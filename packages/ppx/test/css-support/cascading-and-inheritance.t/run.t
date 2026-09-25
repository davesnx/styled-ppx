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
  [@css ".a-4eyg6i{color:unset;}"];
  [@css ".a-65m9shh2p{font-weight:unset;}"];
  [@css ".a-390086y3o{background-image:unset;}"];
  [@css ".a-ecvyp6{width:unset;}"];
  
  CSS.make("a-4eyg6i", []);
  CSS.make("a-65m9shh2p", []);
  CSS.make("a-390086y3o", []);
  CSS.make("a-ecvyp6", []);
