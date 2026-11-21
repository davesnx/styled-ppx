type var_type =
  | Selector
  | MediaQuery
  | CustomProperty
  | RuntimeModule(string);

type dynamic_var = {
  name: string,
  path: string,
  var_type,
  loc: Ppxlib.Location.t,
};

let render_rule = Styled_ppx_css_parser.Render.rule;
let render_prefixed_rule = Css_autoprefixer.render_rule;
let render_declaration = Styled_ppx_css_parser.Render.declaration;

module Buffer = {
  type rule = (string, string);
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

  let var_type_key = (var_type: var_type) =>
    switch (var_type) {
    | Selector => "selector"
    | MediaQuery => "media-query"
    | CustomProperty => "custom-property"
    | RuntimeModule(name) => "runtime:" ++ name
    };

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

  let declaration_has_value_interpolation = (decl: declaration) =>
    component_value_list_has_interpolation(fst(decl.value));

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

  let atom_has_value_interpolation = (rule: rule): bool =>
    switch (atom_declaration(rule)) {
    | Some(decl) => declaration_has_value_interpolation(decl)
    | None => false
    };

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
      |> List.concat_map(subclass =>
           transform_subclass_selector_to_list(ctx, subclass)
         );
    let transformed_pseudos =
      compound.pseudo_selectors
      |> List.map(pseudo => transform_pseudo_selector(ctx, pseudo));
    {
      type_selector: transformed_type_selector,
      subclass_selectors: transformed_subclasses,
      pseudo_selectors: transformed_pseudos,
    };
  }

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
      switch (resolved) {
      | [single] => Subclass(Class(single))
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

  and transform_simple_selector_to_selector =
      (ctx, simple: simple_selector): selector => {
    switch (simple) {
    | Variable(_, _) =>
      SimpleSelector(transform_simple_selector(ctx, simple))
    | _ => SimpleSelector(simple)
    };
  }

  and transform_subclass_selector_to_list =
      (ctx, subclass: subclass_selector): list(subclass_selector) => {
    switch (subclass) {
    | ClassVariable(path_str, var_loc) =>
      let classNames =
        Local_selector_environment.resolve_selector_class_ref(
          ~file=ctx.file,
          ~scope=ctx.scope,
          ~opens=ctx.opens,
          ~loc=to_file_loc(ctx, var_loc),
          path_str,
        );
      List.map(c => Class(c), classNames);
    | Pseudo_class(pseudo) => [
        Pseudo_class(transform_pseudo_selector(ctx, pseudo)),
      ]
    | _ => [subclass]
    };
  }

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

  type block_item =
    | Declaration_group(list(declaration))
    | Nested_rule(rule);

  let declaration_group_key = ({ name: (name, _), _ }: declaration) =>
    if (String.length(name) >= 2 && String.sub(name, 0, 2) == "--") {
      name;
    } else {
      String.lowercase_ascii(name);
    };

  let group_declarations_by_property = (rules: list(rule)): list(block_item) => {
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
      (~source_position_start, ~label=?, rules: list(rule))
      : list((string, string, rule)) => {
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
              Hash_class.class_and_namespace(~label?, rule_string);
            (className, namespace, style_rule);
          },
          parent_selectors,
        );
      };
    };

    let rec extract_atomic_rules_from_block =
            (~parent_prelude=?, rules: list(rule))
            : list((string, string, rule)) =>
      rules
      |> group_declarations_by_property
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
        ~label=?,
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

    let atomic_rules = atomize_rules(~source_position_start, ~label?, rules);

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
        Some(
          Hash_class.class_and_namespace(~label?, String.concat("", seeds)),
        )
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
                None,
              )
            | _ => (className, var_namespace, Some(className))
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
    let dynamic_vars_final = List.rev(ctx.dynamic_vars^);

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

let mint_empty_class = (~main_module, ~scope, ~binding_name, ~label) =>
  switch (binding_name) {
  | Some(name) when name != "_" => [
      Hash_class.marker_class(
        ~label?,
        ~module_name=main_module,
        ~scope,
        name,
      ),
    ]
  | _ => []
  };

let push =
    (
      ~file,
      ~main_module,
      ~scope: list(string),
      ~opens: list(list(string)),
      ~source_position_start,
      ~binding_name=?,
      ~label=?,
      declarations: Styled_ppx_css_parser.Ast.rule_list,
    ) => {
  let (shipped_rules, binding_classes, dynamic_vars, safe_inherits_false_vars) =
    Css_transform.transform_rule_list(
      ~file,
      ~scope,
      ~opens,
      ~source_position_start,
      ~label?,
      declarations,
    );

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
    | [] => mint_empty_class(~main_module, ~scope, ~binding_name, ~label)
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

  let flattened_rules =
    Styled_ppx_css_parser.Resolve.resolve_selectors(rules);
  let var_namespace =
    Hash_class.scoped_namespace(
      ~kind="global",
      ~module_name=main_module,
      ~scope,
      ~rendered_rules=List.map(render_rule, flattened_rules),
    );

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
  rules;
};
