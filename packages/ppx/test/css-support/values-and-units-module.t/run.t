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
  [@css ".a-h9mhzu{width:5rem;}"];
  [@css ".a-1ipmtw2{width:5ch;}"];
  [@css ".a-1l9qw8v{width:5vw;}"];
  [@css ".a-1ikjpn0{width:5vh;}"];
  [@css ".a-ygyuy0{width:5vmin;}"];
  [@css ".a-1aojkyq{width:5vmax;}"];
  [@css ".a-tsqvys{width:calc(1px + 2px);}"];
  [@css ".a-1ssfuw8{width:calc(5px * 2);}"];
  [@css ".a-1823oae{width:calc(5px - 10px);}"];
  [@css ".a-1faodca{width:calc(1vw - 1px);}"];
  [@css ".a-8atqhb{width:100%;}"];
  [@css ".a-1g01t7g{padding:5rem;}"];
  [@css ".a-b58q7f{padding:5ch;}"];
  [@css ".a-thw8ry{padding:5vw;}"];
  [@css ".a-18hvl0f{padding:5vh;}"];
  [@css ".a-6wnbv5{padding:5vmin;}"];
  [@css ".a-hrtnlf{padding:5vmax;}"];
  
  CSS.make("a-h9mhzu", []);
  CSS.make("a-1ipmtw2", []);
  CSS.make("a-1l9qw8v", []);
  CSS.make("a-1ikjpn0", []);
  CSS.make("a-ygyuy0", []);
  CSS.make("a-1aojkyq", []);
  CSS.make("a-tsqvys", []);
  CSS.make("a-1ssfuw8", []);
  CSS.make("a-1ssfuw8", []);
  CSS.make("a-1823oae", []);
  CSS.make("a-1faodca", []);
  CSS.make("a-8atqhb", []);
  CSS.make("a-1g01t7g", []);
  CSS.make("a-b58q7f", []);
  CSS.make("a-thw8ry", []);
  CSS.make("a-18hvl0f", []);
  CSS.make("a-6wnbv5", []);
  CSS.make("a-hrtnlf", []);

