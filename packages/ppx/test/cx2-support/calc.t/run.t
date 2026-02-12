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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-hxo6vg{width:calc(50% + 4px);}\n.css-1bjj19s{width:calc(20px - 10px);}\n.css-12qo4ty{width:calc(100vh - calc(2rem + 120px));}\n.css-1g5uhfp{width:calc(100vh * 2);}\n.css-6t8hw4{width:calc(2 * 120px);}\n"
  ];
  CSS.make("css-hxo6vg", []);
  CSS.make("css-1bjj19s", []);
  CSS.make("css-12qo4ty", []);
  CSS.make("css-1g5uhfp", []);
  CSS.make("css-6t8hw4", []);

  $ dune build
