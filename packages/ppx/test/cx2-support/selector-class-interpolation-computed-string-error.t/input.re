let suffix = "marker";
let marker = "external-" ++ suffix;

let wrapper = [%cx2 {|
  &.$(marker) { color: blue; }
|}];

let _ = (marker, wrapper);
