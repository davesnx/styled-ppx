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
  type target = {
    mutable rules: list(rule),
    seen: Hashtbl.t(string, int),
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
      Hashtbl.add(target.seen, className, Hashtbl.length(target.seen));
      target.rules = [(className, cssText), ...target.rules];
    };

  let block_classes: ref(list((string, int, string, Ppxlib.Location.t))) =
    ref([]);
  let rule_index = className =>
    Hashtbl.find(accumulated_rules.seen, className);
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
    block_classes := [];
  };
};

let self_placeholder_char = '\001';
let self_placeholder = String.make(1, self_placeholder_char);

module Css_transform = {
  open Styled_ppx_css_parser.Ast;

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

  let rec rule_is_ampersand_local = (rule: rule): bool =>
    switch (rule) {
    | Declaration(_) => true
    | Style_rule({ prelude: (selectors, _), block: (rules, _), _ }) =>
      List.for_all(
        ((sel, _loc)) => selector_subject_is_ampersand(sel),
        selectors,
      )
      && List.for_all(rule_is_ampersand_local, rules)
    | At_rule({ block, _ }) =>
      switch (block) {
      | Rule_list((rules, _))
      | Stylesheet((rules, _)) =>
        List.for_all(rule_is_ampersand_local, rules)
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
    || c == '-'
    || c == self_placeholder_char;

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
      Subclass(
        Class(
          Local_selector_environment.resolve_selector_class_ref(
            ~file=ctx.file,
            ~scope=ctx.scope,
            ~opens=ctx.opens,
            ~loc=var_loc,
            path_str,
          ),
        ),
      );
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
      let loc = to_file_loc(ctx, var_loc);
      Class(
        Local_selector_environment.resolve_selector_class_ref(
          ~file=ctx.file,
          ~scope=ctx.scope,
          ~opens=ctx.opens,
          ~loc,
          path_str,
        ),
      );
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

  let transform_declaration = (ctx, ~name_var, decl: declaration) => {
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
        name_var(
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

  let rec transform_rule = (ctx, ~name_var, rule: rule) => {
    switch (rule) {
    | Declaration(decl) =>
      Declaration(transform_declaration(ctx, ~name_var, decl))
    | Style_rule(style_rule) =>
      Style_rule(transform_style_rule(ctx, ~name_var, style_rule))
    | At_rule(at_rule) =>
      At_rule(transform_at_rule(ctx, ~name_var, at_rule))
    };
  }

  and transform_style_rule = (ctx, ~name_var, style_rule: style_rule) => {
    let { prelude, block, loc } = style_rule;
    let (selector_list, selector_loc) = prelude;
    let transformed_selectors =
      List.map(
        ((sel, sel_loc)) => (transform_selector(ctx, sel), sel_loc),
        selector_list,
      );
    let (rule_list, rule_loc) = block;
    let transformed_rules =
      List.map(rule => transform_rule(ctx, ~name_var, rule), rule_list);
    {
      prelude: (transformed_selectors, selector_loc),
      block: (transformed_rules, rule_loc),
      loc,
    };
  }

  and transform_at_rule = (ctx, ~name_var, at_rule: at_rule) => {
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
      List.map(r => transform_rule(ctx, ~name_var, r), rules),
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
     intent at the top of a block: `.X :hover` matches
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

  let merge_preludes = (~parent, ~child) =>
    List.concat_map(
      ((parent_sel, _)) =>
        List.map(
          ((child_sel, child_loc)) =>
            (
              Styled_ppx_css_parser.Selector_nesting.compute_new_prefix(
                ~prefix=Some(parent_sel),
                child_sel,
              ),
              child_loc,
            ),
          child,
        ),
      parent,
    );

  let rec validate_rule = (~source_position_start, ~parent_prelude=?, rule) =>
    switch (rule) {
    | Declaration(decl) =>
      switch (parent_prelude) {
      | Some(parents) when declaration_has_value_interpolation(decl) =>
        List.iter(
          ((sel, loc)) =>
            if (Styled_ppx_css_parser.Selector_nesting.subject_escapes_ampersand_subtree(
                  sel,
                )) {
              raise_subtree_escaping_interpolation_error(
                ~loc,
                ~source_position_start,
                ~property=fst(decl.name),
                sel,
              );
            },
          parents,
        )
      | _ => ()
      }
    | Style_rule({ prelude: (child, _), block: (rules, _), _ }) =>
      List.iter(
        ((sel, loc)) =>
          if (is_bare_leading_pseudo(sel)) {
            raise_bare_leading_pseudo_error(
              ~loc,
              ~source_position_start,
              sel,
            );
          },
        child,
      );
      let parent_prelude =
        switch (parent_prelude) {
        | None => child
        | Some(parent) => merge_preludes(~parent, ~child)
        };
      List.iter(
        validate_rule(~source_position_start, ~parent_prelude),
        rules,
      );
    | At_rule({ name: (name, name_loc), block, _ }) =>
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
      switch (String.lowercase_ascii(name), block) {
      | ("keyframes", _) =>
        raise_at_rule_error(
          "@keyframes should be defined with %keyframe(...)",
        )
      | ("media" | "supports" | "container" | "starting-style", Empty) =>
        raise_at_rule_error(
          Printf.sprintf(
            "At-rule @%s requires a block (`@%s ... { ... }`)",
            name,
            name,
          ),
        )
      | (
          "media" | "supports" | "container" | "starting-style",
          Rule_list((rules, _)) | Stylesheet((rules, _)),
        ) =>
        List.iter(
          validate_rule(~source_position_start, ~parent_prelude?),
          rules,
        )
      | _ =>
        raise_at_rule_error(
          Printf.sprintf("At-rule @%s is not supported in styled-ppx", name),
        )
      };
    };

  let rec declarations = rule =>
    switch (rule) {
    | Declaration(decl) => [decl]
    | At_rule({ block: Empty, _ }) => []
    | Style_rule({ block: (rules, _), _ })
    | At_rule({ block: Rule_list((rules, _)) | Stylesheet((rules, _)), _ }) =>
      List.concat_map(declarations, rules)
    };

  let transform_rule_list =
      (
        ~file,
        ~scope,
        ~opens,
        ~source_position_start,
        ~class_name,
        ~name_var,
        (rules, _) as rule_list: rule_list,
      ) => {
    let ctx = {
      file,
      scope,
      opens,
      source_position_start,
      dynamic_vars: ref([]),
    };
    List.iter(validate_rule(~source_position_start), rules);
    let shipped =
      Styled_ppx_css_parser.Transform.run(~className=class_name, rule_list)
      |> List.map(transform_rule(ctx, ~name_var));
    let dynamic_vars = List.rev(ctx.dynamic_vars^);
    let scratch = {
      ...ctx,
      dynamic_vars: ref([]),
    };
    let rule_infos =
      List.map(
        rule =>
          (
            rule_is_ampersand_local(rule),
            declarations(rule)
            |> List.concat_map(decl =>
                 custom_property_names_in_text(
                   render_declaration(
                     transform_declaration(scratch, ~name_var, decl),
                   ),
                 )
               ),
          ),
        rules,
      );
    let safe_inherits_false_vars =
      dynamic_vars
      |> List.filter_map(({ name, var_type, _ }) =>
           var_type_supports_inherits_false(var_type)
           && List.for_all(
                ((local, referenced)) =>
                  local || !List.mem(name, referenced),
                rule_infos,
              )
             ? Some(name) : None
         );
    (shipped, dynamic_vars, safe_inherits_false_vars);
  };
};

let push =
    (
      ~file,
      ~main_module,
      ~scope: list(string),
      ~opens: list(list(string)),
      ~source_position_start,
      ~binding_name=?,
      ~binding_display=?,
      (_, block_loc) as declarations: Styled_ppx_css_parser.Ast.rule_list,
    ) => {
  let (shipped_rules, dynamic_vars, safe_inherits_false_vars) =
    Css_transform.transform_rule_list(
      ~file,
      ~scope,
      ~opens,
      ~source_position_start,
      ~class_name="css-" ++ self_placeholder,
      ~name_var=Hash_class.block_variables(~block_hash=self_placeholder),
      declarations,
    );
  let block_hash =
    Hash_class.block_hash(
      ~module_name=main_module,
      ~scope,
      ~binding=Option.value(binding_name, ~default=""),
      String.concat(
        "\000",
        [
          String.concat("", List.map(render_rule, shipped_rules)),
          ...List.map(
               ({ path, var_type, _ }: dynamic_var) =>
                 path ++ " " ++ Css_transform.var_type_key(var_type),
               dynamic_vars,
             ),
        ],
      ),
    );
  let fill = text =>
    String.concat(
      block_hash,
      String.split_on_char(self_placeholder_char, text),
    );
  let class_name = "css-" ++ block_hash;
  let dynamic_vars =
    List.map(
      (var: dynamic_var) =>
        {
          ...var,
          name: fill(var.name),
        },
      dynamic_vars,
    );
  let safe_inherits_false_vars = List.map(fill, safe_inherits_false_vars);
  let block_css =
    fill(String.concat("", List.map(render_prefixed_rule, shipped_rules)));
  if (block_css != "") {
    Buffer.add_rule(block_css, block_css);
    Buffer.block_classes :=
      [
        (
          class_name,
          Buffer.rule_index(block_css),
          switch (
            Option.fold(
              ~none=binding_name,
              ~some=Option.some,
              binding_display,
            )
          ) {
          | Some(name) when name != "_" =>
            String.concat(".", [main_module, ...scope] @ [name])
          | _ => ""
          },
          Styled_ppx_css_parser.Parser_location.to_file_location(
            ~source_position_start,
            block_loc,
          ),
        ),
        ...Buffer.block_classes^,
      ];
  };
  List.iter(
    var_name =>
      Buffer.add_global_rule(
        "@property --" ++ var_name,
        "@property --" ++ var_name ++ "{syntax:\"*\";inherits:false;}",
      ),
    safe_inherits_false_vars,
  );
  let classNames =
    switch (block_css, binding_name) {
    | ("", Some(name)) when name != "_" => [
        Hash_class.marker_class(~module_name=main_module, ~scope, name),
      ]
    | ("", _) => []
    | _ => [class_name]
    };
  (classNames, dynamic_vars);
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
         Css_transform.transform_rule(
           ctx,
           ~name_var=
             Hash_class.variable_for_occurrence(~namespace=var_namespace),
           rule,
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
           Css_transform.transform_rule(
             ctx,
             ~name_var=
               Hash_class.variable_for_occurrence(~namespace=var_namespace),
             rule,
           );
         let key = Hash_class.global_key(render_rule(transformed));
         Buffer.add_global_rule(key, render_prefixed_rule(transformed));
       | Declaration(_) => ()
       }
     );

  List.rev(ctx.dynamic_vars^);
};

let get = () => {
  let rules = Buffer.get_rules();
  let offset = Hashtbl.length(Buffer.global_rules.seen);
  let seen = Hashtbl.create(64);
  let classes =
    List.rev(Buffer.block_classes^)
    |> List.filter_map(((class_name, index, binding, loc)) =>
         if (Hashtbl.mem(seen, index)) {
           None;
         } else {
           Hashtbl.add(seen, index, ());
           Some(
             Css_extraction.class_entry(
               ~class_name,
               ~rule_index=offset + index,
               ~binding,
               loc,
             ),
           );
         }
       );
  Buffer.clear();
  Local_selector_environment.clear();
  (rules, classes);
};
