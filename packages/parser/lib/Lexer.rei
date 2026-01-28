/** Signals a lexing error at the provided source location. */
exception LexingError((Lexing.position, Lexing.position, string));

type token_with_location = {
  txt: result(Tokens.token, Tokens.error),
  loc: Ast.loc,
};

let get_next_tokens_with_location:
  Sedlexing.lexbuf => (Tokens.token, Lexing.position, Lexing.position);
let from_string: string => list(token_with_location);
let tokenize:
  string =>
  result(list((Tokens.token, Lexing.position, Lexing.position)), string);
let render_token: Tokens.token => string;
let position_to_string: Lexing.position => string;
let debug_token: ((Tokens.token, Lexing.position, Lexing.position)) => string;
let to_string: list((Tokens.token, 'a, 'b)) => string;
let to_debug:
  list((Tokens.token, Lexing.position, Lexing.position)) => string;
