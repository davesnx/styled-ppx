open Ppxlib;
open Asttypes;

let expander = (
  ~recursive,
  ~loc as exprLoc,
  ~path as _: label,
  ~arg as _: option(loc(Ppxlib.Longident.t)),
  value,
  _,
  _
) => {
  switch (Css_spec_parser.value_of_string(value)) {
  | Some(value_ast) =>
    module Ast_builder = Ppxlib.Ast_builder.Make({ let loc = exprLoc });
    module Emit = EmitPatch.Make(Ast_builder);

    let expr = Emit.create_value_parser(value_ast);

    recursive
      ? Ast_builder.pexp_fun(
          Nolabel,
          None,
          Ast_builder.pvar("tokens"),
          Ast_builder.eapply(expr, [Ast_builder.evar("tokens")]),
        )
      : expr;
  | exception _
  | None =>
    raise(
      Location.raise_errorf(~loc=exprLoc, "couldn't parse this value")
    )
  }
};

let payload_pattern =
  Ast_pattern.(
    pstr(
      pstr_eval(pexp_constant(pconst_string(__, __', none)), nil) ^:: __,
    )
  );

let valueExtension =
  Ppxlib.Extension.declare_with_path_arg(
    "value",
    Ppxlib.Extension.Context.Expression,
    payload_pattern,
    expander(~recursive=false),
  );

let valueRecExtension =
  Ppxlib.Extension.declare_with_path_arg(
    "value.rec",
    Ppxlib.Extension.Context.Expression,
    payload_pattern,
    expander(~recursive=true),
  );

let gen_type = (structure_item) => {
  let bindings = List.find_opt(fun
    | {pstr_desc: Pstr_value(Recursive, _), pstr_loc: _loc} => true
    | _ => false
  , structure_item);

  switch (bindings) {
    | Some({pstr_desc: Pstr_value(_, value_bindings), _}) =>
      [EmitType.gen_types(value_bindings)] @ structure_item
    | _ => structure_item
  }
}

Driver.register_transformation(~preprocess_impl=gen_type, ~extensions=[valueExtension, valueRecExtension], "css-value-parser-ppx");
