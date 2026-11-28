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
  [@css ".css-ivpcvyf{margin-block-start:auto;}"];
  [@css ".css-ivpc8to{margin-block-start:0;}"];
  [@css ".css-ivpcxok{margin-block-start:10%;}"];
  [@css ".css-ivpc202{margin-block-start:calc(10px + 5%);}"];
  [@css ".css-ivpcdbe{margin-block-end:auto;}"];
  [@css ".css-ivpcnty{margin-block-end:0;}"];
  [@css ".css-ivpcm75{margin-block-end:10%;}"];
  [@css ".css-ivpcj7n{margin-block-end:calc(10px + 5%);}"];
  [@css
    ".css-ivpcwcp{-webkit-margin-inline-start:auto;margin-inline-start:auto;}"
  ];
  [@css ".css-ivpc1wi{-webkit-margin-inline-start:0;margin-inline-start:0;}"];
  [@css
    ".css-ivpcllh{-webkit-margin-inline-start:10%;margin-inline-start:10%;}"
  ];
  [@css
    ".css-ivpc2og{-webkit-margin-inline-start:calc(10px + 5%);margin-inline-start:calc(10px + 5%);}"
  ];
  [@css ".css-ivpc3hj{-webkit-margin-inline-end:auto;margin-inline-end:auto;}"];
  [@css ".css-ivpch6l{-webkit-margin-inline-end:0;margin-inline-end:0;}"];
  [@css ".css-ivpc10q{-webkit-margin-inline-end:10%;margin-inline-end:10%;}"];
  [@css
    ".css-ivpcwrs{-webkit-margin-inline-end:calc(10px + 5%);margin-inline-end:calc(10px + 5%);}"
  ];
  [@css ".css-ivpcgaa{padding-block-start:0;}"];
  [@css ".css-ivpc19l{padding-block-start:10%;}"];
  [@css ".css-ivpcq09{padding-block-start:calc(10px + 5%);}"];
  [@css ".css-ivpcf1o{padding-block-end:0;}"];
  [@css ".css-ivpcre8{padding-block-end:10%;}"];
  [@css ".css-ivpck5g{padding-block-end:calc(10px + 5%);}"];
  [@css ".css-ivpcewt{-webkit-padding-inline-start:0;padding-inline-start:0;}"];
  [@css
    ".css-ivpcvyd{-webkit-padding-inline-start:10%;padding-inline-start:10%;}"
  ];
  [@css
    ".css-ivpc36v{-webkit-padding-inline-start:calc(10px + 5%);padding-inline-start:calc(10px + 5%);}"
  ];
  [@css ".css-ivpcihg{-webkit-padding-inline-end:0;padding-inline-end:0;}"];
  [@css ".css-ivpcrnt{-webkit-padding-inline-end:10%;padding-inline-end:10%;}"];
  [@css
    ".css-ivpcqun{-webkit-padding-inline-end:calc(10px + 5%);padding-inline-end:calc(10px + 5%);}"
  ];
  [@css ".css-ivpcv7u{margin-block:auto auto;}"];
  [@css ".css-ivpcv15{margin-block:10px 20px;}"];
  [@css ".css-ivpc6c6{margin-block:10% 20%;}"];
  [@css ".css-ivpcccd{margin-inline:auto auto;}"];
  [@css ".css-ivpcmni{margin-inline:10px 20px;}"];
  [@css ".css-ivpcsq3{margin-inline:10% 20%;}"];
  [@css ".css-ivpcpem{padding-block:10px 20px;}"];
  [@css ".css-ivpcpzl{padding-block:10% 20%;}"];
  [@css ".css-ivpcdol{padding-inline:10px 20px;}"];
  [@css ".css-ivpcsyx{padding-inline:10% 20%;}"];
  [@css ".css-ivpcj32{border-block-width:thin;}"];
  [@css ".css-ivpcmv2{border-block-width:medium;}"];
  [@css ".css-ivpcea4{border-block-width:thick;}"];
  [@css ".css-ivpckty{border-block-width:2px;}"];
  [@css ".css-ivpc751{border-inline-width:thin;}"];
  [@css ".css-ivpcg6n{border-inline-width:medium;}"];
  [@css ".css-ivpc3xc{border-inline-width:thick;}"];
  [@css ".css-ivpck25{border-inline-width:2px;}"];
  [@css ".css-ivpcokm{border-block-style:none;}"];
  [@css ".css-ivpckih{border-block-style:solid;}"];
  [@css ".css-ivpc7uw{border-block-style:dashed;}"];
  [@css ".css-ivpcoyv{border-inline-style:none;}"];
  [@css ".css-ivpcofy{border-inline-style:solid;}"];
  [@css ".css-ivpc0mf{border-inline-style:dashed;}"];
  [@css.classes
    [
      ("css-ivpcvyf", 0, "", "input.re", 4, 8, 4, 32),
      ("css-ivpc8to", 1, "", "input.re", 5, 8, 5, 29),
      ("css-ivpcxok", 2, "", "input.re", 6, 8, 6, 31),
      ("css-ivpc202", 3, "", "input.re", 7, 8, 7, 43),
      ("css-ivpcdbe", 4, "", "input.re", 8, 8, 8, 30),
      ("css-ivpcnty", 5, "", "input.re", 9, 8, 9, 27),
      ("css-ivpcm75", 6, "", "input.re", 10, 8, 10, 29),
      ("css-ivpcj7n", 7, "", "input.re", 11, 8, 11, 41),
      ("css-ivpcwcp", 8, "", "input.re", 14, 8, 14, 33),
      ("css-ivpc1wi", 9, "", "input.re", 15, 8, 15, 30),
      ("css-ivpcllh", 10, "", "input.re", 16, 8, 16, 32),
      ("css-ivpc2og", 11, "", "input.re", 17, 8, 17, 44),
      ("css-ivpc3hj", 12, "", "input.re", 18, 8, 18, 31),
      ("css-ivpch6l", 13, "", "input.re", 19, 8, 19, 28),
      ("css-ivpc10q", 14, "", "input.re", 20, 8, 20, 30),
      ("css-ivpcwrs", 15, "", "input.re", 21, 8, 21, 42),
      ("css-ivpcgaa", 16, "", "input.re", 24, 8, 24, 30),
      ("css-ivpc19l", 17, "", "input.re", 25, 8, 25, 32),
      ("css-ivpcq09", 18, "", "input.re", 26, 8, 26, 44),
      ("css-ivpcf1o", 19, "", "input.re", 27, 8, 27, 28),
      ("css-ivpcre8", 20, "", "input.re", 28, 8, 28, 30),
      ("css-ivpck5g", 21, "", "input.re", 29, 8, 29, 42),
      ("css-ivpcewt", 22, "", "input.re", 32, 8, 32, 31),
      ("css-ivpcvyd", 23, "", "input.re", 33, 8, 33, 33),
      ("css-ivpc36v", 24, "", "input.re", 34, 8, 34, 45),
      ("css-ivpcihg", 25, "", "input.re", 35, 8, 35, 29),
      ("css-ivpcrnt", 26, "", "input.re", 36, 8, 36, 31),
      ("css-ivpcqun", 27, "", "input.re", 37, 8, 37, 43),
      ("css-ivpcv7u", 28, "", "input.re", 40, 8, 40, 31),
      ("css-ivpcv15", 29, "", "input.re", 41, 8, 41, 31),
      ("css-ivpc6c6", 30, "", "input.re", 42, 8, 42, 29),
      ("css-ivpcccd", 31, "", "input.re", 43, 8, 43, 32),
      ("css-ivpcmni", 32, "", "input.re", 44, 8, 44, 32),
      ("css-ivpcsq3", 33, "", "input.re", 45, 8, 45, 30),
      ("css-ivpcpem", 34, "", "input.re", 48, 8, 48, 32),
      ("css-ivpcpzl", 35, "", "input.re", 49, 8, 49, 30),
      ("css-ivpcdol", 36, "", "input.re", 50, 8, 50, 33),
      ("css-ivpcsyx", 37, "", "input.re", 51, 8, 51, 31),
      ("css-ivpcj32", 38, "", "input.re", 54, 8, 54, 32),
      ("css-ivpcmv2", 39, "", "input.re", 55, 8, 55, 34),
      ("css-ivpcea4", 40, "", "input.re", 56, 8, 56, 33),
      ("css-ivpckty", 41, "", "input.re", 57, 8, 57, 31),
      ("css-ivpc751", 42, "", "input.re", 58, 8, 58, 33),
      ("css-ivpcg6n", 43, "", "input.re", 59, 8, 59, 35),
      ("css-ivpc3xc", 44, "", "input.re", 60, 8, 60, 34),
      ("css-ivpck25", 45, "", "input.re", 61, 8, 61, 32),
      ("css-ivpcokm", 46, "", "input.re", 64, 8, 64, 32),
      ("css-ivpckih", 47, "", "input.re", 65, 8, 65, 33),
      ("css-ivpc7uw", 48, "", "input.re", 66, 8, 66, 34),
      ("css-ivpcoyv", 49, "", "input.re", 67, 8, 67, 33),
      ("css-ivpcofy", 50, "", "input.re", 68, 8, 68, 34),
      ("css-ivpc0mf", 51, "", "input.re", 69, 8, 69, 35),
    ]
  ];
  
  CSS.make("css-ivpcvyf", []);
  CSS.make("css-ivpc8to", []);
  CSS.make("css-ivpcxok", []);
  CSS.make("css-ivpc202", []);
  CSS.make("css-ivpcdbe", []);
  CSS.make("css-ivpcnty", []);
  CSS.make("css-ivpcm75", []);
  CSS.make("css-ivpcj7n", []);
  
  CSS.make("css-ivpcwcp", []);
  CSS.make("css-ivpc1wi", []);
  CSS.make("css-ivpcllh", []);
  CSS.make("css-ivpc2og", []);
  CSS.make("css-ivpc3hj", []);
  CSS.make("css-ivpch6l", []);
  CSS.make("css-ivpc10q", []);
  CSS.make("css-ivpcwrs", []);
  
  CSS.make("css-ivpcgaa", []);
  CSS.make("css-ivpc19l", []);
  CSS.make("css-ivpcq09", []);
  CSS.make("css-ivpcf1o", []);
  CSS.make("css-ivpcre8", []);
  CSS.make("css-ivpck5g", []);
  
  CSS.make("css-ivpcewt", []);
  CSS.make("css-ivpcvyd", []);
  CSS.make("css-ivpc36v", []);
  CSS.make("css-ivpcihg", []);
  CSS.make("css-ivpcrnt", []);
  CSS.make("css-ivpcqun", []);
  
  CSS.make("css-ivpcv7u", []);
  CSS.make("css-ivpcv15", []);
  CSS.make("css-ivpc6c6", []);
  CSS.make("css-ivpcccd", []);
  CSS.make("css-ivpcmni", []);
  CSS.make("css-ivpcsq3", []);
  
  CSS.make("css-ivpcpem", []);
  CSS.make("css-ivpcpzl", []);
  CSS.make("css-ivpcdol", []);
  CSS.make("css-ivpcsyx", []);
  
  CSS.make("css-ivpcj32", []);
  CSS.make("css-ivpcmv2", []);
  CSS.make("css-ivpcea4", []);
  CSS.make("css-ivpckty", []);
  CSS.make("css-ivpc751", []);
  CSS.make("css-ivpcg6n", []);
  CSS.make("css-ivpc3xc", []);
  CSS.make("css-ivpck25", []);
  
  CSS.make("css-ivpcokm", []);
  CSS.make("css-ivpckih", []);
  CSS.make("css-ivpc7uw", []);
  CSS.make("css-ivpcoyv", []);
  CSS.make("css-ivpcofy", []);
  CSS.make("css-ivpc0mf", []);
