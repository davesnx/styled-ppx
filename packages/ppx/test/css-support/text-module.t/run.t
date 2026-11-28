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
  [@css ".css-ivpcy1s{text-transform:full-width;}"];
  [@css ".css-ivpcoyg{text-transform:full-size-kana;}"];
  [@css ".css-ivpcxcu{-moz-tab-size:4;-o-tab-size:4;tab-size:4;}"];
  [@css ".css-ivpc3j8{-moz-tab-size:1em;-o-tab-size:1em;tab-size:1em;}"];
  [@css ".css-ivpcvsq{line-break:auto;}"];
  [@css ".css-ivpc300{line-break:loose;}"];
  [@css ".css-ivpciii{line-break:normal;}"];
  [@css ".css-ivpcj7n{line-break:strict;}"];
  [@css ".css-ivpc7j8{line-break:anywhere;}"];
  [@css ".css-ivpchkb{word-break:normal;}"];
  [@css ".css-ivpcq01{word-break:keep-all;}"];
  [@css ".css-ivpcv2i{word-break:break-all;}"];
  [@css ".css-ivpcur4{white-space:break-spaces;}"];
  [@css
    ".css-ivpcye2{-webkit-hyphens:auto;-moz-hyphens:auto;-ms-hyphens:auto;hyphens:auto;}"
  ];
  [@css
    ".css-ivpcvdq{-webkit-hyphens:manual;-moz-hyphens:manual;-ms-hyphens:manual;hyphens:manual;}"
  ];
  [@css
    ".css-ivpcstn{-webkit-hyphens:none;-moz-hyphens:none;-ms-hyphens:none;hyphens:none;}"
  ];
  [@css ".css-ivpc2ot{overflow-wrap:normal;}"];
  [@css ".css-ivpcimk{overflow-wrap:break-word;}"];
  [@css ".css-ivpcydh{overflow-wrap:anywhere;}"];
  [@css ".css-ivpcasf{word-wrap:normal;}"];
  [@css ".css-ivpcxbw{word-wrap:break-word;}"];
  [@css ".css-ivpco0b{word-wrap:anywhere;}"];
  [@css ".css-ivpcznj{text-align:start;}"];
  [@css ".css-ivpcx48{text-align:end;}"];
  [@css ".css-ivpc1p5{text-align:left;}"];
  [@css ".css-ivpcye3{text-align:right;}"];
  [@css ".css-ivpczah{text-align:center;}"];
  [@css ".css-ivpchjf{text-align:justify;}"];
  [@css ".css-ivpcmhh{text-align:match-parent;}"];
  [@css ".css-ivpcxqz{text-align:justify-all;}"];
  [@css ".css-ivpcf7x{text-align-all:start;}"];
  [@css ".css-ivpcwxu{text-align-all:end;}"];
  [@css ".css-ivpc2r5{text-align-all:left;}"];
  [@css ".css-ivpcoyv{text-align-all:right;}"];
  [@css ".css-ivpctbr{text-align-all:center;}"];
  [@css ".css-ivpccvr{text-align-all:justify;}"];
  [@css ".css-ivpcoyt{text-align-all:match-parent;}"];
  [@css ".css-ivpcxce{text-align-last:auto;}"];
  [@css ".css-ivpcjrd{text-align-last:start;}"];
  [@css ".css-ivpc6ce{text-align-last:end;}"];
  [@css ".css-ivpc4gr{text-align-last:left;}"];
  [@css ".css-ivpc3hx{text-align-last:right;}"];
  [@css ".css-ivpcn0g{text-align-last:center;}"];
  [@css ".css-ivpc4iw{text-align-last:justify;}"];
  [@css ".css-ivpcu1i{text-align-last:match-parent;}"];
  [@css ".css-ivpcrw4{text-justify:auto;}"];
  [@css ".css-ivpclqu{text-justify:none;}"];
  [@css ".css-ivpcczn{text-justify:inter-word;}"];
  [@css ".css-ivpcdb4{text-justify:inter-character;}"];
  [@css ".css-ivpcm4x{word-spacing:50%;}"];
  [@css ".css-ivpcvpg{text-indent:1em hanging;}"];
  [@css ".css-ivpcux2{text-indent:1em each-line;}"];
  [@css ".css-ivpcwil{text-indent:1em hanging each-line;}"];
  [@css ".css-ivpccz2{hanging-punctuation:none;}"];
  [@css ".css-ivpcz9e{hanging-punctuation:first;}"];
  [@css ".css-ivpcg4b{hanging-punctuation:last;}"];
  [@css ".css-ivpckxo{hanging-punctuation:force-end;}"];
  [@css ".css-ivpcls2{hanging-punctuation:allow-end;}"];
  [@css ".css-ivpcei7{hanging-punctuation:first last;}"];
  [@css ".css-ivpcv5r{hanging-punctuation:first force-end;}"];
  [@css ".css-ivpca9b{hanging-punctuation:first force-end last;}"];
  [@css ".css-ivpcsud{hanging-punctuation:first allow-end last;}"];
  [@css ".css-ivpcv52{text-wrap:wrap;}"];
  [@css ".css-ivpc3gh{text-wrap:nowrap;}"];
  [@css ".css-ivpc7mt{text-wrap:balance;}"];
  [@css ".css-ivpcrbu{text-wrap:stable;}"];
  [@css ".css-ivpc3kr{text-wrap:pretty;}"];
  [@css ".css-ivpcrnz{text-wrap-mode:wrap;}"];
  [@css ".css-ivpcky8{text-wrap-mode:nowrap;}"];
  [@css ".css-ivpc7yh{text-wrap-style:auto;}"];
  [@css ".css-ivpcfdn{text-wrap-style:balance;}"];
  [@css ".css-ivpcku9{text-wrap-style:stable;}"];
  [@css ".css-ivpc809{text-wrap-style:pretty;}"];
  [@css ".css-ivpcutk{hyphenate-character:auto;}"];
  [@css ".css-ivpcbm9{hyphenate-limit-zone:1%;}"];
  [@css ".css-ivpc6n0{hyphenate-limit-zone:1em;}"];
  [@css ".css-ivpcddo{hyphenate-limit-chars:auto;}"];
  [@css ".css-ivpcmkr{hyphenate-limit-chars:5;}"];
  [@css ".css-ivpc7gf{hyphenate-limit-lines:no-limit;}"];
  [@css ".css-ivpcqy4{hyphenate-limit-lines:2;}"];
  [@css.classes
    [
      ("css-ivpcy1s", 0, "", "input.re", 2, 8, 2, 34),
      ("css-ivpcoyg", 1, "", "input.re", 3, 8, 3, 38),
      ("css-ivpcxcu", 2, "", "input.re", 6, 8, 6, 19),
      ("css-ivpc3j8", 3, "", "input.re", 7, 8, 7, 21),
      ("css-ivpcvsq", 4, "", "input.re", 8, 8, 8, 24),
      ("css-ivpc300", 5, "", "input.re", 9, 8, 9, 25),
      ("css-ivpciii", 6, "", "input.re", 10, 8, 10, 26),
      ("css-ivpcj7n", 7, "", "input.re", 11, 8, 11, 26),
      ("css-ivpc7j8", 8, "", "input.re", 12, 8, 12, 28),
      ("css-ivpchkb", 9, "", "input.re", 13, 8, 13, 26),
      ("css-ivpcq01", 10, "", "input.re", 14, 8, 14, 28),
      ("css-ivpcv2i", 11, "", "input.re", 15, 8, 15, 29),
      ("css-ivpcur4", 12, "", "input.re", 16, 8, 16, 33),
      ("css-ivpcye2", 13, "", "input.re", 17, 8, 17, 21),
      ("css-ivpcvdq", 14, "", "input.re", 18, 8, 18, 23),
      ("css-ivpcstn", 15, "", "input.re", 19, 8, 19, 21),
      ("css-ivpc2ot", 16, "", "input.re", 20, 8, 20, 29),
      ("css-ivpcimk", 17, "", "input.re", 21, 8, 21, 33),
      ("css-ivpcydh", 18, "", "input.re", 22, 8, 22, 31),
      ("css-ivpcasf", 19, "", "input.re", 23, 8, 23, 25),
      ("css-ivpcxbw", 20, "", "input.re", 24, 8, 24, 29),
      ("css-ivpco0b", 21, "", "input.re", 25, 8, 25, 27),
      ("css-ivpcznj", 22, "", "input.re", 26, 8, 26, 25),
      ("css-ivpcx48", 23, "", "input.re", 27, 8, 27, 23),
      ("css-ivpc1p5", 24, "", "input.re", 28, 8, 28, 24),
      ("css-ivpcye3", 25, "", "input.re", 29, 8, 29, 25),
      ("css-ivpczah", 26, "", "input.re", 30, 8, 30, 26),
      ("css-ivpchjf", 27, "", "input.re", 31, 8, 31, 27),
      ("css-ivpcmhh", 28, "", "input.re", 32, 8, 32, 32),
      ("css-ivpcxqz", 29, "", "input.re", 33, 8, 33, 31),
      ("css-ivpcf7x", 30, "", "input.re", 34, 8, 34, 29),
      ("css-ivpcwxu", 31, "", "input.re", 35, 8, 35, 27),
      ("css-ivpc2r5", 32, "", "input.re", 36, 8, 36, 28),
      ("css-ivpcoyv", 33, "", "input.re", 37, 8, 37, 29),
      ("css-ivpctbr", 34, "", "input.re", 38, 8, 38, 30),
      ("css-ivpccvr", 35, "", "input.re", 39, 8, 39, 31),
      ("css-ivpcoyt", 36, "", "input.re", 40, 8, 40, 36),
      ("css-ivpcxce", 37, "", "input.re", 41, 8, 41, 29),
      ("css-ivpcjrd", 38, "", "input.re", 42, 8, 42, 30),
      ("css-ivpc6ce", 39, "", "input.re", 43, 8, 43, 28),
      ("css-ivpc4gr", 40, "", "input.re", 44, 8, 44, 29),
      ("css-ivpc3hx", 41, "", "input.re", 45, 8, 45, 30),
      ("css-ivpcn0g", 42, "", "input.re", 46, 8, 46, 31),
      ("css-ivpc4iw", 43, "", "input.re", 47, 8, 47, 32),
      ("css-ivpcu1i", 44, "", "input.re", 48, 8, 48, 37),
      ("css-ivpcrw4", 45, "", "input.re", 49, 8, 49, 26),
      ("css-ivpclqu", 46, "", "input.re", 50, 8, 50, 26),
      ("css-ivpcczn", 47, "", "input.re", 51, 8, 51, 32),
      ("css-ivpcdb4", 48, "", "input.re", 52, 8, 52, 37),
      ("css-ivpcm4x", 49, "", "input.re", 53, 8, 53, 25),
      ("css-ivpcvpg", 50, "", "input.re", 54, 8, 54, 32),
      ("css-ivpcux2", 51, "", "input.re", 55, 8, 55, 34),
      ("css-ivpcwil", 52, "", "input.re", 56, 8, 56, 42),
      ("css-ivpccz2", 53, "", "input.re", 57, 8, 57, 33),
      ("css-ivpcz9e", 54, "", "input.re", 58, 8, 58, 34),
      ("css-ivpcg4b", 55, "", "input.re", 59, 8, 59, 33),
      ("css-ivpckxo", 56, "", "input.re", 60, 8, 60, 38),
      ("css-ivpcls2", 57, "", "input.re", 61, 8, 61, 38),
      ("css-ivpcei7", 58, "", "input.re", 62, 8, 62, 39),
      ("css-ivpcv5r", 59, "", "input.re", 63, 8, 63, 44),
      ("css-ivpca9b", 60, "", "input.re", 64, 8, 64, 49),
      ("css-ivpcsud", 61, "", "input.re", 65, 8, 65, 49),
      ("css-ivpcv52", 62, "", "input.re", 79, 8, 79, 23),
      ("css-ivpc3gh", 63, "", "input.re", 80, 8, 80, 25),
      ("css-ivpc7mt", 64, "", "input.re", 81, 8, 81, 26),
      ("css-ivpcrbu", 65, "", "input.re", 82, 8, 82, 25),
      ("css-ivpc3kr", 66, "", "input.re", 83, 8, 83, 25),
      ("css-ivpcrnz", 67, "", "input.re", 84, 8, 84, 28),
      ("css-ivpcky8", 68, "", "input.re", 85, 8, 85, 30),
      ("css-ivpc7yh", 69, "", "input.re", 86, 8, 86, 29),
      ("css-ivpcfdn", 70, "", "input.re", 87, 8, 87, 32),
      ("css-ivpcku9", 71, "", "input.re", 88, 8, 88, 31),
      ("css-ivpc809", 72, "", "input.re", 89, 8, 89, 31),
      ("css-ivpcutk", 73, "", "input.re", 104, 8, 104, 33),
      ("css-ivpcbm9", 74, "", "input.re", 105, 8, 105, 32),
      ("css-ivpc6n0", 75, "", "input.re", 106, 8, 106, 33),
      ("css-ivpcddo", 76, "", "input.re", 107, 8, 107, 35),
      ("css-ivpcmkr", 77, "", "input.re", 108, 8, 108, 32),
      ("css-ivpc7gf", 78, "", "input.re", 111, 8, 111, 39),
      ("css-ivpcqy4", 79, "", "input.re", 112, 8, 112, 32),
    ]
  ];
  
  CSS.make("css-ivpcy1s", []);
  CSS.make("css-ivpcoyg", []);
  
  CSS.make("css-ivpcxcu", []);
  CSS.make("css-ivpc3j8", []);
  CSS.make("css-ivpcvsq", []);
  CSS.make("css-ivpc300", []);
  CSS.make("css-ivpciii", []);
  CSS.make("css-ivpcj7n", []);
  CSS.make("css-ivpc7j8", []);
  CSS.make("css-ivpchkb", []);
  CSS.make("css-ivpcq01", []);
  CSS.make("css-ivpcv2i", []);
  CSS.make("css-ivpcur4", []);
  CSS.make("css-ivpcye2", []);
  CSS.make("css-ivpcvdq", []);
  CSS.make("css-ivpcstn", []);
  CSS.make("css-ivpc2ot", []);
  CSS.make("css-ivpcimk", []);
  CSS.make("css-ivpcydh", []);
  CSS.make("css-ivpcasf", []);
  CSS.make("css-ivpcxbw", []);
  CSS.make("css-ivpco0b", []);
  CSS.make("css-ivpcznj", []);
  CSS.make("css-ivpcx48", []);
  CSS.make("css-ivpc1p5", []);
  CSS.make("css-ivpcye3", []);
  CSS.make("css-ivpczah", []);
  CSS.make("css-ivpchjf", []);
  CSS.make("css-ivpcmhh", []);
  CSS.make("css-ivpcxqz", []);
  CSS.make("css-ivpcf7x", []);
  CSS.make("css-ivpcwxu", []);
  CSS.make("css-ivpc2r5", []);
  CSS.make("css-ivpcoyv", []);
  CSS.make("css-ivpctbr", []);
  CSS.make("css-ivpccvr", []);
  CSS.make("css-ivpcoyt", []);
  CSS.make("css-ivpcxce", []);
  CSS.make("css-ivpcjrd", []);
  CSS.make("css-ivpc6ce", []);
  CSS.make("css-ivpc4gr", []);
  CSS.make("css-ivpc3hx", []);
  CSS.make("css-ivpcn0g", []);
  CSS.make("css-ivpc4iw", []);
  CSS.make("css-ivpcu1i", []);
  CSS.make("css-ivpcrw4", []);
  CSS.make("css-ivpclqu", []);
  CSS.make("css-ivpcczn", []);
  CSS.make("css-ivpcdb4", []);
  CSS.make("css-ivpcm4x", []);
  CSS.make("css-ivpcvpg", []);
  CSS.make("css-ivpcux2", []);
  CSS.make("css-ivpcwil", []);
  CSS.make("css-ivpccz2", []);
  CSS.make("css-ivpcz9e", []);
  CSS.make("css-ivpcg4b", []);
  CSS.make("css-ivpckxo", []);
  CSS.make("css-ivpcls2", []);
  CSS.make("css-ivpcei7", []);
  CSS.make("css-ivpcv5r", []);
  CSS.make("css-ivpca9b", []);
  CSS.make("css-ivpcsud", []);
  
  CSS.make("css-ivpcv52", []);
  CSS.make("css-ivpc3gh", []);
  CSS.make("css-ivpc7mt", []);
  CSS.make("css-ivpcrbu", []);
  CSS.make("css-ivpc3kr", []);
  CSS.make("css-ivpcrnz", []);
  CSS.make("css-ivpcky8", []);
  CSS.make("css-ivpc7yh", []);
  CSS.make("css-ivpcfdn", []);
  CSS.make("css-ivpcku9", []);
  CSS.make("css-ivpc809", []);
  
  CSS.make("css-ivpcutk", []);
  CSS.make("css-ivpcbm9", []);
  CSS.make("css-ivpc6n0", []);
  CSS.make("css-ivpcddo", []);
  CSS.make("css-ivpcmkr", []);
  
  CSS.make("css-ivpc7gf", []);
  CSS.make("css-ivpcqy4", []);
