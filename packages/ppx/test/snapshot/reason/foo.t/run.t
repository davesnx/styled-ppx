  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  let css = main =>
    CSS.style([|
      (CSS.color(main): CSS.rule),
      CSS.backgroundColor(CSS.black),
      CSS.display(`flex),
    |]);
  <div style={css(CSS.red)} />;
