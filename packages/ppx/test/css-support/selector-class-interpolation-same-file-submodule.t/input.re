module Css = {
  let marker = [%css {| color: red; |}];

  let wrapper = [%css {|
    &.$(marker) { color: orange; }
  |}];
};

let wrapper = [%css {|
  &.$(Css.marker) { font-weight: bold; }
|}];

module Theme = {
  module Css = {
    let marker = [%css {| color: green; |}];
  };

  module Components = {
    let wrapper = [%css {|
      &.$(Css.marker) { color: blue; }
    |}];
  };
};

let _ = (
  Css.marker,
  Css.wrapper,
  wrapper,
  Theme.Css.marker,
  Theme.Components.wrapper,
);
