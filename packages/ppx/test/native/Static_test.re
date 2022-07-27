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

let compare = (input, expected, {expect, _}) => {
  let result = Pprintast.string_of_expression(input);
  let expected = Pprintast.string_of_expression(expected);
  expect.string(result).toEqual(expected);
};

/* The tests that are commented, means that we don't support them safely */
let properties_static_css_tests = [%expr
  [|
    (
      [%css "display: block;"],
      (CssJs.display(`block) : CssJs.rule)
    ),
    (
      [%css "box-sizing: border-box"],
      (CssJs.boxSizing(`borderBox) : CssJs.rule)
    ),
    (
      [%css "box-sizing: content-box"],
      (CssJs.boxSizing(`contentBox) : CssJs.rule)
    ),
    (
      [%css "color: #454545"],
      (CssJs.color(`hex({js|454545|js})) : CssJs.rule)
    ),
    (
      [%css "color: red"],
      (CssJs.color(CssJs.red) : CssJs.rule)
    ),
    (
      [%css "display: flex"],
      (CssJs.display(`flex) : CssJs.rule)
    ),
    (
      [%css "flex-direction: column"],
      (CssJs.flexDirection(`column) : CssJs.rule)
    ),
    (
      [%css "font-size: 30px"],
      (CssJs.fontSize(`pxFloat(30.)) : CssJs.rule)
    ),
    (
      [%css "height: 100vh"],
      (CssJs.height(`vh(100.)) : CssJs.rule)
    ),
    (
      [%css "margin: 0"],
      (CssJs.margin(`zero) : CssJs.rule)
    ),
    (
      [%css "margin: 5px"],
      (CssJs.margin(`pxFloat(5.)) : CssJs.rule)
    ),
    (
      [%css "opacity: 0.9"],
      (CssJs.opacity(0.9) : CssJs.rule)
    ),
    (
      [%css "width: 100vw"],
      (CssJs.width(`vw(100.)) : CssJs.rule)
    ),
    // css-sizing-3
    (
      [%css "width: auto"],
      (CssJs.width(`auto) : CssJs.rule)
    ),
    (
      [%css "width: 0"],
      (CssJs.width(`zero) : CssJs.rule)
    ),
    (
      [%css "height: 5px"],
      (CssJs.height(`pxFloat(5.)) : CssJs.rule)
    ),
    (
      [%css "min-width: 5%"],
      (CssJs.minWidth(`percent(5.)) : CssJs.rule)
    ),
    (
      [%css "min-height: 5em"],
      (CssJs.minHeight(`em(5.)) : CssJs.rule)
    ),
    (
      [%css "max-width: 3em"],
      (CssJs.maxWidth(`em(3.)) : CssJs.rule)
    ),
    (
      [%css "max-height: 3vh"],
      (CssJs.maxHeight(`vh(3.)) : CssJs.rule)
    ),
    (
      [%css "box-sizing: border-box"],
      (CssJs.boxSizing(`borderBox) : CssJs.rule)
    ),
    // css-box-3
    (
      [%css "margin-top: auto"],
      (CssJs.marginTop(`auto) : CssJs.rule)
    ),
    (
      [%css "margin-right: 1px"],
      (CssJs.marginRight(`pxFloat(1.)) : CssJs.rule)
    ),
    (
      [%css "margin-bottom: 2px"],
      (CssJs.marginBottom(`pxFloat(2.)) : CssJs.rule)
    ),
    (
      [%css "margin-left: 3px"],
      (CssJs.marginLeft(`pxFloat(3.)) : CssJs.rule)
    ),
    (
      [%css "margin: 1px"],
      (CssJs.margin(`pxFloat(1.)) : CssJs.rule)
    ),
    (
      [%css "margin: 1px 2px"],
      (CssJs.margin2(~v=`pxFloat(1.), ~h=`pxFloat(2.)) : CssJs.rule)
    ),
    (
      [%css "margin: 1px 2px 3px"],
      (CssJs.margin3(
        ~top=`pxFloat(1.),
        ~h=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
      ) : CssJs.rule)
    ),
    (
      [%css "margin: 1px 2px 3px 4px"],
      (CssJs.margin4(
        ~top=`pxFloat(1.),
        ~right=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
        ~left=`pxFloat(4.),
      ) : CssJs.rule)
    ),
    (
      [%css "padding-top: 0"],
      (CssJs.paddingTop(`zero) : CssJs.rule)
    ),
    (
      [%css "padding-right: 1px"],
      (CssJs.paddingRight(`pxFloat(1.)) : CssJs.rule)
    ),
    (
      [%css "padding-bottom: 2px"],
      (CssJs.paddingBottom(`pxFloat(2.)) : CssJs.rule)
    ),
    (
      [%css "padding-left: 3px"],
      (CssJs.paddingLeft(`pxFloat(3.)) : CssJs.rule)
    ),
    (
      [%css "padding: 1px"],
      (CssJs.padding(`pxFloat(1.)) : CssJs.rule)
    ),
    (
      [%css "padding: 1px 2px"],
      (CssJs.padding2(~v=`pxFloat(1.), ~h=`pxFloat(2.)) : CssJs.rule)
    ),
    (
      [%css "padding: 1px 2px 3px"],
      (CssJs.padding3(
        ~top=`pxFloat(1.),
        ~h=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
      ) : CssJs.rule)
    ),
    (
      [%css "padding: 1px 2px 3px 4px"],
      (CssJs.padding4(
        ~top=`pxFloat(1.),
        ~right=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
        ~left=`pxFloat(4.),
      ) : CssJs.rule)
    ),
    (
      [%css "color: #012"],
      (CssJs.color(`hex({js|012|js})) : CssJs.rule)
    ),
    (
      [%css "color: #0123"],
      (CssJs.color(`hex({js|0123|js})) : CssJs.rule)
    ),
    (  
      [%css "color: #012345"],
      (CssJs.color(`hex({js|012345|js})) : CssJs.rule)
    ),
    (
      [%css "color: #01234567"],
      (CssJs.color(`hex({js|01234567|js})) : CssJs.rule)
    ),
    (
      [%css "color: blue"],
      (CssJs.color(CssJs.blue) : CssJs.rule)
    ),
    (
      [%css "color: currentColor"],
      (CssJs.color(`currentColor) : CssJs.rule)
    ),
     (
      [%css "color: transparent"],
      (CssJs.color(`transparent) : CssJs.rule)
    ),
    (
      [%css "color: rgb(1 2 3)"],
      (CssJs.color(`rgb((1, 2, 3))) : CssJs.rule)
    ),
    (
      [%css "color: rgb(1 2 3 / .4)"],
      (CssJs.color(`rgba((1, 2, 3, `num (0.4)))) : CssJs.rule)
    ),
    (
      [%css "color: rgba(1, 2, 3)"],
      (CssJs.color(`rgb((1, 2, 3))) : CssJs.rule)
    ),
    (
      [%css "color: rgba(1, 2, 3, .4)"],
      (CssJs.color(`rgba((1, 2, 3, `num(0.4)))) : CssJs.rule)
    ),
    (
      [%css "color: rgba(1, 2, 3, 50%)"],
      (CssJs.color(`rgba((1, 2, 3, `percent(0.5)))) : CssJs.rule)
    ),
    (
      [%css "color: hsl(120deg 100% 50%)"],
      (CssJs.color(`hsl((`deg(120.), `percent(100.), `percent(50.)))) : CssJs.rule)
    ),
    (
      [%css "opacity: 0.5"],
      (CssJs.opacity(0.5) : CssJs.rule)
    ),
    (
      [%css "opacity: 60%"],
      (CssJs.opacity(0.6) : CssJs.rule)
    ),
    // css-images-4
    (
      [%css "object-fit: fill"],
      (CssJs.objectFit(`fill) : CssJs.rule)
    ),
    (
      [%css "object-position: right bottom"],
      (CssJs.objectPosition(`hv((`right, `bottom))) : CssJs.rule)
    ),
    // css-backgrounds-3
    (
      [%css "background-color: red"],
      (CssJs.backgroundColor(CssJs.red) : CssJs.rule)
    ),
    (
      [%css "border-top-color: blue"],
      (CssJs.borderTopColor(CssJs.blue) : CssJs.rule)
    ),
    (
      [%css "border-right-color: green"],
      (CssJs.borderRightColor(CssJs.green) : CssJs.rule)
    ),
    (
      [%css "border-left-color: #fff"],
      (CssJs.borderLeftColor(`hex({js|fff|js})) : CssJs.rule)
    ),
    (
      [%css "border-top-width: 15px"],
      (CssJs.borderTopWidth(`pxFloat(15.)) : CssJs.rule)
    ),
    (
      [%css "border-right-width: 16px"],
      (CssJs.borderRightWidth(`pxFloat(16.)) : CssJs.rule)
    ),
    (
      [%css "border-bottom-width: 17px"],
      (CssJs.borderBottomWidth(`pxFloat(17.)) : CssJs.rule)
    ),
    (
      [%css "border-left-width: 18px"],
      (CssJs.borderLeftWidth(`pxFloat(18.)) : CssJs.rule)
    ),
    (
      [%css "border-top-left-radius: 12%"],
      (CssJs.borderTopLeftRadius(`percent(12.)) : CssJs.rule)
    ),
    (
      [%css "border-top-right-radius: 15%"],
      (CssJs.borderTopRightRadius(`percent(15.)) : CssJs.rule)
    ),
    (
      [%css "border-bottom-left-radius: 14%"],
      (CssJs.borderBottomLeftRadius(`percent(14.)) : CssJs.rule)
    ),
    (
      [%css "border-bottom-right-radius: 13%"],
      (CssJs.borderBottomRightRadius(`percent(13.)) : CssJs.rule)
    ),
    // css-overflow-3
    (
      [%css "overflow-x: auto"],
      (CssJs.overflowX(`auto) : CssJs.rule)
    ),
    (
      [%css "overflow-y: hidden"],
      (CssJs.overflowY(`hidden) : CssJs.rule)
    ),
    (
      [%css "overflow: scroll"],
      (CssJs.overflow(`scroll) : CssJs.rule)
    ),
    /* (
      [%css "overflow: scroll visible"],
      CssJs.overflowX(`scroll), CssJs.overflowY(`visible),
    ), */
    /* (
      [%css "text-overflow: clip"],
      CssJs.textOverflow(`clip)
    ), */
    /* (
      [%css "text-overflow: ellipsis"],
      CssJs.textOverflow(`ellipsis)
    ), */
    // css-text-3
    (
      [%css "text-transform: capitalize"],
      (CssJs.textTransform(`capitalize) : CssJs.rule)
    ),
    (
      [%css "white-space: break-spaces"],
      (CssJs.whiteSpace(`breakSpaces) : CssJs.rule)
    ),
    (
      [%css "word-break: keep-all"],
      (CssJs.wordBreak(`keepAll) : CssJs.rule)
    ),
    (
      [%css "overflow-wrap: anywhere"],
      (CssJs.overflowWrap(`anywhere) : CssJs.rule)
    ),
    (
      [%css "word-wrap: normal"],
      (CssJs.wordWrap(`normal) : CssJs.rule)
    ),
    /*
      not supported by bs-css
      (
      [%css "text-align: start"],
      CssJs.textAlign(`start)
    ), */
    (
      [%css "text-align: left"],
      (CssJs.textAlign(`left) : CssJs.rule)
    ),
    (
      [%css "word-spacing: normal"],
      (CssJs.wordSpacing(`normal) : CssJs.rule)
    ),
    (
      [%css "word-spacing: 5px"],
      (CssJs.wordSpacing(`pxFloat(5.)) : CssJs.rule)
    ),
    (
      [%css "letter-spacing: normal"],
      (CssJs.letterSpacing(`normal) : CssJs.rule)
    ),
    (
      [%css "letter-spacing: 5px"],
      (CssJs.letterSpacing(`pxFloat(5.)) : CssJs.rule)
    ),
    (
      [%css "text-indent: 5%"],
      (CssJs.textIndent(`percent(5.)) : CssJs.rule)
    ),
    // css-flexbox-1
    (
      [%css "flex-wrap: wrap"],
      (CssJs.flexWrap(`wrap) : CssJs.rule)
    ),
    /*
      not supported on bs-css
      (
      [%css "flex-flow: row nowrap"],
      [|CssJs.flexDirection(`row), CssJs.flexWrap(`nowrap)|],
    ), */
    (
      [%css "order: 5"],
      (CssJs.order(5) : CssJs.rule)
    ),
    (
      [%css "flex-grow: 2"],
      (CssJs.flexGrow(2.) : CssJs.rule)
    ),
    (
      [%css "flex-grow: 2.5"],
      (CssJs.flexGrow(2.5) : CssJs.rule)
    ),
    (
      [%css "flex-shrink: 2"],
      (CssJs.flexShrink(2.) : CssJs.rule)
    ),
    (
      [%css "flex-shrink: 2.5"],
      (CssJs.flexShrink(2.5) : CssJs.rule)
    ),
    (
      [%css "flex-basis: content"],
      (CssJs.flexBasis(`content) : CssJs.rule)
    ),
    (
      [%css "flex: none"],
      (CssJs.flex(`none) : CssJs.rule)
    ),
    (
      [%css "width: calc(100% + 32px)"],
      (CssJs.width(`calc(`add, `percent(100.), `pxFloat(32.))) : CssJs.rule)
    ),
    (
      [%css "width: calc(100vh - 120px)"],
      (CssJs.width(`calc(`sub, `vh(100.), `pxFloat(120.))) : CssJs.rule)
    ),
    /* Mult isn't available in bs-css */
    /* (
      [%css "width: calc(100px * 3)"],
      CssJs.width(`calc(`mult, `px(100.), `number(3.)))
    ), */
    /* (
      [%css "flex: 1 2 content"],
      CssJs.flexGrow(1.), CssJs.flexShrink(2.), CssJs.flexBasis(`content)|],
    ), */
    // unsupported
    /* (
      [%css "overflow-x: clip"],
      CssJs.unsafe("overflowX", "clip")),
    */
    /* (
      [%css "align-items: center"],
      CssJs.alignItems(`center)
    ), */
    /* (
      [%css "align-self: stretch"],
      CssJs.alignSelf(`stretch)
    ), */
     /* (
       [%css "align-content: space-around"],
       CssJs.alignContent(`spaceAround),
     ), */
     /* (
       [%css "justify-content: center"],
       CssJs.unsafe("justifyContent", "center"),
     ), */
    /* (
      [%css "-moz-text-blink: blink"],
      CssJs.unsafe("MozTextBlink", "blink")],
    ),
    (
      [%css "display: -webkit-inline-box"],
      CssJs.unsafe("display", "-webkit-inline-box")],
    ), */
  |]
];

describe("Transform [%css] to bs-css", ({test, _}) => {
  let test = (prefix, index, (input, expected)) =>
    test(prefix ++ string_of_int(index), compare(input, expected));

  let properties_static_css_tests =
    extract_tests(properties_static_css_tests);

  /* We write the tests to files so the Typecheker runs on them and ensures it's a valid with bs-css interfaces */
   write_tests_to_file(properties_static_css_tests, "static_css_tests.ml");

  List.iteri(test("properties static: "), properties_static_css_tests);
});
