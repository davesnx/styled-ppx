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
  [@css ".a-5qjqc9{direction:ltr;}"];
  [@css ".a-5q82ql{direction:rtl;}"];
  [@css ".a-dp14px{unicode-bidi:normal;}"];
  [@css ".a-dptajz{unicode-bidi:embed;}"];
  [@css ".a-dphxsn{unicode-bidi:isolate;}"];
  [@css ".a-dp3xur{unicode-bidi:bidi-override;}"];
  [@css ".a-dp30cq{unicode-bidi:isolate-override;}"];
  [@css ".a-dp7z6r{unicode-bidi:plaintext;}"];
  [@css
    ".a-ehni7l{-webkit-writing-mode:horizontal-tb;-ms-writing-mode:horizontal-tb;writing-mode:horizontal-tb;}"
  ];
  [@css
    ".a-ehrbdf{-webkit-writing-mode:vertical-rl;-ms-writing-mode:vertical-rl;writing-mode:vertical-rl;}"
  ];
  [@css
    ".a-ehuv7p{-webkit-writing-mode:vertical-lr;-ms-writing-mode:vertical-lr;writing-mode:vertical-lr;}"
  ];
  [@css ".a-cvc989{text-orientation:mixed;}"];
  [@css ".a-cvjqux{text-orientation:upright;}"];
  [@css ".a-cvfrh6{text-orientation:sideways;}"];
  [@css ".a-ceubm3{text-combine-upright:none;}"];
  [@css ".a-cejtzu{text-combine-upright:all;}"];
  [@css
    ".a-ehcjo4{-webkit-writing-mode:sideways-rl;-ms-writing-mode:sideways-rl;writing-mode:sideways-rl;}"
  ];
  [@css
    ".a-ehq5f9{-webkit-writing-mode:sideways-lr;-ms-writing-mode:sideways-lr;writing-mode:sideways-lr;}"
  ];
  [@css ".a-cefs5k{text-combine-upright:digits 2;}"];
  
  CSS.make("a-5qjqc9", []);
  CSS.make("a-5q82ql", []);
  CSS.make("a-dp14px", []);
  CSS.make("a-dptajz", []);
  CSS.make("a-dphxsn", []);
  CSS.make("a-dp3xur", []);
  CSS.make("a-dp30cq", []);
  CSS.make("a-dp7z6r", []);
  CSS.make("a-ehni7l", []);
  CSS.make("a-ehrbdf", []);
  CSS.make("a-ehuv7p", []);
  CSS.make("a-cvc989", []);
  CSS.make("a-cvjqux", []);
  CSS.make("a-cvfrh6", []);
  CSS.make("a-ceubm3", []);
  CSS.make("a-cejtzu", []);
  
  CSS.make("a-ehcjo4", []);
  CSS.make("a-ehq5f9", []);
  CSS.make("a-cefs5k", []);
