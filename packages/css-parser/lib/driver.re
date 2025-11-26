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

let parse_string = (parser, string) => {
  let buffer = Sedlexing.Utf8.from_string(string);
  parse(buffer, parser);
};

let parse_declaration_list = (input: string) => {
  parse_string(Parser.declaration_list, input);
};

let parse_declaration = (input: string) => {
  parse_string(Parser.declaration, input);
};

let parse_keyframes = (input: string) => {
  parse_string(Parser.keyframes, input);
};
