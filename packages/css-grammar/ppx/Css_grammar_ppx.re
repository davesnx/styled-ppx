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

let value_extension =
  Ppxlib.Extension.declare_with_path_arg(
    "value",
    Ppxlib.Extension.Context.Expression,
    string_patten,
    expander(~recursive=false),
  );

let value_rec_extension =
  Ppxlib.Extension.declare_with_path_arg(
    "value.rec",
    Ppxlib.Extension.Context.Expression,
    string_patten,
    expander(~recursive=true),
  );

let spec_extension =
  Ppxlib.Extension.declare_with_path_arg(
    "spec",
    Ppxlib.Extension.Context.Expression,
    string_patten,
    expander(~recursive=true),
  );

/* Expander for spec_t - generates OCaml type from CSS spec string */
let spec_t_expander =
    (~loc as exprLoc, ~path as _: string, value: string, _loc) => {
  switch (Css_spec_parser.value_of_string(value)) {
  | Some(parsed_spec: Css_spec_parser.value) =>
    module Ast_builder =
      Ast_builder.Make({
        let loc = exprLoc;
      });
    module Emit = Generate.Make(Ast_builder);
    Emit.create_type_parser(parsed_spec);
  | exception _
  | None =>
    raise(Location.raise_errorf(~loc=exprLoc, "couldn't parse CSS spec: %s", value))
  };
};

let spec_t_extension =
  Ppxlib.Extension.declare(
    "spec_t",
    Ppxlib.Extension.Context.Core_type,
    Ast_pattern.(pstr(pstr_eval(pexp_constant(pconst_string(__, __', none)), nil) ^:: nil)),
    spec_t_expander,
  );

/* Extract module path string from a packed module expression like
   (module Css_types.Display : RUNTIME_TYPE) -> "Css_types.Display" */
let rec longident_to_string = (lid: Longident.t): string =>
  switch (lid) {
  | Lident(s) => s
  | Ldot(prefix, s) => longident_to_string(prefix) ++ "." ++ s
  | Lapply(_, _) => failwith("Lapply not supported in module path")
  };

let extract_module_path = (expr: expression): option(string) =>
  switch (expr.pexp_desc) {
  /* (module M : T) is Pexp_constraint(Pexp_pack(...), _) */
  | Pexp_constraint({pexp_desc: Pexp_pack(mod_expr), _}, _) =>
    switch (mod_expr.pmod_desc) {
    | Pmod_ident({txt: lid, _}) => Some(longident_to_string(lid))
    | _ => None
    }
  /* (module M) without constraint is just Pexp_pack */
  | Pexp_pack(mod_expr) =>
    switch (mod_expr.pmod_desc) {
    | Pmod_ident({txt: lid, _}) => Some(longident_to_string(lid))
    | _ => None
    }
  | _ => None
  };

/* Extract spec string from an expression */
let extract_spec_string = (expr: expression): option(string) =>
  switch (expr.pexp_desc) {
  | Pexp_constant(Pconst_string(s, _, _)) => Some(s)
  | _ => None
  };

/* Pattern for spec_module: captures the whole payload expression */
let spec_module_pattern = Ast_pattern.(pstr(pstr_eval(__, nil) ^:: nil));

/* Unified expander for spec_module - handles multiple forms:
   1. [%spec_module "spec_string"] - generates inline type
   2. [%spec_module "spec_string", (module Css_types.Foo : RUNTIME_TYPE)] - with runtime module
   3. [%spec_module "type_name", "spec_string", (module ...)] - type_name is ignored (legacy form) */
let spec_module_expander =
    (~loc as _exprLoc, ~path as _: string, payload_expr: expression) => {
  module Ast_builder =
    Ast_builder.Make({
      let loc = _exprLoc;
    });
  module Emit = Generate.Make(Ast_builder);

  /* Determine which form we have and extract values */
  let (spec_string, witness_opt, runtime_path_opt) =
    switch (payload_expr.pexp_desc) {
    /* Form 1: Just a string - [%spec_module "spec_string"] */
    | Pexp_constant(Pconst_string(s, _, _)) => (s, None, None)
    /* Form 2+: Tuple */
    | Pexp_tuple(elements) =>
      switch (elements) {
      /* Form 2a: [%spec_module "type_name", "spec_string"] - type_name is ignored */
      | [_type_name_expr, spec_expr] when extract_spec_string(spec_expr) != None =>
        switch (extract_spec_string(spec_expr)) {
        | Some(s) => (s, None, None)
        | None =>
          raise(
            Location.raise_errorf(
              ~loc=_exprLoc,
              "second element of tuple must be a spec string literal",
            ),
          )
        }
      /* Form 2b: [%spec_module "spec_string", (module ...)] */
      | [spec_expr, witness_expr] when extract_spec_string(spec_expr) != None && extract_module_path(witness_expr) != None =>
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
          (s, Some(witness_expr), Some(runtime_path));
        | None =>
          raise(
            Location.raise_errorf(
              ~loc=_exprLoc,
              "first element of tuple must be a string literal",
            ),
          )
        }
      /* Form 3: [%spec_module "type_name", "spec_string", (module ...)] - type_name is ignored */
      | [_type_name_expr, spec_expr, witness_expr] =>
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
          (s, Some(witness_expr), Some(runtime_path));
        | None =>
          raise(
            Location.raise_errorf(
              ~loc=_exprLoc,
              "second element of tuple must be a spec string literal",
            ),
          )
        }
      | _ =>
        raise(
          Location.raise_errorf(
            ~loc=_exprLoc,
            "spec_module expects (string), (string, module), or (string, string, module)",
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
        ~witness=witness_opt,
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

let preprocess_impl = structure_items => structure_items;

Driver.register_transformation(
  ~preprocess_impl,
  ~extensions=[
    value_extension,
    value_rec_extension,
    spec_extension,
    spec_t_extension,
    spec_module_extension,
  ],
  "css-grammar-ppx",
);
