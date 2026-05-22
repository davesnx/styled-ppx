module Css = {
  let marker = [%css {| color: red; |}];
};

module Styles = Css;

let wrapper = [%css {|
  &.$(Styles.marker) { color: blue; }
|}];

module Theme = {
  module Css = {
    let marker = [%css {| color: green; |}];
  };

  module Styles = Css;

  let wrapper = [%css {|
    &.$(Styles.marker) { color: purple; }
  |}];
};

let _ = (Css.marker, wrapper, Theme.Css.marker, Theme.wrapper);
