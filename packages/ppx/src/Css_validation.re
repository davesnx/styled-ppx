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

let type_check_at_rule_prelude = (at_rule: Styled_ppx_css_parser.Ast.at_rule) => {
  let (name, _) = at_rule.name;
  let (prelude, prelude_loc) = at_rule.prelude;
  /* Interpolated preludes (`@media $(Media.wide)`) are rejected later by
     the extraction pipeline with a dedicated message; skip grammar
     validation so that error stays the one users see. */
  if (Styled_ppx_css_parser.Ast.component_value_list_has_interpolation(
        prelude,
      )) {
    [Ok()];
  } else {
    switch (
      Css_grammar.validate_at_rule_prelude(~loc=prelude_loc, ~name, prelude)
    ) {
    | None
    | Some(Ok ()) => [Ok()]
    | Some(Error((loc, `Invalid_value(detail)))) =>
      let prelude_source =
        Styled_ppx_css_parser.Render.component_value_list(prelude)
        |> String.trim;
      let msg =
        Format.sprintf(
          "@[@%s@ has@ an@ invalid@ condition:@ '%s',@ %s@]",
          name,
          prelude_source,
          Css_grammar.Rule.format_error_info(detail),
        );
      [Error((loc, `Invalid_value(msg)))];
    | Some(Error((loc, `Invalid_prelude(msg)))) => [
        Error((loc, `Invalid_value(msg))),
      ]
    };
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
    let prelude_checks = type_check_at_rule_prelude(at_rule);
    let block_checks =
      switch (at_rule.block) {
      | Empty => [Ok()]
      | Rule_list(rule_list) => type_check_rule_list(rule_list)
      | Stylesheet(rule_list) => type_check_rule_list(rule_list)
      };
    prelude_checks @ block_checks;
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
