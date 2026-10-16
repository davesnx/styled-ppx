/* A pseudo-class after `::before` is not a valid selector in any engine, so
   the browser drops the whole rule and it never matches. Rejected with the
   location of the selector and the fix. */
let _x = [%css {|
  &::before:hover { color: red; }
|}];
