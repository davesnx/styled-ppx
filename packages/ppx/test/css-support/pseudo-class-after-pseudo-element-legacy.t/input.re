/* The legacy single-colon spelling of a pseudo-element, followed by a
   pseudo-class, is dropped by every engine as well. */
let _x = [%css {|
  &:first-line:hover { color: red; }
|}];
