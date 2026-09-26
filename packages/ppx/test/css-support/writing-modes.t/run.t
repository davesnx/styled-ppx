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
  [@css "._a_5qjqc9{direction:ltr;}"];
  [@css "._a_5q82ql{direction:rtl;}"];
  [@css "._a_dp14px{unicode-bidi:normal;}"];
  [@css "._a_dptajz{unicode-bidi:embed;}"];
  [@css "._a_dphxsn{unicode-bidi:isolate;}"];
  [@css "._a_dp3xur{unicode-bidi:bidi-override;}"];
  [@css "._a_dp30cq{unicode-bidi:isolate-override;}"];
  [@css "._a_dp7z6r{unicode-bidi:plaintext;}"];
  [@css
    "._a_ehni7l{-webkit-writing-mode:horizontal-tb;-ms-writing-mode:horizontal-tb;writing-mode:horizontal-tb;}"
  ];
  [@css
    "._a_ehrbdf{-webkit-writing-mode:vertical-rl;-ms-writing-mode:vertical-rl;writing-mode:vertical-rl;}"
  ];
  [@css
    "._a_ehuv7p{-webkit-writing-mode:vertical-lr;-ms-writing-mode:vertical-lr;writing-mode:vertical-lr;}"
  ];
  [@css "._a_cvc989{text-orientation:mixed;}"];
  [@css "._a_cvjqux{text-orientation:upright;}"];
  [@css "._a_cvfrh6{text-orientation:sideways;}"];
  [@css "._a_ceubm3{text-combine-upright:none;}"];
  [@css "._a_cejtzu{text-combine-upright:all;}"];
  [@css
    "._a_ehcjo4{-webkit-writing-mode:sideways-rl;-ms-writing-mode:sideways-rl;writing-mode:sideways-rl;}"
  ];
  [@css
    "._a_ehq5f9{-webkit-writing-mode:sideways-lr;-ms-writing-mode:sideways-lr;writing-mode:sideways-lr;}"
  ];
  [@css "._a_cefs5k{text-combine-upright:digits 2;}"];
  
  CSS.make("_a_5qjqc9", []);
  CSS.make("_a_5q82ql", []);
  CSS.make("_a_dp14px", []);
  CSS.make("_a_dptajz", []);
  CSS.make("_a_dphxsn", []);
  CSS.make("_a_dp3xur", []);
  CSS.make("_a_dp30cq", []);
  CSS.make("_a_dp7z6r", []);
  CSS.make("_a_ehni7l", []);
  CSS.make("_a_ehrbdf", []);
  CSS.make("_a_ehuv7p", []);
  CSS.make("_a_cvc989", []);
  CSS.make("_a_cvjqux", []);
  CSS.make("_a_cvfrh6", []);
  CSS.make("_a_ceubm3", []);
  CSS.make("_a_cejtzu", []);
  
  CSS.make("_a_ehcjo4", []);
  CSS.make("_a_ehq5f9", []);
  CSS.make("_a_cefs5k", []);
