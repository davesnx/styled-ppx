module Css = {
  let marker = [%cx2 {| color: red; |}];
};

module Styles = Css;

let wrapper = [%cx2 {|
  &.$(Styles.marker) { color: blue; }
|}];

module Theme = {
  module Css = {
    let marker = [%cx2 {| color: green; |}];
  };

  module Styles = Css;

  let wrapper = [%cx2 {|
    &.$(Styles.marker) { color: purple; }
  |}];
};

let _ = (Css.marker, wrapper, Theme.Css.marker, Theme.wrapper);
