open Migrate_parsetree;
open Ast_406;
open Ast_mapper;
open Asttypes;
open Parsetree;
open Ast_helper;

let styleVariableName = "styles";

/* let styles = Emotion.(css(exp)) */
let createStyles = (loc, name, exp) => {
  let variableName = {
    ppat_desc: Ppat_var({txt: name, loc}),
    ppat_loc: loc,
    ppat_attributes: [],
  };

  Str.mk(~loc, Pstr_value(Nonrecursive, [Vb.mk(~loc, variableName, exp)]));
};

/* module X = { createStyle + createReactComponent } */
let transformModule = (~loc, ~ast, ~tag) =>
  Mod.mk(
    Pmod_structure([
      createStyles(
        loc,
        styleVariableName,
        Css_to_emotion.render_declaration_list(ast),
      ),
      React_component.create(~loc, ~tag, ~styles=styleVariableName),
    ]),
  );

let moduleMapper = (_, _) => {
  ...default_mapper,
  /* We map all the modules */
  module_expr: (mapper, expr) =>
    switch (expr) {
    | {
        pmod_desc:
          /* that are defined with a ppx like [%txt] */
          Pmod_extension((
            {txt, _},
            PStr([
              {
                /* and contains a string as a payload */
                pstr_desc:
                  Pstr_eval(
                    {
                      pexp_desc: Pexp_constant(Pconst_string(str, delim)),
                      pexp_loc,
                      _,
                    },
                    _,
                  ),
                _,
              },
            ]),
          )),
        _,
      } =>
      let tag =
        switch (String.split_on_char('.', txt)) {
        | ["styled"] => "div"
        | ["styled", tag] => tag
        | _ => "div"
        };

      if (!List.exists(t => t === tag, HTML.tags)) {
        ();
        /* TODO: Add warning into an invalid html tag */
      };

      let loc = pexp_loc;
      let loc_start =
        switch (delim) {
        | None => loc.Location.loc_start
        | Some(s) => {
            ...loc.Location.loc_start,
            Lexing.pos_cnum:
              loc.Location.loc_start.Lexing.pos_cnum + String.length(s) + 1,
          }
        };

      let ast =
        Css_lexer.parse_string(
          ~container_lnum=loc_start.Lexing.pos_lnum,
          ~pos=loc_start,
          str,
          Css_parser.declaration_list,
        );

      transformModule(~loc, ~ast, ~tag);
    | _ => default_mapper.module_expr(mapper, expr)
    },
};

let () =
  Driver.register(~name="styled-ppx", Versions.ocaml_406, moduleMapper);
