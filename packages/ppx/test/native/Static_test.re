open Alcotest;
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

let openMockBsCss = [[%stri open MockBsCss]];
let ignoreWarning33 = [[%stri [@warning "-33"]]];
let mapExpected = ((expected, _)) => [%stri let _ = [%e expected]];

let write_tests_to_file = (
  tests: list((expression, expression)),
  file
) => {
  let code =
    tests
    |> List.map(mapExpected)
    |> List.append(openMockBsCss)
    |> List.append(ignoreWarning33)
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
      CssJs.display(`block)
    ),
    (
      [%css "box-sizing: border-box"],
      CssJs.boxSizing(`borderBox)
    ),
    (
      [%css "box-sizing: content-box"],
      CssJs.boxSizing(`contentBox)
    ),
    (
      [%css "color: #454545"],
      CssJs.color(`hex({js|454545|js}))
    ),
    (
      [%css "color: red"],
      CssJs.color(CssJs.red)
    ),
    (
      [%css "display: flex"],
      CssJs.display(`flex)
    ),
    (
      [%css "flex-direction: column"],
      CssJs.flexDirection(`column)
    ),
    (
      [%css "font-size: 30px"],
      CssJs.fontSize(`pxFloat(30.))
    ),
    (
      [%css "height: 100vh"],
      CssJs.height(`vh(100.))
    ),
    (
      [%css "margin: 0"],
      CssJs.margin(`zero)
    ),
    (
      [%css "margin: 5px"],
      CssJs.margin(`pxFloat(5.))
    ),
    (
      [%css "opacity: 0.9"],
      CssJs.opacity(0.9)
    ),
    (
      [%css "width: 100vw"],
      CssJs.width(`vw(100.))
    ),
    // css-sizing-3
    (
      [%css "width: auto"],
      CssJs.width(`auto)
    ),
    (
      [%css "width: 0"],
      CssJs.width(`zero)
    ),
    (
      [%css "height: 5px"],
      CssJs.height(`pxFloat(5.))
    ),
    (
      [%css "min-width: 5%"],
      CssJs.minWidth(`percent(5.))
    ),
    (
      [%css "min-height: 5em"],
      CssJs.minHeight(`em(5.))
    ),
    (
      [%css "max-width: 3em"],
      CssJs.maxWidth(`em(3.))
    ),
    (
      [%css "max-height: 3vh"],
      CssJs.maxHeight(`vh(3.))
    ),
    (
      [%css "box-sizing: border-box"],
      CssJs.boxSizing(`borderBox)
    ),
    // css-box-3
    (
      [%css "margin-top: auto"],
      CssJs.marginTop(`auto)
    ),
    (
      [%css "margin-right: 1px"],
      CssJs.marginRight(`pxFloat(1.))
    ),
    (
      [%css "margin-bottom: 2px"],
      CssJs.marginBottom(`pxFloat(2.))
    ),
    (
      [%css "margin-left: 3px"],
      CssJs.marginLeft(`pxFloat(3.))
    ),
    (
      [%css "margin: 1px"],
      CssJs.margin(`pxFloat(1.))
    ),
    (
      [%css "margin: 1px 2px"],
      CssJs.margin2(~v=`pxFloat(1.), ~h=`pxFloat(2.)),
    ),
    (
      [%css "margin: 1px 2px 3px"],
      CssJs.margin3(
        ~top=`pxFloat(1.),
        ~h=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
      ),
    ),
    (
      [%css "margin: 1px 2px 3px 4px"],
      CssJs.margin4(
        ~top=`pxFloat(1.),
        ~right=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
        ~left=`pxFloat(4.),
      ),
    ),
    (
      [%css "padding-top: 0"],
      CssJs.paddingTop(`zero)
    ),
    (
      [%css "padding-right: 1px"],
      CssJs.paddingRight(`pxFloat(1.))
    ),
    (
      [%css "padding-bottom: 2px"],
      CssJs.paddingBottom(`pxFloat(2.))
    ),
    (
      [%css "padding-left: 3px"],
      CssJs.paddingLeft(`pxFloat(3.))
    ),
    (
      [%css "padding: 1px"],
      CssJs.padding(`pxFloat(1.))
    ),
    (
      [%css "padding: 1px 2px"],
      CssJs.padding2(~v=`pxFloat(1.), ~h=`pxFloat(2.)),
    ),
    (
      [%css "padding: 1px 2px 3px"],
      CssJs.padding3(
        ~top=`pxFloat(1.),
        ~h=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
      ),
    ),
    (
      [%css "padding: 1px 2px 3px 4px"],
      CssJs.padding4(
        ~top=`pxFloat(1.),
        ~right=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
        ~left=`pxFloat(4.),
      ),
    ),
    (
      [%css "color: #012"],
      CssJs.color(`hex({js|012|js}))),

    (
      [%css "color: #0123"],
      CssJs.color(`hex({js|0123|js}))),

    (
      [%css "color: #012345"],
      CssJs.color(`hex({js|012345|js}))
    ),
    (
      [%css "color: #01234567"],
      CssJs.color(`hex({js|01234567|js}))
    ),
    (
      [%css "color: blue"],
      CssJs.color(CssJs.blue)
    ),
    (
      [%css "color: currentColor"],
      CssJs.color(`currentColor)
    ),
    (
      [%css "color: transparent"],
      CssJs.color(`transparent)
    ),
    (
      [%css "color: rgb(1 2 3)"],
      CssJs.color(`rgb((1, 2, 3)))
    ),
    (
      [%css "color: rgb(1 2 3 / .4)"],
      CssJs.color(`rgba((1, 2, 3, `num (0.4))))
    ),
    (
      [%css "color: rgba(1, 2, 3)"],
      CssJs.color(`rgb((1, 2, 3)))
    ),
    (
      [%css "color: rgba(1, 2, 3, .4)"],
      CssJs.color(`rgba((1, 2, 3, `num(0.4)))),
    ),
    (
      [%css "color: rgba(1, 2, 3, 50%)"],
      CssJs.color(`rgba((1, 2, 3, `percent(0.5)))),
    ),
    (
      [%css "color: hsl(120deg 100% 50%)"],
      CssJs.color(`hsl((`deg(120.), `percent(100.), `percent(50.)))),
    ),
    (
      [%css "opacity: 0.5"],
      CssJs.opacity(0.5)
    ),
    (
      [%css "opacity: 60%"],
      CssJs.opacity(0.6)
    ),
    // css-images-4
    (
      [%css "object-fit: fill"],
      CssJs.objectFit(`fill)
    ),
    (
      [%css "object-position: right bottom"],
      CssJs.objectPosition(`hv((`right, `bottom))),
    ),
    (
      [%css "background-color: red"],
      CssJs.backgroundColor(CssJs.red)
    ),
    (
      [%css "border-top-color: blue"],
      CssJs.borderTopColor(CssJs.blue)
    ),
    (
      [%css "border-right-color: green"],
      CssJs.borderRightColor(CssJs.green)
    ),
    (
      [%css "border-left-color: #fff"],
      CssJs.borderLeftColor(`hex({js|fff|js}))),

    (
      [%css "border-top-width: 15px"],
      CssJs.borderTopWidth(`pxFloat(15.))
    ),
    (
      [%css "border-right-width: 16px"],
      CssJs.borderRightWidth(`pxFloat(16.)),
    ),
    (
      [%css "border-bottom-width: 17px"],
      CssJs.borderBottomWidth(`pxFloat(17.)),
    ),
    (
      [%css "border-left-width: 18px"],
      CssJs.borderLeftWidth(`pxFloat(18.)),
    ),
    (
      [%css "border-top-left-radius: 12%"],
      CssJs.borderTopLeftRadius(`percent(12.)),
    ),
    (
      [%css "border-top-right-radius: 15%"],
      CssJs.borderTopRightRadius(`percent(15.)),
    ),
    (
      [%css "border-bottom-left-radius: 14%"],
      CssJs.borderBottomLeftRadius(`percent(14.)),
    ),
    (
      [%css "border-bottom-right-radius: 13%"],
      CssJs.borderBottomRightRadius(`percent(13.)),
    ),
    (
      [%css "overflow-x: auto"],
      CssJs.overflowX(`auto)
    ),
    (
      [%css "overflow-y: hidden"],
      CssJs.overflowY(`hidden)
    ),
    (
      [%css "overflow: scroll"],
      CssJs.overflow(`scroll)
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
    (
      [%css "text-transform: capitalize"],
      CssJs.textTransform(`capitalize)
    ),
    (
      [%css "white-space: break-spaces"],
      CssJs.whiteSpace(`breakSpaces)
    ),
    (
      [%css "word-break: keep-all"],
      CssJs.wordBreak(`keepAll)
    ),
    (
      [%css "overflow-wrap: anywhere"],
      CssJs.overflowWrap(`anywhere)
    ),
    (
      [%css "word-wrap: normal"],
      CssJs.wordWrap(`normal)
    ),
    (
      [%css "text-align: start"],
      CssJs.textAlign(`start)
    ),
    (
      [%css "text-align: left"],
      CssJs.textAlign(`left)
    ),
    (
      [%css "word-spacing: normal"],
      CssJs.wordSpacing(`normal)
    ),
    (
      [%css "word-spacing: 5px"],
      CssJs.wordSpacing(`pxFloat(5.))
    ),
    (
      [%css "letter-spacing: normal"],
      CssJs.letterSpacing(`normal)
    ),
    (
      [%css "letter-spacing: 5px"],
      CssJs.letterSpacing(`pxFloat(5.))
    ),
    (
      [%css "text-indent: 5%"],
      CssJs.textIndent(`percent(5.))
    ),
    (
      [%css "flex-wrap: wrap"],
      CssJs.flexWrap(`wrap)
    ),
    /*
      not supported on bs-css
      (
      [%css "flex-flow: row nowrap"],
      [|CssJs.flexDirection(`row), CssJs.flexWrap(`nowrap)|],
    ), */
    (
      [%css "order: 5"],
      CssJs.order(5)
    ),
    (
      [%css "flex-grow: 2"],
      CssJs.flexGrow(2.)
    ),
    (
      [%css "flex-grow: 2.5"],
      CssJs.flexGrow(2.5)
    ),
    (
      [%css "flex-shrink: 2"],
      CssJs.flexShrink(2.)
    ),
    (
      [%css "flex-shrink: 2.5"],
      CssJs.flexShrink(2.5)
    ),
    (
      [%css "flex-basis: content"],
      CssJs.flexBasis(`content)
    ),
    (
      [%css "flex: none"],
      CssJs.flex(`none)
    ),
    /* bs-css doesn't support it */
    /* (
      [%css "width: calc(100px)"],
      CssJs.width(`calc(`add, `percent(100.), `pxFloat(32.)))
    ), */
    (
      [%css "width: calc(100% + 32px)"],
      CssJs.width(`calc(`add, `percent(100.), `pxFloat(32.)))
    ),
    (
      [%css "width: calc(100vh - 120px)"],
      CssJs.width(`calc(`sub, `vh(100.), `pxFloat(120.)))
    ),
    (
      [%css "color: var(--main-c)"],
      CssJs.color(`var({js|--main-c|js}))
    ),
    /* (
      [%css "color: var(--main-c, #fff)"],
      CssJs.color(`var({js|--main-c|js}, `hex({js|fff|js})))
    ), */
    (
      [%css "background-image: url('img_tree.gif')"],
      CssJs.backgroundImage(`url({js|img_tree.gif|js}))
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
      CssJs.unsafe("MozTextBlink", "blink"),
    ), */
    /* (
      [%css "display: -webkit-inline-box"],
      CssJs.unsafe("display", "-webkit-inline-box"),
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
