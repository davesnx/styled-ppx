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
  File "input.re", line 5, characters 2-18:
  5 |   &::before:hover { color: red; }
        ^^^^^^^^^^^^^^^^
  Error: `:hover` after the pseudo-element `::before` never matches: no browser accepts `&::before:hover`, so the whole rule is dropped. Write the pseudo-class first: `&:hover::before`.
  [1]
