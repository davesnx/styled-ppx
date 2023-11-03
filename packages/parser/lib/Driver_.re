module Lexer = Css_lexer;
module Parser = Css_parser;
module Location = Ppxlib.Location;
module Sedlexing = Sedlexing;

exception LexingError((Lexing.position, string));

let menhir = MenhirLib.Convert.Simplified.traditional2revised;

let parse = (skip_whitespaces, buf, parser) => {
  Lexer.skip_whitespace.contents = skip_whitespaces;

  let last_token = ref((Parser.EOF, Lexing.dummy_pos, Lexing.dummy_pos));

  let next_token = () => {
    last_token := Lexer.get_next_tokens_with_location(buf);
    last_token^;
  };

  try(Ok(menhir(parser, next_token))) {
  | LexingError((pos, msg)) =>
    let loc = Lex_buffer.make_loc(pos, pos);
    Error((loc, msg));
  | _ =>
    let (token, start_pos, end_pos) = last_token^;
    let loc = Lex_buffer.make_loc(start_pos, end_pos);
    let msg =
      Printf.sprintf(
        "Parse error while reading token '%s'",
        Lexer.token_to_string(token),
      );
    Error((loc, msg));
  };
};

let parse_string =
    (~skip_whitespace, ~container_lnum=?, ~pos=?, parser, string) => {
  parse(
    skip_whitespace,
    Lex_buffer.from_string(~container_lnum?, ~pos?, string),
    parser,
  );
};

let parse_declaration_list = (~container_lnum=?, ~pos=?, input: string) => {
  parse_string(
    ~skip_whitespace=false,
    ~container_lnum?,
    ~pos?,
    Parser.declaration_list,
    input,
  );
};

let parse_declaration = (~container_lnum=?, ~pos=?, input: string) =>
  parse_string(
    ~skip_whitespace=true,
    ~container_lnum?,
    ~pos?,
    Parser.declaration,
    input,
  );

let parse_stylesheet = (~container_lnum=?, ~pos=?, input: string) =>
  parse_string(
    ~skip_whitespace=false,
    ~container_lnum?,
    ~pos?,
    Parser.stylesheet,
    input,
  );

let parse_keyframes = (~container_lnum=?, ~pos=?, input: string) =>
  parse_string(
    ~skip_whitespace=false,
    ~container_lnum?,
    ~pos?,
    Parser.keyframes,
    input,
  );
