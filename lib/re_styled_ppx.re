open Migrate_parsetree;
open Ast_406;
open Ast_mapper;
open Asttypes;
open Parsetree;

let expr = (mapper, expression) =>
  switch (expression.pexp_desc) {
  | Pexp_extension(({txt: "styled", loc}, _payload)) =>
    switch (expression.pexp_desc) {
      | Pexp_constant(Pconst_string(str, delim)) =>
        let loc_start =
          switch (delim) {
          | None => expression.pexp_loc.Location.loc_start
          | Some(s) => {
              ...expression.pexp_loc.Location.loc_start,
              Lexing.pos_cnum:
                expression.pexp_loc.Location.loc_start.Lexing.pos_cnum
                + String.length(s)
                + 1,
            }
          };
        let container_lnum = loc_start.Lexing.pos_lnum;
        let ast =
          Css_lexer.parse_string(
            ~container_lnum,
            ~pos=loc_start,
            str,
            Css_parser.declaration_list,
          );

        Css_to_emotion.render_declaration_list(ast);
      | _ =>
      let message = "Invalid syntax";
      raise(Location.Error(Location.error(~loc, message)));
    }
  | _ => default_mapper.expr(mapper, expression)
  };

let mapper = (_, _) => {...default_mapper, expr};

let () = Driver.register(~name="styled", Versions.ocaml_406, mapper);
