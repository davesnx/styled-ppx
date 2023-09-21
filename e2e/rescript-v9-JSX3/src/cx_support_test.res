open Vitest

let testData = list{
  (%cx("opacity: 0.9"), CssJs.style(. [CssJs.opacity(0.9)])),
  (
    %cx("@media (min-width: 30em) { color: brown; }"),
    CssJs.style(. [CssJs.media(. "(min-width: 30em)", [CssJs.color(CssJs.brown)])]),
  ),
}

describe("cx", () => {
  Belt.List.forEachWithIndex(testData, (index, (cssIn, emotionOut)) =>
    test(string_of_int(index), _t => expect(cssIn)->Expect.toEqual(emotionOut))
  )
})
