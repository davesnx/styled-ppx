open Alcotest;
open Ppxlib;

let loc = Location.none;
let compare = (input, expected, {expect, _}) => {
  let result = Pprintast.string_of_expression(input);
  let expected = Pprintast.string_of_expression(expected);
  expect.string(result).toEqual(expected);
};

let css_tests = [
  (
    "ignore in style_rule",
    [%expr [%cx ".bar{}"]],
    [%expr [%cx ".bar {}"]],
  ),
  (
    "ignore in style_rule",
    [%expr [%cx ".bar { } "]],
    [%expr [%cx ".bar {}"]],
  ),
  (
    "ignore in declaration list",
    [%expr [%cx "display: block; box-sizing: border-box          ; "]],
    [%expr [%cx "display: block; box-sizing: border-box;"]],
  ),
  (
    "ignore in declaration",
    [%expr [%cx " display : block; "]],
    [%expr [%cx "display: block;"]],
  ),
  (
    "ignore in declaration",
    [%expr [%cx " display : block ; "]],
    [%expr [%cx "display: block;"]],
  ),
  (
    "ignore in declaration",
    [%expr [%cx "display:block;"]],
    [%expr [%cx "display: block;"]],
  ),
  (
    "ignore in at_rule inside declarations",
    [%expr [%cx "@media all {}"]],
    [%expr [%cx "@media all {}"]],
  ),
  (
    "ignore in at_rule inside declarations",
    [%expr [%cx "@media all  { } "]],
    [%expr [%cx "@media all {}"]],
  ),
  (
    "ignore in at_rule inside declarations",
    [%expr [%cx "@media(min-width: 30px) {}"]],
    [%expr [%cx "@media (min-width: 30px) {}"]],
  ),
  (
    "ignore in at_rule inside declarations",
    [%expr [%cx "@media screen  and  (min-width: 30px) {}"]],
    [%expr [%cx "@media screen and (min-width: 30px) {}"]],
  ),
  (
    "media with declarations",
    [%expr [%cx "@media    screen and (min-width: 30px  ) { color: red; }"]],
    [%expr [%cx "@media screen and (min-width: 30px  ) { color: red; } "]],
  ),
  (
    "media with multiple preludes",
    [%expr [%cx "@media screen and (min-width: 30px) and (max-height: 16rem) { color: red; }"]],
    [%expr [%cx "@media screen and (min-width: 30px) and (max-height: 16rem) { color: red; } "]],
  ),
  (
    "media with declarations",
    [%expr [%cx ".clar {  background-image : url( 'img_tree.gif') ; }"]],
    [%expr [%cx ".clar { background-image: url( 'img_tree.gif') }"]],
  ),
  (
    "ignore space on declaration url",
    [%expr [%css " background-image: url('img_tree.gif' )" ]],
    [%expr [%css "background-image: url('img_tree.gif' )" ]],
  ),
  (
    "html, body, #root, .class",
    [%expr [%styled.global {|
    html, body, #root, .class {
      margin: 0;
    } |}]],
    [%expr ignore(CssJs.global(. {js|html, body, #root, .class|js}, [| CssJs.margin(`zero) |]))],
  ),
  (
    "html, body, #root, .class",
    [%expr [%styled.global {|
    html,             body, #root, .class   {     margin: 0    } |}]],
    [%expr ignore(CssJs.global(. {js|html, body, #root, .class|js}, [| CssJs.margin(`zero) |]))],
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
