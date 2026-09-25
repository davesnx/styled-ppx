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
  [@css ".a-9k0k8p{pointer-events:auto;}"];
  [@css ".a-9k73s1{pointer-events:visiblePainted;}"];
  [@css ".a-9kle2q{pointer-events:visibleFill;}"];
  [@css ".a-9k4ebn{pointer-events:visibleStroke;}"];
  [@css ".a-9ksh4e{pointer-events:visible;}"];
  [@css ".a-9k29yp{pointer-events:painted;}"];
  [@css ".a-9kh5dc{pointer-events:fill;}"];
  [@css ".a-9kii8d{pointer-events:stroke;}"];
  [@css ".a-9k7k7s{pointer-events:all;}"];
  [@css ".a-9kbp0l{pointer-events:none;}"];
  
  CSS.make("a-9k0k8p", []);
  
  CSS.make("a-9k73s1", []);
  CSS.make("a-9kle2q", []);
  CSS.make("a-9k4ebn", []);
  CSS.make("a-9ksh4e", []);
  CSS.make("a-9k29yp", []);
  CSS.make("a-9kh5dc", []);
  CSS.make("a-9kii8d", []);
  CSS.make("a-9k7k7s", []);
  CSS.make("a-9kbp0l", []);
