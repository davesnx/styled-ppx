open Jest;

let testData = [
  /* ([%cx "border-top-color: blue"], CssJs.style(. [|CssJs.borderTopColorCssJs.blue|])), */
  /* ([%cx "border-right-color: green"], CssJs.style(. [|CssJs.borderRightColorCssJs.green|])), */
  /* ([%cx "border-bottom-color: purple"], CssJs.style(. [|CssJs.borderBottomColorCssJs.purple|])), */
  ("border-left-color", [%cx "border-left-color: #fff"], CssJs.style(. [|CssJs.borderLeftColor(`hex("fff"))|])),
  /* ([%cx "border-right-width: 16px"], CssJs.style(. [|CssJs.borderRightWidth(`pxFloat(16.))|])),
  ([%cx "border-bottom-width: 17px"], CssJs.style(. [|CssJs.borderBottomWidth(`pxFloat(17.))|])),
  ([%cx "border-left-width: 18px"], CssJs.style(. [|CssJs.borderLeftWidth(`pxFloat(18.))|])),
  ([%cx "border-top-left-radius: 12%"], CssJs.style(. [|CssJs.borderTopLeftRadius(`percent(12.))|])),
  ([%cx "border-top-right-radius: 15%"], CssJs.style(. [|CssJs.borderTopRightRadius(`percent(15.))|])),
  ([%cx "border-bottom-left-radius: 14%"], CssJs.style(. [|CssJs.borderBottomLeftRadius(`percent(14.))|])),
  ([%cx "border-bottom-right-radius: 13%"], CssJs.style(. [|CssJs.borderBottomRightRadius(`percent(13.))|])), */
];

Belt.List.forEachWithIndex(testData, (index, (name, cssIn, emotionOut)) => {
  test(string_of_int(index) ++ ". Supports " ++ name, () => {
    Expect.expect(cssIn) |> Expect.toMatch(emotionOut);
  });
});
