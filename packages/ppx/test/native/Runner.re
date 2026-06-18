open Ppxlib;

let loc = Location.none;

let printExpression = (prefix, expression) =>
  Printf.printf("%s%S\n", prefix, Pprintast.string_of_expression(expression));

let printCase = ((title, input)) => {
  Printf.printf("- %s\n", title);
  printExpression("  ", input);
};

let printSuite = (name, cases) => {
  Printf.printf("## %s\n", name);
  List.iter(printCase, cases);
};

let printPpxSuite = () => {
  Printf.printf("## Ppx\n");
  let input = [%stri module X = [%graphql]];
  Printf.printf("- passthrough extension\n");
  Printf.printf("  %S\n", Pprintast.string_of_structure([input]));
};

let printTransformSuite = () => {
  Printf.printf("## Transform\n");
  Transform_test.run_all();
  Printf.printf("- %d runtime transform assertions passed\n", List.length(Transform_test.cases));
};

let printSubtreeEscapeSuite = () => {
  Printf.printf("## SubtreeEscape\n");
  Subtree_escape_test.run_all();
  Printf.printf(
    "- %d subtree-escape assertions passed\n",
    List.length(Subtree_escape_test.cases),
  );
};

let printSelectorSuites = () => {
  printSuite("Selector/simple", Selector_test.simple_tests);
  printSuite("Selector/compound", Selector_test.compound_tests);
  printSuite("Selector/complex", Selector_test.complex_tests);
  printSuite("Selector/stylesheet", Selector_test.stylesheet_tests);
  printSuite("Selector/nested", Selector_test.nested_tests);
  printSuite("Selector/comments", Selector_test.comments_tests);
};

let printAll = () => {
  printSelectorSuites();
  printSuite("Whitespace", Whitespace_test.cases);
  printPpxSuite();
  printTransformSuite();
  printSubtreeEscapeSuite();
};

let printUsage = () => {
  Printf.eprintf(
    "Usage: ppx-native-test-runner [all|selector|whitespace|ppx|transform|subtree-escape]\n",
  );
  exit(2);
};

let runSuite = name =>
  switch (name) {
  | "all" => printAll()
  | "selector" => printSelectorSuites()
  | "whitespace" => printSuite("Whitespace", Whitespace_test.cases)
  | "ppx" => printPpxSuite()
  | "transform" => printTransformSuite()
  | "subtree-escape" => printSubtreeEscapeSuite()
  | _ => printUsage()
  };

switch (Array.length(Sys.argv)) {
| 1 => printAll()
| 2 => runSuite(Sys.argv[1])
| _ => printUsage()
};
