/* When `$(name)` resolves to a [%css] binding whose RHS contained multiple
   declarations, atomization mints multiple class names. The selector
   substitution must chain them as a compound (`.cssA.cssB`) so the
   selector matches only elements that have ALL atomized classes applied -
   matching the runtime semantics where every consumer of the binding
   gets all the classes. */

let composed = [%css {|
  display: flex;
  gap: 1rem;
|}];

let user = [%css {|
  &.$(composed) { color: red; }
|}];

let _ = (composed, user);
