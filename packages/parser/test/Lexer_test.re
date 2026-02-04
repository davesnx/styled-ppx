open Alcotest;

module Tokens = Styled_ppx_css_parser.Tokens;
module Lexer = Styled_ppx_css_parser.Lexer;
module Lexer_context = Styled_ppx_css_parser.Lexer_context;

let parse = input => {
  let values =
    Lexer.from_string(~initial_mode=Lexer_context.Declaration_value, input);
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
    (" \n\t ", [WS]),
    ({|"something"|}, [STRING("something")]),
    ({|'tuturu'|}, [STRING("tuturu")]),
    ({|#2|}, [HASH(("2", `UNRESTRICTED))]),
    ({|#abc|}, [HASH(("abc", `ID))]),
    ({|#|}, [DELIM('#')]),
    ({|(|}, [LEFT_PAREN]),
    ({|)|}, [RIGHT_PAREN]),
    ({|+12.3|}, [NUMBER(12.3)]),
    ({|+ 12.3|}, [PLUS, WS, NUMBER(12.3)]),
    ({|+|}, [PLUS]),
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
    ({|-|}, [MINUS]),
    ({|.|}, [DOT]),
    ({|*|}, [ASTERISK]),
    ({|&|}, [AMPERSAND]),
    ({|:|}, [COLON]),
    ({|::|}, [DOUBLE_COLON]),
    ({|;|}, [SEMI_COLON]),
    ({|<|}, [LESS_THAN]),
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
    ({|@keyframes|}, [AT_KEYFRAMES("keyframes")]),
    ({|@charset|}, [AT_RULE_STATEMENT("charset")]),
    ({|@media|}, [AT_RULE("media")]),
    ({|@mayushii|}, [AT_RULE("mayushii")]),
    ({|@|}, [DELIM('@')]),
    ({|~=|}, [TILDE, EQUALS]),
    ({|>|}, [GREATER_THAN]),
    ({|~|}, [TILDE]),
    ({|[|}, [LEFT_BRACKET]),
    ({|]|}, [RIGHT_BRACKET]),
    ({|0.7|}, [NUMBER(0.7)]),
    ({|12345678.9|}, [NUMBER(12345678.9)]),
    ({|bar|}, [IDENT("bar")]),
    ({|div|}, [IDENT("div")]),
    ({|!|}, [EXCLAMATION]),
    ("1 / 1", [NUMBER(1.), WS, SLASH, WS, NUMBER(1.)]),
    (
      {|url($(Module.variable))|},
      [
        FUNCTION("url"),
        INTERPOLATION(("Module.variable", Ppxlib.Location.none)),
        RIGHT_PAREN,
      ],
    ),
    (
      {|calc(10px + 10px)|},
      [
        FUNCTION("calc"),
        DIMENSION((10., "px")),
        WS,
        PLUS,
        WS,
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
        PLUS,
        WS,
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
        WS,
        RIGHT_PAREN,
      ],
    ),
    (
      {|$(Module.variable)|},
      [INTERPOLATION(("Module.variable", Ppxlib.Location.none))],
    ),
    (
      {|$(Module.variable')|},
      [INTERPOLATION(("Module.variable'", Ppxlib.Location.none))],
    ),
    (
      {|$(match prop with | Big -> CSS.red | Small -> CSS.blue)|},
      [
        INTERPOLATION((
          "match prop with | Big -> CSS.red | Small -> CSS.blue",
          Ppxlib.Location.none,
        )),
      ],
    ),
    (
      {|$(switch (prop) { | Big => `red | Small => `blue })|},
      [
        INTERPOLATION((
          "switch (prop) { | Big => `red | Small => `blue }",
          Ppxlib.Location.none,
        )),
      ],
    ),
    (
      {|$({ let x = 1; x + 1 })|},
      [INTERPOLATION(("{ let x = 1; x + 1 }", Ppxlib.Location.none))],
    ),
    (
      {|$(f(x) /* comment */ + 1)|},
      [INTERPOLATION(("f(x) /* comment */ + 1", Ppxlib.Location.none))],
    ),
    (
      {|$(if (x) { a } else { b })|},
      [INTERPOLATION(("if (x) { a } else { b }", Ppxlib.Location.none))],
    ),
    ({|-moz|}, [IDENT("-moz")]),
    ({|--color-main|}, [IDENT("--color-main")]),
    (
      {|
    /* nice */
    /* nice */


    /* nice */
    /* nice */

    div {}|},
      [WS, IDENT("div"), WS, LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|
    div /*nice*/ /* nice */   /*ice*/.b {}|},
      [WS, IDENT("div"), WS, DOT, IDENT("b"), WS, LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|
    div/*nice*//* nice *//*ice*/.b {}|},
      [WS, IDENT("div"), DOT, IDENT("b"), WS, LEFT_BRACE, RIGHT_BRACE],
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
             Lexer.from_string(
               ~initial_mode=Lexer_context.Declaration_value,
               input,
             );
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
    ({|$(unclosed|}, "Error(Unclosed interpolation: expected ')' to close)"),
    (
      {|$("unterminated|},
      "Error(Unclosed string literal inside interpolation)",
    ),
    ({|$('\\|}, "Error(Unclosed char literal inside interpolation)"),
    (
      {|$(f (* unclosed comment|},
      "Error(Unclosed comment inside interpolation)",
    ),
    (
      {|$(switch (x) { | A => a|},
      "Error(Unclosed brace inside interpolation)",
    ),
    ({|$({ let x = 1;|}, "Error(Unclosed brace inside interpolation)"),
    ({|$(f(x) /* unclosed|}, "Error(Unclosed comment inside interpolation)"),
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
    (" \n\t ", [Tokens.WS], 4),
    ({|"something"|}, [STRING("something")], 11),
    ({|#2|}, [HASH(("2", `UNRESTRICTED))], 2),
    ({|#abc|}, [HASH(("abc", `ID))], 4),
    ({|#|}, [DELIM('#')], 1),
    ({|'tuturu'|}, [STRING("tuturu")], 8),
    ({|(|}, [LEFT_PAREN], 1),
    ({|)|}, [RIGHT_PAREN], 1),
    ({|+12.3|}, [NUMBER(12.3)], 5),
    ({|+|}, [PLUS], 1),
    ({|,|}, [COMMA], 1),
    ({|-45.6|}, [NUMBER(-45.6)], 5),
    ({|--potato|}, [IDENT("--potato")], 8),
    ({|-|}, [MINUS], 1),
    ({|.7|}, [NUMBER(0.7)], 2),
    ({|.|}, [DOT], 1),
    ({|:|}, [COLON], 1),
    ({|::|}, [DOUBLE_COLON], 2),
    ({|;|}, [SEMI_COLON], 1),
    ({|<|}, [LESS_THAN], 1),
    ({|>|}, [GREATER_THAN], 1),
    ({|!important|}, [IMPORTANT], 10),
    ({|U+0025-00FF|}, [UNICODE_RANGE("U+0025-00FF")], 11),
    ({|~=|}, [TILDE, EQUALS], 2),
    ({|@keyframes|}, [AT_KEYFRAMES("keyframes")], 10),
    ({|@mayushii|}, [AT_RULE("mayushii")], 9),
    ({|@|}, [DELIM('@')], 1),
    ({|[|}, [LEFT_BRACKET], 1),
    ("\\@desu", [IDENT("@desu")], 6),
    ({|]|}, [RIGHT_BRACKET], 1),
    ({|12345678.9|}, [NUMBER(12345678.9)], 10),
    ({|bar|}, [IDENT("bar")], 3),
    ({|div|}, [IDENT("div")], 3),
    ({|!|}, [EXCLAMATION], 1),
    ("1 / 1", [NUMBER(1.), WS, SLASH, WS, NUMBER(1.)], 5),
    (
      {|calc(10px + 10px)|},
      [
        FUNCTION("calc"),
        DIMENSION((10., "px")),
        WS,
        PLUS,
        WS,
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
        WS,
        RIGHT_PAREN,
      ],
      37,
    ),
    (
      {|calc(10px+ 10px)|},
      [
        FUNCTION("calc"),
        DIMENSION((10., "px")),
        PLUS,
        WS,
        DIMENSION((10., "px")),
        RIGHT_PAREN,
      ],
      16,
    ),
    ({|nth-child(|}, [NTH_FUNCTION("nth-child")], 10),
    ({|calc(10%)|}, [FUNCTION("calc"), PERCENTAGE(10.), RIGHT_PAREN], 9),
    (
      {|$(Module.variable)|},
      [INTERPOLATION(("Module.variable", Ppxlib.Location.none))],
      18,
    ),
    (
      {|$(Module.variable')|},
      [INTERPOLATION(("Module.variable'", Ppxlib.Location.none))],
      19,
    ),
    ({|--color-main|}, [IDENT("--color-main")], 12),
    ({|>=|}, [GTE], 2),
    ({|<=|}, [LTE], 2),
    (
      {|url($(Module.variable'))|},
      [
        FUNCTION("url"),
        INTERPOLATION(("Module.variable'", Ppxlib.Location.none)),
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
      [AMPERSAND, GREATER_THAN, TYPE_SELECTOR("a"), LEFT_BRACE, RIGHT_BRACE],
    ),
    ({|#bar {}|}, [HASH(("bar", `ID)), LEFT_BRACE, RIGHT_BRACE]),
    ({|#bar{}|}, [HASH(("bar", `ID)), LEFT_BRACE, RIGHT_BRACE]),
  ]
  |> List.map(((input, expected_output)) => {
       test_case(
         "Selector mode: " ++ input,
         `Quick,
         () => {
           let (_, values) =
             parse_with_mode(input, Lexer_context.Declaration_block);
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

let toplevel_mode_tests =
  [
    // Type selectors
    ({|div {}|}, [TYPE_SELECTOR("div"), LEFT_BRACE, RIGHT_BRACE]),
    ({|span {}|}, [TYPE_SELECTOR("span"), LEFT_BRACE, RIGHT_BRACE]),
    ({|a {}|}, [TYPE_SELECTOR("a"), LEFT_BRACE, RIGHT_BRACE]),
    ({|h1 {}|}, [TYPE_SELECTOR("h1"), LEFT_BRACE, RIGHT_BRACE]),
    (
      {|custom-element {}|},
      [TYPE_SELECTOR("custom-element"), LEFT_BRACE, RIGHT_BRACE],
    ),
    // Class selectors
    ({|.class {}|}, [DOT, TYPE_SELECTOR("class"), LEFT_BRACE, RIGHT_BRACE]),
    (
      {|.my-class {}|},
      [DOT, TYPE_SELECTOR("my-class"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|.class1.class2 {}|},
      [
        DOT,
        TYPE_SELECTOR("class1"),
        DOT,
        TYPE_SELECTOR("class2"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    // ID selectors
    ({|#id {}|}, [HASH(("id", `ID)), LEFT_BRACE, RIGHT_BRACE]),
    ({|#my-id {}|}, [HASH(("my-id", `ID)), LEFT_BRACE, RIGHT_BRACE]),
    // Universal selector
    ({|* {}|}, [ASTERISK, LEFT_BRACE, RIGHT_BRACE]),
    (
      {|*.class {}|},
      [ASTERISK, DOT, TYPE_SELECTOR("class"), LEFT_BRACE, RIGHT_BRACE],
    ),
    // Combining type + class + id
    (
      {|div.class {}|},
      [
        TYPE_SELECTOR("div"),
        DOT,
        TYPE_SELECTOR("class"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|div#id {}|},
      [TYPE_SELECTOR("div"), HASH(("id", `ID)), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|div.class#id {}|},
      [
        TYPE_SELECTOR("div"),
        DOT,
        TYPE_SELECTOR("class"),
        HASH(("id", `ID)),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    // Attribute selectors
    (
      {|[attr] {}|},
      [
        LEFT_BRACKET,
        TYPE_SELECTOR("attr"),
        RIGHT_BRACKET,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|[attr=value] {}|},
      [
        LEFT_BRACKET,
        TYPE_SELECTOR("attr"),
        EQUALS,
        TYPE_SELECTOR("value"),
        RIGHT_BRACKET,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|[attr="value"] {}|},
      [
        LEFT_BRACKET,
        TYPE_SELECTOR("attr"),
        EQUALS,
        STRING("value"),
        RIGHT_BRACKET,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|[attr~=value] {}|},
      [
        LEFT_BRACKET,
        TYPE_SELECTOR("attr"),
        TILDE,
        EQUALS,
        TYPE_SELECTOR("value"),
        RIGHT_BRACKET,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|[attr|=value] {}|},
      [
        LEFT_BRACKET,
        TYPE_SELECTOR("attr"),
        PIPE,
        EQUALS,
        TYPE_SELECTOR("value"),
        RIGHT_BRACKET,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|[attr^=value] {}|},
      [
        LEFT_BRACKET,
        TYPE_SELECTOR("attr"),
        CARET,
        EQUALS,
        TYPE_SELECTOR("value"),
        RIGHT_BRACKET,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|[attr$=value] {}|},
      [
        LEFT_BRACKET,
        TYPE_SELECTOR("attr"),
        DOLLAR_SIGN,
        EQUALS,
        TYPE_SELECTOR("value"),
        RIGHT_BRACKET,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|[attr*=value] {}|},
      [
        LEFT_BRACKET,
        TYPE_SELECTOR("attr"),
        ASTERISK,
        EQUALS,
        TYPE_SELECTOR("value"),
        RIGHT_BRACKET,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|div[attr] {}|},
      [
        TYPE_SELECTOR("div"),
        LEFT_BRACKET,
        TYPE_SELECTOR("attr"),
        RIGHT_BRACKET,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    // Pseudo-classes
    (
      {|:hover {}|},
      [COLON, TYPE_SELECTOR("hover"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|:active {}|},
      [COLON, TYPE_SELECTOR("active"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|:focus {}|},
      [COLON, TYPE_SELECTOR("focus"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|:visited {}|},
      [COLON, TYPE_SELECTOR("visited"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|:first-child {}|},
      [COLON, TYPE_SELECTOR("first-child"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|:last-child {}|},
      [COLON, TYPE_SELECTOR("last-child"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|:nth-child(2n) {}|},
      [
        COLON,
        NTH_FUNCTION("nth-child"),
        DIMENSION((2., "n")),
        RIGHT_PAREN,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|:nth-child(odd) {}|},
      [
        COLON,
        NTH_FUNCTION("nth-child"),
        TYPE_SELECTOR("odd"),
        RIGHT_PAREN,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|:nth-of-type(3n) {}|},
      [
        COLON,
        NTH_FUNCTION("nth-of-type"),
        DIMENSION((3., "n")),
        RIGHT_PAREN,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|:not(.class) {}|},
      [
        COLON,
        FUNCTION("not"),
        DOT,
        TYPE_SELECTOR("class"),
        RIGHT_PAREN,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|:is(div, span) {}|},
      [
        COLON,
        FUNCTION("is"),
        TYPE_SELECTOR("div"),
        COMMA,
        TYPE_SELECTOR("span"),
        RIGHT_PAREN,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|:where(a, b) {}|},
      [
        COLON,
        FUNCTION("where"),
        TYPE_SELECTOR("a"),
        COMMA,
        TYPE_SELECTOR("b"),
        RIGHT_PAREN,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|:has(> img) {}|},
      [
        COLON,
        FUNCTION("has"),
        GREATER_THAN,
        TYPE_SELECTOR("img"),
        RIGHT_PAREN,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|div:hover {}|},
      [
        TYPE_SELECTOR("div"),
        COLON,
        TYPE_SELECTOR("hover"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|a:visited:hover {}|},
      [
        TYPE_SELECTOR("a"),
        COLON,
        TYPE_SELECTOR("visited"),
        COLON,
        TYPE_SELECTOR("hover"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    // Pseudo-elements
    (
      {|::before {}|},
      [DOUBLE_COLON, TYPE_SELECTOR("before"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|::after {}|},
      [DOUBLE_COLON, TYPE_SELECTOR("after"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|::first-line {}|},
      [DOUBLE_COLON, TYPE_SELECTOR("first-line"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|::first-letter {}|},
      [DOUBLE_COLON, TYPE_SELECTOR("first-letter"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|::placeholder {}|},
      [DOUBLE_COLON, TYPE_SELECTOR("placeholder"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|::selection {}|},
      [DOUBLE_COLON, TYPE_SELECTOR("selection"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|div::before {}|},
      [
        TYPE_SELECTOR("div"),
        DOUBLE_COLON,
        TYPE_SELECTOR("before"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    // Combinators
    (
      {|div span {}|},
      [
        TYPE_SELECTOR("div"),
        DESCENDANT_COMBINATOR,
        TYPE_SELECTOR("span"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|div > span {}|},
      [
        TYPE_SELECTOR("div"),
        GREATER_THAN,
        TYPE_SELECTOR("span"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|div + span {}|},
      [
        TYPE_SELECTOR("div"),
        PLUS,
        TYPE_SELECTOR("span"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|div ~ span {}|},
      [
        TYPE_SELECTOR("div"),
        TILDE,
        TYPE_SELECTOR("span"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|div>span {}|},
      [
        TYPE_SELECTOR("div"),
        GREATER_THAN,
        TYPE_SELECTOR("span"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|div+span {}|},
      [
        TYPE_SELECTOR("div"),
        PLUS,
        TYPE_SELECTOR("span"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|div~span {}|},
      [
        TYPE_SELECTOR("div"),
        TILDE,
        TYPE_SELECTOR("span"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    // Complex selectors
    (
      {|ul li a {}|},
      [
        TYPE_SELECTOR("ul"),
        DESCENDANT_COMBINATOR,
        TYPE_SELECTOR("li"),
        DESCENDANT_COMBINATOR,
        TYPE_SELECTOR("a"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|div > p + span {}|},
      [
        TYPE_SELECTOR("div"),
        GREATER_THAN,
        TYPE_SELECTOR("p"),
        PLUS,
        TYPE_SELECTOR("span"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|.a .b .c {}|},
      [
        DOT,
        TYPE_SELECTOR("a"),
        DESCENDANT_COMBINATOR,
        DOT,
        TYPE_SELECTOR("b"),
        DESCENDANT_COMBINATOR,
        DOT,
        TYPE_SELECTOR("c"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|#a > .b + .c ~ .d {}|},
      [
        HASH(("a", `ID)),
        GREATER_THAN,
        DOT,
        TYPE_SELECTOR("b"),
        PLUS,
        DOT,
        TYPE_SELECTOR("c"),
        TILDE,
        DOT,
        TYPE_SELECTOR("d"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    // Grouped selectors
    (
      {|div, span {}|},
      [
        TYPE_SELECTOR("div"),
        COMMA,
        TYPE_SELECTOR("span"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|.a, .b, .c {}|},
      [
        DOT,
        TYPE_SELECTOR("a"),
        COMMA,
        DOT,
        TYPE_SELECTOR("b"),
        COMMA,
        DOT,
        TYPE_SELECTOR("c"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|h1, h2, h3, h4, h5, h6 {}|},
      [
        TYPE_SELECTOR("h1"),
        COMMA,
        TYPE_SELECTOR("h2"),
        COMMA,
        TYPE_SELECTOR("h3"),
        COMMA,
        TYPE_SELECTOR("h4"),
        COMMA,
        TYPE_SELECTOR("h5"),
        COMMA,
        TYPE_SELECTOR("h6"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    // Nesting (&)
    ({|& {}|}, [AMPERSAND, LEFT_BRACE, RIGHT_BRACE]),
    (
      {|&.class {}|},
      [AMPERSAND, DOT, TYPE_SELECTOR("class"), LEFT_BRACE, RIGHT_BRACE],
    ),
    ({|&#id {}|}, [AMPERSAND, HASH(("id", `ID)), LEFT_BRACE, RIGHT_BRACE]),
    (
      {|& > div {}|},
      [
        AMPERSAND,
        GREATER_THAN,
        TYPE_SELECTOR("div"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|&:hover {}|},
      [AMPERSAND, COLON, TYPE_SELECTOR("hover"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|&::before {}|},
      [
        AMPERSAND,
        DOUBLE_COLON,
        TYPE_SELECTOR("before"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|div & {}|},
      [
        TYPE_SELECTOR("div"),
        DESCENDANT_COMBINATOR,
        AMPERSAND,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    // @import at-rule
    (
      {|@import "file.css";|},
      [AT_RULE_STATEMENT("import"), WS, STRING("file.css"), SEMI_COLON],
    ),
    (
      {|@import url("file.css");|},
      [
        AT_RULE_STATEMENT("import"),
        WS,
        FUNCTION("url"),
        STRING("file.css"),
        RIGHT_PAREN,
        SEMI_COLON,
      ],
    ),
    // @charset at-rule
    (
      {|@charset "UTF-8";|},
      [AT_RULE_STATEMENT("charset"), WS, STRING("UTF-8"), SEMI_COLON],
    ),
    // @namespace at-rule
    (
      {|@namespace svg "http://www.w3.org/2000/svg";|},
      [
        AT_RULE_STATEMENT("namespace"),
        WS,
        IDENT("svg"),
        WS,
        STRING("http://www.w3.org/2000/svg"),
        SEMI_COLON,
      ],
    ),
    // Multiple rules
    (
      {|div {} span {}|},
      [
        TYPE_SELECTOR("div"),
        LEFT_BRACE,
        RIGHT_BRACE,
        TYPE_SELECTOR("span"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|.a {} .b {}|},
      [
        DOT,
        TYPE_SELECTOR("a"),
        LEFT_BRACE,
        RIGHT_BRACE,
        DOT,
        TYPE_SELECTOR("b"),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    // Interpolations in selectors
    (
      {|$(variable) {}|},
      [
        INTERPOLATION(("variable", Ppxlib.Location.none)),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|div.$(className) {}|},
      [
        TYPE_SELECTOR("div"),
        DOT,
        INTERPOLATION(("className", Ppxlib.Location.none)),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|$(Module.selector) {}|},
      [
        INTERPOLATION(("Module.selector", Ppxlib.Location.none)),
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    // Edge cases
    (
      {|-webkit-foo {}|},
      [TYPE_SELECTOR("-webkit-foo"), LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      {|_underscore {}|},
      [TYPE_SELECTOR("_underscore"), LEFT_BRACE, RIGHT_BRACE],
    ),
    ({|div123 {}|}, [TYPE_SELECTOR("div123"), LEFT_BRACE, RIGHT_BRACE]),
    ({|#123 {}|}, [HASH(("123", `UNRESTRICTED)), LEFT_BRACE, RIGHT_BRACE]),
    (
      {|[data-attr="with spaces"] {}|},
      [
        LEFT_BRACKET,
        TYPE_SELECTOR("data-attr"),
        EQUALS,
        STRING("with spaces"),
        RIGHT_BRACKET,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
    (
      {|[class~="foo"] {}|},
      [
        LEFT_BRACKET,
        TYPE_SELECTOR("class"),
        TILDE,
        EQUALS,
        STRING("foo"),
        RIGHT_BRACKET,
        LEFT_BRACE,
        RIGHT_BRACE,
      ],
    ),
  ]
  |> List.map(((input, expected_output)) => {
       test_case(
         "Toplevel mode: " ++ input,
         `Quick,
         () => {
           let (_, values) = parse_with_mode(input, Lexer_context.Toplevel);
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

let token_of_delimiter_string_tests = {
  let show_option_token =
    fun
    | None => "None"
    | Some(t) => "Some(" ++ Tokens.show_token(t) ++ ")";

  let test_cases = [
    ("(", Some(Tokens.LEFT_PAREN)),
    (")", Some(Tokens.RIGHT_PAREN)),
    ("[", Some(Tokens.LEFT_BRACKET)),
    ("]", Some(Tokens.RIGHT_BRACKET)),
    ("{", Some(Tokens.LEFT_BRACE)),
    ("}", Some(Tokens.RIGHT_BRACE)),
    (":", Some(Tokens.COLON)),
    (";", Some(Tokens.SEMI_COLON)),
    (",", Some(Tokens.COMMA)),
    (".", Some(Tokens.DOT)),
    ("*", Some(Tokens.ASTERISK)),
    ("&", Some(Tokens.AMPERSAND)),
    ("+", Some(Tokens.PLUS)),
    ("-", Some(Tokens.MINUS)),
    ("~", Some(Tokens.TILDE)),
    (">", Some(Tokens.GREATER_THAN)),
    ("<", Some(Tokens.LESS_THAN)),
    ("=", Some(Tokens.EQUALS)),
    ("/", Some(Tokens.SLASH)),
    ("!", Some(Tokens.EXCLAMATION)),
    ("|", Some(Tokens.PIPE)),
    ("^", Some(Tokens.CARET)),
    ("$", Some(Tokens.DOLLAR_SIGN)),
    ("?", Some(Tokens.QUESTION_MARK)),
    ("#", Some(Tokens.DELIM('#'))),
    ("@", Some(Tokens.DELIM('@'))),
    ("%", Some(Tokens.DELIM('%'))),
    ("_", Some(Tokens.DELIM('_'))),
    ("", None),
    ("++", None),
    ("abc", None),
  ];

  test_cases
  |> List.map(((input, expected)) => {
       test_case(
         "token_of_delimiter_string(\"" ++ String.escaped(input) ++ "\")",
         `Quick,
         () => {
           let result = Tokens.token_of_delimiter_string(input);
           check(
             string,
             "should match",
             show_option_token(expected),
             show_option_token(result),
           );
         },
       )
     });
};

let tests =
  success_tests
  @ error_tests
  @ test_with_location
  @ selector_mode_tests
  @ toplevel_mode_tests
  @ token_of_delimiter_string_tests;
