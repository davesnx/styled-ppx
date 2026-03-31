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

let resolve_module_name = (~type_path: string, ~property_name: string): string => {
  switch (String.split_on_char('.', type_path)) {
  | [_, module_name] => module_name
  | _ =>
    /* type_path is empty, look up from the registry directly */
    switch (Css_grammar.find_property(property_name)) {
    | Some(Css_grammar.Pack_rule({runtime_module_path: Some(path), _})) =>
      switch (String.split_on_char('.', path)) {
      | [_, module_name] => module_name
      | _ => "Cascading"
      }
    | _ => "Cascading"
    };
  };
};
