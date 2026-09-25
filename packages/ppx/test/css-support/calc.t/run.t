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
  [@css ".a-eco6vg{width:calc(50% + 4px);}"];
  [@css ".a-ecj19s{width:calc(20px - 10px);}"];
  [@css ".a-eco4ty{width:calc(100vh - calc(2rem + 120px));}"];
  [@css ".a-ecuhfp{width:calc(100vh * 2);}"];
  [@css ".a-ec8hw4{width:calc(2 * 120px);}"];
  CSS.make("a-eco6vg", []);
  CSS.make("a-ecj19s", []);
  CSS.make("a-eco4ty", []);
  CSS.make("a-ecuhfp", []);
  CSS.make("a-ec8hw4", []);

  $ dune build
