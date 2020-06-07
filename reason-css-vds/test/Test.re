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
    Combinator(
      Static,
      [
        Terminal(Keyword("A"), Optional),
        Terminal(Keyword("B"), Optional),
        Terminal(Keyword("C"), Optional),
      ],
    ),
  ),
  (
    "[ A? B? C? ]!",
    Group(
      Combinator(
        Static,
        [
          Terminal(Keyword("A"), Optional),
          Terminal(Keyword("B"), Optional),
          Terminal(Keyword("C"), Optional),
        ],
      ),
      At_least_one,
    ),
  ),
  (
    "A B C",
    Combinator(
      Static,
      [
        Terminal(Keyword("A"), One),
        Terminal(Keyword("B"), One),
        Terminal(Keyword("C"), One),
      ],
    ),
  ),
  (
    "A? || B? || C?",
    Combinator(
      Or,
      [
        Terminal(Keyword("A"), Optional),
        Terminal(Keyword("B"), Optional),
        Terminal(Keyword("C"), Optional),
      ],
    ),
  ),
  (
    "A || B || C",
    Combinator(
      Or,
      [
        Terminal(Keyword("A"), One),
        Terminal(Keyword("B"), One),
        Terminal(Keyword("C"), One),
      ],
    ),
  ),
  (
    "A && B && C",
    Combinator(
      And,
      [
        Terminal(Keyword("A"), One),
        Terminal(Keyword("B"), One),
        Terminal(Keyword("C"), One),
      ],
    ),
  ),
  // groups
  ("[A]", Terminal(Keyword("A"), One)),
  (
    "[A && B]",
    Combinator(
      And,
      [Terminal(Keyword("A"), One), Terminal(Keyword("B"), One)],
    ),
  ),
  (
    "A && [B && C]",
    Combinator(
      And,
      [
        Terminal(Keyword("A"), One),
        Combinator(
          And,
          [Terminal(Keyword("B"), One), Terminal(Keyword("C"), One)],
        ),
      ],
    ),
  ),
  (
    "[A && B] && C",
    Combinator(
      And,
      [
        Combinator(
          And,
          [Terminal(Keyword("A"), One), Terminal(Keyword("B"), One)],
        ),
        Terminal(Keyword("C"), One),
      ],
    ),
  ),
  // multipliers
  ("A*", Terminal(Keyword("A"), Zero_or_more)),
  ("A+", Terminal(Keyword("A"), One_or_more)),
  ("A?", Terminal(Keyword("A"), Optional)),
  ("A{4}", Terminal(Keyword("A"), Repeat(4, Some(4)))),
  ("A{4,5}", Terminal(Keyword("A"), Repeat(4, Some(5)))),
  ("A{4,}", Terminal(Keyword("A"), Repeat(4, None))),
  ("A!", Terminal(Keyword("A"), At_least_one)),
  // why Group exists:
  ("[A?]!", Group(Terminal(Keyword("A"), Optional), At_least_one)),
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
