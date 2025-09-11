/* Test error location accuracy for various CSS errors */

/* Test 1: Invalid property value on single line */
let single_line_error = [%cx "display: fley"];

/* Test 2: Invalid property value in multi-line CSS */
let multi_line_error = [%cx
  {|
  color: red;
  display: fley;
  padding: 10px;
|}
];

let multiple_errors = [%cx
  {|
  color: reed;
  display: fley;
  padding: 10pxx;
|}
];

/* Test 4: Error in cx2 with interpolation */
let cx2_error = main => [%cx2
  {|
  color: $(main);
  background-color: $(CSS.black);
  display: fley;
  margin: 20px;
|}
];

/* Test 5: Nested selector with error */
let nested_error = [%cx
  {|
  .container {
    display: fley;
    padding: 10px;
  }
|}
];

/* Test 6: Error with important */
let important_error = [%cx "display: fley !important"];

/* Test 7: Error on first property */
let first_prop_error = [%cx {|
  display: fley;
  color: red;
|}];

/* Test 8: Error on last property */
let last_prop_error = [%cx {|
  color: red;
  display: fley;
|}];

/* Test 9: Error in middle of many properties */
let middle_error = [%cx
  {|
  color: red;
  padding: 10px;
  display: fley;
  margin: 20px;
  border: 1px solid black;
|}
];

/* Test 10: Error with vendor prefix (unsupported) */
let vendor_error = [%cx "-webkit-display: fley"];

let css = main => [%cx2
  {|
  color: $(main);
  background-color: $(CSS.black);
  display: flex;
|}
];

let classname = [%cx2
  {|
    display: flex;
    flex-direction: column;
    gap: 10px;
  |}
];

<div styles={css(CSS.red)} />;

print_endline("\n");
print_endline(
  ReactDOM.renderToStaticMarkup(
    <main styles=classname> <div styles=[%cx2 "color: red"] /> </main>,
  ),
);

print_endline("\n");
print_endline(ReactDOM.renderToStaticMarkup(<App />));

print_endline("\nStyle tag:");
print_endline(ReactDOM.renderToStaticMarkup(<CSS.style_tag />));
