module Css = {
  let marker = "external-marker";
};

let wrapper = [%cx2 {|
  &.$(Css.marker) { color: blue; }
|}];

let _ = (Css.marker, wrapper);
