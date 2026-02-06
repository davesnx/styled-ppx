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

    global_rules^
    |> List.rev
    |> List.iter(((_, cssText)) => {
         Buffer.add_string(buffer, cssText);
         Buffer.add_string(buffer, "\n");
       });

    accumulated_rules^
    |> List.rev
    |> List.iter(((_, cssText)) => {
         Buffer.add_string(buffer, cssText);
         Buffer.add_string(buffer, "\n");
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

  let generate_class_from_content = (content: string): string => {
    Printf.sprintf("css-%s", Murmur2.default(content));
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

      | Style_rule({prelude, block: (rules, _), loc: _}) =>
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

      | At_rule({name, prelude, block, loc}) =>
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

           List.map(r => (className, r), transformed);
         })
      |> List.concat;

    processed_rules;
  };
};

let push = (declarations: Styled_ppx_css_parser.Ast.rule_list) => {
  let render_rule = Styled_ppx_css_parser.Render.rule;

  let atomic_classnames =
    Css_transform.transform_rule_list(declarations);

  let classNames =
    atomic_classnames
    |> List.map(((className, rule)) => {
         let rendered_css = render_rule(rule);
         Buffer.add_rule(className, rendered_css);
         className;
       });

  classNames;
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
