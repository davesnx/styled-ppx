Alcotest.run(
  "Lexer and Parser",
  [
    ("Lexer", Lexer_test.tests),
    ("Parser", Parser_test.tests),
    ("Tokenizer", Tokenizer_test.tests),
  ],
);
