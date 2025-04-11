open Vitest

let testData = list{
  (%cx("opacity: 0.9"), CSS.style([CSS.opacity(0.9)])),
  (
    %cx("@media (min-width: 30em) { color: brown; }"),
    CSS.style([CSS.media("(min-width: 30em)", [CSS.color(CSS.brown)])]),
  ),
}

describe("cx", () => {
  Belt.List.forEachWithIndex(testData, (index, (cssIn, emotionOut)) =>
    test(string_of_int(index), _t => expect(cssIn)->Expect.toEqual(emotionOut))
  )
})
