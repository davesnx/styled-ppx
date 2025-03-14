open Alcotest;

module Tokens = Styled_ppx_css_parser.Tokens;
module Lexer = Styled_ppx_css_parser.Lexer;
module Parser = Styled_ppx_css_parser.Parser;

let success_tests =
  [
    (
      {|url($(Module.variable))|},
      [FUNCTION("url"), INTERPOLATION(["Module", "variable"]), RIGHT_PAREN],
    ),
    ({|inset-3\.5|}, [IDENT("inset-3.5")]),
    ({|-inset-3\.5|}, [IDENT("-inset-3.5")]),
    ({|inset-1\/3|}, [IDENT("inset-1/3")]),
    ({|\32xl\:container|}, [IDENT("2xl:container")]),
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
    ({|<|}, [DELIM("<")]),
    ({|not|}, [IDENT("not")]),
    ({|not |}, [IDENT("not"), WS]),
    ({|only|}, [IDENT("only")]),
    ({|only |}, [IDENT("only"), WS]),
    ({|and|}, [IDENT("and")]),
    ({|and |}, [IDENT("and"), WS]),
    ({|or |}, [IDENT("or"), WS]),
    ({|all|}, [IDENT("all")]),
    ({|screen|}, [IDENT("screen")]),
    ({|print|}, [IDENT("print")]),
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
       let okInput = Lexer.tokenize(input) |> Result.get_ok;
       let inputTokens = Lexer.to_string(okInput);
       let outputTokens =
         output
         |> List.map(token => (token, Lexing.dummy_pos, Lexing.dummy_pos))
         |> Lexer.to_string;

       test_case(input, `Quick, () =>
         check(string, "should match" ++ input, inputTokens, outputTokens)
       );
     });

let error_tests =
  [("/*", "Unterminated comment at the end of the string")]
  |> List.map(((input, output)) => {
       let error = Lexer.tokenize(input) |> Result.get_error;
       test_case(input, `Quick, () =>
         check(string, "should match" ++ input, error, output)
       );
     });

let parse = input => {
  let values =
    switch (Lexer.from_string(input)) {
    | Ok(values) => values
    | Error(`Frozen) => failwith("Lexer got frozen")
    };

  let Lexer.{loc, _} = List.hd(values);
  let values = values |> List.map((Lexer.{txt, _}) => txt);
  (loc, values);
};

let render_token =
  fun
  | Tokens.EOF => ""
  | t => Tokens.show_token(t);

let list_parse_tokens_to_string = tokens =>
  tokens
  |> List.rev
  |> List.map(
       fun
       | Ok(token) => render_token(token)
       | Error((token, err)) =>
         "Error("
         ++ Tokens.show_error(err)
         ++ ") "
         ++ Tokens.show_token(token),
     )
  |> String.concat(" ")
  |> String.trim;

let list_tokens_to_string = tokens =>
  tokens |> List.map(render_token) |> String.concat(" ") |> String.trim;

let test_with_location =
  [
    ({||}, [EOF], 0),
    (" \n\t ", [Tokens.WS], 4),
    ({|"something"|}, [STRING("something")], 11),
    // TODO: is that right?
    ({|#2|}, [HASH("2", `UNRESTRICTED)], 2),
    ({|#abc|}, [HASH("abc", `ID)], 4),
    ({|#|}, [DELIM("#")], 1),
    ({|'tuturu'|}, [STRING("tuturu")], 8),
    ({|(|}, [LEFT_PAREN], 1),
    ({|)|}, [RIGHT_PAREN], 1),
    ({|+12.3|}, [NUMBER(12.3)], 5),
    ({|+|}, [DELIM("+")], 1),
    ({|,|}, [COMMA], 1),
    ({|-45.6|}, [NUMBER(-45.6)], 5),
    ({|--potato|}, [IDENT("--potato")], 8),
    ({|-|}, [DELIM("-")], 1),
    ({|.7|}, [NUMBER(0.7)], 2),
    ({|.|}, [DELIM(".")], 1),
    ({|:|}, [COLON], 1),
    ({|;|}, [SEMI_COLON], 1),
    ({|<|}, [DELIM("<")], 1),
    ({|@mayushii|}, [AT_KEYWORD("mayushii")], 9),
    ({|@|}, [DELIM("@")], 1),
    ({|[|}, [LEFT_BRACKET], 1),
    ("\\@desu", [IDENT("@desu")], 6),
    ({|]|}, [RIGHT_BRACKET], 1),
    ({|12345678.9|}, [NUMBER(12345678.9)], 10),
    ({|bar|}, [IDENT("bar")], 3),
    ({|!|}, [DELIM("!")], 1),
    ("1 / 1", [NUMBER(1.), WS, DELIM("/"), WS, NUMBER(1.)], 5),
    (
      {|calc(10px + 10px)|},
      [
        FUNCTION("calc"),
        DIMENSION(10., "px"),
        WS,
        DELIM("+"),
        WS,
        DIMENSION(10., "px"),
        RIGHT_PAREN,
      ],
      17,
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
      37,
    ),
    (
      {|calc(10px+ 10px)|},
      [
        FUNCTION("calc"),
        DIMENSION(10., "px"),
        DELIM("+"),
        WS,
        DIMENSION(10., "px"),
        RIGHT_PAREN,
      ],
      16,
    ),
    ({|calc(10%)|}, [FUNCTION("calc"), PERCENTAGE(10.), RIGHT_PAREN], 9),
    (
      {|$(Module.variable)|},
      [
        DELIM("$"),
        LEFT_PAREN,
        IDENT("Module"),
        DELIM("."),
        IDENT("variable"),
        RIGHT_PAREN,
      ],
      18,
    ),
    (
      {|$(Module.variable')|},
      [
        DELIM("$"),
        LEFT_PAREN,
        IDENT("Module"),
        DELIM("."),
        IDENT("variable'"),
        RIGHT_PAREN,
      ],
      19,
    ),
    ({|--color-main|}, [IDENT("--color-main")], 12),
    ({|>=|}, [GTE], 2),
    ({|<=|}, [LTE], 2),
    (
      {|url($(Module.variable'))|},
      [
        FUNCTION("url"),
        DELIM("$"),
        LEFT_PAREN,
        IDENT("Module"),
        DELIM("."),
        IDENT("variable'"),
        RIGHT_PAREN,
        RIGHT_PAREN,
      ],
      24,
    ),
  ]
  |> List.mapi((_index, (input, output, last_position)) => {
       let (loc, values) = parse(input);

       loc.loc_end.pos_cnum == last_position
         ? ()
         : Alcotest.fail(
             "position should be "
             ++ string_of_int(last_position)
             ++ " received "
             ++ string_of_int(loc.loc_end.pos_cnum),
           );

       let assertion = () =>
         Alcotest.check(
           Alcotest.string,
           "should succeed lexing: " ++ input,
           list_parse_tokens_to_string(values),
           list_tokens_to_string(output),
         );

       Alcotest.test_case(input, `Quick, assertion);
     });

let tests = success_tests @ error_tests @ test_with_location;
