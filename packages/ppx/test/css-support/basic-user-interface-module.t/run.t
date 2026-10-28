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
      "._a_41ynbj{box-sizing:border-box;}",
      "_a_41ynbj",
      "0,1,0 own",
      "145",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4193ep{box-sizing:content-box;}",
      "_a_4193ep",
      "0,1,0 own",
      "145",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8p0002s84b{outline-style:auto;}",
      "_a_8p0002s84b",
      "0,1,0 own",
      "313",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8p0002dro3{outline-style:none;}",
      "_a_8p0002dro3",
      "0,1,0 own",
      "313",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8p0002ynf6{outline-style:dotted;}",
      "_a_8p0002ynf6",
      "0,1,0 own",
      "313",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8p0002qa57{outline-style:dashed;}",
      "_a_8p0002qa57",
      "0,1,0 own",
      "313",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8p00029twl{outline-style:solid;}",
      "_a_8p00029twl",
      "0,1,0 own",
      "313",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8p0002oq43{outline-style:double;}",
      "_a_8p0002oq43",
      "0,1,0 own",
      "313",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8p00021dni{outline-style:groove;}",
      "_a_8p00021dni",
      "0,1,0 own",
      "313",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8p0002ia9n{outline-style:ridge;}",
      "_a_8p0002ia9n",
      "0,1,0 own",
      "313",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8p0002duzy{outline-style:inset;}",
      "_a_8p0002duzy",
      "0,1,0 own",
      "313",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8p00028noo{outline-style:outset;}",
      "_a_8p00028noo",
      "0,1,0 own",
      "313",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8qr6ge{outline-offset:-5px;}",
      "_a_8qr6ge",
      "0,1,0 own",
      "314",
      1,
      false,
    )
  ];
  [@css
    ("._a_8qfqwb{outline-offset:0;}", "_a_8qfqwb", "0,1,0 own", "314", 1, false)
  ];
  [@css
    (
      "._a_8qch4u{outline-offset:5px;}",
      "_a_8qch4u",
      "0,1,0 own",
      "314",
      1,
      false,
    )
  ];
  [@css
    ("._a_9y6l6w{resize:none;}", "_a_9y6l6w", "0,1,0 own", "358", 1, false)
  ];
  [@css
    ("._a_9ywl10{resize:both;}", "_a_9ywl10", "0,1,0 own", "358", 1, false)
  ];
  [@css
    (
      "._a_9y0f2m{resize:horizontal;}",
      "_a_9y0f2m",
      "0,1,0 own",
      "358",
      1,
      false,
    )
  ];
  [@css
    ("._a_9yqaai{resize:vertical;}", "_a_9yqaai", "0,1,0 own", "358", 1, false)
  ];
  [@css
    (
      "._a_cwkj8c{text-overflow:clip;}",
      "_a_cwkj8c",
      "0,1,0 own",
      "464",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cwjq4j{text-overflow:ellipsis;}",
      "_a_cwjq4j",
      "0,1,0 own",
      "464",
      1,
      false,
    )
  ];
  [@css
    ("._a_5lr2w0{cursor:default;}", "_a_5lr2w0", "0,1,0 own", "201", 1, false)
  ];
  [@css
    ("._a_5l6hmx{cursor:none;}", "_a_5l6hmx", "0,1,0 own", "201", 1, false)
  ];
  [@css
    (
      "._a_5l4qqq{cursor:context-menu;}",
      "_a_5l4qqq",
      "0,1,0 own",
      "201",
      1,
      false,
    )
  ];
  [@css
    ("._a_5laee9{cursor:cell;}", "_a_5laee9", "0,1,0 own", "201", 1, false)
  ];
  [@css
    (
      "._a_5lkbts{cursor:vertical-text;}",
      "_a_5lkbts",
      "0,1,0 own",
      "201",
      1,
      false,
    )
  ];
  [@css
    ("._a_5llkeh{cursor:alias;}", "_a_5llkeh", "0,1,0 own", "201", 1, false)
  ];
  [@css
    ("._a_5l476y{cursor:copy;}", "_a_5l476y", "0,1,0 own", "201", 1, false)
  ];
  [@css
    ("._a_5ls137{cursor:no-drop;}", "_a_5ls137", "0,1,0 own", "201", 1, false)
  ];
  [@css
    (
      "._a_5lhlfv{cursor:not-allowed;}",
      "_a_5lhlfv",
      "0,1,0 own",
      "201",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5lba41{cursor:-webkit-grab;cursor:grab;}",
      "_a_5lba41",
      "0,1,0 own",
      "201",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5laufq{cursor:-webkit-grabbing;cursor:grabbing;}",
      "_a_5laufq",
      "0,1,0 own",
      "201",
      1,
      false,
    )
  ];
  [@css
    ("._a_5lsboj{cursor:ew-resize;}", "_a_5lsboj", "0,1,0 own", "201", 1, false)
  ];
  [@css
    ("._a_5lxfz0{cursor:ns-resize;}", "_a_5lxfz0", "0,1,0 own", "201", 1, false)
  ];
  [@css
    (
      "._a_5l8jep{cursor:nesw-resize;}",
      "_a_5l8jep",
      "0,1,0 own",
      "201",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5lobzn{cursor:nwse-resize;}",
      "_a_5lobzn",
      "0,1,0 own",
      "201",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5ljlp0{cursor:col-resize;}",
      "_a_5ljlp0",
      "0,1,0 own",
      "201",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5lwrya{cursor:row-resize;}",
      "_a_5lwrya",
      "0,1,0 own",
      "201",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5luxfn{cursor:all-scroll;}",
      "_a_5luxfn",
      "0,1,0 own",
      "201",
      1,
      false,
    )
  ];
  [@css
    ("._a_5ld1sg{cursor:zoom-in;}", "_a_5ld1sg", "0,1,0 own", "201", 1, false)
  ];
  [@css
    ("._a_5ltb2g{cursor:zoom-out;}", "_a_5ltb2g", "0,1,0 own", "201", 1, false)
  ];
  [@css
    ("._a_48pnps{caret-color:auto;}", "_a_48pnps", "0,1,0 own", "152", 1, false)
  ];
  [@css
    (
      "._a_481yyj{caret-color:green;}",
      "_a_481yyj",
      "0,1,0 own",
      "152",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_33ky4e{-webkit-appearance:auto;-moz-appearance:auto;appearance:auto;}",
      "_a_33ky4e",
      "0,1,0 own",
      "111",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_33rcf8{-webkit-appearance:none;-moz-appearance:none;appearance:none;}",
      "_a_33rcf8",
      "0,1,0 own",
      "111",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cwooc5{text-overflow:\"foo\";}",
      "_a_cwooc5",
      "0,1,0 own",
      "464",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cwfzgv{text-overflow:clip clip;}",
      "_a_cwfzgv",
      "0,1,0 own",
      "464",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cw1axg{text-overflow:ellipsis clip;}",
      "_a_cw1axg",
      "0,1,0 own",
      "464",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cw1db5{text-overflow:\"foo\" clip;}",
      "_a_cw1db5",
      "0,1,0 own",
      "464",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cw9k39{text-overflow:clip ellipsis;}",
      "_a_cw9k39",
      "0,1,0 own",
      "464",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cw42kz{text-overflow:ellipsis ellipsis;}",
      "_a_cw42kz",
      "0,1,0 own",
      "464",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cwad1k{text-overflow:\"foo\" ellipsis;}",
      "_a_cwad1k",
      "0,1,0 own",
      "464",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cw09ns{text-overflow:clip \"foo\";}",
      "_a_cw09ns",
      "0,1,0 own",
      "464",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cwgl00{text-overflow:ellipsis \"foo\";}",
      "_a_cwgl00",
      "0,1,0 own",
      "464",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cwjnzg{text-overflow:\"foo\" \"foo\";}",
      "_a_cwjnzg",
      "0,1,0 own",
      "464",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_drp0oo{-webkit-user-select:auto;-moz-user-select:auto;-ms-user-select:auto;user-select:auto;}",
      "_a_drp0oo",
      "0,1,0 own",
      "495",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_droigx{-webkit-user-select:text;-moz-user-select:text;-ms-user-select:text;user-select:text;}",
      "_a_droigx",
      "0,1,0 own",
      "495",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dr6172{-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}",
      "_a_dr6172",
      "0,1,0 own",
      "495",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dryfv1{-webkit-user-select:contain;-moz-user-select:contain;-ms-user-select:contain;user-select:contain;}",
      "_a_dryfv1",
      "0,1,0 own",
      "495",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_drvaqc{-webkit-user-select:all;-moz-user-select:all;-ms-user-select:all;user-select:all;}",
      "_a_drvaqc",
      "0,1,0 own",
      "495",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (2, "", [0]),
      (3, "", [1]),
      (4, "", [2]),
      (5, "", [3]),
      (6, "", [4]),
      (7, "", [5]),
      (8, "", [6]),
      (9, "", [7]),
      (10, "", [8]),
      (11, "", [9]),
      (12, "", [10]),
      (13, "", [11]),
      (14, "", [12]),
      (15, "", [13]),
      (16, "", [14]),
      (17, "", [15]),
      (18, "", [16]),
      (19, "", [17]),
      (20, "", [18]),
      (21, "", [19]),
      (22, "", [20]),
      (24, "", [21]),
      (25, "", [22]),
      (26, "", [23]),
      (27, "", [24]),
      (28, "", [25]),
      (29, "", [26]),
      (30, "", [27]),
      (31, "", [28]),
      (32, "", [29]),
      (33, "", [30]),
      (34, "", [31]),
      (35, "", [32]),
      (36, "", [33]),
      (37, "", [34]),
      (38, "", [35]),
      (39, "", [36]),
      (40, "", [37]),
      (41, "", [38]),
      (42, "", [39]),
      (43, "", [40]),
      (44, "", [41]),
      (45, "", [42]),
      (48, "", [43]),
      (49, "", [44]),
      (58, "", [19]),
      (59, "", [20]),
      (63, "", [45]),
      (64, "", [46]),
      (65, "", [47]),
      (69, "", [48]),
      (70, "", [49]),
      (71, "", [50]),
      (75, "", [51]),
      (94, "", [52]),
      (95, "", [53]),
      (99, "", [54]),
      (100, "", [55]),
      (101, "", [56]),
      (102, "", [57]),
      (103, "", [58]),
      (104, "", [59]),
    ]
  ];
  
  CSS.make("_a_41ynbj", []);
  CSS.make("_a_4193ep", []);
  CSS.make("_a_8p0002s84b", []);
  CSS.make("_a_8p0002dro3", []);
  CSS.make("_a_8p0002ynf6", []);
  CSS.make("_a_8p0002qa57", []);
  CSS.make("_a_8p00029twl", []);
  CSS.make("_a_8p0002oq43", []);
  CSS.make("_a_8p00021dni", []);
  CSS.make("_a_8p0002ia9n", []);
  CSS.make("_a_8p0002duzy", []);
  CSS.make("_a_8p00028noo", []);
  CSS.make("_a_8qr6ge", []);
  CSS.make("_a_8qfqwb", []);
  CSS.make("_a_8qch4u", []);
  CSS.make("_a_9y6l6w", []);
  CSS.make("_a_9ywl10", []);
  CSS.make("_a_9y0f2m", []);
  CSS.make("_a_9yqaai", []);
  CSS.make("_a_cwkj8c", []);
  CSS.make("_a_cwjq4j", []);
  
  CSS.make("_a_5lr2w0", []);
  CSS.make("_a_5l6hmx", []);
  CSS.make("_a_5l4qqq", []);
  CSS.make("_a_5laee9", []);
  CSS.make("_a_5lkbts", []);
  CSS.make("_a_5llkeh", []);
  CSS.make("_a_5l476y", []);
  CSS.make("_a_5ls137", []);
  CSS.make("_a_5lhlfv", []);
  CSS.make("_a_5lba41", []);
  CSS.make("_a_5laufq", []);
  CSS.make("_a_5lsboj", []);
  CSS.make("_a_5lxfz0", []);
  CSS.make("_a_5l8jep", []);
  CSS.make("_a_5lobzn", []);
  CSS.make("_a_5ljlp0", []);
  CSS.make("_a_5lwrya", []);
  CSS.make("_a_5luxfn", []);
  CSS.make("_a_5ld1sg", []);
  CSS.make("_a_5ltb2g", []);
  CSS.make("_a_48pnps", []);
  CSS.make("_a_481yyj", []);
  
  CSS.make("_a_33ky4e", []);
  CSS.make("_a_33rcf8", []);
  
  CSS.make("_a_cwkj8c", []);
  CSS.make("_a_cwjq4j", []);
  
  CSS.make("_a_cwooc5", []);
  CSS.make("_a_cwfzgv", []);
  CSS.make("_a_cw1axg", []);
  
  CSS.make("_a_cw1db5", []);
  CSS.make("_a_cw9k39", []);
  CSS.make("_a_cw42kz", []);
  
  CSS.make("_a_cwad1k", []);
  
  CSS.make("_a_cw09ns", []);
  CSS.make("_a_cwgl00", []);
  
  CSS.make("_a_cwjnzg", []);
  CSS.make("_a_drp0oo", []);
  CSS.make("_a_droigx", []);
  CSS.make("_a_dr6172", []);
  CSS.make("_a_dryfv1", []);
  CSS.make("_a_drvaqc", []);

  $ dune build
