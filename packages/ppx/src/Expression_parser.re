open Ppxlib;

let parse_ocaml = source => {
  let lexbuf = Lexing.from_string(source);
  try(Ok(Parse.expression(lexbuf))) {
  | exn => Error(Printexc.to_string(exn))
  };
};

module Reason_single_parser = Reason.Reason_single_parser;
module Reason_parser_explain = Reason.Reason_parser_explain;

let parse_reason = source => {
  let lexbuf = Lexing.from_string(source);
  let init_pos = {
    Lexing.pos_fname: "",
    pos_lnum: 1,
    pos_bol: 0,
    pos_cnum: 0,
  };
  lexbuf.Lexing.lex_start_p = init_pos;
  lexbuf.Lexing.lex_curr_p = init_pos;
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

let parse_expression = (~loc, ~source) => {
  let result =
    switch (File.get()) {
    | Some(Reason)
    | Some(ReScript) => parse_reason(source)
    | Some(OCaml)
    | None => parse_ocaml(source)
    };
  Result.map(
    Styled_ppx_css_parser.Parser_location.relocate_expression(loc),
    result,
  );
};
