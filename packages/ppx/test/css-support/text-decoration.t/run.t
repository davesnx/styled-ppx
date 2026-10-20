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
  [@css "._a_cf0002tiaf{text-decoration-line:none;}"];
  [@css "._a_cf0002jo7l{text-decoration-line:underline;}"];
  [@css "._a_cf00027jjn{text-decoration-line:overline;}"];
  [@css "._a_cf0002aj5y{text-decoration-line:line-through;}"];
  [@css "._a_cf00024p93{text-decoration-line:underline overline;}"];
  [@css "._a_cf0001lvj2{text-decoration-color:white;}"];
  [@css "._a_cf0004de1x{text-decoration-style:solid;}"];
  [@css "._a_cf00043bb0{text-decoration-style:double;}"];
  [@css "._a_cf0004u23a{text-decoration-style:dotted;}"];
  [@css "._a_cf000489xg{text-decoration-style:dashed;}"];
  [@css "._a_cf0004bza7{text-decoration-style:wavy;}"];
  [@css "._a_d37kvy{text-underline-position:auto;}"];
  [@css "._a_d3hfys{text-underline-position:under;}"];
  [@css "._a_d32wu2{text-underline-position:left;}"];
  [@css "._a_d3dp26{text-underline-position:right;}"];
  [@css "._a_d3s52a{text-underline-position:under left;}"];
  [@css "._a_d3n9dq{text-underline-position:under right;}"];
  [@css "._a_co0002iqil{text-emphasis-style:none;}"];
  [@css "._a_co0002j2pl{text-emphasis-style:filled;}"];
  [@css "._a_co0002g7ob{text-emphasis-style:open;}"];
  [@css "._a_co0002eeq5{text-emphasis-style:dot;}"];
  [@css "._a_co00022qxn{text-emphasis-style:circle;}"];
  [@css "._a_co0002nz0y{text-emphasis-style:double-circle;}"];
  [@css "._a_co0002niuc{text-emphasis-style:triangle;}"];
  [@css "._a_co0002243n{text-emphasis-style:sesame;}"];
  [@css "._a_co00023653{text-emphasis-style:open dot;}"];
  [@css "._a_co0002i345{text-emphasis-style:\"foo\";}"];
  [@css "._a_co00017yre{text-emphasis-color:green;}"];
  [@css "._a_co1xtr{text-emphasis:open dot green;}"];
  [@css "._a_cp1nl6{text-emphasis-position:over;}"];
  [@css "._a_cpdg2o{text-emphasis-position:under;}"];
  [@css "._a_cpd4dg{text-emphasis-position:over left;}"];
  [@css "._a_cpsz24{text-emphasis-position:over right;}"];
  [@css "._a_cpwejo{text-emphasis-position:under left;}"];
  [@css "._a_cpux8j{text-emphasis-position:left under;}"];
  [@css "._a_cps7qc{text-emphasis-position:under right;}"];
  [@css "._a_cyql9z{text-shadow:none;}"];
  [@css "._a_cyychj{text-shadow:1px 1px;}"];
  [@css "._a_cyo2mi{text-shadow:0 0 black;}"];
  [@css "._a_cyqa7n{text-shadow:1px 2px 3px;}"];
  [@css "._a_cyj1j4{text-shadow:1px 2px 3px black;}"];
  [@css "._a_cybx5y{text-shadow:1px 1px, 2px 2px red;}"];
  [@css "._a_cy7zpt{text-shadow:1px 2px 3px black, 0 0 5px white;}"];
  [@css "._a_chxjle{text-decoration-skip:none;}"];
  [@css "._a_chhh35{text-decoration-skip:objects;}"];
  [@css "._a_chl9gi{text-decoration-skip:objects spaces;}"];
  [@css "._a_chjofb{text-decoration-skip:objects leading-spaces;}"];
  [@css "._a_ch5tpa{text-decoration-skip:objects trailing-spaces;}"];
  [@css
    "._a_chl3dj{text-decoration-skip:objects leading-spaces trailing-spaces;}"
  ];
  [@css
    "._a_chwwzb{text-decoration-skip:objects leading-spaces trailing-spaces edges;}"
  ];
  [@css
    "._a_chj747{text-decoration-skip:objects leading-spaces trailing-spaces edges box-decoration;}"
  ];
  [@css "._a_chqqvz{text-decoration-skip:objects edges;}"];
  [@css "._a_chjnz3{text-decoration-skip:objects box-decoration;}"];
  [@css "._a_chnj6l{text-decoration-skip:spaces;}"];
  [@css "._a_chlxfd{text-decoration-skip:spaces edges;}"];
  [@css "._a_chealr{text-decoration-skip:spaces edges box-decoration;}"];
  [@css "._a_ch9jre{text-decoration-skip:spaces box-decoration;}"];
  [@css "._a_chf8ym{text-decoration-skip:leading-spaces;}"];
  [@css
    "._a_chupg8{text-decoration-skip:leading-spaces trailing-spaces edges;}"
  ];
  [@css
    "._a_chs8vu{text-decoration-skip:leading-spaces trailing-spaces edges box-decoration;}"
  ];
  [@css "._a_chty82{text-decoration-skip:edges;}"];
  [@css "._a_chxscz{text-decoration-skip:edges box-decoration;}"];
  [@css "._a_chedkd{text-decoration-skip:box-decoration;}"];
  [@css "._a_cjq7y7{text-decoration-skip-ink:none;}"];
  [@css "._a_cj1soe{text-decoration-skip-ink:auto;}"];
  [@css "._a_cj2f09{text-decoration-skip-ink:all;}"];
  [@css "._a_cifdf1{text-decoration-skip-box:none;}"];
  [@css "._a_cidjmk{text-decoration-skip-box:all;}"];
  [@css "._a_ck3yi9{text-decoration-skip-inset:none;}"];
  [@css "._a_ck0g23{text-decoration-skip-inset:auto;}"];
  [@css "._a_d2jicj{text-underline-offset:auto;}"];
  [@css "._a_d2lgvj{text-underline-offset:3px;}"];
  [@css "._a_d2n22j{text-underline-offset:10%;}"];
  [@css "._a_cf0008ssta{text-decoration-thickness:auto;}"];
  [@css "._a_cf0008yh8i{text-decoration-thickness:from-font;}"];
  [@css "._a_cf0008jw5c{text-decoration-thickness:3px;}"];
  [@css "._a_cf0008vgf0{text-decoration-thickness:10%;}"];
  [@css.blocks
    [
      (3, "_a_cf0002tiaf"),
      (4, "_a_cf0002jo7l"),
      (5, "_a_cf00027jjn"),
      (6, "_a_cf0002aj5y"),
      (7, "_a_cf00024p93"),
      (8, "_a_cf0001lvj2"),
      (9, "_a_cf0004de1x"),
      (10, "_a_cf00043bb0"),
      (11, "_a_cf0004u23a"),
      (12, "_a_cf000489xg"),
      (13, "_a_cf0004bza7"),
      (14, "_a_d37kvy"),
      (15, "_a_d3hfys"),
      (16, "_a_d32wu2"),
      (17, "_a_d3dp26"),
      (18, "_a_d3s52a"),
      (19, "_a_d3n9dq"),
      (20, "_a_co0002iqil"),
      (21, "_a_co0002j2pl"),
      (22, "_a_co0002g7ob"),
      (23, "_a_co0002eeq5"),
      (24, "_a_co00022qxn"),
      (25, "_a_co0002nz0y"),
      (26, "_a_co0002niuc"),
      (27, "_a_co0002243n"),
      (28, "_a_co00023653"),
      (29, "_a_co0002i345"),
      (30, "_a_co00017yre"),
      (31, "_a_co1xtr"),
      (33, "_a_cp1nl6"),
      (34, "_a_cpdg2o"),
      (35, "_a_cpd4dg"),
      (36, "_a_cpsz24"),
      (37, "_a_cpwejo"),
      (38, "_a_cpux8j"),
      (39, "_a_cps7qc"),
      (42, "_a_cyql9z"),
      (44, "_a_cyychj"),
      (46, "_a_cyo2mi"),
      (48, "_a_cyqa7n"),
      (50, "_a_cyj1j4"),
      (52, "_a_cybx5y"),
      (53, "_a_cy7zpt"),
      (57, "_a_chxjle"),
      (58, "_a_chhh35"),
      (59, "_a_chl9gi"),
      (60, "_a_chjofb"),
      (61, "_a_ch5tpa"),
      (62, "_a_chl3dj"),
      (63, "_a_chwwzb"),
      (65, "_a_chj747"),
      (67, "_a_chqqvz"),
      (68, "_a_chjnz3"),
      (69, "_a_chnj6l"),
      (70, "_a_chlxfd"),
      (71, "_a_chealr"),
      (72, "_a_ch9jre"),
      (73, "_a_chf8ym"),
      (74, "_a_chupg8"),
      (76, "_a_chs8vu"),
      (78, "_a_chty82"),
      (79, "_a_chxscz"),
      (80, "_a_chedkd"),
      (81, "_a_cjq7y7"),
      (82, "_a_cj1soe"),
      (83, "_a_cj2f09"),
      (84, "_a_cifdf1"),
      (85, "_a_cidjmk"),
      (86, "_a_ck3yi9"),
      (87, "_a_ck0g23"),
      (88, "_a_d2jicj"),
      (89, "_a_d2lgvj"),
      (90, "_a_d2n22j"),
      (91, "_a_cf0008ssta"),
      (92, "_a_cf0008yh8i"),
      (93, "_a_cf0008jw5c"),
      (94, "_a_cf0008vgf0"),
    ]
  ];
  
  CSS.make("_a_cf0002tiaf", []);
  CSS.make("_a_cf0002jo7l", []);
  CSS.make("_a_cf00027jjn", []);
  CSS.make("_a_cf0002aj5y", []);
  CSS.make("_a_cf00024p93", []);
  CSS.make("_a_cf0001lvj2", []);
  CSS.make("_a_cf0004de1x", []);
  CSS.make("_a_cf00043bb0", []);
  CSS.make("_a_cf0004u23a", []);
  CSS.make("_a_cf000489xg", []);
  CSS.make("_a_cf0004bza7", []);
  CSS.make("_a_d37kvy", []);
  CSS.make("_a_d3hfys", []);
  CSS.make("_a_d32wu2", []);
  CSS.make("_a_d3dp26", []);
  CSS.make("_a_d3s52a", []);
  CSS.make("_a_d3n9dq", []);
  CSS.make("_a_co0002iqil", []);
  CSS.make("_a_co0002j2pl", []);
  CSS.make("_a_co0002g7ob", []);
  CSS.make("_a_co0002eeq5", []);
  CSS.make("_a_co00022qxn", []);
  CSS.make("_a_co0002nz0y", []);
  CSS.make("_a_co0002niuc", []);
  CSS.make("_a_co0002243n", []);
  CSS.make("_a_co00023653", []);
  CSS.make("_a_co0002i345", []);
  CSS.make("_a_co00017yre", []);
  CSS.make("_a_co1xtr", []);
  
  CSS.make("_a_cp1nl6", []);
  CSS.make("_a_cpdg2o", []);
  CSS.make("_a_cpd4dg", []);
  CSS.make("_a_cpsz24", []);
  CSS.make("_a_cpwejo", []);
  CSS.make("_a_cpux8j", []);
  CSS.make("_a_cps7qc", []);
  
  CSS.make("_a_cyql9z", []);
  
  CSS.make("_a_cyychj", []);
  
  CSS.make("_a_cyo2mi", []);
  
  CSS.make("_a_cyqa7n", []);
  
  CSS.make("_a_cyj1j4", []);
  
  CSS.make("_a_cybx5y", []);
  CSS.make("_a_cy7zpt", []);
  
  CSS.make("_a_chxjle", []);
  CSS.make("_a_chhh35", []);
  CSS.make("_a_chl9gi", []);
  CSS.make("_a_chjofb", []);
  CSS.make("_a_ch5tpa", []);
  CSS.make("_a_chl3dj", []);
  CSS.make("_a_chwwzb", []);
  CSS.make("_a_chj747", []);
  CSS.make("_a_chqqvz", []);
  CSS.make("_a_chjnz3", []);
  CSS.make("_a_chnj6l", []);
  CSS.make("_a_chlxfd", []);
  CSS.make("_a_chealr", []);
  CSS.make("_a_ch9jre", []);
  CSS.make("_a_chf8ym", []);
  CSS.make("_a_chupg8", []);
  CSS.make("_a_chs8vu", []);
  CSS.make("_a_chty82", []);
  CSS.make("_a_chxscz", []);
  CSS.make("_a_chedkd", []);
  CSS.make("_a_cjq7y7", []);
  CSS.make("_a_cj1soe", []);
  CSS.make("_a_cj2f09", []);
  CSS.make("_a_cifdf1", []);
  CSS.make("_a_cidjmk", []);
  CSS.make("_a_ck3yi9", []);
  CSS.make("_a_ck0g23", []);
  CSS.make("_a_d2jicj", []);
  CSS.make("_a_d2lgvj", []);
  CSS.make("_a_d2n22j", []);
  CSS.make("_a_cf0008ssta", []);
  CSS.make("_a_cf0008yh8i", []);
  CSS.make("_a_cf0008jw5c", []);
  CSS.make("_a_cf0008vgf0", []);
