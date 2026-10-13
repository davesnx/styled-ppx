Alcotest.run(
  ~show_errors=true,
  "CSS Property Parser",
  List.flatten([
    Combinators_test.tests,
    Modifiers_test.tests,
    Rules_test.tests,
    Standard_test.tests,
    Parser_test.tests,
    Interpolation_extraction_test.tests,
    Shorthand_test.tests,
  ]),
);
