module Css = {
  let marker = [%cx2 {| color: red; |}];
};

open Css;
let _ = marker;

let wrapper = [%cx2 {|
  &.$(marker) { color: blue; }
|}];

let _ = (Css.marker, wrapper);
