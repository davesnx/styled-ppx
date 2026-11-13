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
  [@css ".css-jtvua3{line-clamp:none;}"];
  [@css ".css-oh33d9{line-clamp:1;}"];
  [@css ".css-yh9esp{max-lines:none;}"];
  [@css ".css-1mqb88m{max-lines:1;}"];
  [@css ".css-rv44qp{overflow-x:visible;}"];
  [@css ".css-1qcwnv3{overflow-x:hidden;}"];
  [@css ".css-1rlagl2{overflow-x:clip;}"];
  [@css ".css-yfqybg{overflow-x:scroll;}"];
  [@css ".css-wo0glo{overflow-x:auto;}"];
  [@css ".css-1d460ov{overflow-y:visible;}"];
  [@css ".css-lmnjef{overflow-y:hidden;}"];
  [@css ".css-1revijk{overflow-y:clip;}"];
  [@css ".css-q1ydgp{overflow-y:scroll;}"];
  [@css ".css-v5vfbq{overflow-y:auto;}"];
  [@css ".css-1h8h4fe{overflow-inline:visible;}"];
  [@css ".css-ayye0t{overflow-inline:hidden;}"];
  [@css ".css-1menfyp{overflow-inline:clip;}"];
  [@css ".css-zirhxu{overflow-inline:scroll;}"];
  [@css ".css-k7eian{overflow-inline:auto;}"];
  [@css ".css-1ttqd2n{overflow-block:visible;}"];
  [@css ".css-1a5za4x{overflow-block:hidden;}"];
  [@css ".css-1rjo03u{overflow-block:clip;}"];
  [@css ".css-10tuqhx{overflow-block:scroll;}"];
  [@css ".css-i45kq6{overflow-block:auto;}"];
  [@css ".css-1uobwl1{scrollbar-gutter:auto;}"];
  [@css ".css-ytbkp{scrollbar-gutter:stable;}"];
  [@css ".css-1vbzd1x{scrollbar-gutter:both-edges stable;}"];
  [@css ".css-ldysqn{scrollbar-gutter:stable both-edges;}"];
  [@css ".css-1cx18v2{overflow-clip-margin:content-box;}"];
  [@css ".css-1i87i9o{overflow-clip-margin:padding-box;}"];
  [@css ".css-1bqz4xd{overflow-clip-margin:border-box;}"];
  [@css ".css-s9ap5h{overflow-clip-margin:20px;}"];
  [@css ".css-onh1zv{overflow-clip-margin:1em;}"];
  [@css ".css-156ojmv{overflow-clip-margin:content-box 5px;}"];
  [@css ".css-1yzjmub{overflow-clip-margin:5px content-box;}"];
  [@css.classes
    [
      ("css-jtvua3", 0, "", "input.re", 2, 8, 2, 24),
      ("css-oh33d9", 1, "", "input.re", 3, 8, 3, 21),
      ("css-yh9esp", 2, "", "input.re", 6, 8, 6, 23),
      ("css-1mqb88m", 3, "", "input.re", 7, 8, 7, 20),
      ("css-rv44qp", 4, "", "input.re", 8, 8, 8, 27),
      ("css-1qcwnv3", 5, "", "input.re", 9, 8, 9, 26),
      ("css-1rlagl2", 6, "", "input.re", 10, 8, 10, 24),
      ("css-yfqybg", 7, "", "input.re", 11, 8, 11, 26),
      ("css-wo0glo", 8, "", "input.re", 12, 8, 12, 24),
      ("css-1d460ov", 9, "", "input.re", 13, 8, 13, 27),
      ("css-lmnjef", 10, "", "input.re", 14, 8, 14, 26),
      ("css-1revijk", 11, "", "input.re", 15, 8, 15, 24),
      ("css-q1ydgp", 12, "", "input.re", 16, 8, 16, 26),
      ("css-v5vfbq", 13, "", "input.re", 17, 8, 17, 24),
      ("css-1h8h4fe", 14, "", "input.re", 18, 8, 18, 32),
      ("css-ayye0t", 15, "", "input.re", 19, 8, 19, 31),
      ("css-1menfyp", 16, "", "input.re", 20, 8, 20, 29),
      ("css-zirhxu", 17, "", "input.re", 21, 8, 21, 31),
      ("css-k7eian", 18, "", "input.re", 22, 8, 22, 29),
      ("css-1ttqd2n", 19, "", "input.re", 23, 8, 23, 31),
      ("css-1a5za4x", 20, "", "input.re", 24, 8, 24, 30),
      ("css-1rjo03u", 21, "", "input.re", 25, 8, 25, 28),
      ("css-10tuqhx", 22, "", "input.re", 26, 8, 26, 30),
      ("css-i45kq6", 23, "", "input.re", 27, 8, 27, 28),
      ("css-1uobwl1", 24, "", "input.re", 28, 8, 28, 30),
      ("css-ytbkp", 25, "", "input.re", 29, 8, 29, 32),
      ("css-1vbzd1x", 26, "", "input.re", 30, 8, 30, 43),
      ("css-ldysqn", 27, "", "input.re", 31, 8, 31, 43),
      ("css-1cx18v2", 28, "", "input.re", 32, 8, 32, 41),
      ("css-1i87i9o", 29, "", "input.re", 33, 8, 33, 41),
      ("css-1bqz4xd", 30, "", "input.re", 34, 8, 34, 40),
      ("css-s9ap5h", 31, "", "input.re", 35, 8, 35, 34),
      ("css-onh1zv", 32, "", "input.re", 36, 8, 36, 33),
      ("css-156ojmv", 33, "", "input.re", 37, 8, 37, 45),
      ("css-1yzjmub", 34, "", "input.re", 38, 8, 38, 45),
    ]
  ];
  
  CSS.make("css-jtvua3", []);
  CSS.make("css-oh33d9", []);
  
  CSS.make("css-yh9esp", []);
  CSS.make("css-1mqb88m", []);
  CSS.make("css-rv44qp", []);
  CSS.make("css-1qcwnv3", []);
  CSS.make("css-1rlagl2", []);
  CSS.make("css-yfqybg", []);
  CSS.make("css-wo0glo", []);
  CSS.make("css-1d460ov", []);
  CSS.make("css-lmnjef", []);
  CSS.make("css-1revijk", []);
  CSS.make("css-q1ydgp", []);
  CSS.make("css-v5vfbq", []);
  CSS.make("css-1h8h4fe", []);
  CSS.make("css-ayye0t", []);
  CSS.make("css-1menfyp", []);
  CSS.make("css-zirhxu", []);
  CSS.make("css-k7eian", []);
  CSS.make("css-1ttqd2n", []);
  CSS.make("css-1a5za4x", []);
  CSS.make("css-1rjo03u", []);
  CSS.make("css-10tuqhx", []);
  CSS.make("css-i45kq6", []);
  CSS.make("css-1uobwl1", []);
  CSS.make("css-ytbkp", []);
  CSS.make("css-1vbzd1x", []);
  CSS.make("css-ldysqn", []);
  CSS.make("css-1cx18v2", []);
  CSS.make("css-1i87i9o", []);
  CSS.make("css-1bqz4xd", []);
  CSS.make("css-s9ap5h", []);
  CSS.make("css-onh1zv", []);
  CSS.make("css-156ojmv", []);
  CSS.make("css-1yzjmub", []);
