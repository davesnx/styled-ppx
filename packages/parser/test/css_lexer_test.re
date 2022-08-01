open Setup;

module Lexer = Css_lexer;
module Parser = Css_lexer.Parser;

let parse = input => {
  let buffer = Sedlexing.Utf8.from_string(input) |> Lex_buffer.of_sedlex;
  let rec from_string = acc => {
    switch (Lexer.get_next_token(buffer)) {
      | Parser.EOF => []
      | token => [token, ...from_string(acc)]
    }
  }

  from_string([])
};

let render_token =
  fun
  | Parser.EOF => ""
  | t => Lexer.token_to_debug(t);

let list_parse_tokens_to_string = tokens =>
  tokens
  |> List.rev
  |> List.map(render_token)
  |> String.concat(" ")
  |> String.trim;

let list_tokens_to_string = tokens =>
  tokens |> List.map(render_token) |> String.concat(" ") |> String.trim;

describe("CSS Lexer", ({test, _}) => {
  let success_tests_data = Parser.([
    (" \n\t ", [WS]),
    ({|"something"|}, [STRING("something")]),
    // TODO: is that right?
    /* ({|#2|}, [HASH("2", `UNRESTRICTED)]), */
    /* ({|#abc|}, [HASH("abc", `ID)]), */
    ({|#|}, [DELIM("#")]),
    ({|'tuturu'|}, [STRING("tuturu")]),
    ({|(|}, [LEFT_PAREN]),
    ({|)|}, [RIGHT_PAREN]),
    /* ({|+12.3|}, [NUMBER(12.3)]), */
    /* ({|+|}, [DELIM("+")]), */
    ({|,|}, [COMMA]),
    /* ({|-45.6|}, [NUMBER(-45.6)]), */
    /* ({|-->|}, [CDC]), */
    ({|--potato|}, [IDENT("--potato")]),
    ({|-|}, [DELIM("-")]),
    /* ({|.7|}, [NUMBER(0.7)]), */
    ({|.|}, [DOT]),
    ({|:|}, [COLON]),
    ({|;|}, [SEMI_COLON]),
    /* ({|<!--|}, [CDO]), */
    ({|<|}, [DELIM("<")]),
    /* ({|@mayushii|}, [AT_KEYWORD("mayushii")]), */
    ({|@|}, [DELIM("@")]),
    ({|[|}, [LEFT_BRACKET]),
    /* ("\\@desu", [IDENT("@desu")]), */
    ({|]|}, [RIGHT_BRACKET]),
    /* ({|12345678.9|}, [NUMBER(12345678.9)]), */
    ({|bar|}, [IDENT("bar")]),
    ({||}, [EOF]),
    ({|!|}, [DELIM("!")]),
    /* ("1 / 1", [NUMBER(1.), WS, DELIM("/"), WS, NUMBER(1.)]), */
    /* (
      {|calc(10px + 10px)|},
      [
        FUNCTION("calc"),
        FLOAT_DIMENSION(("10", "px", Length)),
        WS,
        DELIM("+"),
        WS,
        FLOAT_DIMENSION(("10", "px", Length)),
        RIGHT_PAREN,
      ],
    ),
    (
      {|background-image:url('img_tree.gif' )|},
      [
        IDENT("background-image"),
        COLON,
        FUNCTION("url"),
        STRING("img_tree.gif"),
        WS,
        RIGHT_PAREN,
      ],
    ),
    (
      {|calc(10px+ 10px)|},
      [
        FUNCTION("calc"),
        FLOAT_DIMENSION(("10", "px", Length)),
        DELIM("+"),
        WS,
        FLOAT_DIMENSION(("10", "px", Length)),
        RIGHT_PAREN,
      ],
    ),
  ({|calc(10%)|}, [FUNCTION("calc"), PERCENTAGE, RIGHT_PAREN]),
    ({|$(Module.variable)|}, [DELIM("$"), LEFT_PAREN, IDENT("Module"), DELIM("."), IDENT("variable"), RIGHT_PAREN]),
    ({|$(Module.variable')|}, [DELIM("$"), LEFT_PAREN, IDENT("Module"), DELIM("."), IDENT("variable'"), RIGHT_PAREN]), */
  ]);

  success_tests_data
  |> List.iter(((input, output)) =>
       test(
         "should succed lexing: " ++ input,
         ({expect, _}) => {
           let inputTokens = list_parse_tokens_to_string(parse(input));
           let outputTokens = list_tokens_to_string(output);
           expect.string(inputTokens).toEqual(outputTokens);
         },
       )
     );
});
