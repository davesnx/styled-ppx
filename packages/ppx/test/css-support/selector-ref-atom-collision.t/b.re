/* Module B: same local binding name and the same two selector shapes as
   A, but [row] carries different content, so B's [row] must resolve to
   a DIFFERENT identity class than A's. */
let row = [%css "color: blue"];
let list = [%css
  {|
  & > div:not(:last-child).$(row) { display: flex; }
  &.$(row) { cursor: pointer; }
|}
];
