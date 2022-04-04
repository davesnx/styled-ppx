open Jest

let testData = list{
  (
    "transition-property",
    %cx("transition-property: all"),
    CssJs.style(. [CssJs.unsafe("transitionProperty", "all")]),
  ),
  (
    "transition-duration",
    %cx("transition-duration: 0.5s"),
    CssJs.style(. [CssJs.unsafe("transitionDuration", "0.5s")]),
  ),
  (
    "transition-timing-function",
    %cx("transition-timing-function: ease"),
    CssJs.style(. [CssJs.unsafe("transitionTimingFunction", "ease")]),
  ),
  (
    "transition-timing-function",
    %cx("transition-timing-function: step-end"),
    CssJs.style(. [CssJs.unsafe("transitionTimingFunction", "step-end")]),
  ),
  (
    "transition-delay",
    %cx("transition-delay: 0.5s"),
    CssJs.style(. [CssJs.unsafe("transitionDelay", "0.5s")]),
  ),
  ("transition", %cx("transition: none;"), CssJs.style(. [CssJs.unsafe("transition", "none")])),
  (
    "transition",
    %cx("transition: ease 250ms"),
    CssJs.style(. [CssJs.unsafe("transition", "ease 250ms")]),
  ),
  (
    "transition",
    %cx("transition: margin-left 4s ease-in-out 1s"),
    CssJs.style(. [CssJs.unsafe("transition", "margin-left 4s ease-in-out 1s")]),
  ),
  (
    "transition",
    %cx("transition: width 2s, height 2s, background-color 2s, transform 2s"),
    CssJs.style(. [
      CssJs.unsafe("transition", "width 2s, height 2s, background-color 2s, transform 2s"),
    ]),
  ),
}

Belt.List.forEachWithIndex(testData, (index, (name, cssIn, emotionOut)) =>
  test(string_of_int(index) ++ (". Supports " ++ name), () =>
    Expect.expect(cssIn) |> Expect.toMatch(emotionOut)
  )
)
