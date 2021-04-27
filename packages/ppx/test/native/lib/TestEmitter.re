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
    /* input: Css.style([Css.unsafe("display", "block")]) */
    /* We want to compare the arguments of style(), in this case Css.unsafe("display", "block") */
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
    ([%cx "box-sizing: border-box"], [Css.boxSizing(`borderBox)]),
    ([%cx "box-sizing: content-box"], [Css.boxSizing(`contentBox)]),
    /* ([%cx "color: #454545"], [Css.color(`hex("454545"))]), */
    ([%cx "color: red"], [Css.color(Css.red)]),
    /* ([%cx "display: flex"], [Css.unsafe("display", "flex")]), */
    ([%cx "flex-direction: column"], [Css.flexDirection(`column)]),
    /* ([%cx "font-size: 30px"], [Css.unsafe("fontSize", "30px")]), */
    ([%cx "height: 100vh"], [Css.height(`vh(100.))]),
    ([%cx "margin: 0"], [Css.margin(`zero)]),
    ([%cx "margin: 5px"], [Css.margin(`pxFloat(5.))]),
    ([%cx "opacity: 0.9"], [Css.opacity(0.9)]),
    ([%cx "width: 100vw"], [Css.width(`vw(100.))]),
    // css-sizing-3
    ([%cx "width: auto"], [Css.width(`auto)]),
    ([%cx "width: 0"], [Css.width(`zero)]),
    ([%cx "height: 5px"], [Css.height(`pxFloat(5.))]),
    ([%cx "min-width: 5%"], [Css.minWidth(`percent(5.))]),
    ([%cx "min-height: 5em"], [Css.minHeight(`em(5.))]),
    ([%cx "max-width: 3em"], [Css.maxWidth(`em(3.))]),
    ([%cx "max-height: 3vh"], [Css.maxHeight(`vh(3.))]),
    ([%cx "box-sizing: border-box"], [Css.boxSizing(`borderBox)]),
    // css-box-3
    ([%cx "margin-top: auto"], [Css.marginTop(`auto)]),
    ([%cx "margin-right: 1px"], [Css.marginRight(`pxFloat(1.))]),
    ([%cx "margin-bottom: 2px"], [Css.marginBottom(`pxFloat(2.))]),
    ([%cx "margin-left: 3px"], [Css.marginLeft(`pxFloat(3.))]),
    ([%cx "margin: 1px"], [Css.margin(`pxFloat(1.))]),
    (
      [%cx "margin: 1px 2px"],
      [Css.margin2(~v=`pxFloat(1.), ~h=`pxFloat(2.))],
    ),
    (
      [%cx "margin: 1px 2px 3px"],
      [
        Css.margin3(
          ~top=`pxFloat(1.),
          ~h=`pxFloat(2.),
          ~bottom=`pxFloat(3.),
        ),
      ],
    ),
    (
      [%cx "margin: 1px 2px 3px 4px"],
      [
        Css.margin4(
          ~top=`pxFloat(1.),
          ~right=`pxFloat(2.),
          ~bottom=`pxFloat(3.),
          ~left=`pxFloat(4.),
        ),
      ],
    ),
    ([%cx "padding-top: 0"], [Css.paddingTop(`zero)]),
    ([%cx "padding-right: 1px"], [Css.paddingRight(`pxFloat(1.))]),
    ([%cx "padding-bottom: 2px"], [Css.paddingBottom(`pxFloat(2.))]),
    ([%cx "padding-left: 3px"], [Css.paddingLeft(`pxFloat(3.))]),
    ([%cx "padding: 1px"], [Css.padding(`pxFloat(1.))]),
    (
      [%cx "padding: 1px 2px"],
      [Css.padding2(~v=`pxFloat(1.), ~h=`pxFloat(2.))],
    ),
    (
      [%cx "padding: 1px 2px 3px"],
      [
        Css.padding3(
          ~top=`pxFloat(1.),
          ~h=`pxFloat(2.),
          ~bottom=`pxFloat(3.),
        ),
      ],
    ),
    (
      [%cx "padding: 1px 2px 3px 4px"],
      [
        Css.padding4(
          ~top=`pxFloat(1.),
          ~right=`pxFloat(2.),
          ~bottom=`pxFloat(3.),
          ~left=`pxFloat(4.),
        ),
      ],
    ),
    /* ([%cx "color: #012"], [Css.color(`hex("012"))]), */
    /* ([%cx "color: #0123"], [Css.color(`hex("0123"))]), */
    /* ([%cx "color: #012345"], [Css.color(`hex("012345"))]), */
    /* ([%cx "color: #01234567"], [Css.color(`hex("01234567"))]), */
    ([%cx "color: blue"], [Css.color(Css.blue)]),
    ([%cx "color: currentcolor"], [Css.color(`currentColor)]),
    ([%cx "color: transparent"], [Css.color(`transparent)]),
    ([%cx "color: rgb(1 2 3)"], [Css.color(`rgb((1, 2, 3)))]),
    ([%cx "color: rgb(1 2 3 / .4)"], [Css.color(`rgba((1, 2, 3, 0.4)))]),
    ([%cx "color: rgba(1, 2, 3)"], [Css.color(`rgb((1, 2, 3)))]),
    (
      [%cx "color: rgba(1, 2, 3, .4)"],
      [Css.color(`rgba((1, 2, 3, 0.4)))],
    ),
    (
      [%cx "color: hsl(120deg 100% 50%)"],
      [Css.color(`hsl((`deg(120.), `percent(100.), `percent(50.))))],
    ),
    ([%cx "opacity: 0.5"], [Css.opacity(0.5)]),
    ([%cx "opacity: 60%"], [Css.opacity(0.6)]),
    // css-images-4
    ([%cx "object-fit: fill"], [Css.objectFit(`fill)]),
    (
      [%cx "object-position: right bottom"],
      [Css.objectPosition(`hv((`right, `bottom)))],
    ),
    // css-backgrounds-3
    ([%cx "background-color: red"], [Css.backgroundColor(Css.red)]),
    ([%cx "border-top-color: blue"], [Css.borderTopColor(Css.blue)]),
    ([%cx "border-right-color: green"], [Css.borderRightColor(Css.green)]),
    (
      [%cx "border-bottom-color: purple"],
      [Css.borderBottomColor(Css.purple)],
    ),
    /* ([%cx "border-left-color: #fff"], [Css.borderLeftColor(`hex("fff"))]), */
    ([%cx "border-top-width: 15px"], [Css.borderTopWidth(`pxFloat(15.))]),
    (
      [%cx "border-right-width: 16px"],
      [Css.borderRightWidth(`pxFloat(16.))],
    ),
    (
      [%cx "border-bottom-width: 17px"],
      [Css.borderBottomWidth(`pxFloat(17.))],
    ),
    (
      [%cx "border-left-width: 18px"],
      [Css.borderLeftWidth(`pxFloat(18.))],
    ),
    (
      [%cx "border-top-left-radius: 12%"],
      [Css.borderTopLeftRadius(`percent(12.))],
    ),
    (
      [%cx "border-top-right-radius: 15%"],
      [Css.borderTopRightRadius(`percent(15.))],
    ),
    (
      [%cx "border-bottom-left-radius: 14%"],
      [Css.borderBottomLeftRadius(`percent(14.))],
    ),
    (
      [%cx "border-bottom-right-radius: 13%"],
      [Css.borderBottomRightRadius(`percent(13.))],
    ),
    (
      [%cx "box-shadow: 12px 12px 2px 1px rgba(0, 0, 255, .2)"],
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
      [%cx
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
    ([%cx "overflow-x: auto"], [Css.overflowX(`auto)]),
    ([%cx "overflow-y: hidden"], [Css.overflowY(`hidden)]),
    ([%cx "overflow: scroll"], [Css.overflow(`scroll)]),
    (
      [%cx "overflow: scroll visible"],
      [Css.overflowX(`scroll), Css.overflowY(`visible)],
    ),
    // ([%cx "text-overflow: clip"], [Css.textOverflow(`clip)]),
    // ([%cx "text-overflow: ellipsis"], [Css.textOverflow(`ellipsis)]),
    // css-text-3
    ([%cx "text-transform: capitalize"], [Css.textTransform(`capitalize)]),
    ([%cx "white-space: break-spaces"], [Css.whiteSpace(`breakSpaces)]),
    ([%cx "word-break: keep-all"], [Css.wordBreak(`keepAll)]),
    ([%cx "overflow-wrap: anywhere"], [Css.overflowWrap(`anywhere)]),
    ([%cx "word-wrap: normal"], [Css.wordWrap(`normal)]),
    // ([%cx "text-align: start"], [Css.textAlign(`start)]),
    ([%cx "text-align: left"], [Css.textAlign(`left)]),
    ([%cx "word-spacing: normal"], [Css.wordSpacing(`normal)]),
    ([%cx "word-spacing: 5px"], [Css.wordSpacing(`pxFloat(5.))]),
    ([%cx "letter-spacing: normal"], [Css.letterSpacing(`normal)]),
    ([%cx "letter-spacing: 5px"], [Css.letterSpacing(`pxFloat(5.))]),
    ([%cx "text-indent: 5%"], [Css.textIndent(`percent(5.))]),
    // css-flexbox-1
    ([%cx "flex-wrap: wrap"], [Css.flexWrap(`wrap)]),
    // TODO: generate tests with variables in the future
    // ([%cx "flex-wrap: $var"], [Css.flexWrap(var)]),
    // ([%cx "flex-wrap: $(var)"], [Css.flexWrap(var)]),
    (
      [%cx "flex-flow: row nowrap"],
      [Css.flexDirection(`row), Css.flexWrap(`nowrap)],
    ),
    // TODO: flex-flow + variables
    ([%cx "order: 5"], [Css.order(5)]),
    ([%cx "flex-grow: 2"], [Css.flexGrow(2.)]),
    ([%cx "flex-grow: 2.5"], [Css.flexGrow(2.5)]),
    ([%cx "flex-shrink: 2"], [Css.flexShrink(2.)]),
    ([%cx "flex-shrink: 2.5"], [Css.flexShrink(2.5)]),
    ([%cx "flex-basis: content"], [Css.flexBasis(`content)]),
    ([%cx "flex: none"], [Css.flex(`none)]),
    (
      [%cx "flex: 1 2 content"],
      [Css.flexGrow(1.), Css.flexShrink(2.), Css.flexBasis(`content)],
    ),
    // unsupported
    /* ([%cx "overflow-x: clip"], [Css.unsafe("overflowX", "clip")]), */
    // ([%cx "align-items: center"], [Css.alignItems(`center)]),
    // ([%cx "align-self: stretch"], [Css.alignSelf(`stretch)]),
    // (
    //   [%cx "align-content: space-around"],
    //   [Css.alignContent(`spaceAround)],
    // ),
    // (
    //   [%cx "justify-content: center"],
    //   [Css.unsafe("justifyContent", "center")],
    // ),
    // not supported
    /* (
      [%cx "-moz-text-blink: blink"],
      [Css.unsafe("MozTextBlink", "blink")],
    ),
    (
      [%cx "display: -webkit-inline-box"],
      [Css.unsafe("display", "-webkit-inline-box")],
    ), */
  |]
];

let selectors_static_css_tests = [%expr
  [|
    (
      [%cx "& > a { color: green; }"],
      [Css.selector({js|& > a|js}, [Css.color(Css.green)])],
    ),
    (
      [%cx "&:nth-child(even) { color: red; }"],
      [Css.selector({js|&:nth-child(even)|js}, [Css.color(Css.red)])],
    ),
    (
      [%cx "& > div:nth-child(3n+1) { color: blue; }"],
      [
        Css.selector(
          {js|& > div:nth-child(3n  + 1)|js},
          [Css.color(Css.blue)],
        ),
      ],
    ),
    (
      [%cx "&::active { color: brown; }"],
      [Css.active([Css.color(Css.brown)])],
    ),
    (
      [%cx "&:hover { color: gray; }"],
      [Css.hover([Css.color(Css.gray)])],
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
        Css.color(Css.blue),
        Css.media("(min-width: 30em)", [Css.color(Css.red)]),
      ],
    ), */
    /* (
      [%cx "@media (min-width: 30em) and (min-height: 20em) { color: brown; }"
      ],
      [
        Css.media(
          "(min-width: 30em) and (min-height: 20em)",
          [Css.color(Css.brown)],
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
      [
        (0, [Css.opacity(0.)]),
        (100, [Css.opacity(1.)]),
      ],
    ),
    (
      [%styled.keyframe "
        0% { opacity: 0 }
        100% { opacity: 1 }
      "],
      [(0, [Css.opacity(0.)]), (100, [Css.opacity(1.)])],
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
  ([%expr [%cx "color: $var"]], [%expr [Css.color(var)]]),
  // TODO: ([%cx "margin: $var"], [%expr [Css.margin("margin", var)]),
];

describe("Transform [%cx] to bs-css with a variable interpolatated", ({test, _}) => {
  let test = (index, (result, expected)) =>
    test(
      "simple variable: " ++ string_of_int(index),
      compare(result, expected),
    );

  List.iteri(test, properties_variable_css_tests);
});
