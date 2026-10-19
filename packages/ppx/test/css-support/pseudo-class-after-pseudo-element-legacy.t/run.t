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
  File "input.re", line 4, characters 2-20:
  4 |   &:first-line:hover { color: red; }
        ^^^^^^^^^^^^^^^^^^
  Error: `:hover` after the pseudo-element `::first-line` never matches: no browser accepts `&::first-line:hover`, so the whole rule is dropped. Write the pseudo-class first: `&:hover::first-line`.
  [1]
