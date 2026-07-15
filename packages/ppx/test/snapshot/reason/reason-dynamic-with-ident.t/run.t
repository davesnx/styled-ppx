  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  File "output.ml", line 1, characters 59-66:
  1 | module DynamicCompnentWithIdent = [%styled.div fun ~a:_ -> cssRule]
                                                                 ^^^^^^^
  Error: Extracted dynamic styled components require a CSS string body.
  
  Example:
    [%styled.div (~color) => "color: $(color);"]
  
  More info: https://styled-ppx.vercel.app/reference/styled-components#derive-styles-from-props
  [1]
  $ refmt --parse ml --print re output.ml
  module DynamicCompnentWithIdent = [%styled.div (~a as _) => cssRule];
