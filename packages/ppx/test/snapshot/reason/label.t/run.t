  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  let className = css([CssJs.label("className"), CssJs.block(`blue)]);
  let foo = css([CssJs.label("foo"), prop("1"), prop("2")]);
  let bar = (~x) => css([CssJs.label("bar"), prop(x)]);
  let baz = (~x, ~y) => css([CssJs.label("baz"), prop(x), prop(y)]);
  let empty = css([CssJs.label("empty")]);
  type t =
    | A
    | B;
  let fn1 = x =>
    css([
      CssJs.label("fn1"),
      ...switch (x) {
         | A => [prop("a")]
         | B => [prop("b")]
         },
    ]);
  let fn2 = (x, y) =>
    css([
      CssJs.label("fn2"),
      ...switch (x) {
         | A when y => [prop("ay")]
         | A => [prop("a")]
         | B when y => [prop("by")]
         | B => [prop("b")]
         },
    ]);
