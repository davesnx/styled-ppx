/* Forward references error the same as undefined: the registry is
   populated as the PPX expands top-to-bottom, so a `$(b)` reference must
   come AFTER `let b = [%cx2 ...]`. The error message should be the same
   "not bound earlier in this module" message; users can fix this by
   reordering the bindings. */

let a = [%cx2 {|
  &.$(b) { color: red; }
|}];

let b = [%cx2 {| color: blue; |}];

let _ = (a, b);
