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
    ".css-1nccoxz { will-change: scroll-position; }\n.css-lptqy0 { will-change: contents; }\n.css-5pevkr { will-change: transform; }\n.css-dbrmi3 { will-change: top, left; }\n"
  ];
  CSS.make("css-1nccoxz", []);
  CSS.make("css-lptqy0", []);
  CSS.make("css-5pevkr", []);
  CSS.make("css-dbrmi3", []);
