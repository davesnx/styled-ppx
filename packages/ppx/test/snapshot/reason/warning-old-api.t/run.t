  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  File "_none_", line 1:
  Error: Unexpected error A dynamic component without props doesn't make much sense. Try to translate into static.
  
  More info: https://styled-ppx.vercel.app/usage/dynamic-components
  [1]
  $ refmt --parse ml --print re output.ml
  module T = [%styled.span () => [|[%css "font-size: 16px"]|]];
