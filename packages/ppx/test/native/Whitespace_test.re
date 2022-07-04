open Setup;
open Ppxlib;
let loc = Location.none;

let compare = (input, expected, {expect, _}) => {
  let result = Pprintast.string_of_expression(input);
  let expected = Pprintast.string_of_expression(expected);
  expect.string(result).toEqual(expected);
};

let css_tests = [
  (
    "ignore in declaration list",
    [%expr [%cx "display: block; box-sizing: border-box          "]],
    [%expr [%cx "display: block; box-sizing: border-box;"]],
  ),
  (
    "ignore in declaration",
    [%expr [%cx " display : block; "]],
    [%expr [%cx "display: block;"]],
  ),
  (
    "ignore in declaration",
    [%expr [%cx "display:block;"]],
    [%expr [%cx "display: block;"]],
  ),
  (
    "ignore in at_rule inside declarations",
    [%expr [%cx "@media all { }"]],
    [%expr [%cx "@media all { }"]],
  ),
  (
    "ignore in at_rule inside declarations",
    [%expr [%cx "@media(min-width:30px) {}"]],
    [%expr [%cx "@media (min-width: 30px) {}"]],
  ),
  (
    "ignore in at_rule inside declarations",
    [%expr [%cx "@media screen and (min-width:30px) {}"]],
    [%expr [%cx "@media screen and (min-width: 30px) {}"]],
  ),
  (
    "wat",
    [%expr [%cx "@media screen and (min-width: 30px) { color: red; }"]],
    [%expr [%cx "@media screen and (min-width: 30px) { color: red; } "]],
  ),
];

describe("Should treat Whitespace accordingly", ({test, _}) => {
  css_tests |>
    List.iteri((_index, (title, result, expected)) =>
      test(
        title,
        compare(result, expected),
      )
    );
});