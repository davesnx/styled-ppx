type var_type =
  | Selector
  | MediaQuery
  /* Passthrough string interpolation for `--*: $(expr)` declarations in
     [%css] / [%styled.global]. `expr` is required to be a [string] and is
     emitted verbatim in the value position - no `toString` wrap, no
     validation. This is the unsafe escape hatch for custom properties;
     when we later support typed custom properties (e.g. via
     `@property` / a codec registry) a new variant will sit next to this
     one and this one remains the "unknown / unsafe" fallback. */
  | CustomProperty
  | RuntimeModule(string);

/* A `$(expr)` value interpolation hoisted to a CSS custom property. */
type dynamic_var = {
  name: string, /* hashed custom-property name, without `--` */
  path: string, /* the expression's source, e.g. "Theme.color" */
  var_type,
  loc: Ppxlib.Location.t /* file location of the expression inside `$()` */
};

let render_rule = Styled_ppx_css_parser.Render.rule;
let render_prefixed_rule = Css_autoprefixer.render_rule;
let render_declaration = Styled_ppx_css_parser.Render.declaration;

module Buffer = {
  type rule = (string, string);
  /* Rules are deduped by className on insert. [seen] mirrors the
     classNames present in [rules] so membership is amortized O(1)
     instead of an O(n) [List.exists] scan per call, which made rule
     accumulation quadratic in the number of [%css] atoms per file. */
  type target = {
    mutable rules: list(rule),
    seen: Hashtbl.t(string, unit),
  };
  let accumulated_rules: target = {
    rules: [],
    seen: Hashtbl.create(256),
  };
  let global_rules: target = {
    rules: [],
    seen: Hashtbl.create(64),
  };

  let add_to = (target, className, cssText) =>
    if (!Hashtbl.mem(target.seen, className)) {
      Hashtbl.add(target.seen, className, ());
      target.rules = [(className, cssText), ...target.rules];
    };

  let add_rule = add_to(accumulated_rules);
  let add_global_rule = add_to(global_rules);

  let get_rules = () => {
    let dump = target =>
      List.rev_map(((_, cssText)) => cssText, target.rules);
    dump(global_rules) @ dump(accumulated_rules);
  };

  let clear = () => {
    accumulated_rules.rules = [];
    global_rules.rules = [];
    Hashtbl.reset(accumulated_rules.seen);
    Hashtbl.reset(global_rules.seen);
  };
};

module Css_transform = {
  open Styled_ppx_css_parser.Ast;

  /* Maps an interpolation's resolved kind to the stable [type_key] string
     that `Hash_class.variable` mixes into the custom-property hash, so two
     interpolations differing only by target type get distinct variables.
     Kept here rather than in `Hash_class` because `var_type` is a domain
     type that also drives runtime emission (`Css_to_runtime`,
     `Css_global_to_string`); `Hash_class` stays free of that coupling and
     consumes the opaque [type_key] string. */
  let var_type_key = (var_type: var_type) =>
    switch (var_type) {
    | Selector => "selector"
    | MediaQuery => "media-query"
    | CustomProperty => "custom-property"
    | RuntimeModule(name) => "runtime:" ++ name
    };

  /* Increment the count for [name] in an assoc list, returning the new
     count and the updated list. */
  let bump = (name, counts) => {
    let next = 1 + Option.value(List.assoc_opt(name, counts), ~default=0);
    (next, [(name, next), ...List.remove_assoc(name, counts)]);
  };

  let count_named_occurrences = names =>
    List.fold_left((counts, name) => snd(bump(name, counts)), [], names);

  let next_occurrence = (name, occurrences) => {
    let (next, updated) = bump(name, occurrences^);
    occurrences := updated;
    next;
  };

  let take_first_matching_name = (name, items) => {
    let rec loop = (before_rev, remaining) => {
      switch (remaining) {
      | [] => (None, List.rev(before_rev))
      | [(item_name, value) as item, ...tail] =>
        if (item_name == name) {
          (Some(value), List.rev_append(before_rev, tail));
        } else {
          loop([item, ...before_rev], tail);
        }
      };
    };

    loop([], items);
  };

  /* Threaded unchanged through the whole transform walk: resolution
     inputs, the position AST locations are rebased against, and the
     accumulator for hoisted interpolations. */
  type ctx = {
    file: string,
    scope: list(string),
    opens: list(list(string)),
    source_position_start: Lexing.position,
    dynamic_vars: ref(list(dynamic_var)),
  };

  let to_file_loc = (ctx, relative_loc) =>
    Styled_ppx_css_parser.Parser_location.to_file_location(
      ~source_position_start=ctx.source_position_start,
      relative_loc,
    );

  let add_dynamic_var = (ctx, dynamic_var: dynamic_var) =>
    if (!
          List.exists(
            (existing: dynamic_var) => existing.name == dynamic_var.name,
            ctx.dynamic_vars^,
          )) {
      ctx.dynamic_vars := [dynamic_var, ...ctx.dynamic_vars^];
    };

  /* Detect a `$(name)` interpolation anywhere in a component-value list,
     recursing into `Paren_block`, `Bracket_block`, and `Function` bodies.
     The naive top-level check misses interpolations nested inside those
     groupings (e.g. `calc($(a) + 1px)` or `(max-width: $(bp))`). */
  let rec component_value_has_interpolation = (cv: component_value) =>
    switch (cv) {
    | Variable(_, _) => true
    | Paren_block(values)
    | Bracket_block(values) => component_value_list_has_interpolation(values)
    | Function({ body: (values, _), _ }) =>
      component_value_list_has_interpolation(values)
    | _ => false
    }
  and component_value_list_has_interpolation = values =>
    List.exists(
      ((cv, _loc)) => component_value_has_interpolation(cv),
      values,
    );

  /* A declaration hoists a custom property iff its *value* carries a
     `$(…)` interpolation. Selector-position interpolations (`.$(name)`)
     are resolved statically and never hoisted, so they are irrelevant
     here — we only inspect the declaration value. */
  let declaration_has_value_interpolation = (decl: declaration) =>
    component_value_list_has_interpolation(fst(decl.value));

  /* Every `$(name)` source path a value interpolates, recursing the same
     shape `component_value_has_interpolation` does (into `Paren_block`,
     `Bracket_block`, `Function` bodies) - collecting the path string
     instead of stopping at a bool. Used to decide which of a block's
     interpolating declarations must SHARE a bundle (see
     `transform_rule_list`'s bundle grouping below): two declarations that
     interpolate the same path need one variable between them; two that
     interpolate different, unrelated paths do not. */
  let rec component_value_interpolation_paths = (cv: component_value) =>
    switch (cv) {
    | Variable(path, _) => [path]
    | Paren_block(values)
    | Bracket_block(values) =>
      component_value_list_interpolation_paths(values)
    | Function({ body: (values, _), _ }) =>
      component_value_list_interpolation_paths(values)
    | _ => []
    }
  and component_value_list_interpolation_paths = values =>
    List.concat_map(
      ((cv, _loc)) => component_value_interpolation_paths(cv),
      values,
    );

  let declaration_interpolation_paths = (decl: declaration) =>
    component_value_list_interpolation_paths(fst(decl.value));

  /* The single declaration an atom carries: bare (top-level), nested under a
     selector (`Style_rule`), or under an at-rule. None for an atom with no
     declaration body (e.g. an empty at-rule), OR for a multi-declaration
     group (same-property or same-family, see `group_declarations_by_family`)
     - such a group's bundling eligibility (`atom_has_value_interpolation`
     below) is therefore always [false], never re-examined per member. This
     is harmless, not a gap: a multi-declaration group already puts every
     member in ONE atom with its own inline `var(--...)` per interpolating
     declaration (unaffected by grouping - substitution happens per
     declaration, before grouping), so the sharing bundling exists for
     (one variable, not one per occurrence) is already achieved by the
     grouping itself; bundling's remaining, distinct job is sharing a value
     ACROSS separately-grouped atoms (base vs `:hover` vs `@media`), which a
     single already-merged group has no need for. */
  let rec atom_declaration = (rule: rule): option(declaration) =>
    switch (rule) {
    | Declaration(decl) => Some(decl)
    | Style_rule({ block: (rules, _), _ }) =>
      switch (rules) {
      | [inner] => atom_declaration(inner)
      | _ => None
      }
    | At_rule({ block, _ }) =>
      switch (block) {
      | Rule_list((rules, _))
      | Stylesheet((rules, _)) =>
        switch (rules) {
        | [inner] => atom_declaration(inner)
        | _ => None
        }
      | Empty => None
      }
    };

  /* True when the atom's declaration interpolates a runtime value. Such atoms
     are bundled (one shared class + var namespace) rather than atomized, so the
     same value across base/`:hover`/`@media` collapses to one custom property. */
  let atom_has_value_interpolation = (rule: rule): bool =>
    switch (atom_declaration(rule)) {
    | Some(decl) => declaration_has_value_interpolation(decl)
    | None => false
    };

  /* @property{inherits:false} support for `&`-local interpolation vars. A
     non-inheriting custom property does not reach descendants, so changing it
     invalidates only the element, not its subtree. Safe only when the var is
     read on `&`'s own box, never through inheritance — which excludes both
     descendant elements (`& .child`) AND pseudo-elements (`&::before`,
     `&::placeholder`): a pseudo-element is a separate box that receives the
     originating element's custom properties via inheritance, so an
     inherits:false var set inline on `&` is invisible to it.

     [selector_subject_is_ampersand]: the subject (rightmost compound) of [sel]
     is `&`'s own box, so the rule matches the styled element itself. `&:hover`,
     `&.foo`, `.ancestor &` qualify; `& .child`, `& > .x`, `&::before`,
     `&:after` do not. */
  let selector_subject_is_ampersand = (sel: selector): bool =>
    switch (
      List.rev(
        Styled_ppx_css_parser.Selector_nesting.flatten_selector_chain(sel),
      )
    ) {
    | [] => false
    | [(_combinator, subject), ..._] =>
      Styled_ppx_css_parser.Selector_nesting.selector_is_ampersand_own_box(
        subject,
      )
    };

  /* True when every declaration in an atom is read on `&` itself, so its
     interpolation vars need not inherit. A bare declaration is on `&`; a nested
     rule iff its subject is `&`; an at-rule defers to its inner rule. Unknown
     shapes default to false (keep inherits:true). */
  let rec atom_is_ampersand_local = (rule: rule): bool =>
    switch (rule) {
    | Declaration(_) => true
    | Style_rule({ prelude: (selectors, _), _ }) =>
      List.for_all(
        ((sel, _loc)) => selector_subject_is_ampersand(sel),
        selectors,
      )
    | At_rule({ block, _ }) =>
      switch (block) {
      | Rule_list((rules, _))
      | Stylesheet((rules, _)) =>
        List.for_all(atom_is_ampersand_local, rules)
      | Empty => true
      }
    };

  let is_var_name_char = c =>
    c >= 'a'
    && c <= 'z'
    || c >= 'A'
    && c <= 'Z'
    || c >= '0'
    && c <= '9'
    || c == '_'
    || c == '-';

  /* The `--<name>` tokens in rendered CSS, without the leading `--`. Finds which
     dynamic vars an atom reads even when cross-atom dedup hides a reference, so
     a var read by any descendant atom can be excluded from inherits:false. */
  let custom_property_names_in_text = (text: string): list(string) => {
    let n = String.length(text);
    let names = ref([]);
    let i = ref(0);
    while (i^ < n - 1) {
      if (text.[i^] == '-' && text.[i^ + 1] == '-') {
        let start = i^ + 2;
        let j = ref(start);
        while (j^ < n && is_var_name_char(text.[j^])) {
          incr(j);
        };
        if (j^ > start) {
          names := [String.sub(text, start, j^ - start), ...names^];
        };
        i := j^;
      } else {
        incr(i);
      };
    };
    names^;
  };

  /* A var may register @property{inherits:false} only if it is a declaration
     value (a `RuntimeModule` serializer or a `--custom: $(...)` feeder), not an
     animation-name or a selector/media-prelude var. */
  let var_type_supports_inherits_false = (var_type: var_type): bool =>
    switch (var_type) {
    | RuntimeModule("AnimationName") => false
    | RuntimeModule(_)
    | CustomProperty => true
    | Selector
    | MediaQuery => false
    };

  let rec transform_component_value =
          (
            ctx,
            cv: component_value,
            get_var_binding: string => (string, var_type),
          )
          : component_value => {
    let recurse = ((v, loc)) => (
      transform_component_value(ctx, v, get_var_binding),
      loc,
    );
    switch (cv) {
    | Variable(path_str, var_loc) =>
      let (var_name, var_type) = get_var_binding(path_str);
      add_dynamic_var(
        ctx,
        {
          name: var_name,
          path: path_str,
          var_type,
          loc: to_file_loc(ctx, var_loc),
        },
      );

      Function({
        name: ("var", Ppxlib.Location.none),
        kind: Function_kind_regular,
        body: (
          [(Ident("--" ++ var_name), Ppxlib.Location.none)],
          Ppxlib.Location.none,
        ),
      });
    | Function(
        { name: (fn_name, _), body: (body_values, body_loc), _ } as fn,
      )
        when fn_name == "url" =>
      /* CSS `url()` does not perform `var()` substitution: browsers consume
         the body as a literal token, so `url(var(--x))` resolves to the
         string "var(--x)" not the value the custom property holds. Allowing
         the recursive rewrite below would silently emit broken CSS (see
         documents/css-extraction.md). When the body contains an
         interpolation, reject with a clear error pointing the user at
         literal-string alternatives the static extractor can serialize
         correctly; otherwise fall through to the generic Function rewrite. */
      let interp_loc =
        List.find_map(
          ((inner: component_value, loc)) =>
            switch (inner) {
            | Variable(_, _) => Some(loc)
            | _ => None
            },
          body_values,
        );
      switch (interp_loc) {
      | Some(loc) =>
        Ppxlib.Location.raise_errorf(
          ~loc=to_file_loc(ctx, loc),
          "Interpolation inside `url(...)` is not supported: browsers don't substitute `var()` there.\n- Inline the URL: `url(\"/path/to/asset\")`.\n- Or interpolate the whole value: `src: $(font_src)`.",
        )
      | None =>
        Function({
          ...fn,
          body: (List.map(recurse, body_values), body_loc),
        })
      };
    | Function({ name, kind, body: (body_values, body_loc) }) =>
      Function({
        name,
        kind,
        body: (List.map(recurse, body_values), body_loc),
      })
    | Paren_block(values) => Paren_block(List.map(recurse, values))
    | Bracket_block(values) => Bracket_block(List.map(recurse, values))
    | Selector(selector_list) =>
      let recurse_sel = ((sel, loc)) => (
        transform_selector(ctx, sel),
        loc,
      );
      Selector(List.map(recurse_sel, selector_list));
    | _ => cv
    };
  }

  and transform_selector = (ctx, sel: selector) => {
    switch (sel) {
    | SimpleSelector(simple) =>
      transform_simple_selector_to_selector(ctx, simple)
    | ComplexSelector(complex) =>
      ComplexSelector(transform_complex_selector(ctx, complex))
    | CompoundSelector(compound) =>
      CompoundSelector(transform_compound_selector(ctx, compound))
    | RelativeSelector(relative) =>
      RelativeSelector({
        ...relative,
        complex_selector:
          transform_complex_selector(ctx, relative.complex_selector),
      })
    };
  }

  and transform_complex_selector = (ctx, complex: complex_selector) => {
    switch (complex) {
    | Selector(sel) => Selector(transform_selector(ctx, sel))
    | Combinator({ left, right }) =>
      Combinator({
        left: transform_selector(ctx, left),
        right:
          List.map(
            ((combinator, sel)) =>
              (combinator, transform_selector(ctx, sel)),
            right,
          ),
      })
    };
  }

  and transform_compound_selector = (ctx, compound: compound_selector) => {
    let transformed_type_selector =
      Option.map(
        simple => transform_simple_selector(ctx, simple),
        compound.type_selector,
      );
    let transformed_subclasses =
      compound.subclass_selectors
      |> List.map(subclass => transform_subclass_selector(ctx, subclass));
    let transformed_pseudos =
      compound.pseudo_selectors
      |> List.map(pseudo => transform_pseudo_selector(ctx, pseudo));
    {
      type_selector: transformed_type_selector,
      subclass_selectors: transformed_subclasses,
      pseudo_selectors: transformed_pseudos,
    };
  }

  /* Rewrite a `simple_selector` in compound-internal position (slotted
     into `type_selector`). The selector-wrapping variant below is
     `transform_simple_selector_to_selector`. */
  and transform_simple_selector =
      (ctx, simple: simple_selector): simple_selector => {
    switch (simple) {
    | Variable(path_str, var_loc) =>
      let var_loc = to_file_loc(ctx, var_loc);
      let resolved =
        Local_selector_environment.resolve_selector_class_ref(
          ~file=ctx.file,
          ~scope=ctx.scope,
          ~opens=ctx.opens,
          ~loc=var_loc,
          path_str,
        );
      Subclass(Class(resolved));
    | _ => simple
    };
  }

  /* When a `simple_selector` appears outside a compound (i.e. as a
     `SimpleSelector(...)` whole-selector wrapping it), we still need to
     express the resolution. Same lookup, wraps the result. */
  and transform_simple_selector_to_selector =
      (ctx, simple: simple_selector): selector => {
    switch (simple) {
    | Variable(_, _) =>
      SimpleSelector(transform_simple_selector(ctx, simple))
    | _ => SimpleSelector(simple)
    };
  }

  and transform_subclass_selector =
      (ctx, subclass: subclass_selector): subclass_selector => {
    switch (subclass) {
    | ClassVariable(path_str, var_loc) =>
      let className =
        Local_selector_environment.resolve_selector_class_ref(
          ~file=ctx.file,
          ~scope=ctx.scope,
          ~opens=ctx.opens,
          ~loc=to_file_loc(ctx, var_loc),
          path_str,
        );
      Class(className);
    | Pseudo_class(pseudo) =>
      Pseudo_class(transform_pseudo_selector(ctx, pseudo))
    | _ => subclass
    };
  }

  /* Pseudo-classes like `:not(...)`, `:is(...)`, `:where(...)`,
     `:has(...)`, `:nth-child(of ...)` etc. carry nested selector lists.
     Recurse into the payload so `:not(&.$(foo))` resolves the same way as
     a top-level `&.$(foo)`. */
  and transform_pseudo_selector =
      (ctx, pseudo: pseudo_selector): pseudo_selector => {
    switch (pseudo) {
    | Pseudoelement(_) => pseudo
    | PseudoelementFunction({ name, payload: (selector_list, payload_loc) }) =>
      let transformed =
        List.map(
          ((sel, sel_loc)) => (transform_selector(ctx, sel), sel_loc),
          selector_list,
        );
      PseudoelementFunction({
        name,
        payload: (transformed, payload_loc),
      });
    | Pseudoclass(kind) =>
      Pseudoclass(transform_pseudoclass_kind(ctx, kind))
    };
  }

  and transform_pseudoclass_kind =
      (ctx, kind: pseudoclass_kind): pseudoclass_kind => {
    switch (kind) {
    | PseudoIdent(_) => kind
    | Function({ name, payload: (selector_list, payload_loc) }) =>
      let transformed =
        List.map(
          ((sel, sel_loc)) => (transform_selector(ctx, sel), sel_loc),
          selector_list,
        );
      Function({
        name,
        payload: (transformed, payload_loc),
      });
    | NthFunction({ name, payload: (nth_payload, payload_loc) }) =>
      let transformed_payload =
        switch (nth_payload) {
        | Nth(_) => nth_payload
        | NthSelector({ nth, selectors }) =>
          NthSelector({
            nth,
            selectors:
              List.map(c => transform_complex_selector(ctx, c), selectors),
          })
        };
      NthFunction({
        name,
        payload: (transformed_payload, payload_loc),
      });
    };
  };

  /* Resolve `$(binding)`/`&.$(binding)` selector-class references (via
     `transform_selector`, reused unchanged from above) BEFORE atomization,
     leaving declaration values untouched. This must run ahead of
     `atomize_rules`: an atom's class name and `Slot_key` context both hash
     the rendered rule text (`render_rule`/`render_declaration`,
     `Render.selector` respectively), and that text must already carry the
     REFERENCED BINDING'S identity class, not the literal `$(row)` marker -
     otherwise two files with the same local binding name and the same
     nested selector (e.g. `& > div:not(:last-child).$(row)`) render
     identical unresolved text and mint the SAME atom class even though
     `row` resolves to a different `id-` class in each file, which
     `styled-ppx.generate`'s atom-class-collision check then rightly rejects
     (same class, different final CSS).

     Declaration values are NOT resolved here - deferred to `lower_atom`
     (`transform_rule`'s full walk), since a value interpolation's own
     variable name depends on the atom's own class/namespace, which is only
     known once atomize_rules and `Hash_class.class_and_namespace` have run;
     resolving selector-class refs first creates no such cycle, because
     `resolve_selector_class_ref` only needs the REFERENCED binding's
     already-registered identity class, never this atom's own.

     Idempotent: a selector already resolved to `Class(...)`/
     `Subclass(Class(...))` falls through `transform_selector`'s
     catch-all, so running it again in `lower_atom` later is a no-op. */
  let rec resolve_rule_selectors = (ctx, rule: rule): rule =>
    switch (rule) {
    | Declaration(_) => rule
    | Style_rule({ prelude: (selectors, selector_loc), block, loc }) =>
      let (rule_list, rule_loc) = block;
      Style_rule({
        prelude: (
          List.map(
            ((sel, sel_loc)) => (transform_selector(ctx, sel), sel_loc),
            selectors,
          ),
          selector_loc,
        ),
        block: (List.map(resolve_rule_selectors(ctx), rule_list), rule_loc),
        loc,
      });
    | At_rule({ name, prelude, block, loc }) =>
      let map_payload = ((rules, rule_loc)) => (
        List.map(resolve_rule_selectors(ctx), rules),
        rule_loc,
      );
      At_rule({
        name,
        prelude,
        block:
          switch (block) {
          | Empty => Empty
          | Rule_list(payload) => Rule_list(map_payload(payload))
          | Stylesheet(payload) => Stylesheet(map_payload(payload))
          },
        loc,
      });
    };

  let transform_declaration = (ctx, ~var_namespace, decl: declaration) => {
    let (property_name, _) = decl.name;
    let (value_list, value_loc) = decl.value;

    let interpolation_types =
      Css_grammar.infer_interpolation_types(~name=property_name, value_list);

    let interpolation_occurrences =
      interpolation_types
      |> List.map(((name, _)) => name)
      |> count_named_occurrences;
    let seen_interpolations = ref([]);
    let remaining_interpolation_types = ref(interpolation_types);

    let get_var_binding = var_name => {
      let occurrence_index = next_occurrence(var_name, seen_interpolations);
      let total_occurrences =
        switch (List.assoc_opt(var_name, interpolation_occurrences)) {
        | Some(count) => count
        | None => 1
        };
      let (type_path, remaining_types) =
        switch (
          take_first_matching_name(var_name, remaining_interpolation_types^)
        ) {
        | (Some(type_path), remaining_types) => (type_path, remaining_types)
        | (None, remaining_types) => ("", remaining_types)
        };
      remaining_interpolation_types := remaining_types;

      let is_custom_property =
        String.length(property_name) >= 2
        && String.sub(property_name, 0, 2) == "--";

      let var_type =
        if (is_custom_property) {
          CustomProperty;
        } else {
          RuntimeModule(
            Property_to_types.resolve_module_name(~type_path, ~property_name),
          );
        };
      let css_var_name =
        Hash_class.variable_for_occurrence(
          ~namespace=var_namespace,
          ~type_key=var_type_key(var_type),
          ~occurrence=occurrence_index,
          ~total=total_occurrences,
          var_name,
        );

      (css_var_name, var_type);
    };

    let transformed_values =
      List.map(
        ((cv, loc)) =>
          (transform_component_value(ctx, cv, get_var_binding), loc),
        value_list,
      );
    {
      ...decl,
      value: (transformed_values, value_loc),
    };
  };

  let rec transform_rule = (ctx, ~var_namespace, rule: rule) => {
    switch (rule) {
    | Declaration(decl) =>
      Declaration(transform_declaration(ctx, ~var_namespace, decl))
    | Style_rule(style_rule) =>
      Style_rule(transform_style_rule(ctx, ~var_namespace, style_rule))
    | At_rule(at_rule) =>
      At_rule(transform_at_rule(ctx, ~var_namespace, at_rule))
    };
  }

  and transform_style_rule = (ctx, ~var_namespace, style_rule: style_rule) => {
    let { prelude, block, loc } = style_rule;
    let (selector_list, selector_loc) = prelude;
    let transformed_selectors =
      List.map(
        ((sel, sel_loc)) => (transform_selector(ctx, sel), sel_loc),
        selector_list,
      );
    let (rule_list, rule_loc) = block;
    let transformed_rules =
      List.map(rule => transform_rule(ctx, ~var_namespace, rule), rule_list);
    {
      prelude: (transformed_selectors, selector_loc),
      block: (transformed_rules, rule_loc),
      loc,
    };
  }

  and transform_at_rule = (ctx, ~var_namespace, at_rule: at_rule) => {
    let { name, prelude, block, loc } = at_rule;
    let (prelude_values, prelude_loc) = prelude;

    /* Detect any `$(name)` interpolation anywhere in the at-rule prelude
       (recursing into nested groupings — see `component_value_has_interpolation`)
       — e.g. the canonical `@media (max-width: $(bp))` form, where `$(bp)`
       lives inside a `Paren_block` of the `(max-width: $(bp))` group.

        Static extraction can't bind `var(--x)` into a media query (CSS
        custom properties are not valid in media-query conditions), so we
        reject the whole shape with a hard error. */
    let has_interpolation =
      component_value_list_has_interpolation(prelude_values);

    if (has_interpolation) {
      let (at_name, _) = name;
      Ppxlib.Location.raise_errorf(
        ~loc=to_file_loc(ctx, loc),
        "Interpolation in @%s preludes is not supported during static extraction. CSS custom properties (var()) are not valid in media query conditions. Inline the value directly.",
        at_name,
      );
    };

    let map_payload = ((rules, rule_loc)) => (
      List.map(r => transform_rule(ctx, ~var_namespace, r), rules),
      rule_loc,
    );
    let transformed_block =
      switch (block) {
      | Empty => Empty
      | Rule_list(payload) => Rule_list(map_payload(payload))
      | Stylesheet(payload) => Stylesheet(map_payload(payload))
      };
    {
      name,
      prelude: (prelude_values, prelude_loc),
      block: transformed_block,
      loc,
    };
  };

  /* Detect whether `selector` starts with a pseudo-only compound and
     contains no `&` anywhere. Such selectors are spec-correct (per
     CSS Nesting Level 1 §3.1 they descendant-join with the parent),
     but the descendant interpretation almost never matches author
     intent at the top of an atomization context: `.X :hover` matches
     descendants of `.X` when hovered, not `.X` itself when hovered.

     Walks past `ComplexSelector(Selector(_))` wrappers and the `left`
     of `Combinator`s to find the leading compound. Returns `true`
     iff the leading compound has `type_selector = None`, every
     subclass selector is a `Pseudo_class`, and the compound has at
     least one pseudo (subclass or pseudo-element). Mixed compounds
     like `:hover.foo` (which contain a `Class`) are not flagged
     because the author has clearly written a more specific selector.

     `&:hover`, `&[disabled]`, `& :hover`, etc. all contain `&` and
     so are accepted unchanged via the `replace_ampersand` path. */
  let rec leading_compound = sel =>
    switch (sel) {
    | CompoundSelector(c) => Some(c)
    | ComplexSelector(Selector(inner)) => leading_compound(inner)
    | ComplexSelector(Combinator({ left, _ })) => leading_compound(left)
    | _ => None
    };

  let is_bare_leading_pseudo = (sel: selector): bool =>
    if (Styled_ppx_css_parser.Selector_nesting.contains_ampersand(sel)) {
      false;
    } else {
      switch (leading_compound(sel)) {
      | Some({ type_selector: None, subclass_selectors, pseudo_selectors }) =>
        let all_pseudo_class =
          List.for_all(
            fun
            | Pseudo_class(_) => true
            | _ => false,
            subclass_selectors,
          );
        let has_some_pseudo =
          subclass_selectors != [] || pseudo_selectors != [];
        all_pseudo_class && has_some_pseudo;
      | _ => false
      };
    };

  let raise_bare_leading_pseudo_error = (~loc, ~source_position_start, sel) => {
    let rendered = Styled_ppx_css_parser.Render.selector(sel);
    Ppxlib.Location.raise_errorf(
      ~loc=
        Styled_ppx_css_parser.Parser_location.to_file_location(
          ~source_position_start,
          loc,
        ),
      "Bare leading pseudo selector `%s` is ambiguous in nested CSS. Per CSS Nesting Level 1 §3.1 it descendant-joins with the enclosing selector (producing `<parent> %s`), which matches descendants rather than the element itself. Write `&%s` for compound (`<parent>%s`, the usual intent), or `& %s` to opt into the explicit descendant form.",
      rendered,
      rendered,
      rendered,
      rendered,
      rendered,
    );
  };

  /* Mirrors the `@media`-prelude rejection: a value interpolation under a
     subtree-escaping selector cannot be reached by the `var(--…)`
     indirection, so reject it instead of emitting silently-broken CSS. */
  let raise_subtree_escaping_interpolation_error =
      (~loc, ~source_position_start, ~property, sel) => {
    let rendered = Styled_ppx_css_parser.Render.selector(sel);
    Ppxlib.Location.raise_errorf(
      ~loc=
        Styled_ppx_css_parser.Parser_location.to_file_location(
          ~source_position_start,
          loc,
        ),
      "Cannot interpolate into the value of `%s` under `%s`: the selector targets an element outside `&`'s subtree (via a sibling combinator `+`/`~`, or a pseudo-class like `:not(&)`/`:has(&)` whose subject isn't `&` or a descendant of it). Static extraction passes interpolations as a custom property set inline on `&`, which only `&` and its descendants inherit, so an element outside that subtree can't read it and the declaration would be dropped. Instead, target `&` or a descendant, or write a literal value or a globally-inherited theme `var(--...)` directly.",
      property,
      rendered,
    );
  };

  /* Declarations of a block group into one atom when their COVERED LEAF
     PROPERTIES overlap, taken transitively - not merely because they share
     a family. Sharing a family is necessary but not sufficient:
     `padding-left`/`padding-right` are both in the "padding" family but
     cover disjoint leaves (no shared longhand), so they stay separate
     atoms - grouping them would make a future `CSS.merge` too coarse (it
     could no longer drop just one side's atom without also dropping the
     other's). `margin: 10px; margin-top: 0;` DO overlap (margin's full
     leaf set includes margin-top), so they group into one atom, and a
     same-property repeat overlaps itself trivially (fallback pairs like
     `display: -webkit-box; display: flex` stay together, as before).
     "Transitively": a bridging declaration pulls everything it overlaps
     into one group even when those things don't overlap each other
     directly - `border: 1px solid; border-left-width: 2px;` group
     together (border's full leaf set includes border-left-width), but
     `border-top: 1px solid; border-left-width: 2px;` do NOT (border-top's
     three leaves are all on the top side, none of them is
     border-left-width). Groups anchor at the LAST occurrence (a group
     cascades like its last member; first-anchoring would hoist earlier
     members past intervening rules). Singleton, single-declaration groups
     keep the historical atom shape and hash. */
  type block_item =
    | Declaration_group(list(declaration))
    | Nested_rule(rule);

  /* A declaration's covered leaf (non-shorthand) properties (see
     `Slot_key.leaves_of`) - `[property]` itself when it names no
     shorthand. `Slot_key.normalize_property` lowercases everything except
     a custom property (`--*`, case-sensitive); a custom property is never
     a shorthand member, so `leaves_of` returns it unchanged and two
     differently-cased custom properties correctly never overlap. */
  let declaration_leaves = ({ name: (name, _), _ }: declaration) =>
    Slot_key.leaves_of(Slot_key.normalize_property(name));

  let leaf_sets_overlap = (a: list(string), b: list(string)) =>
    List.exists(leaf => List.mem(leaf, b), a);

  let group_declarations_by_family = (rules: list(rule)): list(block_item) => {
    /* Every `Declaration` in this block, in order, paired with its leaf
       set (computed once per declaration, not once per pair compared
       below) and its position in `rules` (for last-occurrence anchoring). */
    let decls =
      rules
      |> List.mapi((index, rule) => (index, rule))
      |> List.filter_map(((index, rule)) =>
           switch (rule) {
           | Declaration(decl) =>
             Some((index, decl, declaration_leaves(decl)))
           | _ => None
           }
         )
      |> Array.of_list;
    let n = Array.length(decls);

    /* Union-find over positions [0, n) in `decls` - path-compressed, no
       union-by-rank (n is a block's declaration count, always small).
       Connects i and j when their leaf sets overlap, so the relation is
       transitive by construction: if i-j and j-k are each unioned, find(i)
       = find(j) = find(k) regardless of whether i and k overlap directly. */
    let parent = Array.init(n, i => i);
    let rec find = i =>
      if (parent[i] == i) {
        i;
      } else {
        let root = find(parent[i]);
        parent[i] = root;
        root;
      };
    let union = (i, j) => {
      let (ri, rj) = (find(i), find(j));
      if (ri != rj) {
        parent[max(ri, rj)] = min(ri, rj);
      };
    };
    for (i in 0 to n - 1) {
      for (j in i + 1 to n - 1) {
        let (_, _, leaves_i) = decls[i];
        let (_, _, leaves_j) = decls[j];
        if (leaf_sets_overlap(leaves_i, leaves_j)) {
          union(i, j);
        };
      };
    };

    /* Collect each group's members (in author order) and the block-level
       index of its LAST member, keyed by union-find root. */
    let members_by_root: Hashtbl.t(int, ref(list(declaration))) =
      Hashtbl.create(8);
    let last_index_by_root: Hashtbl.t(int, int) = Hashtbl.create(8);
    let root_by_block_index: Hashtbl.t(int, int) = Hashtbl.create(8);
    Array.iteri(
      (i, (block_index, decl, _leaves)) => {
        let root = find(i);
        Hashtbl.replace(root_by_block_index, block_index, root);
        switch (Hashtbl.find_opt(members_by_root, root)) {
        | Some(group) => group := [decl, ...group^]
        | None => Hashtbl.add(members_by_root, root, ref([decl]))
        };
        Hashtbl.replace(last_index_by_root, root, block_index);
      },
      decls,
    );

    /* Emit each group at its last member's position, same anchoring rule
       as before, now keyed by union-find root instead of a literal key. */
    List.mapi(
      (index, rule) =>
        switch (rule) {
        | Declaration(_) =>
          let root = Hashtbl.find(root_by_block_index, index);
          if (Hashtbl.find(last_index_by_root, root) == index) {
            let group = Hashtbl.find(members_by_root, root);
            [Declaration_group(List.rev(group^))];
          } else {
            [];
          };
        | rule => [Nested_rule(rule)]
        },
      rules,
    )
    |> List.concat;
  };

  /* Media condition ordering (StyleX's `lastMediaQueryWinsTransform`).
     Within one block, when 2+ sibling `@media` at-rules set the same
     property family under the same selector target, plain CSS gives the
     tie at equal specificity to stylesheet POSITION, not source order -
     and `generate` dedupes byte-identical rules by first sighting, so two
     blocks writing the same two conditions in opposite order silently
     collapse onto whichever block the aggregator saw first (see
     `media-order-dedup-flip.t`). Rewriting each earlier condition to
     exclude every later one makes the group pairwise disjoint, so at most
     one ever applies and "last written wins" holds regardless of
     stylesheet position or which other block already emitted the same
     rule. Runs here, before `atomize_rules` hashes each atom's rendered
     text, so the REWRITTEN condition is what ends up in the class name.

     Scope, matching StyleX exactly: `@media` only - `@supports`/
     `@container` are left alone by construction (`media_atom_slot` only
     classifies `At_rule` nodes named "media"). A prelude this can't
     confidently classify (further nesting, a block mixing more than one
     property family, an interpolated condition - rejected later anyway,
     see `media-query-interpolation-error.t`) is left untouched rather
     than guessed at: this pass is an ordering optimization, not a
     validity check. */

  /* One `@media` at-rule's (selector, family, important) - the same
     grouping question `CSS.merge` (`Slot_key.removes`) already asks of
     two atoms ("do these compete for the same spot"), minus the at-rule
     chain itself (exactly the part a group's members are allowed to
     differ on - that's the thing being rewritten). `None` when the
     at-rule's own content doesn't reduce to one clean (target, family)
     unit, e.g. two unrelated properties or a nested at-rule - see the
     scope note above. */
  let media_atom_slot = (at_rule: at_rule): option(Slot_key.t) => {
    let inner_rules =
      switch (at_rule.block) {
      | Rule_list((rules, _))
      | Stylesheet((rules, _)) => rules
      | Empty => []
      };
    switch (group_declarations_by_family(inner_rules)) {
    | [Declaration_group(decls)] =>
      let synthetic =
        switch (decls) {
        | [d] => Declaration(d)
        | decls =>
          Style_rule({
            prelude: (
              [(SimpleSelector(Ampersand), Ppxlib.Location.none)],
              Ppxlib.Location.none,
            ),
            block: (
              List.map(d => Declaration(d), decls),
              Ppxlib.Location.none,
            ),
            loc: Ppxlib.Location.none,
          })
        };
      Slot_key.of_atom(synthetic);
    | [Nested_rule(Style_rule(_) as sr)] => Slot_key.of_atom(sr)
    | _ => None /* mixed families or further nesting: left alone, see above */
    };
  };

  /* Same trim `Selector_nesting` already uses for a media prelude
     (`join_media`). */
  let drop_leading_whitespace = Styled_ppx_css_parser.Selector_nesting.trim_left;
  let trim_whitespace = tokens =>
    tokens
    |> Styled_ppx_css_parser.Selector_nesting.trim_left
    |> Styled_ppx_css_parser.Selector_nesting.trim_right;

  /* `tokens` split on top-level commas (an MQ4 query list is CSS's `or`).
     A comma nested inside a `Paren_block`/`Function` is already part of
     that token's own sub-list, never visible here - the parser has
     already done the depth tracking, so this needs none of its own. */
  let split_top_level_commas =
      (tokens: component_value_list): list(component_value_list) => {
    let (branches, current) =
      List.fold_left(
        ((branches, current), (cv, _loc) as tok) =>
          switch (cv) {
          | Delim(Delimiter_comma) => (
              [List.rev(current), ...branches],
              [],
            )
          | _ => (branches, [tok, ...current])
          },
        ([], []),
        tokens,
      );
    List.rev([List.rev(current), ...branches]) |> List.map(trim_whitespace);
  };

  /* True when one OR-branch (one comma-separated alternative) carries a
     leading media-type keyword (`screen`, `print`, `all`, ...), optionally
     itself prefixed by `not`/`only` - the `<media-query>`
     `['not'|'only']? <media-type> ['and' ...]?` production, as opposed to a
     bare `<media-condition>` (an and/or-chain of parenthesized features,
     optionally `not`-prefixed). A media type can never be wrapped in
     parentheses (`<media-in-parens>` only ever contains a
     `<media-condition>`, and a media type is not one), so a query built
     this way cannot be turned into a `(not (...))` AND-term at all -
     negating it correctly would need the OUTER, per-query `not`/`only`
     toggle instead, a different mechanism this pass does not implement.
     Conservative default (anything that isn't clearly a parenthesized
     condition counts as "has a media type") so an unrecognized shape is
     excluded rather than mishandled - see `rewrite_media_prelude_siblings`,
     which drops any candidate with a `true` branch here entirely, matching
     `media-type-query-unchanged.t`. */
  let branch_has_media_type = (branch: component_value_list): bool => {
    let skip_leading_not_or_only = tokens =>
      switch (tokens) {
      | [(Ident(name), _), ...rest]
          when
            String.lowercase_ascii(name) == "not"
            || String.lowercase_ascii(name) == "only" =>
        drop_leading_whitespace(rest)
      | tokens => tokens
      };
    switch (skip_leading_not_or_only(drop_leading_whitespace(branch))) {
    | [(Paren_block(_), _), ..._] => false
    | [] => false
    | _ => true
    };
  };

  /* `<mf-name>`s whose range test every supported browser resolves to a
     plain, definite true/false - never CSS's third ("unknown") truth
     value - for a literal `px`/`em`/`rem` length. */
  let is_safe_range_feature_name = name =>
    switch (String.lowercase_ascii(name)) {
    | "min-width"
    | "max-width"
    | "min-height"
    | "max-height" => true
    | _ => false
    };

  let is_safe_length_unit = unit =>
    switch (String.lowercase_ascii(unit)) {
    | "px"
    | "em"
    | "rem" => true
    | _ => false
    };

  /* Contents of ONE `Paren_block` - true only for the two shapes every
     supported browser resolves to a definite true/false: `<safe-name>:
     <literal px/em/rem length>`, or `orientation: landscape|portrait`.
     Anything else (`calc()`, a percentage, a range comparison, a boolean
     feature) is NOT safe to negate - see `query_is_negation_safe`. */
  let paren_contents_is_safe_feature = (contents: component_value_list): bool =>
    switch (List.filter(((cv, _)) => cv != Whitespace, contents)) {
    | [
        (Ident(name), _),
        (Delim(Delimiter_colon), _),
        (Dimension({ unit, _ }), _),
      ] =>
      is_safe_range_feature_name(name) && is_safe_length_unit(unit)
    | [(Ident(name), _), (Delim(Delimiter_colon), _), (Ident(value), _)]
        when String.lowercase_ascii(name) == "orientation" =>
      switch (String.lowercase_ascii(value)) {
      | "landscape"
      | "portrait" => true
      | _ => false
      }
    | _ => false
    };

  /* True when every feature test in this query (one full `@media`
     prelude, already known to carry no media type) is one of the two
     safe shapes above, so the query only ever resolves to a definite
     true/false - never "unknown". Matters for a query used as a
     NEGATION SOURCE (the `<later>` in `and (not (<later>))`):
     three-valued media-feature logic means `not unknown` is itself
     `unknown`, and `true and unknown` is `unknown`, not `false` - so
     negating an "unknown"-capable later query can turn an EARLIER rule
     that used to apply unconditionally into one that never applies
     again. `min-width: calc(1000px - 2%)` mixes an absolute length with
     a percentage, not a valid `<length>` in a media feature; the
     browser resolves it, and its negation, to permanently `false` -
     not `true`, the way negating an ordinary `false` would - see
     `media-calc-feature-unchanged.t`, which shows the computed-style
     loss this would otherwise cause.

     Checked per OR-branch (an unsafe feature anywhere in any branch
     makes the whole query unsafe - De Morgan negates every branch), after
     stripping an optional leading condition-level `not` (already known
     absent a media type, so every remaining top-level token is a
     `Paren_block`, the `and` keyword, or whitespace). Shared with the
     same-type-prefix path below (`split_type_prefix_and_chain`), whose
     own chain (after the shared type prefix + its own leading `and`) has
     exactly this same shape and the exact same "unknown" risk. */
  let chain_is_negation_safe = (tokens: component_value_list): bool =>
    tokens
    |> List.for_all(((cv, _)) =>
         switch (cv) {
         | Paren_block(inner) => paren_contents_is_safe_feature(inner)
         | Ident(kw) when String.lowercase_ascii(kw) == "and" => true
         | Whitespace => true
         | _ => false
         }
       );

  let query_is_negation_safe = (prelude: component_value_list): bool =>
    split_top_level_commas(prelude)
    |> List.for_all(branch => {
         let checked =
           switch (branch) {
           | [(Ident(name), _), ...rest]
               when String.lowercase_ascii(name) == "not" => rest
           | branch => branch
           };
         chain_is_negation_safe(checked);
       });

  /* The four media types Media Queries 4 still defines (`tty`/`tv`/
     `projection`/`handheld`/`braille`/`embossed`/`aural` were removed
     from the spec) - unlike a feature's VALUE, a media type test is
     never partially-supported or invalid, so recognizing one carries
     none of `query_is_negation_safe`'s "unknown" risk; the reason it is
     handled separately at all is purely syntactic (`branch_has_media_type`'s
     doc: a type can never be wrapped in parentheses). */
  let is_recognized_media_type = name =>
    switch (String.lowercase_ascii(name)) {
    | "all"
    | "print"
    | "screen"
    | "speech" => true
    | _ => false
    };

  /* Splits one type-bearing, single OR-branch (`branch_has_media_type`
     already true for it) into (a comparison key for its exact type
     prefix, the feature-chain tokens after its own `'and'`) - `None` when
     the leading idents aren't exactly one recognized type (bare, or
     `only`-prefixed), or when there is no `and <chain>` to fold a
     negation into (a bare `@media screen` has no feature condition -
     `branch_has_media_type`'s "no correct form" reasoning again).

     A `not`-prefixed type is explicitly EXCLUDED (`words` containing
     "not" always returns `None`), unlike `only` - `not` negates the
     WHOLE query (type and condition together, per spec), so `not screen
     and (A) and (not (B))` does NOT reduce to "A-but-not-B" the way the
     bare-type case does: De Morgan turns the leading `not` into an OR
     across the whole expression, so the appended `(not (B))` term ends
     up OR'd at the top level instead of scoped inside the original AND,
     so the earlier rule fires in cases where neither original rule
     should apply. `only` has no such problem (a no-op in every browser
     that matters), so `only
     screen and (A) and (not (B))` reduces exactly like the bare-type
     case.

     Two branches with the SAME key (`rewrite_media_prelude_siblings`
     groups on it) share the exact same `only`/type combination, so
     appending `and (not (<other's chain>))` after EITHER's own chain
     stays a single, valid `<media-condition-without-or>` for that shared
     type. */
  let split_type_prefix_and_chain =
      (branch: component_value_list)
      : option((string, component_value_list, component_value_list)) => {
    let rec collect = (words, prefix_toks, tokens) =>
      switch (tokens) {
      | [(Whitespace, _) as tok, ...rest] =>
        collect(words, [tok, ...prefix_toks], rest)
      | [(Ident(kw), _), ...rest] when String.lowercase_ascii(kw) == "and" =>
        Some((words, List.rev(prefix_toks), drop_leading_whitespace(rest)))
      | [(Ident(word), _) as tok, ...rest] =>
        collect(
          [String.lowercase_ascii(word), ...words],
          [tok, ...prefix_toks],
          rest,
        )
      | [] => Some((words, List.rev(prefix_toks), []))
      | _ => None /* a Paren_block (or anything else) before any `and`:
                     not a type prefix at all */
      };
    switch (collect([], [], branch)) {
    | None => None
    | Some((words_rev, prefix_toks, chain)) =>
      let words = List.rev(words_rev);
      let type_words = List.filter(w => w != "only", words);
      switch (type_words, chain) {
      | ([ty], [_, ..._])
          when is_recognized_media_type(ty) && !List.mem("not", words) =>
        Some((
          String.concat(" ", words),
          trim_whitespace(prefix_toks),
          chain,
        ))
      | _ => None
      };
    };
  };

  /* `current`, made safe to extend with further ` and (...)` terms. Every
     MQ4 shape except a bare, unwrapped `not <condition>` already is: a
     single parenthesized feature or an `and`-chain of them is already a
     `<media-and>`/`<media-in-parens>`, which the grammar lets grow with
     more `and <media-in-parens>` terms directly. A bare `<media-not>` is
     not - it has no `and`-continuation of its own - so wrap it in one
     fresh pair of parens first, turning it into a `<media-in-parens>` (a
     valid, if trivial, one-element and-chain) before anything is
     appended. */
  let ensure_and_chainable =
      (branch: component_value_list): component_value_list =>
    switch (branch) {
    | [(Ident(name), _), ..._] when String.lowercase_ascii(name) == "not" => [
        (Paren_block(branch), Ppxlib.Location.none),
      ]
    | branch => branch
    };

  /* The logical negation of one later OR-branch, as a term ready to append
     directly after ` and ` (i.e. already a valid `<media-in-parens>` -
     `branch_has_media_type` guarantees the branch itself is a bare
     `<media-condition>`, never a media type, by the time this runs). Two
     shapes:
     - already `not <rest>`: double negation cancels - `rest` is whatever
       the author originally wrapped the `not` around, already a valid
       `<media-in-parens>` on its own (a `<media-not>`'s operand always is),
       so it is reused verbatim with no extra wrap.
     - anything else (one parenthesized feature, or an `and`-chain of
       several): the negation is `not <that>`, which is a `<media-not>` -
       itself a `<media-condition>`, not yet a `<media-in-parens>` - so the
       WHOLE `not <that>` is wrapped in one fresh pair of parens:
       `(not (min-width: 900px))`, or `(not ((min-width: 768px) and
       (max-width: 1279px)))` when `<that>` is itself a multi-term chain
       needing its own inner wrap first to become one `<media-in-parens>`
       for `not` to apply to. */
  let negate_as_and_term =
      (branch: component_value_list): component_value_list => {
    let loc =
      switch (branch) {
      | [(_, l), ..._] => l
      | [] => Ppxlib.Location.none
      };
    switch (branch) {
    | [(Ident(name), _), ...rest]
        when String.lowercase_ascii(name) == "not" => [
        (Paren_block(trim_whitespace(rest)), loc),
      ]
    | [(Paren_block(_), _) as single] => [
        (
          Paren_block([(Ident("not"), loc), (Whitespace, loc), single]),
          loc,
        ),
      ]
    | _ => [
        (
          Paren_block([
            (Ident("not"), loc),
            (Whitespace, loc),
            (Paren_block(branch), loc),
          ]),
          loc,
        ),
      ]
    };
  };

  let join_with_commas =
      (branches: list(component_value_list)): component_value_list =>
    switch (branches) {
    | [] => []
    | [first, ...rest] =>
      List.fold_left(
        (acc, branch) =>
          acc
          @ [
            (Delim(Delimiter_comma), Ppxlib.Location.none),
            (Whitespace, Ppxlib.Location.none),
          ]
          @ branch,
        first,
        rest,
      )
    };

  let and_join = (a, b) =>
    a
    @ [
      (Whitespace, Ppxlib.Location.none),
      (Ident("and"), Ppxlib.Location.none),
      (Whitespace, Ppxlib.Location.none),
    ]
    @ b;

  /* `current AND (not later1) AND (not later2)...`, De Morgan-distributed
     into every OR-branch of `current` independently (mirrors StyleX's
     `combineMediaQueryWithNegations`, `~/.librarian/github.com/facebook/stylex`),
     each negation wrapped in its own parens (`(not (...))`, never a bare
     `and not (...)` - invalid MQ4, `not` only starts a whole condition).
     `later` are the ORIGINAL (not previously rewritten) preludes of every
     strictly-later group member - a 3+-way group chains against all of
     them, not just its neighbor.

     `~type_prefix`: for a same-type group (`split_type_prefix_and_chain`),
     `current`/`later` are already just the shared-type members' own
     feature chains (no comma, no type) - split/rejoin-by-comma is then a
     no-op, so the same steps produce `<chain> and (not (...))...`, and
     the untouched type prefix is prepended once at the end. */
  let negate_prelude_chain =
      (
        ~type_prefix: option(component_value_list),
        ~current: component_value_list,
        ~later: list(component_value_list),
      )
      : component_value_list => {
    let not_terms =
      later
      |> List.concat_map(prelude =>
           split_top_level_commas(prelude) |> List.map(negate_as_and_term)
         );
    let negated =
      current
      |> split_top_level_commas
      |> List.map(ensure_and_chainable)
      |> List.map(branch => List.fold_left(and_join, branch, not_terms))
      |> join_with_commas;
    switch (type_prefix) {
    | None => negated
    | Some(prefix) => and_join(prefix, negated)
    };
  };

  /* Stable grouping by structural key, first-seen order - `n` is always a
     block's own at-rule count (small), so the linear scan per insert costs
     nothing worth a hashtable for. */
  let group_by_key = (key_of, items) => {
    let groups = ref([]);
    items
    |> List.iter(item => {
         let k = key_of(item);
         switch (
           List.find_opt(((existing_key, _)) => existing_key == k, groups^)
         ) {
         | Some((_, members)) => members := [item, ...members^]
         | None => groups := groups^ @ [(k, ref([item]))]
         };
       });
    groups^ |> List.map(((_, members)) => List.rev(members^));
  };

  /* `Plain`: no media type anywhere in the prelude (every OR-branch) - the
     original, StyleX-equivalent path. `Typed`: a SINGLE branch (no
     top-level comma) that is exactly `['not'|'only']? <type> 'and'
     <chain>` for one recognized type (`screen` is by far the most common
     in practice) - carries the comparison key (so only an EXACT same
     `not`/`only`/type combination groups together, see
     `split_type_prefix_and_chain`'s doc), the original prefix tokens (for
     verbatim reuse) and the chain tokens (the only part ever negated). A
     comma list mixing a typed and an untyped branch, or two different
     types, classifies as neither and is excluded entirely (`None`) -
     mixed or other types stay untouched. */
  type media_kind =
    | Plain
    | Typed(string, component_value_list, component_value_list);

  let classify_media_query =
      (prelude: component_value_list): option(media_kind) =>
    switch (split_top_level_commas(prelude)) {
    | [branch] when !branch_has_media_type(branch) => Some(Plain)
    | [branch] =>
      switch (split_type_prefix_and_chain(branch)) {
      | Some((key, prefix, chain)) => Some(Typed(key, prefix, chain))
      | None => None
      }
    | branches =>
      List.for_all(b => !branch_has_media_type(b), branches)
        ? Some(Plain) : None
    };

  let media_kind_key = kind =>
    switch (kind) {
    | Plain => ""
    | Typed(key, _, _) => "typed:" ++ key
    };

  /* What this member contributes if it is used as a LATER negation
     source: `Plain`'s is its whole (possibly multi-branch) prelude,
     fed to `negate_prelude_chain`'s own per-branch splitting; `Typed`'s
     is just its chain (already known single-branch), fed straight to
     `negate_as_and_term`. Same representation type either way
     (`component_value_list`), so both the safety check and the "what do
     later members contribute" step read uniformly below. */
  let later_representation = (kind, prelude) =>
    switch (kind) {
    | Plain => prelude
    | Typed(_, _, chain) => chain
    };

  let is_safe_as_later = (kind, repr) =>
    switch (kind) {
    | Plain => query_is_negation_safe(repr)
    | Typed(_, _, _) => chain_is_negation_safe(repr)
    };

  /* One rule-list level (siblings): find every classifiable `@media`
     at-rule, group by (target, family, !important, media_kind), and for
     every group of 2+, rewrite every member but the last against every
     strictly-later member's ORIGINAL prelude. Non-candidates (base
     declarations, `@supports`/`@container`, unclassifiable `@media`,
     singleton groups) pass through unchanged. */
  let rewrite_media_prelude_siblings = (rules: list(rule)): list(rule) => {
    let candidates =
      rules
      |> List.mapi((i, r) => (i, r))
      |> List.filter_map(((i, r)) =>
           switch (r) {
           | At_rule({ name: (n, _), prelude, _ } as ar)
               when
                 String.lowercase_ascii(n) == "media"
                 && !component_value_list_has_interpolation(fst(prelude)) =>
             switch (
               media_atom_slot(ar),
               classify_media_query(fst(prelude)),
             ) {
             | (Some(slot), Some(kind)) => Some((i, ar, slot, kind))
             | _ => None
             }
           | _ => None
           }
         );
    let groups =
      group_by_key(
        ((_, _, slot: Slot_key.t, kind)) =>
          (
            slot.context.selector,
            slot.context.important,
            slot.family,
            media_kind_key(kind),
          ),
        candidates,
      );
    let rewritten: Hashtbl.t(int, component_value_list) = Hashtbl.create(8);
    groups
    |> List.iter(members =>
         switch (members) {
         | []
         | [_] => () /* nothing else in this (target, family, kind) to negate against */
         | members =>
           let reprs =
             members
             |> List.map(
                  ((_, ar, _, kind): (int, at_rule, Slot_key.t, media_kind)) =>
                  later_representation(kind, fst(ar.prelude))
                );
           let arr = Array.of_list(reprs);
           let n = Array.length(arr);
           /* Every member from index 1 on is a potential negation SOURCE
              for some earlier member (index 0 is never negated - nothing
              precedes it). If any of them can resolve to "unknown" (see
              `query_is_negation_safe`'s doc), negating ANY member of this
              group can turn an earlier, always-applying rule into one
              that never applies: leave the WHOLE group untouched rather
              than negate against the safe members only and silently
              accept a narrower, harder-to-audit gap. */
           let (_, _, _, group_kind) = List.hd(members);
           let later_side_is_safe =
             Array.to_list(Array.sub(arr, 1, n - 1))
             |> List.for_all(repr => is_safe_as_later(group_kind, repr));
           if (later_side_is_safe) {
             members
             |> List.iteri(
                  (
                    idx,
                    (i, ar, _slot, kind): (
                      int,
                      at_rule,
                      Slot_key.t,
                      media_kind,
                    ),
                  ) =>
                  if (idx < n - 1) {
                    let later =
                      Array.to_list(Array.sub(arr, idx + 1, n - idx - 1));
                    let new_prelude =
                      switch (kind) {
                      | Plain =>
                        negate_prelude_chain(
                          ~type_prefix=None,
                          ~current=fst(ar.prelude),
                          ~later,
                        )
                      | Typed(_, prefix, chain) =>
                        negate_prelude_chain(
                          ~type_prefix=Some(prefix),
                          ~current=chain,
                          ~later,
                        )
                      };
                    Hashtbl.replace(rewritten, i, new_prelude);
                  }
                );
           };
         }
       );
    rules
    |> List.mapi((i, r) =>
         switch (r, Hashtbl.find_opt(rewritten, i)) {
         | (At_rule(ar), Some(new_prelude)) =>
           At_rule({
             ...ar,
             prelude: (new_prelude, snd(ar.prelude)),
           })
         | _ => r
         }
       );
  };

  /* Applies the sibling rewrite at every nesting level independently
     (mirrors StyleX's "a nested object gets its own independent
     sibling-rewrite pass one depth down"): a `@media` block's own inner
     rules, or a nested selector's block, can have their own sibling
     `@media` groups one level deeper. */
  let rec rewrite_media_conditions = (rules: list(rule)): list(rule) =>
    rules
    |> rewrite_media_prelude_siblings
    |> List.map(recurse_media_children)
  and recurse_media_children = (r: rule): rule =>
    switch (r) {
    | Declaration(_) => r
    | Style_rule({ block: (inner, loc), _ } as sr) =>
      Style_rule({
        ...sr,
        block: (rewrite_media_conditions(inner), loc),
      })
    | At_rule({ block: Rule_list((inner, loc)), _ } as ar) =>
      At_rule({
        ...ar,
        block: Rule_list((rewrite_media_conditions(inner), loc)),
      })
    | At_rule({ block: Stylesheet((inner, loc)), _ } as ar) =>
      At_rule({
        ...ar,
        block: Stylesheet((rewrite_media_conditions(inner), loc)),
      })
    | At_rule({ block: Empty, _ }) => r
    };

  let atomize_rules =
      (~source_position_start, rules: list(rule))
      : list((string, string, rule)) => {
    /* Merge a child selector-list prelude under a parent selector-list prelude.
       For each (parent, child) pair, run `compute_new_prefix` so `&`,
       `::pseudo`, and descendant combinators all resolve correctly. The
       Cartesian product matches CSS-nesting semantics:
       `a, b { c, d { ... } }` desugars to `a c, a d, b c, b d`.

       Folded with prepend then reversed once at the end — equivalent
       output to the prior `concat_map`/`map` combination but avoids the
       per-parent intermediate list and the final concat pass. */
    let merge_preludes =
        (
          ~parent: list((selector, Ppxlib.Location.t)),
          ~child: list((selector, Ppxlib.Location.t)),
        ) => {
      List.fold_left(
        (acc, (parent_sel, _parent_loc)) =>
          List.fold_left(
            (acc, (child_sel, child_loc)) => {
              let merged =
                Styled_ppx_css_parser.Selector_nesting.compute_new_prefix(
                  ~prefix=Some(parent_sel),
                  child_sel,
                );
              [(merged, child_loc), ...acc];
            },
            acc,
            child,
          ),
        [],
        parent,
      )
      |> List.rev;
    };

    /* Wrap a same-family `Declaration` group (see
       `group_declarations_by_family`) as one atom. No parent:
       singleton keeps the historical bare `Declaration` atom (hash
       stability); a group becomes `& { ... }` (`&` resolves to the
       className). With a parent: one `Style_rule(parent){group}` atom
       per parent selector. */
    let wrap_declaration_group_under_parent = (~parent_prelude=?, decls) => {
      switch (parent_prelude) {
      | None =>
        switch (decls) {
        | [decl] =>
          let bare_rule = Declaration(decl);
          let decl_string = render_declaration(decl);
          let (className, namespace) =
            Hash_class.class_and_namespace(
              ~namespace=Settings.Get.namespace(),
              ~slot=Slot_key.of_atom(bare_rule),
              decl_string,
            );
          [(className, namespace, bare_rule)];
        | decls =>
          let group_string =
            decls |> List.map(render_declaration) |> String.concat("");
          let style_rule =
            Style_rule({
              prelude: (
                [(SimpleSelector(Ampersand), Ppxlib.Location.none)],
                Ppxlib.Location.none,
              ),
              block: (
                List.map(decl => Declaration(decl), decls),
                Ppxlib.Location.none,
              ),
              loc: Ppxlib.Location.none,
            });
          let (className, namespace) =
            Hash_class.class_and_namespace(
              ~namespace=Settings.Get.namespace(),
              ~slot=Slot_key.of_atom(style_rule),
              group_string,
            );
          [(className, namespace, style_rule)];
        }
      | Some(parent_selectors) =>
        /* Computed once: depends on the declarations, not on which parent
           selector they pair with. */
        let interpolated_property =
          decls
          |> List.find_opt(declaration_has_value_interpolation)
          |> Option.map((decl: declaration) => fst(decl.name));
        List.map(
          ((parent_sel, parent_loc)) => {
            switch (interpolated_property) {
            | Some(property)
                when
                  Styled_ppx_css_parser.Selector_nesting.subject_escapes_ampersand_subtree(
                    parent_sel,
                  ) =>
              raise_subtree_escaping_interpolation_error(
                ~loc=parent_loc,
                ~source_position_start,
                ~property,
                parent_sel,
              )
            | _ => ()
            };
            let style_rule =
              Style_rule({
                prelude: ([(parent_sel, parent_loc)], parent_loc),
                block: (
                  List.map(decl => Declaration(decl), decls),
                  Ppxlib.Location.none,
                ),
                loc: Ppxlib.Location.none,
              });
            let rule_string = render_rule(style_rule);
            let (className, namespace) =
              Hash_class.class_and_namespace(
                ~namespace=Settings.Get.namespace(),
                ~slot=Slot_key.of_atom(style_rule),
                rule_string,
              );
            (className, namespace, style_rule);
          },
          parent_selectors,
        );
      };
    };

    /* Atomize one block's rules: same-family declarations group into a
       single atom (see `group_declarations_by_family`); everything
       else atomizes rule by rule. */
    let rec extract_atomic_rules_from_block =
            (~parent_prelude=?, rules: list(rule))
            : list((string, string, rule)) =>
      rules
      |> group_declarations_by_family
      |> List.concat_map(
           fun
           | Declaration_group(decls) =>
             wrap_declaration_group_under_parent(~parent_prelude?, decls)
           | Nested_rule(rule) =>
             extract_atomic_rules(~parent_prelude?, rule),
         )
    and extract_atomic_rules =
        (~parent_prelude=?, rule: rule): list((string, string, rule)) => {
      switch (rule) {
      | Declaration(decl) =>
        wrap_declaration_group_under_parent(~parent_prelude?, [decl])

      | Style_rule({
          prelude: (child_selectors, _),
          block: (rules, _),
          loc: _,
        }) =>
        /* CSS Nesting Level 1 §3.1 desugars a bare leading pseudo
           selector via descendant combinator, so `:hover { ... }` and
           `::after { ... }` produce `<parent> :hover` / `<parent>
           ::after`. That's almost never what authors want; the typical
           intent is the compound form (`<parent>:hover` / `<parent>::after`).
           Reject these with a precise location and steer authors toward
           `&:hover` (compound) or `& :hover` (explicit descendant).

           The check runs at every nesting level (with or without a
           parent prelude) because the same footgun applies whether the
           parent is the implicit className or another selector. */
        List.iter(
          ((sel, sel_loc)) =>
            if (is_bare_leading_pseudo(sel)) {
              raise_bare_leading_pseudo_error(
                ~loc=sel_loc,
                ~source_position_start,
                sel,
              );
            },
          child_selectors,
        );
        /* Merge any accumulated parent prelude into this Style_rule's
           selector list. At the top level (no parent) this preserves the
           original prelude verbatim, including multi-selector lists. */
        let effective_selectors =
          switch (parent_prelude) {
          | None => child_selectors
          | Some(parent) => merge_preludes(~parent, ~child=child_selectors)
          };
        extract_atomic_rules_from_block(
          ~parent_prelude=effective_selectors,
          rules,
        );

      | At_rule({ name: (name, name_loc), prelude, block, loc }) =>
        /* Only conditional group rules can be atomized (the condition
           distributes over the block). Everything else errors like the
           runtime path — splitting @font-face/@keyframes/@property or
           @layer produces broken CSS. Accepted set is a deliberate
           superset of the runtime's (@supports/@starting-style are
           extraction-only). */
        let raise_at_rule_error = message =>
          Ppxlib.Location.raise_errorf(
            ~loc=
              Styled_ppx_css_parser.Parser_location.to_file_location(
                ~source_position_start,
                name_loc,
              ),
            "%s",
            message,
          );
        let is_conditional_group_rule =
          switch (String.lowercase_ascii(name)) {
          | "media"
          | "supports"
          | "container"
          | "starting-style" => true
          | _ => false
          };
        switch (block) {
        | _ when String.lowercase_ascii(name) == "keyframes" =>
          raise_at_rule_error(
            "@keyframes should be defined with %keyframe(...)",
          )
        | _ when !is_conditional_group_rule =>
          raise_at_rule_error(
            Printf.sprintf(
              "At-rule @%s is not supported in styled-ppx",
              name,
            ),
          )
        | Empty =>
          raise_at_rule_error(
            Printf.sprintf(
              "At-rule @%s requires a block (`@%s ... { ... }`)",
              name,
              name,
            ),
          )

        /* Both Rule_list and Stylesheet payloads are atomized the same way:
           recurse into the inner rules, then re-wrap each atom in a fresh
           `At_rule(... Rule_list ...)`. We normalize Stylesheet → Rule_list
           on output because each atom carries exactly one inner rule.

           The accumulated parent prelude is threaded through so that any
           Style_rule (or bare Declaration) nested inside an at-rule still
           carries the full selector chain. The Declaration arm above turns
           a bare Declaration with a parent into a Style_rule, which is what
           lets `.a .b { @media (...) { color: red } }` render correctly as
           `@media (...) { .a-X .a .b { color:red } }`. */
        | Rule_list((rules, rule_loc))
        | Stylesheet((rules, rule_loc)) =>
          extract_atomic_rules_from_block(~parent_prelude?, rules)
          |> List.map(((_className, _namespace, inner_rule)) => {
               let wrapped =
                 At_rule({
                   name: (name, name_loc),
                   prelude,
                   block: Rule_list(([inner_rule], rule_loc)),
                   loc,
                 });
               let wrapped_string = render_rule(wrapped);
               let (new_className, new_namespace) =
                 Hash_class.class_and_namespace(
                   ~namespace=Settings.Get.namespace(),
                   ~slot=Slot_key.of_atom(wrapped),
                   wrapped_string,
                 );
               (new_className, new_namespace, wrapped);
             })
        };
      };
    };

    extract_atomic_rules_from_block(~parent_prelude=?None, rules);
  };

  /* Lower a single atom into its concrete CSS rules, resolving `&` /
     descendant nesting against [effective_class] and substituting
     interpolations under [effective_namespace]. A bare `Declaration` atom is
     wrapped under `.effective_class`; nested / at-rule atoms run through
     `Transform.run`. */
  let lower_atom = (ctx, ~effective_class, ~effective_namespace, ~loc, rule) => {
    let single_rule_list = ([rule], loc);
    let transformed =
      switch (rule) {
      | Declaration(decl) =>
        let wrapped =
          Style_rule({
            prelude: (
              [
                (
                  CompoundSelector({
                    type_selector: None,
                    subclass_selectors: [Class(effective_class)],
                    pseudo_selectors: [],
                  }),
                  Ppxlib.Location.none,
                ),
              ],
              Ppxlib.Location.none,
            ),
            block: ([Declaration(decl)], Ppxlib.Location.none),
            loc: Ppxlib.Location.none,
          });
        [wrapped];

      | Style_rule(_)
      | At_rule(_) =>
        Styled_ppx_css_parser.Transform.run(
          ~className=effective_class,
          single_rule_list,
        )
      };

    transformed
    |> List.map(r =>
         transform_rule(ctx, ~var_namespace=effective_namespace, r)
       );
  };

  let transform_rule_list =
      (
        ~file,
        ~scope: list(string),
        ~opens: list(list(string)),
        ~source_position_start,
        rule_list: rule_list,
      ) => {
    let ctx = {
      file,
      scope,
      opens,
      source_position_start,
      dynamic_vars: ref([]),
    };
    let (rules, loc) = rule_list;

    /* Resolve selector-class references before atomizing (see
       `resolve_rule_selectors`'s own comment) so an atom's hash reflects
       the RESOLVED selector, not a local binding name that can mean a
       different binding in every file that uses it. */
    let selector_resolved_rules =
      List.map(resolve_rule_selectors(ctx), rules);
    /* Media condition ordering (see `rewrite_media_conditions`'s own
       doc): runs before `atomize_rules` so a rewritten `@media` condition
       is what gets hashed into its atom's class name. */
    let media_rewritten_rules =
      rewrite_media_conditions(selector_resolved_rules);
    let atomic_rules =
      atomize_rules(~source_position_start, media_rewritten_rules);

    /* Selective atomization: of a block's SINGLETON interpolating atoms
       (`atom_has_value_interpolation` - a multi-declaration group from
       `group_declarations_by_family`'s leaf-overlap pass is never a
       candidate here, see `atom_declaration`'s own doc: it already shares
       one namespace for whatever it groups), only those that reference the
       SAME `$(name)` source path as another one actually need to share
       anything - one variable, one inline custom property for that value
       across base/`:hover`/`@media` (see Hash_class.ml). Two atoms that
       merely both happen to interpolate, but different, unrelated paths,
       do not: `color: $(a); background-color: $(b);` used to force both
       into one bundle for no reason neither value needed.

       Grouped by shared path with union-find - same technique
       `group_declarations_by_family` already uses for leaf overlap,
       transitively: an atom interpolating two paths (`border: $(a) solid
       $(b);`) bridges both into one group, same reasoning a declaration
       bridging two leaf sets does there. A group of exactly one atom is
       not a bundle at all: it already got a real, structural slot-keyed
       class from `atomize_rules` above (via `Hash_class.class_and_namespace`
       / `Slot_key.of_atom`, same path a static atom uses), so it merges
       normally like any other atom - `CSS.merge` only stays blind to an
       atom that genuinely shares its class with an unrelated sibling, not
       to every interpolated declaration on principle. A group of two or
       more gets today's bundle mechanism (class `in-<B>`/var namespace
       `css-<B>` - same bundle content hash, different literal prefix, see
       Hash_class.ml's "Prefix rename"), scoped to that group's own members
       only, so a block can now mint more than one independent bundle.

       Static declarations keep their own per-content atom class (still
       shared across blocks). A block with no interpolation, or where no
       two interpolating atoms share a path, mints no bundle at all and is
       byte-for-byte identical to the pre-bundle output. */
    let interpolating_atoms =
      atomic_rules
      |> List.mapi((i, atom) => (i, atom))
      |> List.filter(((_i, (_cn, _ns, rule))) =>
           atom_has_value_interpolation(rule)
         )
      |> Array.of_list;
    let interpolating_count = Array.length(interpolating_atoms);
    let paths_of = i => {
      let (_atomic_index, (_cn, _ns, rule)) = interpolating_atoms[i];
      switch (atom_declaration(rule)) {
      | Some(decl) => declaration_interpolation_paths(decl)
      | None => [] /* unreachable: atom_has_value_interpolation implies Some */
      };
    };
    let paths = Array.init(interpolating_count, paths_of);
    /* Union-find over positions [0, interpolating_count) - path-compressed,
       no union-by-rank (a block's interpolating-atom count is always
       small). Connects i and j when their path sets intersect. */
    let parent = Array.init(interpolating_count, i => i);
    let rec find = i =>
      if (parent[i] == i) {
        i;
      } else {
        let root = find(parent[i]);
        parent[i] = root;
        root;
      };
    let union = (i, j) => {
      let (ri, rj) = (find(i), find(j));
      if (ri != rj) {
        parent[max(ri, rj)] = min(ri, rj);
      };
    };
    for (i in 0 to interpolating_count - 1) {
      for (j in i + 1 to interpolating_count - 1) {
        if (List.exists(p => List.mem(p, paths[j]), paths[i])) {
          union(i, j);
        };
      };
    };
    let members_by_root: Hashtbl.t(int, ref(list(int))) =
      Hashtbl.create(8);
    for (i in 0 to interpolating_count - 1) {
      let root = find(i);
      switch (Hashtbl.find_opt(members_by_root, root)) {
      | Some(members) => members := [i, ...members^]
      | None => Hashtbl.add(members_by_root, root, ref([i]))
      };
    };
    /* Only a root with 2+ members mints a bundle; a singleton root's atom
       keeps the real class `atomic_rules` already gave it (no entry here). */
    let bundle_by_atomic_index: Hashtbl.t(int, (string, string)) =
      Hashtbl.create(8);
    Hashtbl.iter(
      (_root, members) =>
        switch (List.rev(members^)) {
        | []
        | [_] => ()
        | member_positions =>
          let seeds =
            member_positions
            |> List.map(k => {
                 let (_atomic_index, (_cn, _ns, rule)) = interpolating_atoms[k];
                 render_rule(rule);
               });
          let bundle_class_and_namespace =
            Hash_class.bundle_class_and_namespace(
              ~namespace=Settings.Get.namespace(),
              String.concat("", seeds),
            );
          List.iter(
            k => {
              let (atomic_index, _) = interpolating_atoms[k];
              Hashtbl.replace(
                bundle_by_atomic_index,
                atomic_index,
                bundle_class_and_namespace,
              );
            },
            member_positions,
          );
        },
      members_by_root,
    );

    let (shipped_rev, classes_rev, atom_infos_rev) =
      atomic_rules
      |> List.mapi((i, atom) => (i, atom))
      |> List.fold_left(
           (
             (shipped_acc, classes_acc, atom_infos_acc),
             (i, (className, var_namespace, rule)),
           ) => {
             let (effective_class, effective_namespace, dedup_key) =
               switch (Hashtbl.find_opt(bundle_by_atomic_index, i)) {
               | Some((bundle_class, bundle_namespace)) => (
                   bundle_class,
                   bundle_namespace,
                   None /* content-keyed: many bundle rules share one class */,
                 )
               | None => (className, var_namespace, Some(className))
               };

             let processed =
               lower_atom(
                 ctx,
                 ~effective_class,
                 ~effective_namespace,
                 ~loc,
                 rule,
               )
               |> List.map(r => (dedup_key, r));

             let classes_acc =
               List.mem(effective_class, classes_acc)
                 ? classes_acc : [effective_class, ...classes_acc];

             /* Record the atom's `&`-locality and the vars it references
                (scanned from rendered text so cross-atom dedup can't hide a
                reference), for the inherits:false decision below. */
             let atom_local = atom_is_ampersand_local(rule);
             let referenced =
               processed
               |> List.concat_map(((_key, r)) =>
                    custom_property_names_in_text(render_rule(r))
                  );

             (
               List.rev_append(processed, shipped_acc),
               classes_acc,
               [(atom_local, referenced), ...atom_infos_acc],
             );
           },
           ([], [], []),
         );

    let atom_infos = atom_infos_rev;
    let dynamic_vars_final = List.rev(ctx.dynamic_vars^);

    /* A var registers @property{inherits:false} iff its type supports it and
       every atom that reads it is `&`-local. */
    let safe_inherits_false_vars =
      dynamic_vars_final
      |> List.filter_map(({ name, var_type, _ }) =>
           if (var_type_supports_inherits_false(var_type)
               && List.for_all(
                    ((atom_local, referenced)) =>
                      atom_local || !List.mem(name, referenced),
                    atom_infos,
                  )) {
             Some(name);
           } else {
             None;
           }
         );

    (
      List.rev(shipped_rev),
      List.rev(classes_rev),
      dynamic_vars_final,
      safe_inherits_false_vars,
    );
  };
};

/* Per-compilation-unit occurrence counter for identity classes, keyed by
   (scope, name). A repeated (scope, name) - e.g. two functions each with
   their own `let a = [%css ...]` - would otherwise mint the same identity
   for two unrelated bindings; the occurrence count breaks the tie. Cleared
   in `get()`, at the same point every other per-CU accumulator resets. */
let identity_occurrences: Hashtbl.t((string, string), int) =
  Hashtbl.create(64);

let next_identity_occurrence = (~scope: list(string), ~name: string) => {
  let key = (String.concat(".", scope), name);
  let next =
    1 + Option.value(Hashtbl.find_opt(identity_occurrences, key), ~default=0);
  Hashtbl.replace(identity_occurrences, key, next);
  next;
};

/* The identity class for a named binding (see `Hash_class.identity_class`).
   `None` for an anonymous (`_`) or statement-position binding: it cannot be
   referenced cross-module, so it needs no stable handle. Independent of
   `--minify` - unlike the historical label suffix, the identity is never
   dropped in production, which is what lets an empty named binding still
   resolve `&.$(name)` under `--minify` (see documents/css-extraction.md). */
let identity_of_name = (~main_module, ~scope, ~name: option(string)) =>
  switch (name) {
  | Some(n) when n != "_" =>
    let occurrence = next_identity_occurrence(~scope, ~name=n);
    Some(
      Hash_class.identity_class(
        ~namespace=Settings.Get.namespace(),
        ~module_name=main_module,
        ~scope,
        ~name=n,
        ~occurrence,
      ),
    );
  | _ => None
  };

let push =
    (
      ~file,
      ~main_module,
      ~scope: list(string),
      ~opens: list(list(string)),
      ~source_position_start,
      ~name: option(string),
      declarations: Styled_ppx_css_parser.Ast.rule_list,
    ) => {
  let (shipped_rules, binding_classes, dynamic_vars, safe_inherits_false_vars) =
    Css_transform.transform_rule_list(
      ~file,
      ~scope,
      ~opens,
      ~source_position_start,
      declarations,
    );

  /* Ship every rule, deduped by its key. Static atoms key by class name (class
     and content are 1:1). Bundle rules carry `None` and key by rendered content,
     since many share one bundle class and class-name keying would drop all but
     the first. */
  List.iter(
    ((dedup_key, rule)) => {
      let rendered_css = render_prefixed_rule(rule);
      let key =
        switch (dedup_key) {
        | Some(className) => className
        | None => rendered_css
        };
      Buffer.add_rule(key, rendered_css);
    },
    shipped_rules,
  );

  /* Register each `&`-local var with @property{inherits:false} so a value change
     invalidates only the element, not its subtree. `syntax:"*"` accepts any
     value and needs no `initial-value`; the var is always set inline by
     `CSS.make`, so it is never unset. Deduped by content here and across units
     by `generate`, so a name reused N times ships one registration. */
  List.iter(
    var_name =>
      Buffer.add_global_rule(
        "@property --" ++ var_name,
        "@property --" ++ var_name ++ "{syntax:\"*\";inherits:false;}",
      ),
    safe_inherits_false_vars,
  );

  let identity = identity_of_name(~main_module, ~scope, ~name);

  (identity, binding_classes, dynamic_vars);
};

let classes_with_identity = (~identity, atomClasses) =>
  switch (identity) {
  | Some(cid) => [cid, ...atomClasses]
  | None => atomClasses
  };

let push_keyframe =
    (
      ~file,
      ~main_module,
      ~scope: list(string),
      ~opens: list(list(string)),
      ~source_position_start,
      keyframe_rules: Styled_ppx_css_parser.Ast.rule_list,
    ) => {
  open Styled_ppx_css_parser.Ast;

  let (rules, rule_loc) = keyframe_rules;
  let ctx =
    Css_transform.{
      file,
      scope,
      opens,
      source_position_start,
      dynamic_vars: ref([]),
    };
  let var_namespace =
    Hash_class.scoped_namespace(
      ~kind="keyframes",
      ~module_name=main_module,
      ~scope,
      ~rendered_rules=List.map(render_rule, rules),
    );
  let transformed_rules =
    rules
    |> List.map(rule =>
         Css_transform.transform_rule(ctx, ~var_namespace, rule)
       );
  let rendered_body =
    transformed_rules |> List.map(render_rule) |> String.concat(" ");

  let keyframe_name = Hash_class.keyframe_name(rendered_body);

  let at_rule: at_rule = {
    name: ("keyframes", Ppxlib.Location.none),
    prelude: (
      [(Ident(keyframe_name), Ppxlib.Location.none)],
      Ppxlib.Location.none,
    ),
    block: Rule_list((transformed_rules, rule_loc)),
    loc: Ppxlib.Location.none,
  };

  let rendered_keyframe = render_prefixed_rule(At_rule(at_rule));

  Buffer.add_rule(keyframe_name, rendered_keyframe);

  (keyframe_name, List.rev(ctx.dynamic_vars^));
};

/* Walk every rule in a [%styled.global] block, substitute
   `$(expr)` interpolations with scoped `var(--var-<hash>)` names on the static
   side, and accumulate the corresponding dynamic_vars.

   Each rule (whether or not it contains interpolation) is pushed to
   `Buffer.add_global_rule` so it ships through the existing
   `[@@@css ...]` channel. The returned dynamic_vars feeds the
   generated module's `to_string`, which emits a single
   `:root { --var-<hash>: <value>; ... }` block for callers that explicitly
    request the dynamic custom-property CSS; one declaration per dynamic_var
    entry (already deduplicated by `Css_transform.add_dynamic_var`).

   Static-only blocks return an empty dynamic_vars list, which makes
   `to_string` emit `""`. */
let push_global =
    (
      ~file,
      ~main_module,
      ~scope: list(string),
      ~opens: list(list(string)),
      ~source_position_start,
      global_rules: Styled_ppx_css_parser.Ast.rule_list,
    )
    : list(dynamic_var) => {
  open Styled_ppx_css_parser.Ast;

  let (rules, _) = global_rules;
  let ctx =
    Css_transform.{
      file,
      scope,
      opens,
      source_position_start,
      dynamic_vars: ref([]),
    };

  let rec reject_parentless_ampersand = rule =>
    switch (rule) {
    | Style_rule({ prelude: (selectors, _), _ }) =>
      List.iter(
        ((selector, selector_loc)) =>
          if (Styled_ppx_css_parser.Selector_nesting.needs_parent_selector(
                selector,
              )) {
            Ppxlib.Location.raise_errorf(
              ~loc=
                Styled_ppx_css_parser.Parser_location.to_file_location(
                  ~source_position_start,
                  selector_loc,
                ),
              "The nesting selector `&` has no parent selector to resolve against here in [%%styled.global] (at-rules like @media don't provide one). Write a concrete selector instead.",
            );
          },
        selectors,
      )
    | At_rule({ block: Rule_list((inner, _)), _ })
    | At_rule({ block: Stylesheet((inner, _)), _ }) =>
      List.iter(reject_parentless_ampersand, inner)
    | At_rule({ block: Empty, _ })
    | Declaration(_) => ()
    };
  List.iter(reject_parentless_ampersand, rules);

  /* Flatten CSS-nesting before rendering (literal nesting only works in
     modern browsers). Same order-preserving flattener as `[%css]`;
     @font-face/@keyframes/@import pass through verbatim. */
  let flattened_rules =
    Styled_ppx_css_parser.Resolve.resolve_selectors(rules);
  let var_namespace =
    Hash_class.scoped_namespace(
      ~kind="global",
      ~module_name=main_module,
      ~scope,
      ~rendered_rules=List.map(render_rule, flattened_rules),
    );

  /* transform_rule walks the rule, replacing every Variable(path) in
     declaration values with a namespace/type-scoped var(--hash) and appending
     the corresponding dynamic_var to the context accumulator.

     The caller in [ppx.re] pre-checks the rule list for top-level
     Declaration nodes and bails before invoking this function, so the
     Declaration arm here is unreachable in practice. We keep it as a
     defensive no-op rather than partial-matching, so a future caller
     bypassing the pre-check still produces well-formed CSS instead of
     raising. */
  flattened_rules
  |> List.iter(rule =>
       switch (rule) {
       | Style_rule(_)
       | At_rule(_) =>
         let transformed =
           Css_transform.transform_rule(ctx, ~var_namespace, rule);
         let key = Hash_class.global_key(render_rule(transformed));
         Buffer.add_global_rule(key, render_prefixed_rule(transformed));
       | Declaration(_) => ()
       }
     );

  List.rev(ctx.dynamic_vars^);
};

let get = () => {
  let rules = Buffer.get_rules();
  Buffer.clear();
  Local_selector_environment.clear();
  Hashtbl.clear(identity_occurrences);
  rules;
};
