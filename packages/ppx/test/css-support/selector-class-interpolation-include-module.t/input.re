module Css = {
  let marker = [%css {| color: red; |}];
};

include Css;

let wrapper = [%css {|
  &.$(marker) { color: blue; }
|}];

let _ = (Css.marker, wrapper);
