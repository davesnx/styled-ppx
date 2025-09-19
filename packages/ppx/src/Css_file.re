module Buffer = {
  /* In-memory buffer to accumulate CSS rules during compilation */
  /* Using a list of (className, css) pairs to track unique rules */
  let css_rules: ref(list((string, string))) = ref([]);

  let add_rule = (className: string, css: string) => {
    let exists =
      List.exists(
        ((existingClass, _)) => existingClass == className,
        css_rules^,
      );
    if (!exists) {
      css_rules := [(className, css), ...css_rules^];
    };
  };

  let get_css_content = () => {
    let buffer = Buffer.create(1024);

    css_rules^
    |> List.rev
    |> List.iter(((className, css)) => {
         Buffer.add_char(buffer, '.');
         Buffer.add_string(buffer, className);
         Buffer.add_string(buffer, " {");
         Buffer.add_string(buffer, css);
         Buffer.add_string(buffer, "}");
         Buffer.add_char(buffer, '\n');
       });
    Buffer.contents(buffer);
  };

  let clear = () => {
    css_rules := [];
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
    | _ => cv
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

  let transform_rule = (rule: rule, dynamic_vars) => {
    switch (rule) {
    | Declaration(decl) =>
      Declaration(transform_declaration(decl, dynamic_vars))
    | _ => rule
    };
  };

  let transform_rule_list = (~className, rule_list: rule_list) => {
    let dynamic_vars = ref([]);
    let (_rule_list, rule_loc) = rule_list;
    let transformed_rules =
      rule_list
      |> Styled_ppx_css_parser.Transform.run(~className)
      |> List.map(rule => transform_rule(rule, dynamic_vars));
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

let push = (~hash_by, declarations) => {
  let className = Printf.sprintf("css-%s", Murmur2.default(hash_by));
  let (transformed_declarations, dynamic_vars) =
    Css_transform.transform_rule_list(~className, declarations);

  /* /* Debug: Log the transformed CSS */
              if (Settings.Get.debug()) {
                Printf.printf("[styled-ppx] Transformed CSS: %s\n", css_string);
                Printf.printf(
                  "[styled-ppx] Dynamic vars: %d\n",
                  List.length(dynamic_vars),
                );
                List.iter(
                  ((var_name, original, property)) =>
                    Printf.printf(
                      "[styled-ppx]   --%s => %s (property: %s)\n",
                      var_name,
                      original,
                      property,
                    ),
                  dynamic_vars,
                );
              };
     */

  /* let css_content =
     Settings.Get.debug()
       ? Printf.sprintf(
           "  /* Generated from [%%cx] in %s at line %d */\n%s",
           stringLoc.loc_start.pos_fname,
           stringLoc.loc_start.pos_lnum,
           css_string,
         )
       : css_string; */

  /* TODO: Allow render minified CSS or not */
  let rendered =
    Styled_ppx_css_parser.Render.rule_list(transformed_declarations);

  Buffer.add_rule(className, rendered);
  (className, dynamic_vars);
};

let finalize_css_generation = () => {
  let file_content = Buffer.get_css_content();
  if (String.length(file_content) > 0) {
    let filename = get_output_path();

    let content =
      Printf.sprintf(
        "/* This file is generated by styled-ppx, do not edit manually */\n\n%s\n",
        file_content,
      );

    switch (File.write(~filename, content)) {
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
