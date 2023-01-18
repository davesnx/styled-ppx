open Ppxlib;
open Asttypes;

let expander = (
  ~recursive,
  ~loc as exprLoc,
  ~path as _: string,
  ~arg as _: option(loc(Ppxlib.Longident.t)),
  value: string,
  _,
  _
) => {
  switch (Css_spec_parser.value_of_string(value)) {
  | Some(value: Css_spec_parser.value) =>
    module Ast_builder = Ppxlib.Ast_builder.Make({ let loc = exprLoc });
    module Emit = Generate.Make(Ast_builder);
    let expr = Emit.make_value(value);

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

let is_structure_item_recursive = fun
  | {pstr_desc: Pstr_value(Recursive, _), pstr_loc: _loc} => true
  | _ => false;

let gen_type = (structure_items) => {
  let bindings = List.find_opt(is_structure_item_recursive, structure_items);

  switch (bindings) {
  | Some({pstr_desc: Pstr_value(_, value_bindings), pstr_loc, _}) => {
    module Ast_builder = Ppxlib.Ast_builder.Make({ let loc = pstr_loc });
    module Emit = Generate.Make(Ast_builder);
    let generated_types = Emit.make_types(value_bindings);

    List.cons(generated_types, structure_items)
  }
  | _ => structure_items
  }
};

Driver.register_transformation(~preprocess_impl=gen_type, ~extensions=[valueExtension, valueRecExtension], "css-value-parser-ppx");
