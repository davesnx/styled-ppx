/* Top-level bare leading `::after` (pseudo-element) is rejected. */
let _x = [%cx2 {|
  ::after { content: "*"; }
|}];
