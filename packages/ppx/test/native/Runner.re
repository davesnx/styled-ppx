Alcotest.run(
  "ppx test native",
  List.flatten([
    At_rule_test.tests,
    Interpolation_test.tests,
    Selector_test.tests,
    Static_test.tests,
    Ppx_test.tests,
    Transform_test.tests,
  ]),
);
