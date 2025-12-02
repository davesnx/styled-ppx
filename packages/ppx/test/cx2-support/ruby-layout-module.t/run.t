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
    ".css-lpsosj { display: ruby; }\n.css-129suoa { display: ruby-base; }\n.css-4b8etj { display: ruby-text; }\n.css-wlmuqs { display: ruby-base-container; }\n.css-k89j4p { display: ruby-text-container; }\n"
  ];
  CSS.make("css-lpsosj", []);
  CSS.make("css-129suoa", []);
  CSS.make("css-4b8etj", []);
  CSS.make("css-wlmuqs", []);
  CSS.make("css-k89j4p", []);
