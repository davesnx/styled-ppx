open Migrate_parsetree;
open Ast_410;
open Setup;

let compare = (result, expected, {expect, _}) => {
  open Parsetree;
  let result =
    switch (result) {
    | {pexp_desc: Pexp_apply(_, [(_, expr)]), _} => expr
    | _ => failwith("probably the result changed")
    };

  let result = Pprintast.string_of_expression(result);
  let expected = Pprintast.string_of_expression(expected);
  expect.string(result).toEqual(expected);
};

let static_css_tests = [
  (
    [%expr [%css "align-items: center"]],
    [%expr [Css.alignItems(Css.center)]],
  ),
  (
    [%expr [%css "box-sizing: border-box"]],
    [%expr [Css.boxSizing(`borderBox)]],
  ),
  (
    [%expr [%css "box-sizing: content-box"]],
    [%expr [Css.boxSizing(`contentBox)]],
  ),
  (
    [%expr [%css "color: #454545"]],
    [%expr [Css.color(Css.hex({js|454545|js}))]],
  ),
  ([%expr [%css "color: red"]], [%expr [Css.color(Css.red)]]),
  ([%expr [%css "display: flex"]], [%expr [Css.display(`flex)]]),
  (
    [%expr [%css "flex-direction: column"]],
    [%expr [Css.flexDirection(Css.column)]],
  ),
  ([%expr [%css "font-size: 30px"]], [%expr [Css.fontSize(Css.px(30))]]),
  ([%expr [%css "height: 100vh"]], [%expr [Css.height(Css.vh(100.))]]),
  (
    [%expr [%css "justify-content: center"]],
    [%expr [Css.justifyContent(Css.center)]],
  ),
  ([%expr [%css "margin: 0"]], [%expr [Css.margin(`zero)]]),
  ([%expr [%css "margin: 5px"]], [%expr [Css.margin(Css.px(5))]]),
  ([%expr [%css "opacity: 0.9"]], [%expr [Css.opacity(0.9)]]),
  ([%expr [%css "width: 100vw"]], [%expr [Css.width(Css.vw(100.))]]),
];

describe("emit bs-css from static [%css]", ({test, _}) => {
  let test = (index, (result, expected)) =>
    test("static css: " ++ string_of_int(index), compare(result, expected));
  List.iteri(test, static_css_tests);
});

let var_css_tests = [
  ([%expr [%css "color: $var"]], [%expr [Css.unsafe("color", var)]]),
  ([%expr [%css "margin: $var"]], [%expr [Css.unsafe("margin", var)]]),
];
describe("emit bs-css from variable [%css]", ({test, _}) => {
  let test = (index, (result, expected)) =>
    test("variable: " ++ string_of_int(index), compare(result, expected));
  List.iteri(test, var_css_tests);
});
