Alcotest.run(
  "Lexer and Parser",
  [
    ("Lexer", Css_lexer_test.tests),
    ("Parser", Css_parser_test.tests),
    ("Tokenizer", Tokenizer_test.tests),
  ],
);
