let rec read_and_print = lines =>
  try({
    let line = input_line(stdin);
    read_and_print(List.cons(line, lines));
  }) {
  | End_of_file => List.rev(lines)
  };

let lines = read_and_print([]) |> String.concat("\n");

let parse_exn = css =>
  switch (
    Styled_ppx_css_parser.Driver.parse_declaration_list(
      ~loc=Ppxlib.Location.none,
      css,
    )
  ) {
  | Ok(declarations) =>
    let (rules, loc) = declarations;
    let resolved = Styled_ppx_css_parser.Resolve.resolve_selectors(rules);
    let (decls, sels) = Styled_ppx_css_parser.Resolve.split_by_kind(resolved);
    Ok(Styled_ppx_css_parser.Render.rule_list((decls @ sels, loc)))
  | Error((loc, msg)) =>
    open Styled_ppx_css_parser.Ast;
    let position = loc.loc_start;
    let curr_char_pos = position.pos_cnum;
    let lnum = position.pos_lnum;
    let pos_bol = position.pos_bol;
    Error(
      Printf.sprintf(
        "Error parsing CSS: %s on line %i at position %i",
        msg,
        lnum,
        curr_char_pos - pos_bol,
      ),
    );
  };

let value = parse_exn(lines);
let value = Result.bind(value, parse_exn);
switch (value) {
| Ok(parsed_css) => print_endline(parsed_css)
| Error(error_msg) => print_endline(error_msg)
};
