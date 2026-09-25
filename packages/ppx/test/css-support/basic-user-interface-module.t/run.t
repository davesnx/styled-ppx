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
  [@css ".a-41ynbj{box-sizing:border-box;}"];
  [@css ".a-4193ep{box-sizing:content-box;}"];
  [@css ".a-8p002s84b{outline-style:auto;}"];
  [@css ".a-8p002dro3{outline-style:none;}"];
  [@css ".a-8p002ynf6{outline-style:dotted;}"];
  [@css ".a-8p002qa57{outline-style:dashed;}"];
  [@css ".a-8p0029twl{outline-style:solid;}"];
  [@css ".a-8p002oq43{outline-style:double;}"];
  [@css ".a-8p0021dni{outline-style:groove;}"];
  [@css ".a-8p002ia9n{outline-style:ridge;}"];
  [@css ".a-8p002duzy{outline-style:inset;}"];
  [@css ".a-8p0028noo{outline-style:outset;}"];
  [@css ".a-8qr6ge{outline-offset:-5px;}"];
  [@css ".a-8qfqwb{outline-offset:0;}"];
  [@css ".a-8qch4u{outline-offset:5px;}"];
  [@css ".a-9y6l6w{resize:none;}"];
  [@css ".a-9ywl10{resize:both;}"];
  [@css ".a-9y0f2m{resize:horizontal;}"];
  [@css ".a-9yqaai{resize:vertical;}"];
  [@css ".a-cwkj8c{text-overflow:clip;}"];
  [@css ".a-cwjq4j{text-overflow:ellipsis;}"];
  [@css ".a-5lr2w0{cursor:default;}"];
  [@css ".a-5l6hmx{cursor:none;}"];
  [@css ".a-5l4qqq{cursor:context-menu;}"];
  [@css ".a-5laee9{cursor:cell;}"];
  [@css ".a-5lkbts{cursor:vertical-text;}"];
  [@css ".a-5llkeh{cursor:alias;}"];
  [@css ".a-5l476y{cursor:copy;}"];
  [@css ".a-5ls137{cursor:no-drop;}"];
  [@css ".a-5lhlfv{cursor:not-allowed;}"];
  [@css ".a-5lba41{cursor:-webkit-grab;cursor:grab;}"];
  [@css ".a-5laufq{cursor:-webkit-grabbing;cursor:grabbing;}"];
  [@css ".a-5lsboj{cursor:ew-resize;}"];
  [@css ".a-5lxfz0{cursor:ns-resize;}"];
  [@css ".a-5l8jep{cursor:nesw-resize;}"];
  [@css ".a-5lobzn{cursor:nwse-resize;}"];
  [@css ".a-5ljlp0{cursor:col-resize;}"];
  [@css ".a-5lwrya{cursor:row-resize;}"];
  [@css ".a-5luxfn{cursor:all-scroll;}"];
  [@css ".a-5ld1sg{cursor:zoom-in;}"];
  [@css ".a-5ltb2g{cursor:zoom-out;}"];
  [@css ".a-48pnps{caret-color:auto;}"];
  [@css ".a-481yyj{caret-color:green;}"];
  [@css
    ".a-33ky4e{-webkit-appearance:auto;-moz-appearance:auto;-ms-appearance:auto;appearance:auto;}"
  ];
  [@css
    ".a-33rcf8{-webkit-appearance:none;-moz-appearance:none;-ms-appearance:none;appearance:none;}"
  ];
  [@css ".a-cwooc5{text-overflow:\"foo\";}"];
  [@css ".a-cwfzgv{text-overflow:clip clip;}"];
  [@css ".a-cw1axg{text-overflow:ellipsis clip;}"];
  [@css ".a-cw1db5{text-overflow:\"foo\" clip;}"];
  [@css ".a-cw9k39{text-overflow:clip ellipsis;}"];
  [@css ".a-cw42kz{text-overflow:ellipsis ellipsis;}"];
  [@css ".a-cwad1k{text-overflow:\"foo\" ellipsis;}"];
  [@css ".a-cw09ns{text-overflow:clip \"foo\";}"];
  [@css ".a-cwgl00{text-overflow:ellipsis \"foo\";}"];
  [@css ".a-cwjnzg{text-overflow:\"foo\" \"foo\";}"];
  [@css
    ".a-drp0oo{-webkit-user-select:auto;-moz-user-select:auto;-ms-user-select:auto;user-select:auto;}"
  ];
  [@css
    ".a-droigx{-webkit-user-select:text;-moz-user-select:text;-ms-user-select:text;user-select:text;}"
  ];
  [@css
    ".a-dr6172{-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}"
  ];
  [@css
    ".a-dryfv1{-webkit-user-select:contain;-moz-user-select:contain;-ms-user-select:contain;user-select:contain;}"
  ];
  [@css
    ".a-drvaqc{-webkit-user-select:all;-moz-user-select:all;-ms-user-select:all;user-select:all;}"
  ];
  
  CSS.make("a-41ynbj", []);
  CSS.make("a-4193ep", []);
  CSS.make("a-8p002s84b", []);
  CSS.make("a-8p002dro3", []);
  CSS.make("a-8p002ynf6", []);
  CSS.make("a-8p002qa57", []);
  CSS.make("a-8p0029twl", []);
  CSS.make("a-8p002oq43", []);
  CSS.make("a-8p0021dni", []);
  CSS.make("a-8p002ia9n", []);
  CSS.make("a-8p002duzy", []);
  CSS.make("a-8p0028noo", []);
  CSS.make("a-8qr6ge", []);
  CSS.make("a-8qfqwb", []);
  CSS.make("a-8qch4u", []);
  CSS.make("a-9y6l6w", []);
  CSS.make("a-9ywl10", []);
  CSS.make("a-9y0f2m", []);
  CSS.make("a-9yqaai", []);
  CSS.make("a-cwkj8c", []);
  CSS.make("a-cwjq4j", []);
  
  CSS.make("a-5lr2w0", []);
  CSS.make("a-5l6hmx", []);
  CSS.make("a-5l4qqq", []);
  CSS.make("a-5laee9", []);
  CSS.make("a-5lkbts", []);
  CSS.make("a-5llkeh", []);
  CSS.make("a-5l476y", []);
  CSS.make("a-5ls137", []);
  CSS.make("a-5lhlfv", []);
  CSS.make("a-5lba41", []);
  CSS.make("a-5laufq", []);
  CSS.make("a-5lsboj", []);
  CSS.make("a-5lxfz0", []);
  CSS.make("a-5l8jep", []);
  CSS.make("a-5lobzn", []);
  CSS.make("a-5ljlp0", []);
  CSS.make("a-5lwrya", []);
  CSS.make("a-5luxfn", []);
  CSS.make("a-5ld1sg", []);
  CSS.make("a-5ltb2g", []);
  CSS.make("a-48pnps", []);
  CSS.make("a-481yyj", []);
  
  CSS.make("a-33ky4e", []);
  CSS.make("a-33rcf8", []);
  
  CSS.make("a-cwkj8c", []);
  CSS.make("a-cwjq4j", []);
  
  CSS.make("a-cwooc5", []);
  CSS.make("a-cwfzgv", []);
  CSS.make("a-cw1axg", []);
  
  CSS.make("a-cw1db5", []);
  CSS.make("a-cw9k39", []);
  CSS.make("a-cw42kz", []);
  
  CSS.make("a-cwad1k", []);
  
  CSS.make("a-cw09ns", []);
  CSS.make("a-cwgl00", []);
  
  CSS.make("a-cwjnzg", []);
  CSS.make("a-drp0oo", []);
  CSS.make("a-droigx", []);
  CSS.make("a-dr6172", []);
  CSS.make("a-dryfv1", []);
  CSS.make("a-drvaqc", []);

  $ dune build
