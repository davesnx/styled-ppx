module Tokens = Styled_ppx_css_parser.Tokens;
module Lexer = Styled_ppx_css_parser.Lexer;
module Parser = Styled_ppx_css_parser.Parser;

let success_tests =
  [
    (__POS__, {|inset-3\.5|}, [IDENT("inset-3.5")]),
    (__POS__, {|-inset-3\.5|}, [IDENT("-inset-3.5")]),
    (__POS__, {|inset-1\/3|}, [IDENT("inset-1/3")]),
    (__POS__, {|\32xl\:container|}, [IDENT("2xl:container")]),
    (__POS__, " \n\t ", [WS]),
    (__POS__, {|"something"|}, [STRING("something")]),
    (__POS__, {|'tuturu'|}, [STRING("tuturu")]),
    /* TODO: Differentiate HASH from ID */
    (__POS__, {|#2|}, [HASH("2")]),
    (__POS__, {|#abc|}, [HASH("abc")]),
    (__POS__, {|#|}, [DELIM("#")]),
    (__POS__, {|(|}, [LEFT_PAREN]),
    (__POS__, {|)|}, [RIGHT_PAREN]),
    (__POS__, {|+12.3|}, [NUMBER("+12.3")]),
    (__POS__, {|+ 12.3|}, [COMBINATOR("+"), WS, NUMBER("12.3")]),
    (__POS__, {|+|}, [COMBINATOR("+")]),
    (__POS__, {|,|}, [COMMA]),
    (__POS__, {|45.6|}, [NUMBER("45.6")]),
    (__POS__, {|-45.6|}, [NUMBER("-45.6")]),
    (__POS__, {|45%|}, [NUMBER("45"), PERCENT]),
    (__POS__, {|2n|}, [DIMENSION(("2", "n"))]),
    /* TODO: Store Float_dimension as float/int */
    /* TODO: Store dimension as a variant */
    (__POS__, {|45.6px|}, [FLOAT_DIMENSION(("45.6", "px"))]),
    (__POS__, {|10px|}, [FLOAT_DIMENSION(("10", "px"))]),
    (__POS__, {|.5|}, [NUMBER(".5")]),
    /* TODO: Treat 5. as NUMBER("5.0") */
    (__POS__, {|5.|}, [NUMBER("5"), DOT]),
    (__POS__, {|--potato|}, [IDENT("--potato")]),
    (__POS__, {|-|}, [DELIM("-")]),
    (__POS__, {|.|}, [DOT]),
    (__POS__, {|*|}, [ASTERISK]),
    (__POS__, {|&|}, [AMPERSAND]),
    (__POS__, {|:|}, [COLON]),
    (__POS__, {|::|}, [DOUBLE_COLON]),
    (__POS__, {|;|}, [SEMI_COLON]),
    (__POS__, {|<|}, [DELIM("<")]),
    (__POS__, {|not|}, [IDENT("not")]),
    (__POS__, {|not |}, [IDENT("not"), WS]),
    (__POS__, {|only|}, [IDENT("only")]),
    (__POS__, {|only |}, [IDENT("only"), WS]),
    (__POS__, {|and|}, [IDENT("and")]),
    (__POS__, {|and |}, [IDENT("and"), WS]),
    (__POS__, {|or |}, [IDENT("or"), WS]),
    (__POS__, {|all|}, [IDENT("all")]),
    (__POS__, {|screen|}, [IDENT("screen")]),
    (__POS__, {|print|}, [IDENT("print")]),
    (__POS__, {|@mayushii|}, [AT_RULE("mayushii")]),
    (__POS__, {|@|}, [DELIM("@")]),
    (__POS__, {|[|}, [LEFT_BRACKET]),
    (__POS__, {|]|}, [RIGHT_BRACKET]),
    (__POS__, {|0.7|}, [NUMBER("0.7")]),
    (__POS__, {|12345678.9|}, [NUMBER("12345678.9")]),
    (__POS__, {|bar|}, [IDENT("bar")]),
    (__POS__, {||}, [EOF]),
    (__POS__, {|!|}, [DELIM("!")]),
    (__POS__, "1 / 1", [NUMBER("1"), WS, DELIM("/"), WS, NUMBER("1")]),
    (
      __POS__,
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
    (__POS__, {|+10px|}, [FLOAT_DIMENSION(("+10", "px"))]),
    (
      __POS__,
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
      __POS__,
      {|calc(10%)|},
      [FUNCTION("calc"), NUMBER("10"), PERCENT, RIGHT_PAREN],
    ),
    (
      __POS__,
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
    (
      __POS__,
      {|$(Module.variable)|},
      [INTERPOLATION(["Module", "variable"])],
    ),
    (
      __POS__,
      {|$(Module.variable')|},
      [INTERPOLATION(["Module", "variable'"])],
    ),
    (__POS__, {|-moz|}, [IDENT("-moz")]),
    (__POS__, {|--color-main|}, [IDENT("--color-main")]),
    // Test IMPORTANT token
    (__POS__, {|!important|}, [IMPORTANT]),
    (__POS__, {|! important|}, [IMPORTANT]),
    // Test OPERATOR tokens
    (__POS__, {|~=|}, [OPERATOR("~=")]),
    (__POS__, {||=|}, [OPERATOR("|=")]),
    (__POS__, {|^=|}, [OPERATOR("^=")]),
    (__POS__, {|$=|}, [OPERATOR("$=")]),
    (__POS__, {|*=|}, [OPERATOR("*=")]),
    (__POS__, {|=|}, [OPERATOR("=")]),
    // Test COMBINATOR tokens
    (__POS__, {|>|}, [COMBINATOR(">")]),
    (__POS__, {|~|}, [COMBINATOR("~")]),
    // + is COMBINATOR unless part of number
    (__POS__, {|+ |}, [COMBINATOR("+"), WS]),
    // Test AT_KEYFRAMES
    (__POS__, {|@keyframes|}, [AT_KEYFRAMES("keyframes")]),
    // Test AT_RULE_STATEMENT
    (__POS__, {|@import|}, [AT_RULE_STATEMENT("import")]),
    (__POS__, {|@charset|}, [AT_RULE_STATEMENT("charset")]),
    (__POS__, {|@namespace|}, [AT_RULE_STATEMENT("namespace")]),
    (
      __POS__,
      {|
    /* nice */
    /* nice */


    /* nice */
    /* nice */

    div {}|},
      [WS, TAG("div"), WS, LEFT_BRACE, RIGHT_BRACE],
    ),
    (
      __POS__,
      {|
    div /*nice*/ /* nice */   /*ice*/.b {}|},
      [WS, TAG("div"), WS, DOT, TAG("b"), WS, LEFT_BRACE, RIGHT_BRACE],
    ),
    /* BROKEN TEST:    (
         __POS__,
         {|
       div/*nice*//* nice *//*ice*/.b {}|},
         [WS, TAG("div"), DOT, TAG("b"), WS, LEFT_BRACE, RIGHT_BRACE],
       ), */
    /* TODO: Support for escaped */
    /* (__POS__, {|\32|}, [NUMBER("\32")]), */
    /* (__POS__, {|\25BA|}, [NUMBER "\25BA"]), */
    /* TODO: Support escaped "@" and others */
    /* ("\\@desu", [IDENT("@desu")]), */
  ]
  |> List.map(((pos, input, output)) => {
       let okInput = Lexer.tokenize(input) |> Result.get_ok;
       let inputTokens = Lexer.to_string(okInput);
       let outputTokens =
         output
         |> List.map(token => (token, Lexing.dummy_pos, Lexing.dummy_pos))
         |> Lexer.to_string;

       test(Printf.sprintf("parse %s", input), () =>
         check(~__POS__=pos, Alcotest.string, inputTokens, outputTokens)
       );
     });

let parse = input => {
  let values = Lexer.from_string(input);
  let {loc: first_loc, _}: Lexer.token_with_location = List.hd(values);
  let values =
    values
    |> List.map((Lexer.{txt, _}) => txt)
    |> List.filter(txt =>
         switch (txt) {
         | Ok(Parser.EOF) => false
         | _ => true
         }
       )
    |> List.rev;
  (first_loc, values);
};

let list_parse_tokens_to_string = tokens =>
  tokens
  |> List.rev
  |> List.map(
       fun
       | Ok(token) => Tokens.show_token(token)
       | Error((token, err)) =>
         "Error("
         ++ Tokens.show_error(err)
         ++ ") "
         ++ Tokens.show_token(token),
     )
  |> String.concat(" ")
  |> String.trim;

let list_tokens_to_string = tokens =>
  tokens |> List.map(Tokens.show_token) |> String.concat(" ") |> String.trim;

let error_tests =
  [
    (
      "/*",
      "/ * the end" /* TODO: This should be an error "Unterminated comment at the end of the string" */,
    ),
  ]
  |> List.map(((input, output)) => {
       let value: list(Lexer.token_with_location) =
         input |> Lexer.from_string;
       let error =
         value
         |> List.map(({txt, _}: Lexer.token_with_location) =>
              switch (txt) {
              | Ok(token) => Tokens.humanize(token)
              | Error((token, err)) =>
                "Error("
                ++ Tokens.show_error(err)
                ++ ") "
                ++ Lexer.render_token(token)
              }
            )
         |> String.concat(" ")
         |> String.trim;
       test(input, () =>
         check(~__POS__, Alcotest.string, error, output)
       );
     });

let test_with_location =
  [
    (__POS__, {||}, [], 0) /* Since we filter WS, EOF is not present */,
    (__POS__, " \n\t ", [WS], 4),
    (__POS__, {|"something"|}, [STRING("something")], 11),
    // TODO: is that right?
    (__POS__, {|#2|}, [HASH("2")], 2),
    (__POS__, {|#abc|}, [HASH("abc")], 4),
    (__POS__, {|#|}, [DELIM("#")], 1),
    (__POS__, {|'tuturu'|}, [STRING("tuturu")], 8),
    (__POS__, {|(|}, [LEFT_PAREN], 1),
    (__POS__, {|)|}, [RIGHT_PAREN], 1),
    (__POS__, {|+12.3|}, [NUMBER("+12.3")], 5),
    (__POS__, {|+|}, [COMBINATOR("+")], 1),
    (__POS__, {|,|}, [COMMA], 1),
    (__POS__, {|-45.6|}, [NUMBER("-45.6")], 5),
    (__POS__, {|--potato|}, [IDENT("--potato")], 8),
    (__POS__, {|-|}, [DELIM("-")], 1),
    (__POS__, {|.7|}, [NUMBER(".7")], 2),
    (__POS__, {|.|}, [DOT], 1),
    (__POS__, {|:|}, [COLON], 1),
    (__POS__, {|;|}, [SEMI_COLON], 1),
    (__POS__, {|<|}, [DELIM("<")], 1),
    (__POS__, {|@mayushii|}, [AT_RULE("mayushii")], 9),
    (__POS__, {|@|}, [DELIM("@")], 1),
    (__POS__, {|[|}, [LEFT_BRACKET], 1),
    (__POS__, "\\@desu", [IDENT("@desu")], 6),
    (__POS__, {|]|}, [RIGHT_BRACKET], 1),
    (__POS__, {|12345678.9|}, [NUMBER("12345678.9")], 10),
    (__POS__, {|bar|}, [IDENT("bar")], 3),
    (__POS__, {|!|}, [DELIM("!")], 1),
    (__POS__, "1 / 1", [NUMBER("1"), WS, DELIM("/"), WS, NUMBER("1")], 1), /* number 1 looks wrong */
    (
      __POS__,
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
      5 /* 17, */
    ),
    (
      __POS__,
      {|background-image:url('img_tree.gif' )|},
      [
        IDENT("background-image"),
        COLON,
        FUNCTION("url"),
        STRING("img_tree.gif"),
        WS,
        RIGHT_PAREN,
      ],
      16 /* 37, */
    ),
    (
      __POS__,
      {|calc(10px+ 10px)|},
      [
        FUNCTION("calc"),
        FLOAT_DIMENSION(("10", "px")),
        COMBINATOR("+"),
        WS,
        FLOAT_DIMENSION(("10", "px")),
        RIGHT_PAREN,
      ],
      5 /* 16, */
    ),
    (
      __POS__,
      {|calc(10%)|},
      [FUNCTION("calc"), NUMBER("10"), PERCENT, RIGHT_PAREN],
      5 /* 9, */
    ),
    (
      __POS__,
      {|$(Module.variable)|},
      [INTERPOLATION(["Module", "variable"])],
      18,
    ),
    (
      __POS__,
      {|$(Module.variable')|},
      [INTERPOLATION(["Module", "variable'"])],
      19,
    ),
    (__POS__, {|--color-main|}, [IDENT("--color-main")], 12),
    (__POS__, {|>=|}, [DELIM(">=")], 2),
    (__POS__, {|<=|}, [DELIM("<=")], 2),
    (
      __POS__,
      {|url($(Module.variable'))|},
      [
        FUNCTION("url"),
        INTERPOLATION(["Module", "variable'"]),
        RIGHT_PAREN,
      ],
      4 /* 24, */
    ),
  ]
  |> List.mapi((_index, (pos, input, output, last_position)) => {
       let (loc, values) = parse(input);

       loc.loc_end.pos_cnum == last_position
         ? ()
         : Alcotest.fail(
             ~pos,
             "position should be "
             ++ string_of_int(last_position)
             ++ " received "
             ++ string_of_int(loc.loc_end.pos_cnum),
           );

       let assertion = () =>
         Alcotest.check(
           ~pos,
           Alcotest.string,
           "should succeed lexing: " ++ input,
           list_tokens_to_string(output),
           list_parse_tokens_to_string(values),
         );

       test(Printf.sprintf("parse with loc %S", input), assertion);
     });

let tests: tests =
  List.concat([success_tests, error_tests, test_with_location]);
