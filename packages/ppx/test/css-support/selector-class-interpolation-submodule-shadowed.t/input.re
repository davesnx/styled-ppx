module Css = {
  let marker = [%css {| color: red; |}];
  let _ = marker;

  let marker = [%css {| color: green; |}];
};

let wrapper = [%css {|
  &.$(Css.marker) { color: blue; }
|}];

let _ = (Css.marker, wrapper);
