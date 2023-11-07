module Lexer = Css_lexer;
module Parser = Css_parser;
module Location = Ppxlib.Location;

let menhir = MenhirLib.Convert.Simplified.traditional2revised;

let parse = (skip_whitespaces, lexbuf, parser) => {
  Lexer.skip_whitespace.contents = skip_whitespaces;

  let last_token = ref((Parser.EOF, Lexing.dummy_pos, Lexing.dummy_pos));

  let next_token = () => {
    last_token := Lexer.get_next_tokens_with_location(lexbuf);
    last_token^;
  };

  try(Ok(menhir(parser, next_token))) {
  | Lexer.LexingError((pos, msg)) =>
    let loc = Parser_location.make(pos, pos);
    Error((loc, msg));
  | _ =>
    let (token, start_pos, end_pos) = last_token^;
    let loc = Parser_location.make(start_pos, end_pos);
    let msg =
      Printf.sprintf(
        "Parse error while reading token '%s'",
        Tokens.token_to_string(token),
      );
    Error((loc, msg));
  };
};

let from_string = (~pos: option(Lexing.position)=?, string) => {
  let buffer = Sedlexing.Latin1.from_string(string);
  switch (pos) {
  | Some(p) => Sedlexing.set_position(buffer, p)
  | None => ()
  };
  buffer;
};

let last_buffer = ref(None);

let parse_string = (~skip_whitespace, ~pos, parser, string) => {
  let buffer = Sedlexing.Utf8.from_string(string);

  last_buffer := Some(from_string(~pos?, string));

  parse(skip_whitespace, buffer, parser);
};

let parse_declaration_list = (input: string) => {
  parse_string(~skip_whitespace=false, Parser.declaration_list, input);
};

let parse_declaration = (input: string) =>
  parse_string(~skip_whitespace=true, Parser.declaration, input);

let parse_stylesheet = (input: string) =>
  parse_string(~skip_whitespace=false, Parser.stylesheet, input);

let parse_keyframes = (input: string) =>
  parse_string(~skip_whitespace=false, Parser.keyframes, input);
