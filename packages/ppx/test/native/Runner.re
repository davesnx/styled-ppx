Alcotest.run(
  "ppx test native",
  [
    ("At_rule", At_rule_test.tests),
    ("Interpolation", Interpolation_test.tests),
    ("Selector", Selector_test.tests),
    ("Static", Static_test.tests),
    ("Ppx", Ppx_test.tests),
  ],
);
