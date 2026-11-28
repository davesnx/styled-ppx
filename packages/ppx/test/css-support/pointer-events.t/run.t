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
  [@css ".css-ivpcwlh{touch-action:auto;}"];
  [@css ".css-ivpcsds{touch-action:none;}"];
  [@css ".css-ivpcsz4{touch-action:pan-x;}"];
  [@css ".css-ivpc34v{touch-action:pan-y;}"];
  [@css ".css-ivpcy0g{touch-action:pan-x pan-y;}"];
  [@css ".css-ivpc31p{touch-action:manipulation;}"];
  [@css ".css-ivpctov{touch-action:pan-left;}"];
  [@css ".css-ivpc5w0{touch-action:pan-right;}"];
  [@css ".css-ivpcgeu{touch-action:pan-up;}"];
  [@css ".css-ivpcizy{touch-action:pan-down;}"];
  [@css ".css-ivpc9sq{touch-action:pan-left pan-up;}"];
  [@css ".css-ivpc5k9{touch-action:pinch-zoom;}"];
  [@css ".css-ivpcu9d{touch-action:pan-x pinch-zoom;}"];
  [@css ".css-ivpcbv2{touch-action:pan-y pinch-zoom;}"];
  [@css ".css-ivpc0zx{touch-action:pan-x pan-y pinch-zoom;}"];
  [@css.classes
    [
      ("css-ivpcwlh", 0, "", "input.re", 2, 8, 2, 26),
      ("css-ivpcsds", 1, "", "input.re", 3, 8, 3, 26),
      ("css-ivpcsz4", 2, "", "input.re", 4, 8, 4, 27),
      ("css-ivpc34v", 3, "", "input.re", 5, 8, 5, 27),
      ("css-ivpcy0g", 4, "", "input.re", 6, 8, 6, 33),
      ("css-ivpc31p", 5, "", "input.re", 7, 8, 7, 34),
      ("css-ivpctov", 6, "", "input.re", 10, 8, 10, 30),
      ("css-ivpc5w0", 7, "", "input.re", 11, 8, 11, 31),
      ("css-ivpcgeu", 8, "", "input.re", 12, 8, 12, 28),
      ("css-ivpcizy", 9, "", "input.re", 13, 8, 13, 30),
      ("css-ivpc9sq", 10, "", "input.re", 14, 8, 14, 37),
      ("css-ivpc5k9", 11, "", "input.re", 17, 8, 17, 32),
      ("css-ivpcu9d", 12, "", "input.re", 18, 8, 18, 38),
      ("css-ivpcbv2", 13, "", "input.re", 19, 8, 19, 38),
      ("css-ivpc0zx", 14, "", "input.re", 20, 8, 20, 44),
    ]
  ];
  
  CSS.make("css-ivpcwlh", []);
  CSS.make("css-ivpcsds", []);
  CSS.make("css-ivpcsz4", []);
  CSS.make("css-ivpc34v", []);
  CSS.make("css-ivpcy0g", []);
  CSS.make("css-ivpc31p", []);
  
  CSS.make("css-ivpctov", []);
  CSS.make("css-ivpc5w0", []);
  CSS.make("css-ivpcgeu", []);
  CSS.make("css-ivpcizy", []);
  CSS.make("css-ivpc9sq", []);
  
  CSS.make("css-ivpc5k9", []);
  CSS.make("css-ivpcu9d", []);
  CSS.make("css-ivpcbv2", []);
  CSS.make("css-ivpc0zx", []);
