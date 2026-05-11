A dynamic component declared without any props is rejected as a
hard error: such a component carries no information beyond a static
one, and the legacy API silently accepted it. The fix is either to
add props or to use the static form `[%styled.span ...]` directly.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  File "output.ml", line 1, characters 29-31:
  1 | module T = [%styled.span fun () -> [|([%css "font-size: 16px"])|]]
                                   ^^
  Error: A dynamic component without props doesn't make much sense. This component should be static.
  
  More info: https://styled-ppx.vercel.app/usage/dynamic-components
  [1]
  $ refmt --parse ml --print re output.ml
  module T = [%styled.span () => [|[%css "font-size: 16px"]|]];
