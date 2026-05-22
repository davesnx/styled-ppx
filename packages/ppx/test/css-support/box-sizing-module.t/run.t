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
    ".css-cf3le8{width:-webkit-max-content;width:-moz-max-content;width:max-content;}"
  ];
  [@css
    ".css-17hckkm{width:-webkit-min-content;width:-moz-min-content;width:min-content;}"
  ];
  [@css ".css-muccy6{width:fit-content(10%);}"];
  [@css
    ".css-106ktvk{min-width:-webkit-max-content;min-width:-moz-max-content;min-width:max-content;}"
  ];
  [@css
    ".css-vlreoz{min-width:-webkit-min-content;min-width:-moz-min-content;min-width:min-content;}"
  ];
  [@css ".css-gikswh{min-width:fit-content(10%);}"];
  [@css
    ".css-13sc9a0{max-width:-webkit-max-content;max-width:-moz-max-content;max-width:max-content;}"
  ];
  [@css
    ".css-1jonlwm{max-width:-webkit-min-content;max-width:-moz-min-content;max-width:min-content;}"
  ];
  [@css ".css-gszzeg{max-width:fit-content(10%);}"];
  [@css
    ".css-14x27ji{height:-webkit-max-content;height:-moz-max-content;height:max-content;}"
  ];
  [@css
    ".css-uvzl7o{height:-webkit-min-content;height:-moz-min-content;height:min-content;}"
  ];
  [@css ".css-giv2pj{height:fit-content(10%);}"];
  [@css
    ".css-ezyx8i{min-height:-webkit-max-content;min-height:-moz-max-content;min-height:max-content;}"
  ];
  [@css
    ".css-14fp2tk{min-height:-webkit-min-content;min-height:-moz-min-content;min-height:min-content;}"
  ];
  [@css ".css-1iubza9{min-height:fit-content(10%);}"];
  [@css
    ".css-1smyxes{max-height:-webkit-max-content;max-height:-moz-max-content;max-height:max-content;}"
  ];
  [@css
    ".css-rl4hk2{max-height:-webkit-min-content;max-height:-moz-min-content;max-height:min-content;}"
  ];
  [@css ".css-drct3b{max-height:fit-content(10%);}"];
  [@css ".css-1gqcmp3{aspect-ratio:auto;}"];
  [@css ".css-kpqo31{aspect-ratio:2;}"];
  [@css ".css-1amvr3s{aspect-ratio:16 / 9;}"];
  [@css
    ".css-1gtanqs{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}"
  ];
  [@css
    ".css-1344rbf{min-width:-webkit-fit-content;min-width:-moz-fit-content;min-width:fit-content;}"
  ];
  [@css
    ".css-1fuhjh6{max-width:-webkit-fit-content;max-width:-moz-fit-content;max-width:fit-content;}"
  ];
  [@css
    ".css-1sy0xge{height:-webkit-fit-content;height:-moz-fit-content;height:fit-content;}"
  ];
  [@css
    ".css-ewx31z{min-height:-webkit-fit-content;min-height:-moz-fit-content;min-height:fit-content;}"
  ];
  [@css
    ".css-hse59j{max-height:-webkit-fit-content;max-height:-moz-fit-content;max-height:fit-content;}"
  ];
  
  CSS.make("css-cf3le8", []);
  CSS.make("css-17hckkm", []);
  CSS.make("css-muccy6", []);
  CSS.make("css-106ktvk", []);
  CSS.make("css-vlreoz", []);
  CSS.make("css-gikswh", []);
  CSS.make("css-13sc9a0", []);
  CSS.make("css-1jonlwm", []);
  CSS.make("css-gszzeg", []);
  CSS.make("css-14x27ji", []);
  CSS.make("css-uvzl7o", []);
  CSS.make("css-giv2pj", []);
  CSS.make("css-ezyx8i", []);
  CSS.make("css-14fp2tk", []);
  CSS.make("css-1iubza9", []);
  CSS.make("css-1smyxes", []);
  CSS.make("css-rl4hk2", []);
  CSS.make("css-drct3b", []);
  
  CSS.make("css-1gqcmp3", []);
  CSS.make("css-kpqo31", []);
  CSS.make("css-1amvr3s", []);
  
  CSS.make("css-1gtanqs", []);
  
  CSS.make("css-1344rbf", []);
  
  CSS.make("css-1fuhjh6", []);
  
  CSS.make("css-1sy0xge", []);
  
  CSS.make("css-ewx31z", []);
  
  CSS.make("css-hse59j", []);
