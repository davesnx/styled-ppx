let render_help = () => {
  print_endline("");
  print_endline("");
  print_endline({|  lexer-renderer pretty-prints the lexer of CSS|});
  print_endline("");
  print_endline({|    EXAMPLE: esy x lexer-renderer ".a { color: red }"|});
  print_endline("");
  print_endline("");
};

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
| (None, _) => render_help()
| (Some(css), _) =>
  let okInput =
    Styled_ppx_css_parser.Css_lexer.tokenize(css) |> Result.get_ok;
  let debug = Styled_ppx_css_parser.Css_lexer.to_debug(okInput);
  print_endline(debug);
};
