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
  [@css ".css-3g225d { display: run-in; }\n.css-1qsmten { display: flow; }\n.css-hbr3m9 { display: flow-root; }\n"];
  CSS.make("css-3g225d", []);
  CSS.make("css-1qsmten", []);
  CSS.make("css-hbr3m9", []);
