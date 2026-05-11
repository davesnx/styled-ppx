/* Bare leading pseudo nested under a class outer is rejected too —
   the descendant-join footgun applies at any depth, not just the top
   level. The error fires at the inner `:hover`, with its own location. */
let _x = [%cx2 {|
  .outer {
    :hover { color: red; }
  }
|}];
