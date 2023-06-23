  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  File "output.ml", line 3, characters 8-10:
  3 |     fun () ->
              ^^
  Error: A dynamic component without props doesn't make much sense. This component should be static.
  
  More info: https://styled-ppx.vercel.app/usage/dynamic-components
  [1]
  $ refmt --parse ml --print re output.ml
  module T = [%styled.span () => [|[%css "font-size: 16px"]|]];
