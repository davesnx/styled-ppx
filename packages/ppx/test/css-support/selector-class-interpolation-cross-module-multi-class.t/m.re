/* Module M's marker has multiple declarations, so [%css] atomizes
   it into multiple class names. Cross-module references must produce
   a chained compound (.cssA.cssB) so consumers match on every atom. */
let marker = [%css {|
  background: red;
  color: white;
|}];
