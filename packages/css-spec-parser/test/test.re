open Alcotest;
open Css_spec_parser;

let parse_tests =
  [
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
    ("[A]!", Group(Terminal(Keyword("A"), One), At_least_one)),
    // why Group exists:
    ("[A?]!", Group(Terminal(Keyword("A"), Optional), At_least_one)),
    // property name
    (
      "<font-weight-absolute> | bolder | lighter",
      Combinator(
        Xor,
        [
          Terminal(Data_type("font-weight-absolute", None), One),
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
            Terminal(Data_type("percentage", None), Repeat(3, Some(3))),
            Group(
              Combinator(
                Static,
                [
                  Terminal(Keyword("/"), One),
                  Terminal(Data_type("alpha-value", None), One),
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
          Terminal(Delim("["), One),
          Terminal(Data_type("custom-ident", None), Zero_or_more),
          Terminal(Delim("]"), One),
        ],
      ),
    ),
    ("<rgb()>", Terminal(Data_type("rgb()", None), One)),
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
    (
      "<number [1, 5]>",
      Terminal(
        Data_type("number", Some((Int_bound(1), Int_bound(5)))),
        One,
      ),
    ),
    (
      "<integer [0, \xe2\x88\x9e]>",
      Terminal(Data_type("integer", Some((Int_bound(0), Infinity))), One),
    ),
    (
      "<number [-\xe2\x88\x9e, \xe2\x88\x9e]>",
      Terminal(Data_type("number", Some((Neg_infinity, Infinity))), One),
    ),
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
    (
      "{ a }",
      Combinator(
        Static,
        [
          Terminal(Keyword("{"), One),
          Terminal(Keyword("a"), One),
          Terminal(Keyword("}"), One),
        ],
      ),
    ),
    (
      // special characters
      "','",
      Terminal(Delim(","), One),
    ),
    // stacked multipliers (CSS Values 4 §2.3)
    (
      "A+#",
      Group(Terminal(Keyword("A"), One_or_more), Repeat_by_comma(1, None)),
    ),
    (
      "A#?",
      Group(Terminal(Keyword("A"), Repeat_by_comma(1, None)), Optional),
    ),
    (
      "A{2}?",
      Group(Terminal(Keyword("A"), Repeat(2, Some(2))), Optional),
    ),
    (
      "A{2,4}?",
      Group(Terminal(Keyword("A"), Repeat(2, Some(4))), Optional),
    ),
  ]
  |> List.mapi((_, (result, expected)) => {
       let result =
         switch (value_of_string(result)) {
         | Some(result) => result
         | None => failwith("Failed to parse")
         };

       let assertion = () =>
         check(
           string,
           "Should match",
           show_value(expected),
           show_value(result),
         );

       test_case(show_value(result), `Quick, assertion);
     });

let print_tests =
  [
    ("  a b   |   c ||   d &&   e f", "'a' 'b' | 'c' || 'd' && 'e' 'f'"),
    ("[ a b ] | [ c || [ d && [ e f ]]]", "'a' 'b' | 'c' || 'd' && 'e' 'f'"),
    ("'[' abc ']'", "'[' 'abc' ']'"),
  ]
  |> List.mapi((_index, (input, expected)) => {
       let result =
         switch (value_of_string(input)) {
         | Some(res) => res
         | None => fail("Failed to parse")
         };

       let assertion = () =>
         check(
           ~pos=__POS__,
           string,
           "Should match",
           string_of_value(result),
           expected,
         );

       test_case(show_value(result), `Quick, assertion);
     });

let error_tests =
  ["|||", "[[", "]invalid[", "A!"]
  |> List.mapi((_index, input) => {
       let assertion = () =>
         check(
           bool,
           "Should return None for invalid input",
           true,
           value_of_string(input) == None,
         );

       test_case("invalid: " ++ input, `Quick, assertion);
     });

Alcotest.run(
  "CSS Spec Parser",
  [
    ("Parser", parse_tests),
    ("Printer", print_tests),
    ("Error handling", error_tests),
  ],
);
