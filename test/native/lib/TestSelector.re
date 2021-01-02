open Setup;
open Styled_ppx_parser;
open Selectors_parser;

let compare = (result, expected, {expect, _}) => {
  let serialize = selector_list =>
    selector_list
    |> List.map(Selectors_parser.show_complex_selector)
    |> String.concat(", ");
  let result = serialize(result);
  let expected = serialize(expected);
  expect.string(result).toEqual(expected);
};

let apply_combinator =
    ((left, left_expected), (right, right_expected), combinator) => {
  let expected =
    Combinator({left: left_expected, combinator, right: right_expected});
  let infix =
    switch (combinator) {
    | Juxtaposition => " "
    | Greater => " > "
    | Plus => " + "
    | Tilde => " ~ "
    };
  (left ++ infix ++ right, expected);
};
let selectors_tests = [
  (
    "element",
    {
      type_selector: Some("element"),
      subclass_selectors: [],
      pseudo_selectors: [],
    },
  ),
  (
    ".class",
    {
      type_selector: None,
      subclass_selectors: [Class("class")],
      pseudo_selectors: [],
    },
  ),
  (
    "#id",
    {
      type_selector: None,
      subclass_selectors: [Id("id")],
      pseudo_selectors: [],
    },
  ),
  (
    ":pseudo_class",
    {
      type_selector: None,
      subclass_selectors: [],
      pseudo_selectors: [Pseudo_class(Ident("pseudo_class"))],
    },
  ),
  (
    "::pseudo_element",
    {
      type_selector: None,
      subclass_selectors: [],
      pseudo_selectors: [Pseudo_element(Ident("pseudo_element"))],
    },
  ),
  (
    "element.class#id",
    {
      type_selector: Some("element"),
      subclass_selectors: [Class("class"), Id("id")],
      pseudo_selectors: [],
    },
  ),
  (
    "div#banner.green:active:not(:hover)::before",
    {
      type_selector: Some("div"),
      subclass_selectors: [Id("banner"), Class("green")],
      pseudo_selectors: [
        Pseudo_class(Ident("active")),
        Pseudo_class(
          Function({
            name: "not",
            payload: [Reason_css_lexer.COLON, IDENT("hover")],
          }),
        ),
        Pseudo_element(Ident("before")),
      ],
    },
  ),
];
let selectors_tests =
  selectors_tests
  |> List.concat_map(original_test => {
       // TODO: this should do all the permutations, but I'm not smart enough to figure it out how to do it
       let all_combinations =
         [Juxtaposition, Greater, Plus, Tilde]
         |> List.concat_map(combinator =>
              selectors_tests
              |> List.map(right => {
                   let (left, left_expected) = original_test;
                   apply_combinator(
                     (left, Selector(left_expected)),
                     right,
                     combinator,
                   );
                 })
            );
       let input = all_combinations |> List.map(fst) |> String.concat(", ");
       let output = all_combinations |> List.map(snd);
       [
         {
           let (input, expected) = original_test;
           (input, [Selector(expected)]);
         },
         (input, output),
       ];
     });

// TODO: write with combinators

describe("parse css selectors", ({test, _}) => {
  let test = ((selector, expected)) =>
    test(
      "selector " ++ selector,
      suite => {
        let body = Printf.sprintf("%s{}", selector);
        let rule = parse_rule(body);
        switch (rule) {
        | Some({prelude: {txt: prelude, _}, _}) =>
          let prelude =
            prelude
            |> List.map(Helpers.to_lexer)
            |> List.map((Location.{txt, _}) => txt);
          switch (Selectors_parser.selector_list(prelude)) {
          | (Ok(result), []) => compare(result, expected, suite)
          | (Ok(result), tokens) =>
            Printf.sprintf(
              "failed to parse: %s\nremaining tokens: %s\ngot:%s\n",
              selector,
              tokens
              |> List.map(Reason_css_lexer.show_token)
              |> String.concat(", "),
              result
              |> List.map(Selectors_parser.show_complex_selector)
              |> String.concat(", "),
            )
            |> failwith
          | _ => failwith("failed to parse " ++ selector)
          };
        | None => failwith("failed to parse " ++ selector)
        };
      },
    );
  List.iter(test, selectors_tests);
});
