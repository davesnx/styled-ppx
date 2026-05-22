/* Shadowing in OCaml: the second `let foo = ...` shadows the first.
   Selector resolution should pick up the most recent binding visible at
   the reference site (last-write-wins in the registry). */

let foo = [%css {| color: red; |}];
let _ = foo;

let foo = [%css {| color: blue; |}];

let bar = [%css {|
  &.$(foo) { font-weight: bold; }
|}];

let _ = (foo, bar);
