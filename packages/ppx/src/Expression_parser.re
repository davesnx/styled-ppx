open Ppxlib;

let parse_ocaml = (~start: Lexing.position, source) => {
  let lexbuf = Lexing.from_string(source);
  Lexing.set_filename(lexbuf, start.pos_fname);
  Lexing.set_position(lexbuf, start);
  try(Ok(Parse.expression(lexbuf))) {
  | exn => Error(Printexc.to_string(exn))
  };
};

module Reason_single_parser = Reason.Reason_single_parser;
module Reason_parser_explain = Reason.Reason_parser_explain;

let parse_reason = (~start: Lexing.position, source) => {
  let lexbuf = Lexing.from_string(source);
  Lexing.set_filename(lexbuf, start.pos_fname);
  Lexing.set_position(lexbuf, start);
  lexbuf.Lexing.lex_start_p = start;
  let lexer = Reason.Reason_lexer.init(lexbuf);

  let rec loop = parser => {
    let token = Reason.Reason_lexer.token(lexer);
    switch (Reason_single_parser.step(parser, token)) {
    | Intermediate(parser') => loop(parser')
    | Success(expr, _docstrings) => Ok(expr)
    | Error =>
      let (env, _) = Reason_single_parser.recovery_env(parser);
      let message = Reason_parser_explain.message(env, token);
      Error(message);
    };
  };

  let parser =
    Reason_single_parser.initial(
      Reason.Reason_parser.Incremental.parse_expression,
      lexbuf.Lexing.lex_curr_p,
    );
  loop(parser);
};

let parse_expression = (~loc: Ppxlib.location, ~source) => {
  let start = loc.loc_start;
  switch (File.get()) {
  | Some(Reason) => parse_reason(~start, source)
  | Some(OCaml)
  | None => parse_ocaml(~start, source)
  };
};
