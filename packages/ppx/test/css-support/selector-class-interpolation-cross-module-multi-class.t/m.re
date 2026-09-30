/* Module M's marker has multiple declarations, so [%css] atomizes it into
   multiple class names. A cross-module reference resolves to `marker`'s
   identity class regardless - "carries this binding", not "carries these
   exact atoms" - so consumers match on the identity alone. */
let marker = [%css {|
  background: red;
  color: white;
|}];
