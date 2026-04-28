type var_type =
  | Selector
  | MediaQuery
  | RuntimeModule(string);

/* Per-compilation-unit registry mapping the enclosing `let` binding name of a
   [%cx2] expansion to the list of atomized class names it minted. Selector
   interpolation in later [%cx2] blocks resolves `$(name)` against this
   registry so the literal placeholder never reaches the extracted CSS.

   The registry is keyed on (file_path, binding_name); shadowing is handled by
   last-write-wins via Hashtbl.replace. Anonymous bindings (`let _ = ...`) are
   intentionally not registered. The registry is cleared whenever the
   accumulated CSS buffer is cleared (see `get` at the bottom of this file). */
module Class_registry = {
  let table: Hashtbl.t((string, string), list(string)) = Hashtbl.create(64);

  let register = (~file: string, ~name: string, ~classNames: list(string)) =>
    if (name != "_") {
      Hashtbl.replace(table, (file, name), classNames);
    };

  let lookup = (~file: string, ~name: string): option(list(string)) =>
    Hashtbl.find_opt(table, (file, name));

  let clear = () => Hashtbl.clear(table);
};

module Buffer = {
  type rule = (string, string);
  let accumulated_rules: ref(list(rule)) = ref([]);
  let global_rules: ref(list(rule)) = ref([]);

  let add_rule = (className: string, cssText: string) => {
    let already_exists =
      List.exists(
        ((existingClass, _)) => existingClass == className,
        accumulated_rules^,
      );

    if (!already_exists) {
      accumulated_rules := [(className, cssText), ...accumulated_rules^];
    };
  };

  let add_global_rule = (className: string, cssText: string) => {
    let already_exists =
      List.exists(
        ((existingClass, _)) => existingClass == className,
        global_rules^,
      );

    if (!already_exists) {
      global_rules := [(className, cssText), ...global_rules^];
    };
  };

  let get_rules = () => {
    let globals =
      global_rules^ |> List.rev |> List.map(((_, cssText)) => cssText);
    let rules =
      accumulated_rules^ |> List.rev |> List.map(((_, cssText)) => cssText);
    globals @ rules;
  };

  let clear = () => {
    accumulated_rules := [];
    global_rules := [];
  };
};

module Css_transform = {
  open Styled_ppx_css_parser.Ast;

  let variable_to_css_var_name = (path_str: string) => {
    let hash = Murmur2.default(path_str);
    Printf.sprintf("var-%s", hash);
  };

  let variable_to_css_var_name_for_occurrence =
      (path_str: string, occurrence_index: int, total_occurrences: int) => {
    let var_name = variable_to_css_var_name(path_str);
    total_occurrences > 1
      ? Printf.sprintf("%s_%d", var_name, occurrence_index) : var_name;
  };

  let count_named_occurrences = names =>
    names
    |> List.fold_left(
         (counts, name) => {
           let next_count =
             switch (List.assoc_opt(name, counts)) {
             | Some(count) => count + 1
             | None => 1
             };
           [(name, next_count), ...List.remove_assoc(name, counts)];
         },
         [],
       );

  let next_occurrence = (name, occurrences) => {
    let next_count =
      switch (List.assoc_opt(name, occurrences^)) {
      | Some(count) => count + 1
      | None => 1
      };
    occurrences :=
      [(name, next_count), ...List.remove_assoc(name, occurrences^)];
    next_count;
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

  let generate_class_from_content = (~label=?, content: string): string => {
    let hash = Murmur2.default(content);
    switch (label) {
    | Some(name) => Printf.sprintf("css-%s-%s", hash, name)
    | None => Printf.sprintf("css-%s", hash)
    };
  };

  /* Resolve a `$(name)` selector interpolation against the per-file
     [%cx2] class registry. Same-module references substitute the resolved
     class names directly into the CSS AST so no literal `$(...)` ever
     reaches the extracted CSS, and no phantom CSS custom property is
     emitted onto the runtime tuple. Cross-module and unresolved refs raise
     a clear PPX error. */
  let resolve_selector_class_ref = (~file: string, ~loc, path_str: string) => {
    if (String.contains(path_str, '.')) {
      Ppxlib.Location.raise_errorf(
        ~loc,
        "[%%cx2] selector interpolation `$(%s)` references another module.\nStatic CSS extraction can only resolve same-module bindings.\nInline the rules into this [%%cx2] block, or use [%%cx] for runtime substitution.",
        path_str,
      );
    } else {
      switch (Class_registry.lookup(~file, ~name=path_str)) {
      | Some(classNames) => classNames
      | None =>
        Ppxlib.Location.raise_errorf(
          ~loc,
          "[%%cx2] selector interpolation `$(%s)` does not refer to a [%%cx2] binding earlier in this module.\n- If `%s` is bound to a [%%cx2] later in the file, reorder the bindings.\n- If `%s` is a plain string, inline the class name literally.\n- Otherwise, use [%%cx] for runtime substitution.",
          path_str,
          path_str,
          path_str,
        )
      };
    };
  };

  let rec transform_component_value =
          (
            ~file: string,
            cv: component_value,
            dynamic_vars: ref(list((string, string, var_type))),
            get_var_binding: string => (string, var_type),
          )
          : component_value => {
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
    | Function({ name, kind, body }) =>
      let (body_values, body_loc) = body;
      let transformed_body =
        List.map(
          ((value, loc)) =>
            (
              transform_component_value(
                ~file,
                value,
                dynamic_vars,
                get_var_binding,
              ),
              loc,
            ),
          body_values,
        );
      Function({
        name,
        kind,
        body: (transformed_body, body_loc),
      });
    | Paren_block(values) =>
      let transformed =
        List.map(
          ((value, loc)) =>
            (
              transform_component_value(
                ~file,
                value,
                dynamic_vars,
                get_var_binding,
              ),
              loc,
            ),
          values,
        );
      Paren_block(transformed);
    | Bracket_block(values) =>
      let transformed =
        List.map(
          ((value, loc)) =>
            (
              transform_component_value(
                ~file,
                value,
                dynamic_vars,
                get_var_binding,
              ),
              loc,
            ),
          values,
        );
      Bracket_block(transformed);
    | Selector(selector_list) =>
      let transformed_selectors =
        List.map(
          ((sel, loc)) => (transform_selector(~file, sel, dynamic_vars), loc),
          selector_list,
        );
      Selector(transformed_selectors);
    | _ => cv
    };
  }

  and transform_selector = (~file, sel: selector, dynamic_vars) => {
    switch (sel) {
    | SimpleSelector(simple) =>
      transform_simple_selector_to_selector(~file, simple, dynamic_vars)
    | ComplexSelector(complex) =>
      ComplexSelector(transform_complex_selector(~file, complex, dynamic_vars))
    | CompoundSelector(compound) =>
      CompoundSelector(
        transform_compound_selector(~file, compound, dynamic_vars),
      )
    | RelativeSelector(relative) =>
      RelativeSelector({
        ...relative,
        complex_selector:
          transform_complex_selector(
            ~file,
            relative.complex_selector,
            dynamic_vars,
          ),
      })
    };
  }

  and transform_complex_selector =
      (~file, complex: complex_selector, dynamic_vars) => {
    switch (complex) {
    | Selector(sel) => Selector(transform_selector(~file, sel, dynamic_vars))
    | Combinator({ left, right }) =>
      Combinator({
        left: transform_selector(~file, left, dynamic_vars),
        right:
          List.map(
            ((combinator, sel)) =>
              (combinator, transform_selector(~file, sel, dynamic_vars)),
            right,
          ),
      })
    };
  }

  /* Resolve `ClassVariable(name)` (i.e. `.$(name)`) by replacing it with
     the chain of `Class(c)` subclass selectors corresponding to the
     classNames the referenced [%cx2] binding minted. Multi-declaration
     bindings expand to a compound chain (`&.cssA.cssB`) which matches the
     "AND" semantics: every consumer of the referenced binding has all of
     its atomized classes applied to the same element. */
  and transform_compound_selector =
      (~file, compound: compound_selector, dynamic_vars) => {
    let transformed_type_selector =
      Option.map(
        simple => transform_simple_selector(~file, simple, dynamic_vars),
        compound.type_selector,
      );
    let transformed_subclasses =
      compound.subclass_selectors
      |> List.concat_map(subclass =>
           transform_subclass_selector_to_list(
             ~file,
             subclass,
             dynamic_vars,
           )
         );
    let transformed_pseudos =
      compound.pseudo_selectors
      |> List.map(pseudo => transform_pseudo_selector(~file, pseudo, dynamic_vars));
    {
      type_selector: transformed_type_selector,
      subclass_selectors: transformed_subclasses,
      pseudo_selectors: transformed_pseudos,
    };
  }

  /* In-place rewrite of a `simple_selector` for use inside a compound. */
  and transform_simple_selector =
      (~file, simple: simple_selector, _dynamic_vars): simple_selector => {
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
        resolve_selector_class_ref(~file, ~loc=var_loc, path_str);
      switch (resolved) {
      | [single] => Type("." ++ single)
      | _ =>
        Ppxlib.Location.raise_errorf(
          ~loc=var_loc,
          "[%%cx2] bare `$(%s)` selector interpolation expanded to %d class names; this position only accepts a single class. Prefix with `.` to use a class chain instead: `.$(%s)`.",
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
      (~file, simple: simple_selector, dynamic_vars): selector => {
    switch (simple) {
    | Variable(_, _) =>
      SimpleSelector(transform_simple_selector(~file, simple, dynamic_vars))
    | _ => SimpleSelector(simple)
    };
  }

  /* `transform_subclass_selector_to_list` returns a *list* of subclass
     selectors so `ClassVariable` can fan out into a compound chain
     (`.cssA.cssB`) for multi-declaration source bindings. */
  and transform_subclass_selector_to_list =
      (~file, subclass: subclass_selector, dynamic_vars)
      : list(subclass_selector) => {
    switch (subclass) {
    | ClassVariable(path_str, var_loc) =>
      let classNames =
        resolve_selector_class_ref(~file, ~loc=var_loc, path_str);
      List.map(c => Class(c), classNames);
    | Pseudo_class(pseudo) => [
        Pseudo_class(transform_pseudo_selector(~file, pseudo, dynamic_vars)),
      ]
    | _ => [subclass]
    };
  }

  /* Pseudo-classes like `:not(...)`, `:is(...)`, `:where(...)`,
     `:has(...)`, `:nth-child(of ...)` etc. carry nested selector lists.
     Recurse into the payload so `:not(&.$(foo))` resolves the same way as
     a top-level `&.$(foo)`. */
  and transform_pseudo_selector =
      (~file, pseudo: pseudo_selector, dynamic_vars): pseudo_selector => {
    switch (pseudo) {
    | Pseudoelement(_) => pseudo
    | Pseudoclass(kind) =>
      Pseudoclass(transform_pseudoclass_kind(~file, kind, dynamic_vars))
    };
  }

  and transform_pseudoclass_kind =
      (~file, kind: pseudoclass_kind, dynamic_vars): pseudoclass_kind => {
    switch (kind) {
    | PseudoIdent(_) => kind
    | Function({ name, payload: (selector_list, payload_loc) }) =>
      let transformed =
        List.map(
          ((sel, sel_loc)) =>
            (transform_selector(~file, sel, dynamic_vars), sel_loc),
          selector_list,
        );
      Function({ name, payload: (transformed, payload_loc) });
    | NthFunction({ name, payload: (nth_payload, payload_loc) }) =>
      let transformed_payload =
        switch (nth_payload) {
        | Nth(_) => nth_payload
        | NthSelector(complex_selectors) =>
          NthSelector(
            List.map(
              c => transform_complex_selector(~file, c, dynamic_vars),
              complex_selectors,
            ),
          )
        };
      NthFunction({ name, payload: (transformed_payload, payload_loc) });
    };
  };

  let transform_declaration = (~file, decl: declaration, dynamic_vars) => {
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
      let css_var_name =
        variable_to_css_var_name_for_occurrence(
          var_name,
          occurrence_index,
          total_occurrences,
        );
      let (type_path, remaining_types) =
        switch (
          take_first_matching_name(var_name, remaining_interpolation_types^)
        ) {
        | (Some(type_path), remaining_types) => (type_path, remaining_types)
        | (None, remaining_types) => ("", remaining_types)
        };
      remaining_interpolation_types := remaining_types;

      let var_type =
        RuntimeModule(
          Property_to_types.resolve_module_name(~type_path, ~property_name),
        );

      (css_var_name, var_type);
    };

    let transformed_values =
      List.map(
        ((cv, loc)) =>
          (
            transform_component_value(
              ~file,
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

  let rec transform_rule = (~file, rule: rule, dynamic_vars) => {
    switch (rule) {
    | Declaration(decl) =>
      Declaration(transform_declaration(~file, decl, dynamic_vars))
    | Style_rule(style_rule) =>
      Style_rule(transform_style_rule(~file, style_rule, dynamic_vars))
    | At_rule(at_rule) =>
      At_rule(transform_at_rule(~file, at_rule, dynamic_vars))
    };
  }

  and transform_style_rule = (~file, style_rule: style_rule, dynamic_vars) => {
    let { prelude, block, loc } = style_rule;
    let (selector_list, selector_loc) = prelude;
    let transformed_selectors =
      List.map(
        ((sel, sel_loc)) =>
          (transform_selector(~file, sel, dynamic_vars), sel_loc),
        selector_list,
      );
    let (rule_list, rule_loc) = block;
    let transformed_rules =
      List.map(rule => transform_rule(~file, rule, dynamic_vars), rule_list);
    {
      prelude: (transformed_selectors, selector_loc),
      block: (transformed_rules, rule_loc),
      loc,
    };
  }

  and transform_at_rule = (~file, at_rule: at_rule, dynamic_vars) => {
    let { name, prelude, block, loc } = at_rule;
    let (prelude_values, prelude_loc) = prelude;

    let has_interpolation =
      List.exists(
        ((cv, _cv_loc)) =>
          switch ((cv: component_value)) {
          | Variable(_, _) => true
          | _ => false
          },
        prelude_values,
      );

    if (has_interpolation) {
      let (at_name, _) = name;
      Ppxlib.Location.raise_errorf(
        ~loc,
        "[%%%%cx2] does not support interpolation in @%s preludes. CSS custom properties (var()) are not valid in media query conditions. Inline the value directly or use [%%%%cx] for runtime media query interpolation.",
        at_name,
      );
    };

    let transformed_prelude = prelude_values;
    let transformed_block =
      switch (block) {
      | Empty => Empty
      | Rule_list((rule_list, rule_loc)) =>
        let transformed_rules =
          List.map(
            rule => transform_rule(~file, rule, dynamic_vars),
            rule_list,
          );
        Rule_list((transformed_rules, rule_loc));
      | Stylesheet((rule_list, rule_loc)) =>
        let transformed_rules =
          List.map(
            rule => transform_rule(~file, rule, dynamic_vars),
            rule_list,
          );
        Stylesheet((transformed_rules, rule_loc));
      };
    {
      name,
      prelude: (transformed_prelude, prelude_loc),
      block: transformed_block,
      loc,
    };
  }
  and transform_variables_to_custom_properties =
      (
        ~file,
        rules: list(rule),
        dynamic_vars: ref(list((string, string, var_type))),
      ) => {
    List.map(r => transform_rule(~file, r, dynamic_vars), rules);
  };

  let render_rule = Styled_ppx_css_parser.Render.rule;
  let render_declaration = Styled_ppx_css_parser.Render.declaration;

  let atomize_rules = (~label=?, rules: list(rule)): list((string, rule)) => {
    let rec extract_atomic_rules = (rule: rule): list((string, rule)) => {
      switch (rule) {
      | Declaration(decl) =>
        let decl_string = render_declaration(decl);
        let className = generate_class_from_content(~label?, decl_string);
        [(className, Declaration(decl))];

      | Style_rule({ prelude, block: (rules, _), loc: _ }) =>
        rules
        |> List.concat_map(r => {
             switch (r) {
             | Declaration(decl) =>
               let style_rule =
                 Style_rule({
                   prelude,
                   block: ([Declaration(decl)], Ppxlib.Location.none),
                   loc: Ppxlib.Location.none,
                 });
               let rule_string = render_rule(style_rule);
               let className = generate_class_from_content(~label?, rule_string);
               [(className, style_rule)];
             | Style_rule(_) as nested => extract_atomic_rules(nested)
             | _ => extract_atomic_rules(r)
             }
           })

      | At_rule({ name, prelude, block, loc }) =>
        switch (block) {
        | Empty =>
          let at_string = render_rule(rule);
          let className = generate_class_from_content(~label?, at_string);
          [(className, rule)];

        | Rule_list((rules, rule_loc)) =>
          rules
          |> List.concat_map(extract_atomic_rules)
          |> List.map(((_className, inner_rule)) => {
               let wrapped =
                 At_rule({
                   name,
                   prelude,
                   block: Rule_list(([inner_rule], rule_loc)),
                   loc,
                 });
               let wrapped_string = render_rule(wrapped);
               let new_className =
                 generate_class_from_content(~label?, wrapped_string);
               (new_className, wrapped);
             })

        | Stylesheet((rules, rule_loc)) =>
          rules
          |> List.concat_map(extract_atomic_rules)
          |> List.map(((_className, inner_rule)) => {
               let wrapped =
                 At_rule({
                   name,
                   prelude,
                   block: Rule_list(([inner_rule], rule_loc)),
                   loc,
                 });
               let wrapped_string = render_rule(wrapped);
               let new_className =
                 generate_class_from_content(~label?, wrapped_string);
               (new_className, wrapped);
             })
        }
      };
    };

    List.concat_map(extract_atomic_rules, rules);
  };

  let transform_rule_list = (~file, ~label=?, rule_list: rule_list) => {
    let dynamic_vars = ref([]);
    let (rules, loc) = rule_list;

    let atomic_rules = atomize_rules(~label?, rules);

    let processed_rules =
      atomic_rules
      |> List.map(((className, rule)) => {
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
                           subclass_selectors: [Class(className)],
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
                 ~className,
                 single_rule_list,
               )
             };

           let final_rules =
             transform_variables_to_custom_properties(
               ~file,
               transformed,
               dynamic_vars,
             );

           List.map(r => (className, r), final_rules);
         })
      |> List.concat;

    (processed_rules, List.rev(dynamic_vars^));
  };
};

let push = (~file, ~label=?, declarations: Styled_ppx_css_parser.Ast.rule_list) => {
  let render_rule = Styled_ppx_css_parser.Render.rule;

  let (atomic_classnames, dynamic_vars) =
    Css_transform.transform_rule_list(~file, ~label?, declarations);

  let classNames =
    atomic_classnames
    |> List.map(((className, rule)) => {
         let rendered_css = render_rule(rule);
         Buffer.add_rule(className, rendered_css);
         className;
       });

  (classNames, dynamic_vars);
};

let push_keyframe = (keyframe_rules: Styled_ppx_css_parser.Ast.rule_list) => {
  open Styled_ppx_css_parser.Ast;

  let render_rule = Styled_ppx_css_parser.Render.rule;

  let (rules, _) = keyframe_rules;
  let rendered_body =
    rules
    |> List.map(Styled_ppx_css_parser.Render.rule)
    |> String.concat(" ");

  let keyframe_name =
    Printf.sprintf("keyframe-%s", Murmur2.default(rendered_body));

  let at_rule: at_rule = {
    name: ("keyframes", Ppxlib.Location.none),
    prelude: (
      [(Ident(keyframe_name), Ppxlib.Location.none)],
      Ppxlib.Location.none,
    ),
    block: Rule_list(keyframe_rules),
    loc: Ppxlib.Location.none,
  };

  let rendered_keyframe = render_rule(At_rule(at_rule));

  Buffer.add_rule(keyframe_name, rendered_keyframe);

  keyframe_name;
};

let push_global = (global_rules: Styled_ppx_css_parser.Ast.rule_list) => {
  open Styled_ppx_css_parser.Ast;

  let render_rule = Styled_ppx_css_parser.Render.rule;

  let (rules, _) = global_rules;

  rules
  |> List.iter(rule => {
       switch (rule) {
       | Style_rule(_)
       | At_rule(_) =>
         let rendered = render_rule(rule);
         let key = Printf.sprintf("global-%s", Murmur2.default(rendered));
         Buffer.add_global_rule(key, rendered);
       | Declaration(_) => ()
       }
     });
};

let get = () => {
  let rules = Buffer.get_rules();
  Buffer.clear();
  Class_registry.clear();
  rules;
};
