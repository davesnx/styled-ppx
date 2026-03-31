let args = Sys.argv |> Array.to_list;
let input = List.nth_opt(args, 1);
let help =
  List.exists(
    arg =>
      arg == "--help"
      || arg == "-help"
      || arg == "help"
      || arg == "--h"
      || arg == "-h",
    args,
  );

switch (input, help) {
| (Some(_), true)
| (None, _) =>
  print_endline(
    "\n  `lexer-renderer` pretty-prints the result of CSS lexering of the input string.

  EXAMPLE: dune exec lexer-renderer \".a { color: red }\"\n",
  )
| (Some(css), _) =>
  let tokens = Styled_ppx_css_parser.Lexer.from_string(css);
  let okInput =
    tokens
    |> List.filter_map(({ Styled_ppx_css_parser.Lexer.txt, start_pos, end_pos }) =>
         switch (txt) {
         | Ok(token) =>
           Some((Styled_ppx_css_parser.Lexer.raw_to_token(token), start_pos, end_pos))
         | Error(_) => None
         }
       )
  let debug = Styled_ppx_css_parser.Lexer.debug(okInput);
  print_endline(debug);
};
