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
  File "input.re", line 5, characters 4-11:
  5 |     &:focus { color: red; }
          ^^^^^^^
  Error: `:focus` after the pseudo-element `::after` never matches: no browser accepts `&::after:focus`, so the whole rule is dropped. Write the pseudo-class first: `&:focus::after`.
  [1]
