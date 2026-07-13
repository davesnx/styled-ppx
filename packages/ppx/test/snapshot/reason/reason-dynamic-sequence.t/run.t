  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  File "output.ml", lines 4-5, characters 6-62:
  4 | ......Js.log "Logging when render";
  5 |       [|([%css "width: $(size)"]);([%css "display: block;"])|].
  Error: Extracted dynamic styled components require a CSS string body.
  
  Example:
    [%styled.div (~color) => "color: $(color);"]
  
  More info: https://styled-ppx.vercel.app/reference/dynamic-components
  [1]
  $ refmt --parse ml --print re output.ml
  module SequenceDynamicComponent = [%styled.div
    (~size) => {
      Js.log("Logging when render");
      [|[%css "width: $(size)"], [%css "display: block;"]|];
    }
  ];
  module DynamicComponentWithSequence = [%styled.button
    (~variant) => {
      let color = Theme.button(variant);
      [|
        [%css "display: inline-flex"],
        [%css "color: $(color)"],
        [%css "width: 100%;"],
      |];
    }
  ];
