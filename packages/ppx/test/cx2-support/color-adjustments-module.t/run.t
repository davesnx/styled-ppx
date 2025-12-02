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
    ".css-x7ja91 { color-adjust: economy; }\n.css-17hk2r1 { color-adjust: exact; }\n.css-hs3n1x { forced-color-adjust: auto; }\n.css-1237do { forced-color-adjust: none; }\n.css-hwmjx3 { forced-color-adjust: preserve-parent-color; }\n.css-99xxi9 { color-scheme: normal; }\n.css-a60htk { color-scheme: light; }\n.css-1lyce09 { color-scheme: dark; }\n.css-1xbaq8h { color-scheme: light dark; }\n.css-1cjc761 { color-scheme: dark light; }\n.css-m3l1ox { color-scheme: only light; }\n.css-ntoj84 { color-scheme: light only; }\n.css-1b6yh7s { color-scheme: light light; }\n.css-1cj9cmo { color-scheme: dark dark; }\n.css-6bv9e2 { color-scheme: light purple; }\n.css-idrdrg { color-scheme: purple dark interesting; }\n.css-9qtap6 { color-scheme: none; }\n.css-1bwz4sq { color-scheme: light none; }\n"
  ];
  CSS.make("css-x7ja91", []);
  CSS.make("css-17hk2r1", []);
  CSS.make("css-hs3n1x", []);
  CSS.make("css-1237do", []);
  CSS.make("css-hwmjx3", []);
  CSS.make("css-99xxi9", []);
  CSS.make("css-a60htk", []);
  CSS.make("css-1lyce09", []);
  CSS.make("css-1xbaq8h", []);
  CSS.make("css-1cjc761", []);
  CSS.make("css-m3l1ox", []);
  CSS.make("css-ntoj84", []);
  CSS.make("css-1b6yh7s", []);
  CSS.make("css-1cj9cmo", []);
  CSS.make("css-6bv9e2", []);
  CSS.make("css-idrdrg", []);
  CSS.make("css-9qtap6", []);
  CSS.make("css-1bwz4sq", []);
