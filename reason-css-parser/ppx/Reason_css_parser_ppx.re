open Migrate_parsetree;
open Ast_408;
open Ast_mapper;
open Asttypes;
open Parsetree;

let mapper = (_, _) => {
  ...default_mapper,
  expr: mapper =>
    fun
    | {
        pexp_desc:
          Pexp_extension((
            {txt: "value.rec" as ext_name, _},
            PStr([
              {
                pstr_desc:
                  Pstr_eval(
                    {
                      pexp_desc: Pexp_constant(Pconst_string(value, None)),
                      _,
                    },
                    _,
                  ),
                _,
              },
            ]),
          )),
        pexp_loc,
        pexp_loc_stack,
        _,
      }
    | {
        pexp_desc:
          Pexp_extension((
            {txt: "value" as ext_name, _},
            PStr([
              {
                pstr_desc:
                  Pstr_eval(
                    {
                      pexp_desc: Pexp_constant(Pconst_string(value, None)),
                      _,
                    },
                    _,
                  ),
                _,
              },
            ]),
          )),
        pexp_loc,
        pexp_loc_stack,
        _,
      } =>
      switch (Reason_css_vds.value_of_string(value)) {
      | Some(value_ast) =>
        let {pexp_desc, _} = Emit.create_value_parser(value_ast);
        let expr = {pexp_loc, pexp_loc_stack, pexp_desc, pexp_attributes: []};
        let expr =
          switch (ext_name) {
          | "value.rec" =>
            %expr
            (tokens => [%e expr](tokens))
          | "value" => expr
          | _ => failwith("unreachable")
          };
        expr;
      | None => failwith("couldn't parse this value")
      }
    | expr => default_mapper.expr(mapper, expr),
};
Driver.register(
  ~name="styled-ppx",
  /* this is required to run before ppx_metaquot during tests */
  /* any change regarding this behavior not related to metaquot is a bug */
  ~position=-1,
  Versions.ocaml_408,
  mapper,
);
