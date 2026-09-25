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
  [@css ".a-12m0k8p{pointer-events:auto;}"];
  [@css ".a-1k273s1{pointer-events:visiblePainted;}"];
  [@css ".a-1z0le2q{pointer-events:visibleFill;}"];
  [@css ".a-1e64ebn{pointer-events:visibleStroke;}"];
  [@css ".a-1ttsh4e{pointer-events:visible;}"];
  [@css ".a-nw29yp{pointer-events:painted;}"];
  [@css ".a-1olh5dc{pointer-events:fill;}"];
  [@css ".a-k8ii8d{pointer-events:stroke;}"];
  [@css ".a-uw7k7s{pointer-events:all;}"];
  [@css ".a-1ixbp0l{pointer-events:none;}"];
  
  CSS.make("a-12m0k8p", []);
  
  CSS.make("a-1k273s1", []);
  CSS.make("a-1z0le2q", []);
  CSS.make("a-1e64ebn", []);
  CSS.make("a-1ttsh4e", []);
  CSS.make("a-nw29yp", []);
  CSS.make("a-1olh5dc", []);
  CSS.make("a-k8ii8d", []);
  CSS.make("a-uw7k7s", []);
  CSS.make("a-1ixbp0l", []);
