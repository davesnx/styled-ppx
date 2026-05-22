/* Comprehensive test for cx2 interpolation with various property types */

let lengthVar = CSS.px(10);
let colorVar = CSS.red;
let percentVar = CSS.pct(50.0);
let autoVar = `auto;

/* Test 1: Basic length properties */
let test1 = [%css
  {|
  width: $(lengthVar);
  height: $(lengthVar);
  min-width: $(lengthVar);
  max-width: $(lengthVar);
|}
];

/* Test 2: Margin and padding */
let test2 = [%css
  {|
  margin-top: $(lengthVar);
  margin-bottom: $(lengthVar);
  padding-left: $(lengthVar);
  padding-right: $(lengthVar);
|}
];

/* Test 3: Gap properties */
let test3 = [%css
  {|
  gap: $(lengthVar);
  row-gap: $(lengthVar);
  column-gap: $(lengthVar);
|}
];

/* Test 4: Color properties */
let test4 = [%css
  {|
  color: $(colorVar);
  background-color: $(colorVar);
  border-top-color: $(colorVar);
|}
];

/* Test 5: Flex properties */
let flexBasisVar = CSS.px(100);
let test5 = [%css {|
  flex-basis: $(flexBasisVar);
|}];

/* Test 6: Grid properties */
let gridLineVar = `auto;
let test6 = [%css
  {|
  grid-row-start: $(gridLineVar);
  grid-column-end: $(gridLineVar);
|}
];

/* Test 7: Positioning (top/bottom/left/right accept length values) */
let topVar = CSS.px(20);
let test7 = [%css {|
  top: $(topVar);
  bottom: $(topVar);
|}];

/* Test 8: Z-index */
let zIndexVar = `num(10);
let test8 = [%css {|
  z-index: $(zIndexVar);
|}];

/* Test 9: Border width (LineWidth) */
let borderWidthVar = `medium;
let test9 = [%css
  {|
  border-top-width: $(borderWidthVar);
  border-width: $(borderWidthVar);
|}
];

/* Test 10: Text spacing properties (accept length values) */
let spacingVar = CSS.px(2);
let test10 = [%css
  {|
  letter-spacing: $(spacingVar);
  word-spacing: $(spacingVar);
|}
];

/* Test 11: Mixed static and interpolated */
let test11 = width => [%css
  {|
  width: $(width);
  height: 100px;
  color: red;
|}
];
