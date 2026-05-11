/* Module M's marker has multiple declarations, so [%cx2] atomizes
   it into multiple class names. Cross-module references must produce
   a chained compound (.cssA.cssB) so consumers match on every atom. */
let marker = [%cx2 {|
  background: red;
  color: white;
|}];
