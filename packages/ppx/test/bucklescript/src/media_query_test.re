open Jest;

let testData = [
  (
    "media-query",
    [%cx "@media (min-width: 30em) and (min-height: 20em) { color: brown; }"],
    CssJs.style(. [|
      CssJs.media(
        "(min-width: 30em) and (min-height: 20em)",
        [|CssJs.color(CssJs.brown)|],
      ),
    |])
  )
];

Belt.List.forEachWithIndex(testData, (index, (name, cssIn, emotionOut)) => {
  test(string_of_int(index) ++ ". Supports " ++ name, () => {
    Expect.expect(cssIn) |> Expect.toMatch(emotionOut);
  });
});
