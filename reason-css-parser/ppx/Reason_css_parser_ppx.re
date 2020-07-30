open Migrate_parsetree;
open Ast_410;
open Ast_mapper;
open Asttypes;
open Parsetree;

module Escape = Escape;
module Emit = Emit;

let extract_value = {
  open Ppxlib.Ast_pattern;

  let payload_pattern =
    pexp_extension(
      extension(
        __,
        pstr(
          pstr_eval(pexp_constant(pconst_string(__', none)), nil) ^:: __,
        ),
      ),
    );
  expr =>
    parse(
      payload_pattern,
      expr.pexp_loc,
      ~on_error=
        _ => {
          print_endline("wat");
          None;
        },
      expr,
      (key, value, _) =>
        switch (key) {
        | "value" => Some((false, value))
        | "value.rec" => Some((true, value))
        | _ => None
        },
    );
};

let transform = (mapper, expr) =>
  switch (extract_value(expr)) {
  | Some((recursive, value)) =>
    let {loc, txt: value} = value;
    switch (Reason_css_vds.value_of_string(value)) {
    | Some(value_ast) =>
      module Loc: {let loc: Location.t;} = {
        let loc = loc;
      };
      module Ast_builder = Ppxlib.Ast_builder.Make(Loc);
      module Emit = Emit.Make(Ast_builder);
      open Ast_builder;

      let expr = Emit.create_value_parser(value_ast);
      recursive
        ? pexp_fun(
            Nolabel,
            None,
            pvar("tokens"),
            eapply(expr, [evar("tokens")]),
          )
        : expr;
    | exception _
    | None =>
      raise(
        Location.Error(
          Location.error(~loc=expr.pexp_loc, "couldn't parse this value"),
        ),
      )
    };
  | None => default_mapper.expr(mapper, expr)
  };
let mapper = (_, _) => {
  ...default_mapper,
  expr: (mapper, expr) =>
    switch (expr) {
    | {pexp_desc: Pexp_extension(({txt: "value" | "value.rec", _}, _)), _} =>
      transform(mapper, expr)
    | _ => default_mapper.expr(mapper, expr)
    },
};
Driver.register(
  ~name="styled-ppx",
  /* this is required to run before ppx_metaquot during tests */
  /* any change regarding this behavior not related to metaquot is a bug */
  ~position=-1,
  Versions.ocaml_410,
  mapper,
);
