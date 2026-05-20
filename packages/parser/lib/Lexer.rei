/** Signals a lexing error at the provided source location. */
exception LexingError((Lexing.position, Lexing.position, string));

type token_with_location = {
  txt: result(Tokens.token, Tokens.error),
  start_pos: Lexing.position,
  end_pos: Lexing.position,
};

let from_string: string => list(token_with_location);

let debug: list((Tokens.token, Lexing.position, Lexing.position)) => string;
