/* Module A: [row] is a local [%css] binding referenced from [list]'s
   selector twice - once nested under a descendant compound
   (`.$(row)` on `div:not(:last-child)`) and once attached directly to
   `&` (`&.$(row)`). Both shapes resolve [row]'s reference to A's own
   identity class. */
let row = [%css "color: red"];
let list = [%css
  {|
  & > div:not(:last-child).$(row) { display: flex; }
  &.$(row) { cursor: pointer; }
|}
];
