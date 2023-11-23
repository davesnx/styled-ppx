open Alcotest;
open Ppxlib;

let loc = Location.none;

let label: CssJs.rule = CssJs.label("asdf");
let block: CssJs.rule = CssJs.display(`block);
let c = CssJs.style([|block, label|]);

/* The tests that are commented, means that we don't support them safely */
let properties_static_css_tests = [
  (
    [%css "display: block;"],
    [%expr [%css "display: block;"]],
    [%expr CssJs.display(`block)],
  ),
  (
    [%css "box-sizing: border-box"],
    [%expr [%css "box-sizing: border-box"]],
    [%expr CssJs.boxSizing(`borderBox)],
  ),
  (
    [%css "box-sizing: content-box"],
    [%expr [%css "box-sizing: content-box"]],
    [%expr CssJs.boxSizing(`contentBox)],
  ),
  (
    [%css "color: #454545"],
    [%expr [%css "color: #454545"]],
    [%expr CssJs.color(`hex({js|454545|js}))],
  ),
  (
    [%css "color: red"],
    [%expr [%css "color: red"]],
    [%expr CssJs.color(CssJs.red)],
  ),
  (
    [%css "display: flex"],
    [%expr [%css "display: flex"]],
    [%expr CssJs.display(`flex)],
  ),
  (
    [%css "flex-direction: column"],
    [%expr [%css "flex-direction: column"]],
    [%expr CssJs.flexDirection(`column)],
  ),
  (
    [%css "font-size: 30px"],
    [%expr [%css "font-size: 30px"]],
    [%expr CssJs.fontSize(`pxFloat(30.))],
  ),
  (
    [%css "height: 100vh"],
    [%expr [%css "height: 100vh"]],
    [%expr CssJs.height(`vh(100.))],
  ),
  (
    [%css "margin: 0"],
    [%expr [%css "margin: 0"]],
    [%expr CssJs.margin(`zero)],
  ),
  (
    [%css "margin: 5px"],
    [%expr [%css "margin: 5px"]],
    [%expr CssJs.margin(`pxFloat(5.))],
  ),
  (
    [%css "opacity: 0.9"],
    [%expr [%css "opacity: 0.9"]],
    [%expr CssJs.opacity(0.9)],
  ),
  (
    [%css "width: 100vw"],
    [%expr [%css "width: 100vw"]],
    [%expr CssJs.width(`vw(100.))],
  ),
  // css-sizing-3
  (
    [%css "width: auto"],
    [%expr [%css "width: auto"]],
    [%expr CssJs.width(`auto)],
  ),
  ([%css "width: 0"], [%expr [%css "width: 0"]], [%expr CssJs.width(`zero)]),
  (
    [%css "height: 5px"],
    [%expr [%css "height: 5px"]],
    [%expr CssJs.height(`pxFloat(5.))],
  ),
  (
    [%css "min-width: 5%"],
    [%expr [%css "min-width: 5%"]],
    [%expr CssJs.minWidth(`percent(5.))],
  ),
  (
    [%css "min-height: 5em"],
    [%expr [%css "min-height: 5em"]],
    [%expr CssJs.minHeight(`em(5.))],
  ),
  (
    [%css "max-width: 3em"],
    [%expr [%css "max-width: 3em"]],
    [%expr CssJs.maxWidth(`em(3.))],
  ),
  (
    [%css "max-height: 3vh"],
    [%expr [%css "max-height: 3vh"]],
    [%expr CssJs.maxHeight(`vh(3.))],
  ),
  (
    [%css "box-sizing: border-box"],
    [%expr [%css "box-sizing: border-box"]],
    [%expr CssJs.boxSizing(`borderBox)],
  ),
  // css-box-3
  (
    [%css "margin-top: auto"],
    [%expr [%css "margin-top: auto"]],
    [%expr CssJs.marginTop(`auto)],
  ),
  (
    [%css "margin-right: 1px"],
    [%expr [%css "margin-right: 1px"]],
    [%expr CssJs.marginRight(`pxFloat(1.))],
  ),
  (
    [%css "margin-bottom: 2px"],
    [%expr [%css "margin-bottom: 2px"]],
    [%expr CssJs.marginBottom(`pxFloat(2.))],
  ),
  (
    [%css "margin-left: 3px"],
    [%expr [%css "margin-left: 3px"]],
    [%expr CssJs.marginLeft(`pxFloat(3.))],
  ),
  (
    [%css "margin: 1px"],
    [%expr [%css "margin: 1px"]],
    [%expr CssJs.margin(`pxFloat(1.))],
  ),
  (
    [%css "margin: 1px 2px"],
    [%expr [%css "margin: 1px 2px"]],
    [%expr CssJs.margin2(~v=`pxFloat(1.), ~h=`pxFloat(2.))],
  ),
  (
    [%css "margin: 1px 2px 3px"],
    [%expr [%css "margin: 1px 2px 3px"]],
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
    [%expr CssJs.paddingTop(`zero)],
  ),
  (
    [%css "padding-right: 1px"],
    [%expr [%css "padding-right: 1px"]],
    [%expr CssJs.paddingRight(`pxFloat(1.))],
  ),
  (
    [%css "padding-bottom: 2px"],
    [%expr [%css "padding-bottom: 2px"]],
    [%expr CssJs.paddingBottom(`pxFloat(2.))],
  ),
  (
    [%css "padding-left: 3px"],
    [%expr [%css "padding-left: 3px"]],
    [%expr CssJs.paddingLeft(`pxFloat(3.))],
  ),
  (
    [%css "padding: 1px"],
    [%expr [%css "padding: 1px"]],
    [%expr CssJs.padding(`pxFloat(1.))],
  ),
  (
    [%css "padding: 1px 2px"],
    [%expr [%css "padding: 1px 2px"]],
    [%expr CssJs.padding2(~v=`pxFloat(1.), ~h=`pxFloat(2.))],
  ),
  (
    [%css "padding: 1px 2px 3px"],
    [%expr [%css "padding: 1px 2px 3px"]],
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
    [%expr CssJs.color(`hex({js|012|js}))],
  ),
  (
    [%css "color: #0123"],
    [%expr [%css "color: #0123"]],
    [%expr CssJs.color(`hex({js|0123|js}))],
  ),
  (
    [%css "color: #012345"],
    [%expr [%css "color: #012345"]],
    [%expr CssJs.color(`hex({js|012345|js}))],
  ),
  (
    [%css "color: #01234567"],
    [%expr [%css "color: #01234567"]],
    [%expr CssJs.color(`hex({js|01234567|js}))],
  ),
  (
    [%css "color: blue"],
    [%expr [%css "color: blue"]],
    [%expr CssJs.color(CssJs.blue)],
  ),
  (
    [%css "color: currentColor"],
    [%expr [%css "color: currentColor"]],
    [%expr CssJs.color(`currentColor)],
  ),
  (
    [%css "color: transparent"],
    [%expr [%css "color: transparent"]],
    [%expr CssJs.color(`transparent)],
  ),
  (
    [%css "color: rgb(1 2 3)"],
    [%expr [%css "color: rgb(1 2 3)"]],
    [%expr CssJs.color(`rgb((1, 2, 3)))],
  ),
  (
    [%css "color: rgb(1 2 3 / .4)"],
    [%expr [%css "color: rgb(1 2 3 / .4)"]],
    [%expr CssJs.color(`rgba((1, 2, 3, `num(0.4))))],
  ),
  (
    [%css "color: rgba(1, 2, 3)"],
    [%expr [%css "color: rgba(1, 2, 3)"]],
    [%expr CssJs.color(`rgb((1, 2, 3)))],
  ),
  (
    [%css "color: rgba(1, 2, 3, .4)"],
    [%expr [%css "color: rgba(1, 2, 3, .4)"]],
    [%expr CssJs.color(`rgba((1, 2, 3, `num(0.4))))],
  ),
  (
    [%css "color: rgba(1, 2, 3, 50%)"],
    [%expr [%css "color: rgba(1, 2, 3, 50%)"]],
    [%expr CssJs.color(`rgba((1, 2, 3, `percent(0.5))))],
  ),
  (
    [%css "color: hsl(120deg 100% 50%)"],
    [%expr [%css "color: hsl(120deg 100% 50%)"]],
    [%expr
      CssJs.color(`hsl((`deg(120.), `percent(100.), `percent(50.))))
    ],
  ),
  (
    [%css "opacity: 0.5"],
    [%expr [%css "opacity: 0.5"]],
    [%expr CssJs.opacity(0.5)],
  ),
  (
    [%css "opacity: 60%"],
    [%expr [%css "opacity: 60%"]],
    [%expr CssJs.opacity(0.6)],
  ),
  // css-images-4
  (
    [%css "object-fit: fill"],
    [%expr [%css "object-fit: fill"]],
    [%expr CssJs.objectFit(`fill)],
  ),
  (
    [%css "object-position: right bottom"],
    [%expr [%css "object-position: right bottom"]],
    [%expr CssJs.objectPosition(`hv((`right, `bottom)))],
  ),
  (
    [%css "background-color: red"],
    [%expr [%css "background-color: red"]],
    [%expr CssJs.backgroundColor(CssJs.red)],
  ),
  (
    [%css "border-top-color: blue"],
    [%expr [%css "border-top-color: blue"]],
    [%expr CssJs.borderTopColor(CssJs.blue)],
  ),
  (
    [%css "border-right-color: green"],
    [%expr [%css "border-right-color: green"]],
    [%expr CssJs.borderRightColor(CssJs.green)],
  ),
  (
    [%css "border-left-color: #fff"],
    [%expr [%css "border-left-color: #fff"]],
    [%expr CssJs.borderLeftColor(`hex({js|fff|js}))],
  ),
  (
    [%css "border-top-width: 15px"],
    [%expr [%css "border-top-width: 15px"]],
    [%expr CssJs.borderTopWidth(`pxFloat(15.))],
  ),
  (
    [%css "border-right-width: 16px"],
    [%expr [%css "border-right-width: 16px"]],
    [%expr CssJs.borderRightWidth(`pxFloat(16.))],
  ),
  (
    [%css "border-bottom-width: 17px"],
    [%expr [%css "border-bottom-width: 17px"]],
    [%expr CssJs.borderBottomWidth(`pxFloat(17.))],
  ),
  (
    [%css "border-left-width: 18px"],
    [%expr [%css "border-left-width: 18px"]],
    [%expr CssJs.borderLeftWidth(`pxFloat(18.))],
  ),
  (
    [%css "border-top-left-radius: 12%"],
    [%expr [%css "border-top-left-radius: 12%"]],
    [%expr CssJs.borderTopLeftRadius(`percent(12.))],
  ),
  (
    [%css "border-top-right-radius: 15%"],
    [%expr [%css "border-top-right-radius: 15%"]],
    [%expr CssJs.borderTopRightRadius(`percent(15.))],
  ),
  (
    [%css "border-bottom-left-radius: 14%"],
    [%expr [%css "border-bottom-left-radius: 14%"]],
    [%expr CssJs.borderBottomLeftRadius(`percent(14.))],
  ),
  (
    [%css "border-bottom-right-radius: 13%"],
    [%expr [%css "border-bottom-right-radius: 13%"]],
    [%expr CssJs.borderBottomRightRadius(`percent(13.))],
  ),
  (
    [%css "overflow-x: auto"],
    [%expr [%css "overflow-x: auto"]],
    [%expr CssJs.overflowX(`auto)],
  ),
  (
    [%css "overflow-y: hidden"],
    [%expr [%css "overflow-y: hidden"]],
    [%expr CssJs.overflowY(`hidden)],
  ),
  (
    [%css "overflow: scroll"],
    [%expr [%css "overflow: scroll"]],
    [%expr CssJs.overflow(`scroll)],
  ),
  /* (
       [%css "overflow: scroll visible"],
       [%expr [%css "overflow: scroll visible"]],
       [%expr CssJs.overflowX(`scroll), CssJs.overflowY(`visible)],
     ), */
  /* (
       [%css "text-overflow: clip"],
       [%expr [%css "text-overflow: clip"]],
       [%expr CssJs.textOverflow(`clip)],
     ), */
  /* (
       [%css "text-overflow: ellipsis"],
       [%expr [%css "text-overflow: ellipsis"]],
       [%expr CssJs.textOverflow(`ellipsis)],
     ), */
  (
    [%css "text-transform: capitalize"],
    [%expr [%css "text-transform: capitalize"]],
    [%expr CssJs.textTransform(`capitalize)],
  ),
  (
    [%css "white-space: break-spaces"],
    [%expr [%css "white-space: break-spaces"]],
    [%expr CssJs.whiteSpace(`breakSpaces)],
  ),
  (
    [%css "word-break: keep-all"],
    [%expr [%css "word-break: keep-all"]],
    [%expr CssJs.wordBreak(`keepAll)],
  ),
  (
    [%css "overflow-wrap: anywhere"],
    [%expr [%css "overflow-wrap: anywhere"]],
    [%expr CssJs.overflowWrap(`anywhere)],
  ),
  (
    [%css "word-wrap: normal"],
    [%expr [%css "word-wrap: normal"]],
    [%expr CssJs.wordWrap(`normal)],
  ),
  (
    [%css "text-align: start"],
    [%expr [%css "text-align: start"]],
    [%expr CssJs.textAlign(`start)],
  ),
  (
    [%css "text-align: left"],
    [%expr [%css "text-align: left"]],
    [%expr CssJs.textAlign(`left)],
  ),
  (
    [%css "text-align: end"],
    [%expr [%css "text-align: end"]],
    [%expr CssJs.textAlign(`end_)],
  ),
  (
    [%css "text-align: match-parent"],
    [%expr [%css "text-align: match-parent"]],
    [%expr CssJs.textAlign(`matchParent)],
  ),
  (
    [%css "text-align: justify-all"],
    [%expr [%css "text-align: justify-all"]],
    [%expr CssJs.textAlign(`justifyAll)],
  ),
  (
    [%css "text-align-all: start"],
    [%expr [%css "text-align-all: start"]],
    [%expr CssJs.textAlignAll(`start)],
  ),
  (
    [%css "text-align-all: left"],
    [%expr [%css "text-align-all: left"]],
    [%expr CssJs.textAlignAll(`left)],
  ),
  (
    [%css "text-align-all: end"],
    [%expr [%css "text-align-all: end"]],
    [%expr CssJs.textAlignAll(`end_)],
  ),
  (
    [%css "text-align-all: match-parent"],
    [%expr [%css "text-align-all: match-parent"]],
    [%expr CssJs.textAlignAll(`matchParent)],
  ),
  (
    [%css "text-align-last: center"],
    [%expr [%css "text-align-last: center"]],
    [%expr CssJs.textAlignLast(`center)],
  ),
  (
    [%css "text-align-last: match-parent"],
    [%expr [%css "text-align-last: match-parent"]],
    [%expr CssJs.textAlignLast(`matchParent)],
  ),
  (
    [%css "word-spacing: normal"],
    [%expr [%css "word-spacing: normal"]],
    [%expr CssJs.wordSpacing(`normal)],
  ),
  (
    [%css "word-spacing: 5px"],
    [%expr [%css "word-spacing: 5px"]],
    [%expr CssJs.wordSpacing(`pxFloat(5.))],
  ),
  (
    [%css "letter-spacing: normal"],
    [%expr [%css "letter-spacing: normal"]],
    [%expr CssJs.letterSpacing(`normal)],
  ),
  (
    [%css "letter-spacing: 5px"],
    [%expr [%css "letter-spacing: 5px"]],
    [%expr CssJs.letterSpacing(`pxFloat(5.))],
  ),
  (
    [%css "text-indent: 5%"],
    [%expr [%css "text-indent: 5%"]],
    [%expr CssJs.textIndent(`percent(5.))],
  ),
  (
    [%css "flex-wrap: wrap"],
    [%expr [%css "flex-wrap: wrap"]],
    [%expr CssJs.flexWrap(`wrap)],
  ),
  /*
     not supported on bs-css
     (
     [%css "flex-flow: row nowrap"],
     [%expr [%css "flex-flow: row nowrap"]],
     [|CssJs.flexDirection(`row), CssJs.flexWrap(`nowrap)|],
   ), */
  ([%css "order: 5"], [%expr [%css "order: 5"]], [%expr CssJs.order(5)]),
  (
    [%css "flex-grow: 2"],
    [%expr [%css "flex-grow: 2"]],
    [%expr CssJs.flexGrow(2.)],
  ),
  (
    [%css "flex-grow: 2.5"],
    [%expr [%css "flex-grow: 2.5"]],
    [%expr CssJs.flexGrow(2.5)],
  ),
  (
    [%css "flex-shrink: 2"],
    [%expr [%css "flex-shrink: 2"]],
    [%expr CssJs.flexShrink(2.)],
  ),
  (
    [%css "flex-shrink: 2.5"],
    [%expr [%css "flex-shrink: 2.5"]],
    [%expr CssJs.flexShrink(2.5)],
  ),
  (
    [%css "flex-basis: content"],
    [%expr [%css "flex-basis: content"]],
    [%expr CssJs.flexBasis(`content)],
  ),
  (
    [%css "flex: none"],
    [%expr [%css "flex: none"]],
    [%expr CssJs.flex1(`none)],
  ),
  /* Since calc(x) -> x */
  (
    [%css "width: calc(100px)"],
    [%expr [%css "width: calc(100px)"]],
    [%expr CssJs.width(`pxFloat(100.))],
  ),
  (
    [%css "width: calc(100% + 32px)"],
    [%expr [%css "width: calc(100% + 32px)"]],
    [%expr CssJs.width(`calc(`add((`percent(100.), `pxFloat(32.)))))],
  ),
  (
    [%css "width: calc(100vh - 120px)"],
    [%expr [%css "width: calc(100vh - 120px)"]],
    [%expr CssJs.width(`calc(`sub((`vh(100.), `pxFloat(120.)))))],
  ),
  (
    [%css "color: var(--main-c)"],
    [%expr [%css "color: var(--main-c)"]],
    [%expr CssJs.color(`var({js|--main-c|js}))],
  ),
  (
    [%css "box-shadow: 12px 12px 2px 1px rgba(0, 0, 255, 0.2)"],
    [%expr [%css "box-shadow: 12px 12px 2px 1px rgba(0, 0, 255, 0.2)"]],
    [%expr
      CssJs.boxShadows([|
        CssJs.Shadow.box(
          ~x=`pxFloat(12.),
          ~y=`pxFloat(12.),
          ~blur=`pxFloat(2.),
          ~spread=`pxFloat(1.),
          `rgba((0, 0, 255, `num(0.2))),
        ),
      |])
    ],
  ),
  /* (
       [%css "color: var(--main-c, #fff)"],
       [%expr [%css "color: var(--main-c, #fff)"]],
       [%expr CssJs.color(`var({js|--main-c|js}, `hex({js|fff|js})))]
     ), */
  (
    [%css "background-image: url('img_tree.gif')"],
    [%expr [%css "background-image: url('img_tree.gif')"]],
    [%expr CssJs.backgroundImage(`url({js|img_tree.gif|js}))],
  ),
  (
    [%css "flex: 1 2 content"],
    [%expr [%css "flex: 1 2 content"]],
    [%expr CssJs.flex(1., 2., `content)],
  ),
  (
    [%css "align-items: center"],
    [%expr [%css "align-items: center"]],
    [%expr CssJs.alignItems(`center)],
  ),
  (
    [%css "align-self: stretch"],
    [%expr [%css "align-self: stretch"]],
    [%expr CssJs.alignSelf(`stretch)],
  ),
  (
    [%css "align-content: space-around"],
    [%expr [%css "align-content: space-around"]],
    [%expr CssJs.alignContent(`spaceAround)],
  ),
  (
    [%css "justify-content: center"],
    [%expr [%css "justify-content: center"]],
    [%expr CssJs.justifyContent(`center)],
  ),
  (
    [%css "text-emphasis-color: #555;"],
    [%expr [%css "text-emphasis-color: #555;"]],
    [%expr CssJs.textEmphasisColor(`hex({js|555|js}))],
  ),
  (
    [%css "text-emphasis-color: blue;"],
    [%expr [%css "text-emphasis-color: blue;"]],
    [%expr CssJs.textEmphasisColor(CssJs.blue)],
  ),
  (
    [%css "text-emphasis-color: rgba(90, 200, 160, 0.8);"],
    [%expr [%css "text-emphasis-color: rgba(90, 200, 160, 0.8);"]],
    [%expr CssJs.textEmphasisColor(`rgba((90, 200, 160, `num(0.8))))],
  ),
  (
    [%css "text-emphasis-color: transparent"],
    [%expr [%css "text-emphasis-color: transparent"]],
    [%expr CssJs.textEmphasisColor(`transparent)],
  ),
  (
    [%css "text-emphasis-style: 'foo'"],
    [%expr [%css "text-emphasis-style: 'foo'"]],
    [%expr CssJs.textEmphasisStyle(`string({js|foo|js}))],
  ),
  (
    [%css "text-emphasis-style: open"],
    [%expr [%css "text-emphasis-style: open"]],
    [%expr CssJs.textEmphasisStyle(`open_)],
  ),
  (
    [%css "text-emphasis-style: filled double-circle"],
    [%expr [%css "text-emphasis-style:  filled double-circle"]],
    [%expr
      CssJs.textEmphasisStyle(
        `textEmphasisStyleXY((`filled, `double_circle)),
      )
    ],
  ),
  (
    [%css "text-emphasis-style: sesame open"],
    [%expr [%css "text-emphasis-style:  sesame open"]],
    [%expr CssJs.textEmphasisStyle(`textEmphasisStyleXY((`open_, `sesame)))],
  ),
  (
    [%css "text-emphasis-position: over"],
    [%expr [%css "text-emphasis-position: over"]],
    [%expr CssJs.textEmphasisPosition(`over)],
  ),
  (
    [%css "text-emphasis-position: under"],
    [%expr [%css "text-emphasis-position: under"]],
    [%expr CssJs.textEmphasisPosition(`under)],
  ),
  (
    [%css "text-emphasis-position: over left"],
    [%expr [%css "text-emphasis-position: over left"]],
    [%expr
      CssJs.textEmphasisPosition(`textEmphasisPositionYX((`over, `left)))
    ],
  ),
  (
    [%css "text-emphasis-position: left over"],
    [%expr [%css "text-emphasis-position: left over"]],
    [%expr
      CssJs.textEmphasisPosition(`textEmphasisPositionYX((`over, `left)))
    ],
  ),
  (
    [%css "line-break: auto"],
    [%expr [%css "line-break: auto"]],
    [%expr CssJs.lineBreak(`auto)],
  ),
  (
    [%css "hyphens: none"],
    [%expr [%css "hyphens: none"]],
    [%expr CssJs.hyphens(`none)],
  ),
  (
    [%css "text-justify: none"],
    [%expr [%css "text-justify: none"]],
    [%expr CssJs.textJustify(`none)],
  ),
  (
    [%css "text-justify: inter-word"],
    [%expr [%css "text-justify: inter-word"]],
    [%expr CssJs.textJustify(`interWord)],
  ),
  (
    [%css "overflow-inline: visible"],
    [%expr [%css "overflow-inline: visible"]],
    [%expr CssJs.overflowInline(`visible)],
  ),
  // unsupported
  /* (
       [%css "-moz-text-blink: blink"],
       [%expr [%css "-moz-text-blink: blink"]],
       [%expr CssJs.unsafe("MozTextBlink", "blink")],
     ), */
  /* (
       [%css "display: -webkit-inline-box"],
       [%expr [%css "display: -webkit-inline-box"]],
       [%expr CssJs.unsafe("display", "-webkit-inline-box")],
     ), */
];

let runner = tests =>
  List.map(
    item => {
      let (_input, input, expected) = item;
      test_case(
        Pprintast.string_of_expression(input),
        `Quick,
        () => {
          let pp_expr = (ppf, x) =>
            Fmt.pf(ppf, "%S", Pprintast.string_of_expression(x));
          let check_expr = testable(pp_expr, (==));
          check(check_expr, "", expected, input);
        },
      );
    },
    tests,
  );

let tests = runner(properties_static_css_tests);
