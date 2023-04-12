  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  let className = css([label("className"), CssJs.block(`blue)]);
  let foo = css([label("foo"), prop("1"), prop("2")]);
  let bar = (~x) => css([label("bar"), prop(x)]);
  let baz = (~x, ~y) => css([label("baz"), prop(x), prop(y)]);
  let empty = css([label("empty")]);
  type t =
    | A
    | B;
  let fn1 = x =>
    css([
      label("fn1"),
      ...switch (x) {
         | A => [prop("a")]
         | B => [prop("b")]
         },
    ]);
  let fn2 = (x, y) =>
    css([
      label("fn2"),
      ...switch (x) {
         | A when y => [prop("ay")]
         | A => [prop("a")]
         | B when y => [prop("by")]
         | B => [prop("b")]
         },
    ]);
