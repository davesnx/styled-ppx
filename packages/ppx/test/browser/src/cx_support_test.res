open Jest

EmotionSerializer.load()

let testData = list{
  (%cx("overflow-x: clip"), CssJs.style(. [CssJs.unsafe("overflowX", "clip")])),
  (%cx("opacity: 0.9"), CssJs.style(. [CssJs.opacity(0.9)])),
  (%cx("visibility: visible"), CssJs.style(. [CssJs.unsafe("visibility", "visible")])),
  (%cx("hyphens: manual"), CssJs.style(. [CssJs.unsafe("hyphens", "manual")])),
  (%cx("stroke: none"), CssJs.style(. [CssJs.unsafe("stroke", "none")])),
  (%cx("direction: ltr"), CssJs.style(. [CssJs.unsafe("direction", "ltr")])),
  (%cx("clear: none"), CssJs.style(. [CssJs.unsafe("clear", "none")])),
  (%cx("box-sizing: content-box"), CssJs.style(. [CssJs.boxSizing(#contentBox)])),
  (%cx("box-sizing: border-box"), CssJs.style(. [CssJs.boxSizing(#borderBox)])),
  (
    %cx("font-family: 'Open Sans', '-system', sans-serif"),
    CssJs.style(. [CssJs.unsafe("fontFamily", "'Open Sans', '-system', sans-serif")]),
  ),
  (%cx("flex-flow: row wrap"), CssJs.style(. [CssJs.flexDirection(#row), CssJs.flexWrap(#wrap)])),
  (
    %cx("flex: 1 2 content"),
    CssJs.style(. [CssJs.flexGrow(1.), CssJs.flexShrink(2.), CssJs.flexBasis(#content)]),
  ),
  (%cx("flex: unset"), CssJs.style(. [CssJs.unsafe("flex", "unset")])),
  (%cx("width: auto"), CssJs.style(. [CssJs.width(#auto)])),
  /*
  (
    [%cx "width: 0"],
    CssJs.style(. [|CssJs.width(`zero)|])
  ),
 */
  (%cx("height: 5px"), CssJs.style(. [CssJs.height(#pxFloat(5.))])),
  (%cx("min-width: 5%"), CssJs.style(. [CssJs.minWidth(#percent(5.))])),
  (%cx("min-height: 5em"), CssJs.style(. [CssJs.minHeight(#em(5.))])),
  (%cx("max-width: none"), CssJs.style(. [CssJs.maxWidth(#none)])),
  (%cx("max-height: 3vh"), CssJs.style(. [CssJs.maxHeight(#vh(3.))])),
  (%cx("box-sizing: border-box"), CssJs.style(. [CssJs.boxSizing(#borderBox)])),
  (%cx("opacity: 0.5"), CssJs.style(. [CssJs.opacity(0.5)])),
  (%cx("opacity: 60%"), CssJs.style(. [CssJs.opacity(0.6)])),
  (%cx("object-fit: fill"), CssJs.style(. [CssJs.objectFit(#fill)])),
  (
    %cx("object-position: right bottom"),
    CssJs.style(. [CssJs.objectPosition(#hv(#right, #bottom))]),
  ),
  (%cx("text-overflow: clip"), CssJs.style(. [CssJs.unsafe("textOverflow", "clip")])),
  (%cx("text-overflow: ellipsis"), CssJs.style(. [CssJs.unsafe("textOverflow", "ellipsis")])),
  (%cx("text-transform: capitalize"), CssJs.style(. [CssJs.textTransform(#capitalize)])),
  (%cx("white-space: break-spaces"), CssJs.style(. [CssJs.whiteSpace(#breakSpaces)])),
  (%cx("word-break: keep-all"), CssJs.style(. [CssJs.wordBreak(#keepAll)])),
  (%cx("overflow-wrap: anywhere"), CssJs.style(. [CssJs.overflowWrap(#anywhere)])),
  (%cx("word-wrap: normal"), CssJs.style(. [CssJs.wordWrap(#normal)])),
  (%cx("text-align: left"), CssJs.style(. [CssJs.textAlign(#left)])),
  (%cx("word-spacing: normal"), CssJs.style(. [CssJs.wordSpacing(#normal)])),
  (%cx("word-spacing: 5px"), CssJs.style(. [CssJs.wordSpacing(#pxFloat(5.))])),
  (%cx("letter-spacing: normal"), CssJs.style(. [CssJs.letterSpacing(#normal)])),
  (%cx("letter-spacing: 5px"), CssJs.style(. [CssJs.letterSpacing(#pxFloat(5.))])),
  (%cx("text-indent: 5%"), CssJs.style(. [CssJs.textIndent(#percent(5.))])),
  (%cx("background: blue;"), CssJs.style(. [CssJs.backgroundColor(CssJs.blue)])),
  (%cx("text-transform: uppercase;"), CssJs.style(. [CssJs.textTransform(#uppercase)])),
  (%cx("line-height: 1.4;"), CssJs.style(. [CssJs.unsafe("lineHeight", "1.4")])),
  (%cx("line-height: 100%;"), CssJs.style(. [CssJs.unsafe("lineHeight", "100%")])),
  (%cx("grid-gap: 20px;"), CssJs.style(. [CssJs.unsafe("gridGap", "20px")])),
  /* [%cx "-moz-text-blink: blink"], */
  /* [%cx "display: -webkit-inline-box"], */
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
  test(string_of_int(index), () => Expect.expect(cssIn) |> Expect.toMatch(emotionOut))
)
