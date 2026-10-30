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
    (
      "._a_cf0002tiaf{text-decoration-line:none;}",
      "_a_cf0002tiaf",
      "0,1,0 own",
      "447",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_cf0002jo7l{text-decoration-line:underline;}",
      "_a_cf0002jo7l",
      "0,1,0 own",
      "447",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_cf00027jjn{text-decoration-line:overline;}",
      "_a_cf00027jjn",
      "0,1,0 own",
      "447",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_cf0002aj5y{text-decoration-line:line-through;}",
      "_a_cf0002aj5y",
      "0,1,0 own",
      "447",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_cf00024p93{text-decoration-line:underline overline;}",
      "_a_cf00024p93",
      "0,1,0 own",
      "447",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_cf0001lvj2{text-decoration-color:white;}",
      "_a_cf0001lvj2",
      "0,1,0 own",
      "447",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cf0004de1x{text-decoration-style:solid;}",
      "_a_cf0004de1x",
      "0,1,0 own",
      "447",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_cf00043bb0{text-decoration-style:double;}",
      "_a_cf00043bb0",
      "0,1,0 own",
      "447",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_cf0004u23a{text-decoration-style:dotted;}",
      "_a_cf0004u23a",
      "0,1,0 own",
      "447",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_cf000489xg{text-decoration-style:dashed;}",
      "_a_cf000489xg",
      "0,1,0 own",
      "447",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_cf0004bza7{text-decoration-style:wavy;}",
      "_a_cf0004bza7",
      "0,1,0 own",
      "447",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_d37kvy{text-underline-position:auto;}",
      "_a_d37kvy",
      "0,1,0 own",
      "471",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_d3hfys{text-underline-position:under;}",
      "_a_d3hfys",
      "0,1,0 own",
      "471",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_d32wu2{text-underline-position:left;}",
      "_a_d32wu2",
      "0,1,0 own",
      "471",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_d3dp26{text-underline-position:right;}",
      "_a_d3dp26",
      "0,1,0 own",
      "471",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_d3s52a{text-underline-position:under left;}",
      "_a_d3s52a",
      "0,1,0 own",
      "471",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_d3n9dq{text-underline-position:under right;}",
      "_a_d3n9dq",
      "0,1,0 own",
      "471",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_co0002iqil{text-emphasis-style:none;}",
      "_a_co0002iqil",
      "0,1,0 own",
      "456",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_co0002j2pl{text-emphasis-style:filled;}",
      "_a_co0002j2pl",
      "0,1,0 own",
      "456",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_co0002g7ob{text-emphasis-style:open;}",
      "_a_co0002g7ob",
      "0,1,0 own",
      "456",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_co0002eeq5{text-emphasis-style:dot;}",
      "_a_co0002eeq5",
      "0,1,0 own",
      "456",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_co00022qxn{text-emphasis-style:circle;}",
      "_a_co00022qxn",
      "0,1,0 own",
      "456",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_co0002nz0y{text-emphasis-style:double-circle;}",
      "_a_co0002nz0y",
      "0,1,0 own",
      "456",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_co0002niuc{text-emphasis-style:triangle;}",
      "_a_co0002niuc",
      "0,1,0 own",
      "456",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_co0002243n{text-emphasis-style:sesame;}",
      "_a_co0002243n",
      "0,1,0 own",
      "456",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_co00023653{text-emphasis-style:open dot;}",
      "_a_co00023653",
      "0,1,0 own",
      "456",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_co0002i345{text-emphasis-style:\"foo\";}",
      "_a_co0002i345",
      "0,1,0 own",
      "456",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_co00017yre{text-emphasis-color:green;}",
      "_a_co00017yre",
      "0,1,0 own",
      "456",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_co1xtr{text-emphasis:open dot green;}",
      "_a_co1xtr",
      "0,1,0 own",
      "456",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_cp1nl6{text-emphasis-position:over;}",
      "_a_cp1nl6",
      "0,1,0 own",
      "457",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cpdg2o{text-emphasis-position:under;}",
      "_a_cpdg2o",
      "0,1,0 own",
      "457",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cpd4dg{text-emphasis-position:over left;}",
      "_a_cpd4dg",
      "0,1,0 own",
      "457",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cpsz24{text-emphasis-position:over right;}",
      "_a_cpsz24",
      "0,1,0 own",
      "457",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cpwejo{text-emphasis-position:under left;}",
      "_a_cpwejo",
      "0,1,0 own",
      "457",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cpux8j{text-emphasis-position:left under;}",
      "_a_cpux8j",
      "0,1,0 own",
      "457",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cps7qc{text-emphasis-position:under right;}",
      "_a_cps7qc",
      "0,1,0 own",
      "457",
      1,
      false,
    )
  ];
  [@css
    ("._a_cyql9z{text-shadow:none;}", "_a_cyql9z", "0,1,0 own", "466", 1, false)
  ];
  [@css
    (
      "._a_cyychj{text-shadow:1px 1px;}",
      "_a_cyychj",
      "0,1,0 own",
      "466",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cyo2mi{text-shadow:0 0 black;}",
      "_a_cyo2mi",
      "0,1,0 own",
      "466",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cyqa7n{text-shadow:1px 2px 3px;}",
      "_a_cyqa7n",
      "0,1,0 own",
      "466",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cyj1j4{text-shadow:1px 2px 3px black;}",
      "_a_cyj1j4",
      "0,1,0 own",
      "466",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cybx5y{text-shadow:1px 1px, 2px 2px red;}",
      "_a_cybx5y",
      "0,1,0 own",
      "466",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cy7zpt{text-shadow:1px 2px 3px black, 0 0 5px white;}",
      "_a_cy7zpt",
      "0,1,0 own",
      "466",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chxjle{text-decoration-skip:none;}",
      "_a_chxjle",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chhh35{text-decoration-skip:objects;}",
      "_a_chhh35",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chl9gi{text-decoration-skip:objects spaces;}",
      "_a_chl9gi",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chjofb{text-decoration-skip:objects leading-spaces;}",
      "_a_chjofb",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ch5tpa{text-decoration-skip:objects trailing-spaces;}",
      "_a_ch5tpa",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chl3dj{text-decoration-skip:objects leading-spaces trailing-spaces;}",
      "_a_chl3dj",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chwwzb{text-decoration-skip:objects leading-spaces trailing-spaces edges;}",
      "_a_chwwzb",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chj747{text-decoration-skip:objects leading-spaces trailing-spaces edges box-decoration;}",
      "_a_chj747",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chqqvz{text-decoration-skip:objects edges;}",
      "_a_chqqvz",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chjnz3{text-decoration-skip:objects box-decoration;}",
      "_a_chjnz3",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chnj6l{text-decoration-skip:spaces;}",
      "_a_chnj6l",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chlxfd{text-decoration-skip:spaces edges;}",
      "_a_chlxfd",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chealr{text-decoration-skip:spaces edges box-decoration;}",
      "_a_chealr",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ch9jre{text-decoration-skip:spaces box-decoration;}",
      "_a_ch9jre",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chf8ym{text-decoration-skip:leading-spaces;}",
      "_a_chf8ym",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chupg8{text-decoration-skip:leading-spaces trailing-spaces edges;}",
      "_a_chupg8",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chs8vu{text-decoration-skip:leading-spaces trailing-spaces edges box-decoration;}",
      "_a_chs8vu",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chty82{text-decoration-skip:edges;}",
      "_a_chty82",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chxscz{text-decoration-skip:edges box-decoration;}",
      "_a_chxscz",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_chedkd{text-decoration-skip:box-decoration;}",
      "_a_chedkd",
      "0,1,0 own",
      "449",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cjq7y7{text-decoration-skip-ink:none;}",
      "_a_cjq7y7",
      "0,1,0 own",
      "451",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cj1soe{text-decoration-skip-ink:auto;}",
      "_a_cj1soe",
      "0,1,0 own",
      "451",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cj2f09{text-decoration-skip-ink:all;}",
      "_a_cj2f09",
      "0,1,0 own",
      "451",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cifdf1{text-decoration-skip-box:none;}",
      "_a_cifdf1",
      "0,1,0 own",
      "450",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cidjmk{text-decoration-skip-box:all;}",
      "_a_cidjmk",
      "0,1,0 own",
      "450",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ck3yi9{text-decoration-skip-inset:none;}",
      "_a_ck3yi9",
      "0,1,0 own",
      "452",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ck0g23{text-decoration-skip-inset:auto;}",
      "_a_ck0g23",
      "0,1,0 own",
      "452",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_d2jicj{text-underline-offset:auto;}",
      "_a_d2jicj",
      "0,1,0 own",
      "470",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_d2lgvj{text-underline-offset:3px;}",
      "_a_d2lgvj",
      "0,1,0 own",
      "470",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_d2n22j{text-underline-offset:10%;}",
      "_a_d2n22j",
      "0,1,0 own",
      "470",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cf0008ssta{text-decoration-thickness:auto;}",
      "_a_cf0008ssta",
      "0,1,0 own",
      "447",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_cf0008yh8i{text-decoration-thickness:from-font;}",
      "_a_cf0008yh8i",
      "0,1,0 own",
      "447",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_cf0008jw5c{text-decoration-thickness:3px;}",
      "_a_cf0008jw5c",
      "0,1,0 own",
      "447",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_cf0008vgf0{text-decoration-thickness:10%;}",
      "_a_cf0008vgf0",
      "0,1,0 own",
      "447",
      8,
      false,
    )
  ];
  [@css.blocks
    [
      (3, "", [0]),
      (4, "", [1]),
      (5, "", [2]),
      (6, "", [3]),
      (7, "", [4]),
      (8, "", [5]),
      (9, "", [6]),
      (10, "", [7]),
      (11, "", [8]),
      (12, "", [9]),
      (13, "", [10]),
      (14, "", [11]),
      (15, "", [12]),
      (16, "", [13]),
      (17, "", [14]),
      (18, "", [15]),
      (19, "", [16]),
      (20, "", [17]),
      (21, "", [18]),
      (22, "", [19]),
      (23, "", [20]),
      (24, "", [21]),
      (25, "", [22]),
      (26, "", [23]),
      (27, "", [24]),
      (28, "", [25]),
      (29, "", [26]),
      (30, "", [27]),
      (31, "", [28]),
      (33, "", [29]),
      (34, "", [30]),
      (35, "", [31]),
      (36, "", [32]),
      (37, "", [33]),
      (38, "", [34]),
      (39, "", [35]),
      (42, "", [36]),
      (44, "", [37]),
      (46, "", [38]),
      (48, "", [39]),
      (50, "", [40]),
      (52, "", [41]),
      (53, "", [42]),
      (57, "", [43]),
      (58, "", [44]),
      (59, "", [45]),
      (60, "", [46]),
      (61, "", [47]),
      (62, "", [48]),
      (63, "", [49]),
      (65, "", [50]),
      (67, "", [51]),
      (68, "", [52]),
      (69, "", [53]),
      (70, "", [54]),
      (71, "", [55]),
      (72, "", [56]),
      (73, "", [57]),
      (74, "", [58]),
      (76, "", [59]),
      (78, "", [60]),
      (79, "", [61]),
      (80, "", [62]),
      (81, "", [63]),
      (82, "", [64]),
      (83, "", [65]),
      (84, "", [66]),
      (85, "", [67]),
      (86, "", [68]),
      (87, "", [69]),
      (88, "", [70]),
      (89, "", [71]),
      (90, "", [72]),
      (91, "", [73]),
      (92, "", [74]),
      (93, "", [75]),
      (94, "", [76]),
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
