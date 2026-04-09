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
  [@css ".css-roynbj{box-sizing:border-box;}"];
  [@css ".css-g393ep{box-sizing:content-box;}"];
  [@css ".css-19ks84b{outline-style:auto;}"];
  [@css ".css-vqdro3{outline-style:none;}"];
  [@css ".css-xlynf6{outline-style:dotted;}"];
  [@css ".css-1hmqa57{outline-style:dashed;}"];
  [@css ".css-1709twl{outline-style:solid;}"];
  [@css ".css-1dqoq43{outline-style:double;}"];
  [@css ".css-1521dni{outline-style:groove;}"];
  [@css ".css-l7ia9n{outline-style:ridge;}"];
  [@css ".css-rtduzy{outline-style:inset;}"];
  [@css ".css-qe8noo{outline-style:outset;}"];
  [@css ".css-1uer6ge{outline-offset:-5px;}"];
  [@css ".css-1nkfqwb{outline-offset:0;}"];
  [@css ".css-165ch4u{outline-offset:5px;}"];
  [@css ".css-5d6l6w{resize:none;}"];
  [@css ".css-w8wl10{resize:both;}"];
  [@css ".css-1o40f2m{resize:horizontal;}"];
  [@css ".css-nwqaai{resize:vertical;}"];
  [@css ".css-bkj8c{text-overflow:clip;}"];
  [@css ".css-bmjq4j{text-overflow:ellipsis;}"];
  [@css ".css-1j8r2w0{cursor:default;}"];
  [@css ".css-bc6hmx{cursor:none;}"];
  [@css ".css-to4qqq{cursor:context-menu;}"];
  [@css ".css-17aaee9{cursor:cell;}"];
  [@css ".css-1vskbts{cursor:vertical-text;}"];
  [@css ".css-lelkeh{cursor:alias;}"];
  [@css ".css-1n3476y{cursor:copy;}"];
  [@css ".css-1cus137{cursor:no-drop;}"];
  [@css ".css-vdhlfv{cursor:not-allowed;}"];
  [@css ".css-ehba41{cursor:grab;}"];
  [@css ".css-m2aufq{cursor:grabbing;}"];
  [@css ".css-3hsboj{cursor:ew-resize;}"];
  [@css ".css-kqxfz0{cursor:ns-resize;}"];
  [@css ".css-13l8jep{cursor:nesw-resize;}"];
  [@css ".css-kxobzn{cursor:nwse-resize;}"];
  [@css ".css-fmjlp0{cursor:col-resize;}"];
  [@css ".css-12owrya{cursor:row-resize;}"];
  [@css ".css-16euxfn{cursor:all-scroll;}"];
  [@css ".css-vgd1sg{cursor:zoom-in;}"];
  [@css ".css-kmtb2g{cursor:zoom-out;}"];
  [@css ".css-1llpnps{caret-color:auto;}"];
  [@css ".css-1q51yyj{caret-color:green;}"];
  [@css ".css-1ndky4e{appearance:auto;}"];
  [@css ".css-17grcf8{appearance:none;}"];
  [@css ".css-1ttooc5{text-overflow:\"foo\";}"];
  [@css ".css-1pwfzgv{text-overflow:clip clip;}"];
  [@css ".css-r61axg{text-overflow:ellipsis clip;}"];
  [@css ".css-2w1db5{text-overflow:\"foo\" clip;}"];
  [@css ".css-2b9k39{text-overflow:clip ellipsis;}"];
  [@css ".css-1m742kz{text-overflow:ellipsis ellipsis;}"];
  [@css ".css-85ad1k{text-overflow:\"foo\" ellipsis;}"];
  [@css ".css-n09ns{text-overflow:clip \"foo\";}"];
  [@css ".css-9zgl00{text-overflow:ellipsis \"foo\";}"];
  [@css ".css-l6jnzg{text-overflow:\"foo\" \"foo\";}"];
  [@css ".css-99p0oo{user-select:auto;}"];
  [@css ".css-1mmoigx{user-select:text;}"];
  [@css ".css-9y6172{user-select:none;}"];
  [@css ".css-1rsyfv1{user-select:contain;}"];
  [@css ".css-1udvaqc{user-select:all;}"];
  
  CSS.make("css-roynbj", []);
  CSS.make("css-g393ep", []);
  CSS.make("css-19ks84b", []);
  CSS.make("css-vqdro3", []);
  CSS.make("css-xlynf6", []);
  CSS.make("css-1hmqa57", []);
  CSS.make("css-1709twl", []);
  CSS.make("css-1dqoq43", []);
  CSS.make("css-1521dni", []);
  CSS.make("css-l7ia9n", []);
  CSS.make("css-rtduzy", []);
  CSS.make("css-qe8noo", []);
  CSS.make("css-1uer6ge", []);
  CSS.make("css-1nkfqwb", []);
  CSS.make("css-165ch4u", []);
  CSS.make("css-5d6l6w", []);
  CSS.make("css-w8wl10", []);
  CSS.make("css-1o40f2m", []);
  CSS.make("css-nwqaai", []);
  CSS.make("css-bkj8c", []);
  CSS.make("css-bmjq4j", []);
  
  CSS.make("css-1j8r2w0", []);
  CSS.make("css-bc6hmx", []);
  CSS.make("css-to4qqq", []);
  CSS.make("css-17aaee9", []);
  CSS.make("css-1vskbts", []);
  CSS.make("css-lelkeh", []);
  CSS.make("css-1n3476y", []);
  CSS.make("css-1cus137", []);
  CSS.make("css-vdhlfv", []);
  CSS.make("css-ehba41", []);
  CSS.make("css-m2aufq", []);
  CSS.make("css-3hsboj", []);
  CSS.make("css-kqxfz0", []);
  CSS.make("css-13l8jep", []);
  CSS.make("css-kxobzn", []);
  CSS.make("css-fmjlp0", []);
  CSS.make("css-12owrya", []);
  CSS.make("css-16euxfn", []);
  CSS.make("css-vgd1sg", []);
  CSS.make("css-kmtb2g", []);
  CSS.make("css-1llpnps", []);
  CSS.make("css-1q51yyj", []);
  
  CSS.make("css-1ndky4e", []);
  CSS.make("css-17grcf8", []);
  
  CSS.make("css-bkj8c", []);
  CSS.make("css-bmjq4j", []);
  
  CSS.make("css-1ttooc5", []);
  CSS.make("css-1pwfzgv", []);
  CSS.make("css-r61axg", []);
  
  CSS.make("css-2w1db5", []);
  CSS.make("css-2b9k39", []);
  CSS.make("css-1m742kz", []);
  
  CSS.make("css-85ad1k", []);
  
  CSS.make("css-n09ns", []);
  CSS.make("css-9zgl00", []);
  
  CSS.make("css-l6jnzg", []);
  CSS.make("css-99p0oo", []);
  CSS.make("css-1mmoigx", []);
  CSS.make("css-9y6172", []);
  CSS.make("css-1rsyfv1", []);
  CSS.make("css-1udvaqc", []);

  $ dune build
