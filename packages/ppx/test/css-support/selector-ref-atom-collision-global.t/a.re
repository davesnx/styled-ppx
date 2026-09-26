/* Module A: a bare `$(row)` selector reference inside [%styled.global],
   same local binding name and selector shape as B, different content. */
let row = [%css "color: red"];
module Globals = [%styled.global {|
  .$(row) { cursor: pointer; }
|}];
