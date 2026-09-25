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
  [@css ".a-duudp6{transition-timing-function:steps(2, jump-start);}"];
  [@css ".a-2tegan{transition-timing-function:steps(2, jump-end);}"];
  [@css ".a-1qfsz2c{transition-timing-function:steps(1, jump-both);}"];
  [@css ".a-1m48w8e{transition-timing-function:steps(2, jump-none);}"];
  
  CSS.make("a-duudp6", []);
  CSS.make("a-2tegan", []);
  CSS.make("a-1qfsz2c", []);
  CSS.make("a-1m48w8e", []);
