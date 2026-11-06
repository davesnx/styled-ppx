let m = [%css {||}];

let panel = [%css
  {|
  &.$(m) { color: green; }
  &.$(M.m) { color: red; }
  &.$(M.Inner.m) { color: blue; }
  &.$(Box.Box) { color: purple; }
|}
];
