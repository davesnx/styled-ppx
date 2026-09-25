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
  [@css ".a-roynbj{box-sizing:border-box;}"];
  [@css ".a-g393ep{box-sizing:content-box;}"];
  [@css ".a-19ks84b{outline-style:auto;}"];
  [@css ".a-vqdro3{outline-style:none;}"];
  [@css ".a-xlynf6{outline-style:dotted;}"];
  [@css ".a-1hmqa57{outline-style:dashed;}"];
  [@css ".a-1709twl{outline-style:solid;}"];
  [@css ".a-1dqoq43{outline-style:double;}"];
  [@css ".a-1521dni{outline-style:groove;}"];
  [@css ".a-l7ia9n{outline-style:ridge;}"];
  [@css ".a-rtduzy{outline-style:inset;}"];
  [@css ".a-qe8noo{outline-style:outset;}"];
  [@css ".a-1uer6ge{outline-offset:-5px;}"];
  [@css ".a-1nkfqwb{outline-offset:0;}"];
  [@css ".a-165ch4u{outline-offset:5px;}"];
  [@css ".a-5d6l6w{resize:none;}"];
  [@css ".a-w8wl10{resize:both;}"];
  [@css ".a-1o40f2m{resize:horizontal;}"];
  [@css ".a-nwqaai{resize:vertical;}"];
  [@css ".a-bkj8c{text-overflow:clip;}"];
  [@css ".a-bmjq4j{text-overflow:ellipsis;}"];
  [@css ".a-1j8r2w0{cursor:default;}"];
  [@css ".a-bc6hmx{cursor:none;}"];
  [@css ".a-to4qqq{cursor:context-menu;}"];
  [@css ".a-17aaee9{cursor:cell;}"];
  [@css ".a-1vskbts{cursor:vertical-text;}"];
  [@css ".a-lelkeh{cursor:alias;}"];
  [@css ".a-1n3476y{cursor:copy;}"];
  [@css ".a-1cus137{cursor:no-drop;}"];
  [@css ".a-vdhlfv{cursor:not-allowed;}"];
  [@css ".a-ehba41{cursor:-webkit-grab;cursor:grab;}"];
  [@css ".a-m2aufq{cursor:-webkit-grabbing;cursor:grabbing;}"];
  [@css ".a-3hsboj{cursor:ew-resize;}"];
  [@css ".a-kqxfz0{cursor:ns-resize;}"];
  [@css ".a-13l8jep{cursor:nesw-resize;}"];
  [@css ".a-kxobzn{cursor:nwse-resize;}"];
  [@css ".a-fmjlp0{cursor:col-resize;}"];
  [@css ".a-12owrya{cursor:row-resize;}"];
  [@css ".a-16euxfn{cursor:all-scroll;}"];
  [@css ".a-vgd1sg{cursor:zoom-in;}"];
  [@css ".a-kmtb2g{cursor:zoom-out;}"];
  [@css ".a-1llpnps{caret-color:auto;}"];
  [@css ".a-1q51yyj{caret-color:green;}"];
  [@css
    ".a-1ndky4e{-webkit-appearance:auto;-moz-appearance:auto;-ms-appearance:auto;appearance:auto;}"
  ];
  [@css
    ".a-17grcf8{-webkit-appearance:none;-moz-appearance:none;-ms-appearance:none;appearance:none;}"
  ];
  [@css ".a-1ttooc5{text-overflow:\"foo\";}"];
  [@css ".a-1pwfzgv{text-overflow:clip clip;}"];
  [@css ".a-r61axg{text-overflow:ellipsis clip;}"];
  [@css ".a-2w1db5{text-overflow:\"foo\" clip;}"];
  [@css ".a-2b9k39{text-overflow:clip ellipsis;}"];
  [@css ".a-1m742kz{text-overflow:ellipsis ellipsis;}"];
  [@css ".a-85ad1k{text-overflow:\"foo\" ellipsis;}"];
  [@css ".a-n09ns{text-overflow:clip \"foo\";}"];
  [@css ".a-9zgl00{text-overflow:ellipsis \"foo\";}"];
  [@css ".a-l6jnzg{text-overflow:\"foo\" \"foo\";}"];
  [@css
    ".a-99p0oo{-webkit-user-select:auto;-moz-user-select:auto;-ms-user-select:auto;user-select:auto;}"
  ];
  [@css
    ".a-1mmoigx{-webkit-user-select:text;-moz-user-select:text;-ms-user-select:text;user-select:text;}"
  ];
  [@css
    ".a-9y6172{-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}"
  ];
  [@css
    ".a-1rsyfv1{-webkit-user-select:contain;-moz-user-select:contain;-ms-user-select:contain;user-select:contain;}"
  ];
  [@css
    ".a-1udvaqc{-webkit-user-select:all;-moz-user-select:all;-ms-user-select:all;user-select:all;}"
  ];
  
  CSS.make("a-roynbj", []);
  CSS.make("a-g393ep", []);
  CSS.make("a-19ks84b", []);
  CSS.make("a-vqdro3", []);
  CSS.make("a-xlynf6", []);
  CSS.make("a-1hmqa57", []);
  CSS.make("a-1709twl", []);
  CSS.make("a-1dqoq43", []);
  CSS.make("a-1521dni", []);
  CSS.make("a-l7ia9n", []);
  CSS.make("a-rtduzy", []);
  CSS.make("a-qe8noo", []);
  CSS.make("a-1uer6ge", []);
  CSS.make("a-1nkfqwb", []);
  CSS.make("a-165ch4u", []);
  CSS.make("a-5d6l6w", []);
  CSS.make("a-w8wl10", []);
  CSS.make("a-1o40f2m", []);
  CSS.make("a-nwqaai", []);
  CSS.make("a-bkj8c", []);
  CSS.make("a-bmjq4j", []);
  
  CSS.make("a-1j8r2w0", []);
  CSS.make("a-bc6hmx", []);
  CSS.make("a-to4qqq", []);
  CSS.make("a-17aaee9", []);
  CSS.make("a-1vskbts", []);
  CSS.make("a-lelkeh", []);
  CSS.make("a-1n3476y", []);
  CSS.make("a-1cus137", []);
  CSS.make("a-vdhlfv", []);
  CSS.make("a-ehba41", []);
  CSS.make("a-m2aufq", []);
  CSS.make("a-3hsboj", []);
  CSS.make("a-kqxfz0", []);
  CSS.make("a-13l8jep", []);
  CSS.make("a-kxobzn", []);
  CSS.make("a-fmjlp0", []);
  CSS.make("a-12owrya", []);
  CSS.make("a-16euxfn", []);
  CSS.make("a-vgd1sg", []);
  CSS.make("a-kmtb2g", []);
  CSS.make("a-1llpnps", []);
  CSS.make("a-1q51yyj", []);
  
  CSS.make("a-1ndky4e", []);
  CSS.make("a-17grcf8", []);
  
  CSS.make("a-bkj8c", []);
  CSS.make("a-bmjq4j", []);
  
  CSS.make("a-1ttooc5", []);
  CSS.make("a-1pwfzgv", []);
  CSS.make("a-r61axg", []);
  
  CSS.make("a-2w1db5", []);
  CSS.make("a-2b9k39", []);
  CSS.make("a-1m742kz", []);
  
  CSS.make("a-85ad1k", []);
  
  CSS.make("a-n09ns", []);
  CSS.make("a-9zgl00", []);
  
  CSS.make("a-l6jnzg", []);
  CSS.make("a-99p0oo", []);
  CSS.make("a-1mmoigx", []);
  CSS.make("a-9y6172", []);
  CSS.make("a-1rsyfv1", []);
  CSS.make("a-1udvaqc", []);

  $ dune build
