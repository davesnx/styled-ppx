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
  [@css ".css-py8wlh{touch-action:auto;}"];
  [@css ".css-ovmsds{touch-action:none;}"];
  [@css ".css-sossz4{touch-action:pan-x;}"];
  [@css ".css-119h34v{touch-action:pan-y;}"];
  [@css ".css-4ahy0g{touch-action:pan-x pan-y;}"];
  [@css ".css-1h8x31p{touch-action:manipulation;}"];
  [@css ".css-1sb6tov{touch-action:pan-left;}"];
  [@css ".css-16ra5w0{touch-action:pan-right;}"];
  [@css ".css-1nkngeu{touch-action:pan-up;}"];
  [@css ".css-1mcvizy{touch-action:pan-down;}"];
  [@css ".css-iq59sq{touch-action:pan-left pan-up;}"];
  [@css ".css-1ymq5k9{touch-action:pinch-zoom;}"];
  [@css ".css-v8eu9d{touch-action:pan-x pinch-zoom;}"];
  [@css ".css-5pbv2{touch-action:pan-y pinch-zoom;}"];
  [@css ".css-1dnn0zx{touch-action:pan-x pan-y pinch-zoom;}"];
  [@css.classes
    [
      ("css-py8wlh", 0, "", "input.re", 2, 8, 2, 26),
      ("css-ovmsds", 1, "", "input.re", 3, 8, 3, 26),
      ("css-sossz4", 2, "", "input.re", 4, 8, 4, 27),
      ("css-119h34v", 3, "", "input.re", 5, 8, 5, 27),
      ("css-4ahy0g", 4, "", "input.re", 6, 8, 6, 33),
      ("css-1h8x31p", 5, "", "input.re", 7, 8, 7, 34),
      ("css-1sb6tov", 6, "", "input.re", 10, 8, 10, 30),
      ("css-16ra5w0", 7, "", "input.re", 11, 8, 11, 31),
      ("css-1nkngeu", 8, "", "input.re", 12, 8, 12, 28),
      ("css-1mcvizy", 9, "", "input.re", 13, 8, 13, 30),
      ("css-iq59sq", 10, "", "input.re", 14, 8, 14, 37),
      ("css-1ymq5k9", 11, "", "input.re", 17, 8, 17, 32),
      ("css-v8eu9d", 12, "", "input.re", 18, 8, 18, 38),
      ("css-5pbv2", 13, "", "input.re", 19, 8, 19, 38),
      ("css-1dnn0zx", 14, "", "input.re", 20, 8, 20, 44),
    ]
  ];
  
  CSS.make("css-py8wlh", []);
  CSS.make("css-ovmsds", []);
  CSS.make("css-sossz4", []);
  CSS.make("css-119h34v", []);
  CSS.make("css-4ahy0g", []);
  CSS.make("css-1h8x31p", []);
  
  CSS.make("css-1sb6tov", []);
  CSS.make("css-16ra5w0", []);
  CSS.make("css-1nkngeu", []);
  CSS.make("css-1mcvizy", []);
  CSS.make("css-iq59sq", []);
  
  CSS.make("css-1ymq5k9", []);
  CSS.make("css-v8eu9d", []);
  CSS.make("css-5pbv2", []);
  CSS.make("css-1dnn0zx", []);
