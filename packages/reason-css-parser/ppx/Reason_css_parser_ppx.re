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

let is_open = fun
  | {pstr_desc: Pstr_open(_), pstr_loc: _loc} => true
  | _ => false;

let preprocess_impl = (structure_items) => {
  let (bindings, rest) = List.partition(is_structure_item_recursive, structure_items);

  switch (bindings) {
  | [{pstr_desc: Pstr_value(_, value_binding), pstr_loc, _}] => {
    module Ast_builder = Ppxlib.Ast_builder.Make({ let loc = pstr_loc });
    module Emit = Generate.Make(Ast_builder);
    let generated_types = Emit.make_types(value_binding);
    let modified_bindings = Emit.add_types(~loc=pstr_loc, value_binding);
    /* This is clearly a nasty one, I asume the content of the file and re-organise it */
    let (open_bindings, rest) = List.partition(is_open, rest);
    open_bindings @ [generated_types] @ modified_bindings @ rest;
  }
  | [_more_than_one_rec_binding] => failwith("expected a single recursive value binding")
  | _ => structure_items
  }
};

Driver.register_transformation(~preprocess_impl, ~extensions=[valueExtension, valueRecExtension], "css-parser-ppx");
