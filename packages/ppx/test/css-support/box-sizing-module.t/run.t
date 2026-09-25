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
    ".a-ec3le8{width:-webkit-max-content;width:-moz-max-content;width:max-content;}"
  ];
  [@css
    ".a-ecckkm{width:-webkit-min-content;width:-moz-min-content;width:min-content;}"
  ];
  [@css ".a-ecccy6{width:fit-content(10%);}"];
  [@css
    ".a-8cktvk{min-width:-webkit-max-content;min-width:-moz-max-content;min-width:max-content;}"
  ];
  [@css
    ".a-8creoz{min-width:-webkit-min-content;min-width:-moz-min-content;min-width:min-content;}"
  ];
  [@css ".a-8ckswh{min-width:fit-content(10%);}"];
  [@css
    ".a-88c9a0{max-width:-webkit-max-content;max-width:-moz-max-content;max-width:max-content;}"
  ];
  [@css
    ".a-88nlwm{max-width:-webkit-min-content;max-width:-moz-min-content;max-width:min-content;}"
  ];
  [@css ".a-88zzeg{max-width:fit-content(10%);}"];
  [@css
    ".a-6l27ji{height:-webkit-max-content;height:-moz-max-content;height:max-content;}"
  ];
  [@css
    ".a-6lzl7o{height:-webkit-min-content;height:-moz-min-content;height:min-content;}"
  ];
  [@css ".a-6lv2pj{height:fit-content(10%);}"];
  [@css
    ".a-8ayx8i{min-height:-webkit-max-content;min-height:-moz-max-content;min-height:max-content;}"
  ];
  [@css
    ".a-8ap2tk{min-height:-webkit-min-content;min-height:-moz-min-content;min-height:min-content;}"
  ];
  [@css ".a-8abza9{min-height:fit-content(10%);}"];
  [@css
    ".a-85yxes{max-height:-webkit-max-content;max-height:-moz-max-content;max-height:max-content;}"
  ];
  [@css
    ".a-854hk2{max-height:-webkit-min-content;max-height:-moz-min-content;max-height:min-content;}"
  ];
  [@css ".a-85ct3b{max-height:fit-content(10%);}"];
  [@css ".a-35cmp3{aspect-ratio:auto;}"];
  [@css ".a-35qo31{aspect-ratio:2;}"];
  [@css ".a-35vr3s{aspect-ratio:16 / 9;}"];
  [@css
    ".a-ecanqs{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}"
  ];
  [@css
    ".a-8c4rbf{min-width:-webkit-fit-content;min-width:-moz-fit-content;min-width:fit-content;}"
  ];
  [@css
    ".a-88hjh6{max-width:-webkit-fit-content;max-width:-moz-fit-content;max-width:fit-content;}"
  ];
  [@css
    ".a-6l0xge{height:-webkit-fit-content;height:-moz-fit-content;height:fit-content;}"
  ];
  [@css
    ".a-8ax31z{min-height:-webkit-fit-content;min-height:-moz-fit-content;min-height:fit-content;}"
  ];
  [@css
    ".a-85e59j{max-height:-webkit-fit-content;max-height:-moz-fit-content;max-height:fit-content;}"
  ];
  
  CSS.make("a-ec3le8", []);
  CSS.make("a-ecckkm", []);
  CSS.make("a-ecccy6", []);
  CSS.make("a-8cktvk", []);
  CSS.make("a-8creoz", []);
  CSS.make("a-8ckswh", []);
  CSS.make("a-88c9a0", []);
  CSS.make("a-88nlwm", []);
  CSS.make("a-88zzeg", []);
  CSS.make("a-6l27ji", []);
  CSS.make("a-6lzl7o", []);
  CSS.make("a-6lv2pj", []);
  CSS.make("a-8ayx8i", []);
  CSS.make("a-8ap2tk", []);
  CSS.make("a-8abza9", []);
  CSS.make("a-85yxes", []);
  CSS.make("a-854hk2", []);
  CSS.make("a-85ct3b", []);
  
  CSS.make("a-35cmp3", []);
  CSS.make("a-35qo31", []);
  CSS.make("a-35vr3s", []);
  
  CSS.make("a-ecanqs", []);
  
  CSS.make("a-8c4rbf", []);
  
  CSS.make("a-88hjh6", []);
  
  CSS.make("a-6l0xge", []);
  
  CSS.make("a-8ax31z", []);
  
  CSS.make("a-85e59j", []);
