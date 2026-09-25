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
    ".a-cf3le8{width:-webkit-max-content;width:-moz-max-content;width:max-content;}"
  ];
  [@css
    ".a-17hckkm{width:-webkit-min-content;width:-moz-min-content;width:min-content;}"
  ];
  [@css ".a-muccy6{width:fit-content(10%);}"];
  [@css
    ".a-106ktvk{min-width:-webkit-max-content;min-width:-moz-max-content;min-width:max-content;}"
  ];
  [@css
    ".a-vlreoz{min-width:-webkit-min-content;min-width:-moz-min-content;min-width:min-content;}"
  ];
  [@css ".a-gikswh{min-width:fit-content(10%);}"];
  [@css
    ".a-13sc9a0{max-width:-webkit-max-content;max-width:-moz-max-content;max-width:max-content;}"
  ];
  [@css
    ".a-1jonlwm{max-width:-webkit-min-content;max-width:-moz-min-content;max-width:min-content;}"
  ];
  [@css ".a-gszzeg{max-width:fit-content(10%);}"];
  [@css
    ".a-14x27ji{height:-webkit-max-content;height:-moz-max-content;height:max-content;}"
  ];
  [@css
    ".a-uvzl7o{height:-webkit-min-content;height:-moz-min-content;height:min-content;}"
  ];
  [@css ".a-giv2pj{height:fit-content(10%);}"];
  [@css
    ".a-ezyx8i{min-height:-webkit-max-content;min-height:-moz-max-content;min-height:max-content;}"
  ];
  [@css
    ".a-14fp2tk{min-height:-webkit-min-content;min-height:-moz-min-content;min-height:min-content;}"
  ];
  [@css ".a-1iubza9{min-height:fit-content(10%);}"];
  [@css
    ".a-1smyxes{max-height:-webkit-max-content;max-height:-moz-max-content;max-height:max-content;}"
  ];
  [@css
    ".a-rl4hk2{max-height:-webkit-min-content;max-height:-moz-min-content;max-height:min-content;}"
  ];
  [@css ".a-drct3b{max-height:fit-content(10%);}"];
  [@css ".a-1gqcmp3{aspect-ratio:auto;}"];
  [@css ".a-kpqo31{aspect-ratio:2;}"];
  [@css ".a-1amvr3s{aspect-ratio:16 / 9;}"];
  [@css
    ".a-1gtanqs{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}"
  ];
  [@css
    ".a-1344rbf{min-width:-webkit-fit-content;min-width:-moz-fit-content;min-width:fit-content;}"
  ];
  [@css
    ".a-1fuhjh6{max-width:-webkit-fit-content;max-width:-moz-fit-content;max-width:fit-content;}"
  ];
  [@css
    ".a-1sy0xge{height:-webkit-fit-content;height:-moz-fit-content;height:fit-content;}"
  ];
  [@css
    ".a-ewx31z{min-height:-webkit-fit-content;min-height:-moz-fit-content;min-height:fit-content;}"
  ];
  [@css
    ".a-hse59j{max-height:-webkit-fit-content;max-height:-moz-fit-content;max-height:fit-content;}"
  ];
  
  CSS.make("a-cf3le8", []);
  CSS.make("a-17hckkm", []);
  CSS.make("a-muccy6", []);
  CSS.make("a-106ktvk", []);
  CSS.make("a-vlreoz", []);
  CSS.make("a-gikswh", []);
  CSS.make("a-13sc9a0", []);
  CSS.make("a-1jonlwm", []);
  CSS.make("a-gszzeg", []);
  CSS.make("a-14x27ji", []);
  CSS.make("a-uvzl7o", []);
  CSS.make("a-giv2pj", []);
  CSS.make("a-ezyx8i", []);
  CSS.make("a-14fp2tk", []);
  CSS.make("a-1iubza9", []);
  CSS.make("a-1smyxes", []);
  CSS.make("a-rl4hk2", []);
  CSS.make("a-drct3b", []);
  
  CSS.make("a-1gqcmp3", []);
  CSS.make("a-kpqo31", []);
  CSS.make("a-1amvr3s", []);
  
  CSS.make("a-1gtanqs", []);
  
  CSS.make("a-1344rbf", []);
  
  CSS.make("a-1fuhjh6", []);
  
  CSS.make("a-1sy0xge", []);
  
  CSS.make("a-ewx31z", []);
  
  CSS.make("a-hse59j", []);
