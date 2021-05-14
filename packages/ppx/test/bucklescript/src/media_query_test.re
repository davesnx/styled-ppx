open Jest;

let testData = [
  (
    "(min-width: 30em) and (min-height: 200px)",
    [%cx "@media (min-width: 30em) and (min-height: 200px) { color: brown; }"],
    CssJs.style(. [|
      CssJs.media(
        "(min-width: 30em) and (min-height: 200px)",
        [|CssJs.color(CssJs.brown)|],
      ),
    |])
  ),
  /* (
    "prefers-color-scheme: dark",
    [%cx "@media (prefers-color-scheme: dark) { color: white; }"],
    CssJs.style(. [|
      CssJs.media(
        "prefers-color-scheme: dark",
        [|CssJs.color(CssJs.white)|],
      ),
    |])
  ), */

  /* (
    "screen and (prefers-reduced-motion: reduce",
    [%cx "@media screen and (prefers-reduced-motion: reduce) { color: white; }"],
    CssJs.style(. [|
      CssJs.media(
        "media screen and (prefers-reduced-motion: reduce)",
        [|CssJs.color(CssJs.white)|],
      ),
    |])
  ), */
];

describe("media-queries", _ => {
  Belt.List.forEachWithIndex(testData, (index, (name, cssIn, emotionOut)) => {
    test(string_of_int(index) ++ ". Supports " ++ name, () => {
      Expect.expect(cssIn) |> Expect.toMatch(emotionOut);
    });
  });
});
