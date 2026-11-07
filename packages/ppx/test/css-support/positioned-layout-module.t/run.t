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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css.atoms
    [
      (
        "_agm84DTq8",
        ["._agm84DTq8{position:sticky;}"],
        1,
        0,
        1,
        [("value", "84DTq8", "val\\0gm\\0& | \\0position:sticky")],
      ),
    ]
  ];
  
  CSS.make("_agm84DTq8", []);
