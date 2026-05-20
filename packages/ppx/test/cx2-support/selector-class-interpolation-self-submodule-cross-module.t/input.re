module Css = {
  let marker = [%cx2 {| color: red; |}];

  let wrapper = [%cx2 {|
    &.$(Css.marker) { color: blue; }
  |}];
};

let _ = (Css.marker, Css.wrapper);
