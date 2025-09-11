/* Test error location accuracy for cx2 */

/* Test case similar to demo/server/server.re */
let css = main => [%cx2
  {|
  color: $(main);
  background-color: $(CSS.black);
  display: fley;
|}
];

/* Test with error on first line */
let css_first_line = main => [%cx2
  {|
  colr: $(main);
  background-color: $(CSS.black);
  display: flex;
|}
];

/* Test with error on middle line */
let css_middle_line = main => [%cx2
  {|
  color: $(main);
  bakground-color: $(CSS.black);
  display: flex;
|}
];

/* Test with multiple errors */
let css_multiple_errors = main => [%cx2
  {|
  colr: $(main);
  bakground-color: $(CSS.black);
  display: fley;
|}
];
