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
    |> List.append([[%stri open MockBsCss]])
    |> Pprintast.string_of_structure;
  let fd = open_out(file);
  output_string(fd, code);
  close_out(fd);
};

let compare = (input: expression, expected, {expect, _}) => {
  let result = Pprintast.string_of_expression(input);
  let expected = Pprintast.string_of_expression(expected);
  expect.string(result).toEqual(expected);
};

// TODO: ideas, selectors . properties, to have a bigger test matrix
// somehow programatically generate strings to test css

/* There are a few test that are commented since they use strings,
  those are interpreted as raw_literal on the metaquote
  that we use to diff the AST on the assertions and a missmatch
  with OCaml that makes the comparision fail even if they are correct.
  TODO: Fix this by removing the raw_literal on the metaquote transformation
  and uncomment the tests. */
let properties_static_css_tests = [%expr
  [|
    ([%css_ "box-sizing: border-box"], CssJs.boxSizing(`borderBox)),
    ([%css_ "box-sizing: content-box"], CssJs.boxSizing(`contentBox)),
    /* ([%css_ "color: #454545"], CssJs.color(`hex("454545"))), */
    ([%css_ "color: red"], CssJs.color(CssJs.red)),
    /* ([%css_ "display: flex"], CssJs.unsafe("display", "flex")), */
    ([%css_ "flex-direction: column"], CssJs.flexDirection(`column)),
    /* ([%css_ "font-size: 30px"], CssJs.unsafe("fontSize", "30px")), */
    ([%css_ "height: 100vh"], CssJs.height(`vh(100.))),
    ([%css_ "margin: 0"], CssJs.margin(`zero)),
    ([%css_ "margin: 5px"], CssJs.margin(`pxFloat(5.))),
    ([%css_ "opacity: 0.9"], CssJs.opacity(0.9)),
    ([%css_ "width: 100vw"], CssJs.width(`vw(100.))),
    // css-sizing-3
    ([%css_ "width: auto"], CssJs.width(`auto)),
    ([%css_ "width: 0"], CssJs.width(`zero)),
    ([%css_ "height: 5px"], CssJs.height(`pxFloat(5.))),
    ([%css_ "min-width: 5%"], CssJs.minWidth(`percent(5.))),
    ([%css_ "min-height: 5em"], CssJs.minHeight(`em(5.))),
    ([%css_ "max-width: 3em"], CssJs.maxWidth(`em(3.))),
    ([%css_ "max-height: 3vh"], CssJs.maxHeight(`vh(3.))),
    ([%css_ "box-sizing: border-box"], CssJs.boxSizing(`borderBox)),
    // css-box-3
    ([%css_ "margin-top: auto"], CssJs.marginTop(`auto)),
    ([%css_ "margin-right: 1px"], CssJs.marginRight(`pxFloat(1.))),
    ([%css_ "margin-bottom: 2px"], CssJs.marginBottom(`pxFloat(2.))),
    ([%css_ "margin-left: 3px"], CssJs.marginLeft(`pxFloat(3.))),
    ([%css_ "margin: 1px"], CssJs.margin(`pxFloat(1.))),
    (
      [%css_ "margin: 1px 2px"],
      CssJs.margin2(~v=`pxFloat(1.), ~h=`pxFloat(2.)),
    ),
    (
      [%css_ "margin: 1px 2px 3px"],
      CssJs.margin3(
        ~top=`pxFloat(1.),
        ~h=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
      ),
    ),
    (
      [%css_ "margin: 1px 2px 3px 4px"],
      CssJs.margin4(
        ~top=`pxFloat(1.),
        ~right=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
        ~left=`pxFloat(4.),
      ),
    ),
    ([%css_ "padding-top: 0"], CssJs.paddingTop(`zero)),
    ([%css_ "padding-right: 1px"], CssJs.paddingRight(`pxFloat(1.))),
    ([%css_ "padding-bottom: 2px"], CssJs.paddingBottom(`pxFloat(2.))),
    ([%css_ "padding-left: 3px"], CssJs.paddingLeft(`pxFloat(3.))),
    ([%css_ "padding: 1px"], CssJs.padding(`pxFloat(1.))),
    (
      [%css_ "padding: 1px 2px"],
      CssJs.padding2(~v=`pxFloat(1.), ~h=`pxFloat(2.)),
    ),
    (
      [%css_ "padding: 1px 2px 3px"],
      CssJs.padding3(
        ~top=`pxFloat(1.),
        ~h=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
      ),
    ),
    (
      [%css_ "padding: 1px 2px 3px 4px"],
      CssJs.padding4(
        ~top=`pxFloat(1.),
        ~right=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
        ~left=`pxFloat(4.),
      ),
    ),
    /* ([%css_ "color: #012"], CssJs.color(`hex("012"))), */
    /* ([%css_ "color: #0123"], CssJs.color(`hex("0123"))), */
    /* ([%css_ "color: #012345"], CssJs.color(`hex("012345"))), */
    /* ([%css_ "color: #01234567"], CssJs.color(`hex("01234567"))), */
    ([%css_ "color: blue"], CssJs.color(CssJs.blue)),
    ([%css_ "color: currentColor"], CssJs.color(`currentColor)),
    ([%css_ "color: transparent"], CssJs.color(`transparent)),
    ([%css_ "color: rgb(1 2 3)"], CssJs.color(`rgb((1, 2, 3)))),
    ([%css_ "color: rgb(1 2 3 / .4)"], CssJs.color(`rgba((1, 2, 3, `num (0.4))))),
    ([%css_ "color: rgba(1, 2, 3)"], CssJs.color(`rgb((1, 2, 3)))),
    (
      [%css_ "color: rgba(1, 2, 3, .4)"],
      CssJs.color(`rgba((1, 2, 3, `num(0.4)))),
    ),
    (
      [%css_ "color: rgba(1, 2, 3, 50%)"],
      CssJs.color(`rgba((1, 2, 3, `percent(0.5)))),
    ),
    (
      [%css_ "color: hsl(120deg 100% 50%)"],
      CssJs.color(`hsl((`deg(120.), `percent(100.), `percent(50.)))),
    ),
    ([%css_ "opacity: 0.5"], CssJs.opacity(0.5)),
    ([%css_ "opacity: 60%"], CssJs.opacity(0.6)),
    // css-images-4
    ([%css_ "object-fit: fill"], CssJs.objectFit(`fill)),
    (
      [%css_ "object-position: right bottom"],
      CssJs.objectPosition(`hv((`right, `bottom))),
    ),
    // css-backgrounds-3
    ([%css_ "background-color: red"], CssJs.backgroundColor(CssJs.red)),
    ([%css_ "border-top-color: blue"], CssJs.borderTopColor(CssJs.blue)),
    ([%css_ "border-right-color: green"], CssJs.borderRightColor(CssJs.green)),
    /* ([%css_ "border-left-color: #fff"], CssJs.borderLeftColor(`hex("fff"))), */
    ([%css_ "border-top-width: 15px"], CssJs.borderTopWidth(`pxFloat(15.))),
    (
      [%css_ "border-right-width: 16px"],
      CssJs.borderRightWidth(`pxFloat(16.)),
    ),
    (
      [%css_ "border-bottom-width: 17px"],
      CssJs.borderBottomWidth(`pxFloat(17.)),
    ),
    (
      [%css_ "border-left-width: 18px"],
      CssJs.borderLeftWidth(`pxFloat(18.)),
    ),
    (
      [%css_ "border-top-left-radius: 12%"],
      CssJs.borderTopLeftRadius(`percent(12.)),
    ),
    (
      [%css_ "border-top-right-radius: 15%"],
      CssJs.borderTopRightRadius(`percent(15.)),
    ),
    (
      [%css_ "border-bottom-left-radius: 14%"],
      CssJs.borderBottomLeftRadius(`percent(14.)),
    ),
    (
      [%css_ "border-bottom-right-radius: 13%"],
      CssJs.borderBottomRightRadius(`percent(13.)),
    ),
    // css-overflow-3
    ([%css_ "overflow-x: auto"], CssJs.overflowX(`auto)),
    ([%css_ "overflow-y: hidden"], CssJs.overflowY(`hidden)),
    ([%css_ "overflow: scroll"], CssJs.overflow(`scroll)),
    /* (
      [%css_ "overflow: scroll visible"],
      CssJs.overflowX(`scroll), CssJs.overflowY(`visible),
    ), */
    // ([%css_ "text-overflow: clip"], CssJs.textOverflow(`clip)),
    // ([%css_ "text-overflow: ellipsis"], CssJs.textOverflow(`ellipsis)),
    // css-text-3
    ([%css_ "text-transform: capitalize"], CssJs.textTransform(`capitalize)),
    ([%css_ "white-space: break-spaces"], CssJs.whiteSpace(`breakSpaces)),
    ([%css_ "word-break: keep-all"], CssJs.wordBreak(`keepAll)),
    ([%css_ "overflow-wrap: anywhere"], CssJs.overflowWrap(`anywhere)),
    ([%css_ "word-wrap: normal"], CssJs.wordWrap(`normal)),
    // ([%css_ "text-align: start"], CssJs.textAlign(`start)),
    ([%css_ "text-align: left"], CssJs.textAlign(`left)),
    ([%css_ "word-spacing: normal"], CssJs.wordSpacing(`normal)),
    ([%css_ "word-spacing: 5px"], CssJs.wordSpacing(`pxFloat(5.))),
    ([%css_ "letter-spacing: normal"], CssJs.letterSpacing(`normal)),
    ([%css_ "letter-spacing: 5px"], CssJs.letterSpacing(`pxFloat(5.))),
    ([%css_ "text-indent: 5%"], CssJs.textIndent(`percent(5.))),
    // css-flexbox-1
    ([%css_ "flex-wrap: wrap"], CssJs.flexWrap(`wrap)),
    // TODO: generate tests with variables in the future
    // ([%css_ "flex-wrap: $var"], CssJs.flexWrap(var)),
    // ([%css_ "flex-wrap: $(var)"], CssJs.flexWrap(var)),
    /* (
      [%css_ "flex-flow: row nowrap"],
      CssJs.flexDirection(`row), CssJs.flexWrap(`nowrap)|],
    ), */
    // TODO: flex-flow + variables
    ([%css_ "order: 5"], CssJs.order(5)),
    ([%css_ "flex-grow: 2"], CssJs.flexGrow(2.)),
    ([%css_ "flex-grow: 2.5"], CssJs.flexGrow(2.5)),
    ([%css_ "flex-shrink: 2"], CssJs.flexShrink(2.)),
    ([%css_ "flex-shrink: 2.5"], CssJs.flexShrink(2.5)),
    ([%css_ "flex-basis: content"], CssJs.flexBasis(`content)),
    ([%css_ "flex: none"], CssJs.flex(`none)),
    /* (
      [%css_ "flex: 1 2 content"],
      CssJs.flexGrow(1.), CssJs.flexShrink(2.), CssJs.flexBasis(`content)|],
    ), */
    // unsupported
    /* ([%css_ "overflow-x: clip"], CssJs.unsafe("overflowX", "clip")), */
    // ([%css_ "align-items: center"], CssJs.alignItems(`center)),
    // ([%css_ "align-self: stretch"], CssJs.alignSelf(`stretch)),
    // (
    //   [%css_ "align-content: space-around"],
    //   CssJs.alignContent(`spaceAround)],
    // ),
    // (
    //   [%css_ "justify-content: center"],
    //   CssJs.unsafe("justifyContent", "center")],
    // ),
    // not supported
    /* (
      [%css_ "-moz-text-blink: blink"],
      CssJs.unsafe("MozTextBlink", "blink")],
    ),
    (
      [%css_ "display: -webkit-inline-box"],
      CssJs.unsafe("display", "-webkit-inline-box")],
    ), */
  |]
];

describe("Transform [%css_] to bs-css", ({test, _}) => {
  let test = (prefix, index, (input, expected)) =>
    test(prefix ++ string_of_int(index), compare(input, expected));

  let properties_static_css_tests =
    extract_tests(properties_static_css_tests);

  /* We write the tests to files so the Typecheker runs on them and ensures
  it's a valid with bs-css interfaces */
  write_tests_to_file(properties_static_css_tests, "static_css_tests.ml");
  List.iteri(test("properties static: "), properties_static_css_tests);
});


/*
  Commented this tests since they rely on strings, similar to the comment above,
  reason ast transforms strings to (""[@reason.raw_literal ""]) which isn't easy to do in metaquote, prefer to skip those.

let properties_variable_css_tests = [
  ([%expr [%css_ "color: $(var);"]], [%expr CssJs.unsafe("color", var)]),
  ([%expr [%css_ "margin: $(var);"]], [%expr CssJs.unsafe("margin", var)]),
];

describe("Transform [%css_] to bs-css with interpolatated variables", ({test, _}) => {
  let test = (index, (result, expected)) =>
    test(
      "simple variable: " ++ string_of_int(index),
      compare(result, expected),
    );

  List.iteri(test, properties_variable_css_tests);
});
 */
