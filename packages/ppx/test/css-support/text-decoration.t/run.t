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
  [@css ".css-ivpclk1{text-decoration-line:none;}"];
  [@css ".css-ivpcekh{text-decoration-line:underline;}"];
  [@css ".css-ivpczc2{text-decoration-line:overline;}"];
  [@css ".css-ivpc4wx{text-decoration-line:line-through;}"];
  [@css ".css-ivpcowm{text-decoration-line:underline overline;}"];
  [@css ".css-ivpcv34{text-decoration-color:white;}"];
  [@css ".css-ivpc96p{text-decoration-style:solid;}"];
  [@css ".css-ivpcwja{text-decoration-style:double;}"];
  [@css ".css-ivpcz7g{text-decoration-style:dotted;}"];
  [@css ".css-ivpcnad{text-decoration-style:dashed;}"];
  [@css ".css-ivpc5e2{text-decoration-style:wavy;}"];
  [@css ".css-ivpcby9{text-underline-position:auto;}"];
  [@css ".css-ivpcd41{text-underline-position:under;}"];
  [@css ".css-ivpcbax{text-underline-position:left;}"];
  [@css ".css-ivpcubn{text-underline-position:right;}"];
  [@css ".css-ivpcasr{text-underline-position:under left;}"];
  [@css ".css-ivpc170{text-underline-position:under right;}"];
  [@css ".css-ivpcarj{text-emphasis-style:none;}"];
  [@css ".css-ivpcbi3{text-emphasis-style:filled;}"];
  [@css ".css-ivpc2fa{text-emphasis-style:open;}"];
  [@css ".css-ivpcapi{text-emphasis-style:dot;}"];
  [@css ".css-ivpcadb{text-emphasis-style:circle;}"];
  [@css ".css-ivpci0e{text-emphasis-style:double-circle;}"];
  [@css ".css-ivpc1wj{text-emphasis-style:triangle;}"];
  [@css ".css-ivpcjud{text-emphasis-style:sesame;}"];
  [@css ".css-ivpc9y7{text-emphasis-style:open dot;}"];
  [@css ".css-ivpca86{text-emphasis-style:\"foo\";}"];
  [@css ".css-ivpctjf{text-emphasis-color:green;}"];
  [@css ".css-ivpcqwi{text-emphasis:open dot green;}"];
  [@css ".css-ivpc22y{text-emphasis-position:over;}"];
  [@css ".css-ivpc57y{text-emphasis-position:under;}"];
  [@css ".css-ivpckti{text-emphasis-position:over left;}"];
  [@css ".css-ivpcz28{text-emphasis-position:over right;}"];
  [@css ".css-ivpc4aa{text-emphasis-position:under left;}"];
  [@css ".css-ivpcizn{text-emphasis-position:left under;}"];
  [@css ".css-ivpc6ko{text-emphasis-position:under right;}"];
  [@css ".css-ivpcymi{text-shadow:none;}"];
  [@css ".css-ivpc1pt{text-shadow:1px 1px;}"];
  [@css ".css-ivpc1ok{text-shadow:0 0 black;}"];
  [@css ".css-ivpczmn{text-shadow:1px 2px 3px;}"];
  [@css ".css-ivpcqf2{text-shadow:1px 2px 3px black;}"];
  [@css ".css-ivpcf8m{text-shadow:1px 1px, 2px 2px red;}"];
  [@css ".css-ivpcnek{text-shadow:1px 2px 3px black, 0 0 5px white;}"];
  [@css ".css-ivpcmly{text-decoration-skip:none;}"];
  [@css ".css-ivpccku{text-decoration-skip:objects;}"];
  [@css ".css-ivpcv1s{text-decoration-skip:objects spaces;}"];
  [@css ".css-ivpcafq{text-decoration-skip:objects leading-spaces;}"];
  [@css ".css-ivpcd7v{text-decoration-skip:objects trailing-spaces;}"];
  [@css
    ".css-ivpcv2n{text-decoration-skip:objects leading-spaces trailing-spaces;}"
  ];
  [@css
    ".css-ivpc48m{text-decoration-skip:objects leading-spaces trailing-spaces edges;}"
  ];
  [@css
    ".css-ivpcrzu{text-decoration-skip:objects leading-spaces trailing-spaces edges box-decoration;}"
  ];
  [@css ".css-ivpc0r7{text-decoration-skip:objects edges;}"];
  [@css ".css-ivpc4q5{text-decoration-skip:objects box-decoration;}"];
  [@css ".css-ivpckvt{text-decoration-skip:spaces;}"];
  [@css ".css-ivpcsy4{text-decoration-skip:spaces edges;}"];
  [@css ".css-ivpchuc{text-decoration-skip:spaces edges box-decoration;}"];
  [@css ".css-ivpcel5{text-decoration-skip:spaces box-decoration;}"];
  [@css ".css-ivpc8ct{text-decoration-skip:leading-spaces;}"];
  [@css
    ".css-ivpcjnc{text-decoration-skip:leading-spaces trailing-spaces edges;}"
  ];
  [@css
    ".css-ivpc3eb{text-decoration-skip:leading-spaces trailing-spaces edges box-decoration;}"
  ];
  [@css ".css-ivpce2s{text-decoration-skip:edges;}"];
  [@css ".css-ivpcv8s{text-decoration-skip:edges box-decoration;}"];
  [@css ".css-ivpc18v{text-decoration-skip:box-decoration;}"];
  [@css ".css-ivpclxa{text-decoration-skip-ink:none;}"];
  [@css ".css-ivpcbw5{text-decoration-skip-ink:auto;}"];
  [@css ".css-ivpcitx{text-decoration-skip-ink:all;}"];
  [@css ".css-ivpcpnk{text-decoration-skip-box:none;}"];
  [@css ".css-ivpcoyf{text-decoration-skip-box:all;}"];
  [@css ".css-ivpc03y{text-decoration-skip-inset:none;}"];
  [@css ".css-ivpc57p{text-decoration-skip-inset:auto;}"];
  [@css ".css-ivpc3ad{text-underline-offset:auto;}"];
  [@css ".css-ivpc2ff{text-underline-offset:3px;}"];
  [@css ".css-ivpcv92{text-underline-offset:10%;}"];
  [@css ".css-ivpc3io{text-decoration-thickness:auto;}"];
  [@css ".css-ivpcatl{text-decoration-thickness:from-font;}"];
  [@css ".css-ivpcmec{text-decoration-thickness:3px;}"];
  [@css ".css-ivpcs2k{text-decoration-thickness:10%;}"];
  [@css.classes
    [
      ("css-ivpclk1", 0, "", "input.re", 3, 8, 3, 34),
      ("css-ivpcekh", 1, "", "input.re", 4, 8, 4, 39),
      ("css-ivpczc2", 2, "", "input.re", 5, 8, 5, 38),
      ("css-ivpc4wx", 3, "", "input.re", 6, 8, 6, 42),
      ("css-ivpcowm", 4, "", "input.re", 7, 8, 7, 48),
      ("css-ivpcv34", 5, "", "input.re", 8, 8, 8, 36),
      ("css-ivpc96p", 6, "", "input.re", 9, 8, 9, 36),
      ("css-ivpcwja", 7, "", "input.re", 10, 8, 10, 37),
      ("css-ivpcz7g", 8, "", "input.re", 11, 8, 11, 37),
      ("css-ivpcnad", 9, "", "input.re", 12, 8, 12, 37),
      ("css-ivpc5e2", 10, "", "input.re", 13, 8, 13, 35),
      ("css-ivpcby9", 11, "", "input.re", 14, 8, 14, 37),
      ("css-ivpcd41", 12, "", "input.re", 15, 8, 15, 38),
      ("css-ivpcbax", 13, "", "input.re", 16, 8, 16, 37),
      ("css-ivpcubn", 14, "", "input.re", 17, 8, 17, 38),
      ("css-ivpcasr", 15, "", "input.re", 18, 8, 18, 43),
      ("css-ivpc170", 16, "", "input.re", 19, 8, 19, 44),
      ("css-ivpcarj", 17, "", "input.re", 20, 8, 20, 33),
      ("css-ivpcbi3", 18, "", "input.re", 21, 8, 21, 35),
      ("css-ivpc2fa", 19, "", "input.re", 22, 8, 22, 33),
      ("css-ivpcapi", 20, "", "input.re", 23, 8, 23, 32),
      ("css-ivpcadb", 21, "", "input.re", 24, 8, 24, 35),
      ("css-ivpci0e", 22, "", "input.re", 25, 8, 25, 42),
      ("css-ivpc1wj", 23, "", "input.re", 26, 8, 26, 37),
      ("css-ivpcjud", 24, "", "input.re", 27, 8, 27, 35),
      ("css-ivpc9y7", 25, "", "input.re", 28, 8, 28, 37),
      ("css-ivpca86", 26, "", "input.re", 29, 8, 29, 34),
      ("css-ivpctjf", 27, "", "input.re", 30, 8, 30, 34),
      ("css-ivpcqwi", 28, "", "input.re", 31, 8, 31, 37),
      ("css-ivpc22y", 29, "", "input.re", 33, 8, 33, 36),
      ("css-ivpc57y", 30, "", "input.re", 34, 8, 34, 37),
      ("css-ivpckti", 31, "", "input.re", 35, 8, 35, 41),
      ("css-ivpcz28", 32, "", "input.re", 36, 8, 36, 42),
      ("css-ivpc4aa", 33, "", "input.re", 37, 8, 37, 42),
      ("css-ivpcizn", 34, "", "input.re", 38, 8, 38, 42),
      ("css-ivpc6ko", 35, "", "input.re", 39, 8, 39, 43),
      ("css-ivpcymi", 36, "", "input.re", 42, 8, 42, 25),
      ("css-ivpc1pt", 37, "", "input.re", 44, 8, 44, 28),
      ("css-ivpc1ok", 38, "", "input.re", 46, 8, 46, 30),
      ("css-ivpczmn", 39, "", "input.re", 48, 8, 48, 32),
      ("css-ivpcqf2", 40, "", "input.re", 50, 8, 50, 38),
      ("css-ivpcf8m", 41, "", "input.re", 52, 8, 52, 41),
      ("css-ivpcnek", 42, "", "input.re", 53, 8, 53, 53),
      ("css-ivpcmly", 43, "", "input.re", 57, 8, 57, 34),
      ("css-ivpccku", 44, "", "input.re", 58, 8, 58, 37),
      ("css-ivpcv1s", 45, "", "input.re", 59, 8, 59, 44),
      ("css-ivpcafq", 46, "", "input.re", 60, 8, 60, 52),
      ("css-ivpcd7v", 47, "", "input.re", 61, 8, 61, 53),
      ("css-ivpcv2n", 48, "", "input.re", 62, 8, 62, 68),
      ("css-ivpc48m", 49, "", "input.re", 63, 8, 63, 74),
      ("css-ivpcrzu", 50, "", "input.re", 65, 4, 65, 85),
      ("css-ivpc0r7", 51, "", "input.re", 67, 8, 67, 43),
      ("css-ivpc4q5", 52, "", "input.re", 68, 8, 68, 52),
      ("css-ivpckvt", 53, "", "input.re", 69, 8, 69, 36),
      ("css-ivpcsy4", 54, "", "input.re", 70, 8, 70, 42),
      ("css-ivpchuc", 55, "", "input.re", 71, 8, 71, 57),
      ("css-ivpcel5", 56, "", "input.re", 72, 8, 72, 51),
      ("css-ivpc8ct", 57, "", "input.re", 73, 8, 73, 44),
      ("css-ivpcjnc", 58, "", "input.re", 74, 8, 74, 66),
      ("css-ivpc3eb", 59, "", "input.re", 76, 4, 76, 77),
      ("css-ivpce2s", 60, "", "input.re", 78, 8, 78, 35),
      ("css-ivpcv8s", 61, "", "input.re", 79, 8, 79, 50),
      ("css-ivpc18v", 62, "", "input.re", 80, 8, 80, 44),
      ("css-ivpclxa", 63, "", "input.re", 81, 8, 81, 38),
      ("css-ivpcbw5", 64, "", "input.re", 82, 8, 82, 38),
      ("css-ivpcitx", 65, "", "input.re", 83, 8, 83, 37),
      ("css-ivpcpnk", 66, "", "input.re", 84, 8, 84, 38),
      ("css-ivpcoyf", 67, "", "input.re", 85, 8, 85, 37),
      ("css-ivpc03y", 68, "", "input.re", 86, 8, 86, 40),
      ("css-ivpc57p", 69, "", "input.re", 87, 8, 87, 40),
      ("css-ivpc3ad", 70, "", "input.re", 88, 8, 88, 35),
      ("css-ivpc2ff", 71, "", "input.re", 89, 8, 89, 34),
      ("css-ivpcv92", 72, "", "input.re", 90, 8, 90, 34),
      ("css-ivpc3io", 73, "", "input.re", 91, 8, 91, 39),
      ("css-ivpcatl", 74, "", "input.re", 92, 8, 92, 44),
      ("css-ivpcmec", 75, "", "input.re", 93, 8, 93, 38),
      ("css-ivpcs2k", 76, "", "input.re", 94, 8, 94, 38),
    ]
  ];
  
  CSS.make("css-ivpclk1", []);
  CSS.make("css-ivpcekh", []);
  CSS.make("css-ivpczc2", []);
  CSS.make("css-ivpc4wx", []);
  CSS.make("css-ivpcowm", []);
  CSS.make("css-ivpcv34", []);
  CSS.make("css-ivpc96p", []);
  CSS.make("css-ivpcwja", []);
  CSS.make("css-ivpcz7g", []);
  CSS.make("css-ivpcnad", []);
  CSS.make("css-ivpc5e2", []);
  CSS.make("css-ivpcby9", []);
  CSS.make("css-ivpcd41", []);
  CSS.make("css-ivpcbax", []);
  CSS.make("css-ivpcubn", []);
  CSS.make("css-ivpcasr", []);
  CSS.make("css-ivpc170", []);
  CSS.make("css-ivpcarj", []);
  CSS.make("css-ivpcbi3", []);
  CSS.make("css-ivpc2fa", []);
  CSS.make("css-ivpcapi", []);
  CSS.make("css-ivpcadb", []);
  CSS.make("css-ivpci0e", []);
  CSS.make("css-ivpc1wj", []);
  CSS.make("css-ivpcjud", []);
  CSS.make("css-ivpc9y7", []);
  CSS.make("css-ivpca86", []);
  CSS.make("css-ivpctjf", []);
  CSS.make("css-ivpcqwi", []);
  
  CSS.make("css-ivpc22y", []);
  CSS.make("css-ivpc57y", []);
  CSS.make("css-ivpckti", []);
  CSS.make("css-ivpcz28", []);
  CSS.make("css-ivpc4aa", []);
  CSS.make("css-ivpcizn", []);
  CSS.make("css-ivpc6ko", []);
  
  CSS.make("css-ivpcymi", []);
  
  CSS.make("css-ivpc1pt", []);
  
  CSS.make("css-ivpc1ok", []);
  
  CSS.make("css-ivpczmn", []);
  
  CSS.make("css-ivpcqf2", []);
  
  CSS.make("css-ivpcf8m", []);
  CSS.make("css-ivpcnek", []);
  
  CSS.make("css-ivpcmly", []);
  CSS.make("css-ivpccku", []);
  CSS.make("css-ivpcv1s", []);
  CSS.make("css-ivpcafq", []);
  CSS.make("css-ivpcd7v", []);
  CSS.make("css-ivpcv2n", []);
  CSS.make("css-ivpc48m", []);
  CSS.make("css-ivpcrzu", []);
  CSS.make("css-ivpc0r7", []);
  CSS.make("css-ivpc4q5", []);
  CSS.make("css-ivpckvt", []);
  CSS.make("css-ivpcsy4", []);
  CSS.make("css-ivpchuc", []);
  CSS.make("css-ivpcel5", []);
  CSS.make("css-ivpc8ct", []);
  CSS.make("css-ivpcjnc", []);
  CSS.make("css-ivpc3eb", []);
  CSS.make("css-ivpce2s", []);
  CSS.make("css-ivpcv8s", []);
  CSS.make("css-ivpc18v", []);
  CSS.make("css-ivpclxa", []);
  CSS.make("css-ivpcbw5", []);
  CSS.make("css-ivpcitx", []);
  CSS.make("css-ivpcpnk", []);
  CSS.make("css-ivpcoyf", []);
  CSS.make("css-ivpc03y", []);
  CSS.make("css-ivpc57p", []);
  CSS.make("css-ivpc3ad", []);
  CSS.make("css-ivpc2ff", []);
  CSS.make("css-ivpcv92", []);
  CSS.make("css-ivpc3io", []);
  CSS.make("css-ivpcatl", []);
  CSS.make("css-ivpcmec", []);
  CSS.make("css-ivpcs2k", []);
