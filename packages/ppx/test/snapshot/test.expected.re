let className =
  CssJs.style(. [|
    CssJs.label("className"),
    CssJs.display(`block),
    (CssJs.color(colorito): CssJs.rule),
  |]);
