/* Cross-binding selector interpolation `$(name)` resolves through
   `Class_registry`, which is independent of `Dev_mode.marker`. The
   resolved selectors and the extracted CSS must be byte-identical
   regardless of --dev. The marker only ever lands inside the runtime
   className string (the first arg to CSS.make); it never leaks into
   selectors or extracted [@css ...] payloads. */

let foo = [%cx2 {| color: red; |}];

let bar = [%cx2 {|
  &.$(foo) { color: blue; }
|}];

let _ = (foo, bar);
