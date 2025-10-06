Alcotest.run(
  "CSS Property Parser",
  List.flatten([
    Combinators_test.tests,
    Modifiers_test.tests,
    Rules_test.tests,
    Standard_test.tests,
    Types_test.tests,
  ]),
);
