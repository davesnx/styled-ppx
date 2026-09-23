  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  File "output.ml", line 5, characters 6-71:
  5 |       let styles = sharedStylesBetweenDynamicComponents color in styles]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Error: Extracted dynamic styled components require a CSS string body.
  
  Example:
    [%styled.div (~color) => "color: $(color);"]
  
  More info: https://styled-ppx.vercel.app/reference/styled-components#derive-styles-from-props
  [1]
  $ refmt --parse ml --print re output.ml
  let sharedStylesBetweenDynamicComponents = color => [%css "color: $(color)"];
  module DynamicCompnentWithLetIn = [%styled.div
    (~color) => {
      let styles = sharedStylesBetweenDynamicComponents(color);
      styles;
    }
  ];
