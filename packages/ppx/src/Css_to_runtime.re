module Helper = Ppxlib.Ast_helper;
module Builder = Ppxlib.Ast_builder.Default;

let render_variable = (~loc, v) => {
  switch (Expression_parser.parse_expression(~loc, ~source=v)) {
  | Ok(expr) => expr
  | Error(msg) =>
    Error.expr(~loc, "Invalid interpolation expression: " ++ msg)
  };
};

let list_append = (~loc, left, right) => {
  let append_fn =
    {
      txt: Lident("@"),
      loc,
    }
    |> Helper.Exp.ident(~loc);
  Helper.Exp.apply(~loc, append_fn, [(Nolabel, left), (Nolabel, right)]);
};

let concat_list_exprs = (~loc, chunks) =>
  switch (chunks) {
  | [] => Builder.elist(~loc, [])
  | [single] => single
  | [head, ...tail] =>
    List.fold_left(
      (acc, chunk) => list_append(~loc, acc, chunk),
      head,
      tail,
    )
  };

let animation_name_to_style_vars = (~loc) =>
  Builder.pexp_ident(
    ~loc,
    {
      txt:
        Ldot(
          Ldot(Ldot(Lident("CSS"), "Types"), "AnimationName"),
          "toStyleVars",
        ),
      loc,
    },
  );

let is_animation_name_var = (var: Css_file.dynamic_var) =>
  switch (var.var_type) {
  | RuntimeModule("AnimationName") => true
  | _ => false
  };

/* [var.path] is re-parsed at [var.loc], so type errors on the
   interpolation point at the `$()` expression, not at the CSS string. */
let render_dynamic_var_tuple = (~loc, var: Css_file.dynamic_var) => {
  let field_name = "--" ++ var.name;
  let field_name_expr =
    Helper.Exp.constant(~loc, Pconst_string(field_name, loc, None));

  let var_value = render_variable(~loc=var.loc, var.path);

  let field_value =
    switch (var.var_type) {
    | Selector
    | MediaQuery => [%expr fst([%e var_value])]
    | CustomProperty =>
      /* `--foo: $(expr)` - expr is already a [string], pass it
         through verbatim. Type error here means the user supplied a
         non-string to a custom-property interpolation. */
      var_value
    | RuntimeModule(module_name) =>
      Property_to_types.make_to_string_call(~loc, module_name, var_value)
    };

  Builder.pexp_tuple(~loc, [field_name_expr, field_value]);
};

let render_dynamic_var_chunk = (~loc, var: Css_file.dynamic_var) => {
  switch (var.var_type) {
  | RuntimeModule("AnimationName") =>
    let field_name = "--" ++ var.name;
    let field_name_expr =
      Helper.Exp.constant(~loc, Pconst_string(field_name, loc, None));
    let var_value = render_variable(~loc=var.loc, var.path);
    Helper.Exp.apply(
      ~loc,
      animation_name_to_style_vars(~loc),
      [(Nolabel, field_name_expr), (Nolabel, var_value)],
    );
  | Selector
  | MediaQuery
  | CustomProperty
  | RuntimeModule(_) =>
    Builder.elist(~loc, [render_dynamic_var_tuple(~loc, var)])
  };
};

let render_dynamic_var_list = (~loc, dynamic_vars) =>
  if (!List.exists(is_animation_name_var, dynamic_vars)) {
    dynamic_vars
    |> List.map(dynamic_var => render_dynamic_var_tuple(~loc, dynamic_var))
    |> Builder.elist(~loc);
  } else {
    dynamic_vars
    |> List.map(dynamic_var => render_dynamic_var_chunk(~loc, dynamic_var))
    |> concat_list_exprs(~loc);
  };

let render_make_call =
    (~loc, ~marker: option(string), ~classNames, ~dynamic_vars) => {
  let class_string = String.concat(" ", classNames);
  let className_string =
    switch (marker) {
    | Some(m) => m ++ " " ++ class_string
    | None => class_string
    };
  let className_expr =
    Helper.Exp.constant(~loc, Pconst_string(className_string, loc, None));

  let var_list = render_dynamic_var_list(~loc, dynamic_vars);

  [%expr CSS.make([%e className_expr], [%e var_list])];
};
