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
  File "input.re", lines 2-3, characters 0-9:
  Error: Ampersand is needed if selector begins with pseudo-class or
         pseudo-element.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  
  let selectors =
    CSS.style([|
      CSS.label("selectors"),
      [%ocaml.error
        "Ampersand is needed if selector begins with pseudo-class or pseudo-element."
      ],
      [%ocaml.error
        "Ampersand is needed if selector begins with pseudo-class or pseudo-element."
      ],
    |]);
