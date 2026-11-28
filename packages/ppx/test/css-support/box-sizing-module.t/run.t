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
    ".css-ivpc374{width:-webkit-max-content;width:-moz-max-content;width:max-content;}"
  ];
  [@css
    ".css-ivpchpb{width:-webkit-min-content;width:-moz-min-content;width:min-content;}"
  ];
  [@css ".css-ivpcyg4{width:fit-content(10%);}"];
  [@css
    ".css-ivpcblc{min-width:-webkit-max-content;min-width:-moz-max-content;min-width:max-content;}"
  ];
  [@css
    ".css-ivpc3hy{min-width:-webkit-min-content;min-width:-moz-min-content;min-width:min-content;}"
  ];
  [@css ".css-ivpcutz{min-width:fit-content(10%);}"];
  [@css
    ".css-ivpc28a{max-width:-webkit-max-content;max-width:-moz-max-content;max-width:max-content;}"
  ];
  [@css
    ".css-ivpc7m0{max-width:-webkit-min-content;max-width:-moz-min-content;max-width:min-content;}"
  ];
  [@css ".css-ivpczio{max-width:fit-content(10%);}"];
  [@css
    ".css-ivpcosm{height:-webkit-max-content;height:-moz-max-content;height:max-content;}"
  ];
  [@css
    ".css-ivpcldk{height:-webkit-min-content;height:-moz-min-content;height:min-content;}"
  ];
  [@css ".css-ivpcbv7{height:fit-content(10%);}"];
  [@css
    ".css-ivpcq69{min-height:-webkit-max-content;min-height:-moz-max-content;min-height:max-content;}"
  ];
  [@css
    ".css-ivpceqj{min-height:-webkit-min-content;min-height:-moz-min-content;min-height:min-content;}"
  ];
  [@css ".css-ivpcm1z{min-height:fit-content(10%);}"];
  [@css
    ".css-ivpci9x{max-height:-webkit-max-content;max-height:-moz-max-content;max-height:max-content;}"
  ];
  [@css
    ".css-ivpcvdk{max-height:-webkit-min-content;max-height:-moz-min-content;max-height:min-content;}"
  ];
  [@css ".css-ivpc1sl{max-height:fit-content(10%);}"];
  [@css ".css-ivpcgbo{aspect-ratio:auto;}"];
  [@css ".css-ivpc2fv{aspect-ratio:2;}"];
  [@css ".css-ivpci16{aspect-ratio:16 / 9;}"];
  [@css
    ".css-ivpc7kc{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}"
  ];
  [@css
    ".css-ivpc7tn{min-width:-webkit-fit-content;min-width:-moz-fit-content;min-width:fit-content;}"
  ];
  [@css
    ".css-ivpcnfq{max-width:-webkit-fit-content;max-width:-moz-fit-content;max-width:fit-content;}"
  ];
  [@css
    ".css-ivpcb28{height:-webkit-fit-content;height:-moz-fit-content;height:fit-content;}"
  ];
  [@css
    ".css-ivpcyps{min-height:-webkit-fit-content;min-height:-moz-fit-content;min-height:fit-content;}"
  ];
  [@css
    ".css-ivpcugr{max-height:-webkit-fit-content;max-height:-moz-fit-content;max-height:fit-content;}"
  ];
  [@css.classes
    [
      ("css-ivpc374", 0, "", "input.re", 2, 8, 2, 26),
      ("css-ivpchpb", 1, "", "input.re", 3, 8, 3, 26),
      ("css-ivpcyg4", 2, "", "input.re", 4, 8, 4, 31),
      ("css-ivpcblc", 3, "", "input.re", 5, 8, 5, 30),
      ("css-ivpc3hy", 4, "", "input.re", 6, 8, 6, 30),
      ("css-ivpcutz", 5, "", "input.re", 7, 8, 7, 35),
      ("css-ivpc28a", 6, "", "input.re", 8, 8, 8, 30),
      ("css-ivpc7m0", 7, "", "input.re", 9, 8, 9, 30),
      ("css-ivpczio", 8, "", "input.re", 10, 8, 10, 35),
      ("css-ivpcosm", 9, "", "input.re", 11, 8, 11, 27),
      ("css-ivpcldk", 10, "", "input.re", 12, 8, 12, 27),
      ("css-ivpcbv7", 11, "", "input.re", 13, 8, 13, 32),
      ("css-ivpcq69", 12, "", "input.re", 14, 8, 14, 31),
      ("css-ivpceqj", 13, "", "input.re", 15, 8, 15, 31),
      ("css-ivpcm1z", 14, "", "input.re", 16, 8, 16, 36),
      ("css-ivpci9x", 15, "", "input.re", 17, 8, 17, 31),
      ("css-ivpcvdk", 16, "", "input.re", 18, 8, 18, 31),
      ("css-ivpc1sl", 17, "", "input.re", 19, 8, 19, 36),
      ("css-ivpcgbo", 18, "", "input.re", 25, 8, 25, 26),
      ("css-ivpc2fv", 19, "", "input.re", 26, 8, 26, 23),
      ("css-ivpci16", 20, "", "input.re", 27, 8, 27, 28),
      ("css-ivpc7kc", 21, "", "input.re", 41, 8, 41, 26),
      ("css-ivpc7tn", 22, "", "input.re", 44, 8, 44, 30),
      ("css-ivpcnfq", 23, "", "input.re", 47, 8, 47, 30),
      ("css-ivpcb28", 24, "", "input.re", 50, 8, 50, 27),
      ("css-ivpcyps", 25, "", "input.re", 53, 8, 53, 31),
      ("css-ivpcugr", 26, "", "input.re", 56, 8, 56, 31),
    ]
  ];
  
  CSS.make("css-ivpc374", []);
  CSS.make("css-ivpchpb", []);
  CSS.make("css-ivpcyg4", []);
  CSS.make("css-ivpcblc", []);
  CSS.make("css-ivpc3hy", []);
  CSS.make("css-ivpcutz", []);
  CSS.make("css-ivpc28a", []);
  CSS.make("css-ivpc7m0", []);
  CSS.make("css-ivpczio", []);
  CSS.make("css-ivpcosm", []);
  CSS.make("css-ivpcldk", []);
  CSS.make("css-ivpcbv7", []);
  CSS.make("css-ivpcq69", []);
  CSS.make("css-ivpceqj", []);
  CSS.make("css-ivpcm1z", []);
  CSS.make("css-ivpci9x", []);
  CSS.make("css-ivpcvdk", []);
  CSS.make("css-ivpc1sl", []);
  
  CSS.make("css-ivpcgbo", []);
  CSS.make("css-ivpc2fv", []);
  CSS.make("css-ivpci16", []);
  
  CSS.make("css-ivpc7kc", []);
  
  CSS.make("css-ivpc7tn", []);
  
  CSS.make("css-ivpcnfq", []);
  
  CSS.make("css-ivpcb28", []);
  
  CSS.make("css-ivpcyps", []);
  
  CSS.make("css-ivpcugr", []);
