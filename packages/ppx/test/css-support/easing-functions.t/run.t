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
  [@css ".a-dm00gudp6{transition-timing-function:steps(2, jump-start);}"];
  [@css ".a-dm00gegan{transition-timing-function:steps(2, jump-end);}"];
  [@css ".a-dm00gsz2c{transition-timing-function:steps(1, jump-both);}"];
  [@css ".a-dm00g8w8e{transition-timing-function:steps(2, jump-none);}"];
  
  CSS.make("a-dm00gudp6", []);
  CSS.make("a-dm00gegan", []);
  CSS.make("a-dm00gsz2c", []);
  CSS.make("a-dm00g8w8e", []);
