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
  [@css ".css-ivpccdp{direction:ltr;}"];
  [@css ".css-ivpcf8m{direction:rtl;}"];
  [@css ".css-ivpcpiz{unicode-bidi:normal;}"];
  [@css ".css-ivpcelf{unicode-bidi:embed;}"];
  [@css ".css-ivpcufc{unicode-bidi:isolate;}"];
  [@css ".css-ivpcd75{unicode-bidi:bidi-override;}"];
  [@css ".css-ivpcel6{unicode-bidi:isolate-override;}"];
  [@css ".css-ivpcgzn{unicode-bidi:plaintext;}"];
  [@css
    ".css-ivpcs0o{-webkit-writing-mode:horizontal-tb;-ms-writing-mode:horizontal-tb;writing-mode:horizontal-tb;}"
  ];
  [@css
    ".css-ivpcn0b{-webkit-writing-mode:vertical-rl;-ms-writing-mode:vertical-rl;writing-mode:vertical-rl;}"
  ];
  [@css
    ".css-ivpcmw0{-webkit-writing-mode:vertical-lr;-ms-writing-mode:vertical-lr;writing-mode:vertical-lr;}"
  ];
  [@css ".css-ivpct8t{text-orientation:mixed;}"];
  [@css ".css-ivpc3mg{text-orientation:upright;}"];
  [@css ".css-ivpcf3q{text-orientation:sideways;}"];
  [@css ".css-ivpc9vv{text-combine-upright:none;}"];
  [@css ".css-ivpc4nl{text-combine-upright:all;}"];
  [@css
    ".css-ivpc6up{-webkit-writing-mode:sideways-rl;-ms-writing-mode:sideways-rl;writing-mode:sideways-rl;}"
  ];
  [@css
    ".css-ivpcg9u{-webkit-writing-mode:sideways-lr;-ms-writing-mode:sideways-lr;writing-mode:sideways-lr;}"
  ];
  [@css ".css-ivpczut{text-combine-upright:digits 2;}"];
  [@css.classes
    [
      ("css-ivpccdp", 0, "", "input.re", 2, 8, 2, 22),
      ("css-ivpcf8m", 1, "", "input.re", 3, 8, 3, 22),
      ("css-ivpcpiz", 2, "", "input.re", 4, 8, 4, 28),
      ("css-ivpcelf", 3, "", "input.re", 5, 8, 5, 27),
      ("css-ivpcufc", 4, "", "input.re", 6, 8, 6, 29),
      ("css-ivpcd75", 5, "", "input.re", 7, 8, 7, 35),
      ("css-ivpcel6", 6, "", "input.re", 8, 8, 8, 38),
      ("css-ivpcgzn", 7, "", "input.re", 9, 8, 9, 31),
      ("css-ivpcs0o", 8, "", "input.re", 10, 8, 10, 35),
      ("css-ivpcn0b", 9, "", "input.re", 11, 8, 11, 33),
      ("css-ivpcmw0", 10, "", "input.re", 12, 8, 12, 33),
      ("css-ivpct8t", 11, "", "input.re", 13, 8, 13, 31),
      ("css-ivpc3mg", 12, "", "input.re", 14, 8, 14, 33),
      ("css-ivpcf3q", 13, "", "input.re", 15, 8, 15, 34),
      ("css-ivpc9vv", 14, "", "input.re", 16, 8, 16, 34),
      ("css-ivpc4nl", 15, "", "input.re", 17, 8, 17, 33),
      ("css-ivpc6up", 16, "", "input.re", 20, 8, 20, 33),
      ("css-ivpcg9u", 17, "", "input.re", 21, 8, 21, 33),
      ("css-ivpczut", 18, "", "input.re", 22, 8, 22, 38),
    ]
  ];
  
  CSS.make("css-ivpccdp", []);
  CSS.make("css-ivpcf8m", []);
  CSS.make("css-ivpcpiz", []);
  CSS.make("css-ivpcelf", []);
  CSS.make("css-ivpcufc", []);
  CSS.make("css-ivpcd75", []);
  CSS.make("css-ivpcel6", []);
  CSS.make("css-ivpcgzn", []);
  CSS.make("css-ivpcs0o", []);
  CSS.make("css-ivpcn0b", []);
  CSS.make("css-ivpcmw0", []);
  CSS.make("css-ivpct8t", []);
  CSS.make("css-ivpc3mg", []);
  CSS.make("css-ivpcf3q", []);
  CSS.make("css-ivpc9vv", []);
  CSS.make("css-ivpc4nl", []);
  
  CSS.make("css-ivpc6up", []);
  CSS.make("css-ivpcg9u", []);
  CSS.make("css-ivpczut", []);
