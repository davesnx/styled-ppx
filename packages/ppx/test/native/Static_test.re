let loc = Ppxlib.Location.none;

let label: CSS.rule = CSS.label("asdf");
let block: CSS.rule = CSS.display(`block);
let c = CSS.style([|block, label|]);

/* The tests that are commented, means that we don't support them safely */
let properties_static_css_tests = [
  (
    [%css "display: block;"],
    [%expr [%css "display: block;"]],
    [%expr CSS.display(`block)],
  ),
  (
    [%css "box-sizing: border-box"],
    [%expr [%css "box-sizing: border-box"]],
    [%expr CSS.boxSizing(`borderBox)],
  ),
  (
    [%css "box-sizing: content-box"],
    [%expr [%css "box-sizing: content-box"]],
    [%expr CSS.boxSizing(`contentBox)],
  ),
  (
    [%css "color: #454545"],
    [%expr [%css "color: #454545"]],
    [%expr CSS.color(`hex({js|454545|js}))],
  ),
  (
    [%css "color: red"],
    [%expr [%css "color: red"]],
    [%expr CSS.color(CSS.red)],
  ),
  (
    [%css "display: flex"],
    [%expr [%css "display: flex"]],
    [%expr CSS.display(`flex)],
  ),
  (
    [%css "flex-direction: column"],
    [%expr [%css "flex-direction: column"]],
    [%expr CSS.flexDirection(`column)],
  ),
  (
    [%css "font-size: 30px"],
    [%expr [%css "font-size: 30px"]],
    [%expr CSS.fontSize(`pxFloat(30.))],
  ),
  (
    [%css "height: 100vh"],
    [%expr [%css "height: 100vh"]],
    [%expr CSS.height(`vh(100.))],
  ),
  (
    [%css "margin: 0"],
    [%expr [%css "margin: 0"]],
    [%expr CSS.margin(`zero)],
  ),
  (
    [%css "margin: 5px"],
    [%expr [%css "margin: 5px"]],
    [%expr CSS.margin(`pxFloat(5.))],
  ),
  (
    [%css "opacity: 0.9"],
    [%expr [%css "opacity: 0.9"]],
    [%expr CSS.opacity(0.9)],
  ),
  (
    [%css "width: 100vw"],
    [%expr [%css "width: 100vw"]],
    [%expr CSS.width(`vw(100.))],
  ),
  // css-sizing-3
  (
    [%css "width: auto"],
    [%expr [%css "width: auto"]],
    [%expr CSS.width(`auto)],
  ),
  ([%css "width: 0"], [%expr [%css "width: 0"]], [%expr CSS.width(`zero)]),
  (
    [%css "height: 5px"],
    [%expr [%css "height: 5px"]],
    [%expr CSS.height(`pxFloat(5.))],
  ),
  (
    [%css "min-width: 5%"],
    [%expr [%css "min-width: 5%"]],
    [%expr CSS.minWidth(`percent(5.))],
  ),
  (
    [%css "min-height: 5em"],
    [%expr [%css "min-height: 5em"]],
    [%expr CSS.minHeight(`em(5.))],
  ),
  (
    [%css "max-width: 3em"],
    [%expr [%css "max-width: 3em"]],
    [%expr CSS.maxWidth(`em(3.))],
  ),
  (
    [%css "max-height: 3vh"],
    [%expr [%css "max-height: 3vh"]],
    [%expr CSS.maxHeight(`vh(3.))],
  ),
  // css-box-3
  (
    [%css "margin-top: auto"],
    [%expr [%css "margin-top: auto"]],
    [%expr CSS.marginTop(`auto)],
  ),
  (
    [%css "margin-right: 1px"],
    [%expr [%css "margin-right: 1px"]],
    [%expr CSS.marginRight(`pxFloat(1.))],
  ),
  (
    [%css "margin-bottom: 2px"],
    [%expr [%css "margin-bottom: 2px"]],
    [%expr CSS.marginBottom(`pxFloat(2.))],
  ),
  (
    [%css "margin-left: 3px"],
    [%expr [%css "margin-left: 3px"]],
    [%expr CSS.marginLeft(`pxFloat(3.))],
  ),
  (
    [%css "margin: 1px"],
    [%expr [%css "margin: 1px"]],
    [%expr CSS.margin(`pxFloat(1.))],
  ),
  (
    [%css "margin: 1px 2px"],
    [%expr [%css "margin: 1px 2px"]],
    [%expr CSS.margin2(~v=`pxFloat(1.), ~h=`pxFloat(2.))],
  ),
  (
    [%css "margin: 1px 2px 3px"],
    [%expr [%css "margin: 1px 2px 3px"]],
    [%expr
      CSS.margin3(~top=`pxFloat(1.), ~h=`pxFloat(2.), ~bottom=`pxFloat(3.))
    ],
  ),
  (
    [%css "margin: 1px 2px 3px 4px"],
    [%expr [%css "margin: 1px 2px 3px 4px"]],
    [%expr
      CSS.margin4(
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
    [%expr CSS.paddingTop(`zero)],
  ),
  (
    [%css "padding-right: 1px"],
    [%expr [%css "padding-right: 1px"]],
    [%expr CSS.paddingRight(`pxFloat(1.))],
  ),
  (
    [%css "padding-right: min(1px, 2%)"],
    [%expr [%css "padding-right: min(1px, 2%)"]],
    [%expr CSS.paddingRight(`min([|`pxFloat(1.), `percent(2.)|]))],
  ),
  (
    [%css "padding-bottom: 2px"],
    [%expr [%css "padding-bottom: 2px"]],
    [%expr CSS.paddingBottom(`pxFloat(2.))],
  ),
  (
    [%css "padding-left: 3px"],
    [%expr [%css "padding-left: 3px"]],
    [%expr CSS.paddingLeft(`pxFloat(3.))],
  ),
  (
    [%css "padding: 1px"],
    [%expr [%css "padding: 1px"]],
    [%expr CSS.padding(`pxFloat(1.))],
  ),
  (
    [%css "padding: min(1px, 2%)"],
    [%expr [%css "padding: min(1px, 2%)"]],
    [%expr CSS.padding(`min([|`pxFloat(1.), `percent(2.)|]))],
  ),
  (
    [%css "padding: 1px 2px"],
    [%expr [%css "padding: 1px 2px"]],
    [%expr CSS.padding2(~v=`pxFloat(1.), ~h=`pxFloat(2.))],
  ),
  (
    [%css "padding: 1px 2px 3px"],
    [%expr [%css "padding: 1px 2px 3px"]],
    [%expr
      CSS.padding3(
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
      CSS.padding4(
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
    [%expr CSS.color(`hex({js|012|js}))],
  ),
  (
    [%css "color: #0123"],
    [%expr [%css "color: #0123"]],
    [%expr CSS.color(`hex({js|0123|js}))],
  ),
  (
    [%css "color: #012345"],
    [%expr [%css "color: #012345"]],
    [%expr CSS.color(`hex({js|012345|js}))],
  ),
  (
    [%css "color: #01234567"],
    [%expr [%css "color: #01234567"]],
    [%expr CSS.color(`hex({js|01234567|js}))],
  ),
  (
    [%css "color: blue"],
    [%expr [%css "color: blue"]],
    [%expr CSS.color(CSS.blue)],
  ),
  (
    [%css "color: currentColor"],
    [%expr [%css "color: currentColor"]],
    [%expr CSS.color(`currentColor)],
  ),
  (
    [%css "color: transparent"],
    [%expr [%css "color: transparent"]],
    [%expr CSS.color(`transparent)],
  ),
  (
    [%css "color: rgb(1 2 3)"],
    [%expr [%css "color: rgb(1 2 3)"]],
    [%expr CSS.color(`rgb((1, 2, 3)))],
  ),
  (
    [%css "color: rgb(1 2 3 / .5)"],
    [%expr [%css "color: rgb(1 2 3 / .5)"]],
    [%expr CSS.color(`rgba((1, 2, 3, `num(0.5))))],
  ),
  (
    [%css "color: rgba(0, 2, 3)"],
    [%expr [%css "color: rgba(0, 2, 3)"]],
    [%expr CSS.color(`rgb((0, 2, 3)))],
  ),
  (
    [%css "color: rgba(1, 2, 3, .4)"],
    [%expr [%css "color: rgba(1, 2, 3, .4)"]],
    [%expr CSS.color(`rgba((1, 2, 3, `num(0.4))))],
  ),
  (
    [%css "color: rgba(1, 2, 3, 50%)"],
    [%expr [%css "color: rgba(1, 2, 3, 50%)"]],
    [%expr CSS.color(`rgba((1, 2, 3, `percent(0.5))))],
  ),
  (
    [%css "color: rgba(1, 2, 3, calc(50% + 10%))"],
    [%expr [%css "color: rgba(1, 2, 3, calc(50% + 10%))"]],
    [%expr
      CSS.color(
        `rgba((1, 2, 3, `calc(`add((`percent(50.), `percent(10.)))))),
      )
    ],
  ),
  (
    [%css "color: rgba(1, 2, 3, min(50%, 10%))"],
    [%expr [%css "color: rgba(1, 2, 3, min(50%, 10%))"]],
    [%expr
      CSS.color(`rgba((1, 2, 3, `min([|`percent(50.), `percent(10.)|]))))
    ],
  ),
  (
    [%css "color: hsl(calc(120deg + 10deg) 100% 50%)"],
    [%expr [%css "color: hsl(calc(120deg + 10deg) 100% 50%)"]],
    [%expr
      CSS.color(
        `hsl((
          `calc(`add((`deg(120.), `deg(10.)))),
          `percent(100.),
          `percent(50.),
        )),
      )
    ],
  ),
  (
    [%css "color: hsl(min(120deg, 10deg) 100% 50%)"],
    [%expr [%css "color: hsl(min(120deg, 10deg) 100% 50%)"]],
    [%expr
      CSS.color(
        `hsl((
          `min([|`deg(120.), `deg(10.)|]),
          `percent(100.),
          `percent(50.),
        )),
      )
    ],
  ),
  (
    [%css "color: hsl(max(120deg) 100% 50%)"],
    [%expr [%css "color: hsl(max(120deg) 100% 50%)"]],
    [%expr
      CSS.color(
        `hsl((`max([|`deg(120.)|]), `percent(100.), `percent(50.))),
      )
    ],
  ),
  (
    [%css "color: hsl(120deg 100% 50%)"],
    [%expr [%css "color: hsl(120deg 100% 50%)"]],
    [%expr CSS.color(`hsl((`deg(120.), `percent(100.), `percent(50.))))],
  ),
  (
    [%css "color: hsl(120deg 100% calc(50% + 10%))"],
    [%expr [%css "color: hsl(120deg 100% calc(50% + 10%))"]],
    [%expr
      CSS.color(
        `hsl((
          `deg(120.),
          `percent(100.),
          `calc(`add((`percent(50.), `percent(10.)))),
        )),
      )
    ],
  ),
  (
    [%css "color: hsl(120deg calc(50% + 10%) max(50%, 10%))"],
    [%expr [%css "color: hsl(120deg calc(50% + 10%) max(50%, 10%))"]],
    [%expr
      CSS.color(
        `hsl((
          `deg(120.),
          `calc(`add((`percent(50.), `percent(10.)))),
          `max([|`percent(50.), `percent(10.)|]),
        )),
      )
    ],
  ),
  (
    [%css "opacity: 0.5"],
    [%expr [%css "opacity: 0.5"]],
    [%expr CSS.opacity(0.5)],
  ),
  (
    [%css "opacity: 60%"],
    [%expr [%css "opacity: 60%"]],
    [%expr CSS.opacity(0.6)],
  ),
  // css-images-4
  (
    [%css "object-fit: fill"],
    [%expr [%css "object-fit: fill"]],
    [%expr CSS.objectFit(`fill)],
  ),
  (
    [%css "background-color: red"],
    [%expr [%css "background-color: red"]],
    [%expr CSS.backgroundColor(CSS.red)],
  ),
  (
    [%css "background-color: color-mix(in srgb, white 10%, red)"],
    [%expr [%css "background-color: color-mix(in srgb, white 10%, red)"]],
    [%expr
      CSS.backgroundColor(
        `colorMix((
          `srgb,
          (CSS.white, Some(`percent(10.))),
          (CSS.red, None),
        )),
      )
    ],
  ),
  (
    [%css "background-color: color-mix(in srgb, white 10%, red 10%)"],
    [%expr [%css "background-color: color-mix(in srgb, white 10%, red 10%)"]],
    [%expr
      CSS.backgroundColor(
        `colorMix((
          `srgb,
          (CSS.white, Some(`percent(10.))),
          (CSS.red, Some(`percent(10.))),
        )),
      )
    ],
  ),
  (
    [%css "background-color: color-mix(in srgb, white, red)"],
    [%expr [%css "background-color: color-mix(in srgb, white, red)"]],
    [%expr
      CSS.backgroundColor(
        `colorMix((`srgb, (CSS.white, None), (CSS.red, None))),
      )
    ],
  ),
  (
    [%css "background-color: color-mix(in srgb, white, red 10%)"],
    [%expr [%css "background-color: color-mix(in srgb, white, red 10%)"]],
    [%expr
      CSS.backgroundColor(
        `colorMix((
          `srgb,
          (CSS.white, None),
          (CSS.red, Some(`percent(10.))),
        )),
      )
    ],
  ),
  (
    [%css "border-top-color: blue"],
    [%expr [%css "border-top-color: blue"]],
    [%expr CSS.borderTopColor(CSS.blue)],
  ),
  (
    [%css "border-right-color: green"],
    [%expr [%css "border-right-color: green"]],
    [%expr CSS.borderRightColor(CSS.green)],
  ),
  (
    [%css "border-left-color: #fff"],
    [%expr [%css "border-left-color: #fff"]],
    [%expr CSS.borderLeftColor(`hex({js|fff|js}))],
  ),
  (
    [%css "border-top-width: 15px"],
    [%expr [%css "border-top-width: 15px"]],
    [%expr CSS.borderTopWidth(`pxFloat(15.))],
  ),
  (
    [%css "border-right-width: 16px"],
    [%expr [%css "border-right-width: 16px"]],
    [%expr CSS.borderRightWidth(`pxFloat(16.))],
  ),
  (
    [%css "border-bottom-width: 17px"],
    [%expr [%css "border-bottom-width: 17px"]],
    [%expr CSS.borderBottomWidth(`pxFloat(17.))],
  ),
  (
    [%css "border-left-width: 18px"],
    [%expr [%css "border-left-width: 18px"]],
    [%expr CSS.borderLeftWidth(`pxFloat(18.))],
  ),
  (
    [%css "border-top-left-radius: 12%"],
    [%expr [%css "border-top-left-radius: 12%"]],
    [%expr CSS.borderTopLeftRadius(`percent(12.))],
  ),
  (
    [%css "border-top-right-radius: 15%"],
    [%expr [%css "border-top-right-radius: 15%"]],
    [%expr CSS.borderTopRightRadius(`percent(15.))],
  ),
  (
    [%css "border-bottom-left-radius: 14%"],
    [%expr [%css "border-bottom-left-radius: 14%"]],
    [%expr CSS.borderBottomLeftRadius(`percent(14.))],
  ),
  (
    [%css "border-bottom-right-radius: 13%"],
    [%expr [%css "border-bottom-right-radius: 13%"]],
    [%expr CSS.borderBottomRightRadius(`percent(13.))],
  ),
  (
    [%css "overflow-x: auto"],
    [%expr [%css "overflow-x: auto"]],
    [%expr CSS.overflowX(`auto)],
  ),
  (
    [%css "overflow-y: hidden"],
    [%expr [%css "overflow-y: hidden"]],
    [%expr CSS.overflowY(`hidden)],
  ),
  (
    [%css "overflow: scroll"],
    [%expr [%css "overflow: scroll"]],
    [%expr CSS.overflow(`scroll)],
  ),
  (
    [%css "overflow: scroll visible"],
    [%expr [%css "overflow: scroll visible"]],
    [%expr CSS.overflows([|`scroll, `visible|])],
  ),
  (
    [%css "text-overflow: clip"],
    [%expr [%css "text-overflow: clip"]],
    [%expr CSS.textOverflow(`clip)],
  ),
  (
    [%css "text-overflow: ellipsis"],
    [%expr [%css "text-overflow: ellipsis"]],
    [%expr CSS.textOverflow(`ellipsis)],
  ),
  (
    [%css "text-transform: capitalize"],
    [%expr [%css "text-transform: capitalize"]],
    [%expr CSS.textTransform(`capitalize)],
  ),
  (
    [%css "white-space: break-spaces"],
    [%expr [%css "white-space: break-spaces"]],
    [%expr CSS.whiteSpace(`breakSpaces)],
  ),
  (
    [%css "word-break: keep-all"],
    [%expr [%css "word-break: keep-all"]],
    [%expr CSS.wordBreak(`keepAll)],
  ),
  (
    [%css "overflow-wrap: anywhere"],
    [%expr [%css "overflow-wrap: anywhere"]],
    [%expr CSS.overflowWrap(`anywhere)],
  ),
  (
    [%css "word-wrap: normal"],
    [%expr [%css "word-wrap: normal"]],
    [%expr CSS.wordWrap(`normal)],
  ),
  (
    [%css "text-align: start"],
    [%expr [%css "text-align: start"]],
    [%expr CSS.textAlign(`start)],
  ),
  (
    [%css "text-align: left"],
    [%expr [%css "text-align: left"]],
    [%expr CSS.textAlign(`left)],
  ),
  (
    [%css "text-align: end"],
    [%expr [%css "text-align: end"]],
    [%expr CSS.textAlign(`end_)],
  ),
  (
    [%css "text-align: match-parent"],
    [%expr [%css "text-align: match-parent"]],
    [%expr CSS.textAlign(`matchParent)],
  ),
  (
    [%css "text-align: justify-all"],
    [%expr [%css "text-align: justify-all"]],
    [%expr CSS.textAlign(`justifyAll)],
  ),
  (
    [%css "text-align-all: start"],
    [%expr [%css "text-align-all: start"]],
    [%expr CSS.textAlignAll(`start)],
  ),
  (
    [%css "text-align-all: left"],
    [%expr [%css "text-align-all: left"]],
    [%expr CSS.textAlignAll(`left)],
  ),
  (
    [%css "text-align-all: end"],
    [%expr [%css "text-align-all: end"]],
    [%expr CSS.textAlignAll(`end_)],
  ),
  (
    [%css "text-align-all: match-parent"],
    [%expr [%css "text-align-all: match-parent"]],
    [%expr CSS.textAlignAll(`matchParent)],
  ),
  (
    [%css "text-align-last: center"],
    [%expr [%css "text-align-last: center"]],
    [%expr CSS.textAlignLast(`center)],
  ),
  (
    [%css "text-align-last: match-parent"],
    [%expr [%css "text-align-last: match-parent"]],
    [%expr CSS.textAlignLast(`matchParent)],
  ),
  (
    [%css "word-spacing: normal"],
    [%expr [%css "word-spacing: normal"]],
    [%expr CSS.wordSpacing(`normal)],
  ),
  (
    [%css "word-spacing: 5px"],
    [%expr [%css "word-spacing: 5px"]],
    [%expr CSS.wordSpacing(`pxFloat(5.))],
  ),
  (
    [%css "letter-spacing: normal"],
    [%expr [%css "letter-spacing: normal"]],
    [%expr CSS.letterSpacing(`normal)],
  ),
  (
    [%css "letter-spacing: 5px"],
    [%expr [%css "letter-spacing: 5px"]],
    [%expr CSS.letterSpacing(`pxFloat(5.))],
  ),
  (
    [%css "text-indent: 5%"],
    [%expr [%css "text-indent: 5%"]],
    [%expr CSS.textIndent(`percent(5.))],
  ),
  (
    [%css "flex-wrap: wrap"],
    [%expr [%css "flex-wrap: wrap"]],
    [%expr CSS.flexWrap(`wrap)],
  ),
  /*
     not supported on bs-css
     (
     [%css "flex-flow: row nowrap"],
     [%expr [%css "flex-flow: row nowrap"]],
     [|CSS.flexDirection(`row), CSS.flexWrap(`nowrap)|],
   ), */
  ([%css "order: 5"], [%expr [%css "order: 5"]], [%expr CSS.order(5)]),
  (
    [%css "flex-grow: 2"],
    [%expr [%css "flex-grow: 2"]],
    [%expr CSS.flexGrow(2.)],
  ),
  (
    [%css "flex-grow: 2.5"],
    [%expr [%css "flex-grow: 2.5"]],
    [%expr CSS.flexGrow(2.5)],
  ),
  (
    [%css "flex-shrink: 2"],
    [%expr [%css "flex-shrink: 2"]],
    [%expr CSS.flexShrink(2.)],
  ),
  (
    [%css "flex-shrink: 2.5"],
    [%expr [%css "flex-shrink: 2.5"]],
    [%expr CSS.flexShrink(2.5)],
  ),
  (
    [%css "flex-basis: content"],
    [%expr [%css "flex-basis: content"]],
    [%expr CSS.flexBasis(`content)],
  ),
  (
    [%css "flex: none"],
    [%expr [%css "flex: none"]],
    [%expr CSS.flex1(`none)],
  ),
  (
    [%css "width: calc(100px)"],
    [%expr [%css "width: calc(100px)"]],
    [%expr CSS.width(`calc(`pxFloat(100.)))],
  ),
  (
    [%css "width: calc(100% + 32px)"],
    [%expr [%css "width: calc(100% + 32px)"]],
    [%expr CSS.width(`calc(`add((`percent(100.), `pxFloat(32.)))))],
  ),
  (
    [%css "width: calc(100% + min(32px))"],
    [%expr [%css "width: calc(100% + min(32px))"]],
    [%expr
      CSS.width(`calc(`add((`percent(100.), `min([|`pxFloat(32.)|])))))
    ],
  ),
  (
    [%css "width: calc(100% + min(32px, 100%))"],
    [%expr [%css "width: calc(100% + min(32px, 100%))"]],
    [%expr
      CSS.width(
        `calc(
          `add((`percent(100.), `min([|`pxFloat(32.), `percent(100.)|]))),
        ),
      )
    ],
  ),
  (
    [%css "width: min(100%)"],
    [%expr [%css "width: min(100%)"]],
    [%expr CSS.width(`min([|`percent(100.)|]))],
  ),
  (
    [%css "width: min(100%, 30%)"],
    [%expr [%css "width: min(100%, 30%)"]],
    [%expr CSS.width(`min([|`percent(100.), `percent(30.)|]))],
  ),
  (
    [%css "width: min(100em, 30px)"],
    [%expr [%css "width: min(100em, 30px)"]],
    [%expr CSS.width(`min([|`em(100.), `pxFloat(30.)|]))],
  ),
  (
    [%css "width: min(100%, calc(100% + 32px))"],
    [%expr [%css "width: min(100%, calc(100% + 32px))"]],
    [%expr
      CSS.width(
        `min([|
          `percent(100.),
          `calc(`add((`percent(100.), `pxFloat(32.)))),
        |]),
      )
    ],
  ),
  (
    [%css "width: min(100em, 30px, 10%)"],
    [%expr [%css "width: min(100em, 30px, 10%)"]],
    [%expr CSS.width(`min([|`em(100.), `pxFloat(30.), `percent(10.)|]))],
  ),
  (
    [%css "width: calc(100% + max(32px))"],
    [%expr [%css "width: calc(100% + max(32px))"]],
    [%expr
      CSS.width(`calc(`add((`percent(100.), `max([|`pxFloat(32.)|])))))
    ],
  ),
  (
    [%css "width: calc(100% + max(32px, 100%))"],
    [%expr [%css "width: calc(100% + max(32px, 100%))"]],
    [%expr
      CSS.width(
        `calc(
          `add((`percent(100.), `max([|`pxFloat(32.), `percent(100.)|]))),
        ),
      )
    ],
  ),
  (
    [%css "width: max(100%)"],
    [%expr [%css "width: max(100%)"]],
    [%expr CSS.width(`max([|`percent(100.)|]))],
  ),
  (
    [%css "width: max(100%, 30%)"],
    [%expr [%css "width: max(100%, 30%)"]],
    [%expr CSS.width(`max([|`percent(100.), `percent(30.)|]))],
  ),
  (
    [%css "width: max(100em, 30px)"],
    [%expr [%css "width: max(100em, 30px)"]],
    [%expr CSS.width(`max([|`em(100.), `pxFloat(30.)|]))],
  ),
  (
    [%css "width: max(100%, calc(100% + 32px))"],
    [%expr [%css "width: max(100%, calc(100% + 32px))"]],
    [%expr
      CSS.width(
        `max([|
          `percent(100.),
          `calc(`add((`percent(100.), `pxFloat(32.)))),
        |]),
      )
    ],
  ),
  (
    [%css "width: max(100em, 30px, 10%)"],
    [%expr [%css "width: max(100em, 30px, 10%)"]],
    [%expr CSS.width(`max([|`em(100.), `pxFloat(30.), `percent(10.)|]))],
  ),
  (
    [%css "width: calc(100vh - 120px)"],
    [%expr [%css "width: calc(100vh - 120px)"]],
    [%expr CSS.width(`calc(`sub((`vh(100.), `pxFloat(120.)))))],
  ),
  (
    [%css "color: var(--main-c)"],
    [%expr [%css "color: var(--main-c)"]],
    [%expr CSS.color(`var({js|--main-c|js}))],
  ),
  (
    [%css "box-shadow: 12px 12px 2px 1px rgba(0, 0, 255, 0.2)"],
    [%expr [%css "box-shadow: 12px 12px 2px 1px rgba(0, 0, 255, 0.2)"]],
    [%expr
      CSS.boxShadows([|
        CSS.Shadow.box(
          ~x=`pxFloat(12.),
          ~y=`pxFloat(12.),
          ~blur=`pxFloat(2.),
          ~spread=`pxFloat(1.),
          `rgba((0, 0, 255, `num(0.2))),
        ),
      |])
    ],
  ),
  /*
   TODO: Variables don't support default argument on Parser.re (propertyp-arser)
   (
     [%css "color: var(--main-c, #fff)"],
     [%expr [%css "color: var(--main-c, #fff)"]],
     [%expr CSS.color(`var(({js|--main-c|js}, `hex({js|fff|js}))))],
   ), */
  (
    [%css "background-image: url('img_tree.gif')"],
    [%expr [%css "background-image: url('img_tree.gif')"]],
    [%expr CSS.backgroundImage(`url({js|img_tree.gif|js}))],
  ),
  (
    [%css "flex: 1 2 content"],
    [%expr [%css "flex: 1 2 content"]],
    [%expr CSS.flex(1., 2., `content)],
  ),
  (
    [%css "align-items: center"],
    [%expr [%css "align-items: center"]],
    [%expr CSS.alignItems(`center)],
  ),
  (
    [%css "align-self: stretch"],
    [%expr [%css "align-self: stretch"]],
    [%expr CSS.alignSelf(`stretch)],
  ),
  (
    [%css "align-content: space-around"],
    [%expr [%css "align-content: space-around"]],
    [%expr CSS.alignContent(`spaceAround)],
  ),
  (
    [%css "justify-content: center"],
    [%expr [%css "justify-content: center"]],
    [%expr CSS.justifyContent(`center)],
  ),
  (
    [%css "text-emphasis-color: #555;"],
    [%expr [%css "text-emphasis-color: #555;"]],
    [%expr CSS.textEmphasisColor(`hex({js|555|js}))],
  ),
  (
    [%css "text-emphasis-color: blue;"],
    [%expr [%css "text-emphasis-color: blue;"]],
    [%expr CSS.textEmphasisColor(CSS.blue)],
  ),
  (
    [%css "text-emphasis-color: rgba(90, 200, 160, 0.8);"],
    [%expr [%css "text-emphasis-color: rgba(90, 200, 160, 0.8);"]],
    [%expr CSS.textEmphasisColor(`rgba((90, 200, 160, `num(0.8))))],
  ),
  (
    [%css "text-emphasis-color: transparent"],
    [%expr [%css "text-emphasis-color: transparent"]],
    [%expr CSS.textEmphasisColor(`transparent)],
  ),
  (
    [%css "text-emphasis-style: 'foo'"],
    [%expr [%css "text-emphasis-style: 'foo'"]],
    [%expr CSS.textEmphasisStyle(`string({js|foo|js}))],
  ),
  (
    [%css "text-emphasis-style: open"],
    [%expr [%css "text-emphasis-style: open"]],
    [%expr CSS.textEmphasisStyle(`open_)],
  ),
  (
    [%css "text-emphasis-style: filled double-circle"],
    [%expr [%css "text-emphasis-style:  filled double-circle"]],
    [%expr CSS.textEmphasisStyles(`filled, `double_circle)],
  ),
  (
    [%css "text-emphasis-style: sesame open"],
    [%expr [%css "text-emphasis-style:  sesame open"]],
    [%expr CSS.textEmphasisStyles(`open_, `sesame)],
  ),
  (
    [%css "text-emphasis-position: over"],
    [%expr [%css "text-emphasis-position: over"]],
    [%expr CSS.textEmphasisPosition(`over)],
  ),
  (
    [%css "text-emphasis-position: under"],
    [%expr [%css "text-emphasis-position: under"]],
    [%expr CSS.textEmphasisPosition(`under)],
  ),
  (
    [%css "text-emphasis-position: over left"],
    [%expr [%css "text-emphasis-position: over left"]],
    [%expr CSS.textEmphasisPositions(`over, `left)],
  ),
  (
    [%css "line-break: auto"],
    [%expr [%css "line-break: auto"]],
    [%expr CSS.lineBreak(`auto)],
  ),
  (
    [%css "hyphens: none"],
    [%expr [%css "hyphens: none"]],
    [%expr CSS.hyphens(`none)],
  ),
  (
    [%css "text-justify: none"],
    [%expr [%css "text-justify: none"]],
    [%expr CSS.textJustify(`none)],
  ),
  (
    [%css "text-justify: inter-word"],
    [%expr [%css "text-justify: inter-word"]],
    [%expr CSS.textJustify(`interWord)],
  ),
  (
    [%css "overflow-inline: visible"],
    [%expr [%css "overflow-inline: visible"]],
    [%expr CSS.overflowInline(`visible)],
  ),
  (
    [%css "font-synthesis-weight: none"],
    [%expr [%css "font-synthesis-weight: none"]],
    [%expr CSS.fontSynthesisWeight(`none)],
  ),
  (
    [%css "font-synthesis-style: auto"],
    [%expr [%css "font-synthesis-style: auto"]],
    [%expr CSS.fontSynthesisStyle(`auto)],
  ),
  (
    [%css "font-synthesis-small-caps: none"],
    [%expr [%css "font-synthesis-small-caps: none"]],
    [%expr CSS.fontSynthesisSmallCaps(`none)],
  ),
  (
    [%css "font-synthesis-position: auto"],
    [%expr [%css "font-synthesis-position: auto"]],
    [%expr CSS.fontSynthesisPosition(`auto)],
  ),
  (
    [%css "font-kerning: normal"],
    [%expr [%css "font-kerning: normal"]],
    [%expr CSS.fontKerning(`normal)],
  ),
  (
    [%css "font-variant-position: sub"],
    [%expr [%css "font-variant-position: sub"]],
    [%expr CSS.fontVariantPosition(`sub)],
  ),
  (
    [%css "font-variant-position: super"],
    [%expr [%css "font-variant-position: super"]],
    [%expr CSS.fontVariantPosition(`super)],
  ),
  (
    [%css "font-variant-caps: normal"],
    [%expr [%css "font-variant-caps: normal"]],
    [%expr CSS.fontVariantCaps(`normal)],
  ),
  (
    [%css "font-variant-caps: small-caps"],
    [%expr [%css "font-variant-caps: small-caps"]],
    [%expr CSS.fontVariantCaps(`smallCaps)],
  ),
  (
    [%css "font-variant-caps: all-small-caps"],
    [%expr [%css "font-variant-caps: all-small-caps"]],
    [%expr CSS.fontVariantCaps(`allSmallCaps)],
  ),
  (
    [%css "font-variant-caps: petite-caps"],
    [%expr [%css "font-variant-caps: petite-caps"]],
    [%expr CSS.fontVariantCaps(`petiteCaps)],
  ),
  (
    [%css "font-variant-caps: all-petite-caps"],
    [%expr [%css "font-variant-caps: all-petite-caps"]],
    [%expr CSS.fontVariantCaps(`allPetiteCaps)],
  ),
  (
    [%css "font-variant-caps: titling-caps"],
    [%expr [%css "font-variant-caps: titling-caps"]],
    [%expr CSS.fontVariantCaps(`titlingCaps)],
  ),
  (
    [%css "font-variant-caps: unicase"],
    [%expr [%css "font-variant-caps: unicase"]],
    [%expr CSS.fontVariantCaps(`unicase)],
  ),
  (
    [%css "font-optical-sizing: none"],
    [%expr [%css "font-optical-sizing: none"]],
    [%expr CSS.fontOpticalSizing(`none)],
  ),
  (
    [%css "font-optical-sizing: auto"],
    [%expr [%css "font-optical-sizing: auto"]],
    [%expr CSS.fontOpticalSizing(`auto)],
  ),
  (
    [%css "font-variant-emoji: normal"],
    [%expr [%css "font-variant-emoji: normal"]],
    [%expr CSS.fontVariantEmoji(`normal)],
  ),
  (
    [%css "font-variant-emoji: text"],
    [%expr [%css "font-variant-emoji: text"]],
    [%expr CSS.fontVariantEmoji(`text)],
  ),
  (
    [%css "font-variant-emoji: emoji"],
    [%expr [%css "font-variant-emoji: emoji"]],
    [%expr CSS.fontVariantEmoji(`emoji)],
  ),
  (
    [%css "font-variant-emoji: unicode"],
    [%expr [%css "font-variant-emoji: unicode"]],
    [%expr CSS.fontVariantEmoji(`unicode)],
  ),
  (
    [%css "text-decoration-skip-ink: auto"],
    [%expr [%css "text-decoration-skip-ink: auto"]],
    [%expr CSS.textDecorationSkipInk(`auto)],
  ),
  (
    [%css "text-decoration-skip-ink: none"],
    [%expr [%css "text-decoration-skip-ink: none"]],
    [%expr CSS.textDecorationSkipInk(`none)],
  ),
  (
    [%css "text-decoration-skip-ink: all"],
    [%expr [%css "text-decoration-skip-ink: all"]],
    [%expr CSS.textDecorationSkipInk(`all)],
  ),
  (
    [%css "text-decoration-skip-box: none"],
    [%expr [%css "text-decoration-skip-box: none"]],
    [%expr CSS.textDecorationSkipBox(`none)],
  ),
  (
    [%css "text-decoration-skip-box: all"],
    [%expr [%css "text-decoration-skip-box: all"]],
    [%expr CSS.textDecorationSkipBox(`all)],
  ),
  (
    [%css "text-decoration-skip-inset: none"],
    [%expr [%css "text-decoration-skip-inset: none"]],
    [%expr CSS.textDecorationSkipInset(`none)],
  ),
  (
    [%css "text-decoration-skip-inset: auto"],
    [%expr [%css "text-decoration-skip-inset: auto"]],
    [%expr CSS.textDecorationSkipInset(`auto)],
  ),
  (
    [%css "transform-box: content-box"],
    [%expr [%css "transform-box: content-box"]],
    [%expr CSS.transformBox(`contentBox)],
  ),
  (
    [%css "transform-box: border-box"],
    [%expr [%css "transform-box: border-box"]],
    [%expr CSS.transformBox(`borderBox)],
  ),
  (
    [%css "transform-box: fill-box"],
    [%expr [%css "transform-box: fill-box"]],
    [%expr CSS.transformBox(`fillBox)],
  ),
  (
    [%css "transform-box: stroke-box"],
    [%expr [%css "transform-box: stroke-box"]],
    [%expr CSS.transformBox(`strokeBox)],
  ),
  (
    [%css "transform-box: view-box"],
    [%expr [%css "transform-box: view-box"]],
    [%expr CSS.transformBox(`viewBox)],
  ),
  (
    [%css "border-image-source: url('img_tree.gif')"],
    [%expr [%css "border-image-source: url('img_tree.gif')"]],
    [%expr CSS.borderImageSource(`url({js|img_tree.gif|js}))],
  ),
  (
    [%css "border-image-source: none"],
    [%expr [%css "border-image-source: none"]],
    [%expr CSS.borderImageSource(`none)],
  ),
  (
    [%css "border-image-source: linear-gradient(to top, red, yellow)"],
    [%expr [%css "border-image-source: linear-gradient(to top, red, yellow)"]],
    [%expr
      CSS.borderImageSource(
        `linearGradient((
          Some(`Top),
          [|(Some(CSS.red), None), (Some(CSS.yellow), None)|]: CSS.Types.Gradient.color_stop_list,
        )),
      )
    ],
  ),
  (
    [%css "image-rendering: smooth"],
    [%expr [%css "image-rendering: smooth"]],
    [%expr CSS.imageRendering(`smooth)],
  ),
  (
    [%css "image-rendering: high-quality"],
    [%expr [%css "image-rendering: high-quality"]],
    [%expr CSS.imageRendering(`highQuality)],
  ),
  (
    [%css {|color: red !important|}],
    [%expr [%css {|color: red !important|}]],
    [%expr CSS.important(CSS.color(CSS.red))],
  ),
  (
    [%css "tab-size: 0"],
    [%expr [%css "tab-size: 0"]],
    [%expr CSS.tabSize(`zero)],
  ),
  (
    [%css "tab-size: 4"],
    [%expr [%css "tab-size: 4"]],
    [%expr CSS.tabSize(`num(4.))],
  ),
  (
    [%css "tab-size: 10px"],
    [%expr [%css "tab-size: 10px"]],
    [%expr CSS.tabSize(`pxFloat(10.))],
  ),
  (
    [%css "tab-size: calc(10px + 10px)"],
    [%expr [%css "tab-size: calc(10px + 10px)"]],
    [%expr CSS.tabSize(`calc(`add((`pxFloat(10.), `pxFloat(10.)))))],
  ),
  (
    [%css "tab-size: calc(10px + 10pt)"],
    [%expr [%css "tab-size: calc(10px + 10pt)"]],
    [%expr CSS.tabSize(`calc(`add((`pxFloat(10.), `pt(10)))))],
  ),
  (
    [%css "transition-duration: 3s"],
    [%expr [%css "transition-duration: 3s"]],
    [%expr CSS.transitionDuration(`s(3))],
  ),
  (
    [%css "transition-duration: calc(3s + 1ms)"],
    [%expr [%css "transition-duration: calc(3s + 1ms)"]],
    [%expr CSS.transitionDuration(`calc(`add((`s(3), `ms(1)))))],
  ),
  (
    [%css "transition-duration: min(3s)"],
    [%expr [%css "transition-duration: min(3s)"]],
    [%expr CSS.transitionDuration(`min([|`s(3)|]))],
  ),
  (
    [%css "transition-duration: max(3s, calc(1ms))"],
    [%expr [%css "transition-duration: max(3s, calc(1ms))"]],
    [%expr CSS.transitionDuration(`max([|`s(3), `calc(`ms(1))|]))],
  ),
  (
    [%css "transition-duration: max(+3s, calc(-0ms))"],
    [%expr [%css "transition-duration: max(+3s, calc(-0ms))"]],
    [%expr CSS.transitionDuration(`max([|`s(3), `calc(`ms(0))|]))],
  ),
  (
    [%css "animation: 3s"],
    [%expr [%css "animation: 3s"]],
    [%expr
      CSS.animations([|
        CSS.Types.Animation.Value.make(
          ~duration=?Some(`s(3)),
          ~delay=?None,
          ~direction=?None,
          ~timingFunction=?None,
          ~fillMode=?None,
          ~playState=?None,
          ~iterationCount=?None,
          ~name=?None,
          (),
        ),
      |])
    ],
  ),
  (
    [%css "animation: calc(3s + 1ms)"],
    [%expr [%css "animation: calc(3s + 1ms)"]],
    [%expr
      CSS.animations([|
        CSS.Types.Animation.Value.make(
          ~duration=?Some(`calc(`add((`s(3), `ms(1))))),
          ~delay=?None,
          ~direction=?None,
          ~timingFunction=?None,
          ~fillMode=?None,
          ~playState=?None,
          ~iterationCount=?None,
          ~name=?None,
          (),
        ),
      |])
    ],
  ),
  (
    [%css "animation: calc(3 + 1)"],
    [%expr [%css "animation: calc(3 + 1)"]],
    [%expr
      CSS.animations([|
        CSS.Types.Animation.Value.make(
          ~duration=?Some(`calc(`add((`num(3.), `num(1.))))),
          ~delay=?None,
          ~direction=?None,
          ~timingFunction=?None,
          ~fillMode=?None,
          ~playState=?None,
          ~iterationCount=?None,
          ~name=?None,
          (),
        ),
      |])
    ],
  ),
  (
    [%css "animation: max(3s, 1ms)"],
    [%expr [%css "animation: max(3s, 1ms)"]],
    [%expr
      CSS.animations([|
        CSS.Types.Animation.Value.make(
          ~duration=?Some(`max([|`s(3), `ms(1)|])),
          ~delay=?None,
          ~direction=?None,
          ~timingFunction=?None,
          ~fillMode=?None,
          ~playState=?None,
          ~iterationCount=?None,
          ~name=?None,
          (),
        ),
      |])
    ],
  ),
  (
    [%css "tab-size: calc(10 + 10)"],
    [%expr [%css "tab-size: calc(10 + 10)"]],
    [%expr CSS.tabSize(`calc(`add((`num(10.), `num(10.)))))],
  ),
  (
    [%css {|color: var(--color-link);|}],
    [%expr [%css {|color: var(--color-link);|}]],
    [%expr CSS.color(`var({js|--color-link|js}))],
  ),
  // unsupported
  /*
   (
     [%css "color: hsl(calc(120 + 10) 100% 50%)"],
     [%expr [%css "color: hsl(calc(120 + 10) 100% 50%)"]],
     [%expr
       CSS.color(
         `hsl((
           `calc(`add((`deg(120.), `deg(10.)))),
           `percent(100.),
           `percent(50.),
         )),
       )
     ],
   ),
   (
         [%css
           "border-image-source: repeating-linear-gradient(45deg, transparent, #4d9f0c 20px);"
         ],
         [%expr
           [%css
             "border-image-source: repeating-linear-gradient(45deg, transparent, #4d9f0c 20px);"
           ]
         ],
         [%expr CSS.borderImageSource(`none)],
       ),
       */
  /* (
       [%css "-moz-text-blink: blink"],
       [%expr [%css "-moz-text-blink: blink"]],
       [%expr CSS.unsafe("MozTextBlink", "blink")],
     ), */
  /* (
       [%css "display: -webkit-inline-box"],
       [%expr [%css "display: -webkit-inline-box"]],
       [%expr CSS.unsafe("display", "-webkit-inline-box")],
     ), */
];

let runner = tests =>
  List.mapi(
    (index, item) => {
      let (_title, input, expected) = item;
      let title = Ppxlib.Pprintast.string_of_expression(input);
      test(
        Int.to_string(index)
        ++ ". "
        ++ String.sub(title, 0, min(String.length(title), 20)),
        () => {
          let pp_expr = (ppf, x) =>
            Fmt.pf(ppf, "%S", Ppxlib.Pprintast.string_of_expression(x));
          let check_expr = Alcotest.testable(pp_expr, (==));
          Alcotest.check(check_expr, "", expected, input);
        },
      );
    },
    tests,
  );

let tests: tests = runner(properties_static_css_tests);
