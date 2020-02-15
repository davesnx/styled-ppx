open Migrate_parsetree;
open Ast_406;
open Ast_mapper;
open Asttypes;
open Parsetree;

let expr = (mapper, expression) =>
  switch (expression.pexp_desc) {
  | Pexp_extension((
      {txt, loc, _},
      PStr([{pstr_desc: Pstr_eval(e, _), _}]),
    ))
      when txt == "styled" =>
    switch (e.pexp_desc) {
    | Pexp_constant(Pconst_string(str, delim)) =>
      let loc_start =
        switch (delim) {
        | None => e.pexp_loc.Location.loc_start
        | Some(s) => {
            ...e.pexp_loc.Location.loc_start,
            Lexing.pos_cnum:
              e.pexp_loc.Location.loc_start.Lexing.pos_cnum
              + String.length(s)
              + 1,
          }
        };

      let container_lnum = loc_start.Lexing.pos_lnum;
      let pos = loc_start;
      switch (txt) {
        | "styled" =>
          let ast =
            Css_lexer.parse_string(
              ~container_lnum,
              ~pos,
              str,
              Css_parser.declaration_list,
            );
          Css_to_emotion.render_declaration_list(ast);
        | _ => assert(false)
      };
    | _ =>
      let message =
        switch (txt) {
        | "styled" => "[%style] accepts a string, e.g. [%style \"color: red;\"]"
        | _ => assert(false)
        };
      raise(Location.Error(Location.error(~loc, message)));
    }
  | _ => default_mapper.expr(mapper, expression)
  };

let mapper = (_, _) => {...default_mapper, expr};

let () = Driver.register(~name="re_styled_ppx", Versions.ocaml_406, mapper);
