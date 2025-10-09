open Ppxlib;
open Asttypes;

let expander =
    (
      ~recursive,
      ~loc as exprLoc,
      ~path as _: string,
      ~arg as _: option(loc(Longident.t)),
      value: string,
      _loc,
      _rest: list(structure_item),
    ) => {
  switch (Css_spec_parser.value_of_string(value)) {
  | Some(value: Css_spec_parser.value) =>
    module Ast_builder =
      Ast_builder.Make({
        let loc = exprLoc;
      });
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
    raise(Location.raise_errorf(~loc=exprLoc, "couldn't parse this value"))
  };
};

let string_patten =
  Ast_pattern.(
    pstr(
      pstr_eval(pexp_constant(pconst_string(__, __', none)), nil) ^:: __,
    )
  );

let valueExtension =
  Ppxlib.Extension.declare_with_path_arg(
    "value",
    Ppxlib.Extension.Context.Expression,
    string_patten,
    expander(~recursive=false),
  );

let valueRecExtension =
  Ppxlib.Extension.declare_with_path_arg(
    "value.rec",
    Ppxlib.Extension.Context.Expression,
    string_patten,
    expander(~recursive=true),
  );

let is_structure_item_recursive =
  fun
  | {pstr_desc: Pstr_value(Recursive, _), pstr_loc: _loc} => true
  | _ => false;

let is_structure_item_recmodule =
  fun
  | {pstr_desc: Pstr_recmodule(_), pstr_loc: _loc} => true
  | _ => false;

let is_open =
  fun
  | {pstr_desc: Pstr_open(_), pstr_loc: _loc} => true
  | _ => false;

/* let _preprocess_impl = structure_items => {
     let (module_bindings, rest) =
       List.partition(is_structure_item_recmodule, structure_items);

     switch (module_bindings) {
     | [{pstr_desc: Pstr_recmodule(module_bindings), pstr_loc, _}] =>
       module Ast_builder =
         Ppxlib.Ast_builder.Make({
           let loc = pstr_loc;
         });
       module Emit = Generate.Make(Ast_builder);
       let generated_module_bindings = Emit.make_modules(module_bindings);
       let (open_bindings, rest) = List.partition(is_open, rest);

       switch (generated_module_bindings) {
       | [] => structure_items
       | bindings =>
         let rec_modules = Ast_helper.Str.rec_module(~loc=pstr_loc, bindings);
         open_bindings @ [rec_modules] @ rest;
       };
     | [_more_than_one_rec_module] =>
       failwith("expected a single recursive module binding")
     | _ => structure_items
     };
   }; */

let preprocess_impl = structure_items => {
  let (bindings, rest) =
    List.partition(is_structure_item_recursive, structure_items);

  switch (bindings) {
  | [{pstr_desc: Pstr_value(_, value_binding), pstr_loc, _}] =>
    module Ast_builder =
      Ppxlib.Ast_builder.Make({
        let loc = pstr_loc;
      });
    module Emit = Generate.Make(Ast_builder);
    let generated_types = Emit.make_types(value_binding);
    let modified_bindings = Emit.add_types(~loc=pstr_loc, value_binding);
    /* This is clearly a nasty one, I asume the content of the file and re-organise it */
    let (open_bindings, rest) = List.partition(is_open, rest);
    open_bindings @ [generated_types] @ modified_bindings @ rest;
  | [_more_than_one_rec_binding] =>
    failwith("expected a single recursive value binding")
  | _ => structure_items
  };
};

Driver.register_transformation(
  ~preprocess_impl,
  ~extensions=[valueExtension, valueRecExtension],
  "css-grammar-ppx",
);
