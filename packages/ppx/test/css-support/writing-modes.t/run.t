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
  [@css ".css-1asocdp{direction:ltr;}"];
  [@css ".css-15szf8m{direction:rtl;}"];
  [@css ".css-1cc6piz{unicode-bidi:normal;}"];
  [@css ".css-1sdkelf{unicode-bidi:embed;}"];
  [@css ".css-1110ufc{unicode-bidi:isolate;}"];
  [@css ".css-8krd75{unicode-bidi:bidi-override;}"];
  [@css ".css-sjmel6{unicode-bidi:isolate-override;}"];
  [@css ".css-1xtogzn{unicode-bidi:plaintext;}"];
  [@css
    ".css-6j6s0o{-webkit-writing-mode:horizontal-tb;-ms-writing-mode:horizontal-tb;writing-mode:horizontal-tb;}"
  ];
  [@css
    ".css-bbwn0b{-webkit-writing-mode:vertical-rl;-ms-writing-mode:vertical-rl;writing-mode:vertical-rl;}"
  ];
  [@css
    ".css-1wn7mw0{-webkit-writing-mode:vertical-lr;-ms-writing-mode:vertical-lr;writing-mode:vertical-lr;}"
  ];
  [@css ".css-sm2t8t{text-orientation:mixed;}"];
  [@css ".css-1ofh3mg{text-orientation:upright;}"];
  [@css ".css-1fbtf3q{text-orientation:sideways;}"];
  [@css ".css-3i59vv{text-combine-upright:none;}"];
  [@css ".css-1hih4nl{text-combine-upright:all;}"];
  [@css
    ".css-1w9f6up{-webkit-writing-mode:sideways-rl;-ms-writing-mode:sideways-rl;writing-mode:sideways-rl;}"
  ];
  [@css
    ".css-1rllg9u{-webkit-writing-mode:sideways-lr;-ms-writing-mode:sideways-lr;writing-mode:sideways-lr;}"
  ];
  [@css ".css-1fufzut{text-combine-upright:digits 2;}"];
  [@css.classes
    [
      ("css-1asocdp", 0, "", "input.re", 2, 8, 2, 22),
      ("css-15szf8m", 1, "", "input.re", 3, 8, 3, 22),
      ("css-1cc6piz", 2, "", "input.re", 4, 8, 4, 28),
      ("css-1sdkelf", 3, "", "input.re", 5, 8, 5, 27),
      ("css-1110ufc", 4, "", "input.re", 6, 8, 6, 29),
      ("css-8krd75", 5, "", "input.re", 7, 8, 7, 35),
      ("css-sjmel6", 6, "", "input.re", 8, 8, 8, 38),
      ("css-1xtogzn", 7, "", "input.re", 9, 8, 9, 31),
      ("css-6j6s0o", 8, "", "input.re", 10, 8, 10, 35),
      ("css-bbwn0b", 9, "", "input.re", 11, 8, 11, 33),
      ("css-1wn7mw0", 10, "", "input.re", 12, 8, 12, 33),
      ("css-sm2t8t", 11, "", "input.re", 13, 8, 13, 31),
      ("css-1ofh3mg", 12, "", "input.re", 14, 8, 14, 33),
      ("css-1fbtf3q", 13, "", "input.re", 15, 8, 15, 34),
      ("css-3i59vv", 14, "", "input.re", 16, 8, 16, 34),
      ("css-1hih4nl", 15, "", "input.re", 17, 8, 17, 33),
      ("css-1w9f6up", 16, "", "input.re", 20, 8, 20, 33),
      ("css-1rllg9u", 17, "", "input.re", 21, 8, 21, 33),
      ("css-1fufzut", 18, "", "input.re", 22, 8, 22, 38),
    ]
  ];
  
  CSS.make("css-1asocdp", []);
  CSS.make("css-15szf8m", []);
  CSS.make("css-1cc6piz", []);
  CSS.make("css-1sdkelf", []);
  CSS.make("css-1110ufc", []);
  CSS.make("css-8krd75", []);
  CSS.make("css-sjmel6", []);
  CSS.make("css-1xtogzn", []);
  CSS.make("css-6j6s0o", []);
  CSS.make("css-bbwn0b", []);
  CSS.make("css-1wn7mw0", []);
  CSS.make("css-sm2t8t", []);
  CSS.make("css-1ofh3mg", []);
  CSS.make("css-1fbtf3q", []);
  CSS.make("css-3i59vv", []);
  CSS.make("css-1hih4nl", []);
  
  CSS.make("css-1w9f6up", []);
  CSS.make("css-1rllg9u", []);
  CSS.make("css-1fufzut", []);
