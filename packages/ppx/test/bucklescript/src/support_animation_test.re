open Jest;

let testData = [
  ("animation-name", [%cx "animation-name: slidein"], CssJs.style(. [|CssJs.unsafe("animationName", "slidein")|])),
  ("animation-duration", [%cx "animation-duration: 3s"], CssJs.style(. [|CssJs.unsafe("animationDuration", "3s")|])),
  ("animation-timing-function", [%cx "animation-timing-function: ease"], CssJs.style(. [|CssJs.unsafe("animationTimingFunction", "ease")|])),
  ("animation-delay", [%cx "animation-delay: 3s"], CssJs.style(. [|CssJs.unsafe("animationDelay", "3s")|])),
  ("animation-direction", [%cx "animation-direction: alternate"], CssJs.style(. [|CssJs.unsafe("animationDirection", "alternate")|])),
  ("animation-iteration-count", [%cx "animation-iteration-count: infinite"], CssJs.style(. [|CssJs.unsafe("animationIterationCount", "infinite")|])),
  ("animation-iteration-count", [%cx "animation-iteration-count: 1"], CssJs.style(. [|CssJs.unsafe("animationIterationCount", "1")|])),
  ("animation-iteration-count", [%cx "animation-iteration-count: 2, 1, 5"], CssJs.style(. [|CssJs.unsafe("animationIterationCount", "2, 1, 5")|])),
  ("animation-fill-mode", [%cx "animation-fill-mode: backwards"], CssJs.style(. [|CssJs.unsafe("animationFillMode", "backwards")|])),
];

Belt.List.forEachWithIndex(testData, (index, (name, cssIn, emotionOut)) => {
  test(string_of_int(index) ++ ". Supports " ++ name, () => {
    Expect.expect(cssIn) |> Expect.toMatch(emotionOut);
  });
});
