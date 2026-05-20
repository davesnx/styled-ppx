/* Top-level bare leading `:hover` is rejected with a precise error
   pointing at the bad selector. */
let _x = [%cx2 {|
  :hover { color: red; }
|}];
