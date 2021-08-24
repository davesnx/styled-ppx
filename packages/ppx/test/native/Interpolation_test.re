// TODO: generate tests with variables in the future
    // ([%css "flex-wrap: $var"], CssJs.flexWrap(var)),
    // ([%css "flex-wrap: $(var)"], CssJs.flexWrap(var)),
    /* (
      [%css "flex-flow: row nowrap"],
      CssJs.flexDirection(`row), CssJs.flexWrap(`nowrap)|],
    ), */

/* let properties_variable_css_tests = [
  ([%expr [%css "color: $(var);"]], [%expr CssJs.unsafe("color", var)]),
  ([%expr [%css "margin: $(var);"]], [%expr CssJs.unsafe("margin", var)]),
  ([%expr [%css "margin: $(Size.big) $(Size.small);"]], [%expr CssJs.margin2(~v=Size.big, ~h=Size.small)]),
  ([%expr [%css "color: $(mono100);"]], [%expr CssJs.color(mono100)]),
  ([%expr [%css "padding: $(Size.small) 0px;"]], [%expr CssJs.padding2(~v=Size.small, ~h=`pxFloat(0.))]),
  ([%expr [%css "border: 1px solid $(Color.Border.alpha);"]], [%expr CssJs.border(`pxFloat(1.), `solid, Color.Border.alpha)]),
  ([%expr [%css "border-bottom: 0px solid $(Color.Border.alpha);"]], [%expr CssJs.borderBottom(`pxFloat(0.), `solid, Color.Border.alpha)]),
  ([%expr [%css "width: $(width);"]], [%expr CssJs.width(width)]),
  ([%expr [%css "max-width: $(max);"]], [%expr CssJs.maxWidth(max)]),
  ([%expr [%css "height: $(height);"]], [%expr CssJs.height(height)]),
  ([%expr [%css "border-radius: $(border);"]], [%expr CssJs.borderRadius(border)]),
  ([%expr [%css "font-size: $(font);"]], [%expr CssJs.fontSize(font)]),
  ([%expr [%css "font-family: $(mono);"]], [%expr CssJs.fontFamily(mono)]),
  ([%expr [%css "line-height: $(lh);"]], [%expr CssJs.lineHeight(lh)]),
  ([%expr [%css "z-index: $(zLevel);"]], [%expr CssJs.zIndex(zLevel)]),
  ([%expr [%css "left: $(left);"]], [%expr CssJs.left(left)]),
  ([%expr [%css "text-decoration-color: $(decorationColor);"]], [%expr CssJs.textDecorationColor(decorationColor)]),
];

describe("Transform [%css] to bs-css bindings with interpolatated variables", ({test, _}) => {
  let test = (index, (result, expected)) =>
    test(
      "simple variable: " ++ string_of_int(index),
      compare(result, expected),
    );

  List.iteri(test, properties_variable_css_tests);
});
 */
