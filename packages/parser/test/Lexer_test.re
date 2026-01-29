open Alcotest;

module Tokens = Styled_ppx_css_parser.Tokens;
module Lexer = Styled_ppx_css_parser.Lexer;

let parse = input => {
  let values =
    Lexer.from_string(~initial_mode=Tokens.Declaration_value, input);
  let Lexer.{ loc, _ } = List.hd(values);
  let values = values |> List.map((Lexer.{ txt, _ }) => txt);
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
       | Error(err) => "Error(" ++ Tokens.show_error(err) ++ ")",
     )
  |> String.concat(" ")
  |> String.trim;

let list_tokens_to_string = tokens =>
  tokens |> List.map(render_token) |> String.concat(" ") |> String.trim;

let success_tests =
  [
    ({||}, [EOF]),
    ({|inset-3\.5|}, [IDENT("inset-3.5")]),
    ({|-inset-3\.5|}, [IDENT("-inset-3.5")]),
    ({|inset-1\/3|}, [IDENT("inset-1/3")]),
    ({|\32xl\:container|}, [IDENT("2xl:container")]),
    (" \n\t ", [EOF]),
    ({|"something"|}, [STRING("something")]),
    ({|'tuturu'|}, [STRING("tuturu")]),
    ({|#2|}, [HASH(("2", `UNRESTRICTED))]),
    ({|#abc|}, [HASH(("abc", `ID))]),
    ({|#|}, [DELIM("#")]),
    ({|(|}, [LEFT_PAREN]),
    ({|)|}, [RIGHT_PAREN]),
    ({|+12.3|}, [NUMBER(12.3)]),
    ({|+ 12.3|}, [DELIM("+"), NUMBER(12.3)]),
    ({|+|}, [DELIM("+")]),
    ({|,|}, [COMMA]),
    ({|45.6|}, [NUMBER(45.6)]),
    ({|-45.6|}, [NUMBER(-45.6)]),
    ({|45%|}, [PERCENTAGE(45.)]),
    ({|2n|}, [DIMENSION((2., "n"))]),
    ({|45.6px|}, [DIMENSION((45.6, "px"))]),
    ({|10px|}, [DIMENSION((10., "px"))]),
    ({|.5|}, [NUMBER(0.5)]),
    ({|5.|}, [NUMBER(5.), DOT]),
    ({|--potato|}, [IDENT("--potato")]),
    ({|-|}, [DELIM("-")]),
    ({|.|}, [DOT]),
    ({|*|}, [ASTERISK]),
    ({|&|}, [AMPERSAND]),
    ({|:|}, [COLON]),
    ({|::|}, [DOUBLE_COLON]),
    ({|;|}, [SEMI_COLON]),
    ({|<|}, [DELIM("<")]),
    ({|not|}, [IDENT("not")]),
    ({|not |}, [IDENT("not")]),
    ({|only|}, [IDENT("only")]),
    ({|only |}, [IDENT("only")]),
    ({|and|}, [IDENT("and")]),
    ({|and |}, [IDENT("and")]),
    ({|or |}, [IDENT("or")]),
    ({|all|}, [IDENT("all")]),
    ({|screen|}, [IDENT("screen")]),
    ({|print|}, [IDENT("print")]),
    ({|@keyframes|}, [AT_KEYFRAMES("keyframes")]),
    ({|@charset|}, [AT_RULE_STATEMENT("charset")]),
    ({|@media|}, [AT_RULE("media")]),
    ({|@mayushii|}, [AT_RULE("mayushii")]),
    ({|@|}, [DELIM("@")]),
    ({|~=|}, [DELIM("~"), DELIM("=")]),
    ({|>|}, [DELIM(">")]),
    ({|~|}, [DELIM("~")]),
    ({|[|}, [LEFT_BRACKET]),
    ({|]|}, [RIGHT_BRACKET]),
    ({|0.7|}, [NUMBER(0.7)]),
    ({|12345678.9|}, [NUMBER(12345678.9)]),
    ({|bar|}, [IDENT("bar")]),
    ({|div|}, [IDENT("div")]),
    ({|!|}, [DELIM("!")]),
    ("1 / 1", [NUMBER(1.), DELIM("/"), NUMBER(1.)]),
    (
      {|url($(Module.variable))|},
      [FUNCTION("url"), INTERPOLATION(["Module", "variable"]), RIGHT_PAREN],
    ),
    (
      {|calc(10px + 10px)|},
      [
        FUNCTION("calc"),
        DIMENSION((10., "px")),
        DELIM("+"),
        DIMENSION((10., "px")),
        RIGHT_PAREN,
      ],
    ),
    ({|+10px|}, [DIMENSION((10., "px"))]),
    (
      {|calc(10px+ 10px)|},
      [
        FUNCTION("calc"),
        DIMENSION((10., "px")),
        DELIM("+"),
        DIMENSION((10., "px")),
        RIGHT_PAREN,
      ],
    ),
    ({|calc(10%)|}, [FUNCTION("calc"), PERCENTAGE(10.), RIGHT_PAREN]),
    (
      {|background-image:url('img_tree.gif' )|},
      [
        IDENT("background-image"),
        COLON,
        FUNCTION("url"),
        STRING("img_tree.gif"),
        RIGHT_PAREN,
      ],
    ),
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
      [IDENT("div"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|
    div /*nice*/ /* nice */   /*ice*/.b {}|},
      [IDENT("div"), DOT, IDENT("b"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|
    div/*nice*//* nice *//*ice*/.b {}|},
      [IDENT("div"), DOT, IDENT("b"), LEFT_BRACE, RIGHT_BRACE],
    ),
    ({|nth-child(|}, [NTH_FUNCTION("nth-child")]),
  ]
  |> List.map(((input, output)) => {
       let (_, values) = parse(input);
       let inputTokens = list_parse_tokens_to_string(values);
       let outputTokens = list_tokens_to_string(output);

       test_case(input, `Quick, () =>
         check(string, "should match" ++ input, inputTokens, outputTokens)
       );
     });

let lexer_error_tests =
  [("/*", "Unterminated comment at the end of the string")]
  |> List.map(((input, output)) => {
       test_case(input, `Quick, () =>
         try({
           let _ =
             Lexer.from_string(~initial_mode=Tokens.Declaration_value, input);
           fail("Expected LexingError but got success");
         }) {
         | Lexer.LexingError((_, _, msg)) =>
           check(string, "should match" ++ input, msg, output)
         }
       )
     });

let soft_error_tests =
  [
    ({|"unterminated|}, "Error(Unexpected end of input)"),
    ({|'unterminated|}, "Error(Unexpected end of input)"),
    (
      "\"with\nnewline\"",
      {|Error(Unexpected newline in string) (IDENT "newline") Error(Unexpected end of input)|},
    ),
    (
      "'with\nnewline'",
      {|Error(Unexpected newline in string) (IDENT "newline'")|},
    ),
    ({|url(unterminated|}, "Error(Unexpected end of input)"),
    ({|url(bad"url)|}, "Error(Invalid URL)"),
    ({|url(bad'url)|}, "Error(Invalid URL)"),
    ("\\\n", "Error(Invalid escape sequence)"),
  ]
  |> List.map(((input, expected_output)) => {
       test_case(
         input,
         `Quick,
         () => {
           let (_, values) = parse(input);
           let output = list_parse_tokens_to_string(values);
           check(
             string,
             "should match error output for: " ++ String.escaped(input),
             output,
             expected_output,
           );
         },
       )
     });

let error_tests = lexer_error_tests @ soft_error_tests;

let test_with_location =
  [
    ({||}, [EOF], 0),
    (" \n\t ", [Tokens.EOF], 4),
    ({|"something"|}, [STRING("something")], 11),
    ({|#2|}, [HASH(("2", `UNRESTRICTED))], 2),
    ({|#abc|}, [HASH(("abc", `ID))], 4),
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
    ({|.|}, [DOT], 1),
    ({|:|}, [COLON], 1),
    ({|::|}, [DOUBLE_COLON], 2),
    ({|;|}, [SEMI_COLON], 1),
    ({|<|}, [DELIM("<")], 1),
    ({|>|}, [DELIM(">")], 1),
    ({|!important|}, [IMPORTANT], 10),
    ({|U+0025-00FF|}, [UNICODE_RANGE("U+0025-00FF")], 11),
    ({|~=|}, [DELIM("~"), DELIM("=")], 2),
    ({|@keyframes|}, [AT_KEYFRAMES("keyframes")], 10),
    ({|@mayushii|}, [AT_RULE("mayushii")], 9),
    ({|@|}, [DELIM("@")], 1),
    ({|[|}, [LEFT_BRACKET], 1),
    ("\\@desu", [IDENT("@desu")], 6),
    ({|]|}, [RIGHT_BRACKET], 1),
    ({|12345678.9|}, [NUMBER(12345678.9)], 10),
    ({|bar|}, [IDENT("bar")], 3),
    ({|div|}, [IDENT("div")], 3),
    ({|!|}, [DELIM("!")], 1),
    ("1 / 1", [NUMBER(1.), DELIM("/"), NUMBER(1.)], 5),
    (
      {|calc(10px + 10px)|},
      [
        FUNCTION("calc"),
        DIMENSION((10., "px")),
        DELIM("+"),
        DIMENSION((10., "px")),
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
        RIGHT_PAREN,
      ],
      37,
    ),
    (
      {|calc(10px+ 10px)|},
      [
        FUNCTION("calc"),
        DIMENSION((10., "px")),
        DELIM("+"),
        DIMENSION((10., "px")),
        RIGHT_PAREN,
      ],
      16,
    ),
    ({|nth-child(|}, [NTH_FUNCTION("nth-child")], 10),
    ({|calc(10%)|}, [FUNCTION("calc"), PERCENTAGE(10.), RIGHT_PAREN], 9),
    ({|$(Module.variable)|}, [INTERPOLATION(["Module", "variable"])], 18),
    ({|$(Module.variable')|}, [INTERPOLATION(["Module", "variable'"])], 19),
    ({|--color-main|}, [IDENT("--color-main")], 12),
    ({|>=|}, [GTE], 2),
    ({|<=|}, [LTE], 2),
    (
      {|url($(Module.variable'))|},
      [
        FUNCTION("url"),
        INTERPOLATION(["Module", "variable'"]),
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

let parse_with_mode = (input, mode) => {
  let values = Lexer.from_string(~initial_mode=mode, input);
  let Lexer.{ loc, _ } = List.hd(values);
  let values = values |> List.map((Lexer.{ txt, _ }) => txt);
  (loc, values);
};

let selector_mode_tests =
  [
    (
      {|&.bar,&.foo {}|},
      Tokens.Declaration_block,
      [
        AMPERSAND,
        DOT,
        TYPE_SELECTOR("bar"),
        COMMA,
        AMPERSAND,
        DOT,
        TYPE_SELECTOR("foo"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|&>a {}|},
      Tokens.Declaration_block,
      [AMPERSAND, DELIM(">"), TYPE_SELECTOR("a"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|#bar {}|},
      Tokens.Declaration_block,
      [HASH(("bar", `ID)), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|#bar{}|},
      Tokens.Declaration_block,
      [HASH(("bar", `ID)), LEFT_BRACE, RIGHT_BRACE],
    ),
  ]
  |> List.map(((input, mode, expected_output)) => {
       test_case(
         "Selector mode: " ++ input,
         `Quick,
         () => {
           let (_, values) = parse_with_mode(input, mode);
           let inputTokens = list_parse_tokens_to_string(values);
           let outputTokens = list_tokens_to_string(expected_output);
           check(
             string,
             "should match: " ++ input,
             inputTokens,
             outputTokens,
           );
         },
       )
     });

let tests =
  success_tests @ error_tests @ test_with_location @ selector_mode_tests;
