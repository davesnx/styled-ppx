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
    "._a_ec3le8{width:-webkit-max-content;width:-moz-max-content;width:max-content;}"
  ];
  [@css
    "._a_ecckkm{width:-webkit-min-content;width:-moz-min-content;width:min-content;}"
  ];
  [@css "._a_ecccy6{width:fit-content(10%);}"];
  [@css
    "._a_ga002ktvk{min-width:-webkit-max-content;min-width:-moz-max-content;min-width:max-content;}"
  ];
  [@css
    "._a_ga002reoz{min-width:-webkit-min-content;min-width:-moz-min-content;min-width:min-content;}"
  ];
  [@css "._a_ga002kswh{min-width:fit-content(10%);}"];
  [@css
    "._a_g8002c9a0{max-width:-webkit-max-content;max-width:-moz-max-content;max-width:max-content;}"
  ];
  [@css
    "._a_g8002nlwm{max-width:-webkit-min-content;max-width:-moz-min-content;max-width:min-content;}"
  ];
  [@css "._a_g8002zzeg{max-width:fit-content(10%);}"];
  [@css
    "._a_6l27ji{height:-webkit-max-content;height:-moz-max-content;height:max-content;}"
  ];
  [@css
    "._a_6lzl7o{height:-webkit-min-content;height:-moz-min-content;height:min-content;}"
  ];
  [@css "._a_6lv2pj{height:fit-content(10%);}"];
  [@css
    "._a_ga001yx8i{min-height:-webkit-max-content;min-height:-moz-max-content;min-height:max-content;}"
  ];
  [@css
    "._a_ga001p2tk{min-height:-webkit-min-content;min-height:-moz-min-content;min-height:min-content;}"
  ];
  [@css "._a_ga001bza9{min-height:fit-content(10%);}"];
  [@css
    "._a_g8001yxes{max-height:-webkit-max-content;max-height:-moz-max-content;max-height:max-content;}"
  ];
  [@css
    "._a_g80014hk2{max-height:-webkit-min-content;max-height:-moz-min-content;max-height:min-content;}"
  ];
  [@css "._a_g8001ct3b{max-height:fit-content(10%);}"];
  [@css "._a_35cmp3{aspect-ratio:auto;}"];
  [@css "._a_35qo31{aspect-ratio:2;}"];
  [@css "._a_35vr3s{aspect-ratio:16 / 9;}"];
  [@css
    "._a_ecanqs{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}"
  ];
  [@css
    "._a_ga0024rbf{min-width:-webkit-fit-content;min-width:-moz-fit-content;min-width:fit-content;}"
  ];
  [@css
    "._a_g8002hjh6{max-width:-webkit-fit-content;max-width:-moz-fit-content;max-width:fit-content;}"
  ];
  [@css
    "._a_6l0xge{height:-webkit-fit-content;height:-moz-fit-content;height:fit-content;}"
  ];
  [@css
    "._a_ga001x31z{min-height:-webkit-fit-content;min-height:-moz-fit-content;min-height:fit-content;}"
  ];
  [@css
    "._a_g8001e59j{max-height:-webkit-fit-content;max-height:-moz-fit-content;max-height:fit-content;}"
  ];
  
  CSS.make("_a_ec3le8", []);
  CSS.make("_a_ecckkm", []);
  CSS.make("_a_ecccy6", []);
  CSS.make("_a_ga002ktvk", []);
  CSS.make("_a_ga002reoz", []);
  CSS.make("_a_ga002kswh", []);
  CSS.make("_a_g8002c9a0", []);
  CSS.make("_a_g8002nlwm", []);
  CSS.make("_a_g8002zzeg", []);
  CSS.make("_a_6l27ji", []);
  CSS.make("_a_6lzl7o", []);
  CSS.make("_a_6lv2pj", []);
  CSS.make("_a_ga001yx8i", []);
  CSS.make("_a_ga001p2tk", []);
  CSS.make("_a_ga001bza9", []);
  CSS.make("_a_g8001yxes", []);
  CSS.make("_a_g80014hk2", []);
  CSS.make("_a_g8001ct3b", []);
  
  CSS.make("_a_35cmp3", []);
  CSS.make("_a_35qo31", []);
  CSS.make("_a_35vr3s", []);
  
  CSS.make("_a_ecanqs", []);
  
  CSS.make("_a_ga0024rbf", []);
  
  CSS.make("_a_g8002hjh6", []);
  
  CSS.make("_a_6l0xge", []);
  
  CSS.make("_a_ga001x31z", []);
  
  CSS.make("_a_g8001e59j", []);
