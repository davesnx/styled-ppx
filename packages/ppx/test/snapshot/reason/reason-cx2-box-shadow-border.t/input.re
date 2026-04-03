/* Static box-shadow and border tests for cx2 extraction */

/* === STATIC BOX-SHADOW TESTS === */

/* Test 1: Simple box-shadow with all 4 values */
let simpleShadow = [%cx2 "box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.1);"];

/* Test 2: Multiple box-shadows */
let multipleShadows = [%cx2
  {|
  box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.1), 0px 4px 8px 0px rgba(0, 0, 0, 0.2);
|}
];

/* Test 3: Inset box-shadow */
let insetShadow = [%cx2
  "box-shadow: inset 0px 2px 4px 0px rgba(0, 0, 0, 0.1);"
];

/* Test 4: box-shadow none */
let noShadow = [%cx2 "box-shadow: none;"];

/* Test 5: Complex box-shadow with spread */
let spreadShadow = [%cx2
  "box-shadow: 0px 4px 6px -1px rgba(0, 0, 0, 0.1), 0px 2px 4px -2px rgba(0, 0, 0, 0.1);"
];

/* === STATIC BORDER TESTS === */

/* Test 6: Simple border */
let simpleBorder = [%cx2 "border: 1px solid black;"];

/* Test 7: Border with color */
let borderWithColor = [%cx2 "border: 2px dashed #ff0000;"];

/* Test 8: Border with transparent */
let borderTransparent = [%cx2 "border: 1px solid transparent;"];

/* Test 9: Border none */
let noBorder = [%cx2 "border: none;"];

/* Test 10: Border with different styles */
let borderStyles = [%cx2
  {|
  border-top: 1px solid red;
  border-right: 2px dashed blue;
  border-bottom: 3px dotted green;
  border-left: 4px double orange;
|}
];

/* Test 11: Border width/style/color separate */
let borderSeparate = [%cx2
  {|
  border-width: 2px;
  border-style: solid;
  border-color: #333;
|}
];

/* Test 12: Border radius with border */
let borderWithRadius = [%cx2
  {|
  border: 1px solid #ccc;
  border-radius: 8px;
|}
];

/* === COMBINED TESTS === */

/* Test 13: Combined box-shadow and border */
let shadowAndBorder = [%cx2
  {|
  box-shadow: 0px 4px 6px 0px rgba(0, 0, 0, 0.1);
  border: 1px solid #e5e7eb;
  border-radius: 12px;
|}
];

/* Test 14: Card-like styling */
let cardStyle = [%cx2
  {|
  box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.1), 0px 1px 2px -1px rgba(0, 0, 0, 0.1);
  border: 1px solid rgba(0, 0, 0, 0.05);
  border-radius: 16px;
|}
];

/* Test 15: Button styling */
let buttonBase = [%cx2
  {|
  border: 2px solid #3b82f6;
  box-shadow: 0px 0px 0px 0px rgba(59, 130, 246, 0.5);
  border-radius: 8px;
|}
];

/* === INTERPOLATION TESTS === */

/* Test 16: Border with interpolated color (partial interpolation) */
let borderColorInterp = borderColor => [%cx2
  "border: 1px solid $(borderColor);"
];

/* Test 17: Box-shadow with interpolated values */
let shadowInterp = (shadowX, shadowY, blur, spread, shadowColor) => [%cx2
  "box-shadow: $(shadowX) $(shadowY) $(blur) $(spread) $(shadowColor);"
];

/* Test 18: Box-shadow full interpolation */
let shadowFullInterp = myShadow => [%cx2 "box-shadow: $(myShadow);"];

/* Test 19: Border with interpolated width (partial interpolation) */
let borderWidthInterp = borderWidth => [%cx2
  "border: $(borderWidth) solid black;"
];

/* Test 20: Mixed static and interpolated */
let mixedCard = (bgColor, borderColor, shadow) => [%cx2
  {|
  background-color: $(bgColor);
  border: 1px solid $(borderColor);
  box-shadow: $(shadow);
  border-radius: 12px;
|}
];
