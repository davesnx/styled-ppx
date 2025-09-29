This test ensures error locations are reported accurately for CSS property errors

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native server-reason-react.react)
  >  (preprocess (pps server-reason-react.ppx styled-ppx)))
  > EOF

Test error location accuracy
  $ dune build
  File "input.re", line 5, characters 6-18:
  5 | [%cx2 "color: rex"];
            ^^^^^^^^^^^^
  Error: Type error on cx2 definition
  File "input.re", lines 4-5, characters 7-17:
  4 | [%cx2 "color: rex"];
             ^^^^^^^^^^
    Got 'function rgb', did you mean 'function var'?
  [1]
