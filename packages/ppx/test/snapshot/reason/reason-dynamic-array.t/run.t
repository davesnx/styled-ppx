  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  File "output.ml", lines 4-6, characters 6-76:
  4 | ......[|((match var with
  5 |           | `Black -> [%css "color: #999999"]
  6 |           | `White -> [%css "color: #FAFAFA"]));([%css "display: block;"])|].
  Error: Extracted dynamic styled components require a CSS string body.
  
  Example:
    [%styled.div (~color) => "color: $(color);"]
  
  More info: https://styled-ppx.vercel.app/reference/dynamic-components
  [1]
  $ refmt --parse ml --print re output.ml
  module ArrayDynamicComponent = [%styled.div
    (~var) => [|
      switch (var) {
      | `Black => [%css "color: #999999"]
      | `White => [%css "color: #FAFAFA"]
      },
      [%css "display: block;"],
    |]
  ];
