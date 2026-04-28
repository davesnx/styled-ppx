/* Cross-module class-name interpolation in [%cx2] selectors is not
   supported because static extraction only sees the current compilation
   unit's [%cx2] bindings. The PPX should error with a clear message. */

let bad = [%cx2 {|
  &.$(SomeOtherModule.foo) { color: red; }
|}];

let _ = bad;
