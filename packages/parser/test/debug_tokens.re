module Tokens = Styled_ppx_css_parser.Tokens;
module Lexer = Styled_ppx_css_parser.Lexer;
module Driver = Styled_ppx_css_parser.Driver;
module Lexer_context = Styled_ppx_css_parser.Lexer_context;

let () = {
  let input = {|&[data-foo=bar] .lola {}|};
  Printf.printf("=== Input ===\n%s\n\n", input);

  Printf.printf("=== Tokens ===\n");
  let lexbuf = Sedlexing.Latin1.from_string(input);
  let state: Lexer_context.lexer_state = {
    mode: Lexer_context.Declaration_block,
    paren_depth: 0,
    brace_depth: 0,
    bracket_depth: 0,
    last_was_ident: false,
    last_was_combinator: false,
    last_was_delimiter: false,
  };
  let rec loop = () => {
    let (token, start_pos, _) =
      Lexer.get_next_tokens_with_location(~state, lexbuf);
    Printf.printf(
      "  [L%d C%d] %s\n",
      start_pos.Lexing.pos_lnum,
      start_pos.Lexing.pos_cnum - start_pos.Lexing.pos_bol,
      Tokens.to_debug(token),
    );
    switch (token) {
    | Tokens.EOF => ()
    | _ => loop()
    };
  };
  loop();

  let loc = Ppxlib.Location.none;
  Printf.printf("\n");
  switch (Driver.parse_declaration_list(~loc, input)) {
  | Error((_, msg)) => Printf.printf("Parse FAILED: %s\n", msg)
  | Ok(_) => Printf.printf("Parse OK\n")
  };
};
