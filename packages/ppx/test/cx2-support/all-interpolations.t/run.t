This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build
  File "input.re", line 644, characters 6-28:
  644 | [%cx2 {|order: $(orderVal)|}];
              ^^^^^^^^^^^^^^^^^^^^^^
  Error: This expression has type [> `num of int ]
         but an expression was expected of type int
  [1]


