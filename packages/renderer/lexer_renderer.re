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
  let okInput = Styled_ppx_css_parser.Lexer.tokenize(css) |> Result.get_ok;
  let debug = Styled_ppx_css_parser.Lexer.to_debug(okInput);
  print_endline(debug);
};
