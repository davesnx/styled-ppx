Alcotest.run(
  ~show_errors=true,
  "Lexer and Parser",
  [("Lexer", Lexer_test.tests), ("Parser", Parser_test.tests)],
);
