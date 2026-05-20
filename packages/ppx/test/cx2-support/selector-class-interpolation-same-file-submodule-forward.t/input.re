let wrapper = [%cx2 {|
  &.$(Css.marker) { color: blue; }
|}];

module Css = {
  let marker = [%cx2 {| color: red; |}];
};

let _ = (wrapper, Css.marker);
