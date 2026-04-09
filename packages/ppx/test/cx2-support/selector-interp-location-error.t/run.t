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
  File "input.re", line 8, characters 20-21:
  Error: Parse error while reading token '2'
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css ".css-1c21bcw-_className .lolaso :nth-child(2n){color:red;}"];
  let _className = CSS.make("css-1c21bcw-_className", []);
  
  let _className = [%ocaml.error "Parse error while reading token '2'"];
