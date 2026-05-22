/* Forward references error the same as undefined: the registry is
   populated as the PPX expands top-to-bottom, so a `$(b)` reference must
   come AFTER `let b = [%css ...]`. The error message should be the same
   "not bound earlier in this module" message; users can fix this by
   reordering the bindings. */

let a = [%css {|
  &.$(b) { color: red; }
|}];

let b = [%css {| color: blue; |}];

let _ = (a, b);
