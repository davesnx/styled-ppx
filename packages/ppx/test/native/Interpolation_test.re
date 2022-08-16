open Setup;
open Ppxlib;

let loc = Location.none;

let compare = (input, expected, {expect, _}) => {
  let result = Pprintast.string_of_expression(input);
  let expected = Pprintast.string_of_expression(expected);
  expect.string(result).toEqual(expected);
};

let properties_variable_css_tests = [
  (
    [%expr [%css "color: $(mono100);"]],
    [%expr (CssJs.color(mono100) : CssJs.rule)]
  ),
  (
    [%expr [%css "margin: $(Size.big) $(Size.small);"]],
    [%expr CssJs.margin2(~v=Size.big, ~h=Size.small)]
  ),
  (
    [%expr [%css "color: $(mono100);"]],
    [%expr (CssJs.color(mono100) : CssJs.rule)]
  ),
  (
    [%expr [%css "padding: $(Size.small) 0px;"]],
    [%expr CssJs.padding2(~v=Size.small, ~h=`pxFloat(0.))]
  ),
  (
    [%expr [%css "border: 1px solid $(Color.Border.alpha);"]],
    [%expr CssJs.border(`pxFloat(1.), `solid, Color.Border.alpha)]
  ),
  (
    [%expr [%css "outline: 1px solid $(Color.Border.alpha);"]],
    [%expr CssJs.outline(`pxFloat(1.), `solid, Color.Border.alpha)]
  ),
  (
    [%expr [%css "border-bottom: 0px solid $(Color.Border.alpha);"]],
    [%expr CssJs.borderBottom(`pxFloat(0.), `solid, Color.Border.alpha)]
  ),
  (
    [%expr [%css "width: $(width);"]],
    [%expr (CssJs.width(width) : CssJs.rule)]
  ),
  (
    [%expr [%css "max-width: $(max);"]],
    [%expr (CssJs.maxWidth(max) : CssJs.rule)]
  ),
  (
    [%expr [%css "height: $(height);"]],
    [%expr (CssJs.height(height) : CssJs.rule)]
  ),
  (
    [%expr [%css "border-radius: $(border);"]],
    [%expr (CssJs.borderRadius(border) : CssJs.rule)]
  ),
  (
    [%expr [%css "font-size: $(font);"]],
    [%expr (CssJs.fontSize(font) : CssJs.rule)]
  ),
  (
    [%expr [%css "font-family: $(mono);"]],
    [%expr (CssJs.fontFamily(mono) : CssJs.rule)]
  ),
  (
    [%expr [%css "line-height: $(lh);"]],
    [%expr (CssJs.lineHeight(lh) : CssJs.rule)]
  ),
  (
    [%expr [%css "z-index: $(zLevel);"]],
    [%expr (CssJs.zIndex(zLevel) : CssJs.rule)]
  ),
  (
    [%expr [%css "left: $(left);"]],
    [%expr (CssJs.left(left) : CssJs.rule)]
  ),
  (
    [%expr [%css "text-decoration-color: $(decorationColor);"]],
    [%expr (CssJs.textDecorationColor(decorationColor) : CssJs.rule)]
  ),
  (
    [%expr [%css "background-image: $(wat);" ]],
    [%expr (CssJs.backgroundImage(wat) : CssJs.rule)],
  ),
  (
    [%expr [%css "mask-image: $(externalImageUrl);" ]],
    [%expr (CssJs.maskImage(externalImageUrl) : CssJs.rule)],
  ),
  (
    [%expr [%css "color: $(Theme.blue);"]],
    [%expr (CssJs.color(Theme.blue) : CssJs.rule)]
  ),
  /* Changed properties */
  (
    [%expr [%css "box-shadow: $(h) $(v) $(blur) $(spread) $(color);"]],
    [%expr CssJs.boxShadows([|
      CssJs.Shadow.box(~x=h, ~y=v, ~blur=blur, ~spread=spread, color)
    |])]
  ),
  (
    [%expr [%css "box-shadow: 10px 10px 0px $(spread) $(color);"]],
    [%expr CssJs.boxShadows([|
      CssJs.Shadow.box(
        ~x=`pxFloat(10.),
        ~y=`pxFloat(10.),
        ~blur=`pxFloat(0.),
        ~spread=spread,
        color
      )
    |])]
  ),
  (
    [%expr [%css "box-shadow: $(BoxShadow.elevation);"]],
    [%expr (CssJs.boxShadows(BoxShadow.elevation): CssJs.rule)]
  ),
  (
    [%expr [%css "text-overflow: $(clip);"]],
    [%expr (CssJs.textOverflow(clip): CssJs.rule)]
  ),
  (
    [%expr [%css "transition-duration: 500ms;"]],
    [%expr CssJs.transitionDuration(`ms(500))]
  ),
  (
    [%expr [%css "transition-duration: $(duration);"]],
    [%expr (CssJs.transitionDuration(duration): CssJs.rule)]
  ),
  (
    [%expr [%css "animation-play-state: $(state);"]],
    [%expr (CssJs.animationPlayState(state): CssJs.rule)]
  ),
  (
    [%expr [%css "animation-play-state: paused;"]],
    [%expr CssJs.animationPlayState(`paused)]
  ),
];

describe("Should bind to bs-css with interpolated variables", ({test, _}) => {
  properties_variable_css_tests |>
    List.iteri((_index, (result, expected)) =>
      test(
        "simple variable: " ++ Pprintast.string_of_expression(expected),
        compare(result, expected),
      )
    );
});
