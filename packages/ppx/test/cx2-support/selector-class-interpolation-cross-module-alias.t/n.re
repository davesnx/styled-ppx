module Styles = M.Css;

let wrapper = [%cx2 {|
  &.$(Styles.marker) { color: blue; }
|}];
