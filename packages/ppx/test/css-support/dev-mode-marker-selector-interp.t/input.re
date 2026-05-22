/* Cross-binding selector interpolation `$(name)` resolves through
   `Local_selector_environment`, which is independent of `Dev_mode.marker`. The
   resolved selectors and the extracted CSS must be byte-identical
   regardless of --dev. The marker only ever lands inside the runtime
   className string (the first arg to CSS.make); it never leaks into
   selectors or extracted [@css ...] payloads. */

let foo = [%css {| color: red; |}];

let bar = [%css {|
  &.$(foo) { color: blue; }
|}];

let _ = (foo, bar);
