open Alcotest;
open Ppxlib;

let loc = Location.none;

let tests =
  [
    (
      "color: $(mono100)",
      [%expr [%css "color: $(mono100)"]],
      [%expr (CssJs.color(mono100): CssJs.rule)],
    ),
    (
      "margin: $(Size.big) $(Size.small)",
      [%expr [%css "margin: $(Size.big) $(Size.small)"]],
      [%expr CssJs.margin2(~v=Size.big, ~h=Size.small)],
    ),
    (
      "color: $(mono100)",
      [%expr [%css "color: $(mono100)"]],
      [%expr (CssJs.color(mono100): CssJs.rule)],
    ),
    (
      "padding: $(Size.small) 0px;",
      [%expr [%css "padding: $(Size.small) 0px"]],
      [%expr CssJs.padding2(~v=Size.small, ~h=`pxFloat(0.))],
    ),
    (
      "border: 1px solid $(Color.Border.alpha)",
      [%expr [%css "border: 1px solid $(Color.Border.alpha)"]],
      [%expr CssJs.border(`pxFloat(1.), `solid, Color.Border.alpha)],
    ),
    (
      "outline: 1px solid $(Color.Border.alpha)",
      [%expr [%css "outline: 1px solid $(Color.Border.alpha)"]],
      [%expr CssJs.outline(`pxFloat(1.), `solid, Color.Border.alpha)],
    ),
    (
      "border-bottom: 0px solid $(Color.Border.alpha)",
      [%expr [%css "border-bottom: 0px solid $(Color.Border.alpha)"]],
      [%expr CssJs.borderBottom(`pxFloat(0.), `solid, Color.Border.alpha)],
    ),
    (
      "width: $(width)",
      [%expr [%css "width: $(width)"]],
      [%expr (CssJs.width(width): CssJs.rule)],
    ),
    (
      "max-width: $(max)",
      [%expr [%css "max-width: $(max)"]],
      [%expr (CssJs.maxWidth(max): CssJs.rule)],
    ),
    (
      "height: $(height)",
      [%expr [%css "height: $(height)"]],
      [%expr (CssJs.height(height): CssJs.rule)],
    ),
    (
      "border-radius: $(border)",
      [%expr [%css "border-radius: $(border)"]],
      [%expr (CssJs.borderRadius(border): CssJs.rule)],
    ),
    (
      "font-size: $(font)",
      [%expr [%css "font-size: $(font)"]],
      [%expr (CssJs.fontSize(font): CssJs.rule)],
    ),
    (
      "font-family: $(mono)",
      [%expr [%css "font-family: $(mono)"]],
      [%expr
        CssJs.fontFamilies(mono: array(Css_AtomicTypes.FontFamilyName.t))
      ],
    ),
    (
      "line-height: $(lh)",
      [%expr [%css "line-height: $(lh)"]],
      [%expr (CssJs.lineHeight(lh): CssJs.rule)],
    ),
    (
      "z-index: $(zLevel)",
      [%expr [%css "z-index: $(zLevel)"]],
      [%expr (CssJs.zIndex(zLevel): CssJs.rule)],
    ),
    (
      "left: $(left)",
      [%expr [%css "left: $(left)"]],
      [%expr (CssJs.left(left): CssJs.rule)],
    ),
    (
      "text-decoration-color: $(decorationColor)",
      [%expr [%css "text-decoration-color: $(decorationColor)"]],
      [%expr (CssJs.textDecorationColor(decorationColor): CssJs.rule)],
    ),
    (
      "background-image: $(wat);",
      [%expr [%css "background-image: $(wat);"]],
      [%expr CssJs.backgroundImage(wat)],
    ),
    (
      "mask-image: $(externalImageUrl);",
      [%expr [%css "mask-image: $(externalImageUrl);"]],
      [%expr (CssJs.maskImage(externalImageUrl): CssJs.rule)],
    ),
    (
      "text-shadow: $(h) $(v) $(blur) $(color)",
      [%expr [%css "text-shadow: $(h) $(v) $(blur) $(color)"]],
      [%expr CssJs.textShadow(CssJs.Shadow.text(~x=h, ~y=v, ~blur, color))],
    ),
    (
      "color: $(Theme.blue)",
      [%expr [%css "color: $(Theme.blue)"]],
      [%expr (CssJs.color(Theme.blue): CssJs.rule)],
    ),
    /* Changed properties */
    (
      "box-shadow: $(h) $(v) $(blur) $(spread) $(color)",
      [%expr [%css "box-shadow: $(h) $(v) $(blur) $(spread) $(color)"]],
      [%expr
        CssJs.boxShadows([|
          CssJs.Shadow.box(~x=h, ~y=v, ~blur, ~spread, color),
        |])
      ],
    ),
    (
      "box-shadow: 10px 10px 0px $(spread) $(color)",
      [%expr [%css "box-shadow: 10px 10px 0px $(spread) $(color)"]],
      [%expr
        CssJs.boxShadows([|
          CssJs.Shadow.box(
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
      [%expr CssJs.boxShadows(BoxShadow.elevation)],
    ),
    (
      "box-shadow: none",
      [%expr [%css "box-shadow: none"]],
      [%expr CssJs.boxShadow(`none)],
    ),
    (
      "text-overflow: $(clip)",
      [%expr [%css "text-overflow: $(clip)"]],
      [%expr (CssJs.textOverflow(clip): CssJs.rule)],
    ),
    (
      "transition-duration: 500ms;",
      [%expr [%css "transition-duration: 500ms"]],
      [%expr CssJs.transitionDuration(`ms(500))],
    ),
    (
      "transition-duration: $(duration)",
      [%expr [%css "transition-duration: $(duration)"]],
      [%expr (CssJs.transitionDuration(duration): CssJs.rule)],
    ),
    (
      "animation-play-state: $(state)",
      [%expr [%css "animation-play-state: $(state)"]],
      [%expr (CssJs.animationPlayState(state): CssJs.rule)],
    ),
    (
      "animation-play-state: paused;",
      [%expr [%css "animation-play-state: paused"]],
      [%expr CssJs.animationPlayState(`paused)],
    ),
    (
      "column-gap: $(Size.px30);",
      [%expr [%css "column-gap: $(Size.px30)"]],
      [%expr (CssJs.columnGap(Size.px30): CssJs.rule)],
    ),
    // Test for property not inside properties list on declarations_to_emotion.re, should trigger unsafe interpolation
    (
      "-webkit-text-fill-color: $(Color.red);",
      [%expr [%css "-webkit-text-fill-color: $(Color.red)"]],
      [%expr CssJs.unsafe({js|WebkitTextFillColor|js}, Color.red)],
    ),
  ]
  |> List.map(item => {
       let (title, input, expected) = item;
       test_case(
         title,
         `Quick,
         () => {
           let pp_expr = (ppf, x) =>
             Fmt.pf(ppf, "%S", Pprintast.string_of_expression(x));
           let check_expr = testable(pp_expr, (==));
           check(check_expr, "", expected, input);
         },
       );
     });
