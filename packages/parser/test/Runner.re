Alcotest.run(
  "Parser",
  [("Lexer", Css_lexer_test.tests), ("Parser", Css_parser_test.tests)],
);
