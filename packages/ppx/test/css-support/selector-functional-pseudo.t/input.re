/* Functional pseudo-elements (`::part()`, `::slotted()`, and any other
   identifier the lexer tokenizes as a function, since only nth-* names get
   their own token) and the Selectors Level 4 "of S" form of
   `:nth-child()`/`:nth-last-child()` were both unparseable
   (.workplace/docs/parser-audit-defects.md #7, #8). */

let _part = [%css
  {|
  &::part(foo) { color: red; }
|}
];

let _slotted = [%css
  {|
  &::slotted(.bar) { color: blue; }
|}
];

let _nth_child_of = [%css
  {|
  &:nth-child(2n+1 of .x) { color: green; }
|}
];

let _nth_last_child_of_list = [%css
  {|
  &:nth-last-child(odd of .a, .b) { color: yellow; }
|}
];
