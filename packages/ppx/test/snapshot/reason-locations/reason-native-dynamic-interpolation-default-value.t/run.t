  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --native --impl output.ml -o output.ml
  File "output.ml", line 4, characters 6-62:
  4 |       [|([%css "color: $(var);"]);([%css "display: block;"])|]]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Error: Extracted dynamic styled components require a CSS string body.
  
  Example:
    [%styled.div (~color) => "color: $(color);"]
  
  More info: https://styled-ppx.vercel.app/reference/styled-components#derive-styles-from-props
  [1]
  $ refmt --parse ml --print re output.ml
  module DynamicComponentWithDefaultValue = [%styled.div
    (~var=CSS.hex("333")) => [|
      [%css "color: $(var);"],
      [%css "display: block;"],
    |]
  ];
