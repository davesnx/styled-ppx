open Migrate_parsetree;
open Ast_406;
open Ast_mapper;
open Asttypes;
open Parsetree;

let expr = (mapper, expression) =>
  switch (expression.pexp_desc) {
  | Pexp_constant([@implicit_arity] Pconst_string(str, delim)) =>
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
    let pos = loc_start;
    let mode =
      switch (delim) {
      | None
      | Some("")
      | Some("bs-css") => Css_to_ocaml.Bs_css
      | Some("typed")
      | Some("bs-typed-css") => Css_to_ocaml.Bs_typed_css
      | _ =>
        raise(
          Location.Error(
            Location.error(
              ~loc,
              "Unexpected delimiter: accepted values are \"bs-css\" (or none) for bs-css, and \"typed\" (or \"bs-typed-css\") for bs-typed-css",
            ),
          ),
        )
      };
    switch (txt) {
    | "style" =>
      let ast =
        Css_lexer.parse_string(
          ~container_lnum,
          ~pos,
          str,
          Css_parser.declaration_list,
        );
      Css_to_ocaml.render_declaration_list(mode, ast);
    | "css" =>
      let ast =
        Css_lexer.parse_string(
          ~container_lnum,
          ~pos,
          str,
          Css_parser.stylesheet,
        );
      Css_to_ocaml.render_stylesheet(mode, ast);
    | _ => assert(false)
    };
  | _ =>
    let message =
      switch (txt) {
      | "css" => "[%css] accepts a string, e.g. [%css \"{\n  color: red;\n}\"]"
      | "style" => "[%style] accepts a string, e.g. [%style \"color: red;\"]"
      | _ => assert(false)
      };
    raise(Location.Error(Location.error(~loc, message)));
  | _ => default_mapper.expr(mapper, e)
  };

let mapper = (_, _) => {...default_mapper, expr};

let () = Driver.register(~name="re-styled-css", Versions.ocaml_406, mapper);
