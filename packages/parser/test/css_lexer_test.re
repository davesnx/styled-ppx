open Alcotest;
module Parser = Css_parser;

let success_tests =
  [
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
    ({|+12.3|}, [COMBINATOR("+"), NUMBER("12.3")]),
    ({|+ 12.3|}, [COMBINATOR("+"), WS, NUMBER("12.3")]),
    /* TODO: Disambiguate + sign. Either COMBINATOR(+) or DELIM(+) */
    ({|+|}, [COMBINATOR("+")]),
    ({|,|}, [COMMA]),
    ({|45.6|}, [NUMBER("45.6")]),
    ({|-45.6|}, [NUMBER("-45.6")]),
    ({|45%|}, [NUMBER("45"), PERCENT]),
    ({|2n|}, [DIMENSION(("2", "n"))]),
    /* TODO: Store Float_dimension as float/int */
    /* TODO: Store dimension as a variant */
    ({|45.6px|}, [FLOAT_DIMENSION(("45.6", "px"))]),
    ({|10px|}, [FLOAT_DIMENSION(("10", "px"))]),
    ({|.5|}, [NUMBER(".5")]),
    /* TODO: Treat 5. as NUMBER("5.0") */
    ({|5.|}, [NUMBER("5"), DOT]),
    ({|--potato|}, [IDENT("--potato")]),
    ({|-|}, [DELIM("-")]),
    ({|.|}, [DOT]),
    ({|*|}, [ASTERISK]),
    ({|&|}, [AMPERSAND]),
    ({|:|}, [COLON]),
    ({|::|}, [DOUBLE_COLON]),
    ({|;|}, [SEMI_COLON]),
    /* TODO: Support comments in the lexer? */
    /* ({|<!--|}, [CDO]), */
    /* ({|-->|}, [CDC]), */
    ({|<|}, [MEDIA_FEATURE_COMPARISON("<")]),
    ({|not|}, [IDENT("not")]),
    ({|not |}, [MEDIA_QUERY_OPERATOR("not ")]),
    ({|only|}, [IDENT("only")]),
    ({|only |}, [MEDIA_QUERY_OPERATOR("only ")]),
    ({|and|}, [IDENT("and")]),
    ({|and |}, [MEDIA_QUERY_OPERATOR("and ")]),
    ({|or |}, [MEDIA_QUERY_OPERATOR("or ")]),
    ({|all|}, [ALL_MEDIA_TYPE("all")]),
    ({|screen|}, [SCREEN_MEDIA_TYPE("screen")]),
    ({|print|}, [PRINT_MEDIA_TYPE("print")]),
    ({|@mayushii|}, [AT_RULE("mayushii")]),
    ({|@|}, [DELIM("@")]),
    ({|[|}, [LEFT_BRACKET]),
    ({|]|}, [RIGHT_BRACKET]),
    ({|0.7|}, [NUMBER("0.7")]),
    ({|12345678.9|}, [NUMBER("12345678.9")]),
    ({|bar|}, [IDENT("bar")]),
    ({||}, [EOF]),
    ({|!|}, [DELIM("!")]),
    ("1 / 1", [NUMBER("1"), WS, DELIM("/"), WS, NUMBER("1")]),
    (
      {|calc(10px + 10px)|},
      [
        FUNCTION("calc"),
        FLOAT_DIMENSION(("10", "px")),
        WS,
        COMBINATOR("+"),
        WS,
        FLOAT_DIMENSION(("10", "px")),
        RIGHT_PAREN,
      ],
    ),
    ({|+10px|}, [COMBINATOR("+"), FLOAT_DIMENSION(("10", "px"))]),
    (
      {|calc(10px+ 10px)|},
      [
        FUNCTION("calc"),
        FLOAT_DIMENSION(("10", "px")),
        COMBINATOR("+"),
        WS,
        FLOAT_DIMENSION(("10", "px")),
        RIGHT_PAREN,
      ],
    ),
    /* TODO: Percentage should have payload? */
    (
      {|calc(10%)|},
      [FUNCTION("calc"), NUMBER("10"), PERCENT, RIGHT_PAREN],
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
    /* TODO: Transform this as [DELIM("$"), LEFT_PAREN, IDENT("Module"), DELIM("."), IDENT("variable"), RIGHT_PAREN]) */
    ({|$(Module.variable)|}, [INTERPOLATION(["Module", "variable"])]),
    ({|$(Module.variable')|}, [INTERPOLATION(["Module", "variable'"])]),
    ({|-moz|}, [IDENT("-moz")]),
    ({|--color-main|}, [IDENT("--color-main")]),
    (
      {|
    /* nice */
    /* nice */


    /* nice */
    /* nice */

    div {}|},
      [WS, TAG("div"), WS, LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|
    div /*nice*/ /* nice */   /*ice*/.b {}|},
      [WS, TAG("div"), WS, DOT, TAG("b"), WS, LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|
    div/*nice*//* nice *//*ice*/.b {}|},
      [WS, TAG("div"), DOT, TAG("b"), WS, LEFT_BRACE, RIGHT_BRACE],
    ),
    /* TODO: Support for escaped */
    /* ({|\32|}, [NUMBER("\32")]), */
    /* ({|\25BA|}, [NUMBER "\25BA"]), */
    /* TODO: Support escaped "@" and others */
    /* ("\\@desu", [IDENT("@desu")]), */
  ]
  |> List.map(((input, output)) => {
       let okInput = Css_lexer.tokenize(input) |> Result.get_ok;
       let inputTokens = Css_lexer.to_string(okInput);
       let outputTokens =
         output
         |> List.map(token => (token, Lexing.dummy_pos, Lexing.dummy_pos))
         |> Css_lexer.to_string;

       test_case(input, `Quick, () =>
         check(string, "should match" ++ input, inputTokens, outputTokens)
       );
     });

let error_tests =
  [("/*", "Unterminated comment at the end of the string")]
  |> List.map(((input, output)) => {
       let error = Css_lexer.tokenize(input) |> Result.get_error;
       test_case(input, `Quick, () =>
         check(string, "should match" ++ input, error, output)
       );
     });

let tests = List.append(success_tests, error_tests);
