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
  [@css ".a-1uqp1bd{scrollbar-color:auto;}"];
  [@css ".a-1xd6oa{scrollbar-color:red blue;}"];
  [@css ".a-1tn07g6{scrollbar-width:auto;}"];
  [@css ".a-osrmx3{scrollbar-width:thin;}"];
  [@css ".a-1y6rjsx{scrollbar-width:none;}"];
  
  CSS.make("a-1uqp1bd", []);
  CSS.make("a-1xd6oa", []);
  CSS.make("a-1tn07g6", []);
  CSS.make("a-osrmx3", []);
  CSS.make("a-1y6rjsx", []);
