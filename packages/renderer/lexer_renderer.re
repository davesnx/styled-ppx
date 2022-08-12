/* esy x lexer-renderer */

let render_help = () => {
  print_endline("");
  print_endline("");
  print_endline(
    {|  lexer-renderer pretty-prints the lexer of CSS|},
  );
  print_endline("");
  print_endline({|    EXAMPLE: esy x lexer-renderer ".a { color: red }"|});
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

let rec printUnlessIsEof = buffer => {
  let lexes = Css_lexer.get_next_token(buffer);
  switch (lexes) {
    | Css_lexer.Parser.EOF => ()
    | token => {
      token |> Css_lexer.token_to_debug |> print_endline;
      printUnlessIsEof(buffer)
    }
  }
};

switch (input, help) {
| (Some(_), true)
| (None, _) => render_help()
| (Some(css), _) =>
  let buf = Lex_buffer.of_ascii_string(css);
  printUnlessIsEof(buf);
};
