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
  [@css
    ".css-h9mhzu{width:5rem;}\n.css-1ipmtw2{width:5ch;}\n.css-1l9qw8v{width:5vw;}\n.css-1ikjpn0{width:5vh;}\n.css-ygyuy0{width:5vmin;}\n.css-1aojkyq{width:5vmax;}\n.css-tsqvys{width:calc(1px + 2px);}\n.css-1ssfuw8{width:calc(5px * 2);}\n.css-1823oae{width:calc(5px - 10px);}\n.css-1faodca{width:calc(1vw - 1px);}\n.css-8atqhb{width:100%;}\n.css-1g01t7g{padding:5rem;}\n.css-b58q7f{padding:5ch;}\n.css-thw8ry{padding:5vw;}\n.css-18hvl0f{padding:5vh;}\n.css-6wnbv5{padding:5vmin;}\n.css-hrtnlf{padding:5vmax;}\n"
  ];
  
  CSS.make("css-h9mhzu", []);
  CSS.make("css-1ipmtw2", []);
  CSS.make("css-1l9qw8v", []);
  CSS.make("css-1ikjpn0", []);
  CSS.make("css-ygyuy0", []);
  CSS.make("css-1aojkyq", []);
  CSS.make("css-tsqvys", []);
  CSS.make("css-1ssfuw8", []);
  CSS.make("css-1ssfuw8", []);
  CSS.make("css-1823oae", []);
  CSS.make("css-1faodca", []);
  CSS.make("css-8atqhb", []);
  CSS.make("css-1g01t7g", []);
  CSS.make("css-b58q7f", []);
  CSS.make("css-thw8ry", []);
  CSS.make("css-18hvl0f", []);
  CSS.make("css-6wnbv5", []);
  CSS.make("css-hrtnlf", []);

