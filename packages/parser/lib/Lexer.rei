/** Signals a lexing error at the provided source location. */
exception LexingError((Lexing.position, Lexing.position, string));

type token_with_location = {
  txt: result(Tokens.token, Tokens.error),
  loc: Ast.loc,
};

let from_string:
  (~initial_mode: Tokens.lexer_mode, string) => list(token_with_location);
let get_next_tokens_with_location:
  (~state: Tokens.lexer_state, Sedlexing.lexbuf) =>
  (Tokens.token, Lexing.position, Lexing.position);

let debug: list((Tokens.token, Lexing.position, Lexing.position)) => string;
