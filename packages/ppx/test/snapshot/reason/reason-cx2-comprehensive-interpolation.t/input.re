/* Comprehensive test for cx2 interpolation with various property types */

let lengthVar = CSS.px(10);
let colorVar = CSS.red;
let percentVar = CSS.pct(50.0);
let autoVar = `auto;

/* Test 1: Basic length properties */
let test1 = [%cx2
  {|
  width: $(lengthVar);
  height: $(lengthVar);
  min-width: $(lengthVar);
  max-width: $(lengthVar);
|}
];

/* Test 2: Margin and padding */
let test2 = [%cx2
  {|
  margin-top: $(lengthVar);
  margin-bottom: $(lengthVar);
  padding-left: $(lengthVar);
  padding-right: $(lengthVar);
|}
];

/* Test 3: Gap properties */
let test3 = [%cx2
  {|
  gap: $(lengthVar);
  row-gap: $(lengthVar);
  column-gap: $(lengthVar);
|}
];

/* Test 4: Color properties */
let test4 = [%cx2
  {|
  color: $(colorVar);
  background-color: $(colorVar);
  border-top-color: $(colorVar);
|}
];

/* Test 5: Flex properties */
let flexBasisVar = CSS.px(100);
let test5 = [%cx2 {|
  flex-basis: $(flexBasisVar);
|}];

/* Test 6: Grid properties */
let gridLineVar = `auto;
let test6 = [%cx2
  {|
  grid-row-start: $(gridLineVar);
  grid-column-end: $(gridLineVar);
|}
];

/* Test 7: Positioning (top/bottom/left/right accept length values) */
let topVar = CSS.px(20);
let test7 = [%cx2 {|
  top: $(topVar);
  bottom: $(topVar);
|}];

/* Test 8: Z-index */
let zIndexVar = `num(10);
let test8 = [%cx2 {|
  z-index: $(zIndexVar);
|}];

/* Test 9: Border width (LineWidth) */
let borderWidthVar = `medium;
let test9 = [%cx2
  {|
  border-top-width: $(borderWidthVar);
  border-width: $(borderWidthVar);
|}
];

/* Test 10: Text spacing properties (accept length values) */
let spacingVar = CSS.px(2);
let test10 = [%cx2
  {|
  letter-spacing: $(spacingVar);
  word-spacing: $(spacingVar);
|}
];

/* Test 11: Mixed static and interpolated */
let test11 = width => [%cx2
  {|
  width: $(width);
  height: 100px;
  color: red;
|}
];
