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
  [@css ".css-2welk1{text-decoration-line:none;}"];
  [@css ".css-1ikeekh{text-decoration-line:underline;}"];
  [@css ".css-cb1zc2{text-decoration-line:overline;}"];
  [@css ".css-1s0o4wx{text-decoration-line:line-through;}"];
  [@css ".css-250owm{text-decoration-line:underline overline;}"];
  [@css ".css-1yh1v34{text-decoration-color:white;}"];
  [@css ".css-68396p{text-decoration-style:solid;}"];
  [@css ".css-lqpwja{text-decoration-style:double;}"];
  [@css ".css-zslz7g{text-decoration-style:dotted;}"];
  [@css ".css-1u7onad{text-decoration-style:dashed;}"];
  [@css ".css-1d5o5e2{text-decoration-style:wavy;}"];
  [@css ".css-12tnby9{text-underline-position:auto;}"];
  [@css ".css-1tpld41{text-underline-position:under;}"];
  [@css ".css-rqlbax{text-underline-position:left;}"];
  [@css ".css-82aubn{text-underline-position:right;}"];
  [@css ".css-gjcasr{text-underline-position:under left;}"];
  [@css ".css-xv170{text-underline-position:under right;}"];
  [@css ".css-nzoarj{text-emphasis-style:none;}"];
  [@css ".css-1ykgbi3{text-emphasis-style:filled;}"];
  [@css ".css-1q6g2fa{text-emphasis-style:open;}"];
  [@css ".css-17laapi{text-emphasis-style:dot;}"];
  [@css ".css-1iv0adb{text-emphasis-style:circle;}"];
  [@css ".css-1p8qi0e{text-emphasis-style:double-circle;}"];
  [@css ".css-7aq1wj{text-emphasis-style:triangle;}"];
  [@css ".css-1594jud{text-emphasis-style:sesame;}"];
  [@css ".css-1wn69y7{text-emphasis-style:open dot;}"];
  [@css ".css-cana86{text-emphasis-style:\"foo\";}"];
  [@css ".css-awatjf{text-emphasis-color:green;}"];
  [@css ".css-1brqwi{text-emphasis:open dot green;}"];
  [@css ".css-1avp22y{text-emphasis-position:over;}"];
  [@css ".css-1jxd57y{text-emphasis-position:under;}"];
  [@css ".css-1vhnkti{text-emphasis-position:over left;}"];
  [@css ".css-mboz28{text-emphasis-position:over right;}"];
  [@css ".css-feq4aa{text-emphasis-position:under left;}"];
  [@css ".css-fbsizn{text-emphasis-position:left under;}"];
  [@css ".css-15i66ko{text-emphasis-position:under right;}"];
  [@css ".css-1tcymi{text-shadow:none;}"];
  [@css ".css-bul1pt{text-shadow:1px 1px;}"];
  [@css ".css-10zs1ok{text-shadow:0 0 black;}"];
  [@css ".css-14i5zmn{text-shadow:1px 2px 3px;}"];
  [@css ".css-14y4qf2{text-shadow:1px 2px 3px black;}"];
  [@css ".css-1dfaf8m{text-shadow:1px 1px, 2px 2px red;}"];
  [@css ".css-q9onek{text-shadow:1px 2px 3px black, 0 0 5px white;}"];
  [@css ".css-1f57mly{text-decoration-skip:none;}"];
  [@css ".css-1dfbcku{text-decoration-skip:objects;}"];
  [@css ".css-abdv1s{text-decoration-skip:objects spaces;}"];
  [@css ".css-k9safq{text-decoration-skip:objects leading-spaces;}"];
  [@css ".css-1rnsd7v{text-decoration-skip:objects trailing-spaces;}"];
  [@css
    ".css-1qbev2n{text-decoration-skip:objects leading-spaces trailing-spaces;}"
  ];
  [@css
    ".css-wwt48m{text-decoration-skip:objects leading-spaces trailing-spaces edges;}"
  ];
  [@css
    ".css-1kb7rzu{text-decoration-skip:objects leading-spaces trailing-spaces edges box-decoration;}"
  ];
  [@css ".css-qix0r7{text-decoration-skip:objects edges;}"];
  [@css ".css-1qya4q5{text-decoration-skip:objects box-decoration;}"];
  [@css ".css-1eigkvt{text-decoration-skip:spaces;}"];
  [@css ".css-17xtsy4{text-decoration-skip:spaces edges;}"];
  [@css ".css-zhdhuc{text-decoration-skip:spaces edges box-decoration;}"];
  [@css ".css-18kjel5{text-decoration-skip:spaces box-decoration;}"];
  [@css ".css-2uo8ct{text-decoration-skip:leading-spaces;}"];
  [@css
    ".css-mjgjnc{text-decoration-skip:leading-spaces trailing-spaces edges;}"
  ];
  [@css
    ".css-3823eb{text-decoration-skip:leading-spaces trailing-spaces edges box-decoration;}"
  ];
  [@css ".css-1jk9e2s{text-decoration-skip:edges;}"];
  [@css ".css-6fvv8s{text-decoration-skip:edges box-decoration;}"];
  [@css ".css-qck18v{text-decoration-skip:box-decoration;}"];
  [@css ".css-xsclxa{text-decoration-skip-ink:none;}"];
  [@css ".css-11lgbw5{text-decoration-skip-ink:auto;}"];
  [@css ".css-6g2itx{text-decoration-skip-ink:all;}"];
  [@css ".css-1bnipnk{text-decoration-skip-box:none;}"];
  [@css ".css-89foyf{text-decoration-skip-box:all;}"];
  [@css ".css-18um03y{text-decoration-skip-inset:none;}"];
  [@css ".css-1mx357p{text-decoration-skip-inset:auto;}"];
  [@css ".css-1fsm3ad{text-underline-offset:auto;}"];
  [@css ".css-h342ff{text-underline-offset:3px;}"];
  [@css ".css-yvev92{text-underline-offset:10%;}"];
  [@css ".css-1vk83io{text-decoration-thickness:auto;}"];
  [@css ".css-10h4atl{text-decoration-thickness:from-font;}"];
  [@css ".css-1k9jmec{text-decoration-thickness:3px;}"];
  [@css ".css-etys2k{text-decoration-thickness:10%;}"];
  [@css.classes
    [
      ("css-2welk1", 0, "", "input.re", 3, 8, 3, 34),
      ("css-1ikeekh", 1, "", "input.re", 4, 8, 4, 39),
      ("css-cb1zc2", 2, "", "input.re", 5, 8, 5, 38),
      ("css-1s0o4wx", 3, "", "input.re", 6, 8, 6, 42),
      ("css-250owm", 4, "", "input.re", 7, 8, 7, 48),
      ("css-1yh1v34", 5, "", "input.re", 8, 8, 8, 36),
      ("css-68396p", 6, "", "input.re", 9, 8, 9, 36),
      ("css-lqpwja", 7, "", "input.re", 10, 8, 10, 37),
      ("css-zslz7g", 8, "", "input.re", 11, 8, 11, 37),
      ("css-1u7onad", 9, "", "input.re", 12, 8, 12, 37),
      ("css-1d5o5e2", 10, "", "input.re", 13, 8, 13, 35),
      ("css-12tnby9", 11, "", "input.re", 14, 8, 14, 37),
      ("css-1tpld41", 12, "", "input.re", 15, 8, 15, 38),
      ("css-rqlbax", 13, "", "input.re", 16, 8, 16, 37),
      ("css-82aubn", 14, "", "input.re", 17, 8, 17, 38),
      ("css-gjcasr", 15, "", "input.re", 18, 8, 18, 43),
      ("css-xv170", 16, "", "input.re", 19, 8, 19, 44),
      ("css-nzoarj", 17, "", "input.re", 20, 8, 20, 33),
      ("css-1ykgbi3", 18, "", "input.re", 21, 8, 21, 35),
      ("css-1q6g2fa", 19, "", "input.re", 22, 8, 22, 33),
      ("css-17laapi", 20, "", "input.re", 23, 8, 23, 32),
      ("css-1iv0adb", 21, "", "input.re", 24, 8, 24, 35),
      ("css-1p8qi0e", 22, "", "input.re", 25, 8, 25, 42),
      ("css-7aq1wj", 23, "", "input.re", 26, 8, 26, 37),
      ("css-1594jud", 24, "", "input.re", 27, 8, 27, 35),
      ("css-1wn69y7", 25, "", "input.re", 28, 8, 28, 37),
      ("css-cana86", 26, "", "input.re", 29, 8, 29, 34),
      ("css-awatjf", 27, "", "input.re", 30, 8, 30, 34),
      ("css-1brqwi", 28, "", "input.re", 31, 8, 31, 37),
      ("css-1avp22y", 29, "", "input.re", 33, 8, 33, 36),
      ("css-1jxd57y", 30, "", "input.re", 34, 8, 34, 37),
      ("css-1vhnkti", 31, "", "input.re", 35, 8, 35, 41),
      ("css-mboz28", 32, "", "input.re", 36, 8, 36, 42),
      ("css-feq4aa", 33, "", "input.re", 37, 8, 37, 42),
      ("css-fbsizn", 34, "", "input.re", 38, 8, 38, 42),
      ("css-15i66ko", 35, "", "input.re", 39, 8, 39, 43),
      ("css-1tcymi", 36, "", "input.re", 42, 8, 42, 25),
      ("css-bul1pt", 37, "", "input.re", 44, 8, 44, 28),
      ("css-10zs1ok", 38, "", "input.re", 46, 8, 46, 30),
      ("css-14i5zmn", 39, "", "input.re", 48, 8, 48, 32),
      ("css-14y4qf2", 40, "", "input.re", 50, 8, 50, 38),
      ("css-1dfaf8m", 41, "", "input.re", 52, 8, 52, 41),
      ("css-q9onek", 42, "", "input.re", 53, 8, 53, 53),
      ("css-1f57mly", 43, "", "input.re", 57, 8, 57, 34),
      ("css-1dfbcku", 44, "", "input.re", 58, 8, 58, 37),
      ("css-abdv1s", 45, "", "input.re", 59, 8, 59, 44),
      ("css-k9safq", 46, "", "input.re", 60, 8, 60, 52),
      ("css-1rnsd7v", 47, "", "input.re", 61, 8, 61, 53),
      ("css-1qbev2n", 48, "", "input.re", 62, 8, 62, 68),
      ("css-wwt48m", 49, "", "input.re", 63, 8, 63, 74),
      ("css-1kb7rzu", 50, "", "input.re", 65, 4, 65, 85),
      ("css-qix0r7", 51, "", "input.re", 67, 8, 67, 43),
      ("css-1qya4q5", 52, "", "input.re", 68, 8, 68, 52),
      ("css-1eigkvt", 53, "", "input.re", 69, 8, 69, 36),
      ("css-17xtsy4", 54, "", "input.re", 70, 8, 70, 42),
      ("css-zhdhuc", 55, "", "input.re", 71, 8, 71, 57),
      ("css-18kjel5", 56, "", "input.re", 72, 8, 72, 51),
      ("css-2uo8ct", 57, "", "input.re", 73, 8, 73, 44),
      ("css-mjgjnc", 58, "", "input.re", 74, 8, 74, 66),
      ("css-3823eb", 59, "", "input.re", 76, 4, 76, 77),
      ("css-1jk9e2s", 60, "", "input.re", 78, 8, 78, 35),
      ("css-6fvv8s", 61, "", "input.re", 79, 8, 79, 50),
      ("css-qck18v", 62, "", "input.re", 80, 8, 80, 44),
      ("css-xsclxa", 63, "", "input.re", 81, 8, 81, 38),
      ("css-11lgbw5", 64, "", "input.re", 82, 8, 82, 38),
      ("css-6g2itx", 65, "", "input.re", 83, 8, 83, 37),
      ("css-1bnipnk", 66, "", "input.re", 84, 8, 84, 38),
      ("css-89foyf", 67, "", "input.re", 85, 8, 85, 37),
      ("css-18um03y", 68, "", "input.re", 86, 8, 86, 40),
      ("css-1mx357p", 69, "", "input.re", 87, 8, 87, 40),
      ("css-1fsm3ad", 70, "", "input.re", 88, 8, 88, 35),
      ("css-h342ff", 71, "", "input.re", 89, 8, 89, 34),
      ("css-yvev92", 72, "", "input.re", 90, 8, 90, 34),
      ("css-1vk83io", 73, "", "input.re", 91, 8, 91, 39),
      ("css-10h4atl", 74, "", "input.re", 92, 8, 92, 44),
      ("css-1k9jmec", 75, "", "input.re", 93, 8, 93, 38),
      ("css-etys2k", 76, "", "input.re", 94, 8, 94, 38),
    ]
  ];
  
  CSS.make("css-2welk1", []);
  CSS.make("css-1ikeekh", []);
  CSS.make("css-cb1zc2", []);
  CSS.make("css-1s0o4wx", []);
  CSS.make("css-250owm", []);
  CSS.make("css-1yh1v34", []);
  CSS.make("css-68396p", []);
  CSS.make("css-lqpwja", []);
  CSS.make("css-zslz7g", []);
  CSS.make("css-1u7onad", []);
  CSS.make("css-1d5o5e2", []);
  CSS.make("css-12tnby9", []);
  CSS.make("css-1tpld41", []);
  CSS.make("css-rqlbax", []);
  CSS.make("css-82aubn", []);
  CSS.make("css-gjcasr", []);
  CSS.make("css-xv170", []);
  CSS.make("css-nzoarj", []);
  CSS.make("css-1ykgbi3", []);
  CSS.make("css-1q6g2fa", []);
  CSS.make("css-17laapi", []);
  CSS.make("css-1iv0adb", []);
  CSS.make("css-1p8qi0e", []);
  CSS.make("css-7aq1wj", []);
  CSS.make("css-1594jud", []);
  CSS.make("css-1wn69y7", []);
  CSS.make("css-cana86", []);
  CSS.make("css-awatjf", []);
  CSS.make("css-1brqwi", []);
  
  CSS.make("css-1avp22y", []);
  CSS.make("css-1jxd57y", []);
  CSS.make("css-1vhnkti", []);
  CSS.make("css-mboz28", []);
  CSS.make("css-feq4aa", []);
  CSS.make("css-fbsizn", []);
  CSS.make("css-15i66ko", []);
  
  CSS.make("css-1tcymi", []);
  
  CSS.make("css-bul1pt", []);
  
  CSS.make("css-10zs1ok", []);
  
  CSS.make("css-14i5zmn", []);
  
  CSS.make("css-14y4qf2", []);
  
  CSS.make("css-1dfaf8m", []);
  CSS.make("css-q9onek", []);
  
  CSS.make("css-1f57mly", []);
  CSS.make("css-1dfbcku", []);
  CSS.make("css-abdv1s", []);
  CSS.make("css-k9safq", []);
  CSS.make("css-1rnsd7v", []);
  CSS.make("css-1qbev2n", []);
  CSS.make("css-wwt48m", []);
  CSS.make("css-1kb7rzu", []);
  CSS.make("css-qix0r7", []);
  CSS.make("css-1qya4q5", []);
  CSS.make("css-1eigkvt", []);
  CSS.make("css-17xtsy4", []);
  CSS.make("css-zhdhuc", []);
  CSS.make("css-18kjel5", []);
  CSS.make("css-2uo8ct", []);
  CSS.make("css-mjgjnc", []);
  CSS.make("css-3823eb", []);
  CSS.make("css-1jk9e2s", []);
  CSS.make("css-6fvv8s", []);
  CSS.make("css-qck18v", []);
  CSS.make("css-xsclxa", []);
  CSS.make("css-11lgbw5", []);
  CSS.make("css-6g2itx", []);
  CSS.make("css-1bnipnk", []);
  CSS.make("css-89foyf", []);
  CSS.make("css-18um03y", []);
  CSS.make("css-1mx357p", []);
  CSS.make("css-1fsm3ad", []);
  CSS.make("css-h342ff", []);
  CSS.make("css-yvev92", []);
  CSS.make("css-1vk83io", []);
  CSS.make("css-10h4atl", []);
  CSS.make("css-1k9jmec", []);
  CSS.make("css-etys2k", []);
