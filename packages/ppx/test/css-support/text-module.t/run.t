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
  [@css ".css-b7oy1s{text-transform:full-width;}"];
  [@css ".css-1uz8oyg{text-transform:full-size-kana;}"];
  [@css ".css-1mikxcu{-moz-tab-size:4;-o-tab-size:4;tab-size:4;}"];
  [@css ".css-1d803j8{-moz-tab-size:1em;-o-tab-size:1em;tab-size:1em;}"];
  [@css ".css-bk0vsq{line-break:auto;}"];
  [@css ".css-gzh300{line-break:loose;}"];
  [@css ".css-1iasiii{line-break:normal;}"];
  [@css ".css-4mnj7n{line-break:strict;}"];
  [@css ".css-1lxz7j8{line-break:anywhere;}"];
  [@css ".css-30rhkb{word-break:normal;}"];
  [@css ".css-gbfq01{word-break:keep-all;}"];
  [@css ".css-d10v2i{word-break:break-all;}"];
  [@css ".css-1wqaur4{white-space:break-spaces;}"];
  [@css
    ".css-p9pye2{-webkit-hyphens:auto;-moz-hyphens:auto;-ms-hyphens:auto;hyphens:auto;}"
  ];
  [@css
    ".css-1vxpvdq{-webkit-hyphens:manual;-moz-hyphens:manual;-ms-hyphens:manual;hyphens:manual;}"
  ];
  [@css
    ".css-wqqstn{-webkit-hyphens:none;-moz-hyphens:none;-ms-hyphens:none;hyphens:none;}"
  ];
  [@css ".css-15zk2ot{overflow-wrap:normal;}"];
  [@css ".css-1bxfimk{overflow-wrap:break-word;}"];
  [@css ".css-1r9jydh{overflow-wrap:anywhere;}"];
  [@css ".css-rcdasf{word-wrap:normal;}"];
  [@css ".css-jrwxbw{word-wrap:break-word;}"];
  [@css ".css-10fyo0b{word-wrap:anywhere;}"];
  [@css ".css-kzzznj{text-align:start;}"];
  [@css ".css-qosx48{text-align:end;}"];
  [@css ".css-1r5w1p5{text-align:left;}"];
  [@css ".css-z2oye3{text-align:right;}"];
  [@css ".css-1eoszah{text-align:center;}"];
  [@css ".css-1gp1hjf{text-align:justify;}"];
  [@css ".css-b62mhh{text-align:match-parent;}"];
  [@css ".css-mxoxqz{text-align:justify-all;}"];
  [@css ".css-i6vf7x{text-align-all:start;}"];
  [@css ".css-6tlwxu{text-align-all:end;}"];
  [@css ".css-kvf2r5{text-align-all:left;}"];
  [@css ".css-1hvtoyv{text-align-all:right;}"];
  [@css ".css-xp5tbr{text-align-all:center;}"];
  [@css ".css-15ljcvr{text-align-all:justify;}"];
  [@css ".css-4zeoyt{text-align-all:match-parent;}"];
  [@css ".css-4qzxce{text-align-last:auto;}"];
  [@css ".css-1mvejrd{text-align-last:start;}"];
  [@css ".css-1vqo6ce{text-align-last:end;}"];
  [@css ".css-kxi4gr{text-align-last:left;}"];
  [@css ".css-1e7x3hx{text-align-last:right;}"];
  [@css ".css-kwun0g{text-align-last:center;}"];
  [@css ".css-1n394iw{text-align-last:justify;}"];
  [@css ".css-wx0u1i{text-align-last:match-parent;}"];
  [@css ".css-12z2rw4{text-justify:auto;}"];
  [@css ".css-exrlqu{text-justify:none;}"];
  [@css ".css-1h1mczn{text-justify:inter-word;}"];
  [@css ".css-1yhfdb4{text-justify:inter-character;}"];
  [@css ".css-1oqsm4x{word-spacing:50%;}"];
  [@css ".css-10ssvpg{text-indent:1em hanging;}"];
  [@css ".css-ta5ux2{text-indent:1em each-line;}"];
  [@css ".css-1fkxwil{text-indent:1em hanging each-line;}"];
  [@css ".css-fybcz2{hanging-punctuation:none;}"];
  [@css ".css-fm3z9e{hanging-punctuation:first;}"];
  [@css ".css-1nq1g4b{hanging-punctuation:last;}"];
  [@css ".css-9mzkxo{hanging-punctuation:force-end;}"];
  [@css ".css-lu0ls2{hanging-punctuation:allow-end;}"];
  [@css ".css-3wqei7{hanging-punctuation:first last;}"];
  [@css ".css-15cev5r{hanging-punctuation:first force-end;}"];
  [@css ".css-mx3a9b{hanging-punctuation:first force-end last;}"];
  [@css ".css-aiusud{hanging-punctuation:first allow-end last;}"];
  [@css ".css-250v52{text-wrap:wrap;}"];
  [@css ".css-13qz3gh{text-wrap:nowrap;}"];
  [@css ".css-1wfs7mt{text-wrap:balance;}"];
  [@css ".css-1l1prbu{text-wrap:stable;}"];
  [@css ".css-1yjd3kr{text-wrap:pretty;}"];
  [@css ".css-1e8mrnz{text-wrap-mode:wrap;}"];
  [@css ".css-1lpjky8{text-wrap-mode:nowrap;}"];
  [@css ".css-1v3h7yh{text-wrap-style:auto;}"];
  [@css ".css-15u4fdn{text-wrap-style:balance;}"];
  [@css ".css-1bzsku9{text-wrap-style:stable;}"];
  [@css ".css-fpj809{text-wrap-style:pretty;}"];
  [@css ".css-c15utk{hyphenate-character:auto;}"];
  [@css ".css-1ek3bm9{hyphenate-limit-zone:1%;}"];
  [@css ".css-13o56n0{hyphenate-limit-zone:1em;}"];
  [@css ".css-1axhddo{hyphenate-limit-chars:auto;}"];
  [@css ".css-sqfmkr{hyphenate-limit-chars:5;}"];
  [@css ".css-15a87gf{hyphenate-limit-lines:no-limit;}"];
  [@css ".css-18riqy4{hyphenate-limit-lines:2;}"];
  [@css.classes
    [
      ("css-b7oy1s", 0, "", "input.re", 2, 8, 2, 34),
      ("css-1uz8oyg", 1, "", "input.re", 3, 8, 3, 38),
      ("css-1mikxcu", 2, "", "input.re", 6, 8, 6, 19),
      ("css-1d803j8", 3, "", "input.re", 7, 8, 7, 21),
      ("css-bk0vsq", 4, "", "input.re", 8, 8, 8, 24),
      ("css-gzh300", 5, "", "input.re", 9, 8, 9, 25),
      ("css-1iasiii", 6, "", "input.re", 10, 8, 10, 26),
      ("css-4mnj7n", 7, "", "input.re", 11, 8, 11, 26),
      ("css-1lxz7j8", 8, "", "input.re", 12, 8, 12, 28),
      ("css-30rhkb", 9, "", "input.re", 13, 8, 13, 26),
      ("css-gbfq01", 10, "", "input.re", 14, 8, 14, 28),
      ("css-d10v2i", 11, "", "input.re", 15, 8, 15, 29),
      ("css-1wqaur4", 12, "", "input.re", 16, 8, 16, 33),
      ("css-p9pye2", 13, "", "input.re", 17, 8, 17, 21),
      ("css-1vxpvdq", 14, "", "input.re", 18, 8, 18, 23),
      ("css-wqqstn", 15, "", "input.re", 19, 8, 19, 21),
      ("css-15zk2ot", 16, "", "input.re", 20, 8, 20, 29),
      ("css-1bxfimk", 17, "", "input.re", 21, 8, 21, 33),
      ("css-1r9jydh", 18, "", "input.re", 22, 8, 22, 31),
      ("css-rcdasf", 19, "", "input.re", 23, 8, 23, 25),
      ("css-jrwxbw", 20, "", "input.re", 24, 8, 24, 29),
      ("css-10fyo0b", 21, "", "input.re", 25, 8, 25, 27),
      ("css-kzzznj", 22, "", "input.re", 26, 8, 26, 25),
      ("css-qosx48", 23, "", "input.re", 27, 8, 27, 23),
      ("css-1r5w1p5", 24, "", "input.re", 28, 8, 28, 24),
      ("css-z2oye3", 25, "", "input.re", 29, 8, 29, 25),
      ("css-1eoszah", 26, "", "input.re", 30, 8, 30, 26),
      ("css-1gp1hjf", 27, "", "input.re", 31, 8, 31, 27),
      ("css-b62mhh", 28, "", "input.re", 32, 8, 32, 32),
      ("css-mxoxqz", 29, "", "input.re", 33, 8, 33, 31),
      ("css-i6vf7x", 30, "", "input.re", 34, 8, 34, 29),
      ("css-6tlwxu", 31, "", "input.re", 35, 8, 35, 27),
      ("css-kvf2r5", 32, "", "input.re", 36, 8, 36, 28),
      ("css-1hvtoyv", 33, "", "input.re", 37, 8, 37, 29),
      ("css-xp5tbr", 34, "", "input.re", 38, 8, 38, 30),
      ("css-15ljcvr", 35, "", "input.re", 39, 8, 39, 31),
      ("css-4zeoyt", 36, "", "input.re", 40, 8, 40, 36),
      ("css-4qzxce", 37, "", "input.re", 41, 8, 41, 29),
      ("css-1mvejrd", 38, "", "input.re", 42, 8, 42, 30),
      ("css-1vqo6ce", 39, "", "input.re", 43, 8, 43, 28),
      ("css-kxi4gr", 40, "", "input.re", 44, 8, 44, 29),
      ("css-1e7x3hx", 41, "", "input.re", 45, 8, 45, 30),
      ("css-kwun0g", 42, "", "input.re", 46, 8, 46, 31),
      ("css-1n394iw", 43, "", "input.re", 47, 8, 47, 32),
      ("css-wx0u1i", 44, "", "input.re", 48, 8, 48, 37),
      ("css-12z2rw4", 45, "", "input.re", 49, 8, 49, 26),
      ("css-exrlqu", 46, "", "input.re", 50, 8, 50, 26),
      ("css-1h1mczn", 47, "", "input.re", 51, 8, 51, 32),
      ("css-1yhfdb4", 48, "", "input.re", 52, 8, 52, 37),
      ("css-1oqsm4x", 49, "", "input.re", 53, 8, 53, 25),
      ("css-10ssvpg", 50, "", "input.re", 54, 8, 54, 32),
      ("css-ta5ux2", 51, "", "input.re", 55, 8, 55, 34),
      ("css-1fkxwil", 52, "", "input.re", 56, 8, 56, 42),
      ("css-fybcz2", 53, "", "input.re", 57, 8, 57, 33),
      ("css-fm3z9e", 54, "", "input.re", 58, 8, 58, 34),
      ("css-1nq1g4b", 55, "", "input.re", 59, 8, 59, 33),
      ("css-9mzkxo", 56, "", "input.re", 60, 8, 60, 38),
      ("css-lu0ls2", 57, "", "input.re", 61, 8, 61, 38),
      ("css-3wqei7", 58, "", "input.re", 62, 8, 62, 39),
      ("css-15cev5r", 59, "", "input.re", 63, 8, 63, 44),
      ("css-mx3a9b", 60, "", "input.re", 64, 8, 64, 49),
      ("css-aiusud", 61, "", "input.re", 65, 8, 65, 49),
      ("css-250v52", 62, "", "input.re", 79, 8, 79, 23),
      ("css-13qz3gh", 63, "", "input.re", 80, 8, 80, 25),
      ("css-1wfs7mt", 64, "", "input.re", 81, 8, 81, 26),
      ("css-1l1prbu", 65, "", "input.re", 82, 8, 82, 25),
      ("css-1yjd3kr", 66, "", "input.re", 83, 8, 83, 25),
      ("css-1e8mrnz", 67, "", "input.re", 84, 8, 84, 28),
      ("css-1lpjky8", 68, "", "input.re", 85, 8, 85, 30),
      ("css-1v3h7yh", 69, "", "input.re", 86, 8, 86, 29),
      ("css-15u4fdn", 70, "", "input.re", 87, 8, 87, 32),
      ("css-1bzsku9", 71, "", "input.re", 88, 8, 88, 31),
      ("css-fpj809", 72, "", "input.re", 89, 8, 89, 31),
      ("css-c15utk", 73, "", "input.re", 104, 8, 104, 33),
      ("css-1ek3bm9", 74, "", "input.re", 105, 8, 105, 32),
      ("css-13o56n0", 75, "", "input.re", 106, 8, 106, 33),
      ("css-1axhddo", 76, "", "input.re", 107, 8, 107, 35),
      ("css-sqfmkr", 77, "", "input.re", 108, 8, 108, 32),
      ("css-15a87gf", 78, "", "input.re", 111, 8, 111, 39),
      ("css-18riqy4", 79, "", "input.re", 112, 8, 112, 32),
    ]
  ];
  
  CSS.make("css-b7oy1s", []);
  CSS.make("css-1uz8oyg", []);
  
  CSS.make("css-1mikxcu", []);
  CSS.make("css-1d803j8", []);
  CSS.make("css-bk0vsq", []);
  CSS.make("css-gzh300", []);
  CSS.make("css-1iasiii", []);
  CSS.make("css-4mnj7n", []);
  CSS.make("css-1lxz7j8", []);
  CSS.make("css-30rhkb", []);
  CSS.make("css-gbfq01", []);
  CSS.make("css-d10v2i", []);
  CSS.make("css-1wqaur4", []);
  CSS.make("css-p9pye2", []);
  CSS.make("css-1vxpvdq", []);
  CSS.make("css-wqqstn", []);
  CSS.make("css-15zk2ot", []);
  CSS.make("css-1bxfimk", []);
  CSS.make("css-1r9jydh", []);
  CSS.make("css-rcdasf", []);
  CSS.make("css-jrwxbw", []);
  CSS.make("css-10fyo0b", []);
  CSS.make("css-kzzznj", []);
  CSS.make("css-qosx48", []);
  CSS.make("css-1r5w1p5", []);
  CSS.make("css-z2oye3", []);
  CSS.make("css-1eoszah", []);
  CSS.make("css-1gp1hjf", []);
  CSS.make("css-b62mhh", []);
  CSS.make("css-mxoxqz", []);
  CSS.make("css-i6vf7x", []);
  CSS.make("css-6tlwxu", []);
  CSS.make("css-kvf2r5", []);
  CSS.make("css-1hvtoyv", []);
  CSS.make("css-xp5tbr", []);
  CSS.make("css-15ljcvr", []);
  CSS.make("css-4zeoyt", []);
  CSS.make("css-4qzxce", []);
  CSS.make("css-1mvejrd", []);
  CSS.make("css-1vqo6ce", []);
  CSS.make("css-kxi4gr", []);
  CSS.make("css-1e7x3hx", []);
  CSS.make("css-kwun0g", []);
  CSS.make("css-1n394iw", []);
  CSS.make("css-wx0u1i", []);
  CSS.make("css-12z2rw4", []);
  CSS.make("css-exrlqu", []);
  CSS.make("css-1h1mczn", []);
  CSS.make("css-1yhfdb4", []);
  CSS.make("css-1oqsm4x", []);
  CSS.make("css-10ssvpg", []);
  CSS.make("css-ta5ux2", []);
  CSS.make("css-1fkxwil", []);
  CSS.make("css-fybcz2", []);
  CSS.make("css-fm3z9e", []);
  CSS.make("css-1nq1g4b", []);
  CSS.make("css-9mzkxo", []);
  CSS.make("css-lu0ls2", []);
  CSS.make("css-3wqei7", []);
  CSS.make("css-15cev5r", []);
  CSS.make("css-mx3a9b", []);
  CSS.make("css-aiusud", []);
  
  CSS.make("css-250v52", []);
  CSS.make("css-13qz3gh", []);
  CSS.make("css-1wfs7mt", []);
  CSS.make("css-1l1prbu", []);
  CSS.make("css-1yjd3kr", []);
  CSS.make("css-1e8mrnz", []);
  CSS.make("css-1lpjky8", []);
  CSS.make("css-1v3h7yh", []);
  CSS.make("css-15u4fdn", []);
  CSS.make("css-1bzsku9", []);
  CSS.make("css-fpj809", []);
  
  CSS.make("css-c15utk", []);
  CSS.make("css-1ek3bm9", []);
  CSS.make("css-13o56n0", []);
  CSS.make("css-1axhddo", []);
  CSS.make("css-sqfmkr", []);
  
  CSS.make("css-15a87gf", []);
  CSS.make("css-18riqy4", []);
