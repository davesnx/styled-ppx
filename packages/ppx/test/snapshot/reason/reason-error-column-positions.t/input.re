/* Test error column positions are accurate */

/* Single line with error in value */
let test1 = [%cx "display: fley"];

/* Error should point to the value, not the property */
let test2 = [%cx "color: reed"];

/* Multi-line with indentation */
let test3 = [%cx {|
    display: fley;
|}];

/* Multiple properties on same line */
let test4 = [%cx "color: red; display: fley; padding: 10px"];

/* Error in middle of line */
let test5 = [%cx {|
  color: red;
  background: reed;
  padding: 10px;
|}];

/* Very long property value with error at end */
let test6 = [%cx
  "box-shadow: 0 0 10px 5px rgba(0, 0, 0, 0.5), inset 0 0 5px fley"
];

/* Error in shorthand property */
let test7 = [%cx "margin: 10px fley 20px 30px"];

/* Error with !important */
let test8 = [%cx "display: fley !important"];

/* Error in function value */
let test9 = [%cx "transform: rotate(fley)"];

/* Error in calc expression */
let test10 = [%cx "width: calc(100% - fley)"];
