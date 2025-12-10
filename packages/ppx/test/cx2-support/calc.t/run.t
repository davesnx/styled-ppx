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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-1rc9fy { width: calc(50% + 4px); }\n.css-8q89g5 { width: calc(20px - 10px); }\n.css-j0600b { width: calc(100vh - calc(2rem + 120px)); }\n.css-58jyfl { width: calc(100vh * 2); }\n.css-1jp7q9f { width: calc(2 * 120px); }\n"
  ];
  CSS.make("css-1rc9fy", []);
  CSS.make("css-8q89g5", []);
  CSS.make("css-j0600b", []);
  CSS.make("css-58jyfl", []);
  CSS.make("css-1jp7q9f", []);

  $ dune build
