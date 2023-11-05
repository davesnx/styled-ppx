let render_help = () => {
  print_endline("");
  print_endline("");
  print_endline(
    {|  ast-renderer pretty-prints the CSS AST of parser/css_lexer.re|},
  );
  print_endline("");
  print_endline({|    EXAMPLE: dune exec ast-renderer ".a { color: red }"|});
  print_endline("");
  print_endline("");
};

let pos = Some(Lexing.dummy_pos);
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
  switch (Driver.parse_declaration_list(~pos, css)) {
  | Ok(declarations) =>
    print_endline(Css_types.show_rule_list(declarations))
  | Error((loc, msg)) =>
    let position = loc.Css_types.loc_start;
    let curr_char_pos = position.pos_cnum;
    print_endline(
      Printf.sprintf("Error parsing CSS: %s at pos %i", msg, curr_char_pos),
    );
  }
};
