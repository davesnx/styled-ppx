module Builder = Ppxlib.Ast_builder.Default;

let is_name = (name: string): bool =>
  String.length(name) >= 2 && String.sub(name, 0, 2) == "--";

let render_string = (~loc, s) => {
  Builder.pexp_constant(~loc, Pconst_string(s, loc, Some("js")));
};

let render_declaration = (~loc, ~property, ~raw_value_source) => {
  [%expr
   CSS.unsafe(
     [%e render_string(~loc, property)],
     [%e render_string(~loc, raw_value_source)],
   )
  ];
};
