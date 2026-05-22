module Styles = M.Css;

let wrapper = [%css {|
  &.$(Styles.marker) { color: blue; }
|}];
