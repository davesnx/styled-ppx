open Vitest

let testData = list{
  (%cx("opacity: 0.9"), CssJs.style([CssJs.opacity(0.9)])),
  (
    %cx("@media (min-width: 30em) { color: brown; }"),
    CssJs.style([CssJs.media("(min-width: 30em)", [CssJs.color(CssJs.brown)])]),
  ),
  (%cx("text-transform: initial"), CssJs.style([CssJs.textTransform(#initial)])),
  (%cx("text-transform: unset"), CssJs.style([CssJs.textTransform(#unset)])),
  (%cx("text-transform: inherit"), CssJs.style([CssJs.textTransform(#inherit_)])),
  (%cx("text-transform: revert"), CssJs.style([CssJs.textTransform(#revert)])),
  (%cx("text-transform: revert-layer"), CssJs.style([CssJs.textTransform(#revertLayer)])),
}

describe("cx", () => {
  Belt.List.forEachWithIndex(testData, (index, (cssIn, emotionOut)) =>
    test(string_of_int(index), _t => expect(cssIn)->Expect.toEqual(emotionOut))
  )
})
