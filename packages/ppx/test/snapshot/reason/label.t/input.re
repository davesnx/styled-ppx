let className = [%css_label [CssJs.block(`blue)]];
let foo = [%css_label [prop("1"), prop("2")]];
let bar = (~x) => [%css_label [prop(x)]];
let baz = (~x, ~y) => [%css_label [prop(x), prop(y)]];
let empty = [%css_label []];

type t =
  | A
  | B;

let fn1 = x =>
  switch%css_label (x) {
  | A => [prop("a")]
  | B => [prop("b")]
  };

let fn2 = (x, y) =>
  switch%css_label (x) {
  | A when y => [prop("ay")]
  | A => [prop("a")]
  | B when y => [prop("by")]
  | B => [prop("b")]
  };
