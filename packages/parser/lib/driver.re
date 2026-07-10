/* Parse entry points. [~loc] must point at the first character of the
   string payload (see [Parser_location.update_loc_with_delimiter]); lexing
   and parse errors are rebased from payload-relative positions onto it. */
let run = (~loc, parse_fn, input) =>
  try(Ok(parse_fn(input))) {
  | Lexer.LexingError((start_pos, end_pos, msg))
  | Parser.Parse_error((start_pos, end_pos, msg)) =>
    let relative_loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    Error((
      Parser_location.adjust_to_file(~relative_loc, ~base_loc=loc),
      msg,
    ));
  };

let parse_declaration_list = (~loc, input: string) =>
  run(~loc, Parser.parse_declaration_list, input);

let parse_declaration = (~loc, input: string) =>
  run(~loc, Parser.parse_declaration, input);

let parse_stylesheet = (~loc, input: string) =>
  run(~loc, Parser.parse_stylesheet, input);

let parse_keyframes = (~loc, input: string) =>
  run(~loc, Parser.parse_keyframes, input);
