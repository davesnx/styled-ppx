let wrapper = [%css {|
  &.$(Css.marker) { color: blue; }
|}];

module Css = {
  let marker = [%css {| color: red; |}];
};

let _ = (wrapper, Css.marker);
