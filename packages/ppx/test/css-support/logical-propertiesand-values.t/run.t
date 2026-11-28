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
  [@css ".css-ivpc79u{caption-side:inline-start;}"];
  [@css ".css-ivpcp43{caption-side:inline-end;}"];
  [@css ".css-ivpcr4a{float:inline-start;}"];
  [@css ".css-ivpcx20{float:inline-end;}"];
  [@css ".css-ivpck00{clear:inline-start;}"];
  [@css ".css-ivpcdzw{clear:inline-end;}"];
  [@css ".css-ivpcw47{resize:block;}"];
  [@css ".css-ivpc9i6{resize:inline;}"];
  [@css ".css-ivpcsv2{block-size:100px;}"];
  [@css ".css-ivpc6hn{inline-size:100px;}"];
  [@css ".css-ivpcmlh{min-block-size:100px;}"];
  [@css ".css-ivpccln{min-inline-size:100px;}"];
  [@css ".css-ivpcdm0{max-block-size:100px;}"];
  [@css ".css-ivpcxwp{max-inline-size:100px;}"];
  [@css ".css-ivpc441{margin-block:10px;}"];
  [@css ".css-ivpcau3{margin-block:10px 10px;}"];
  [@css ".css-ivpc4jr{margin-block-start:10px;}"];
  [@css ".css-ivpcd8m{margin-block-end:10px;}"];
  [@css ".css-ivpc236{margin-inline:10px;}"];
  [@css ".css-ivpcu5a{margin-inline:10px 10px;}"];
  [@css
    ".css-ivpceom{-webkit-margin-inline-start:10px;margin-inline-start:10px;}"
  ];
  [@css ".css-ivpc16h{-webkit-margin-inline-end:10px;margin-inline-end:10px;}"];
  [@css ".css-ivpcnfh{inset:10px;}"];
  [@css ".css-ivpcniv{inset:10px 10px;}"];
  [@css ".css-ivpc223{inset:10px 10px 10px;}"];
  [@css ".css-ivpczxm{inset:10px 10px 10px 10px;}"];
  [@css ".css-ivpci6x{inset-block:10px;}"];
  [@css ".css-ivpc543{inset-block:10px 10px;}"];
  [@css ".css-ivpcf8u{inset-block-start:10px;}"];
  [@css ".css-ivpchvz{inset-block-end:10px;}"];
  [@css ".css-ivpcea3{inset-inline:10px;}"];
  [@css ".css-ivpcfbq{inset-inline:10px 10px;}"];
  [@css ".css-ivpc462{inset-inline-start:10px;}"];
  [@css ".css-ivpct9e{inset-inline-end:10px;}"];
  [@css ".css-ivpcncu{padding-block:10px;}"];
  [@css ".css-ivpc887{padding-block:10px 10px;}"];
  [@css ".css-ivpcxy7{padding-block-start:10px;}"];
  [@css ".css-ivpc76y{padding-block-end:10px;}"];
  [@css ".css-ivpc6su{padding-inline:10px;}"];
  [@css ".css-ivpc71r{padding-inline:10px 10px;}"];
  [@css
    ".css-ivpcxcj{-webkit-padding-inline-start:10px;padding-inline-start:10px;}"
  ];
  [@css
    ".css-ivpcisa{-webkit-padding-inline-end:10px;padding-inline-end:10px;}"
  ];
  [@css ".css-ivpcyuh{border-block:1px;}"];
  [@css ".css-ivpc02m{border-block:2px dotted;}"];
  [@css ".css-ivpcm57{border-block:medium dashed green;}"];
  [@css ".css-ivpckyu{border-block-start:1px;}"];
  [@css ".css-ivpcnk8{border-block-start:2px dotted;}"];
  [@css ".css-ivpc2dr{border-block-start:medium dashed green;}"];
  [@css ".css-ivpc9fl{border-block-start-width:thin;}"];
  [@css ".css-ivpc7up{border-block-start-style:dotted;}"];
  [@css ".css-ivpci83{border-block-start-color:navy;}"];
  [@css ".css-ivpc1he{border-block-end:1px;}"];
  [@css ".css-ivpccyo{border-block-end:2px dotted;}"];
  [@css ".css-ivpcshu{border-block-end:medium dashed green;}"];
  [@css ".css-ivpcmkl{border-block-end-width:thin;}"];
  [@css ".css-ivpcx5j{border-block-end-style:dotted;}"];
  [@css ".css-ivpchab{border-block-end-color:navy;}"];
  [@css ".css-ivpcrhu{border-block-color:navy blue;}"];
  [@css ".css-ivpcv6v{border-inline:1px;}"];
  [@css ".css-ivpciqu{border-inline:2px dotted;}"];
  [@css ".css-ivpc6bq{border-inline:medium dashed green;}"];
  [@css ".css-ivpc03w{border-inline-start:1px;}"];
  [@css ".css-ivpc7c1{border-inline-start:2px dotted;}"];
  [@css ".css-ivpcfm1{border-inline-start:medium dashed green;}"];
  [@css ".css-ivpcm9x{border-inline-start-width:thin;}"];
  [@css ".css-ivpcvxn{border-inline-start-style:dotted;}"];
  [@css ".css-ivpccpl{border-inline-start-color:navy;}"];
  [@css ".css-ivpcsxv{border-inline-end:1px;}"];
  [@css ".css-ivpcx1k{border-inline-end:2px dotted;}"];
  [@css ".css-ivpcgvx{border-inline-end:medium dashed green;}"];
  [@css ".css-ivpcztd{border-inline-end-width:thin;}"];
  [@css ".css-ivpcsr5{border-inline-end-style:dotted;}"];
  [@css ".css-ivpc01k{border-inline-end-color:navy;}"];
  [@css ".css-ivpcwf5{border-inline-color:navy blue;}"];
  [@css ".css-ivpcgj8{border-start-start-radius:0;}"];
  [@css ".css-ivpczws{border-start-start-radius:50%;}"];
  [@css ".css-ivpcr8g{border-start-start-radius:250px 100px;}"];
  [@css ".css-ivpceji{border-start-end-radius:0;}"];
  [@css ".css-ivpcpxb{border-start-end-radius:50%;}"];
  [@css ".css-ivpc90r{border-start-end-radius:250px 100px;}"];
  [@css ".css-ivpcfpi{border-end-start-radius:0;}"];
  [@css ".css-ivpcwqa{border-end-start-radius:50%;}"];
  [@css ".css-ivpcqvg{border-end-start-radius:250px 100px;}"];
  [@css ".css-ivpcxx5{border-end-end-radius:0;}"];
  [@css ".css-ivpcxna{border-end-end-radius:50%;}"];
  [@css ".css-ivpcr0b{border-end-end-radius:250px 100px;}"];
  [@css.classes
    [
      ("css-ivpc79u", 0, "", "input.re", 2, 8, 2, 34),
      ("css-ivpcp43", 1, "", "input.re", 3, 8, 3, 32),
      ("css-ivpcr4a", 2, "", "input.re", 4, 8, 4, 27),
      ("css-ivpcx20", 3, "", "input.re", 5, 8, 5, 25),
      ("css-ivpck00", 4, "", "input.re", 6, 8, 6, 27),
      ("css-ivpcdzw", 5, "", "input.re", 7, 8, 7, 25),
      ("css-ivpcw47", 6, "", "input.re", 8, 8, 8, 21),
      ("css-ivpc9i6", 7, "", "input.re", 9, 8, 9, 22),
      ("css-ivpcsv2", 8, "", "input.re", 10, 8, 10, 25),
      ("css-ivpc6hn", 9, "", "input.re", 11, 8, 11, 26),
      ("css-ivpcmlh", 10, "", "input.re", 12, 8, 12, 29),
      ("css-ivpccln", 11, "", "input.re", 13, 8, 13, 30),
      ("css-ivpcdm0", 12, "", "input.re", 14, 8, 14, 29),
      ("css-ivpcxwp", 13, "", "input.re", 15, 8, 15, 30),
      ("css-ivpc441", 14, "", "input.re", 16, 8, 16, 26),
      ("css-ivpcau3", 15, "", "input.re", 17, 8, 17, 31),
      ("css-ivpc4jr", 16, "", "input.re", 18, 8, 18, 32),
      ("css-ivpcd8m", 17, "", "input.re", 19, 8, 19, 30),
      ("css-ivpc236", 18, "", "input.re", 20, 8, 20, 27),
      ("css-ivpcu5a", 19, "", "input.re", 21, 8, 21, 32),
      ("css-ivpceom", 20, "", "input.re", 22, 8, 22, 33),
      ("css-ivpc16h", 21, "", "input.re", 23, 8, 23, 31),
      ("css-ivpcnfh", 22, "", "input.re", 24, 8, 24, 19),
      ("css-ivpcniv", 23, "", "input.re", 25, 8, 25, 24),
      ("css-ivpc223", 24, "", "input.re", 26, 8, 26, 29),
      ("css-ivpczxm", 25, "", "input.re", 27, 8, 27, 34),
      ("css-ivpci6x", 26, "", "input.re", 28, 8, 28, 25),
      ("css-ivpc543", 27, "", "input.re", 29, 8, 29, 30),
      ("css-ivpcf8u", 28, "", "input.re", 30, 8, 30, 31),
      ("css-ivpchvz", 29, "", "input.re", 31, 8, 31, 29),
      ("css-ivpcea3", 30, "", "input.re", 32, 8, 32, 26),
      ("css-ivpcfbq", 31, "", "input.re", 33, 8, 33, 31),
      ("css-ivpc462", 32, "", "input.re", 34, 8, 34, 32),
      ("css-ivpct9e", 33, "", "input.re", 35, 8, 35, 30),
      ("css-ivpcncu", 34, "", "input.re", 36, 8, 36, 27),
      ("css-ivpc887", 35, "", "input.re", 37, 8, 37, 32),
      ("css-ivpcxy7", 36, "", "input.re", 38, 8, 38, 33),
      ("css-ivpc76y", 37, "", "input.re", 39, 8, 39, 31),
      ("css-ivpc6su", 38, "", "input.re", 40, 8, 40, 28),
      ("css-ivpc71r", 39, "", "input.re", 41, 8, 41, 33),
      ("css-ivpcxcj", 40, "", "input.re", 42, 8, 42, 34),
      ("css-ivpcisa", 41, "", "input.re", 43, 8, 43, 32),
      ("css-ivpcyuh", 42, "", "input.re", 44, 8, 44, 25),
      ("css-ivpc02m", 43, "", "input.re", 45, 8, 45, 32),
      ("css-ivpcm57", 44, "", "input.re", 46, 8, 46, 41),
      ("css-ivpckyu", 45, "", "input.re", 47, 8, 47, 31),
      ("css-ivpcnk8", 46, "", "input.re", 48, 8, 48, 38),
      ("css-ivpc2dr", 47, "", "input.re", 49, 8, 49, 47),
      ("css-ivpc9fl", 48, "", "input.re", 50, 8, 50, 38),
      ("css-ivpc7up", 49, "", "input.re", 51, 8, 51, 40),
      ("css-ivpci83", 50, "", "input.re", 52, 8, 52, 38),
      ("css-ivpc1he", 51, "", "input.re", 53, 8, 53, 29),
      ("css-ivpccyo", 52, "", "input.re", 54, 8, 54, 36),
      ("css-ivpcshu", 53, "", "input.re", 55, 8, 55, 45),
      ("css-ivpcmkl", 54, "", "input.re", 56, 8, 56, 36),
      ("css-ivpcx5j", 55, "", "input.re", 57, 8, 57, 38),
      ("css-ivpchab", 56, "", "input.re", 58, 8, 58, 36),
      ("css-ivpcrhu", 57, "", "input.re", 61, 8, 61, 37),
      ("css-ivpcv6v", 58, "", "input.re", 62, 8, 62, 26),
      ("css-ivpciqu", 59, "", "input.re", 63, 8, 63, 33),
      ("css-ivpc6bq", 60, "", "input.re", 64, 8, 64, 42),
      ("css-ivpc03w", 61, "", "input.re", 65, 8, 65, 32),
      ("css-ivpc7c1", 62, "", "input.re", 66, 8, 66, 39),
      ("css-ivpcfm1", 63, "", "input.re", 67, 8, 67, 48),
      ("css-ivpcm9x", 64, "", "input.re", 68, 8, 68, 39),
      ("css-ivpcvxn", 65, "", "input.re", 69, 8, 69, 41),
      ("css-ivpccpl", 66, "", "input.re", 70, 8, 70, 39),
      ("css-ivpcsxv", 67, "", "input.re", 71, 8, 71, 30),
      ("css-ivpcx1k", 68, "", "input.re", 72, 8, 72, 37),
      ("css-ivpcgvx", 69, "", "input.re", 73, 8, 73, 46),
      ("css-ivpcztd", 70, "", "input.re", 74, 8, 74, 37),
      ("css-ivpcsr5", 71, "", "input.re", 75, 8, 75, 39),
      ("css-ivpc01k", 72, "", "input.re", 76, 8, 76, 37),
      ("css-ivpcwf5", 73, "", "input.re", 79, 8, 79, 38),
      ("css-ivpcgj8", 74, "", "input.re", 80, 8, 80, 36),
      ("css-ivpczws", 75, "", "input.re", 81, 8, 81, 38),
      ("css-ivpcr8g", 76, "", "input.re", 82, 8, 82, 46),
      ("css-ivpceji", 77, "", "input.re", 83, 8, 83, 34),
      ("css-ivpcpxb", 78, "", "input.re", 84, 8, 84, 36),
      ("css-ivpc90r", 79, "", "input.re", 85, 8, 85, 44),
      ("css-ivpcfpi", 80, "", "input.re", 86, 8, 86, 34),
      ("css-ivpcwqa", 81, "", "input.re", 87, 8, 87, 36),
      ("css-ivpcqvg", 82, "", "input.re", 88, 8, 88, 44),
      ("css-ivpcxx5", 83, "", "input.re", 89, 8, 89, 32),
      ("css-ivpcxna", 84, "", "input.re", 90, 8, 90, 34),
      ("css-ivpcr0b", 85, "", "input.re", 91, 8, 91, 42),
    ]
  ];
  
  CSS.make("css-ivpc79u", []);
  CSS.make("css-ivpcp43", []);
  CSS.make("css-ivpcr4a", []);
  CSS.make("css-ivpcx20", []);
  CSS.make("css-ivpck00", []);
  CSS.make("css-ivpcdzw", []);
  CSS.make("css-ivpcw47", []);
  CSS.make("css-ivpc9i6", []);
  CSS.make("css-ivpcsv2", []);
  CSS.make("css-ivpc6hn", []);
  CSS.make("css-ivpcmlh", []);
  CSS.make("css-ivpccln", []);
  CSS.make("css-ivpcdm0", []);
  CSS.make("css-ivpcxwp", []);
  CSS.make("css-ivpc441", []);
  CSS.make("css-ivpcau3", []);
  CSS.make("css-ivpc4jr", []);
  CSS.make("css-ivpcd8m", []);
  CSS.make("css-ivpc236", []);
  CSS.make("css-ivpcu5a", []);
  CSS.make("css-ivpceom", []);
  CSS.make("css-ivpc16h", []);
  CSS.make("css-ivpcnfh", []);
  CSS.make("css-ivpcniv", []);
  CSS.make("css-ivpc223", []);
  CSS.make("css-ivpczxm", []);
  CSS.make("css-ivpci6x", []);
  CSS.make("css-ivpc543", []);
  CSS.make("css-ivpcf8u", []);
  CSS.make("css-ivpchvz", []);
  CSS.make("css-ivpcea3", []);
  CSS.make("css-ivpcfbq", []);
  CSS.make("css-ivpc462", []);
  CSS.make("css-ivpct9e", []);
  CSS.make("css-ivpcncu", []);
  CSS.make("css-ivpc887", []);
  CSS.make("css-ivpcxy7", []);
  CSS.make("css-ivpc76y", []);
  CSS.make("css-ivpc6su", []);
  CSS.make("css-ivpc71r", []);
  CSS.make("css-ivpcxcj", []);
  CSS.make("css-ivpcisa", []);
  CSS.make("css-ivpcyuh", []);
  CSS.make("css-ivpc02m", []);
  CSS.make("css-ivpcm57", []);
  CSS.make("css-ivpckyu", []);
  CSS.make("css-ivpcnk8", []);
  CSS.make("css-ivpc2dr", []);
  CSS.make("css-ivpc9fl", []);
  CSS.make("css-ivpc7up", []);
  CSS.make("css-ivpci83", []);
  CSS.make("css-ivpc1he", []);
  CSS.make("css-ivpccyo", []);
  CSS.make("css-ivpcshu", []);
  CSS.make("css-ivpcmkl", []);
  CSS.make("css-ivpcx5j", []);
  CSS.make("css-ivpchab", []);
  
  CSS.make("css-ivpcrhu", []);
  CSS.make("css-ivpcv6v", []);
  CSS.make("css-ivpciqu", []);
  CSS.make("css-ivpc6bq", []);
  CSS.make("css-ivpc03w", []);
  CSS.make("css-ivpc7c1", []);
  CSS.make("css-ivpcfm1", []);
  CSS.make("css-ivpcm9x", []);
  CSS.make("css-ivpcvxn", []);
  CSS.make("css-ivpccpl", []);
  CSS.make("css-ivpcsxv", []);
  CSS.make("css-ivpcx1k", []);
  CSS.make("css-ivpcgvx", []);
  CSS.make("css-ivpcztd", []);
  CSS.make("css-ivpcsr5", []);
  CSS.make("css-ivpc01k", []);
  
  CSS.make("css-ivpcwf5", []);
  CSS.make("css-ivpcgj8", []);
  CSS.make("css-ivpczws", []);
  CSS.make("css-ivpcr8g", []);
  CSS.make("css-ivpceji", []);
  CSS.make("css-ivpcpxb", []);
  CSS.make("css-ivpc90r", []);
  CSS.make("css-ivpcfpi", []);
  CSS.make("css-ivpcwqa", []);
  CSS.make("css-ivpcqvg", []);
  CSS.make("css-ivpcxx5", []);
  CSS.make("css-ivpcxna", []);
  CSS.make("css-ivpcr0b", []);
