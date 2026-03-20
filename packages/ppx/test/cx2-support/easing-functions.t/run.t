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
    ".css-duudp6{transition-timing-function:steps(2, jump-start);}\n.css-2tegan{transition-timing-function:steps(2, jump-end);}\n.css-1qfsz2c{transition-timing-function:steps(1, jump-both);}\n.css-1m48w8e{transition-timing-function:steps(2, jump-none);}\n"
  ];
  
  CSS.make("css-duudp6", []);
  CSS.make("css-2tegan", []);
  CSS.make("css-1qfsz2c", []);
  CSS.make("css-1m48w8e", []);
