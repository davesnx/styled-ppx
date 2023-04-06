open Alcotest;
open Ppxlib;
open Css;

let loc = Location.none;

/* The tests that are commented, means that we don't support them safely */
let properties_static_css_tests = [
  (
    [%css "display: block;"],
    [%expr [%css "display: block;"]],
    CssJs.display(`block),
    [%expr CssJs.display(`block)],
  ),
  (
    [%css "box-sizing: border-box"],
    [%expr [%css "box-sizing: border-box"]],
    CssJs.boxSizing(`borderBox),
    [%expr CssJs.boxSizing(`borderBox)],
  ),
  (
    [%css "box-sizing: content-box"],
    [%expr [%css "box-sizing: content-box"]],
    CssJs.boxSizing(`contentBox),
    [%expr CssJs.boxSizing(`contentBox)],
  ),
  (
    [%css "color: #454545"],
    [%expr [%css "color: #454545"]],
    CssJs.color(`hex({js|454545|js})),
    [%expr CssJs.color(`hex({js|454545|js}))],
  ),
  (
    [%css "color: red"],
    [%expr [%css "color: red"]],
    CssJs.color(CssJs.red),
    [%expr CssJs.color(CssJs.red)],
  ),
  (
    [%css "display: flex"],
    [%expr [%css "display: flex"]],
    CssJs.display(`flex),
    [%expr CssJs.display(`flex)],
  ),
  (
    [%css "flex-direction: column"],
    [%expr [%css "flex-direction: column"]],
    CssJs.flexDirection(`column),
    [%expr CssJs.flexDirection(`column)],
  ),
  (
    [%css "font-size: 30px"],
    [%expr [%css "font-size: 30px"]],
    CssJs.fontSize(`pxFloat(30.)),
    [%expr CssJs.fontSize(`pxFloat(30.))],
  ),
  (
    [%css "height: 100vh"],
    [%expr [%css "height: 100vh"]],
    CssJs.height(`vh(100.)),
    [%expr CssJs.height(`vh(100.))],
  ),
  (
    [%css "margin: 0"],
    [%expr [%css "margin: 0"]],
    CssJs.margin(`zero),
    [%expr CssJs.margin(`zero)],
  ),
  (
    [%css "margin: 5px"],
    [%expr [%css "margin: 5px"]],
    CssJs.margin(`pxFloat(5.)),
    [%expr CssJs.margin(`pxFloat(5.))],
  ),
  (
    [%css "opacity: 0.9"],
    [%expr [%css "opacity: 0.9"]],
    CssJs.opacity(0.9),
    [%expr CssJs.opacity(0.9)],
  ),
  (
    [%css "width: 100vw"],
    [%expr [%css "width: 100vw"]],
    CssJs.width(`vw(100.)),
    [%expr CssJs.width(`vw(100.))],
  ),
  // css-sizing-3
  (
    [%css "width: auto"],
    [%expr [%css "width: auto"]],
    CssJs.width(`auto),
    [%expr CssJs.width(`auto)],
  ),
  (
    [%css "width: 0"],
    [%expr [%css "width: 0"]],
    CssJs.width(`zero),
    [%expr CssJs.width(`zero)],
  ),
  (
    [%css "height: 5px"],
    [%expr [%css "height: 5px"]],
    CssJs.height(`pxFloat(5.)),
    [%expr CssJs.height(`pxFloat(5.))],
  ),
  (
    [%css "min-width: 5%"],
    [%expr [%css "min-width: 5%"]],
    CssJs.minWidth(`percent(5.)),
    [%expr CssJs.minWidth(`percent(5.))],
  ),
  (
    [%css "min-height: 5em"],
    [%expr [%css "min-height: 5em"]],
    CssJs.minHeight(`em(5.)),
    [%expr CssJs.minHeight(`em(5.))],
  ),
  (
    [%css "max-width: 3em"],
    [%expr [%css "max-width: 3em"]],
    CssJs.maxWidth(`em(3.)),
    [%expr CssJs.maxWidth(`em(3.))],
  ),
  (
    [%css "max-height: 3vh"],
    [%expr [%css "max-height: 3vh"]],
    CssJs.maxHeight(`vh(3.)),
    [%expr CssJs.maxHeight(`vh(3.))],
  ),
  (
    [%css "box-sizing: border-box"],
    [%expr [%css "box-sizing: border-box"]],
    CssJs.boxSizing(`borderBox),
    [%expr CssJs.boxSizing(`borderBox)],
  ),
  // css-box-3
  (
    [%css "margin-top: auto"],
    [%expr [%css "margin-top: auto"]],
    CssJs.marginTop(`auto),
    [%expr CssJs.marginTop(`auto)],
  ),
  (
    [%css "margin-right: 1px"],
    [%expr [%css "margin-right: 1px"]],
    CssJs.marginRight(`pxFloat(1.)),
    [%expr CssJs.marginRight(`pxFloat(1.))],
  ),
  (
    [%css "margin-bottom: 2px"],
    [%expr [%css "margin-bottom: 2px"]],
    CssJs.marginBottom(`pxFloat(2.)),
    [%expr CssJs.marginBottom(`pxFloat(2.))],
  ),
  (
    [%css "margin-left: 3px"],
    [%expr [%css "margin-left: 3px"]],
    CssJs.marginLeft(`pxFloat(3.)),
    [%expr CssJs.marginLeft(`pxFloat(3.))],
  ),
  (
    [%css "margin: 1px"],
    [%expr [%css "margin: 1px"]],
    CssJs.margin(`pxFloat(1.)),
    [%expr CssJs.margin(`pxFloat(1.))],
  ),
  (
    [%css "margin: 1px 2px"],
    [%expr [%css "margin: 1px 2px"]],
    CssJs.margin2(~v=`pxFloat(1.), ~h=`pxFloat(2.)),
    [%expr CssJs.margin2(~v=`pxFloat(1.), ~h=`pxFloat(2.))],
  ),
  (
    [%css "margin: 1px 2px 3px"],
    [%expr [%css "margin: 1px 2px 3px"]],
    CssJs.margin3(
      ~top=`pxFloat(1.),
      ~h=`pxFloat(2.),
      ~bottom=`pxFloat(3.),
    ),
    [%expr
      CssJs.margin3(
        ~top=`pxFloat(1.),
        ~h=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
      )
    ],
  ),
  (
    [%css "margin: 1px 2px 3px 4px"],
    [%expr [%css "margin: 1px 2px 3px 4px"]],
    CssJs.margin4(
      ~top=`pxFloat(1.),
      ~right=`pxFloat(2.),
      ~bottom=`pxFloat(3.),
      ~left=`pxFloat(4.),
    ),
    [%expr
      CssJs.margin4(
        ~top=`pxFloat(1.),
        ~right=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
        ~left=`pxFloat(4.),
      )
    ],
  ),
  (
    [%css "padding-top: 0"],
    [%expr [%css "padding-top: 0"]],
    CssJs.paddingTop(`zero),
    [%expr CssJs.paddingTop(`zero)],
  ),
  (
    [%css "padding-right: 1px"],
    [%expr [%css "padding-right: 1px"]],
    CssJs.paddingRight(`pxFloat(1.)),
    [%expr CssJs.paddingRight(`pxFloat(1.))],
  ),
  (
    [%css "padding-bottom: 2px"],
    [%expr [%css "padding-bottom: 2px"]],
    CssJs.paddingBottom(`pxFloat(2.)),
    [%expr CssJs.paddingBottom(`pxFloat(2.))],
  ),
  (
    [%css "padding-left: 3px"],
    [%expr [%css "padding-left: 3px"]],
    CssJs.paddingLeft(`pxFloat(3.)),
    [%expr CssJs.paddingLeft(`pxFloat(3.))],
  ),
  (
    [%css "padding: 1px"],
    [%expr [%css "padding: 1px"]],
    CssJs.padding(`pxFloat(1.)),
    [%expr CssJs.padding(`pxFloat(1.))],
  ),
  (
    [%css "padding: 1px 2px"],
    [%expr [%css "padding: 1px 2px"]],
    CssJs.padding2(~v=`pxFloat(1.), ~h=`pxFloat(2.)),
    [%expr CssJs.padding2(~v=`pxFloat(1.), ~h=`pxFloat(2.))],
  ),
  (
    [%css "padding: 1px 2px 3px"],
    [%expr [%css "padding: 1px 2px 3px"]],
    CssJs.padding3(
      ~top=`pxFloat(1.),
      ~h=`pxFloat(2.),
      ~bottom=`pxFloat(3.),
    ),
    [%expr
      CssJs.padding3(
        ~top=`pxFloat(1.),
        ~h=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
      )
    ],
  ),
  (
    [%css "padding: 1px 2px 3px 4px"],
    [%expr [%css "padding: 1px 2px 3px 4px"]],
    CssJs.padding4(
      ~top=`pxFloat(1.),
      ~right=`pxFloat(2.),
      ~bottom=`pxFloat(3.),
      ~left=`pxFloat(4.),
    ),
    [%expr
      CssJs.padding4(
        ~top=`pxFloat(1.),
        ~right=`pxFloat(2.),
        ~bottom=`pxFloat(3.),
        ~left=`pxFloat(4.),
      )
    ],
  ),
  (
    [%css "color: #012"],
    [%expr [%css "color: #012"]],
    CssJs.color(`hex({js|012|js})),
    [%expr CssJs.color(`hex({js|012|js}))],
  ),
  (
    [%css "color: #0123"],
    [%expr [%css "color: #0123"]],
    CssJs.color(`hex({js|0123|js})),
    [%expr CssJs.color(`hex({js|0123|js}))],
  ),
  (
    [%css "color: #012345"],
    [%expr [%css "color: #012345"]],
    CssJs.color(`hex({js|012345|js})),
    [%expr CssJs.color(`hex({js|012345|js}))],
  ),
  (
    [%css "color: #01234567"],
    [%expr [%css "color: #01234567"]],
    CssJs.color(`hex({js|01234567|js})),
    [%expr CssJs.color(`hex({js|01234567|js}))],
  ),
  (
    [%css "color: blue"],
    [%expr [%css "color: blue"]],
    CssJs.color(CssJs.blue),
    [%expr CssJs.color(CssJs.blue)],
  ),
  (
    [%css "color: currentColor"],
    [%expr [%css "color: currentColor"]],
    CssJs.color(`currentColor),
    [%expr CssJs.color(`currentColor)],
  ),
  (
    [%css "color: transparent"],
    [%expr [%css "color: transparent"]],
    CssJs.color(`transparent),
    [%expr CssJs.color(`transparent)],
  ),
  (
    [%css "color: rgb(1 2 3)"],
    [%expr [%css "color: rgb(1 2 3)"]],
    CssJs.color(`rgb((1, 2, 3))),
    [%expr CssJs.color(`rgb((1, 2, 3)))],
  ),
  (
    [%css "color: rgb(1 2 3 / .4)"],
    [%expr [%css "color: rgb(1 2 3 / .4)"]],
    CssJs.color(`rgba((1, 2, 3, `num(0.4)))),
    [%expr CssJs.color(`rgba((1, 2, 3, `num(0.4))))],
  ),
  (
    [%css "color: rgba(1, 2, 3)"],
    [%expr [%css "color: rgba(1, 2, 3)"]],
    CssJs.color(`rgb((1, 2, 3))),
    [%expr CssJs.color(`rgb((1, 2, 3)))],
  ),
  (
    [%css "color: rgba(1, 2, 3, .4)"],
    [%expr [%css "color: rgba(1, 2, 3, .4)"]],
    CssJs.color(`rgba((1, 2, 3, `num(0.4)))),
    [%expr CssJs.color(`rgba((1, 2, 3, `num(0.4))))],
  ),
  (
    [%css "color: rgba(1, 2, 3, 50%)"],
    [%expr [%css "color: rgba(1, 2, 3, 50%)"]],
    CssJs.color(`rgba((1, 2, 3, `percent(0.5)))),
    [%expr CssJs.color(`rgba((1, 2, 3, `percent(0.5))))],
  ),
  (
    [%css "color: hsl(120deg 100% 50%)"],
    [%expr [%css "color: hsl(120deg 100% 50%)"]],
    CssJs.color(`hsl((`deg(120.), `percent(100.), `percent(50.)))),
    [%expr
      CssJs.color(`hsl((`deg(120.), `percent(100.), `percent(50.))))
    ],
  ),
  (
    [%css "opacity: 0.5"],
    [%expr [%css "opacity: 0.5"]],
    CssJs.opacity(0.5),
    [%expr CssJs.opacity(0.5)],
  ),
  (
    [%css "opacity: 60%"],
    [%expr [%css "opacity: 60%"]],
    CssJs.opacity(0.6),
    [%expr CssJs.opacity(0.6)],
  ),
  // css-images-4
  (
    [%css "object-fit: fill"],
    [%expr [%css "object-fit: fill"]],
    CssJs.objectFit(`fill),
    [%expr CssJs.objectFit(`fill)],
  ),
  (
    [%css "object-position: right bottom"],
    [%expr [%css "object-position: right bottom"]],
    CssJs.objectPosition(`hv((`right, `bottom))),
    [%expr CssJs.objectPosition(`hv((`right, `bottom)))],
  ),
  (
    [%css "background-color: red"],
    [%expr [%css "background-color: red"]],
    CssJs.backgroundColor(CssJs.red),
    [%expr CssJs.backgroundColor(CssJs.red)],
  ),
  (
    [%css "border-top-color: blue"],
    [%expr [%css "border-top-color: blue"]],
    CssJs.borderTopColor(CssJs.blue),
    [%expr CssJs.borderTopColor(CssJs.blue)],
  ),
  (
    [%css "border-right-color: green"],
    [%expr [%css "border-right-color: green"]],
    CssJs.borderRightColor(CssJs.green),
    [%expr CssJs.borderRightColor(CssJs.green)],
  ),
  (
    [%css "border-left-color: #fff"],
    [%expr [%css "border-left-color: #fff"]],
    CssJs.borderLeftColor(`hex({js|fff|js})),
    [%expr CssJs.borderLeftColor(`hex({js|fff|js}))],
  ),
  (
    [%css "border-top-width: 15px"],
    [%expr [%css "border-top-width: 15px"]],
    CssJs.borderTopWidth(`pxFloat(15.)),
    [%expr CssJs.borderTopWidth(`pxFloat(15.))],
  ),
  (
    [%css "border-right-width: 16px"],
    [%expr [%css "border-right-width: 16px"]],
    CssJs.borderRightWidth(`pxFloat(16.)),
    [%expr CssJs.borderRightWidth(`pxFloat(16.))],
  ),
  (
    [%css "border-bottom-width: 17px"],
    [%expr [%css "border-bottom-width: 17px"]],
    CssJs.borderBottomWidth(`pxFloat(17.)),
    [%expr CssJs.borderBottomWidth(`pxFloat(17.))],
  ),
  (
    [%css "border-left-width: 18px"],
    [%expr [%css "border-left-width: 18px"]],
    CssJs.borderLeftWidth(`pxFloat(18.)),
    [%expr CssJs.borderLeftWidth(`pxFloat(18.))],
  ),
  (
    [%css "border-top-left-radius: 12%"],
    [%expr [%css "border-top-left-radius: 12%"]],
    CssJs.borderTopLeftRadius(`percent(12.)),
    [%expr CssJs.borderTopLeftRadius(`percent(12.))],
  ),
  (
    [%css "border-top-right-radius: 15%"],
    [%expr [%css "border-top-right-radius: 15%"]],
    CssJs.borderTopRightRadius(`percent(15.)),
    [%expr CssJs.borderTopRightRadius(`percent(15.))],
  ),
  (
    [%css "border-bottom-left-radius: 14%"],
    [%expr [%css "border-bottom-left-radius: 14%"]],
    CssJs.borderBottomLeftRadius(`percent(14.)),
    [%expr CssJs.borderBottomLeftRadius(`percent(14.))],
  ),
  (
    [%css "border-bottom-right-radius: 13%"],
    [%expr [%css "border-bottom-right-radius: 13%"]],
    CssJs.borderBottomRightRadius(`percent(13.)),
    [%expr CssJs.borderBottomRightRadius(`percent(13.))],
  ),
  (
    [%css "overflow-x: auto"],
    [%expr [%css "overflow-x: auto"]],
    CssJs.overflowX(`auto),
    [%expr CssJs.overflowX(`auto)],
  ),
  (
    [%css "overflow-y: hidden"],
    [%expr [%css "overflow-y: hidden"]],
    CssJs.overflowY(`hidden),
    [%expr CssJs.overflowY(`hidden)],
  ),
  (
    [%css "overflow: scroll"],
    [%expr [%css "overflow: scroll"]],
    CssJs.overflow(`scroll),
    [%expr CssJs.overflow(`scroll)],
  ),
  /* (
       [%css "overflow: scroll visible"],
       [%expr [%css "overflow: scroll visible"]],
       CssJs.overflowX(`scroll), CssJs.overflowY(`visible),
       [%expr CssJs.overflowX(`scroll), CssJs.overflowY(`visible)],
     ), */
  /* (
       [%css "text-overflow: clip"],
       [%expr [%css "text-overflow: clip"]],
       CssJs.textOverflow(`clip),
       [%expr CssJs.textOverflow(`clip)],
     ), */
  /* (
       [%css "text-overflow: ellipsis"],
       [%expr [%css "text-overflow: ellipsis"]],
       CssJs.textOverflow(`ellipsis),
       [%expr CssJs.textOverflow(`ellipsis)],
     ), */
  (
    [%css "text-transform: capitalize"],
    [%expr [%css "text-transform: capitalize"]],
    CssJs.textTransform(`capitalize),
    [%expr CssJs.textTransform(`capitalize)],
  ),
  (
    [%css "white-space: break-spaces"],
    [%expr [%css "white-space: break-spaces"]],
    CssJs.whiteSpace(`breakSpaces),
    [%expr CssJs.whiteSpace(`breakSpaces)],
  ),
  (
    [%css "word-break: keep-all"],
    [%expr [%css "word-break: keep-all"]],
    CssJs.wordBreak(`keepAll),
    [%expr CssJs.wordBreak(`keepAll)],
  ),
  (
    [%css "overflow-wrap: anywhere"],
    [%expr [%css "overflow-wrap: anywhere"]],
    CssJs.overflowWrap(`anywhere),
    [%expr CssJs.overflowWrap(`anywhere)],
  ),
  (
    [%css "word-wrap: normal"],
    [%expr [%css "word-wrap: normal"]],
    CssJs.wordWrap(`normal),
    [%expr CssJs.wordWrap(`normal)],
  ),
  (
    [%css "text-align: start"],
    [%expr [%css "text-align: start"]],
    CssJs.textAlign(`start),
    [%expr CssJs.textAlign(`start)],
  ),
  (
    [%css "text-align: left"],
    [%expr [%css "text-align: left"]],
    CssJs.textAlign(`left),
    [%expr CssJs.textAlign(`left)],
  ),
  (
    [%css "word-spacing: normal"],
    [%expr [%css "word-spacing: normal"]],
    CssJs.wordSpacing(`normal),
    [%expr CssJs.wordSpacing(`normal)],
  ),
  (
    [%css "word-spacing: 5px"],
    [%expr [%css "word-spacing: 5px"]],
    CssJs.wordSpacing(`pxFloat(5.)),
    [%expr CssJs.wordSpacing(`pxFloat(5.))],
  ),
  (
    [%css "letter-spacing: normal"],
    [%expr [%css "letter-spacing: normal"]],
    CssJs.letterSpacing(`normal),
    [%expr CssJs.letterSpacing(`normal)],
  ),
  (
    [%css "letter-spacing: 5px"],
    [%expr [%css "letter-spacing: 5px"]],
    CssJs.letterSpacing(`pxFloat(5.)),
    [%expr CssJs.letterSpacing(`pxFloat(5.))],
  ),
  (
    [%css "text-indent: 5%"],
    [%expr [%css "text-indent: 5%"]],
    CssJs.textIndent(`percent(5.)),
    [%expr CssJs.textIndent(`percent(5.))],
  ),
  (
    [%css "flex-wrap: wrap"],
    [%expr [%css "flex-wrap: wrap"]],
    CssJs.flexWrap(`wrap),
    [%expr CssJs.flexWrap(`wrap)],
  ),
  /*
     not supported on bs-css
     (
     [%css "flex-flow: row nowrap"],
     [%expr [%css "flex-flow: row nowrap"]],
     [|CssJs.flexDirection(`row), CssJs.flexWrap(`nowrap)|],
   ), */
  (
    [%css "order: 5"],
    [%expr [%css "order: 5"]],
    CssJs.order(5),
    [%expr CssJs.order(5)],
  ),
  (
    [%css "flex-grow: 2"],
    [%expr [%css "flex-grow: 2"]],
    CssJs.flexGrow(2.),
    [%expr CssJs.flexGrow(2.)],
  ),
  (
    [%css "flex-grow: 2.5"],
    [%expr [%css "flex-grow: 2.5"]],
    CssJs.flexGrow(2.5),
    [%expr CssJs.flexGrow(2.5)],
  ),
  (
    [%css "flex-shrink: 2"],
    [%expr [%css "flex-shrink: 2"]],
    CssJs.flexShrink(2.),
    [%expr CssJs.flexShrink(2.)],
  ),
  (
    [%css "flex-shrink: 2.5"],
    [%expr [%css "flex-shrink: 2.5"]],
    CssJs.flexShrink(2.5),
    [%expr CssJs.flexShrink(2.5)],
  ),
  (
    [%css "flex-basis: content"],
    [%expr [%css "flex-basis: content"]],
    CssJs.flexBasis(`content),
    [%expr CssJs.flexBasis(`content)],
  ),
  (
    [%css "flex: none"],
    [%expr [%css "flex: none"]],
    CssJs.flex(`none),
    [%expr CssJs.flex(`none)],
  ),
  /* bs-css doesn't support it */
  /* (
       [%css "width: calc(100px)"],
       [%expr [%css "width: calc(100px)"]],
       CssJs.width(`calc(`pxFloat(100.))),
       [%expr CssJs.width(`calc(`pxFloat(100.)))],
     ), */
  (
    [%css "width: calc(100% + 32px)"],
    [%expr [%css "width: calc(100% + 32px)"]],
    CssJs.width(`calc((`add, `percent(100.), `pxFloat(32.)))),
    [%expr CssJs.width(`calc((`add, `percent(100.), `pxFloat(32.))))],
  ),
  (
    [%css "width: calc(100vh - 120px)"],
    [%expr [%css "width: calc(100vh - 120px)"]],
    CssJs.width(`calc((`sub, `vh(100.), `pxFloat(120.)))),
    [%expr CssJs.width(`calc((`sub, `vh(100.), `pxFloat(120.))))],
  ),
  (
    [%css "color: var(--main-c)"],
    [%expr [%css "color: var(--main-c)"]],
    CssJs.color(`var({js|--main-c|js})),
    [%expr CssJs.color(`var({js|--main-c|js}))],
  ),
  /* (
       [%css "color: var(--main-c, #fff)"],
       [%expr [%css "color: var(--main-c, #fff)"]],
       CssJs.color(`var({js|--main-c|js}, `hex({js|fff|js}))),
       [%expr CssJs.color(`var({js|--main-c|js}, `hex({js|fff|js})))]
     ), */
  (
    [%css "background-image: url('img_tree.gif')"],
    [%expr [%css "background-image: url('img_tree.gif')"]],
    CssJs.backgroundImage(`url({js|img_tree.gif|js})),
    [%expr CssJs.backgroundImage(`url({js|img_tree.gif|js}))],
  ),
  /* Mult isn't available in bs-css */
  /* (
       [%css "width: calc(100px * 3)"],
       [%expr [%css "width: calc(100px * 3)"]],
       CssJs.width(`calc(`mult, `px(100.), `number(3.))),
       [%expr CssJs.width(`calc(`mult, `px(100.), `number(3.)))]
     ), */
  /* (
       [%css "flex: 1 2 content"],
       [%expr [%css "flex: 1 2 content"]],
       CssJs.flexGrow(1.), CssJs.flexShrink(2.), CssJs.flexBasis(`content)|],,
       [%expr CssJs.flexGrow(1.), CssJs.flexShrink(2.), CssJs.flexBasis(`content)|],],
     ), */
  // unsupported
  /* (
       [%css "align-items: center"],
       [%expr [%css "align-items: center"]],
       CssJs.alignItems(`center),
       [%expr CssJs.alignItems(`center)],
     ), */
  /* (
       [%css "align-self: stretch"],
       [%expr [%css "align-self: stretch"]],
       CssJs.alignSelf(`stretch),
       [%expr CssJs.alignSelf(`stretch)],
     ), */
  /* (
       [%css "align-content: space-around"],
       [%expr [%css "align-content: space-around"]],
       CssJs.alignContent(`spaceAround),
       [%expr CssJs.alignContent(`spaceAround)],
     ), */
  /* (
       [%css "justify-content: center"],
       [%expr [%css "justify-content: center"]],
       CssJs.unsafe("justifyContent", "center"),
       [%expr CssJs.unsafe("justifyContent", "center")],
     ), */
  /* (
       [%css "-moz-text-blink: blink"],
       [%expr [%css "-moz-text-blink: blink"]],
       CssJs.unsafe("MozTextBlink", "blink"),
       [%expr CssJs.unsafe("MozTextBlink", "blink")],
     ), */
  /* (
       [%css "display: -webkit-inline-box"],
       [%expr [%css "display: -webkit-inline-box"]],
       CssJs.unsafe("display", "-webkit-inline-box"),
       [%expr CssJs.unsafe("display", "-webkit-inline-box")],
     ), */
];

let runner = tests =>
  List.map(
    item => {
      let (_input: CssJs.Rule.t, input, _expected: CssJs.Rule.t, expected) = item;
      test_case(
        Pprintast.string_of_expression(input),
        `Quick,
        () => {
          let pp_expr = (ppf, x) =>
            Fmt.pf(ppf, "%S", Pprintast.string_of_expression(x));
          let check_expr = testable(pp_expr, (==));
          check(check_expr, "", input, expected);
        },
      );
    },
    tests,
  );

let tests = runner(properties_static_css_tests);
