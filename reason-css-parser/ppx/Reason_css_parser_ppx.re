open Migrate_parsetree;
open Ast_408;
open Ast_mapper;
open Asttypes;
open Parsetree;
open Ast_helper;

let mapper = (_, _) => {
  ...default_mapper,
  structure_item: mapper =>
    fun
    | {
        pstr_desc:
          Pstr_extension(
            (
              {txt: "value", _},
              PStr([
                {
                  pstr_desc:
                    Pstr_value(
                      _,
                      [
                        {
                          pvb_pat: {ppat_desc: Ppat_var({txt: name, _}), _},
                          pvb_expr: {
                            pexp_desc:
                              Pexp_constant(Pconst_string(value, None)),
                            _,
                          },
                          _,
                        },
                      ],
                    ),
                  _,
                },
              ]),
            ),
            _,
          ),
        _,
      } =>
      switch (Reason_css_vds.value_of_string(value)) {
      | Some(value_ast) =>
        let value_declaration =
          Vb.mk(
            Pat.var({txt: name, loc: Location.none}),
            Emit.create_value_parser(value_ast),
          );
        Str.value(Nonrecursive, [value_declaration]);
      | None => failwith("couldn't parse this value")
      }
    | stri => default_mapper.structure_item(mapper, stri),
};
Driver.register(
  ~name="styled-ppx",
  /* this is required to run before ppx_metaquot during tests */
  /* any change regarding this behavior not related to metaquot is a bug */
  ~position=-1,
  Versions.ocaml_408,
  mapper,
);
