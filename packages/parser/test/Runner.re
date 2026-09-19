Alcotest.run(
  "Lexer and Parser",
  [
    ("Lexer", Lexer_test.tests),
    ("Parser", Parser_test.tests),
    ("Roundtrip", Roundtrip_test.tests),
  ],
);
