module Buffer = {
  /* In-memory accumulator for CSS rules during compilation.
     Each rule is stored as (className, cssText) to ensure uniqueness by className. */
  type rule = (string, string);
  let accumulated_rules: ref(list(rule)) = ref([]);

  let add_rule = (className: string, cssText: string) => {
    /* Only add if this className hasn't been processed yet */
    let already_exists =
      List.exists(
        ((existingClass, _)) => existingClass == className,
        accumulated_rules^,
      );

    if (!already_exists) {
      accumulated_rules := [(className, cssText), ...accumulated_rules^];
    };
  };

  let get_all_css = () => {
    let buffer = Buffer.create(1024);

    /* Reverse to maintain order of addition, then concatenate all CSS */
    accumulated_rules^
    |> List.rev
    |> List.iter(((_, cssText)) => {
         Buffer.add_string(buffer, cssText);
         Buffer.add_char(buffer, '\n');
       });

    Buffer.contents(buffer);
  };

  let clear = () => {
    accumulated_rules := [];
  };
};

module Css_transform = {
  open Styled_ppx_css_parser.Ast;

  let variable_to_css_var_name = (path: list(string)) => {
    path
    |> String.concat("-")
    |> String.lowercase_ascii
    |> String.map(c =>
         if (c == '.') {
           '-';
         } else {
           c;
         }
       );
  };

  /* Transform component values, replacing Variables with CSS custom properties */
  let rec transform_component_value =
          (
            cv: component_value,
            dynamic_vars: ref(list((string, string, string))),
            property_name: option(string),
          )
          : component_value => {
    switch (cv) {
    | Variable(path) =>
      let var_name = variable_to_css_var_name(path);
      let original_path = String.concat(".", path);

      let property = Option.value(property_name, ~default="");
      if (!List.exists(((vn, _, _)) => vn == var_name, dynamic_vars^)) {
        dynamic_vars :=
          [(var_name, original_path, property), ...dynamic_vars^];
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
              transform_component_value(value, dynamic_vars, property_name),
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
              transform_component_value(value, dynamic_vars, property_name),
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
              transform_component_value(value, dynamic_vars, property_name),
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
    | SimpleSelector(Variable(path)) =>
      /* Transform selector variable to CSS var */
      let var_name = variable_to_css_var_name(path);
      let original_path = String.concat(".", path);
      if (!List.exists(((vn, _, _)) => vn == var_name, dynamic_vars^)) {
        dynamic_vars := [(var_name, original_path, ""), ...dynamic_vars^];
      };
      /* Return as-is for now, will need special handling in render */
      SimpleSelector(Variable(path));
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
    | Combinator({left, right}) =>
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
    | Variable(path) =>
      let var_name = variable_to_css_var_name(path);
      let original_path = String.concat(".", path);
      if (!List.exists(((vn, _, _)) => vn == var_name, dynamic_vars^)) {
        dynamic_vars := [(var_name, original_path, ""), ...dynamic_vars^];
      };
      SimpleSelector(Variable(path));
    | _ => SimpleSelector(simple)
    };
  }

  and transform_subclass_selector =
      (subclass: subclass_selector, dynamic_vars) => {
    switch (subclass) {
    | ClassVariable(path) =>
      let var_name = variable_to_css_var_name(path);
      let original_path = String.concat(".", path);
      if (!List.exists(((vn, _, _)) => vn == var_name, dynamic_vars^)) {
        dynamic_vars := [(var_name, original_path, ""), ...dynamic_vars^];
      };
      ClassVariable(path);
    | _ => subclass
    };
  };

  let transform_declaration = (decl: declaration, dynamic_vars) => {
    let (property_name, _) = decl.name;
    let (value_list, value_loc) = decl.value;
    let transformed_values =
      List.map(
        ((cv, loc)) =>
          (
            transform_component_value(cv, dynamic_vars, Some(property_name)),
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
    let {prelude, block, loc} = style_rule;
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
    let {name, prelude, block, loc} = at_rule;
    let (prelude_values, prelude_loc) = prelude;
    let transformed_prelude =
      List.map(
        ((cv, cv_loc)) =>
          (transform_component_value(cv, dynamic_vars, None), cv_loc),
        prelude_values,
      );
    let transformed_block =
      switch (block) {
      | Empty => Empty
      | Rule_list((rule_list, rule_loc)) =>
        let transformed_rules =
          List.map(rule => transform_rule(rule, dynamic_vars), rule_list);
        Rule_list((transformed_rules, rule_loc));
      };
    {
      name,
      prelude: (transformed_prelude, prelude_loc),
      block: transformed_block,
      loc,
    };
  };

  let transform_rule_list = (~className, rule_list: rule_list) => {
    let dynamic_vars = ref([]);

    /* Transform.run now returns properly wrapped rules, no bare declarations */
    let unnested_rules =
      Styled_ppx_css_parser.Transform.run(~className, rule_list);

    /* Transform variables to CSS custom properties */
    let transformed_rules =
      List.map(rule => transform_rule(rule, dynamic_vars), unnested_rules);

    let (_rules, rule_loc) = rule_list;
    let transformed_declarations = (transformed_rules, rule_loc);
    (transformed_declarations, List.rev(dynamic_vars^));
  };
};

module File = {
  type write_result =
    | Unchanged
    | Updated
    | Created;

  let read_safe = filename =>
    try({
      let ic = open_in(filename);
      let content = really_input_string(ic, in_channel_length(ic));
      close_in(ic);
      Some(content);
    }) {
    | Sys_error(_) => None
    };

  let write = (~filename: string, content: string) => {
    let result =
      switch (read_safe(filename)) {
      | Some(existing_content) when existing_content == content =>
        Log.debug("File content unchanged, skipping write");
        Unchanged;
      | Some(_) =>
        Log.debug("File content changed, updating file");
        let oc = open_out(filename);
        output_string(oc, content);
        close_out(oc);
        Updated;
      | None =>
        Log.debug("File doesn't exist");
        let oc = open_out(filename);
        output_string(oc, content);
        close_out(oc);
        Created;
      };

    result;
  };
};

/*
 * Determines where CSS files should be generated.
 *
 * The output directory MUST be explicitly specified via the --output flag.
 * There is no automatic detection or fallback behavior.
 *
 * Usage:
 * - Pass --output=/path/to/output when invoking the ppx
 */
let get_output_path = () => {
  let css_dir =
    switch (Settings.Get.output()) {
    | Some(configured_path) => configured_path
    | None =>
      raise(
        Failure(
          "styled-ppx: CSS output directory must be specified using --output flag. Example: --output=./styles",
        ),
      )
    };

  if (!Sys.file_exists(css_dir)) {
    let rec create_parent_dirs = path => {
      let parent = Filename.dirname(path);
      if (parent != path && parent != "." && !Sys.file_exists(parent)) {
        create_parent_dirs(parent);
        Unix.mkdir(parent, 0o755);
      };
    };

    create_parent_dirs(css_dir);
    if (!Sys.file_exists(css_dir)) {
      Unix.mkdir(css_dir, 0o755);
    };
  };

  let output_path = Filename.concat(css_dir, "styles.css");
  Log.debug(Printf.sprintf("CSS output path: %s", output_path));
  output_path;
};

/*
 * Main entry point for processing CSS rules.
 * Takes CSS declarations and:
 * 1. Generates a unique className based on the hash
 * 2. Unnests nested selectors and media queries
 * 3. Transforms dynamic variables to CSS custom properties
 * 4. Renders the final CSS and stores it in the buffer
 *
 * Returns: (className, list_of_dynamic_variables)
 */
let push =
    (~hash_by: string, declarations: Styled_ppx_css_parser.Ast.rule_list) => {
  /* Generate unique className from hash */
  let className = Printf.sprintf("css-%s", Murmur2.default(hash_by));

  /* Transform CSS: unnest selectors, handle variables */
  let (transformed_declarations, dynamic_vars) =
    Css_transform.transform_rule_list(~className, declarations);

  /* Render to CSS string */
  let rendered_css =
    Styled_ppx_css_parser.Render.rule_list(transformed_declarations);

  /* Store in buffer for later file generation */
  Buffer.add_rule(className, rendered_css);

  (className, dynamic_vars);
};

let finalize_css_generation = () => {
  let css_content = Buffer.get_all_css();

  if (String.length(css_content) > 0) {
    let filename = get_output_path();
    let header = "/* This file is generated by styled-ppx, do not edit manually */\n\n";
    let final_content = header ++ css_content ++ "\n";

    switch (File.write(~filename, final_content)) {
    | Created =>
      Log.debug(Printf.sprintf("CSS file created at: %s", filename))
    | Updated =>
      Log.debug(Printf.sprintf("CSS file updated at: %s", filename))
    | Unchanged => ()
    };
  } else {
    Log.debug("No CSS content to generate");
  };

  Buffer.clear();
};

Stdlib.at_exit(() => finalize_css_generation());
