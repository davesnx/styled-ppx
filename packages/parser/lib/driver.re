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
  | Lexer.LexingError((start_pos, end_pos, msg)) =>
    let loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    Error((loc, msg));
  | _ =>
    let (token, start_pos, end_pos) = last_token^;
    let loc = Parser_location.to_ppxlib_location(start_pos, end_pos);
    let msg =
      Printf.sprintf(
        "Parse error while reading token '%s'",
        Tokens.token_to_string(token),
      );
    Error((loc, msg));
  };
};

let container_lnum_ref: ref(option(int)) = ref(None);
let last_buffer = ref(None);

let from_string = (~pos as _initial_position: Lexing.position, ~lnum, string) => {
  let buffer = Sedlexing.Latin1.from_string(string);
  container_lnum_ref := Some(lnum);
  buffer;
};

let parse_string = (~lnum, ~skip_whitespace, ~pos, parser, string) => {
  let buffer = Sedlexing.Latin1.from_string(string);
  last_buffer := Some(from_string(~lnum, ~pos, string));
  parse(skip_whitespace, buffer, parser);
};

let parse_declaration_list = (~lnum, ~pos, input: string) => {
  parse_string(
    ~lnum,
    ~pos,
    ~skip_whitespace=false,
    Parser.declaration_list,
    input,
  );
};

let parse_declaration = (~lnum, ~pos, input: string) =>
  parse_string(~lnum, ~pos, ~skip_whitespace=true, Parser.declaration, input);

let parse_stylesheet = (~lnum, ~pos, input: string) =>
  parse_string(~lnum, ~pos, ~skip_whitespace=false, Parser.stylesheet, input);

let parse_keyframes = (~lnum, ~pos, input: string) =>
  parse_string(~lnum, ~pos, ~skip_whitespace=false, Parser.keyframes, input);
