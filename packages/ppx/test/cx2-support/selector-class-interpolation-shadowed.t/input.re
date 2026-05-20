/* Shadowing in OCaml: the second `let foo = ...` shadows the first.
   Selector resolution should pick up the most recent binding visible at
   the reference site (last-write-wins in the registry). */

let foo = [%cx2 {| color: red; |}];
let _ = foo;

let foo = [%cx2 {| color: blue; |}];

let bar = [%cx2 {|
  &.$(foo) { font-weight: bold; }
|}];

let _ = (foo, bar);
