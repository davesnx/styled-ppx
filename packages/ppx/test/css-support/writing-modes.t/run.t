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
  [@css ".a-sxjqc9{direction:ltr;}"];
  [@css ".a-pu82ql{direction:rtl;}"];
  [@css ".a-1nh14px{unicode-bidi:normal;}"];
  [@css ".a-1dxtajz{unicode-bidi:embed;}"];
  [@css ".a-gthxsn{unicode-bidi:isolate;}"];
  [@css ".a-1f53xur{unicode-bidi:bidi-override;}"];
  [@css ".a-1sv30cq{unicode-bidi:isolate-override;}"];
  [@css ".a-3e7z6r{unicode-bidi:plaintext;}"];
  [@css
    ".a-1tyni7l{-webkit-writing-mode:horizontal-tb;-ms-writing-mode:horizontal-tb;writing-mode:horizontal-tb;}"
  ];
  [@css
    ".a-zorbdf{-webkit-writing-mode:vertical-rl;-ms-writing-mode:vertical-rl;writing-mode:vertical-rl;}"
  ];
  [@css
    ".a-bxuv7p{-webkit-writing-mode:vertical-lr;-ms-writing-mode:vertical-lr;writing-mode:vertical-lr;}"
  ];
  [@css ".a-1cbc989{text-orientation:mixed;}"];
  [@css ".a-1kcjqux{text-orientation:upright;}"];
  [@css ".a-ajfrh6{text-orientation:sideways;}"];
  [@css ".a-byubm3{text-combine-upright:none;}"];
  [@css ".a-16cjtzu{text-combine-upright:all;}"];
  [@css
    ".a-mpcjo4{-webkit-writing-mode:sideways-rl;-ms-writing-mode:sideways-rl;writing-mode:sideways-rl;}"
  ];
  [@css
    ".a-1tdq5f9{-webkit-writing-mode:sideways-lr;-ms-writing-mode:sideways-lr;writing-mode:sideways-lr;}"
  ];
  [@css ".a-6ofs5k{text-combine-upright:digits 2;}"];
  
  CSS.make("a-sxjqc9", []);
  CSS.make("a-pu82ql", []);
  CSS.make("a-1nh14px", []);
  CSS.make("a-1dxtajz", []);
  CSS.make("a-gthxsn", []);
  CSS.make("a-1f53xur", []);
  CSS.make("a-1sv30cq", []);
  CSS.make("a-3e7z6r", []);
  CSS.make("a-1tyni7l", []);
  CSS.make("a-zorbdf", []);
  CSS.make("a-bxuv7p", []);
  CSS.make("a-1cbc989", []);
  CSS.make("a-1kcjqux", []);
  CSS.make("a-ajfrh6", []);
  CSS.make("a-byubm3", []);
  CSS.make("a-16cjtzu", []);
  
  CSS.make("a-mpcjo4", []);
  CSS.make("a-1tdq5f9", []);
  CSS.make("a-6ofs5k", []);
