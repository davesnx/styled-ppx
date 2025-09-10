let args = Sys.argv |> Array.to_list;
let input = List.nth_opt(args, 1);
let help =
  List.exists(
    arg =>
      arg == "--help"
      || arg == "-help"
      || arg == "help"
      || arg == "--h"
      || arg == "-h",
    args,
  );

let loc =
  Styled_ppx_css_parser.Parser_location.to_ppxlib_location(
    Lexing.dummy_pos,
    Lexing.dummy_pos,
  );

switch (input, help) {
| (Some(_), true)
| (None, _) =>
  print_endline(
    "\n  `ast-renderer` pretty-prints the CSS AST of the input string.

  EXAMPLE: dune exec ast-renderer \".a { color: red }\"\n",
  )
| (Some(css), _) =>
  switch (Styled_ppx_css_parser.Driver.parse_declaration_list(~loc, css)) {
  | Ok(declarations) =>
    print_endline(Styled_ppx_css_parser.Ast.show_rule_list(declarations))
  | Error((loc, msg)) =>
    let position = loc.loc_start;
    let curr_char_pos = position.pos_cnum;
    let lnum = position.pos_lnum;
    let pos_bol = position.pos_bol;
    print_endline(
      Printf.sprintf(
        "Error parsing CSS: %s on line %i at position %i",
        msg,
        lnum,
        curr_char_pos - pos_bol,
      ),
    );
  }
};
