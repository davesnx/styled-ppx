open Ppxlib;

let rec longident_to_string = (lid: Longident.t): string =>
  switch (lid) {
  | Lident(s) => s
  | Ldot(prefix, s) => longident_to_string(prefix) ++ "." ++ s
  | Lapply(_, _) => failwith("Lapply not supported in module path")
  };

let extract_module_path = (expr: expression): option(string) =>
  switch (expr.pexp_desc) {
  | Pexp_constraint({ pexp_desc: Pexp_pack(mod_expr), _ }, _) =>
    switch (mod_expr.pmod_desc) {
    | Pmod_ident({ txt: lid, _ }) => Some(longident_to_string(lid))
    | _ => None
    }
  | Pexp_pack(mod_expr) =>
    switch (mod_expr.pmod_desc) {
    | Pmod_ident({ txt: lid, _ }) => Some(longident_to_string(lid))
    | _ => None
    }
  | _ => None
  };

let extract_spec_string = (expr: expression): option(string) =>
  switch (expr.pexp_desc) {
  | Pexp_constant(Pconst_string(s, _, _)) => Some(s)
  | _ => None
  };

let spec_module_pattern = Ast_pattern.(pstr(pstr_eval(__, nil) ^:: nil));

let spec_module_expander =
    (~loc as _exprLoc, ~path as _: string, payload_expr: expression) => {
  module Ast_builder =
    Ast_builder.Make({
      let loc = _exprLoc;
    });
  module Emit = Generate.Make(Ast_builder);

  let (spec_string, runtime_path_opt) =
    switch (payload_expr.pexp_desc) {
    | Pexp_constant(Pconst_string(s, _, _)) => (s, None)
    | Pexp_tuple(elements) =>
      switch (elements) {
      | [spec_expr, witness_expr]
          when
            extract_spec_string(spec_expr) != None
            && extract_module_path(witness_expr) != None =>
        switch (extract_spec_string(spec_expr)) {
        | Some(s) =>
          let runtime_path =
            switch (extract_module_path(witness_expr)) {
            | Some(path) => path
            | None =>
              raise(
                Location.raise_errorf(
                  ~loc=_exprLoc,
                  "couldn't extract module path from witness expression",
                ),
              )
            };
          (s, Some(runtime_path));
        | None =>
          raise(
            Location.raise_errorf(
              ~loc=_exprLoc,
              "first element of tuple must be a string literal",
            ),
          )
        }
      | _ =>
        raise(
          Location.raise_errorf(
            ~loc=_exprLoc,
            "spec_module expects (string) or (string, module)",
          ),
        )
      }
    | _ =>
      raise(
        Location.raise_errorf(
          ~loc=_exprLoc,
          "spec_module expects either a string or a tuple",
        ),
      )
    };

  switch (Css_spec_parser.value_of_string(spec_string)) {
  | Some(parsed_spec) =>
    let structure_items =
      Emit.generate_spec_module(
        ~spec=parsed_spec,
        ~runtime_module_path=runtime_path_opt,
        ~loc=_exprLoc,
      );
    Ast_helper.Mod.structure(~loc=_exprLoc, structure_items);
  | None =>
    raise(
      Location.raise_errorf(
        ~loc=_exprLoc,
        "couldn't parse CSS spec: %s",
        spec_string,
      ),
    )
  };
};

let spec_module_extension =
  Ppxlib.Extension.declare(
    "spec_module",
    Ppxlib.Extension.Context.Module_expr,
    spec_module_pattern,
    spec_module_expander,
  );

let module_path_expander =
    (~loc as exprLoc, ~path as _: string, lid_loc: loc(Longident.t)) => {
  module Ast_builder =
    Ast_builder.Make({
      let loc = exprLoc;
    });
  open Ast_builder;

  let lid = lid_loc.txt;
  let path_string = longident_to_string(lid);
  estring(path_string);
};

let module_path_extension =
  Ppxlib.Extension.declare(
    "module_path",
    Ppxlib.Extension.Context.Expression,
    Ast_pattern.(pstr(pstr_eval(pexp_construct(__', none), nil) ^:: nil)),
    module_path_expander,
  );

let string_pattern =
  Ast_pattern.(
    pstr(
      pstr_eval(pexp_constant(pconst_string(__, __', none)), nil) ^:: __,
    )
  );

let spec_expander =
    (
      ~recursive as _,
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
    Ast_builder.pexp_fun(
      Nolabel,
      None,
      Ast_builder.pvar("tokens"),
      Ast_builder.eapply(expr, [Ast_builder.evar("tokens")]),
    );
  | exception _
  | None =>
    raise(Location.raise_errorf(~loc=exprLoc, "couldn't parse this value"))
  };
};

let spec_extension =
  Ppxlib.Extension.declare_with_path_arg(
    "spec",
    Ppxlib.Extension.Context.Expression,
    string_pattern,
    spec_expander(~recursive=true),
  );

let preprocess_impl = structure_items => structure_items;

Driver.register_transformation(
  ~preprocess_impl,
  ~extensions=[spec_extension, spec_module_extension, module_path_extension],
  "css-grammar-ppx",
);
