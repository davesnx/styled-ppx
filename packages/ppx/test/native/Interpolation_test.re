let loc = Ppxlib.Location.none;

let tests =
  [
    (
      "color: $(mono100)",
      [%expr [%css "color: $(mono100)"]],
      [%expr (CSS.color(mono100): CSS.rule)],
    ),
    (
      "margin: $(Size.big) $(Size.small)",
      [%expr [%css "margin: $(Size.big) $(Size.small)"]],
      [%expr CSS.margin2(~v=Size.big, ~h=Size.small)],
    ),
    (
      "padding: $(Size.small) 0px;",
      [%expr [%css "padding: $(Size.small) 0px"]],
      [%expr CSS.padding2(~v=Size.small, ~h=`pxFloat(0.))],
    ),
    (
      "border: 1px solid $(Color.Border.alpha)",
      [%expr [%css "border: 1px solid $(Color.Border.alpha)"]],
      [%expr CSS.border(`pxFloat(1.), `solid, Color.Border.alpha)],
    ),
    (
      "outline: 1px solid $(Color.Border.alpha)",
      [%expr [%css "outline: 1px solid $(Color.Border.alpha)"]],
      [%expr CSS.outline(`pxFloat(1.), `solid, Color.Border.alpha)],
    ),
    (
      "border-bottom: 0px solid $(Color.Border.alpha)",
      [%expr [%css "border-bottom: 0px solid $(Color.Border.alpha)"]],
      [%expr CSS.borderBottom(`pxFloat(0.), `solid, Color.Border.alpha)],
    ),
    (
      "width: $(width)",
      [%expr [%css "width: $(width)"]],
      [%expr (CSS.width(width): CSS.rule)],
    ),
    (
      "max-width: $(max)",
      [%expr [%css "max-width: $(max)"]],
      [%expr (CSS.maxWidth(max): CSS.rule)],
    ),
    (
      "height: $(height)",
      [%expr [%css "height: $(height)"]],
      [%expr (CSS.height(height): CSS.rule)],
    ),
    (
      "border-radius: $(border)",
      [%expr [%css "border-radius: $(border)"]],
      [%expr (CSS.borderRadius(border): CSS.rule)],
    ),
    (
      "font-size: $(font)",
      [%expr [%css "font-size: $(font)"]],
      [%expr (CSS.fontSize(font): CSS.rule)],
    ),
    (
      "font-family: $(mono)",
      [%expr [%css "font-family: $(mono)"]],
      [%expr CSS.fontFamilies(mono: array(CSS.Types.FontFamilyName.t))],
    ),
    (
      "line-height: $(lh)",
      [%expr [%css "line-height: $(lh)"]],
      [%expr (CSS.lineHeight(lh): CSS.rule)],
    ),
    (
      "z-index: $(zLevel)",
      [%expr [%css "z-index: $(zLevel)"]],
      [%expr (CSS.zIndex(zLevel): CSS.rule)],
    ),
    (
      "left: $(left)",
      [%expr [%css "left: $(left)"]],
      [%expr (CSS.left(left): CSS.rule)],
    ),
    (
      "text-decoration-color: $(decorationColor)",
      [%expr [%css "text-decoration-color: $(decorationColor)"]],
      [%expr (CSS.textDecorationColor(decorationColor): CSS.rule)],
    ),
    (
      "background-image: $(wat);",
      [%expr [%css "background-image: $(wat);"]],
      [%expr CSS.backgroundImage(wat)],
    ),
    (
      "mask-image: $(externalImageUrl);",
      [%expr [%css "mask-image: $(externalImageUrl);"]],
      [%expr (CSS.maskImage(externalImageUrl): CSS.rule)],
    ),
    (
      "text-shadow: $(h) $(v) $(blur) $(color)",
      [%expr [%css "text-shadow: $(h) $(v) $(blur) $(color)"]],
      [%expr CSS.textShadow(CSS.Shadow.text(~x=h, ~y=v, ~blur, color))],
    ),
    (
      "color: $(Theme.blue)",
      [%expr [%css "color: $(Theme.blue)"]],
      [%expr (CSS.color(Theme.blue): CSS.rule)],
    ),
    /* Changed properties */
    (
      "box-shadow: $(h) $(v) $(blur) $(spread) $(color)",
      [%expr [%css "box-shadow: $(h) $(v) $(blur) $(spread) $(color)"]],
      [%expr
        CSS.boxShadows([|CSS.Shadow.box(~x=h, ~y=v, ~blur, ~spread, color)|])
      ],
    ),
    (
      "box-shadow: 10px 10px 0px $(spread) $(color)",
      [%expr [%css "box-shadow: 10px 10px 0px $(spread) $(color)"]],
      [%expr
        CSS.boxShadows([|
          CSS.Shadow.box(
            ~x=`pxFloat(10.),
            ~y=`pxFloat(10.),
            ~blur=`pxFloat(0.),
            ~spread,
            color,
          ),
        |])
      ],
    ),
    (
      "box-shadow: $(BoxShadow.elevation)",
      [%expr [%css "box-shadow: $(BoxShadow.elevation)"]],
      [%expr CSS.boxShadows(BoxShadow.elevation)],
    ),
    (
      "box-shadow: none",
      [%expr [%css "box-shadow: none"]],
      [%expr CSS.boxShadow(`none)],
    ),
    (
      "text-overflow: $(clip)",
      [%expr [%css "text-overflow: $(clip)"]],
      [%expr (CSS.textOverflow(clip): CSS.rule)],
    ),
    (
      "transition-duration: 500ms;",
      [%expr [%css "transition-duration: 500ms"]],
      [%expr CSS.transitionDuration(`ms(500))],
    ),
    (
      "transition-duration: $(duration)",
      [%expr [%css "transition-duration: $(duration)"]],
      [%expr CSS.transitionDuration(duration)],
    ),
    (
      "animation-play-state: $(state)",
      [%expr [%css "animation-play-state: $(state)"]],
      [%expr CSS.animationPlayState(state)],
    ),
    (
      "animation-play-state: paused;",
      [%expr [%css "animation-play-state: paused"]],
      [%expr CSS.animationPlayState(`paused)],
    ),
    (
      "column-gap: $(Size.px30);",
      [%expr [%css "column-gap: $(Size.px30)"]],
      [%expr (CSS.columnGap(Size.px30): CSS.rule)],
    ),
    // Test for property not inside properties list on declarations_to_emotion.re, should trigger unsafe interpolation
    (
      "-webkit-text-fill-color: $(Color.red);",
      [%expr [%css "-webkit-text-fill-color: $(Color.red)"]],
      [%expr CSS.unsafe({js|WebkitTextFillColor|js}, Color.red)],
    ),
  ]
  |> List.map(item => {
       let (title, input, expected) = item;
       test(
         title,
         () => {
           let pp_expr = (ppf, x) =>
             Fmt.pf(ppf, "%S", Ppxlib.Pprintast.string_of_expression(x));
           let check_expr = Alcotest.testable(pp_expr, (==));
           check(~__POS__, check_expr, expected, input);
         },
       );
     });
