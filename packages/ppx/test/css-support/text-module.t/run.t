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
      "._a_d1zs7t{text-transform:full-width;}",
      "_a_d1zs7t",
      "0,1,0 own",
      "469",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_d1cm01{text-transform:full-size-kana;}",
      "_a_d1cm01",
      "0,1,0 own",
      "469",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c3d4rk{-moz-tab-size:4;-o-tab-size:4;tab-size:4;}",
      "_a_c3d4rk",
      "0,1,0 own",
      "435",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c3seav{-moz-tab-size:1em;-o-tab-size:1em;tab-size:1em;}",
      "_a_c3seav",
      "0,1,0 own",
      "435",
      1,
      false,
    )
  ];
  [@css
    ("._a_7kf57d{line-break:auto;}", "_a_7kf57d", "0,1,0 own", "272", 1, false)
  ];
  [@css
    ("._a_7ku21a{line-break:loose;}", "_a_7ku21a", "0,1,0 own", "272", 1, false)
  ];
  [@css
    (
      "._a_7ktxm8{line-break:normal;}",
      "_a_7ktxm8",
      "0,1,0 own",
      "272",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7kkryp{line-break:strict;}",
      "_a_7kkryp",
      "0,1,0 own",
      "272",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7k3sz0{line-break:anywhere;}",
      "_a_7k3sz0",
      "0,1,0 own",
      "272",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_eegras{word-break:normal;}",
      "_a_eegras",
      "0,1,0 own",
      "518",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ee2x84{word-break:keep-all;}",
      "_a_ee2x84",
      "0,1,0 own",
      "518",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ee9omi{word-break:break-all;}",
      "_a_ee9omi",
      "0,1,0 own",
      "518",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_e95a1r{white-space:break-spaces;}",
      "_a_e95a1r",
      "0,1,0 own",
      "513",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6ryffq{-webkit-hyphens:auto;-moz-hyphens:auto;-ms-hyphens:auto;hyphens:auto;}",
      "_a_6ryffq",
      "0,1,0 own",
      "243",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6rmz35{-webkit-hyphens:manual;-moz-hyphens:manual;-ms-hyphens:manual;hyphens:manual;}",
      "_a_6rmz35",
      "0,1,0 own",
      "243",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6rs3eu{-webkit-hyphens:none;-moz-hyphens:none;-ms-hyphens:none;hyphens:none;}",
      "_a_6rs3eu",
      "0,1,0 own",
      "243",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8xlw6e{overflow-wrap:normal;}",
      "_a_8xlw6e",
      "0,1,0 own",
      "321",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8xkrze{overflow-wrap:break-word;}",
      "_a_8xkrze",
      "0,1,0 own",
      "321",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8x4jlj{overflow-wrap:anywhere;}",
      "_a_8x4jlj",
      "0,1,0 own",
      "321",
      1,
      false,
    )
  ];
  [@css
    ("._a_8xzy01{word-wrap:normal;}", "_a_8xzy01", "0,1,0 own", "321", 1, false)
  ];
  [@css
    (
      "._a_8xpt08{word-wrap:break-word;}",
      "_a_8xpt08",
      "0,1,0 own",
      "321",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8xnm8r{word-wrap:anywhere;}",
      "_a_8xnm8r",
      "0,1,0 own",
      "321",
      1,
      false,
    )
  ];
  [@css
    ("._a_c5f5ff{text-align:start;}", "_a_c5f5ff", "0,1,0 own", "437", 1, false)
  ];
  [@css
    ("._a_c5k842{text-align:end;}", "_a_c5k842", "0,1,0 own", "437", 1, false)
  ];
  [@css
    ("._a_c5rihr{text-align:left;}", "_a_c5rihr", "0,1,0 own", "437", 1, false)
  ];
  [@css
    ("._a_c5uf1z{text-align:right;}", "_a_c5uf1z", "0,1,0 own", "437", 1, false)
  ];
  [@css
    (
      "._a_c5606m{text-align:center;}",
      "_a_c5606m",
      "0,1,0 own",
      "437",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c5vos8{text-align:justify;}",
      "_a_c5vos8",
      "0,1,0 own",
      "437",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c58mhn{text-align:match-parent;}",
      "_a_c58mhn",
      "0,1,0 own",
      "437",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c53ksq{text-align:justify-all;}",
      "_a_c53ksq",
      "0,1,0 own",
      "437",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c6rn5a{text-align-all:start;}",
      "_a_c6rn5a",
      "0,1,0 own",
      "438",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c6ch4g{text-align-all:end;}",
      "_a_c6ch4g",
      "0,1,0 own",
      "438",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c6rnp3{text-align-all:left;}",
      "_a_c6rnp3",
      "0,1,0 own",
      "438",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c6xe7j{text-align-all:right;}",
      "_a_c6xe7j",
      "0,1,0 own",
      "438",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c6c0st{text-align-all:center;}",
      "_a_c6c0st",
      "0,1,0 own",
      "438",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c651av{text-align-all:justify;}",
      "_a_c651av",
      "0,1,0 own",
      "438",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c6rne5{text-align-all:match-parent;}",
      "_a_c6rne5",
      "0,1,0 own",
      "438",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c7wb1w{text-align-last:auto;}",
      "_a_c7wb1w",
      "0,1,0 own",
      "439",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c7axb4{text-align-last:start;}",
      "_a_c7axb4",
      "0,1,0 own",
      "439",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c7t416{text-align-last:end;}",
      "_a_c7t416",
      "0,1,0 own",
      "439",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c76fl7{text-align-last:left;}",
      "_a_c76fl7",
      "0,1,0 own",
      "439",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c7b6fv{text-align-last:right;}",
      "_a_c7b6fv",
      "0,1,0 own",
      "439",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c70fqu{text-align-last:center;}",
      "_a_c70fqu",
      "0,1,0 own",
      "439",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c7asgv{text-align-last:justify;}",
      "_a_c7asgv",
      "0,1,0 own",
      "439",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_c770fx{text-align-last:match-parent;}",
      "_a_c770fx",
      "0,1,0 own",
      "439",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_crqbb2{text-justify:auto;}",
      "_a_crqbb2",
      "0,1,0 own",
      "459",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_crbh2m{text-justify:none;}",
      "_a_crbh2m",
      "0,1,0 own",
      "459",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_crsqlp{text-justify:inter-word;}",
      "_a_crsqlp",
      "0,1,0 own",
      "459",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_crz8sg{text-justify:inter-character;}",
      "_a_crz8sg",
      "0,1,0 own",
      "459",
      1,
      false,
    )
  ];
  [@css
    ("._a_egc0xc{word-spacing:50%;}", "_a_egc0xc", "0,1,0 own", "520", 1, false)
  ];
  [@css
    (
      "._a_cqmiop{text-indent:1em hanging;}",
      "_a_cqmiop",
      "0,1,0 own",
      "458",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cqot2l{text-indent:1em each-line;}",
      "_a_cqot2l",
      "0,1,0 own",
      "458",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cqr8hy{text-indent:1em hanging each-line;}",
      "_a_cqr8hy",
      "0,1,0 own",
      "458",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6k3lqv{hanging-punctuation:none;}",
      "_a_6k3lqv",
      "0,1,0 own",
      "236",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6kjo68{hanging-punctuation:first;}",
      "_a_6kjo68",
      "0,1,0 own",
      "236",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6k534q{hanging-punctuation:last;}",
      "_a_6k534q",
      "0,1,0 own",
      "236",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6k34w2{hanging-punctuation:force-end;}",
      "_a_6k34w2",
      "0,1,0 own",
      "236",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6kc78w{hanging-punctuation:allow-end;}",
      "_a_6kc78w",
      "0,1,0 own",
      "236",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6kgwj2{hanging-punctuation:first last;}",
      "_a_6kgwj2",
      "0,1,0 own",
      "236",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6ks42f{hanging-punctuation:first force-end;}",
      "_a_6ks42f",
      "0,1,0 own",
      "236",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6kcfy1{hanging-punctuation:first force-end last;}",
      "_a_6kcfy1",
      "0,1,0 own",
      "236",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6kznai{hanging-punctuation:first allow-end last;}",
      "_a_6kznai",
      "0,1,0 own",
      "236",
      1,
      false,
    )
  ];
  [@css
    ("._a_d4w0i2{text-wrap:wrap;}", "_a_d4w0i2", "0,1,0 own", "472", 1, false)
  ];
  [@css
    ("._a_d4kd96{text-wrap:nowrap;}", "_a_d4kd96", "0,1,0 own", "472", 1, false)
  ];
  [@css
    (
      "._a_d4oged{text-wrap:balance;}",
      "_a_d4oged",
      "0,1,0 own",
      "472",
      1,
      false,
    )
  ];
  [@css
    ("._a_d4w6iq{text-wrap:stable;}", "_a_d4w6iq", "0,1,0 own", "472", 1, false)
  ];
  [@css
    ("._a_d43dgl{text-wrap:pretty;}", "_a_d43dgl", "0,1,0 own", "472", 1, false)
  ];
  [@css
    (
      "._a_d5b0wo{text-wrap-mode:wrap;}",
      "_a_d5b0wo",
      "0,1,0 own",
      "473",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_d5odyq{text-wrap-mode:nowrap;}",
      "_a_d5odyq",
      "0,1,0 own",
      "473",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_d6lvfv{text-wrap-style:auto;}",
      "_a_d6lvfv",
      "0,1,0 own",
      "474",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_d6ejd6{text-wrap-style:balance;}",
      "_a_d6ejd6",
      "0,1,0 own",
      "474",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_d6qii6{text-wrap-style:stable;}",
      "_a_d6qii6",
      "0,1,0 own",
      "474",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_d664fg{text-wrap-style:pretty;}",
      "_a_d664fg",
      "0,1,0 own",
      "474",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6m76yp{hyphenate-character:auto;}",
      "_a_6m76yp",
      "0,1,0 own",
      "238",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6qqykq{hyphenate-limit-zone:1%;}",
      "_a_6qqykq",
      "0,1,0 own",
      "242",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6qimjy{hyphenate-limit-zone:1em;}",
      "_a_6qimjy",
      "0,1,0 own",
      "242",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6nlbs0{hyphenate-limit-chars:auto;}",
      "_a_6nlbs0",
      "0,1,0 own",
      "239",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6np8d5{hyphenate-limit-chars:5;}",
      "_a_6np8d5",
      "0,1,0 own",
      "239",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6px7k1{hyphenate-limit-lines:no-limit;}",
      "_a_6px7k1",
      "0,1,0 own",
      "241",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6prd43{hyphenate-limit-lines:2;}",
      "_a_6prd43",
      "0,1,0 own",
      "241",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (2, "", [0]),
      (3, "", [1]),
      (6, "", [2]),
      (7, "", [3]),
      (8, "", [4]),
      (9, "", [5]),
      (10, "", [6]),
      (11, "", [7]),
      (12, "", [8]),
      (13, "", [9]),
      (14, "", [10]),
      (15, "", [11]),
      (16, "", [12]),
      (17, "", [13]),
      (18, "", [14]),
      (19, "", [15]),
      (20, "", [16]),
      (21, "", [17]),
      (22, "", [18]),
      (23, "", [19]),
      (24, "", [20]),
      (25, "", [21]),
      (26, "", [22]),
      (27, "", [23]),
      (28, "", [24]),
      (29, "", [25]),
      (30, "", [26]),
      (31, "", [27]),
      (32, "", [28]),
      (33, "", [29]),
      (34, "", [30]),
      (35, "", [31]),
      (36, "", [32]),
      (37, "", [33]),
      (38, "", [34]),
      (39, "", [35]),
      (40, "", [36]),
      (41, "", [37]),
      (42, "", [38]),
      (43, "", [39]),
      (44, "", [40]),
      (45, "", [41]),
      (46, "", [42]),
      (47, "", [43]),
      (48, "", [44]),
      (49, "", [45]),
      (50, "", [46]),
      (51, "", [47]),
      (52, "", [48]),
      (53, "", [49]),
      (54, "", [50]),
      (55, "", [51]),
      (56, "", [52]),
      (57, "", [53]),
      (58, "", [54]),
      (59, "", [55]),
      (60, "", [56]),
      (61, "", [57]),
      (62, "", [58]),
      (63, "", [59]),
      (64, "", [60]),
      (65, "", [61]),
      (79, "", [62]),
      (80, "", [63]),
      (81, "", [64]),
      (82, "", [65]),
      (83, "", [66]),
      (84, "", [67]),
      (85, "", [68]),
      (86, "", [69]),
      (87, "", [70]),
      (88, "", [71]),
      (89, "", [72]),
      (104, "", [73]),
      (105, "", [74]),
      (106, "", [75]),
      (107, "", [76]),
      (108, "", [77]),
      (111, "", [78]),
      (112, "", [79]),
    ]
  ];
  
  CSS.make("_a_d1zs7t", []);
  CSS.make("_a_d1cm01", []);
  
  CSS.make("_a_c3d4rk", []);
  CSS.make("_a_c3seav", []);
  CSS.make("_a_7kf57d", []);
  CSS.make("_a_7ku21a", []);
  CSS.make("_a_7ktxm8", []);
  CSS.make("_a_7kkryp", []);
  CSS.make("_a_7k3sz0", []);
  CSS.make("_a_eegras", []);
  CSS.make("_a_ee2x84", []);
  CSS.make("_a_ee9omi", []);
  CSS.make("_a_e95a1r", []);
  CSS.make("_a_6ryffq", []);
  CSS.make("_a_6rmz35", []);
  CSS.make("_a_6rs3eu", []);
  CSS.make("_a_8xlw6e", []);
  CSS.make("_a_8xkrze", []);
  CSS.make("_a_8x4jlj", []);
  CSS.make("_a_8xzy01", []);
  CSS.make("_a_8xpt08", []);
  CSS.make("_a_8xnm8r", []);
  CSS.make("_a_c5f5ff", []);
  CSS.make("_a_c5k842", []);
  CSS.make("_a_c5rihr", []);
  CSS.make("_a_c5uf1z", []);
  CSS.make("_a_c5606m", []);
  CSS.make("_a_c5vos8", []);
  CSS.make("_a_c58mhn", []);
  CSS.make("_a_c53ksq", []);
  CSS.make("_a_c6rn5a", []);
  CSS.make("_a_c6ch4g", []);
  CSS.make("_a_c6rnp3", []);
  CSS.make("_a_c6xe7j", []);
  CSS.make("_a_c6c0st", []);
  CSS.make("_a_c651av", []);
  CSS.make("_a_c6rne5", []);
  CSS.make("_a_c7wb1w", []);
  CSS.make("_a_c7axb4", []);
  CSS.make("_a_c7t416", []);
  CSS.make("_a_c76fl7", []);
  CSS.make("_a_c7b6fv", []);
  CSS.make("_a_c70fqu", []);
  CSS.make("_a_c7asgv", []);
  CSS.make("_a_c770fx", []);
  CSS.make("_a_crqbb2", []);
  CSS.make("_a_crbh2m", []);
  CSS.make("_a_crsqlp", []);
  CSS.make("_a_crz8sg", []);
  CSS.make("_a_egc0xc", []);
  CSS.make("_a_cqmiop", []);
  CSS.make("_a_cqot2l", []);
  CSS.make("_a_cqr8hy", []);
  CSS.make("_a_6k3lqv", []);
  CSS.make("_a_6kjo68", []);
  CSS.make("_a_6k534q", []);
  CSS.make("_a_6k34w2", []);
  CSS.make("_a_6kc78w", []);
  CSS.make("_a_6kgwj2", []);
  CSS.make("_a_6ks42f", []);
  CSS.make("_a_6kcfy1", []);
  CSS.make("_a_6kznai", []);
  
  CSS.make("_a_d4w0i2", []);
  CSS.make("_a_d4kd96", []);
  CSS.make("_a_d4oged", []);
  CSS.make("_a_d4w6iq", []);
  CSS.make("_a_d43dgl", []);
  CSS.make("_a_d5b0wo", []);
  CSS.make("_a_d5odyq", []);
  CSS.make("_a_d6lvfv", []);
  CSS.make("_a_d6ejd6", []);
  CSS.make("_a_d6qii6", []);
  CSS.make("_a_d664fg", []);
  
  CSS.make("_a_6m76yp", []);
  CSS.make("_a_6qqykq", []);
  CSS.make("_a_6qimjy", []);
  CSS.make("_a_6nlbs0", []);
  CSS.make("_a_6np8d5", []);
  
  CSS.make("_a_6px7k1", []);
  CSS.make("_a_6prd43", []);
