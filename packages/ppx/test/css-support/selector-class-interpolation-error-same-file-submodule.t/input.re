module Css = {
  let marker = [%css {| color: red; |}];
  let notCx2 = "plain-string-selector";
};

let wrapper = [%css {|
  &.$(Css.notCx2) { color: blue; }
|}];

let _ = (Css.marker, Css.notCx2, wrapper);
