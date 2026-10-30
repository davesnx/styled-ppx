/* Module B: same shape as A, [row] carries different content. */
let row = [%css "color: blue"];
module Globals = [%styled.global {|
  .$(row) { cursor: pointer; }
|}];
