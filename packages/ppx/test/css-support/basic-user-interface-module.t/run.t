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
  [@css "._a_41ynbj{box-sizing:border-box;}"];
  [@css "._a_4193ep{box-sizing:content-box;}"];
  [@css "._a_8p0002s84b{outline-style:auto;}"];
  [@css "._a_8p0002dro3{outline-style:none;}"];
  [@css "._a_8p0002ynf6{outline-style:dotted;}"];
  [@css "._a_8p0002qa57{outline-style:dashed;}"];
  [@css "._a_8p00029twl{outline-style:solid;}"];
  [@css "._a_8p0002oq43{outline-style:double;}"];
  [@css "._a_8p00021dni{outline-style:groove;}"];
  [@css "._a_8p0002ia9n{outline-style:ridge;}"];
  [@css "._a_8p0002duzy{outline-style:inset;}"];
  [@css "._a_8p00028noo{outline-style:outset;}"];
  [@css "._a_8qr6ge{outline-offset:-5px;}"];
  [@css "._a_8qfqwb{outline-offset:0;}"];
  [@css "._a_8qch4u{outline-offset:5px;}"];
  [@css "._a_9y6l6w{resize:none;}"];
  [@css "._a_9ywl10{resize:both;}"];
  [@css "._a_9y0f2m{resize:horizontal;}"];
  [@css "._a_9yqaai{resize:vertical;}"];
  [@css "._a_cwkj8c{text-overflow:clip;}"];
  [@css "._a_cwjq4j{text-overflow:ellipsis;}"];
  [@css "._a_5lr2w0{cursor:default;}"];
  [@css "._a_5l6hmx{cursor:none;}"];
  [@css "._a_5l4qqq{cursor:context-menu;}"];
  [@css "._a_5laee9{cursor:cell;}"];
  [@css "._a_5lkbts{cursor:vertical-text;}"];
  [@css "._a_5llkeh{cursor:alias;}"];
  [@css "._a_5l476y{cursor:copy;}"];
  [@css "._a_5ls137{cursor:no-drop;}"];
  [@css "._a_5lhlfv{cursor:not-allowed;}"];
  [@css "._a_5lba41{cursor:-webkit-grab;cursor:grab;}"];
  [@css "._a_5laufq{cursor:-webkit-grabbing;cursor:grabbing;}"];
  [@css "._a_5lsboj{cursor:ew-resize;}"];
  [@css "._a_5lxfz0{cursor:ns-resize;}"];
  [@css "._a_5l8jep{cursor:nesw-resize;}"];
  [@css "._a_5lobzn{cursor:nwse-resize;}"];
  [@css "._a_5ljlp0{cursor:col-resize;}"];
  [@css "._a_5lwrya{cursor:row-resize;}"];
  [@css "._a_5luxfn{cursor:all-scroll;}"];
  [@css "._a_5ld1sg{cursor:zoom-in;}"];
  [@css "._a_5ltb2g{cursor:zoom-out;}"];
  [@css "._a_48pnps{caret-color:auto;}"];
  [@css "._a_481yyj{caret-color:green;}"];
  [@css
    "._a_33ky4e{-webkit-appearance:auto;-moz-appearance:auto;appearance:auto;}"
  ];
  [@css
    "._a_33rcf8{-webkit-appearance:none;-moz-appearance:none;appearance:none;}"
  ];
  [@css "._a_cwooc5{text-overflow:\"foo\";}"];
  [@css "._a_cwfzgv{text-overflow:clip clip;}"];
  [@css "._a_cw1axg{text-overflow:ellipsis clip;}"];
  [@css "._a_cw1db5{text-overflow:\"foo\" clip;}"];
  [@css "._a_cw9k39{text-overflow:clip ellipsis;}"];
  [@css "._a_cw42kz{text-overflow:ellipsis ellipsis;}"];
  [@css "._a_cwad1k{text-overflow:\"foo\" ellipsis;}"];
  [@css "._a_cw09ns{text-overflow:clip \"foo\";}"];
  [@css "._a_cwgl00{text-overflow:ellipsis \"foo\";}"];
  [@css "._a_cwjnzg{text-overflow:\"foo\" \"foo\";}"];
  [@css
    "._a_drp0oo{-webkit-user-select:auto;-moz-user-select:auto;-ms-user-select:auto;user-select:auto;}"
  ];
  [@css
    "._a_droigx{-webkit-user-select:text;-moz-user-select:text;-ms-user-select:text;user-select:text;}"
  ];
  [@css
    "._a_dr6172{-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}"
  ];
  [@css
    "._a_dryfv1{-webkit-user-select:contain;-moz-user-select:contain;-ms-user-select:contain;user-select:contain;}"
  ];
  [@css
    "._a_drvaqc{-webkit-user-select:all;-moz-user-select:all;-ms-user-select:all;user-select:all;}"
  ];
  [@css.blocks
    [
      (2, "_a_41ynbj"),
      (3, "_a_4193ep"),
      (4, "_a_8p0002s84b"),
      (5, "_a_8p0002dro3"),
      (6, "_a_8p0002ynf6"),
      (7, "_a_8p0002qa57"),
      (8, "_a_8p00029twl"),
      (9, "_a_8p0002oq43"),
      (10, "_a_8p00021dni"),
      (11, "_a_8p0002ia9n"),
      (12, "_a_8p0002duzy"),
      (13, "_a_8p00028noo"),
      (14, "_a_8qr6ge"),
      (15, "_a_8qfqwb"),
      (16, "_a_8qch4u"),
      (17, "_a_9y6l6w"),
      (18, "_a_9ywl10"),
      (19, "_a_9y0f2m"),
      (20, "_a_9yqaai"),
      (21, "_a_cwkj8c"),
      (22, "_a_cwjq4j"),
      (24, "_a_5lr2w0"),
      (25, "_a_5l6hmx"),
      (26, "_a_5l4qqq"),
      (27, "_a_5laee9"),
      (28, "_a_5lkbts"),
      (29, "_a_5llkeh"),
      (30, "_a_5l476y"),
      (31, "_a_5ls137"),
      (32, "_a_5lhlfv"),
      (33, "_a_5lba41"),
      (34, "_a_5laufq"),
      (35, "_a_5lsboj"),
      (36, "_a_5lxfz0"),
      (37, "_a_5l8jep"),
      (38, "_a_5lobzn"),
      (39, "_a_5ljlp0"),
      (40, "_a_5lwrya"),
      (41, "_a_5luxfn"),
      (42, "_a_5ld1sg"),
      (43, "_a_5ltb2g"),
      (44, "_a_48pnps"),
      (45, "_a_481yyj"),
      (48, "_a_33ky4e"),
      (49, "_a_33rcf8"),
      (58, "_a_cwkj8c"),
      (59, "_a_cwjq4j"),
      (63, "_a_cwooc5"),
      (64, "_a_cwfzgv"),
      (65, "_a_cw1axg"),
      (69, "_a_cw1db5"),
      (70, "_a_cw9k39"),
      (71, "_a_cw42kz"),
      (75, "_a_cwad1k"),
      (94, "_a_cw09ns"),
      (95, "_a_cwgl00"),
      (99, "_a_cwjnzg"),
      (100, "_a_drp0oo"),
      (101, "_a_droigx"),
      (102, "_a_dr6172"),
      (103, "_a_dryfv1"),
      (104, "_a_drvaqc"),
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
