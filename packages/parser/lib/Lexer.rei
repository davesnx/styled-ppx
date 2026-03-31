/** Signals a lexing error at the provided source location. */
exception LexingError((Lexing.position, Lexing.position, string));

type raw_token =
  | Raw_whitespace
  | Raw_ident(string)
  | Raw_token(Tokens.token);

type raw_token_with_location = {
  txt: result(raw_token, Tokens.error),
  start_pos: Lexing.position,
  end_pos: Lexing.position,
};

let raw_to_token: raw_token => Tokens.token;

let from_string: string => list(raw_token_with_location);

let debug: list((Tokens.token, Lexing.position, Lexing.position)) => string;
