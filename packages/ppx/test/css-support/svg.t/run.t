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
  [@css "._a_9k0k8p{pointer-events:auto;}"];
  [@css "._a_9k73s1{pointer-events:visiblePainted;}"];
  [@css "._a_9kle2q{pointer-events:visibleFill;}"];
  [@css "._a_9k4ebn{pointer-events:visibleStroke;}"];
  [@css "._a_9ksh4e{pointer-events:visible;}"];
  [@css "._a_9k29yp{pointer-events:painted;}"];
  [@css "._a_9kh5dc{pointer-events:fill;}"];
  [@css "._a_9kii8d{pointer-events:stroke;}"];
  [@css "._a_9k7k7s{pointer-events:all;}"];
  [@css "._a_9kbp0l{pointer-events:none;}"];
  
  CSS.make("_a_9k0k8p", []);
  
  CSS.make("_a_9k73s1", []);
  CSS.make("_a_9kle2q", []);
  CSS.make("_a_9k4ebn", []);
  CSS.make("_a_9ksh4e", []);
  CSS.make("_a_9k29yp", []);
  CSS.make("_a_9kh5dc", []);
  CSS.make("_a_9kii8d", []);
  CSS.make("_a_9k7k7s", []);
  CSS.make("_a_9kbp0l", []);
