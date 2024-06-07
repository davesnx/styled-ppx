module Lexer = Css_lexer;
module Parser = Css_parser;
module Location = Ppxlib.Location;

let menhir = MenhirLib.Convert.Simplified.traditional2revised;

let parse = (~loc: Ppxlib.location, skip_whitespaces, lexbuf, parser) => {
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
    let loc =
      Parser_location.to_ppxlib_location(
        {
          ...start_pos,
          pos_lnum: start_pos.pos_lnum + loc.loc_start.pos_lnum - 1,
        },
        {...end_pos, pos_lnum: end_pos.pos_lnum + loc.loc_start.pos_lnum - 1},
      );
    let msg =
      Printf.sprintf(
        "Parse error while reading token '%s'",
        Tokens.token_to_string(token),
      );
    Error((loc, msg));
  };
};

let last_buffer = ref(None);

let parse_string = (~skip_whitespace, ~loc, parser, string) => {
  let buffer = Sedlexing.Latin1.from_string(string);
  last_buffer := Some(Sedlexing.Latin1.from_string(string));
  parse(~loc, skip_whitespace, buffer, parser);
};

let parse_declaration_list = (~loc, input: string) => {
  parse_string(~loc, ~skip_whitespace=false, Parser.declaration_list, input);
};

let parse_declaration = (~loc, input: string) =>
  parse_string(~loc, ~skip_whitespace=true, Parser.declaration, input);

let parse_stylesheet = (~loc, input: string) =>
  parse_string(~loc, ~skip_whitespace=false, Parser.stylesheet, input);

let parse_keyframes = (~loc, input: string) =>
  parse_string(~loc, ~skip_whitespace=false, Parser.keyframes, input);
