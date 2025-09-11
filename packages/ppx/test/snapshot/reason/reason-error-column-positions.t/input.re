/* Test error column positions are accurate */

/* Single line with error in value */
let test1 = [%cx2 "display: fley"];

/* Error should point to the value, not the property */
let test2 = [%cx2 "color: reed"];

/* Multi-line with indentation */
let test3 = [%cx2 {|
    display: fley;
|}];

/* Multiple properties on same line */
let test4 = [%cx2 "color: red; display: fley; padding: 10px"];

/* Error in middle of line */
let test5 = [%cx2 {|
  color: red;
  background: reed;
  padding: 10px;
|}];

/* Very long property value with error at end */
let test6 = [%cx2
  "box-shadow: 0 0 10px 5px rgba(0, 0, 0, 0.5), inset 0 0 5px fley"
];

/* Error in shorthand property */
let test7 = [%cx2 "margin: 10px fley 20px 30px"];

/* Error with !important */
let test8 = [%cx2 "display: fley !important"];

/* Error in function value */
let test9 = [%cx2 "transform: rotate(fley)"];

/* Error in calc expression */
let test10 = [%cx2 "width: calc(100% - fley)"];
