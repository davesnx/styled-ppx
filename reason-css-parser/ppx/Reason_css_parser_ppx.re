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
            {txt: "value", _},
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
        {pexp_loc, pexp_loc_stack, pexp_desc, pexp_attributes: []};
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
