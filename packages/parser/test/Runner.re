Alcotest.run(
  "Lexer and Parser",
  List.concat([Lexer_test.tests, Parser_test.tests]),
);
