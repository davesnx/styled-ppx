let parse_declaration_list = (~loc, input: string) =>
  try(Ok(Parser.parse_declaration_list(input))) {
  | Lexer.LexingError((start_pos, end_pos, msg)) =>
    let loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    Error((loc, msg));
  | Parser.Parse_error((start_pos, end_pos, msg)) =>
    let token_loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    let loc = Parser_location.update_pos_lnum(token_loc, loc);
    Error((loc, msg));
  };

let parse_declaration = (~loc, input: string) =>
  try(Ok(Parser.parse_declaration(input))) {
  | Lexer.LexingError((start_pos, end_pos, msg)) =>
    let loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    Error((loc, msg));
  | Parser.Parse_error((start_pos, end_pos, msg)) =>
    let token_loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    let loc = Parser_location.update_pos_lnum(token_loc, loc);
    Error((loc, msg));
  };

let parse_stylesheet = (~loc, input: string) =>
  try(Ok(Parser.parse_stylesheet(input))) {
  | Lexer.LexingError((start_pos, end_pos, msg)) =>
    let loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    Error((loc, msg));
  | Parser.Parse_error((start_pos, end_pos, msg)) =>
    let token_loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    let loc = Parser_location.update_pos_lnum(token_loc, loc);
    Error((loc, msg));
  };

let parse_keyframes = (~loc, input: string) =>
  try(Ok(Parser.parse_keyframes(input))) {
  | Lexer.LexingError((start_pos, end_pos, msg)) =>
    let loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    Error((loc, msg));
  | Parser.Parse_error((start_pos, end_pos, msg)) =>
    let token_loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    let loc = Parser_location.update_pos_lnum(token_loc, loc);
    Error((loc, msg));
  };
