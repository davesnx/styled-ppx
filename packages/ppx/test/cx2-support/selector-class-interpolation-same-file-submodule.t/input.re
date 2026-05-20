module Css = {
  let marker = [%cx2 {| color: red; |}];

  let wrapper = [%cx2 {|
    &.$(marker) { color: orange; }
  |}];
};

let wrapper = [%cx2 {|
  &.$(Css.marker) { font-weight: bold; }
|}];

module Theme = {
  module Css = {
    let marker = [%cx2 {| color: green; |}];
  };

  module Components = {
    let wrapper = [%cx2 {|
      &.$(Css.marker) { color: blue; }
    |}];
  };
};

let _ =
  (Css.marker, Css.wrapper, wrapper, Theme.Css.marker, Theme.Components.wrapper);
