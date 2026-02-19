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

  let get_all_css = () => {
    let buffer = Buffer.create(1024);
    let separator = Settings.Get.minify() ? "" : "\n";

    global_rules^
    |> List.rev
    |> List.iter(((_, cssText)) => {
         Buffer.add_string(buffer, cssText);
         Buffer.add_string(buffer, separator);
       });

    accumulated_rules^
    |> List.rev
    |> List.iter(((_, cssText)) => {
         Buffer.add_string(buffer, cssText);
         Buffer.add_string(buffer, separator);
       });

    Buffer.contents(buffer);
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

  let generate_class_from_content = (content: string): string => {
    Printf.sprintf("css-%s", Murmur2.default(content));
  };

  let rec transform_component_value =
          (
            cv: component_value,
            dynamic_vars: ref(list((string, string, string))),
            property_name: option(string),
            get_type_for_var: string => string,
          )
          : component_value => {
    switch (cv) {
    | Variable(path_str, _loc) =>
      let var_name = variable_to_css_var_name(path_str);

      let type_path = get_type_for_var(path_str);
      if (!List.exists(((vn, _, _)) => vn == var_name, dynamic_vars^)) {
        dynamic_vars := [(var_name, path_str, type_path), ...dynamic_vars^];
      };

      Function(
        ("var", Ppxlib.Location.none),
        (
          [(Ident("--" ++ var_name), Ppxlib.Location.none)],
          Ppxlib.Location.none,
        ),
      );
    | Function(name, body) =>
      let (body_values, body_loc) = body;
      let transformed_body =
        List.map(
          ((value, loc)) =>
            (
              transform_component_value(
                value,
                dynamic_vars,
                property_name,
                get_type_for_var,
              ),
              loc,
            ),
          body_values,
        );
      Function(name, (transformed_body, body_loc));
    | Paren_block(values) =>
      let transformed =
        List.map(
          ((value, loc)) =>
            (
              transform_component_value(
                value,
                dynamic_vars,
                property_name,
                get_type_for_var,
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
                value,
                dynamic_vars,
                property_name,
                get_type_for_var,
              ),
              loc,
            ),
          values,
        );
      Bracket_block(transformed);
    | Selector(selector_list) =>
      let transformed_selectors =
        List.map(
          ((sel, loc)) => (transform_selector(sel, dynamic_vars), loc),
          selector_list,
        );
      Selector(transformed_selectors);
    | _ => cv
    };
  }

  and transform_selector = (sel: selector, dynamic_vars) => {
    switch (sel) {
    | SimpleSelector(Variable(path_str, var_loc)) =>
      let var_name = variable_to_css_var_name(path_str);
      if (!List.exists(((vn, _, _)) => vn == var_name, dynamic_vars^)) {
        dynamic_vars := [(var_name, path_str, "selector"), ...dynamic_vars^];
      };
      SimpleSelector(Variable(path_str, var_loc));
    | SimpleSelector(simple) => SimpleSelector(simple)
    | ComplexSelector(complex) =>
      ComplexSelector(transform_complex_selector(complex, dynamic_vars))
    | CompoundSelector(compound) =>
      CompoundSelector(transform_compound_selector(compound, dynamic_vars))
    | RelativeSelector(relative) =>
      RelativeSelector({
        ...relative,
        complex_selector:
          transform_complex_selector(relative.complex_selector, dynamic_vars),
      })
    };
  }

  and transform_complex_selector = (complex: complex_selector, dynamic_vars) => {
    switch (complex) {
    | Selector(sel) => Selector(transform_selector(sel, dynamic_vars))
    | Combinator({ left, right }) =>
      Combinator({
        left: transform_selector(left, dynamic_vars),
        right:
          List.map(
            ((combinator, sel)) =>
              (combinator, transform_selector(sel, dynamic_vars)),
            right,
          ),
      })
    };
  }

  and transform_compound_selector =
      (compound: compound_selector, dynamic_vars) => {
    {
      ...compound,
      type_selector:
        Option.map(
          simple =>
            switch (transform_simple_selector(simple, dynamic_vars)) {
            | SimpleSelector(s) => s
            | _ => simple
            },
          compound.type_selector,
        ),
      subclass_selectors:
        List.map(
          subclass => transform_subclass_selector(subclass, dynamic_vars),
          compound.subclass_selectors,
        ),
    };
  }

  and transform_simple_selector = (simple: simple_selector, dynamic_vars) => {
    switch (simple) {
    | Variable(path_str, var_loc) =>
      let var_name = variable_to_css_var_name(path_str);
      if (!List.exists(((vn, _, _)) => vn == var_name, dynamic_vars^)) {
        dynamic_vars := [(var_name, path_str, "selector"), ...dynamic_vars^];
      };
      SimpleSelector(Variable(path_str, var_loc));
    | _ => SimpleSelector(simple)
    };
  }

  and transform_subclass_selector =
      (subclass: subclass_selector, dynamic_vars) => {
    switch (subclass) {
    | ClassVariable(path_str, var_loc) =>
      let var_name = variable_to_css_var_name(path_str);
      if (!List.exists(((vn, _, _)) => vn == var_name, dynamic_vars^)) {
        dynamic_vars := [(var_name, path_str, "selector"), ...dynamic_vars^];
      };
      ClassVariable(path_str, var_loc);
    | _ => subclass
    };
  };

  let transform_declaration = (decl: declaration, dynamic_vars) => {
    let (property_name, _) = decl.name;
    let (value_list, value_loc) = decl.value;

    let value_string =
      Styled_ppx_css_parser.Render.component_value_list(value_list);
    let interpolation_types =
      Css_grammar.Parser.get_interpolation_types(
        ~name=property_name,
        value_string,
      );

    let get_type_for_var = var_name => {
      switch (
        List.find_opt(((name, _)) => name == var_name, interpolation_types)
      ) {
      | Some((_, type_path)) when type_path != "" => type_path
      | _ => property_name
      };
    };

    let transformed_values =
      List.map(
        ((cv, loc)) =>
          (
            transform_component_value(
              cv,
              dynamic_vars,
              Some(property_name),
              get_type_for_var,
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

  let rec transform_rule = (rule: rule, dynamic_vars) => {
    switch (rule) {
    | Declaration(decl) =>
      Declaration(transform_declaration(decl, dynamic_vars))
    | Style_rule(style_rule) =>
      Style_rule(transform_style_rule(style_rule, dynamic_vars))
    | At_rule(at_rule) => At_rule(transform_at_rule(at_rule, dynamic_vars))
    };
  }

  and transform_style_rule = (style_rule: style_rule, dynamic_vars) => {
    let { prelude, block, loc } = style_rule;
    let (selector_list, selector_loc) = prelude;
    let transformed_selectors =
      List.map(
        ((sel, sel_loc)) =>
          (transform_selector(sel, dynamic_vars), sel_loc),
        selector_list,
      );
    let (rule_list, rule_loc) = block;
    let transformed_rules =
      List.map(rule => transform_rule(rule, dynamic_vars), rule_list);
    {
      prelude: (transformed_selectors, selector_loc),
      block: (transformed_rules, rule_loc),
      loc,
    };
  }

  and transform_at_rule = (at_rule: at_rule, dynamic_vars) => {
    let { name, prelude, block, loc } = at_rule;
    let (prelude_values, prelude_loc) = prelude;
    let default_type_for_var = _var => "media-query";
    let transformed_prelude =
      List.map(
        ((cv, cv_loc)) =>
          (
            transform_component_value(
              cv,
              dynamic_vars,
              None,
              default_type_for_var,
            ),
            cv_loc,
          ),
        prelude_values,
      );
    let transformed_block =
      switch (block) {
      | Empty => Empty
      | Rule_list((rule_list, rule_loc)) =>
        let transformed_rules =
          List.map(rule => transform_rule(rule, dynamic_vars), rule_list);
        Rule_list((transformed_rules, rule_loc));
      | Stylesheet((rule_list, rule_loc)) =>
        let transformed_rules =
          List.map(rule => transform_rule(rule, dynamic_vars), rule_list);
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
        rules: list(rule),
        dynamic_vars: ref(list((string, string, string))),
      ) => {
    List.map(r => transform_rule(r, dynamic_vars), rules);
  };

  let render_rule = Styled_ppx_css_parser.Render.rule;
  let render_declaration = Styled_ppx_css_parser.Render.declaration;

  let atomize_rules = (rules: list(rule)): list((string, rule)) => {
    let rec extract_atomic_rules = (rule: rule): list((string, rule)) => {
      switch (rule) {
      | Declaration(decl) =>
        let decl_string = render_declaration(decl);
        let className = generate_class_from_content(decl_string);
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
               let className = generate_class_from_content(rule_string);
               [(className, style_rule)];
             | Style_rule(_) as nested => extract_atomic_rules(nested)
             | _ => extract_atomic_rules(r)
             }
           })

      | At_rule({ name, prelude, block, loc }) =>
        switch (block) {
        | Empty =>
          let at_string = render_rule(rule);
          let className = generate_class_from_content(at_string);
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
                 generate_class_from_content(wrapped_string);
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
                 generate_class_from_content(wrapped_string);
               (new_className, wrapped);
             })
        }
      };
    };

    List.concat_map(extract_atomic_rules, rules);
  };

  let transform_rule_list = (rule_list: rule_list) => {
    let dynamic_vars = ref([]);
    let (rules, loc) = rule_list;

    let atomic_rules = atomize_rules(rules);

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
               transformed,
               dynamic_vars,
             );

           List.map(r => (className, r), final_rules);
         })
      |> List.concat;

    (processed_rules, List.rev(dynamic_vars^));
  };
};

let push = (declarations: Styled_ppx_css_parser.Ast.rule_list) => {
  let render_rule = Styled_ppx_css_parser.Render.rule;

  let (atomic_classnames, dynamic_vars) =
    Css_transform.transform_rule_list(declarations);

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
  let css_content = Buffer.get_all_css();
  Buffer.clear();
  css_content;
};
