module Types = Ast;
module Parser = Css_parser;
module Location = Ppxlib.Location;

/** Signals a lexing error at the provided source location. */
exception LexingError((Lexing.position, Lexing.position, string));

/** Makes the lexer be aware of whitespaces or not */
let skip_whitespace: ref(bool);

type token_with_location = {
  txt: result(Tokens.token, (Tokens.token, Tokens.error)),
  loc: Types.loc,
};

let get_next_token: Sedlexing.lexbuf => Parser.token;
let get_next_tokens_with_location:
  Sedlexing.lexbuf => (Parser.token, Lexing.position, Lexing.position);
let from_string: string => result(list(token_with_location), [> | `Frozen]);
let tokenize:
  string =>
  result(list((Parser.token, Lexing.position, Lexing.position)), string);
let render_token: Parser.token => string;
let position_to_string: Lexing.position => string;
let debug_token: ((Parser.token, Lexing.position, Lexing.position)) => string;
let to_string: list((Parser.token, 'a, 'b)) => string;
let to_debug:
  list((Parser.token, Lexing.position, Lexing.position)) => string;
