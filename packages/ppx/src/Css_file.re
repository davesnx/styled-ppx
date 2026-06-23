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

let render_rule = Styled_ppx_css_parser.Render.rule;
let render_prefixed_rule = Css_autoprefixer.render_rule;
let render_declaration = Styled_ppx_css_parser.Render.declaration;

module Buffer = {
  type rule = (string, string);
  let accumulated_rules: ref(list(rule)) = ref([]);
  let global_rules: ref(list(rule)) = ref([]);

  let add_to = (target, className, cssText) =>
    if (!List.exists(((existing, _)) => existing == className, target^)) {
      target := [(className, cssText), ...target^];
    };

  let add_rule = add_to(accumulated_rules);
  let add_global_rule = add_to(global_rules);

  let get_rules = () => {
    let dump = target => List.rev_map(((_, cssText)) => cssText, target^);
    dump(global_rules) @ dump(accumulated_rules);
  };

  let clear = () => {
    accumulated_rules := [];
    global_rules := [];
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

  let add_dynamic_var = (dynamic_vars, dynamic_var) => {
    let (var_name, _, _) = dynamic_var;
    if (!
          List.exists(
            ((existing_var_name, _, _)) => existing_var_name == var_name,
            dynamic_vars^,
          )) {
      dynamic_vars := [dynamic_var, ...dynamic_vars^];
    };
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

  /* The single declaration an atom carries: bare (top-level), nested under a
     selector (`Style_rule`), or under an at-rule. None for an atom with no
     declaration body (e.g. an empty at-rule). */
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
      List.rev(Styled_ppx_css_parser.Selector_nesting.flatten_selector_chain(sel))
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
      | Stylesheet((rules, _)) => List.for_all(atom_is_ampersand_local, rules)
      | Empty => true
      }
    };

  let is_var_name_char = c =>
    (c >= 'a' && c <= 'z')
    || (c >= 'A' && c <= 'Z')
    || (c >= '0' && c <= '9')
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
            ~file: string,
            ~scope: list(string),
            ~opens: list(list(string)),
            cv: component_value,
            dynamic_vars: ref(list((string, string, var_type))),
            get_var_binding: string => (string, var_type),
          )
          : component_value => {
    let recurse = ((v, loc)) => (
      transform_component_value(
        ~file,
        ~scope,
        ~opens,
        v,
        dynamic_vars,
        get_var_binding,
      ),
      loc,
    );
    switch (cv) {
    | Variable(path_str, _loc) =>
      let (var_name, var_type) = get_var_binding(path_str);
      add_dynamic_var(dynamic_vars, (var_name, path_str, var_type));

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
          ~loc,
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
        transform_selector(~file, ~scope, ~opens, sel, dynamic_vars),
        loc,
      );
      Selector(List.map(recurse_sel, selector_list));
    | _ => cv
    };
  }

  and transform_selector =
      (~file, ~scope, ~opens, sel: selector, dynamic_vars) => {
    switch (sel) {
    | SimpleSelector(simple) =>
      transform_simple_selector_to_selector(
        ~file,
        ~scope,
        ~opens,
        simple,
        dynamic_vars,
      )
    | ComplexSelector(complex) =>
      ComplexSelector(
        transform_complex_selector(
          ~file,
          ~scope,
          ~opens,
          complex,
          dynamic_vars,
        ),
      )
    | CompoundSelector(compound) =>
      CompoundSelector(
        transform_compound_selector(
          ~file,
          ~scope,
          ~opens,
          compound,
          dynamic_vars,
        ),
      )
    | RelativeSelector(relative) =>
      RelativeSelector({
        ...relative,
        complex_selector:
          transform_complex_selector(
            ~file,
            ~scope,
            ~opens,
            relative.complex_selector,
            dynamic_vars,
          ),
      })
    };
  }

  and transform_complex_selector =
      (~file, ~scope, ~opens, complex: complex_selector, dynamic_vars) => {
    switch (complex) {
    | Selector(sel) =>
      Selector(transform_selector(~file, ~scope, ~opens, sel, dynamic_vars))
    | Combinator({ left, right }) =>
      Combinator({
        left: transform_selector(~file, ~scope, ~opens, left, dynamic_vars),
        right:
          List.map(
            ((combinator, sel)) =>
              (
                combinator,
                transform_selector(~file, ~scope, ~opens, sel, dynamic_vars),
              ),
            right,
          ),
      })
    };
  }

  /* Resolve `ClassVariable(name)` (i.e. `.$(name)`) by replacing it with
     the chain of `Class(c)` subclass selectors corresponding to the
     classNames the referenced [%css] binding minted. Multi-declaration
     bindings expand to a compound chain (`&.cssA.cssB`) which matches the
     "AND" semantics: every consumer of the referenced binding has all of
     its atomized classes applied to the same element. */
  and transform_compound_selector =
      (~file, ~scope, ~opens, compound: compound_selector, dynamic_vars) => {
    let transformed_type_selector =
      Option.map(
        simple =>
          transform_simple_selector(
            ~file,
            ~scope,
            ~opens,
            simple,
            dynamic_vars,
          ),
        compound.type_selector,
      );
    let transformed_subclasses =
      compound.subclass_selectors
      |> List.concat_map(subclass =>
           transform_subclass_selector_to_list(
             ~file,
             ~scope,
             ~opens,
             subclass,
             dynamic_vars,
           )
         );
    let transformed_pseudos =
      compound.pseudo_selectors
      |> List.map(pseudo =>
           transform_pseudo_selector(
             ~file,
             ~scope,
             ~opens,
             pseudo,
             dynamic_vars,
           )
         );
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
      (~file, ~scope, ~opens, simple: simple_selector, _dynamic_vars)
      : simple_selector => {
    switch (simple) {
    | Variable(path_str, var_loc) =>
      /* Bare `$(name)` (no `.` prefix) in selector position. We treat it
         like an implicit class reference and resolve to the first minted
         className as a `Type` selector if there's exactly one; otherwise
         this case is ambiguous - fall through to error. We emit a
         `Type(..)` rather than `Class(..)` because the user wrote no `.`,
         so the resolved value must serve as the type-selector slot. The
         caller (`transform_compound_selector`) only places this in the
         `type_selector` slot, never in `subclass_selectors`. */
      let resolved =
        Local_selector_environment.resolve_selector_class_ref(
          ~file,
          ~scope,
          ~opens,
          ~loc=var_loc,
          path_str,
        );
      switch (resolved) {
      | [single] => Type("." ++ single)
      | _ =>
        Ppxlib.Location.raise_errorf(
          ~loc=var_loc,
          "Bare `$(%s)` selector interpolation expanded to %d class names; this position only accepts a single class. Prefix with `.` to use a class chain instead: `.$(%s)`.",
          path_str,
          List.length(resolved),
          path_str,
        )
      };
    | _ => simple
    };
  }

  /* When a `simple_selector` appears outside a compound (i.e. as a
     `SimpleSelector(...)` whole-selector wrapping it), we still need to
     express the resolution. Same lookup, wraps the result. */
  and transform_simple_selector_to_selector =
      (~file, ~scope, ~opens, simple: simple_selector, dynamic_vars): selector => {
    switch (simple) {
    | Variable(_, _) =>
      SimpleSelector(
        transform_simple_selector(
          ~file,
          ~scope,
          ~opens,
          simple,
          dynamic_vars,
        ),
      )
    | _ => SimpleSelector(simple)
    };
  }

  /* `transform_subclass_selector_to_list` returns a *list* of subclass
     selectors so `ClassVariable` can fan out into a compound chain
     (`.cssA.cssB`) for multi-declaration source bindings. */
  and transform_subclass_selector_to_list =
      (~file, ~scope, ~opens, subclass: subclass_selector, dynamic_vars)
      : list(subclass_selector) => {
    switch (subclass) {
    | ClassVariable(path_str, var_loc) =>
      let classNames =
        Local_selector_environment.resolve_selector_class_ref(
          ~file,
          ~scope,
          ~opens,
          ~loc=var_loc,
          path_str,
        );
      List.map(c => Class(c), classNames);
    | Pseudo_class(pseudo) => [
        Pseudo_class(
          transform_pseudo_selector(
            ~file,
            ~scope,
            ~opens,
            pseudo,
            dynamic_vars,
          ),
        ),
      ]
    | _ => [subclass]
    };
  }

  /* Pseudo-classes like `:not(...)`, `:is(...)`, `:where(...)`,
     `:has(...)`, `:nth-child(of ...)` etc. carry nested selector lists.
     Recurse into the payload so `:not(&.$(foo))` resolves the same way as
     a top-level `&.$(foo)`. */
  and transform_pseudo_selector =
      (~file, ~scope, ~opens, pseudo: pseudo_selector, dynamic_vars)
      : pseudo_selector => {
    switch (pseudo) {
    | Pseudoelement(_) => pseudo
    | Pseudoclass(kind) =>
      Pseudoclass(
        transform_pseudoclass_kind(~file, ~scope, ~opens, kind, dynamic_vars),
      )
    };
  }

  and transform_pseudoclass_kind =
      (~file, ~scope, ~opens, kind: pseudoclass_kind, dynamic_vars)
      : pseudoclass_kind => {
    switch (kind) {
    | PseudoIdent(_) => kind
    | Function({ name, payload: (selector_list, payload_loc) }) =>
      let transformed =
        List.map(
          ((sel, sel_loc)) =>
            (
              transform_selector(~file, ~scope, ~opens, sel, dynamic_vars),
              sel_loc,
            ),
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
        | NthSelector(complex_selectors) =>
          NthSelector(
            List.map(
              c =>
                transform_complex_selector(
                  ~file,
                  ~scope,
                  ~opens,
                  c,
                  dynamic_vars,
                ),
              complex_selectors,
            ),
          )
        };
      NthFunction({
        name,
        payload: (transformed_payload, payload_loc),
      });
    };
  };

  let transform_declaration =
      (~file, ~scope, ~opens, ~var_namespace, decl: declaration, dynamic_vars) => {
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
          (
            transform_component_value(
              ~file,
              ~scope,
              ~opens,
              cv,
              dynamic_vars,
              get_var_binding,
            ),
            loc,
          ),
        value_list,
      );
    {
      ...decl,
      value: (transformed_values, value_loc),
    };
  };

  let rec transform_rule =
          (
            ~file,
            ~scope,
            ~opens,
            ~base_loc,
            ~var_namespace,
            rule: rule,
            dynamic_vars,
          ) => {
    switch (rule) {
    | Declaration(decl) =>
      Declaration(
        transform_declaration(
          ~file,
          ~scope,
          ~opens,
          ~var_namespace,
          decl,
          dynamic_vars,
        ),
      )
    | Style_rule(style_rule) =>
      Style_rule(
        transform_style_rule(
          ~file,
          ~scope,
          ~opens,
          ~base_loc,
          ~var_namespace,
          style_rule,
          dynamic_vars,
        ),
      )
    | At_rule(at_rule) =>
      At_rule(
        transform_at_rule(
          ~file,
          ~scope,
          ~opens,
          ~base_loc,
          ~var_namespace,
          at_rule,
          dynamic_vars,
        ),
      )
    };
  }

  and transform_style_rule =
      (
        ~file,
        ~scope,
        ~opens,
        ~base_loc,
        ~var_namespace,
        style_rule: style_rule,
        dynamic_vars,
      ) => {
    let { prelude, block, loc } = style_rule;
    let (selector_list, selector_loc) = prelude;
    let transformed_selectors =
      List.map(
        ((sel, sel_loc)) =>
          (
            transform_selector(~file, ~scope, ~opens, sel, dynamic_vars),
            sel_loc,
          ),
        selector_list,
      );
    let (rule_list, rule_loc) = block;
    let transformed_rules =
      List.map(
        rule =>
          transform_rule(
            ~file,
            ~scope,
            ~opens,
            ~base_loc,
            ~var_namespace,
            rule,
            dynamic_vars,
          ),
        rule_list,
      );
    {
      prelude: (transformed_selectors, selector_loc),
      block: (transformed_rules, rule_loc),
      loc,
    };
  }

  and transform_at_rule =
      (
        ~file,
        ~scope,
        ~opens,
        ~base_loc,
        ~var_namespace,
        at_rule: at_rule,
        dynamic_vars,
      ) => {
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
        ~loc=
          Styled_ppx_css_parser.Parser_location.adjust_to_file(
            ~relative_loc=loc,
            ~base_loc,
          ),
        "Interpolation in @%s preludes is not supported during static extraction. CSS custom properties (var()) are not valid in media query conditions. Inline the value directly.",
        at_name,
      );
    };

    let map_payload = ((rules, rule_loc)) => (
      List.map(
        r =>
          transform_rule(
            ~file,
            ~scope,
            ~opens,
            ~base_loc,
            ~var_namespace,
            r,
            dynamic_vars,
          ),
        rules,
      ),
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

  let raise_bare_leading_pseudo_error = (~loc, ~base_loc, sel) => {
    let rendered = Styled_ppx_css_parser.Render.selector(sel);
    Ppxlib.Location.raise_errorf(
      ~loc=
        Styled_ppx_css_parser.Parser_location.adjust_to_file(
          ~relative_loc=loc,
          ~base_loc,
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
      (~loc, ~base_loc, ~property, sel) => {
    let rendered = Styled_ppx_css_parser.Render.selector(sel);
    Ppxlib.Location.raise_errorf(
      ~loc=
        Styled_ppx_css_parser.Parser_location.adjust_to_file(
          ~relative_loc=loc,
          ~base_loc,
        ),
      "Cannot interpolate into the value of `%s` under `%s`: the selector targets an element outside `&`'s subtree (via a sibling combinator `+`/`~`, or a pseudo-class like `:not(&)`/`:has(&)` whose subject isn't `&` or a descendant of it). Static extraction passes interpolations as a custom property set inline on `&`, which only `&` and its descendants inherit, so an element outside that subtree can't read it and the declaration would be dropped. Instead, target `&` or a descendant, or write a literal value or a globally-inherited theme `var(--...)` directly.",
      property,
      rendered,
    );
  };

  /* Same-property declarations of a block group into ONE atom so the
     winner is decided by intra-atom source order (emotion parity) —
     fallback pairs like `display: -webkit-box; display: flex` stay
     together; splitting them would let stylesheet position pick the
     winner. Groups anchor at the LAST occurrence (a group cascades like
     its last member; first-anchoring would hoist duplicates past
     intervening rules). Singletons keep the historical atom shape and
     hash. */
  type block_item =
    | Declaration_group(list(declaration))
    | Nested_rule(rule);

  /* Property names are case-insensitive; custom properties (`--*`) are
     case-sensitive. */
  let declaration_group_key = ({ name: (name, _), _ }: declaration) =>
    if (String.length(name) >= 2 && String.sub(name, 0, 2) == "--") {
      name;
    } else {
      String.lowercase_ascii(name);
    };

  let group_declarations_by_property = (rules: list(rule)): list(block_item) => {
    /* Pass 1: collect declarations per key + each key's last index. */
    let decls_by_key: Hashtbl.t(string, ref(list(declaration))) =
      Hashtbl.create(8);
    let last_index_by_key: Hashtbl.t(string, int) = Hashtbl.create(8);
    List.iteri(
      (index, rule) =>
        switch (rule) {
        | Declaration(decl) =>
          let key = declaration_group_key(decl);
          switch (Hashtbl.find_opt(decls_by_key, key)) {
          | Some(group) => group := [decl, ...group^]
          | None => Hashtbl.add(decls_by_key, key, ref([decl]))
          };
          Hashtbl.replace(last_index_by_key, key, index);
        | _ => ()
        },
      rules,
    );
    /* Pass 2: emit each group at its last occurrence. */
    List.mapi(
      (index, rule) =>
        switch (rule) {
        | Declaration(decl) =>
          let key = declaration_group_key(decl);
          if (Hashtbl.find(last_index_by_key, key) == index) {
            let group = Hashtbl.find(decls_by_key, key);
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

  let atomize_rules =
      (~base_loc, ~label=?, rules: list(rule))
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

    /* Wrap a same-property `Declaration` group (see
       `group_declarations_by_property`) as one atom. No parent:
       singleton keeps the historical bare `Declaration` atom (hash
       stability); a group becomes `& { ... }` (`&` resolves to the
       className). With a parent: one `Style_rule(parent){group}` atom
       per parent selector. */
    let wrap_declaration_group_under_parent = (~parent_prelude=?, decls) => {
      switch (parent_prelude) {
      | None =>
        switch (decls) {
        | [decl] =>
          let decl_string = render_declaration(decl);
          let (className, namespace) =
            Hash_class.class_and_namespace(~label?, decl_string);
          [(className, namespace, Declaration(decl))];
        | decls =>
          let group_string =
            decls |> List.map(render_declaration) |> String.concat("");
          let (className, namespace) =
            Hash_class.class_and_namespace(~label?, group_string);
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
                ~base_loc,
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
              Hash_class.class_and_namespace(~label?, rule_string);
            (className, namespace, style_rule);
          },
          parent_selectors,
        );
      };
    };

    /* Atomize one block's rules: same-property declarations group into a
       single atom (see `group_declarations_by_property`); everything
       else atomizes rule by rule. */
    let rec extract_atomic_rules_from_block =
            (~parent_prelude=?, rules: list(rule))
            : list((string, string, rule)) =>
      rules
      |> group_declarations_by_property
      |> List.concat_map(
           fun
           | Declaration_group(decls) =>
             wrap_declaration_group_under_parent(~parent_prelude?, decls)
           | Nested_rule(rule) => extract_atomic_rules(~parent_prelude?, rule),
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
              raise_bare_leading_pseudo_error(~loc=sel_loc, ~base_loc, sel);
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
              Styled_ppx_css_parser.Parser_location.adjust_to_file(
                ~relative_loc=name_loc,
                ~base_loc,
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
            Printf.sprintf("At-rule @%s is not supported in styled-ppx", name),
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
           `@media (...) { .css-X .a .b { color:red } }`. */
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
                 Hash_class.class_and_namespace(~label?, wrapped_string);
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
  let lower_atom =
      (~file, ~scope, ~opens, ~base_loc, ~effective_class, ~effective_namespace, ~loc, rule, dynamic_vars) => {
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
         transform_rule(
           ~file,
           ~scope,
           ~opens,
           ~base_loc,
           ~var_namespace=effective_namespace,
           r,
           dynamic_vars,
         )
       );
  };

  let transform_rule_list =
      (
        ~file,
        ~scope: list(string),
        ~opens: list(list(string)),
        ~base_loc,
        ~label=?,
        rule_list: rule_list,
      ) => {
    let dynamic_vars = ref([]);
    let (rules, loc) = rule_list;

    let atomic_rules = atomize_rules(~base_loc, ~label?, rules);

    /* Selective atomization: the block's interpolating declarations become one
       content-addressed bundle, with class `css-<B>-<label>` and var namespace
       `css-<B>` (label-free) shared across base/`:hover`/`@media`. Both derive
       from the same bundle content, so identical bundles dedup to identical
       rules + vars and different bundles never collide, preserving the
       cross-module atomic invariant (see Hash_class.ml) and `CSS.merge`.

       Static declarations keep their own per-content atom class (still shared
       across blocks). A block with no interpolation produces no bundle and is
       byte-for-byte identical to the pre-bundle output. */
    let bundle =
      switch (
        atomic_rules
        |> List.filter_map(((_cn, _ns, rule)) =>
             atom_has_value_interpolation(rule)
               ? Some(render_rule(rule)) : None
           )
      ) {
      | [] => None
      | seeds =>
        Some(Hash_class.class_and_namespace(~label?, String.concat("", seeds)))
      };

    let (shipped_rev, classes_rev, atom_infos_rev) =
      List.fold_left(
        (
          (shipped_acc, classes_acc, atom_infos_acc),
          (className, var_namespace, rule),
        ) => {
          let (effective_class, effective_namespace, dedup_key) =
            switch (bundle) {
            | Some((bundle_class, bundle_namespace))
                when atom_has_value_interpolation(rule) => (
                bundle_class,
                bundle_namespace,
                None /* content-keyed: many bundle rules share one class */,
              )
            | _ => (className, var_namespace, Some(className))
            };

          let processed =
            lower_atom(
              ~file,
              ~scope,
              ~opens,
              ~base_loc,
              ~effective_class,
              ~effective_namespace,
              ~loc,
              rule,
              dynamic_vars,
            )
            |> List.map(r => (dedup_key, r));

          let classes_acc =
            List.mem(effective_class, classes_acc)
              ? classes_acc : [effective_class, ...classes_acc];

          /* Record the atom's `&`-locality and the vars it references (scanned
             from rendered text so cross-atom dedup can't hide a reference), for
             the inherits:false decision below. */
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
        atomic_rules,
      );

    let atom_infos = atom_infos_rev;
    let dynamic_vars_final = List.rev(dynamic_vars^);

    /* A var registers @property{inherits:false} iff its type supports it and
       every atom that reads it is `&`-local. */
    let safe_inherits_false_vars =
      dynamic_vars_final
      |> List.filter_map(((var_name, _path, var_type)) =>
           if (var_type_supports_inherits_false(var_type)
               && List.for_all(
                    ((atom_local, referenced)) =>
                      atom_local || !List.mem(var_name, referenced),
                    atom_infos,
                  )) {
             Some(var_name);
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

/* Empty `[%css {||}]` bound to a named `let` mints a deterministic
   class handle (`css-<hash-of-empty>-<label>`) so consumers can
   resolve `&.$(name)` against it. No `[@@@css ...]` is emitted —
   there's no rule to write. Anonymous (`_`) and statement-position
   bindings return `[]`, preserving the historical `CSS.make("", [])`
   shape. */
let mint_empty_class = (~label) =>
  switch (label) {
  | Some(name) when name != "_" => [Hash_class.class_name(~label=name, "")]
  | _ => []
  };

let push =
    (
      ~file,
      ~scope: list(string),
      ~opens: list(list(string)),
      ~base_loc,
      ~label=?,
      declarations: Styled_ppx_css_parser.Ast.rule_list,
    ) => {
  let (shipped_rules, binding_classes, dynamic_vars, safe_inherits_false_vars) =
    Css_transform.transform_rule_list(
      ~file,
      ~scope,
      ~opens,
      ~base_loc,
      ~label?,
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

  let classNames =
    switch (binding_classes) {
    | [] => mint_empty_class(~label)
    | _ => binding_classes
    };

  (classNames, dynamic_vars);
};

let push_keyframe =
    (
      ~file,
      ~main_module,
      ~scope: list(string),
      ~opens: list(list(string)),
      ~base_loc,
      keyframe_rules: Styled_ppx_css_parser.Ast.rule_list,
    ) => {
  open Styled_ppx_css_parser.Ast;

  let (rules, rule_loc) = keyframe_rules;
  let dynamic_vars = ref([]);
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
         Css_transform.transform_rule(
           ~file,
           ~scope,
           ~opens,
           ~base_loc,
           ~var_namespace,
           rule,
           dynamic_vars,
         )
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

  (keyframe_name, List.rev(dynamic_vars^));
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
      ~base_loc,
      global_rules: Styled_ppx_css_parser.Ast.rule_list,
    )
    : list((string, string, var_type)) => {
  open Styled_ppx_css_parser.Ast;

  let (rules, _) = global_rules;
  let all_dynamic_vars = ref([]);

  /* Reject `&` with no parent selector: top level, or inside at-rule
     blocks not below a style rule (at-rules don't contribute a
     selector). Recursion stops at style rules — nested `&` is fine. */
  let rec reject_parentless_ampersand = rule =>
    switch (rule) {
    | Style_rule({ prelude: (selectors, _), _ }) =>
      List.iter(
        ((selector, selector_loc)) =>
          if (Styled_ppx_css_parser.Selector_nesting.contains_ampersand(
                selector,
              )) {
            Ppxlib.Location.raise_errorf(
              ~loc=
                Styled_ppx_css_parser.Parser_location.adjust_to_file(
                  ~relative_loc=selector_loc,
                  ~base_loc,
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
     (var_name, path, var_type) to all_dynamic_vars.

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
           Css_transform.transform_rule(
             ~file,
             ~scope,
             ~opens,
             ~base_loc,
             ~var_namespace,
             rule,
             all_dynamic_vars,
           );
         let key = Hash_class.global_key(render_rule(transformed));
         Buffer.add_global_rule(key, render_prefixed_rule(transformed));
       | Declaration(_) => ()
       }
     );

  List.rev(all_dynamic_vars^);
};

let get = () => {
  let rules = Buffer.get_rules();
  Buffer.clear();
  Local_selector_environment.clear();
  rules;
};
