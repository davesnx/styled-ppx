module Location = Ppxlib.Location;

let menhir = MenhirLib.Convert.Simplified.traditional2revised;

let parse = (~loc: Ppxlib.location, lexbuf, parser) => {
  let last_token = ref((Tokens.EOF, Lexing.dummy_pos, Lexing.dummy_pos));

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
        Tokens.humanize(token),
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

let parse_declaration_list = (~loc, input: string) => {
  parse_string(~loc, Parser.declaration_list, input);
};

let parse_declaration = (~loc, input: string) =>
  parse_string(~loc, Parser.declaration, input);

let parse_stylesheet = (~loc, input: string) =>
  parse_string(~loc, Parser.stylesheet, input);

let parse_keyframes = (~loc, input: string) =>
  parse_string(~loc, Parser.keyframes, input);
