open Jest;

let testData = [
  (
    ">",
    [%cx "& > a { color: green; }"],
    CssJs.style(.
      [|
        CssJs.selector(
          {js|& > a|js},
          [| CssJs.color(CssJs.green) |]
        )
      |]
    ),
  ),
  (
    "nth-child(even)",
    [%cx "&:nth-child(even) { color: red; }"],
    CssJs.style(.
      [|
        CssJs.selector(
          {js|&:nth-child(even)|js},
          [|CssJs.color(CssJs.red)|]
        )
      |]
    ),
  ),
  (
    "nth-child(3n+1)",
    [%cx "& > div:nth-child(3n+1) { color: blue; }"],
    CssJs.style(.
      [|
        CssJs.selector(
          {js|& > div:nth-child(3n  + 1)|js},
          [|CssJs.color(CssJs.blue)|],
        ),
      |]
    ),
  ),
  (
    "::active",
    [%cx "&::active { color: brown; }"],
    CssJs.style(.
      [|CssJs.active([|CssJs.color(CssJs.brown)|])|],
    )
  ),
  (
    ":hover",
    [%cx "&:hover { color: gray; }"],
    CssJs.style(. [|CssJs.hover([|CssJs.color(CssJs.gray)|])|]),
  ),
  (
    "& + &",
    [%cx "& + & { margin: 10px; }"],
    CssJs.style(. [|
      CssJs.selector(
        {js|& + &|js},
        [|CssJs.margin(CssJs.px(10))|]
      )
    |]),
  ),
  (
    "& span",
    [%cx "& span { color: red; }"],
    CssJs.style(. [|
      CssJs.selector(
        {js|& span|js},
        [|CssJs.color(CssJs.red)|]),
    |],
    )
  ),

  /* (
    "*:not(:last-child)",
    [%cx "& > *:not(:last-child) { margin: 10px; }"],
    CssJs.style(. [|
      CssJs.selector(
        {js|& > *:not(:last-child)|js},
        [|CssJs.margin(CssJs.px(10))|]
      )
    |]),
  ) */
];

describe("Selectors", _ => {
  Belt.List.forEachWithIndex(testData, (index, (name, cssIn, emotionOut)) => {
    test(string_of_int(index) ++ ". Supports " ++ name, () => {
      Expect.expect(cssIn) |> Expect.toMatch(emotionOut);
    });
  });
});
