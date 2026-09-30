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
  [@css "._a_b9p1bd{scrollbar-color:auto;}"];
  [@css "._a_b9d6oa{scrollbar-color:red blue;}"];
  [@css "._a_bh07g6{scrollbar-width:auto;}"];
  [@css "._a_bhrmx3{scrollbar-width:thin;}"];
  [@css "._a_bhrjsx{scrollbar-width:none;}"];
  
  CSS.make("_a_b9p1bd", []);
  CSS.make("_a_b9d6oa", []);
  CSS.make("_a_bh07g6", []);
  CSS.make("_a_bhrmx3", []);
  CSS.make("_a_bhrjsx", []);
