module Css = {
  let marker = [%cx2 {| color: red; |}];
};

include Css;

let wrapper = [%cx2 {|
  &.$(marker) { color: blue; }
|}];

let _ = (Css.marker, wrapper);
