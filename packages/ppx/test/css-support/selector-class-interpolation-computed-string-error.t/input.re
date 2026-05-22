let suffix = "marker";
let marker = "external-" ++ suffix;

let wrapper = [%css {|
  &.$(marker) { color: blue; }
|}];

let _ = (marker, wrapper);
