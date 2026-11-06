A css-wide keyword value (`inherit`, `initial`, ...) does not bypass the
property-name check. `colr:inherit;` used to compile silently when no space
followed the colon.

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
  File "input.re", line 2, characters 7-14:
  2 |   colr:inherit;
             ^^^^^^^
  Error: Unknown property 'colr'. Did you mean 'color'?
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [%ocaml.error "Unknown property 'colr'. Did you mean 'color'?"];
