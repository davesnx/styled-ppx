/* css-fonts descriptors with no property counterpart: valid only inside
   `@font-face`. */
let font_face_descriptors = [
  "src",
  "unicode-range",
  "font-display",
  "ascent-override",
  "descent-override",
  "line-gap-override",
  "size-adjust",
];

/* Properties that css-fonts also defines as `@font-face` descriptors. */
let font_face_properties = [
  "font-family",
  "font-style",
  "font-weight",
  "font-stretch",
  "font-width",
  "font-feature-settings",
  "font-variation-settings",
  "font-language-override",
];

let is_font_face_descriptor = name =>
  List.mem(
    String.lowercase_ascii(name),
    font_face_descriptors @ font_face_properties,
  );

let rec type_check_rule = (~at_rule, rule: Styled_ppx_css_parser.Ast.rule) => {
  switch (rule) {
  | Declaration({ name: (name, name_loc), _ })
      when
        List.mem(String.lowercase_ascii(name), font_face_descriptors)
        && at_rule != Some("font-face") => [
      Error((
        name_loc,
        `Invalid_value(
          "Descriptor '" ++ name ++ "' is only valid inside @font-face",
        ),
      )),
    ]
  | Declaration({ name: (name, name_loc), _ })
      when at_rule == Some("font-face") && !is_font_face_descriptor(name) => [
      Error((
        name_loc,
        `Invalid_value(
          "Property '" ++ name ++ "' is not a @font-face descriptor",
        ),
      )),
    ]
  | Declaration({ name: (name, _), value: (value, value_loc), loc: _, _ }) =>
    switch (Css_grammar.validate_property(~loc=value_loc, ~name, value)) {
    | Ok () => [Ok()]
    | Error((loc, `Invalid_value(detail))) =>
      let value_source =
        Styled_ppx_css_parser.Render.component_value_list(value)
        |> String.trim;
      let msg =
        Format.sprintf(
          "@[Property@ '%s'@ has@ an@ invalid@ value:@ '%s',@ %s@]",
          name,
          value_source,
          Css_grammar.Rule.format_error_info(detail),
        );
      [Error((loc, `Invalid_value(msg)))];
    | Error((loc, `Property_not_found)) =>
      let msg =
        switch (Css_grammar.suggest_property_name(name)) {
        | Some(suggestion) =>
          "Unknown property '"
          ++ name
          ++ "'. Did you mean '"
          ++ suggestion
          ++ "'?"
        | None => "Unknown property '" ++ name ++ "'"
        };
      [Error((loc, `Invalid_value(msg)))];
    }
  | Style_rule(style_rule) =>
    type_check_rule_list(~at_rule, style_rule.block)
  | At_rule({ name: (name, _), block, _ }) =>
    let at_rule = Some(String.lowercase_ascii(name));
    switch (block) {
    | Empty => [Ok()]
    | Rule_list(rule_list) => type_check_rule_list(~at_rule, rule_list)
    | Stylesheet(rule_list) => type_check_rule_list(~at_rule, rule_list)
    };
  };
}

and type_check_rule_list =
    (~at_rule, (rule_list, _): Styled_ppx_css_parser.Ast.rule_list) =>
  rule_list |> List.concat_map(rule => type_check_rule(~at_rule, rule));

let type_check_rule_list = rule_list =>
  type_check_rule_list(~at_rule=None, rule_list);

let get_errors = validations =>
  validations
  |> List.filter_map(result =>
       switch (result) {
       | Error((loc, error)) => Some((loc, error))
       | Ok(_) => None
       }
     );

let error_to_string = error =>
  switch (error) {
  | `Invalid_value(string) => string
  | `Property_not_found => "Property not found"
  };
