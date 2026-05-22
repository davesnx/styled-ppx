/* Top-level bare leading `::after` (pseudo-element) is rejected. */
let _x = [%css {|
  ::after { content: "*"; }
|}];
