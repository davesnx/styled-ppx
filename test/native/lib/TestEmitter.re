open Migrate_parsetree;
open Ast_410;
open Setup;

let extract_tests = array_expr => {
  open Ppxlib.Ast_pattern;
  let fail = () =>
    failwith("can only extract from array((result, expected))");
  let payload = pexp_array(many(pexp_tuple(many(__))));
  parse(
    payload,
    Location.none,
    ~on_error=fail,
    array_expr,
    List.map(
      fun
      | [result, expected] => (result, expected)
      | _ => fail(),
    ),
  );
};
let write_tests_to_file = (tests, file) => {
  let code =
    tests
    |> List.map(((expected, _)) => [%stri let _ = [%e expected]])
    |> List.append([[%stri open StyledPpxTestNativeBSCSS]])
    |> Pprintast.string_of_structure;
  let fd = open_out(file);
  output_string(fd, code);
  close_out(fd);
};

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
let properties_static_css_tests = [%expr
  [|
    // unsupported
    ([%css "overflow-x: clip"], [Css.unsafe("overflowX", "clip")]),
    // ([%css "align-items: center"], [Css.alignItems(`center)]),
    ([%css "box-sizing: border-box"], [Css.boxSizing(`borderBox)]),
    ([%css "box-sizing: content-box"], [Css.boxSizing(`contentBox)]),
    ([%css "color: #454545"], [Css.color(`hex("454545"))]),
    ([%css "color: red"], [Css.color(Css.red)]),
    ([%css "display: flex"], [Css.unsafe("display", "flex")]),
    ([%css "flex-direction: column"], [Css.flexDirection(`column)]),
    ([%css "font-size: 30px"], [Css.unsafe("fontSize", "30px")]),
    ([%css "height: 100vh"], [Css.height(`vh(100.))]),
    // (
    //   [%css "justify-content: center"],
    //   [Css.unsafe("justifyContent", "center")],
    // ),
    ([%css "margin: 0"], [Css.margin(`zero)]),
    ([%css "margin: 5px"], [Css.margin(`pxFloat(5.))]),
    ([%css "opacity: 0.9"], [Css.opacity(0.9)]),
    ([%css "width: 100vw"], [Css.width(`vw(100.))]),
    // css-sizing-3
    ([%css "width: auto"], [Css.width(`auto)]),
    ([%css "width: 0"], [Css.width(`zero)]),
    ([%css "height: 5px"], [Css.height(`pxFloat(5.))]),
    ([%css "min-width: 5%"], [Css.minWidth(`percent(5.))]),
    ([%css "min-height: 5em"], [Css.minHeight(`em(5.))]),
    ([%css "max-width: 3em"], [Css.maxWidth(`em(3.))]),
    ([%css "max-height: 3vh"], [Css.maxHeight(`vh(3.))]),
    ([%css "box-sizing: border-box"], [Css.boxSizing(`borderBox)]),
    // css-box-3
    ([%css "margin-top: auto"], [Css.marginTop(`auto)]),
    ([%css "margin-right: 1px"], [Css.marginRight(`pxFloat(1.))]),
    ([%css "margin-bottom: 2px"], [Css.marginBottom(`pxFloat(2.))]),
    ([%css "margin-left: 3px"], [Css.marginLeft(`pxFloat(3.))]),
    ([%css "margin: 1px"], [Css.margin(`pxFloat(1.))]),
    (
      [%css "margin: 1px 2px"],
      [Css.margin2(~v=`pxFloat(1.), ~h=`pxFloat(2.))],
    ),
    (
      [%css "margin: 1px 2px 3px"],
      [
        Css.margin3(
          ~top=`pxFloat(1.),
          ~h=`pxFloat(2.),
          ~bottom=`pxFloat(3.),
        ),
      ],
    ),
    (
      [%css "margin: 1px 2px 3px 4px"],
      [
        Css.margin4(
          ~top=`pxFloat(1.),
          ~right=`pxFloat(2.),
          ~bottom=`pxFloat(3.),
          ~left=`pxFloat(4.),
        ),
      ],
    ),
    ([%css "padding-top: 0"], [Css.paddingTop(`zero)]),
    ([%css "padding-right: 1px"], [Css.paddingRight(`pxFloat(1.))]),
    ([%css "padding-bottom: 2px"], [Css.paddingBottom(`pxFloat(2.))]),
    ([%css "padding-left: 3px"], [Css.paddingLeft(`pxFloat(3.))]),
    ([%css "padding: 1px"], [Css.padding(`pxFloat(1.))]),
    (
      [%css "padding: 1px 2px"],
      [Css.padding2(~v=`pxFloat(1.), ~h=`pxFloat(2.))],
    ),
    (
      [%css "padding: 1px 2px 3px"],
      [
        Css.padding3(
          ~top=`pxFloat(1.),
          ~h=`pxFloat(2.),
          ~bottom=`pxFloat(3.),
        ),
      ],
    ),
    (
      [%css "padding: 1px 2px 3px 4px"],
      [
        Css.padding4(
          ~top=`pxFloat(1.),
          ~right=`pxFloat(2.),
          ~bottom=`pxFloat(3.),
          ~left=`pxFloat(4.),
        ),
      ],
    ),
    ([%css "color: #012"], [Css.color(`hex("012"))]),
    ([%css "color: #0123"], [Css.color(`hex("0123"))]),
    ([%css "color: #012345"], [Css.color(`hex("012345"))]),
    ([%css "color: #01234567"], [Css.color(`hex("01234567"))]),
    ([%css "color: blue"], [Css.color(Css.blue)]),
    ([%css "color: currentcolor"], [Css.color(`currentColor)]),
    ([%css "color: transparent"], [Css.color(`transparent)]),
    ([%css "color: rgb(1 2 3)"], [Css.color(`rgb((1, 2, 3)))]),
    ([%css "color: rgb(1 2 3 / .4)"], [Css.color(`rgba((1, 2, 3, 0.4)))]),
    ([%css "color: rgba(1, 2, 3)"], [Css.color(`rgb((1, 2, 3)))]),
    (
      [%css "color: rgba(1, 2, 3, .4)"],
      [Css.color(`rgba((1, 2, 3, 0.4)))],
    ),
    (
      [%css "color: hsl(120deg 100% 50%)"],
      [Css.color(`hsl((`deg(120.), `percent(100.), `percent(50.))))],
    ),
    ([%css "opacity: 0.5"], [Css.opacity(0.5)]),
    ([%css "opacity: 60%"], [Css.opacity(0.6)]),
    // css-images-4
    ([%css "object-fit: fill"], [Css.objectFit(`fill)]),
    (
      [%css "object-position: right bottom"],
      [Css.objectPosition(`hv((`right, `bottom)))],
    ),
    // css-backgrounds-3
    ([%css "background-color: red"], [Css.backgroundColor(Css.red)]),
    ([%css "border-top-color: blue"], [Css.borderTopColor(Css.blue)]),
    ([%css "border-right-color: green"], [Css.borderRightColor(Css.green)]),
    (
      [%css "border-bottom-color: purple"],
      [Css.borderBottomColor(Css.purple)],
    ),
    ([%css "border-left-color: #fff"], [Css.borderLeftColor(`hex("fff"))]),
    ([%css "border-top-width: 15px"], [Css.borderTopWidth(`pxFloat(15.))]),
    (
      [%css "border-right-width: 16px"],
      [Css.borderRightWidth(`pxFloat(16.))],
    ),
    (
      [%css "border-bottom-width: 17px"],
      [Css.borderBottomWidth(`pxFloat(17.))],
    ),
    (
      [%css "border-left-width: 18px"],
      [Css.borderLeftWidth(`pxFloat(18.))],
    ),
    (
      [%css "border-top-left-radius: 12%"],
      [Css.borderTopLeftRadius(`percent(12.))],
    ),
    (
      [%css "border-top-right-radius: 15%"],
      [Css.borderTopRightRadius(`percent(15.))],
    ),
    (
      [%css "border-bottom-left-radius: 14%"],
      [Css.borderBottomLeftRadius(`percent(14.))],
    ),
    (
      [%css "border-bottom-right-radius: 13%"],
      [Css.borderBottomRightRadius(`percent(13.))],
    ),
    (
      [%css "box-shadow: 12px 12px 2px 1px rgba(0, 0, 255, .2)"],
      [
        Css.boxShadows([
          Css.Shadow.box(
            ~x=`pxFloat(12.),
            ~y=`pxFloat(12.),
            ~blur=`pxFloat(2.),
            ~spread=`pxFloat(1.),
            `rgba((0, 0, 255, 0.2)),
          ),
        ]),
      ],
    ),
    (
      [%css
        "box-shadow: 12px 12px 2px 1px rgba(0, 0, 255, .2), 13px 14px 5px 6px rgba(2, 1, 255, 50%)"
      ],
      [
        Css.boxShadows([
          Css.Shadow.box(
            ~x=`pxFloat(12.),
            ~y=`pxFloat(12.),
            ~blur=`pxFloat(2.),
            ~spread=`pxFloat(1.),
            `rgba((0, 0, 255, 0.2)),
          ),
          Css.Shadow.box(
            ~x=`pxFloat(13.),
            ~y=`pxFloat(14.),
            ~blur=`pxFloat(5.),
            ~spread=`pxFloat(6.),
            `rgba((2, 1, 255, 0.5)),
          ),
        ]),
      ],
    ),
    // css-overflow-3
    ([%css "overflow-x: auto"], [Css.overflowX(`auto)]),
    ([%css "overflow-y: hidden"], [Css.overflowY(`hidden)]),
    ([%css "overflow: scroll"], [Css.overflow(`scroll)]),
    (
      [%css "overflow: scroll visible"],
      [Css.overflowX(`scroll), Css.overflowY(`visible)],
    ),
    // ([%css "text-overflow: clip"], [Css.textOverflow(`clip)]),
    // ([%css "text-overflow: ellipsis"], [Css.textOverflow(`ellipsis)]),
    // css-text-3
    ([%css "text-transform: capitalize"], [Css.textTransform(`capitalize)]),
    ([%css "white-space: break-spaces"], [Css.whiteSpace(`breakSpaces)]),
    ([%css "word-break: keep-all"], [Css.wordBreak(`keepAll)]),
    ([%css "overflow-wrap: anywhere"], [Css.overflowWrap(`anywhere)]),
    ([%css "word-wrap: normal"], [Css.wordWrap(`normal)]),
    // ([%css "text-align: start"], [Css.textAlign(`start)]),
    ([%css "text-align: left"], [Css.textAlign(`left)]),
    ([%css "word-spacing: normal"], [Css.wordSpacing(`normal)]),
    ([%css "word-spacing: 5px"], [Css.wordSpacing(`pxFloat(5.))]),
    ([%css "letter-spacing: normal"], [Css.letterSpacing(`normal)]),
    ([%css "letter-spacing: 5px"], [Css.letterSpacing(`pxFloat(5.))]),
    ([%css "text-indent: 5%"], [Css.textIndent(`percent(5.))]),
    // css-flexbox-1
    ([%css "flex-wrap: wrap"], [Css.flexWrap(`wrap)]),
    // TODO: generate tests with variables in the future
    // ([%css "flex-wrap: $var"], [Css.flexWrap(var)]),
    // ([%css "flex-wrap: $(var)"], [Css.flexWrap(var)]),
    (
      [%css "flex-flow: row nowrap"],
      [Css.flexDirection(`row), Css.flexWrap(`nowrap)],
    ),
    // TODO: flex-flow + variables
    ([%css "order: 5"], [Css.order(5)]),
    ([%css "flex-grow: 2"], [Css.flexGrow(2.)]),
    ([%css "flex-grow: 2.5"], [Css.flexGrow(2.5)]),
    ([%css "flex-shrink: 2"], [Css.flexShrink(2.)]),
    ([%css "flex-shrink: 2.5"], [Css.flexShrink(2.5)]),
    ([%css "flex-basis: content"], [Css.flexBasis(`content)]),
    ([%css "flex: none"], [Css.flex(`none)]),
    (
      [%css "flex: 1 2 content"],
      [Css.flexGrow(1.), Css.flexShrink(2.), Css.flexBasis(`content)],
    ),
    // ([%css "align-self: stretch"], [Css.alignSelf(`stretch)]),
    // (
    //   [%css "align-content: space-around"],
    //   [Css.alignContent(`spaceAround)],
    // ),
    // not supported
    (
      [%css "-moz-text-blink: blink"],
      [Css.unsafe("MozTextBlink", "blink")],
    ),
    (
      [%css "display: -webkit-inline-box"],
      [Css.unsafe("display", "-webkit-inline-box")],
    ),
  |]
];
let selectors_static_css_tests = [%expr
  [|
    (
      [%css "& > a { color: green; }"],
      [Css.selector({js|& > a|js}, [Css.color(Css.green)])],
    ),
    (
      [%css "&:nth-child(even) { color: red; }"],
      [Css.selector({js|&:nth-child(even)|js}, [Css.color(Css.red)])],
    ),
    (
      [%css "& > div:nth-child(3n+1) { color: blue; }"],
      [
        Css.selector(
          {js|& > div:nth-child(3n  + 1)|js},
          [Css.color(Css.blue)],
        ),
      ],
    ),
    (
      [%css "&::active { color: brown; }"],
      [Css.active([Css.color(Css.brown)])],
    ),
    (
      [%css "&:hover { color: gray; }"],
      [Css.hover([Css.color(Css.gray)])],
    ),
  |]
];
let media_query_static_css_tests = [%expr
  [|
    (
      [%css {|color: blue; @media (min-width: 30em) { color: red; }|}],
      [
        Css.color(Css.blue),
        Css.media("(min-width: 30em)", [Css.color(Css.red)]),
      ],
    ),
    (
      [%css
        {|@media (min-width: 30em) and (min-height: 20em) { color: brown; }|}
      ],
      [
        Css.media(
          "(min-width: 30em) and (min-height: 20em)",
          [Css.color(Css.brown)],
        ),
      ],
    ),
  |]
];
let keyframe_static_css_tests = [%expr
  [|
    (
      [%styled.keyframe
        {|
        from { opacity: 0 }
        50% {
          background: red;
          border: 1px solid blue
        }
        to { opacity: 1 }
        |}
      ],
      [
        (0, [Css.opacity(0.)]),
        (
          50,
          [
            Css.unsafe("background", "red"),
            Css.unsafe("border", "1px solid blue"),
          ],
        ),
        (100, [Css.opacity(1.)]),
      ],
    ),
    (
      [%styled.keyframe
        {|
        0% { opacity: 0 }
        100% { opacity: 1 }
        |}
      ],
      [(0, [Css.opacity(0.)]), (100, [Css.opacity(1.)])],
    ),
  |]
];
describe("emit bs-css from static [%css]", ({test, _}) => {
  let test = (prefix, index, (result, expected)) =>
    test(prefix ++ string_of_int(index), compare(result, expected));
  let properties_static_css_tests =
    extract_tests(properties_static_css_tests);
  let selectors_static_css_tests = extract_tests(selectors_static_css_tests);
  let media_query_static_css_tests =
    extract_tests(media_query_static_css_tests);
  let keyframe_static_css_tests = extract_tests(keyframe_static_css_tests);

  write_tests_to_file(properties_static_css_tests, "static_css_tests.ml");
  write_tests_to_file(selectors_static_css_tests, "selectors_css_tests.ml");
  write_tests_to_file(
    media_query_static_css_tests,
    "media_query_css_tests.ml",
  );
  write_tests_to_file(keyframe_static_css_tests, "keyframe_css_tests.ml");

  List.iteri(test("properties static: "), properties_static_css_tests);
  List.iteri(test("selectors static: "), selectors_static_css_tests);
  List.iteri(test("media query static: "), media_query_static_css_tests);
  List.iteri(test("keyframes static: "), keyframe_static_css_tests);
});

let properties_variable_css_tests = [
  ([%expr [%css "color: $var"]], [%expr [Css.color(var)]]),
  // TODO: ([%css "margin: $var"], [%expr [Css.margin("margin", var)]),
];
describe("emit bs-css from variable [%css]", ({test, _}) => {
  let test = (index, (result, expected)) =>
    test(
      "simple variable: " ++ string_of_int(index),
      compare(result, expected),
    );
  List.iteri(test, properties_variable_css_tests);
});
