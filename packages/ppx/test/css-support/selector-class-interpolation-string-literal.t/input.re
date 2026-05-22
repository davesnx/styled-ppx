module Css = {
  let marker = "external-marker";
};

let wrapper = [%css {|
  &.$(Css.marker) { color: blue; }
|}];

let _ = (Css.marker, wrapper);
