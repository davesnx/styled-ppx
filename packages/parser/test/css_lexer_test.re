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
  |> List.map(render_token)
  |> String.concat(" ")
  |> String.trim;

let list_tokens_to_string = tokens =>
  tokens |> List.map(render_token) |> String.concat(" ") |> String.trim;

describe("CSS Lexer", ({test, _}) => {
  let success_tests_data = Parser.([
    (" \n\t ", [WS]),
    ({|"something"|}, [STRING("something")]),
    ({|'tuturu'|}, [STRING("tuturu")]),
    /* TODO: Differentiate HASH from ID */
    ({|#2|}, [HASH("2")]),
    ({|#abc|}, [HASH("abc")]),
    ({|#|}, [DELIM("#")]),
    ({|(|}, [LEFT_PAREN]),
    ({|)|}, [RIGHT_PAREN]),
    /* TODO: Treat +1 to NUMBER and not COMBINATOR + NUMBER */
    /* ({|+12.3|}, [NUMBER("12.3")]), */
    ({|+ 12.3|}, [COMBINATOR("+"), WS, NUMBER("12.3")]),
    /* TODO: COMBINATOR or DELIM(+)? */
    ({|+|}, [COMBINATOR("+")]),
    ({|,|}, [COMMA]),
    /* TODO: Store Number as float/int */
    ({|-45.6|}, [NUMBER("-45.6")]),
    /* TODO: Store Float_dimension as float/int */
    /* TODO: Store dimension as a variant */
    ({|45.6px|}, [FLOAT_DIMENSION(("45.6", "px", Length))]),
    ({|--potato|}, [IDENT("--potato")]),
    ({|-|}, [DELIM("-")]),
    ({|.7|}, [NUMBER(".7")]),
    ({|.|}, [DOT]),
    ({|*|}, [ASTERISK]),
    ({|&|}, [AMPERSAND]),
    ({|:|}, [COLON]),
    ({|::|}, [DOUBLE_COLON]),
    ({|;|}, [SEMI_COLON]),
    /* TODO: Support comments on the lexer phase? */
    /* ({|<!--|}, [CDO]), */
    /* ({|-->|}, [CDC]), */
    ({|<|}, [DELIM("<")]),
    ({|@mayushii|}, [AT_RULE("mayushii")]),
    ({|@|}, [DELIM("@")]),
    ({|[|}, [LEFT_BRACKET]),
    ({|]|}, [RIGHT_BRACKET]),
    ({|12345678.9|}, [NUMBER("12345678.9")]),
    ({|bar|}, [IDENT("bar")]),
    ({||}, [EOF]),
    ({|!|}, [DELIM("!")]),
    ("1 / 1", [NUMBER("1"), WS, DELIM("/"), WS, NUMBER("1")]),
    (
      {|calc(10px + 10px)|},
      [
        FUNCTION("calc"),
        FLOAT_DIMENSION(("10", "px", Length)),
        WS,
        COMBINATOR("+"),
        WS,
        FLOAT_DIMENSION(("10", "px", Length)),
        RIGHT_PAREN,
      ],
    ),
    (
      {|calc(10px+ 10px)|},
      [
        FUNCTION("calc"),
        FLOAT_DIMENSION(("10", "px", Length)),
        COMBINATOR("+"),
        WS,
        FLOAT_DIMENSION(("10", "px", Length)),
        RIGHT_PAREN,
      ],
    ),
    /* TODO: Percentage should have payload? */
    ({|calc(10%)|}, [FUNCTION("calc"), NUMBER("10"), PERCENTAGE, RIGHT_PAREN]),
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
    /* TODO: Transform this as [DELIM("$"), LEFT_PAREN, IDENT("Module"), DELIM("."), IDENT("variable"), RIGHT_PAREN]) */
    ({|$(Module.variable)|}, [VARIABLE(["Module", "variable"])]),
    ({|$(Module.variable')|}, [VARIABLE(["Module", "variable'"])]),
    ({|-moz|}, [IDENT("-moz")]),
    ({|--color-main|}, [IDENT("--color-main")]),
    /* TODO: Support for escaped */
    /* ({|\32|}, [IDENT("--color-main")]), */
    /* ({|\25BA|}, [IDENT("--color-main")]), */
    /* TODO: Supported scaped "@" and others */
    /* ("\\@desu", [IDENT("@desu")]), */
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
