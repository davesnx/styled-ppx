let menhir = MenhirLib.Convert.Simplified.traditional2revised;

let parse = (~loc, lexbuf, parser) => {
  let last_token = ref((Parser.EOF, Lexing.dummy_pos, Lexing.dummy_pos));

  let next_token = () => {
    last_token := Lexer.get_next_tokens_with_location(lexbuf);
    last_token^;
  };

  try(Ok(menhir(parser, next_token))) {
  | Lexer.LexingError((start_pos, end_pos, msg)) =>
    let loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    Error((loc, msg));
  | _ =>
    let (token, start_pos, end_pos) = last_token^;
    let token_loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    let loc = Parser_location.update_pos_lnum(token_loc, loc);
    let msg =
      Printf.sprintf(
        "Parse error while reading token '%s'",
        Tokens.token_to_string(token),
      );
    Error((loc, msg));
  };
};

let last_buffer = ref(None);

let parse_string = (~loc, parser, string) => {
  let buffer = Sedlexing.Latin1.from_string(string);
  last_buffer := Some(Sedlexing.Latin1.from_string(string));
  parse(~loc, buffer, parser);
};

let parse_declaration_list = (~loc, ~delimiter=None, input: string) => {
  let loc_with_delimiter =
    Parser_location.update_loc_with_delimiter(loc, delimiter);
  parse_string(~loc=loc_with_delimiter, Parser.declaration_list, input);
};

let parse_declaration = (~loc, ~delimiter=None, input: string) => {
  let loc_with_delimiter =
    Parser_location.update_loc_with_delimiter(loc, delimiter);
  parse_string(~loc=loc_with_delimiter, Parser.declaration, input);
};

let parse_stylesheet = (~loc, ~delimiter=None, input: string) => {
  let loc_with_delimiter =
    Parser_location.update_loc_with_delimiter(loc, delimiter);
  parse_string(~loc=loc_with_delimiter, Parser.stylesheet, input);
};

let parse_keyframes = (~loc, ~delimiter, input: string) => {
  let loc_with_delimiter =
    Parser_location.update_loc_with_delimiter(loc, delimiter);
  parse_string(~loc=loc_with_delimiter, Parser.keyframes, input);
};

let source_code_of_loc = ({loc_start, loc_end, _}: Ast.loc) => {
  switch (last_buffer^) {
  | Some(buffer: Sedlexing.lexbuf) =>
    /* TODO: pos_offset is hardcoded to 0, unsure about the effects */
    let pos_offset = 0;
    let loc_start = loc_start.pos_cnum - pos_offset;
    let loc_end = loc_end.pos_cnum - pos_offset;
    Sedlexing.Latin1.sub_lexeme(buffer, loc_start, loc_end - loc_start)
    /* String.trim is a hack, location should be correct and not contain any whitespace */
    |> String.trim;
  | None => assert(false)
  };
};
