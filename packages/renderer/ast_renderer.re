/* esy x ast-renderer */

let render_help = () => {
  print_endline("");
  print_endline("");
  print_endline(
    {|  ast-renderer pretty-prints the CSS AST of parser/css_lexer.re|},
  );
  print_endline("");
  print_endline({|    EXAMPLE: esy x ast-renderer ".a { color: red }"|});
  print_endline("");
  print_endline("");
};

let container_lnum = 0;
let pos = Lexing.dummy_pos;
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
  /* TODO: parse any css:
     - check if it's valid stylesheet and render it
     - check if it's a valid declaration list and render it.
     - in any other case, print both errors.
     */
  /* let ast = Css_lexer.parse_declaration_list(~container_lnum, ~pos, css);
  print_endline(render_declaration_list(ast)); */
  let ast = Css_lexer.parse_stylesheet(~container_lnum, ~pos, css);
  print_endline(Css_types.Debug.render_stylesheet(ast));
};
