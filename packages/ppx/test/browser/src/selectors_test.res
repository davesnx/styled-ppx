open Jest

module Variables = {
  let element = "p"
  let pseudoclass = "active"
  let pseudoelement = "before"
  let selector = "button:hover"
  let selector_query = "button > p"
  let target = "target"
  let href_target = "\"https\""
  let pseudo = "& + &"
}

let testData = [
  (
    ">",
    %cx("& > a { color: green; }"),
    CssJs.style(. [CssJs.selector(. `& > a`, [CssJs.color(CssJs.green)])]),
  ),
  (
    "nth-child(even)",
    %cx("&:nth-child(even) { color: red; }"),
    CssJs.style(. [CssJs.selector(. `&:nth-child(even)`, [CssJs.color(CssJs.red)])]),
  ),
  (
    "nth-child(3n+1)",
    %cx("& > div:nth-child(3n+1) { color: blue; }"),
    CssJs.style(. [CssJs.selector(. `& > div:nth-child(3n + 1)`, [CssJs.color(CssJs.blue)])]),
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
    "& span",
    %cx("& span { color: red; }"),
    CssJs.style(. [CssJs.selector(. `& span`, [CssJs.color(CssJs.red)])]),
  ),
  (
    "& p:not(.active)",
    %cx("& p:not(.active) { display: none; }"),
    CssJs.style(. [CssJs.selector(. `& p:not(.active)`, [CssJs.display(#none)])]),
  ),
  (
    "& input[type=\"password\"]",
    %cx("& input[type=\"password\"] { border: 1px solid red; } "),
    CssJs.style(. [
      CssJs.selector(.
        `& input[type = "password"]`,
        [CssJs.border(#pxFloat(1.), #solid, CssJs.red)],
      ),
    ]),
  ),
  (
    "& button:hover",
    %cx("& button:hover { cursor: pointer; } "),
    CssJs.style(. [CssJs.selector(. `& button:hover`, [CssJs.unsafe("cursor", "pointer")])]),
  ),
  (
    "& $(Variables.selector_query)",
    %cx("& $(Variables.selector_query) { color: blue }"),
    CssJs.style(. [CssJs.selector(. `& button > p`, [CssJs.color(CssJs.blue)])]),
  ),
  (
    "a[$(Variabels.target)]",
    %cx("a[$(Variables.target)] { color: blue }"),
    CssJs.style(. [CssJs.selector(. `a[target]`, [CssJs.color(CssJs.blue)])]),
  ),
  (
    "a[href^=$(Variables.href_target)]",
    %cx("a[href^=$(Variables.href_target)] { color: blue }"),
    CssJs.style(. [CssJs.selector(. `a[href^="https"]`, [CssJs.color(CssJs.blue)])]),
  ),
  (
    "$(Variables.pseudo)",
    %cx("$(Variables.pseudo) {color: blue}"),
    CssJs.style(. [CssJs.selector(. `& + &`, [CssJs.color(CssJs.blue)])]),
  ),
  (
    "div > $(Variables.element)",
    %cx("div > $(Variables.element) {color: blue}"),
    CssJs.style(. [CssJs.selector(. `div > p`, [CssJs.color(CssJs.blue)])]),
  ),
  (
    "&:$(Variables.pseudoclass)",
    %cx("&:$(Variables.pseudoclass) {color: blue}"),
    CssJs.style(. [CssJs.selector(. `&:active`, [CssJs.color(CssJs.blue)])]),
  ),
  (
    "&::$(Variables.pseudoelement)",
    %cx("&::$(Variables.pseudoelement) {color: blue}"),
    CssJs.style(. [CssJs.selector(. `&::before`, [CssJs.color(CssJs.blue)])]),
  ),
]

describe("Selectors", _ =>
  Belt.Array.forEachWithIndex(testData, (index, (name, cssIn, emotionOut)) =>
    test(string_of_int(index) ++ (". Supports " ++ name), () =>
      Expect.expect(cssIn) |> Expect.toMatch(emotionOut)
    )
  )
)
