  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  let className =
    CssJs.style(. [|CssJs.label("className"), CssJs.display(`block)|]);
  let classNameWithMultiLine =
    CssJs.style(. [|
      CssJs.label("classNameWithMultiLine"),
      CssJs.display(`block),
    |]);
  let classNameWithArray =
    CssJs.style(. [|CssJs.label("classNameWithArray"), cssProperty|]);
  let cssRule = CssJs.color(CssJs.blue);
  let classNameWithCss =
    CssJs.style(. [|
      CssJs.label("classNameWithCss"),
      cssRule,
      CssJs.backgroundColor(CssJs.green),
    |]);
