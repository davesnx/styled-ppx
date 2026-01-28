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
  File "input.re", line 10, characters 11-17:
  Error: Property 'display' has an invalid value: 'blocki',
         Expected '-moz-inline-box'. Got 'blocki' instead.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  Js.log("2000");
  
  CSS.style([|
    CSS.height(`percent(100.)),
    CSS.height(`percent(100.)),
    CSS.height(`percent(100.)),
    CSS.height(`percent(100.)),
    CSS.height(`percent(100.)),
    [%ocaml.error
      "Property 'display' has an invalid value: 'blocki',\nExpected '-moz-inline-box'. Got 'blocki' instead."
    ],
  |]);
