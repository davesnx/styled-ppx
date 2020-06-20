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

// TODO: ideas, selectors . properties, to have a bigger test matrix
// somehow programatically generate strings to test css
let properties_static_css_tests = [
  ([%expr [%css "align-items: center"]], [%expr [Css.alignItems(`center)]]),
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
    [%expr [Css.flexDirection(`column)]],
  ),
  ([%expr [%css "font-size: 30px"]], [%expr [Css.fontSize(Css.px(30))]]),
  ([%expr [%css "height: 100vh"]], [%expr [Css.height(Css.vh(100.))]]),
  (
    [%expr [%css "justify-content: center"]],
    [%expr [Css.justifyContent(`center)]],
  ),
  ([%expr [%css "margin: 0"]], [%expr [Css.margin(`zero)]]),
  ([%expr [%css "margin: 5px"]], [%expr [Css.margin(Css.px(5))]]),
  ([%expr [%css "opacity: 0.9"]], [%expr [Css.opacity(0.9)]]),
  ([%expr [%css "width: 100vw"]], [%expr [Css.width(Css.vw(100.))]]),
  ([%expr [%css "flex-wrap: wrap"]], [%expr [Css.flexWrap(`wrap)]]),
  (
    [%expr [%css "flex-flow: row nowrap"]],
    [%expr [Css.flexDirection(`row), Css.flexWrap(`nowrap)]],
  ),
  ([%expr [%css "order: 5"]], [%expr [Css.order(5)]]),
  ([%expr [%css "flex-grow: 2"]], [%expr [Css.flexGrow(2.)]]),
  // TODO: parser problems with decimal values
  // (
  //   [%expr [%css "flex-grow: 2.5"]],
  //   [%expr [Css.flexGrow(2.5)]],
  // ),
  ([%expr [%css "flex-shrink: 2"]], [%expr [Css.flexShrink(2.)]]),
  // TODO: parser problems with decimal values
  // (
  //   [%expr [%css "flex-shrink: 2.5"]],
  //   [%expr [Css.flexShrink(2.5)]],
  // ),
  ([%expr [%css "flex-basis: content"]], [%expr [Css.flexBasis(`content)]]),
  ([%expr [%css "flex: none"]], [%expr [Css.flex(`none)]]),
  (
    [%expr [%css "flex: 1 2 content"]],
    [%expr
      [Css.flexGrow(1.), Css.flexShrink(2.), Css.flexBasis(`content)]
    ],
  ),
  ([%expr [%css "align-self: stretch"]], [%expr [Css.alignSelf(`stretch)]]),
  (
    [%expr [%css "align-content: space-around"]],
    [%expr [Css.alignContent(`spaceAround)]],
  ),
];
let selectors_static_css_tests = [
  (
    [%expr [%css "& > a { color: green; }"]],
    [%expr [Css.selector({js|& > a|js}, [Css.color(Css.green)])]],
  ),
  (
    [%expr [%css "&:nth-child(even) { color: red; }"]],
    [%expr
      [Css.selector({js|&:nth-child(even)|js}, [Css.color(Css.red)])]
    ],
  ),
  (
    [%expr [%css "& > div:nth-child(3n+1) { color: blue; }"]],
    [%expr
      [
        Css.selector(
          {js|& > div:nth-child(3n  + 1)|js},
          [Css.color(Css.blue)],
        ),
      ]
    ],
  ),
  (
    [%expr [%css "&::active { color: brown; }"]],
    [%expr [Css.active([Css.color(Css.brown)])]],
  ),
  (
    [%expr [%css "&:hover { color: gray; }"]],
    [%expr [Css.hover([Css.color(Css.gray)])]],
  ),
];
describe("emit bs-css from static [%css]", ({test, _}) => {
  let test = (prefix, index, (result, expected)) =>
    test(prefix ++ string_of_int(index), compare(result, expected));

  List.iteri(test("properties static: "), properties_static_css_tests);
  List.iteri(test("selectors static: "), selectors_static_css_tests);
});

let properties_variable_css_tests = [
  ([%expr [%css "color: $var"]], [%expr [Css.unsafe("color", var)]]),
  ([%expr [%css "margin: $var"]], [%expr [Css.unsafe("margin", var)]]),
];
describe("emit bs-css from variable [%css]", ({test, _}) => {
  let test = (index, (result, expected)) =>
    test(
      "simple variable: " ++ string_of_int(index),
      compare(result, expected),
    );
  List.iteri(test, properties_variable_css_tests);
});
