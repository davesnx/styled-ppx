Alcotest.run(
  "CSS Property Parser",
  List.flatten([
    Combinators_test.tests,
    Modifiers_test.tests,
    Rules_test.tests,
    Standard_test.tests,
    Parser_test.tests,
    Interpolation_extraction_test.tests,
  ]),
);
