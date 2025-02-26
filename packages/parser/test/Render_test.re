let rec read_and_print = lines =>
  try({
    let line = input_line(stdin);
    read_and_print(List.cons(line, lines));
  }) {
  | End_of_file => List.rev(lines)
  };

let lines = read_and_print([]) |> String.concat("\n");

switch (
  Styled_ppx_css_parser.Driver.parse_declaration_list(
    ~loc=Ppxlib.Location.none,
    lines,
  )
) {
| Ok(declarations) =>
  print_endline(Styled_ppx_css_parser.Render.rule_list(declarations))
| Error((loc, msg)) =>
  open Styled_ppx_css_parser.Ast;
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
};
