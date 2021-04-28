open Setup;
open Ppxlib;
let loc = Location.none;
let extract_tests = array_expr => {
  let fail = () =>
    failwith("Extracting the expression from the test cases failed. The expected type is `array((result, expected))`.");
  let payload = Ast_pattern.(
    pexp_array(
      many(
        pexp_tuple(
          many(__)
        )
      )
    )
  );

  Ast_pattern.parse(
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

let write_tests_to_file = (
  tests: list((expression, expression)),
  file
) => {
  let code =
    tests
    |> List.map(((expected, _)) => [%stri let _ = [%e expected]])
    |> List.append([[%stri open StyledPpxTestNativeBSCSS]])
    |> Pprintast.string_of_structure;
  let fd = open_out(file);
  output_string(fd, code);
  close_out(fd);
};

let compare = (input: expression, expected, {expect, _}) => {
  let inputExpr =
    switch (input.pexp_desc) {
    /* input: CssJs.style([|CssJs.unsafe("display", "block")|]) */
    /* We want to compare the arguments of style(), in this case CssJs.unsafe("display", "block") */
    | Pexp_apply(_, [(_, expr)]) => expr
    | Pexp_extension(_) => failwith("Transformation by the ppx didn't happen. Expected an apply, got an extension.")
    | _ => failwith("Unexpected AST for the comparision. Probably the result changed: " ++ Pprintast.string_of_expression(input))
    };

  let result = Pprintast.string_of_expression(inputExpr);
  let expected = Pprintast.string_of_expression(expected);
  expect.string(result).toEqual(expected);
};

// TODO: ideas, selectors . properties, to have a bigger test matrix
// somehow programatically generate strings to test css

/* There are a few test that are commented since they use strings, those are interpreted as raw_literal on the metaquote that we use to diff the AST on the assertions and a missmatch with OCaml that makes the comparision fail even if they are correct. TODO: Fix this by removing the raw_literal on the metaquote transformation and uncomment the tests. */
let properties_static_css_tests = [%expr
  [|
    ([%cx "box-sizing: border-box"], [|CssJs.boxSizing(`borderBox)|]),
    ([%cx "box-sizing: content-box"], [|CssJs.boxSizing(`contentBox)|]),
    /* ([%cx "color: #454545"], [|CssJs.color(`hex("454545"))|]), */
    ([%cx "color: red"], [|CssJs.color(CssJs.red)|]),
    /* ([%cx "display: flex"], [|CssJs.unsafe("display", "flex")|]), */
    ([%cx "flex-direction: column"], [|CssJs.flexDirection(`column)|]),
    /* ([%cx "font-size: 30px"], [|CssJs.unsafe("fontSize", "30px")|]), */
    ([%cx "height: 100vh"], [|CssJs.height(`vh(100.))|]),
    ([%cx "margin: 0"], [|CssJs.margin(`zero)|]),
    ([%cx "margin: 5px"], [|CssJs.margin(`pxFloat(5.))|]),
    ([%cx "opacity: 0.9"], [|CssJs.opacity(0.9)|]),
    ([%cx "width: 100vw"], [|CssJs.width(`vw(100.))|]),
    // css-sizing-3
    ([%cx "width: auto"], [|CssJs.width(`auto)|]),
    ([%cx "width: 0"], [|CssJs.width(`zero)|]),
    ([%cx "height: 5px"], [|CssJs.height(`pxFloat(5.))|]),
    ([%cx "min-width: 5%"], [|CssJs.minWidth(`percent(5.))|]),
    ([%cx "min-height: 5em"], [|CssJs.minHeight(`em(5.))|]),
    ([%cx "max-width: 3em"], [|CssJs.maxWidth(`em(3.))|]),
    ([%cx "max-height: 3vh"], [|CssJs.maxHeight(`vh(3.))|]),
    ([%cx "box-sizing: border-box"], [|CssJs.boxSizing(`borderBox)|]),
    // css-box-3
    ([%cx "margin-top: auto"], [|CssJs.marginTop(`auto)|]),
    ([%cx "margin-right: 1px"], [|CssJs.marginRight(`pxFloat(1.))|]),
    ([%cx "margin-bottom: 2px"], [|CssJs.marginBottom(`pxFloat(2.))|]),
    ([%cx "margin-left: 3px"], [|CssJs.marginLeft(`pxFloat(3.))|]),
    ([%cx "margin: 1px"], [|CssJs.margin(`pxFloat(1.))|]),
    (
      [%cx "margin: 1px 2px"],
      [|CssJs.margin2(~v=`pxFloat(1.), ~h=`pxFloat(2.))|],
    ),
    (
      [%cx "margin: 1px 2px 3px"],
      [|
        CssJs.margin3(
          ~top=`pxFloat(1.),
          ~h=`pxFloat(2.),
          ~bottom=`pxFloat(3.),
        ),
      |],
    ),
    (
      [%cx "margin: 1px 2px 3px 4px"],
      [|
        CssJs.margin4(
          ~top=`pxFloat(1.),
          ~right=`pxFloat(2.),
          ~bottom=`pxFloat(3.),
          ~left=`pxFloat(4.),
        ),
      |],
    ),
    ([%cx "padding-top: 0"], [|CssJs.paddingTop(`zero)|]),
    ([%cx "padding-right: 1px"], [|CssJs.paddingRight(`pxFloat(1.))|]),
    ([%cx "padding-bottom: 2px"], [|CssJs.paddingBottom(`pxFloat(2.))|]),
    ([%cx "padding-left: 3px"], [|CssJs.paddingLeft(`pxFloat(3.))|]),
    ([%cx "padding: 1px"], [|CssJs.padding(`pxFloat(1.))|]),
    (
      [%cx "padding: 1px 2px"],
      [|CssJs.padding2(~v=`pxFloat(1.), ~h=`pxFloat(2.))|],
    ),
    (
      [%cx "padding: 1px 2px 3px"],
      [|
        CssJs.padding3(
          ~top=`pxFloat(1.),
          ~h=`pxFloat(2.),
          ~bottom=`pxFloat(3.),
        ),
      |],
    ),
    (
      [%cx "padding: 1px 2px 3px 4px"],
      [|
        CssJs.padding4(
          ~top=`pxFloat(1.),
          ~right=`pxFloat(2.),
          ~bottom=`pxFloat(3.),
          ~left=`pxFloat(4.),
        ),
      |],
    ),
    /* ([%cx "color: #012"], [|CssJs.color(`hex("012"))|]), */
    /* ([%cx "color: #0123"], [|CssJs.color(`hex("0123"))|]), */
    /* ([%cx "color: #012345"], [|CssJs.color(`hex("012345"))|]), */
    /* ([%cx "color: #01234567"], [|CssJs.color(`hex("01234567"))|]), */
    ([%cx "color: blue"], [|CssJs.color(CssJs.blue)|]),
    ([%cx "color: currentcolor"], [|CssJs.color(`currentColor)|]),
    ([%cx "color: transparent"], [|CssJs.color(`transparent)|]),
    ([%cx "color: rgb(1 2 3)"], [|CssJs.color(`rgb((1, 2, 3)))|]),
    ([%cx "color: rgb(1 2 3 / .4)"], [|CssJs.color(`rgba((1, 2, 3, 0.4)))|]),
    ([%cx "color: rgba(1, 2, 3)"], [|CssJs.color(`rgb((1, 2, 3)))|]),
    (
      [%cx "color: rgba(1, 2, 3, .4)"],
      [|CssJs.color(`rgba((1, 2, 3, 0.4)))|],
    ),
    (
      [%cx "color: hsl(120deg 100% 50%)"],
      [|CssJs.color(`hsl((`deg(120.), `percent(100.), `percent(50.))))|],
    ),
    ([%cx "opacity: 0.5"], [|CssJs.opacity(0.5)|]),
    ([%cx "opacity: 60%"], [|CssJs.opacity(0.6)|]),
    // css-images-4
    ([%cx "object-fit: fill"], [|CssJs.objectFit(`fill)|]),
    (
      [%cx "object-position: right bottom"],
      [|CssJs.objectPosition(`hv((`right, `bottom)))|],
    ),
    // css-backgrounds-3
    ([%cx "background-color: red"], [|CssJs.backgroundColor(CssJs.red)|]),
    ([%cx "border-top-color: blue"], [|CssJs.borderTopColor(CssJs.blue)|]),
    ([%cx "border-right-color: green"], [|CssJs.borderRightColor(CssJs.green)|]),
    (
      [%cx "border-bottom-color: purple"],
      [|CssJs.borderBottomColor(CssJs.purple)|],
    ),
    /* ([%cx "border-left-color: #fff"], [|CssJs.borderLeftColor(`hex("fff"))|]), */
    ([%cx "border-top-width: 15px"], [|CssJs.borderTopWidth(`pxFloat(15.))|]),
    (
      [%cx "border-right-width: 16px"],
      [|CssJs.borderRightWidth(`pxFloat(16.))|],
    ),
    (
      [%cx "border-bottom-width: 17px"],
      [|CssJs.borderBottomWidth(`pxFloat(17.))|],
    ),
    (
      [%cx "border-left-width: 18px"],
      [|CssJs.borderLeftWidth(`pxFloat(18.))|],
    ),
    (
      [%cx "border-top-left-radius: 12%"],
      [|CssJs.borderTopLeftRadius(`percent(12.))|],
    ),
    (
      [%cx "border-top-right-radius: 15%"],
      [|CssJs.borderTopRightRadius(`percent(15.))|],
    ),
    (
      [%cx "border-bottom-left-radius: 14%"],
      [|CssJs.borderBottomLeftRadius(`percent(14.))|],
    ),
    (
      [%cx "border-bottom-right-radius: 13%"],
      [|CssJs.borderBottomRightRadius(`percent(13.))|],
    ),
    (
      [%cx "box-shadow: 12px 12px 2px 1px rgba(0, 0, 255, .2)"],
      [|
        CssJs.boxShadows([|
          CssJs.Shadow.box(
            ~x=`pxFloat(12.),
            ~y=`pxFloat(12.),
            ~blur=`pxFloat(2.),
            ~spread=`pxFloat(1.),
            `rgba((0, 0, 255, 0.2)),
          ),
        |]),
      |],
    ),
    (
      [%cx
        "box-shadow: 12px 12px 2px 1px rgba(0, 0, 255, .2), 13px 14px 5px 6px rgba(2, 1, 255, 50%)"
      ],
      [|
        CssJs.boxShadows([|
          CssJs.Shadow.box(
            ~x=`pxFloat(12.),
            ~y=`pxFloat(12.),
            ~blur=`pxFloat(2.),
            ~spread=`pxFloat(1.),
            `rgba((0, 0, 255, 0.2)),
          ),
          CssJs.Shadow.box(
            ~x=`pxFloat(13.),
            ~y=`pxFloat(14.),
            ~blur=`pxFloat(5.),
            ~spread=`pxFloat(6.),
            `rgba((2, 1, 255, 0.5)),
          ),
        |]),
      |],
    ),
    // css-overflow-3
    ([%cx "overflow-x: auto"], [|CssJs.overflowX(`auto)|]),
    ([%cx "overflow-y: hidden"], [|CssJs.overflowY(`hidden)|]),
    ([%cx "overflow: scroll"], [|CssJs.overflow(`scroll)|]),
    (
      [%cx "overflow: scroll visible"],
      [|CssJs.overflowX(`scroll), CssJs.overflowY(`visible)|],
    ),
    // ([%cx "text-overflow: clip"], [|CssJs.textOverflow(`clip)|]),
    // ([%cx "text-overflow: ellipsis"], [|CssJs.textOverflow(`ellipsis)|]),
    // css-text-3
    ([%cx "text-transform: capitalize"], [|CssJs.textTransform(`capitalize)|]),
    ([%cx "white-space: break-spaces"], [|CssJs.whiteSpace(`breakSpaces)|]),
    ([%cx "word-break: keep-all"], [|CssJs.wordBreak(`keepAll)|]),
    ([%cx "overflow-wrap: anywhere"], [|CssJs.overflowWrap(`anywhere)|]),
    ([%cx "word-wrap: normal"], [|CssJs.wordWrap(`normal)|]),
    // ([%cx "text-align: start"], [|CssJs.textAlign(`start)|]),
    ([%cx "text-align: left"], [|CssJs.textAlign(`left)|]),
    ([%cx "word-spacing: normal"], [|CssJs.wordSpacing(`normal)|]),
    ([%cx "word-spacing: 5px"], [|CssJs.wordSpacing(`pxFloat(5.))|]),
    ([%cx "letter-spacing: normal"], [|CssJs.letterSpacing(`normal)|]),
    ([%cx "letter-spacing: 5px"], [|CssJs.letterSpacing(`pxFloat(5.))|]),
    ([%cx "text-indent: 5%"], [|CssJs.textIndent(`percent(5.))|]),
    // css-flexbox-1
    ([%cx "flex-wrap: wrap"], [|CssJs.flexWrap(`wrap)|]),
    // TODO: generate tests with variables in the future
    // ([%cx "flex-wrap: $var"], [|CssJs.flexWrap(var)|]),
    // ([%cx "flex-wrap: $(var)"], [|CssJs.flexWrap(var)|]),
    (
      [%cx "flex-flow: row nowrap"],
      [|CssJs.flexDirection(`row), CssJs.flexWrap(`nowrap)|],
    ),
    // TODO: flex-flow + variables
    ([%cx "order: 5"], [|CssJs.order(5)|]),
    ([%cx "flex-grow: 2"], [|CssJs.flexGrow(2.)|]),
    ([%cx "flex-grow: 2.5"], [|CssJs.flexGrow(2.5)|]),
    ([%cx "flex-shrink: 2"], [|CssJs.flexShrink(2.)|]),
    ([%cx "flex-shrink: 2.5"], [|CssJs.flexShrink(2.5)|]),
    ([%cx "flex-basis: content"], [|CssJs.flexBasis(`content)|]),
    ([%cx "flex: none"], [|CssJs.flex(`none)|]),
    (
      [%cx "flex: 1 2 content"],
      [|CssJs.flexGrow(1.), CssJs.flexShrink(2.), CssJs.flexBasis(`content)|],
    ),
    // unsupported
    /* ([%cx "overflow-x: clip"], [|CssJs.unsafe("overflowX", "clip")|]), */
    // ([%cx "align-items: center"], [|CssJs.alignItems(`center)|]),
    // ([%cx "align-self: stretch"], [|CssJs.alignSelf(`stretch)|]),
    // (
    //   [%cx "align-content: space-around"],
    //   [|CssJs.alignContent(`spaceAround)],
    // ),
    // (
    //   [%cx "justify-content: center"],
    //   [|CssJs.unsafe("justifyContent", "center")],
    // ),
    // not supported
    /* (
      [%cx "-moz-text-blink: blink"],
      [|CssJs.unsafe("MozTextBlink", "blink")],
    ),
    (
      [%cx "display: -webkit-inline-box"],
      [|CssJs.unsafe("display", "-webkit-inline-box")],
    ), */
  |]
];

let selectors_static_css_tests = [%expr
  [|
    (
      [%cx "& > a { color: green; }"],
      [|CssJs.selector({js|& > a|js}, [|CssJs.color(CssJs.green)|])|],
    ),
    (
      [%cx "&:nth-child(even) { color: red; }"],
      [|CssJs.selector({js|&:nth-child(even)|js}, [|CssJs.color(CssJs.red)|])|],
    ),
    (
      [%cx "& > div:nth-child(3n+1) { color: blue; }"],
      [|
        CssJs.selector(
          {js|& > div:nth-child(3n  + 1)|js},
          [|CssJs.color(CssJs.blue)|],
        ),
      |],
    ),
    (
      [%cx "&::active { color: brown; }"],
      [|CssJs.active([|CssJs.color(CssJs.brown)|])|],
    ),
    (
      [%cx "&:hover { color: gray; }"],
      [|CssJs.hover([|CssJs.color(CssJs.gray)|])|],
    ),
  |]
];

/*
TODO: Since we commented the string-based tests, mediaqueries rely entirely on them, so we disable them here and in the dune.

let media_query_static_css_tests = [%expr
  [|
    /* (
      [%cx "color: blue; @media (min-width: 30em) { color: red; }"],
      [
        CssJs.color(CssJs.blue),
        CssJs.media("(min-width: 30em)", [|CssJs.color(CssJs.red)|]),
      ],
    ), */
    /* (
      [%cx "@media (min-width: 30em) and (min-height: 20em) { color: brown; }"
      ],
      [
        CssJs.media(
          "(min-width: 30em) and (min-height: 20em)",
          [|CssJs.color(CssJs.brown)],
        ),
      ],
    ), */
  |]
];
 */

let keyframe_static_css_tests = [%expr
  [|
    (
      [%styled.keyframe
        "
          from { opacity: 0 }
          to { opacity: 1 }
        "
      ],
      [|
        (0, [|CssJs.opacity(0.)|]),
        (100, [|CssJs.opacity(1.)|]),
      |],
    ),
    (
      [%styled.keyframe "
        0% { opacity: 0 }
        100% { opacity: 1 }
      "],
      [|(0, [|CssJs.opacity(0.)|]), (100, [|CssJs.opacity(1.)|])|],
    ),
  |]
];

describe("Transform [%cx] to bs-css", ({test, _}) => {
  let test = (prefix, index, (input, expected)) =>
    test(prefix ++ string_of_int(index), compare(input, expected));

  let properties_static_css_tests =
    extract_tests(properties_static_css_tests);
  let selectors_static_css_tests = extract_tests(selectors_static_css_tests);
  /* let media_query_static_css_tests =
    extract_tests(media_query_static_css_tests); */
  let keyframe_static_css_tests = extract_tests(keyframe_static_css_tests);

  /* We write the tests to files so the Typecheker runs on them and ensures
  it's a valid with bs-css interfaces */
  write_tests_to_file(properties_static_css_tests, "static_css_tests.ml");
  write_tests_to_file(selectors_static_css_tests, "selectors_css_tests.ml");
  /* write_tests_to_file(
    media_query_static_css_tests,
    "media_query_css_tests.ml",
  ); */
  write_tests_to_file(keyframe_static_css_tests, "keyframe_css_tests.ml");

  List.iteri(test("properties static: "), properties_static_css_tests);
  List.iteri(test("selectors static: "), selectors_static_css_tests);
  /* List.iteri(test("media query static: "), media_query_static_css_tests); */
  List.iteri(test("keyframes static: "), keyframe_static_css_tests);
});

let properties_variable_css_tests = [
  ([%expr [%cx "color: $var"]], [%expr [|CssJs.color(var)|]]),
  // TODO: ([%cx "margin: $var"], [%expr [|CssJs.margin("margin", var)|]),
];

describe("Transform [%cx] to bs-css with a variable interpolatated", ({test, _}) => {
  let test = (index, (result, expected)) =>
    test(
      "simple variable: " ++ string_of_int(index),
      compare(result, expected),
    );

  List.iteri(test, properties_variable_css_tests);
});
