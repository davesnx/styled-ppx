  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  let className =
    CSS.style([|CSS.label("className"), CSS.display(`block)|]);
  let classNameWithMultiLine =
    CSS.style([|
      CSS.label("classNameWithMultiLine"),
      CSS.display(`block),
    |]);
  let classNameWithArray =
    CSS.style([|CSS.label("classNameWithArray"), cssProperty|]);
  let cssRule = CSS.color(CSS.blue);
  let classNameWithCss =
    CSS.style([|
      CSS.label("classNameWithCss"),
      cssRule,
      CSS.backgroundColor(CSS.green),
    |]);
