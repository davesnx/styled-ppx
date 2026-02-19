module Location = Ppxlib.Location;
module Builder = Ppxlib.Ast_builder.Default;

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

let property_to_module_mapping = [
  ("-webkit-box-shadow", "BoxShadow"),
  ("box-shadow", "BoxShadow"),
  ("text-shadow", "TextShadow"),
  ("-webkit-box-orient", "BoxOrient"),
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
  ("caret-color", "Color"),
  ("fill", "Color"),
  ("stroke", "Color"),
  ("scrollbar-color", "Color"),
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
  ("outline-offset", "Length"),
  ("font-size", "Length"),
  ("line-height", "Length"),
  ("letter-spacing", "Length"),
  ("word-spacing", "Length"),
  ("text-indent", "Length"),
  ("border", "BorderValue"),
  ("border-radius", "Length"),
  ("border-top-left-radius", "Length"),
  ("border-top-right-radius", "Length"),
  ("border-bottom-left-radius", "Length"),
  ("border-bottom-right-radius", "Length"),
  ("inset", "Length"),
  ("inset-block", "Length"),
  ("inset-block-start", "Length"),
  ("inset-block-end", "Length"),
  ("inset-inline", "Length"),
  ("inset-inline-start", "Length"),
  ("inset-inline-end", "Length"),
  ("margin-block", "Length"),
  ("margin-block-start", "Length"),
  ("margin-block-end", "Length"),
  ("margin-inline", "Length"),
  ("margin-inline-start", "Length"),
  ("margin-inline-end", "Length"),
  ("padding-block", "Length"),
  ("padding-block-start", "Length"),
  ("padding-block-end", "Length"),
  ("padding-inline", "Length"),
  ("padding-inline-start", "Length"),
  ("padding-inline-end", "Length"),
  ("border-block-width", "Length"),
  ("border-block-start-width", "Length"),
  ("border-block-end-width", "Length"),
  ("border-inline-width", "Length"),
  ("border-inline-start-width", "Length"),
  ("border-inline-end-width", "Length"),
  ("block-size", "Length"),
  ("inline-size", "Length"),
  ("min-block-size", "Length"),
  ("max-block-size", "Length"),
  ("min-inline-size", "Length"),
  ("max-inline-size", "Length"),
  ("scroll-margin", "Length"),
  ("scroll-margin-top", "Length"),
  ("scroll-margin-right", "Length"),
  ("scroll-margin-bottom", "Length"),
  ("scroll-margin-left", "Length"),
  ("scroll-margin-block", "Length"),
  ("scroll-margin-block-start", "Length"),
  ("scroll-margin-block-end", "Length"),
  ("scroll-margin-inline", "Length"),
  ("scroll-margin-inline-start", "Length"),
  ("scroll-margin-inline-end", "Length"),
  ("scroll-padding", "Length"),
  ("scroll-padding-top", "Length"),
  ("scroll-padding-right", "Length"),
  ("scroll-padding-bottom", "Length"),
  ("scroll-padding-left", "Length"),
  ("scroll-padding-block", "Length"),
  ("scroll-padding-block-start", "Length"),
  ("scroll-padding-block-end", "Length"),
  ("scroll-padding-inline", "Length"),
  ("scroll-padding-inline-start", "Length"),
  ("scroll-padding-inline-end", "Length"),
  ("flex-basis", "LengthPercentage"),
  ("z-index", "ZIndex"),
  ("order", "Order"),
  ("flex-grow", "FlexGrow"),
  ("flex-shrink", "FlexShrink"),
  ("opacity", "Opacity"),
  ("grid-row-start", "GridLine"),
  ("grid-row-end", "GridLine"),
  ("grid-column-start", "GridLine"),
  ("grid-column-end", "GridLine"),
  ("translate", "Translate"),
  ("rotate", "Rotate"),
  ("scale", "Scale"),
  ("perspective", "Perspective"),
];

let property_name_to_module_name = (property_name: string): string => {
  property_name
  |> String.split_on_char('-')
  |> List.map(part => String.capitalize_ascii(part))
  |> String.concat("");
};

let property_to_module = property_name => {
  switch (Css_grammar.Parser.find_property(property_name)) {
  | Some(Css_grammar.Parser.Pack_rule({ runtime_module_path, _ })) =>
    switch (runtime_module_path) {
    | Some(path) =>
      switch (String.split_on_char('.', path)) {
      | [_, module_name] => Some(module_name)
      | _ =>
        switch (List.assoc_opt(property_name, property_to_module_mapping)) {
        | Some(module_name) => Some(module_name)
        | None => Some(property_name_to_module_name(property_name))
        }
      }
    | None =>
      switch (List.assoc_opt(property_name, property_to_module_mapping)) {
      | Some(module_name) => Some(module_name)
      | None => Some(property_name_to_module_name(property_name))
      }
    }
  | None =>
    switch (List.assoc_opt(property_name, property_to_module_mapping)) {
    | Some(module_name) => Some(module_name)
    | None => Some(property_name_to_module_name(property_name))
    }
  };
};

let get_to_string_for_property = (~loc, property_name, value_expr) => {
  switch (property_to_module(property_name)) {
  | Some(module_name) => make_to_string_call(~loc, module_name, value_expr)
  | None => value_expr
  };
};

type interpolation_info = {
  variable_name: string,
  to_string_path: string,
};

let is_property_registered = (property_name: string): bool => {
  switch (Css_grammar.Parser.find_property(property_name)) {
  | Some(_) => true
  | None => false
  };
};

let with_property_rule
    : (string, Css_grammar.Parser.packed_rule => 'result) => option('result) =
    (property_name, f) => {
  switch (Css_grammar.Parser.find_property(property_name)) {
  | Some(packed_rule) => Some(f(packed_rule))
  | None => None
  };
};

let parse_and_extract_interpolations =
    (property_name: string, value: string)
    : result(list(interpolation_info), string) => {
  switch (Css_grammar.Parser.find_property(property_name)) {
  | None => Error("Property not found in registry: " ++ property_name)
  | Some(Css_grammar.Parser.Pack_rule({ runtime_module_path, validate, _ })) =>
    switch (runtime_module_path) {
    | None => Error("Property has no runtime module path: " ++ property_name)
    | Some(default_runtime_path) =>
      switch (validate(value)) {
      | Error(parse_error) => Error("Failed to parse value: " ++ parse_error)
      | Ok () =>
        let interpolations =
          Css_grammar.Parser.get_interpolation_types(
            ~name=property_name,
            value,
          );
        let infos =
          interpolations
          |> List.map(((variable_name, type_path)) => {
               let effective_path =
                 if (type_path != "") {
                   type_path;
                 } else {
                   default_runtime_path;
                 };
               {
                 variable_name,
                 to_string_path: effective_path ++ ".toString",
               };
             });
        Ok(infos);
      }
    }
  };
};
