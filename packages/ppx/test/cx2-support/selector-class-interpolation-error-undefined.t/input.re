/* `$(name)` in selector position requires `name` to be a [%cx2] binding
   in the same module. A plain string binding doesn't qualify and must
   error clearly. */

let undefined = "css-foo";

let bad = [%cx2 {|
  &.$(undefined) { color: red; }
|}];

let _ = (undefined, bad);
