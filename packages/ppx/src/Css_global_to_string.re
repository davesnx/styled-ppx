module Helper = Ppxlib.Ast_helper;

let estring = (~loc, s) =>
  Helper.Exp.constant(~loc, Pconst_string(s, loc, None));

let concat_exprs = (~loc, parts) => {
  let concat = (a, b) => [%expr [%e a] ++ [%e b]];
  switch (parts) {
  | [] => estring(~loc, "")
  | [single] => single
  | [first, ...rest] => List.fold_left(concat, first, rest)
  };
};

let render_root_block =
    (~loc, dynamic_vars: list(Css_file.dynamic_var)): Ppxlib.expression => {
  switch (dynamic_vars) {
  | [] => estring(~loc, "")
  | _ =>
    let decl_parts =
      dynamic_vars
      |> List.concat_map(
           (
             { name: var_name, path, var_type, loc: var_loc }: Css_file.dynamic_var,
           ) => {
           let value_expr =
             Css_to_runtime.render_variable(~loc=var_loc, path);
           let stringified_value =
             switch (var_type) {
             | Css_file.RuntimeModule(name) =>
               Property_to_types.make_to_string_call(~loc, name, value_expr)
             | Css_file.CustomProperty => value_expr
             | Css_file.Selector
             | Css_file.MediaQuery =>
               Ppxlib.Location.raise_errorf(
                 ~loc,
                 "Internal: %s var_type leaked into [%%styled.global] value interpolation for `$(%s)`. Please report this as a styled-ppx bug.",
                 switch (var_type) {
                 | Css_file.Selector => "Selector"
                 | Css_file.MediaQuery => "MediaQuery"
                 | _ => "Unknown"
                 },
                 path,
               )
             };
           [
             estring(~loc, "--" ++ var_name ++ ":"),
             stringified_value,
             estring(~loc, ";"),
           ];
         });
    concat_exprs(
      ~loc,
      [estring(~loc, ":root{")] @ decl_parts @ [estring(~loc, "}")],
    );
  };
};
