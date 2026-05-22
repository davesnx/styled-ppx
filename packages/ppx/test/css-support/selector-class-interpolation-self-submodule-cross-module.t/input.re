module Css = {
  let marker = [%css {| color: red; |}];

  let wrapper = [%css {|
    &.$(Css.marker) { color: blue; }
  |}];
};

let _ = (Css.marker, Css.wrapper);
