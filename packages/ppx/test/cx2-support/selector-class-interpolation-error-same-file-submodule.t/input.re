module Css = {
  let marker = [%cx2 {| color: red; |}];
  let notCx2 = "plain-string-selector";
};

let wrapper = [%cx2 {|
  &.$(Css.notCx2) { color: blue; }
|}];

let _ = (Css.marker, Css.notCx2, wrapper);
