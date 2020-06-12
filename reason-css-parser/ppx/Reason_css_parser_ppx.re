open Migrate_parsetree;
open Ast_408;
open Ast_mapper;
open Asttypes;
open Parsetree;
open Ast_helper;
open Longident;

let mapper = (_, _) => {
  ...default_mapper,
  structure_item: mapper =>
    fun
    | {
        pstr_desc:
          Pstr_extension(
            (
              {txt: "property", _},
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
        let txt = txt => {txt, loc: Location.none};
        let value_declaration =
          Vb.mk(Pat.var(txt(name)), Emit.create_value_parser(value_ast));
        let property_name =
          Emit.property_name(name) |> Emit.value_name_of_css;
        let property_declaration =
          Vb.mk(
            Pat.var(txt(property_name)),
            Emit.create_property_parser(name),
          );

        let wrapper_declaration =
          Vb.mk(
            Pat.tuple([
              Pat.var(
                txt(
                  Emit.property_value_name(name) |> Emit.value_name_of_css,
                ),
              ),
              Pat.var(txt(property_name)),
            ]),
            Exp.let_(
              Nonrecursive,
              [value_declaration],
              Exp.let_(
                Nonrecursive,
                [property_declaration],
                Exp.tuple([
                  Exp.ident(txt(Lident(name))),
                  Exp.ident(txt(Lident(property_name))),
                ]),
              ),
            ),
          );
        Str.value(Nonrecursive, [wrapper_declaration]);
      | None => failwith("couldn't parse this value")
      }
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
