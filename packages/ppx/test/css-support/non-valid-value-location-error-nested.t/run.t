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
  File "input.re", line 6, characters 11-18:
  6 |     color: cositas;
                 ^^^^^^^
  Error: Property 'color' has an invalid value: 'cositas',
         Expected 'hex-color', 'color()', 'color-mix()', 'hsl()', 'hsla()',
         'hwb()', 'lab()', 'lch()', etc.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css.atoms
    [
      (
        "_i7h4v2-Uj",
        [],
        1,
        0,
        0,
        [("id", "_i7h4v2-Uj", "bind\\0\\0Input\\0\\0selectors\\00")],
      ),
    ]
  ];
  let selectors = [%ocaml.error
    "Property 'color' has an invalid value: 'cositas',\nExpected 'hex-color', 'color()', 'color-mix()', 'hsl()', 'hsla()', 'hwb()', 'lab()', 'lch()', etc."
  ];
