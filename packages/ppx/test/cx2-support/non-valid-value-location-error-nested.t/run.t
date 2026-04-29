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
  File "input.re", line 6, characters 10-18:
  Error: Property 'color' has an invalid value: 'cositas',
         Expected 'hex-color', 'value', 'color()', 'color-mix()', 'hsl()',
         'hsla()', 'hwb()', 'lab()', etc.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  let selectors = [%ocaml.error
    "Property 'color' has an invalid value: 'cositas',\nExpected 'hex-color', 'value', 'color()', 'color-mix()', 'hsl()', 'hsla()', 'hwb()', 'lab()', etc."
  ];
