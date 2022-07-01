open Jest

module Variables = {
  let element = "p"
  let pseudoclass = "active"
  let pseudoelement = "before"
  let selector = "button:hover"
  let selector_query = "button > p"
  let target = "target"
  let href_target = "\"https\""
}

let pseudo = "& + &"

let testData = [
  (
    "& > a",
    %cx("& > a { color: green; }"),
    CssJs.style(. [CssJs.selector(. `& > a`, [CssJs.color(CssJs.green)])]),
  ),
  (
    ":active",
    %cx("&:active { color: brown; }"),
    CssJs.style(. [CssJs.active([CssJs.color(CssJs.brown)])]),
  ),
  (
    ":hover",
    %cx("&:hover { color: gray; }"),
    CssJs.style(. [CssJs.hover([CssJs.color(CssJs.gray)])]),
  ),
  (
    "& + &",
    %cx("& + & { margin: 10px; }"),
    CssJs.style(. [CssJs.selector(. `& + &`, [CssJs.margin(CssJs.px(10))])]),
  ),
  (
    "& $(Variables.selector_query)",
    %cx("& $(Variables.selector_query) { color: blue }"),
    CssJs.style(. [CssJs.selector(. `& button > p`, [CssJs.color(CssJs.blue)])]),
  ),
  (
    "$(pseudo)",
    %cx("$(pseudo) {color: blue}"),
    CssJs.style(. [CssJs.selector(. `& + &`, [CssJs.color(CssJs.blue)])]),
  ),
]

describe("Selectors", _ =>
  Belt.Array.forEachWithIndex(testData, (index, (name, cssIn, emotionOut)) =>
    test(string_of_int(index) ++ (". Supports " ++ name), () =>
      Expect.expect(cssIn) |> Expect.toMatch(emotionOut)
    )
  )
)
