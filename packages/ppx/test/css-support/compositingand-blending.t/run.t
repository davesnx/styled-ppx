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
  [@css ".css-ivpcv7a{mix-blend-mode:normal;}"];
  [@css ".css-ivpcp7z{mix-blend-mode:multiply;}"];
  [@css ".css-ivpchk6{mix-blend-mode:screen;}"];
  [@css ".css-ivpc4fq{mix-blend-mode:overlay;}"];
  [@css ".css-ivpcmkp{mix-blend-mode:darken;}"];
  [@css ".css-ivpc5me{mix-blend-mode:lighten;}"];
  [@css ".css-ivpcsyi{mix-blend-mode:color-dodge;}"];
  [@css ".css-ivpc3su{mix-blend-mode:color-burn;}"];
  [@css ".css-ivpcr4c{mix-blend-mode:hard-light;}"];
  [@css ".css-ivpcp1t{mix-blend-mode:soft-light;}"];
  [@css ".css-ivpcr8m{mix-blend-mode:difference;}"];
  [@css ".css-ivpcna6{mix-blend-mode:exclusion;}"];
  [@css ".css-ivpcse8{mix-blend-mode:hue;}"];
  [@css ".css-ivpc96q{mix-blend-mode:saturation;}"];
  [@css ".css-ivpcm68{mix-blend-mode:color;}"];
  [@css ".css-ivpcywj{mix-blend-mode:luminosity;}"];
  [@css ".css-ivpcccl{isolation:auto;}"];
  [@css ".css-ivpc8dg{isolation:isolate;}"];
  [@css ".css-ivpch0o{background-blend-mode:normal;}"];
  [@css ".css-ivpcq8dg{background-blend-mode:multiply;}"];
  [@css ".css-ivpc20n{background-blend-mode:screen;}"];
  [@css ".css-ivpcgky{background-blend-mode:overlay;}"];
  [@css ".css-ivpcht2{background-blend-mode:darken;}"];
  [@css ".css-ivpcnok{background-blend-mode:lighten;}"];
  [@css ".css-ivpcndx{background-blend-mode:color-dodge;}"];
  [@css ".css-ivpchdj{background-blend-mode:color-burn;}"];
  [@css ".css-ivpcaw6{background-blend-mode:hard-light;}"];
  [@css ".css-ivpce0p{background-blend-mode:soft-light;}"];
  [@css ".css-ivpct48{background-blend-mode:difference;}"];
  [@css ".css-ivpcvlr{background-blend-mode:exclusion;}"];
  [@css ".css-ivpcqso{background-blend-mode:hue;}"];
  [@css ".css-ivpc9bn{background-blend-mode:saturation;}"];
  [@css ".css-ivpc7e0{background-blend-mode:color;}"];
  [@css ".css-ivpcfse{background-blend-mode:luminosity;}"];
  [@css ".css-ivpc58o{background-blend-mode:normal, multiply;}"];
  [@css.classes
    [
      ("css-ivpcv7a", 0, "", "input.re", 2, 8, 2, 30),
      ("css-ivpcp7z", 1, "", "input.re", 3, 8, 3, 32),
      ("css-ivpchk6", 2, "", "input.re", 4, 8, 4, 30),
      ("css-ivpc4fq", 3, "", "input.re", 5, 8, 5, 31),
      ("css-ivpcmkp", 4, "", "input.re", 6, 8, 6, 30),
      ("css-ivpc5me", 5, "", "input.re", 7, 8, 7, 31),
      ("css-ivpcsyi", 6, "", "input.re", 8, 8, 8, 35),
      ("css-ivpc3su", 7, "", "input.re", 9, 8, 9, 34),
      ("css-ivpcr4c", 8, "", "input.re", 10, 8, 10, 34),
      ("css-ivpcp1t", 9, "", "input.re", 11, 8, 11, 34),
      ("css-ivpcr8m", 10, "", "input.re", 12, 8, 12, 34),
      ("css-ivpcna6", 11, "", "input.re", 13, 8, 13, 33),
      ("css-ivpcse8", 12, "", "input.re", 14, 8, 14, 27),
      ("css-ivpc96q", 13, "", "input.re", 15, 8, 15, 34),
      ("css-ivpcm68", 14, "", "input.re", 16, 8, 16, 29),
      ("css-ivpcywj", 15, "", "input.re", 17, 8, 17, 34),
      ("css-ivpcccl", 16, "", "input.re", 18, 8, 18, 23),
      ("css-ivpc8dg", 17, "", "input.re", 19, 8, 19, 26),
      ("css-ivpch0o", 18, "", "input.re", 20, 8, 20, 37),
      ("css-ivpcq8dg", 19, "", "input.re", 21, 8, 21, 39),
      ("css-ivpc20n", 20, "", "input.re", 22, 8, 22, 37),
      ("css-ivpcgky", 21, "", "input.re", 23, 8, 23, 38),
      ("css-ivpcht2", 22, "", "input.re", 24, 8, 24, 37),
      ("css-ivpcnok", 23, "", "input.re", 25, 8, 25, 38),
      ("css-ivpcndx", 24, "", "input.re", 26, 8, 26, 42),
      ("css-ivpchdj", 25, "", "input.re", 27, 8, 27, 41),
      ("css-ivpcaw6", 26, "", "input.re", 28, 8, 28, 41),
      ("css-ivpce0p", 27, "", "input.re", 29, 8, 29, 41),
      ("css-ivpct48", 28, "", "input.re", 30, 8, 30, 41),
      ("css-ivpcvlr", 29, "", "input.re", 31, 8, 31, 40),
      ("css-ivpcqso", 30, "", "input.re", 32, 8, 32, 34),
      ("css-ivpc9bn", 31, "", "input.re", 33, 8, 33, 41),
      ("css-ivpc7e0", 32, "", "input.re", 34, 8, 34, 36),
      ("css-ivpcfse", 33, "", "input.re", 35, 8, 35, 41),
      ("css-ivpc58o", 34, "", "input.re", 36, 8, 36, 47),
    ]
  ];
  
  CSS.make("css-ivpcv7a", []);
  CSS.make("css-ivpcp7z", []);
  CSS.make("css-ivpchk6", []);
  CSS.make("css-ivpc4fq", []);
  CSS.make("css-ivpcmkp", []);
  CSS.make("css-ivpc5me", []);
  CSS.make("css-ivpcsyi", []);
  CSS.make("css-ivpc3su", []);
  CSS.make("css-ivpcr4c", []);
  CSS.make("css-ivpcp1t", []);
  CSS.make("css-ivpcr8m", []);
  CSS.make("css-ivpcna6", []);
  CSS.make("css-ivpcse8", []);
  CSS.make("css-ivpc96q", []);
  CSS.make("css-ivpcm68", []);
  CSS.make("css-ivpcywj", []);
  CSS.make("css-ivpcccl", []);
  CSS.make("css-ivpc8dg", []);
  CSS.make("css-ivpch0o", []);
  CSS.make("css-ivpcq8dg", []);
  CSS.make("css-ivpc20n", []);
  CSS.make("css-ivpcgky", []);
  CSS.make("css-ivpcht2", []);
  CSS.make("css-ivpcnok", []);
  CSS.make("css-ivpcndx", []);
  CSS.make("css-ivpchdj", []);
  CSS.make("css-ivpcaw6", []);
  CSS.make("css-ivpce0p", []);
  CSS.make("css-ivpct48", []);
  CSS.make("css-ivpcvlr", []);
  CSS.make("css-ivpcqso", []);
  CSS.make("css-ivpc9bn", []);
  CSS.make("css-ivpc7e0", []);
  CSS.make("css-ivpcfse", []);
  CSS.make("css-ivpc58o", []);
