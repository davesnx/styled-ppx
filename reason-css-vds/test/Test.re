open TestFramework;
open Reason_css_vds;

let compare_ast = (expected, result, {expect, _}) => {
  let expected = show_value(expected);
  let result = show_value(result);
  expect.string(result).toEqual(expected);
};

let parse_tests = [
  (
    "A? B? C?",
    Static(
      Static(Keyword("A", Optional), Keyword("B", Optional)),
      Keyword("C", Optional),
    ),
  ),
  (
    "[ A? B? C? ]!",
    Group(
      Static(
        Static(Keyword("A", Optional), Keyword("B", Optional)),
        Keyword("C", Optional),
      ),
      At_least_one,
    ),
  ),
  (
    "A B C",
    Static(
      Static(Keyword("A", One), Keyword("B", One)),
      Keyword("C", One),
    ),
  ),
  (
    "A? || B? || C?",
    Or(
      Or(Keyword("A", Optional), Keyword("B", Optional)),
      Keyword("C", Optional),
    ),
  ),
  (
    "A || B || C",
    Or(Or(Keyword("A", One), Keyword("B", One)), Keyword("C", One)),
  ),
  (
    "A && B && C",
    And(And(Keyword("A", One), Keyword("B", One)), Keyword("C", One)),
  ),
  // groups
  ("[A]", Keyword("A", One)),
  ("[A && B]", And(Keyword("A", One), Keyword("B", One))),
  (
    "A && [B && C]",
    And(Keyword("A", One), And(Keyword("B", One), Keyword("C", One))),
  ),
  (
    "[A && B] && C",
    And(And(Keyword("A", One), Keyword("B", One)), Keyword("C", One)),
  ),
  // multipliers
  ("A*", Keyword("A", Zero_or_more)),
  ("A+", Keyword("A", One_or_more)),
  ("A?", Keyword("A", Optional)),
  ("A{4}", Keyword("A", Repeat(4, Some(4)))),
  ("A{4,5}", Keyword("A", Repeat(4, Some(5)))),
  ("A{4,}", Keyword("A", Repeat(4, None))),
  ("A!", Keyword("A", At_least_one)),
  // why Group exists:
  ("[A?]!", Group(Keyword("A", Optional), At_least_one)),
];
describe("correctly parse value", ({test, _}) => {
  let test = (index, (result, expected)) =>
    test(
      "parse: " ++ string_of_int(index),
      utils => {
        let result =
          switch (value_of_string(result)) {
          | Some(result) => result
          | None => failwith("failed to parse")
          };
        compare_ast(expected, result, utils);
      },
    );
  List.iteri(test, parse_tests);
});

let print_tests = [
  ("  a b   |   c ||   d &&   e f", "a b | c || d && e f"),
  ("[ a b ] | [ c || [ d && [ e f ]]]", "a b | c || d && e f"),
];
describe("correctly print value", ({test, _}) => {
  let test = (index, (result, expected)) =>
    test(
      "print: " ++ string_of_int(index),
      ({expect, _}) => {
        let result =
          switch (value_of_string(result)) {
          | Some(result) => result
          | None => failwith("failed to parse")
          };
        let result = value_to_string(result);
        expect.string(result).toEqual(expected);
      },
    );
  List.iteri(test, print_tests);
});
