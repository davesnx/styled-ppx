(* [%styled.global] must flatten CSS-nesting before emit. Native CSS
   nesting works in modern browsers but isn't always polyfilled, so the
   safer ground-truth is to lower nested rules to flat selectors at PPX
   time. *)

(* Single-selector nesting: `body { .child { ... } }` -> `body .child { ... }` *)
module Single =
  [%styled.global
  {|
  body {
    color: red;
    .child {
      color: blue;
    }
  }
|}]

(* Multi-selector parent fans out to one rule per parent. *)
module Multi =
  [%styled.global
  {|
  body, html {
    .child { color: red; }
  }
|}]

(* Cartesian product: parent multi-list × child multi-list. *)
module Cartesian =
  [%styled.global
  {|
  .a, .b {
    .c, .d { color: green; }
  }
|}]

(* Pseudo-class joins onto the parent without an intervening space. *)
module PseudoJoin =
  [%styled.global
  {|
  .button {
    color: black;
    &:hover {
      color: white;
    }
  }
|}]
