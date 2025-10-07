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

let value_expression =
  Ppxlib.Extension.declare_with_path_arg(
    "value",
    Ppxlib.Extension.Context.Expression,
    string_patten,
    expander(~recursive=false),
  );

let value_dot_rec_expression =
  Ppxlib.Extension.declare_with_path_arg(
    "value.rec",
    Ppxlib.Extension.Context.Expression,
    string_patten,
    expander(~recursive=true),
  );

/* Structure item rewriter to handle module rec declarations */
let module_rec_rewriter = (structure: Ppxlib.structure) => {
  open Ppxlib;

  let rewrite_structure_item = (item: structure_item) => {
    switch (item.pstr_desc) {
    | Pstr_recmodule(module_bindings) =>
      module Ast_builder = Ast_builder.Make({let loc = item.pstr_loc;});
      module Emit = Generate.Make(Ast_builder);

      let new_bindings =
        List.filter_map(
          (mb: module_binding) => {
            switch (Emit.get_module_binding_info(mb)) {
            | Some((module_name, value_spec)) =>
              Emit.make_module(module_name, value_spec)
            | None => Some(mb)
            }
          },
          module_bindings,
        );

      {...item, pstr_desc: Pstr_recmodule(new_bindings)};
    | _ => item
    };
  };

  List.map(rewrite_structure_item, structure);
};

Driver.register_transformation(
  ~extensions=[
    value_expression,
    value_dot_rec_expression,
  ],
  ~impl=module_rec_rewriter,
  "css-grammar-ppx",
);
