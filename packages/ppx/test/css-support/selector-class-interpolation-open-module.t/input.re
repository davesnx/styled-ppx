module Css = {
  let marker = [%css {| color: red; |}];
};

open Css;
let _ = marker;

let wrapper = [%css {|
  &.$(marker) { color: blue; }
|}];

let _ = (Css.marker, wrapper);
