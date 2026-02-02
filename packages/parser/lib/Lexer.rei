/** Signals a lexing error at the provided source location. */
exception LexingError((Lexing.position, Lexing.position, string));

type token_with_location = {
  txt: result(Tokens.token, Tokens.error),
  loc: Ast.loc,
};

let from_string:
  (~initial_mode: Lexer_context.lexer_mode, string) =>
  list(token_with_location);
let get_next_tokens_with_location:
  (~state: Lexer_context.lexer_state, Sedlexing.lexbuf) =>
  (Tokens.token, Lexing.position, Lexing.position);

let debug: list((Tokens.token, Lexing.position, Lexing.position)) => string;
