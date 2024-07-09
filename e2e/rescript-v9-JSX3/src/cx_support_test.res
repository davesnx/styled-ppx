open Vitest

let testData = list{
  (%cx("opacity: 0.9"), CSS.style([CSS.opacity(0.9)])),
  (
    %cx("@media (min-width: 30em) { color: brown; }"),
    CSS.style([CSS.media("(min-width: 30em)", [CSS.color(CSS.brown)])]),
  ),
  (%cx("text-transform: initial"), CSS.style([CSS.textTransform(#initial)])),
  (%cx("text-transform: unset"), CSS.style([CSS.textTransform(#unset)])),
  (%cx("text-transform: inherit"), CSS.style([CSS.textTransform(#inherit_)])),
  (%cx("text-transform: revert"), CSS.style([CSS.textTransform(#revert)])),
  (%cx("text-transform: revert-layer"), CSS.style([CSS.textTransform(#revertLayer)])),
}

describe("cx", () => {
  Belt.List.forEachWithIndex(testData, (index, (cssIn, emotionOut)) =>
    test(string_of_int(index), _t => expect(cssIn)->Expect.toEqual(emotionOut))
  )
})
