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
    ".css-11ss374{width:-webkit-max-content;width:-moz-max-content;width:max-content;}"
  ];
  [@css
    ".css-1mrdhpb{width:-webkit-min-content;width:-moz-min-content;width:min-content;}"
  ];
  [@css ".css-6l2yg4{width:fit-content(10%);}"];
  [@css
    ".css-o0ablc{min-width:-webkit-max-content;min-width:-moz-max-content;min-width:max-content;}"
  ];
  [@css
    ".css-14if3hy{min-width:-webkit-min-content;min-width:-moz-min-content;min-width:min-content;}"
  ];
  [@css ".css-1hxdutz{min-width:fit-content(10%);}"];
  [@css
    ".css-wri28a{max-width:-webkit-max-content;max-width:-moz-max-content;max-width:max-content;}"
  ];
  [@css
    ".css-tz47m0{max-width:-webkit-min-content;max-width:-moz-min-content;max-width:min-content;}"
  ];
  [@css ".css-1qkrzio{max-width:fit-content(10%);}"];
  [@css
    ".css-andosm{height:-webkit-max-content;height:-moz-max-content;height:max-content;}"
  ];
  [@css
    ".css-13rnldk{height:-webkit-min-content;height:-moz-min-content;height:min-content;}"
  ];
  [@css ".css-17v0bv7{height:fit-content(10%);}"];
  [@css
    ".css-bg7q69{min-height:-webkit-max-content;min-height:-moz-max-content;min-height:max-content;}"
  ];
  [@css
    ".css-trzeqj{min-height:-webkit-min-content;min-height:-moz-min-content;min-height:min-content;}"
  ];
  [@css ".css-rugm1z{min-height:fit-content(10%);}"];
  [@css
    ".css-1av4i9x{max-height:-webkit-max-content;max-height:-moz-max-content;max-height:max-content;}"
  ];
  [@css
    ".css-1ixhvdk{max-height:-webkit-min-content;max-height:-moz-min-content;max-height:min-content;}"
  ];
  [@css ".css-rwd1sl{max-height:fit-content(10%);}"];
  [@css ".css-s9cgbo{aspect-ratio:auto;}"];
  [@css ".css-r0n2fv{aspect-ratio:2;}"];
  [@css ".css-7sbi16{aspect-ratio:16 / 9;}"];
  [@css
    ".css-ns27kc{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}"
  ];
  [@css
    ".css-1b8k7tn{min-width:-webkit-fit-content;min-width:-moz-fit-content;min-width:fit-content;}"
  ];
  [@css
    ".css-130hnfq{max-width:-webkit-fit-content;max-width:-moz-fit-content;max-width:fit-content;}"
  ];
  [@css
    ".css-10w0b28{height:-webkit-fit-content;height:-moz-fit-content;height:fit-content;}"
  ];
  [@css
    ".css-1g9qyps{min-height:-webkit-fit-content;min-height:-moz-fit-content;min-height:fit-content;}"
  ];
  [@css
    ".css-1wkiugr{max-height:-webkit-fit-content;max-height:-moz-fit-content;max-height:fit-content;}"
  ];
  [@css.classes
    [
      ("css-11ss374", 0, "", "input.re", 2, 8, 2, 26),
      ("css-1mrdhpb", 1, "", "input.re", 3, 8, 3, 26),
      ("css-6l2yg4", 2, "", "input.re", 4, 8, 4, 31),
      ("css-o0ablc", 3, "", "input.re", 5, 8, 5, 30),
      ("css-14if3hy", 4, "", "input.re", 6, 8, 6, 30),
      ("css-1hxdutz", 5, "", "input.re", 7, 8, 7, 35),
      ("css-wri28a", 6, "", "input.re", 8, 8, 8, 30),
      ("css-tz47m0", 7, "", "input.re", 9, 8, 9, 30),
      ("css-1qkrzio", 8, "", "input.re", 10, 8, 10, 35),
      ("css-andosm", 9, "", "input.re", 11, 8, 11, 27),
      ("css-13rnldk", 10, "", "input.re", 12, 8, 12, 27),
      ("css-17v0bv7", 11, "", "input.re", 13, 8, 13, 32),
      ("css-bg7q69", 12, "", "input.re", 14, 8, 14, 31),
      ("css-trzeqj", 13, "", "input.re", 15, 8, 15, 31),
      ("css-rugm1z", 14, "", "input.re", 16, 8, 16, 36),
      ("css-1av4i9x", 15, "", "input.re", 17, 8, 17, 31),
      ("css-1ixhvdk", 16, "", "input.re", 18, 8, 18, 31),
      ("css-rwd1sl", 17, "", "input.re", 19, 8, 19, 36),
      ("css-s9cgbo", 18, "", "input.re", 25, 8, 25, 26),
      ("css-r0n2fv", 19, "", "input.re", 26, 8, 26, 23),
      ("css-7sbi16", 20, "", "input.re", 27, 8, 27, 28),
      ("css-ns27kc", 21, "", "input.re", 41, 8, 41, 26),
      ("css-1b8k7tn", 22, "", "input.re", 44, 8, 44, 30),
      ("css-130hnfq", 23, "", "input.re", 47, 8, 47, 30),
      ("css-10w0b28", 24, "", "input.re", 50, 8, 50, 27),
      ("css-1g9qyps", 25, "", "input.re", 53, 8, 53, 31),
      ("css-1wkiugr", 26, "", "input.re", 56, 8, 56, 31),
    ]
  ];
  
  CSS.make("css-11ss374", []);
  CSS.make("css-1mrdhpb", []);
  CSS.make("css-6l2yg4", []);
  CSS.make("css-o0ablc", []);
  CSS.make("css-14if3hy", []);
  CSS.make("css-1hxdutz", []);
  CSS.make("css-wri28a", []);
  CSS.make("css-tz47m0", []);
  CSS.make("css-1qkrzio", []);
  CSS.make("css-andosm", []);
  CSS.make("css-13rnldk", []);
  CSS.make("css-17v0bv7", []);
  CSS.make("css-bg7q69", []);
  CSS.make("css-trzeqj", []);
  CSS.make("css-rugm1z", []);
  CSS.make("css-1av4i9x", []);
  CSS.make("css-1ixhvdk", []);
  CSS.make("css-rwd1sl", []);
  
  CSS.make("css-s9cgbo", []);
  CSS.make("css-r0n2fv", []);
  CSS.make("css-7sbi16", []);
  
  CSS.make("css-ns27kc", []);
  
  CSS.make("css-1b8k7tn", []);
  
  CSS.make("css-130hnfq", []);
  
  CSS.make("css-10w0b28", []);
  
  CSS.make("css-1g9qyps", []);
  
  CSS.make("css-1wkiugr", []);
