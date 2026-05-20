module Css = {
  let marker = [%cx2 {| color: red; |}];
  let _ = marker;

  let marker = [%cx2 {| color: green; |}];
};

let wrapper = [%cx2 {|
  &.$(Css.marker) { color: blue; }
|}];

let _ = (Css.marker, wrapper);
