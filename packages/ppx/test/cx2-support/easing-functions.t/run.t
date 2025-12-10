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
    ".css-1f293pv { transition-timing-function: steps(2, jump-start); }\n.css-czstwu { transition-timing-function: steps(2, jump-end); }\n.css-jec6vi { transition-timing-function: steps(1, jump-both); }\n.css-mr1240 { transition-timing-function: steps(2, jump-none); }\n"
  ];
  CSS.make("css-1f293pv", []);
  CSS.make("css-czstwu", []);
  CSS.make("css-jec6vi", []);
  CSS.make("css-mr1240", []);
