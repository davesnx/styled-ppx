/* Earlier string literal bindings are valid static selector refs. */

let undefined = "css-foo";

let bad = [%cx2 {|
  &.$(undefined) { color: red; }
|}];

let _ = (undefined, bad);
