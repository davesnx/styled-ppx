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
    ".css-1v7yg6i{color:unset;}\n.css-1uehh2p{font-weight:unset;}\n.css-kh6y3o{background-image:unset;}\n.css-1oovyp6{width:unset;}\n"
  ];
  
  CSS.make("css-1v7yg6i", []);
  CSS.make("css-1uehh2p", []);
  CSS.make("css-kh6y3o", []);
  CSS.make("css-1oovyp6", []);
