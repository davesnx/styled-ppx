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
    ".css-1ogrdc { color: unset; }\n.css-1ezi774 { font-weight: unset; }\n.css-1o79maj { background-image: unset; }\n.css-1mm8mxx { width: unset; }\n"
  ];
  CSS.make("css-1ogrdc", []);
  CSS.make("css-1ezi774", []);
  CSS.make("css-1o79maj", []);
  CSS.make("css-1mm8mxx", []);
