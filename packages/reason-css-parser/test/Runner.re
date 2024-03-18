Alcotest.run(
  ~verbose=true,
  "Reason CSS Parser",
  [
    ("Combinators", Combinators_test.tests),
    ("Modifiers", Modifiers_test.tests),
    ("Rules", Rules_test.tests),
    ("Standard", Standard_test.tests),
    ("Types", Types_test.tests),
  ],
);
