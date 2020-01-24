open Migrate_parsetree;
open Ast_406;
open Ast_mapper;
open Asttypes;
open Parsetree;

let expr = (mapper, expression) =>
  switch (expression.pexp_desc) {
  | Pexp_extension(({txt: "styled", loc: _}, _payload)) =>
    Ast_helper.Exp.constant(Pconst_integer("42", None))
  | _ => default_mapper.expr(mapper, expression)
  };

let mapper = (_, _) => {...default_mapper, expr};

let () = Driver.register(~name="re-styled-ppx", Versions.ocaml_406, mapper);
