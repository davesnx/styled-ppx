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
    ".css-153340t { vertical-align: baseline; }\n.css-1m2eajy { vertical-align: sub; }\n.css-123s0f5 { vertical-align: super; }\n.css-dpr2cn { vertical-align: top; }\n.css-1sdo7bt { vertical-align: text-top; }\n.css-8meb7p { vertical-align: middle; }\n.css-1pyxv02 { vertical-align: bottom; }\n.css-ljxwrj { vertical-align: text-bottom; }\n"
  ];
  CSS.make("css-153340t", []);
  CSS.make("css-1m2eajy", []);
  CSS.make("css-123s0f5", []);
  CSS.make("css-dpr2cn", []);
  CSS.make("css-1sdo7bt", []);
  CSS.make("css-8meb7p", []);
  CSS.make("css-1pyxv02", []);
  CSS.make("css-ljxwrj", []);
