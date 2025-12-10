/* Test that '$' is not shown in error messages */

/* This should not show "expected '$'" in the error */
let test1 = [%cx "display: fley"];

/* This should also not show "expected '$'" */
let test2 = main => [%cx2 {|
  display: fley;
|}];

/* Multiple errors should not show '$' */
let test3 = main => [%cx2
  {|
  color: $(main);
  display: fley;
  background: reed;
|}
];
