  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  File "output.ml", lines 5-7, characters 8-34:
  5 | ........[|([%css "width: $(size)"]);([%css "color: $(color)"]);([%css
  6 |                                                                   "display: block;"]);(
  7 |           [%css "width: 100%;"])|].
  Error: Extracted dynamic styled components require a CSS string body.
  
  Example:
    [%styled.div (~color) => "color: $(color);"]
  
  More info: https://styled-ppx.vercel.app/reference/styled-components#derive-styles-from-props
  [1]
  $ refmt --parse ml --print re output.ml
  module DynamicComponentWithArray = [%styled.button
    (~size, ~color) => [|
      [%css "width: $(size)"],
      [%css "color: $(color)"],
      [%css "display: block;"],
      [%css "width: 100%;"],
    |]
  ];
