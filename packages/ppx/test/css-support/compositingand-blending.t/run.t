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
  [@css ".css-vfgv7a{mix-blend-mode:normal;}"];
  [@css ".css-difp7z{mix-blend-mode:multiply;}"];
  [@css ".css-kokhk6{mix-blend-mode:screen;}"];
  [@css ".css-11ph4fq{mix-blend-mode:overlay;}"];
  [@css ".css-1izkmkp{mix-blend-mode:darken;}"];
  [@css ".css-xow5me{mix-blend-mode:lighten;}"];
  [@css ".css-1cfssyi{mix-blend-mode:color-dodge;}"];
  [@css ".css-6re3su{mix-blend-mode:color-burn;}"];
  [@css ".css-76jr4c{mix-blend-mode:hard-light;}"];
  [@css ".css-1l40p1t{mix-blend-mode:soft-light;}"];
  [@css ".css-1rgar8m{mix-blend-mode:difference;}"];
  [@css ".css-1aqwna6{mix-blend-mode:exclusion;}"];
  [@css ".css-1gbwse8{mix-blend-mode:hue;}"];
  [@css ".css-15bi96q{mix-blend-mode:saturation;}"];
  [@css ".css-1hrom68{mix-blend-mode:color;}"];
  [@css ".css-14zfywj{mix-blend-mode:luminosity;}"];
  [@css ".css-1er8ccl{isolation:auto;}"];
  [@css ".css-149s8dg{isolation:isolate;}"];
  [@css ".css-grph0o{background-blend-mode:normal;}"];
  [@css ".css-1pqq8dg{background-blend-mode:multiply;}"];
  [@css ".css-1tmo20n{background-blend-mode:screen;}"];
  [@css ".css-1nimgky{background-blend-mode:overlay;}"];
  [@css ".css-5yvht2{background-blend-mode:darken;}"];
  [@css ".css-168znok{background-blend-mode:lighten;}"];
  [@css ".css-hiyndx{background-blend-mode:color-dodge;}"];
  [@css ".css-1nu3hdj{background-blend-mode:color-burn;}"];
  [@css ".css-slmaw6{background-blend-mode:hard-light;}"];
  [@css ".css-14k7e0p{background-blend-mode:soft-light;}"];
  [@css ".css-1stgt48{background-blend-mode:difference;}"];
  [@css ".css-axhvlr{background-blend-mode:exclusion;}"];
  [@css ".css-11gdqso{background-blend-mode:hue;}"];
  [@css ".css-14jx9bn{background-blend-mode:saturation;}"];
  [@css ".css-s6p7e0{background-blend-mode:color;}"];
  [@css ".css-2tfse{background-blend-mode:luminosity;}"];
  [@css ".css-1w2c58o{background-blend-mode:normal, multiply;}"];
  [@css.classes
    [
      ("css-vfgv7a", 0, "", "input.re", 2, 8, 2, 30),
      ("css-difp7z", 1, "", "input.re", 3, 8, 3, 32),
      ("css-kokhk6", 2, "", "input.re", 4, 8, 4, 30),
      ("css-11ph4fq", 3, "", "input.re", 5, 8, 5, 31),
      ("css-1izkmkp", 4, "", "input.re", 6, 8, 6, 30),
      ("css-xow5me", 5, "", "input.re", 7, 8, 7, 31),
      ("css-1cfssyi", 6, "", "input.re", 8, 8, 8, 35),
      ("css-6re3su", 7, "", "input.re", 9, 8, 9, 34),
      ("css-76jr4c", 8, "", "input.re", 10, 8, 10, 34),
      ("css-1l40p1t", 9, "", "input.re", 11, 8, 11, 34),
      ("css-1rgar8m", 10, "", "input.re", 12, 8, 12, 34),
      ("css-1aqwna6", 11, "", "input.re", 13, 8, 13, 33),
      ("css-1gbwse8", 12, "", "input.re", 14, 8, 14, 27),
      ("css-15bi96q", 13, "", "input.re", 15, 8, 15, 34),
      ("css-1hrom68", 14, "", "input.re", 16, 8, 16, 29),
      ("css-14zfywj", 15, "", "input.re", 17, 8, 17, 34),
      ("css-1er8ccl", 16, "", "input.re", 18, 8, 18, 23),
      ("css-149s8dg", 17, "", "input.re", 19, 8, 19, 26),
      ("css-grph0o", 18, "", "input.re", 20, 8, 20, 37),
      ("css-1pqq8dg", 19, "", "input.re", 21, 8, 21, 39),
      ("css-1tmo20n", 20, "", "input.re", 22, 8, 22, 37),
      ("css-1nimgky", 21, "", "input.re", 23, 8, 23, 38),
      ("css-5yvht2", 22, "", "input.re", 24, 8, 24, 37),
      ("css-168znok", 23, "", "input.re", 25, 8, 25, 38),
      ("css-hiyndx", 24, "", "input.re", 26, 8, 26, 42),
      ("css-1nu3hdj", 25, "", "input.re", 27, 8, 27, 41),
      ("css-slmaw6", 26, "", "input.re", 28, 8, 28, 41),
      ("css-14k7e0p", 27, "", "input.re", 29, 8, 29, 41),
      ("css-1stgt48", 28, "", "input.re", 30, 8, 30, 41),
      ("css-axhvlr", 29, "", "input.re", 31, 8, 31, 40),
      ("css-11gdqso", 30, "", "input.re", 32, 8, 32, 34),
      ("css-14jx9bn", 31, "", "input.re", 33, 8, 33, 41),
      ("css-s6p7e0", 32, "", "input.re", 34, 8, 34, 36),
      ("css-2tfse", 33, "", "input.re", 35, 8, 35, 41),
      ("css-1w2c58o", 34, "", "input.re", 36, 8, 36, 47),
    ]
  ];
  
  CSS.make("css-vfgv7a", []);
  CSS.make("css-difp7z", []);
  CSS.make("css-kokhk6", []);
  CSS.make("css-11ph4fq", []);
  CSS.make("css-1izkmkp", []);
  CSS.make("css-xow5me", []);
  CSS.make("css-1cfssyi", []);
  CSS.make("css-6re3su", []);
  CSS.make("css-76jr4c", []);
  CSS.make("css-1l40p1t", []);
  CSS.make("css-1rgar8m", []);
  CSS.make("css-1aqwna6", []);
  CSS.make("css-1gbwse8", []);
  CSS.make("css-15bi96q", []);
  CSS.make("css-1hrom68", []);
  CSS.make("css-14zfywj", []);
  CSS.make("css-1er8ccl", []);
  CSS.make("css-149s8dg", []);
  CSS.make("css-grph0o", []);
  CSS.make("css-1pqq8dg", []);
  CSS.make("css-1tmo20n", []);
  CSS.make("css-1nimgky", []);
  CSS.make("css-5yvht2", []);
  CSS.make("css-168znok", []);
  CSS.make("css-hiyndx", []);
  CSS.make("css-1nu3hdj", []);
  CSS.make("css-slmaw6", []);
  CSS.make("css-14k7e0p", []);
  CSS.make("css-1stgt48", []);
  CSS.make("css-axhvlr", []);
  CSS.make("css-11gdqso", []);
  CSS.make("css-14jx9bn", []);
  CSS.make("css-s6p7e0", []);
  CSS.make("css-2tfse", []);
  CSS.make("css-1w2c58o", []);
