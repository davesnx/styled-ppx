open Setup;
open Ppxlib;
let loc = Location.none;

let compare = (input, expected, {expect, _}) => {
  let result = Pprintast.string_of_expression(input);
  let expected = Pprintast.string_of_expression(expected);
  expect.string(result).toEqual(expected);
};

let selectors_css_tests = [
  /* (
    "More than one style rule",
    [%expr [%cx "& > a { }; & > b { };"]],
    [%expr CssJs.style(. [|CssJs.selector(. {js|& > a|js}, [||]), CssJs.selector(. {js|& > b|js}, [||])|])],
  ), */
];

describe("Should parse properly to bs-css style", ({test, _}) => {
  selectors_css_tests |>
    List.iteri((_index, (title, result, expected)) =>
      test(
        title,
        compare(result, expected),
      )
    );
});
