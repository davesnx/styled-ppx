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
  // property name
  (
    "<font-weight-absolute> | bolder | lighter",
    Combinator(
      Xor,
      [
        Terminal(Data_type("font-weight-absolute"), One),
        Terminal(Keyword("bolder"), One),
        Terminal(Keyword("lighter"), One),
      ],
    ),
  ),
  (
    // function call
    "rgb( <percentage>{3} [ / <alpha-value> ]? )",
    Function_call(
      "rgb",
      Combinator(
        Static,
        [
          Terminal(Data_type("percentage"), Repeat(3, Some(3))),
          Group(
            Combinator(
              Static,
              [
                Terminal(Keyword("/"), One),
                Terminal(Data_type("alpha-value"), One),
              ],
            ),
            Optional,
          ),
        ],
      ),
    ),
  ),
  (
    // special characters
    "'[' <custom-ident>* ']'",
    Combinator(
      Static,
      [
        Terminal(Keyword("["), One),
        Terminal(Data_type("custom-ident"), Zero_or_more),
        Terminal(Keyword("]"), One),
      ],
    ),
  ),
  // TODO: shouldn't be a special case
  ("<rgb()>", Terminal(Function("rgb"), One)),
  // ident with number
  (
    "[ jis04 | simplified | traditional ]",
    Combinator(
      Xor,
      [
        Terminal(Keyword("jis04"), One),
        Terminal(Keyword("simplified"), One),
        Terminal(Keyword("traditional"), One),
      ],
    ),
  ),
  // at keyword
  ("@stylistic", Terminal(Keyword("@stylistic"), One)),
  // range restriction
  ("<number [1, 5]>", Terminal(Data_type("number"), One)),
  // escaped combinator
  ("'||'", Terminal(Keyword("||"), One)),
  // function without space
  (
    "minmax(min, max)",
    Function_call(
      "minmax",
      Combinator(
        Static,
        [
          Terminal(Keyword("min"), One),
          Terminal(Keyword(","), One),
          Terminal(Keyword("max"), One),
        ],
      ),
    ),
  ),
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
