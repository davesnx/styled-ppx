let menhir = MenhirLib.Convert.Simplified.traditional2revised;

let parse = (lexbuf, parser) => {
  let last_token = ref((Parser.EOF, Lexing.dummy_pos, Lexing.dummy_pos));

  let next_token = () => {
    last_token := Lexer.get_next_tokens_with_location(lexbuf);
    last_token^;
  };

  try(Ok(menhir(parser, next_token))) {
  | Lexer.LexingError((start_pos, end_pos, msg)) =>
    Error((start_pos, end_pos, msg))
  | _ =>
    let (token, start_pos, end_pos) = last_token^;
    let msg =
      Printf.sprintf(
        "Parse error while reading token '%s'",
        Tokens.token_to_string(token),
      );
    Error((start_pos, end_pos, msg));
  };
};

let last_buffer = ref(None);

let parse_string = (parser, string) => {
  let buffer = Sedlexing.Latin1.from_string(string);
  last_buffer := Some(Sedlexing.Latin1.from_string(string));
  parse(buffer, parser);
};

let parse_declaration_list = (input: string) => {
  parse_string(Parser.declaration_list, input);
};

let parse_declaration = (input: string) => {
  parse_string(Parser.declaration, input);
};

let parse_stylesheet = (input: string) => {
  parse_string(Parser.stylesheet, input);
};

let parse_keyframes = (input: string) => {
  parse_string(Parser.keyframes, input);
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
