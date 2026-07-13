/* Parse entry points. [~source_position_start] is the file position of
   [input]'s first character; lexing and parse errors are rebased onto it. */
let run = (~source_position_start, parse_fn, input) =>
  try(Ok(parse_fn(input))) {
  | Lexer.LexingError((start_pos, end_pos, msg))
  | Parser.Parse_error((start_pos, end_pos, msg)) =>
    let relative_loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    Error((
      Parser_location.to_file_location(~source_position_start, relative_loc),
      msg,
    ));
  };

let parse_declaration_list = (~source_position_start, input: string) =>
  run(~source_position_start, Parser.parse_declaration_list, input);

let parse_declaration = (~source_position_start, input: string) =>
  run(~source_position_start, Parser.parse_declaration, input);

let parse_stylesheet = (~source_position_start, input: string) =>
  run(~source_position_start, Parser.parse_stylesheet, input);

let parse_keyframes = (~source_position_start, input: string) =>
  run(~source_position_start, Parser.parse_keyframes, input);
