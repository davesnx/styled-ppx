open Jest

EmotionSerializer.load()

external toString: CssJs.animationName => string = "%identity"

let testData = list{
  /* (%cx("overflow-x: clip"), CssJs.style(. [CssJs.unsafe("overflowX", "clip")])), */
  (%cx("opacity: 0.9"), CssJs.style(. [CssJs.opacity(0.9)])),
  (
    %cx("@media (min-width: 30em) { color: brown; }"),
    CssJs.style(. [CssJs.media(. "(min-width: 30em)", [CssJs.color(CssJs.brown)])]),
  ),
  (
    %cx(`
    box-shadow:
      12px 12px 2px 1px rgba(0, 0, 255, .2),
      13px 14px 5px 6px rgba(2, 1, 255, 50%);
    `),
    CssJs.style(. [
      CssJs.boxShadows([
        CssJs.Shadow.box(
          ~x=#pxFloat(12.),
          ~y=#pxFloat(12.),
          ~blur=#pxFloat(2.),
          ~spread=#pxFloat(1.),
          #rgba(0, 0, 255, #num(0.2)),
        ),
        CssJs.Shadow.box(
          ~x=#pxFloat(13.),
          ~y=#pxFloat(14.),
          ~blur=#pxFloat(5.),
          ~spread=#pxFloat(6.),
          #rgba(2, 1, 255, #percent(0.5)),
        ),
      ]),
    ]),
  ),
  (
    %cx("box-shadow: 12px 12px 2px 1px rgba(0, 0, 255, 0.2)"),
    CssJs.style(. [
      CssJs.boxShadows([
        CssJs.Shadow.box(
          ~x=#pxFloat(12.),
          ~y=#pxFloat(12.),
          ~blur=#pxFloat(2.),
          ~spread=#pxFloat(1.),
          #rgba(0, 0, 255, #num(0.2)),
        ),
      ]),
    ]),
  ),
}

Belt.List.forEachWithIndex(testData, (index, (cssIn, emotionOut)) =>
  test(string_of_int(index), () => Expect.expect(cssIn) |> Expect.toEqual(emotionOut))
)
