let is_css_keyword = (value: Styled_ppx_css_parser.Ast.component_value) => {
  switch (value) {
  | Ident("inherit")
  | Ident("unset")
  | Ident("initial")
  | Ident("revert")
  | Ident("revert-layer") => true
  | _ => false
  };
};

let rec type_check_rule = (rule: Styled_ppx_css_parser.Ast.rule) => {
  switch (rule) {
  | Declaration({ name: _, value: ([(value, _)], _), _ })
      when is_css_keyword(value) => [
      Ok(),
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
  | Style_rule(style_rule) => type_check_rule_list(style_rule.block)
  | At_rule(at_rule) =>
    switch (at_rule.block) {
    | Empty => [Ok()]
    | Rule_list(rule_list) => type_check_rule_list(rule_list)
    | Stylesheet(rule_list) => type_check_rule_list(rule_list)
    }
  };
}

and type_check_rule_list =
    ((rule_list, _): Styled_ppx_css_parser.Ast.rule_list) =>
  rule_list |> List.concat_map(rule => type_check_rule(rule));

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
