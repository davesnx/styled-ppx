module Location = Ppxlib.Location;
module Builder = Ppxlib.Ast_builder.Default;

/**
 * Maps CSS property names to their corresponding Css_types module toString functions.
 * This is used by cx2 to generate correct toString calls for interpolated values.
 *
 * Example: "color" -> Some("Color")
 * Then generates: CSS.Types.Color.toString(value)
 */

/* Helper to build the toString expression */
let make_to_string_call = (~loc, module_name, value_expr) => {
  let to_string_ident =
    Builder.pexp_ident(
      ~loc,
      {
        txt:
          Ldot(
            Ldot(Ldot(Lident("CSS"), "Types"), module_name),
            "toString",
          ),
        loc,
      },
    );
  Builder.pexp_apply(~loc, to_string_ident, [(Nolabel, value_expr)]);
};

/**
 * Maps CSS property names to their corresponding Css_types module names.
 *
 * Many CSS properties share the same value type. This table maps property names
 * to the module that handles their toString conversion.
 *
 * Properties not in this table will have their name converted to PascalCase.
 */
let property_to_module_mapping = [
  /* Color properties - use Color module */
  ("background-color", "Color"),
  ("border-color", "Color"),
  ("border-top-color", "Color"),
  ("border-right-color", "Color"),
  ("border-bottom-color", "Color"),
  ("border-left-color", "Color"),
  ("border-block-color", "Color"),
  ("border-block-start-color", "Color"),
  ("border-block-end-color", "Color"),
  ("border-inline-color", "Color"),
  ("border-inline-start-color", "Color"),
  ("border-inline-end-color", "Color"),
  ("color", "Color"),
  ("outline-color", "Color"),
  ("text-decoration-color", "Color"),
  ("text-emphasis-color", "Color"),
  ("column-rule-color", "Color"),
  ("accent-color", "Color"),
  ("fill", "Color"),
  ("stroke", "Color"),
  /* Length properties - use Length module */
  ("width", "Length"),
  ("height", "Length"),
  ("min-width", "Length"),
  ("min-height", "Length"),
  ("max-width", "Length"),
  ("max-height", "Length"),
  ("top", "Length"),
  ("right", "Length"),
  ("bottom", "Length"),
  ("left", "Length"),
  ("padding", "Length"),
  ("padding-top", "Length"),
  ("padding-right", "Length"),
  ("padding-bottom", "Length"),
  ("padding-left", "Length"),
  ("margin", "Length"),
  ("margin-top", "Length"),
  ("margin-right", "Length"),
  ("margin-bottom", "Length"),
  ("margin-left", "Length"),
  ("gap", "Length"),
  ("row-gap", "Length"),
  ("column-gap", "Length"),
  ("border-width", "Length"),
  ("border-top-width", "Length"),
  ("border-right-width", "Length"),
  ("border-bottom-width", "Length"),
  ("border-left-width", "Length"),
  ("outline-width", "Length"),
  ("font-size", "Length"),
  ("line-height", "Length"),
  ("letter-spacing", "Length"),
  ("word-spacing", "Length"),
  ("text-indent", "Length"),
  ("border-radius", "Length"),
  /* Percentage-capable properties - use LengthPercentage */
  ("flex-basis", "LengthPercentage"),
  /* Integer properties */
  ("z-index", "ZIndex"),
  ("order", "Order"),
  ("flex-grow", "FlexGrow"),
  ("flex-shrink", "FlexShrink"),
  ("opacity", "Percentage"),
];

/**
 * Converts a CSS property name to a PascalCase module name.
 * Example: "background-color" -> "BackgroundColor"
 */
let property_name_to_module_name = (property_name: string): string => {
  property_name
  |> String.split_on_char('-')
  |> List.map(part => String.capitalize_ascii(part))
  |> String.concat("");
};

/**
 * Maps CSS property names to their corresponding Css_types module names.
 *
 * First tries to find the property in the Parser registry which has the runtime_module_path.
 * Then checks the manual mapping table.
 * Falls back to converting the property name to PascalCase.
 */
let property_to_module = property_name => {
  /* First try Parser which has explicit runtime_module_path */
  switch (Css_grammar.Parser.find_property(property_name)) {
  | Some(spec_module) =>
    module M = (val spec_module: Css_grammar.Parser.RULE);
    /* Extract just the module name from path like "Css_types.Display" -> "Display" */
    switch (M.runtime_module_path) {
    | Some(path) =>
      switch (String.split_on_char('.', path)) {
      | [_, module_name] => Some(module_name)
      | _ =>
        /* Try the mapping table */
        switch (List.assoc_opt(property_name, property_to_module_mapping)) {
        | Some(module_name) => Some(module_name)
        | None => Some(property_name_to_module_name(property_name))
        }
      }
    | None =>
      /* No runtime module path - try the mapping table */
      switch (List.assoc_opt(property_name, property_to_module_mapping)) {
      | Some(module_name) => Some(module_name)
      | None => Some(property_name_to_module_name(property_name))
      }
    };
  | None =>
    /* Try the mapping table */
    switch (List.assoc_opt(property_name, property_to_module_mapping)) {
    | Some(module_name) => Some(module_name)
    | None => Some(property_name_to_module_name(property_name))
    }
  };
};

/**
 * Get the toString expression for a property with an interpolated value.
 *
 * Returns an expression like: CSS.Types.Color.toString(value)
 */
let get_to_string_for_property = (~loc, property_name, value_expr) => {
  switch (property_to_module(property_name)) {
  | Some(module_name) => make_to_string_call(~loc, module_name, value_expr)
  | None =>
    /* For now, just pass through the value - this will likely cause a type error
       which is better than silently generating incorrect code */
    value_expr
  };
};

/**
 * Result type for interpolation extraction.
 * Contains the variable name and the toString function path.
 */
type interpolation_info = {
  variable_name: string,
  to_string_path: string,
};

/**
 * Get interpolation info from a CSS property value.
 *
 * Given a property name and value string, parses the value using the spec module
 * and extracts information about any interpolated variables.
 *
 * Example:
 *   get_interpolation_tostrings("display", "$(myVar)")
 *   -> Ok([{variable_name: "myVar", to_string_path: "Css_types.Display.toString"}])
 *
 *   get_interpolation_tostrings("display", "block")
 *   -> Ok([]) // No interpolations
 *
 *   get_interpolation_tostrings("unknown-property", "value")
 *   -> Error("Property not found in registry: unknown-property")
 */
let get_interpolation_tostrings =
    (property_name: string, value: string)
    : result(list(interpolation_info), string) => {
  switch (Css_grammar.Parser.find_property(property_name)) {
  | None => Error("Property not found in registry: " ++ property_name)
  | Some(spec_module) =>
    module M = (val spec_module: Css_grammar.Parser.RULE);
    switch (M.runtime_module_path) {
    | None => Error("Property has no runtime module path: " ++ property_name)
    | Some(runtime_path) =>
      switch (M.parse(value)) {
      | Error(parse_error) => Error("Failed to parse value: " ++ parse_error)
      | Ok(parsed_value) =>
        let interpolation_names = M.extract_interpolations(parsed_value);
        let to_string_path = runtime_path ++ ".toString";
        let infos =
          interpolation_names
          |> List.map(variable_name =>
               {
                 variable_name,
                 to_string_path,
               }
             );
        Ok(infos);
      }
    };
  };
};

/**
 * Check if a property is registered in the Parser registry.
 */
let is_property_registered = (property_name: string): bool => {
  switch (Css_grammar.Parser.find_property(property_name)) {
  | Some(_) => true
  | None => false
  };
};

/**
 * Type-safe helper for working with property modules.
 *
 * This function encapsulates the pattern of unpacking a first-class module
 * and applying a function to its operations. The type [a] is existentially
 * quantified - the caller doesn't need to know the concrete type, only that
 * the function [f] receives consistent types.
 *
 * Example:
 * {[
 *   with_property_module "display" (fun (module M : RULE) ->
 *     match M.parse "block" with
 *     | Ok value -> M.to_string value
 *     | Error _ -> "invalid"
 *   )
 * ]}
 */
let with_property_module:
  (string, (module Css_grammar.Parser.RULE) => 'result) => option('result) =
  (property_name, f) => {
    switch (Css_grammar.Parser.find_property(property_name)) {
    | Some(spec_module) => Some(f(spec_module))
    | None => None
    };
  };

/**
 * Parse a CSS value for a property and return information about interpolations.
 *
 * This is a type-safe wrapper that demonstrates the proper pattern for working
 * with property modules. The type of the parsed value is existentially quantified
 * within the function scope - we don't expose it to callers because they don't
 * need it. They only need the extracted information (interpolation names, paths).
 */
let parse_and_extract_interpolations =
    (property_name: string, value: string)
    : result(list(interpolation_info), string) => {
  switch (Css_grammar.Parser.find_property(property_name)) {
  | None => Error("Property not found in registry: " ++ property_name)
  | Some(spec_module) =>
    /* Unpack the first-class module - M.t is existentially quantified */
    module M = (val spec_module: Css_grammar.Parser.RULE);
    switch (M.runtime_module_path) {
    | None => Error("Property has no runtime module path: " ++ property_name)
    | Some(runtime_path) =>
      switch (M.parse(value)) {
      | Error(parse_error) => Error("Failed to parse value: " ++ parse_error)
      | Ok(parsed_value) =>
        /* parsed_value : M.t - the type is abstract but we can work with it
           through M's operations which all use the same type */
        let interpolation_names = M.extract_interpolations(parsed_value);
        let to_string_path = runtime_path ++ ".toString";
        let infos =
          interpolation_names
          |> List.map(variable_name =>
               {
                 variable_name,
                 to_string_path,
               }
             );
        Ok(infos);
      }
    };
  };
};
