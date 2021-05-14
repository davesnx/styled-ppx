open Jest;

let testData = [
  (
    "(min-width: 30em) and (min-height: 20em)",
    [%cx "@media (min-width: 30em) and (min-height: 20em) { color: brown; }"],
    CssJs.style(. [|
      CssJs.media(
        "(min-width: 30em) and (min-height: 20em)",
        [|CssJs.color(CssJs.brown)|],
      ),
    |])
  )
];

describe("media-queries", _ => {
  Belt.List.forEachWithIndex(testData, (index, (name, cssIn, emotionOut)) => {
    test(string_of_int(index) ++ ". Supports " ++ name, () => {
      Expect.expect(cssIn) |> Expect.toMatch(emotionOut);
    });
  });
});
