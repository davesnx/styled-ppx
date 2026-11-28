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
    ".css-ivpc3wd{-webkit-transform:none;-moz-transform:none;-ms-transform:none;transform:none;}"
  ];
  [@css
    ".css-ivpcdzs{-webkit-transform:translate(5px);-moz-transform:translate(5px);-ms-transform:translate(5px);transform:translate(5px);}"
  ];
  [@css
    ".css-ivpct0a{-webkit-transform:translate(5px, 10px);-moz-transform:translate(5px, 10px);-ms-transform:translate(5px, 10px);transform:translate(5px, 10px);}"
  ];
  [@css
    ".css-ivpci02{-webkit-transform:translateY(5px);-moz-transform:translateY(5px);-ms-transform:translateY(5px);transform:translateY(5px);}"
  ];
  [@css
    ".css-ivpcasx{-webkit-transform:translateX(5px);-moz-transform:translateX(5px);-ms-transform:translateX(5px);transform:translateX(5px);}"
  ];
  [@css
    ".css-ivpcorm{-webkit-transform:translateY(5%);-moz-transform:translateY(5%);-ms-transform:translateY(5%);transform:translateY(5%);}"
  ];
  [@css
    ".css-ivpcuq3{-webkit-transform:translateX(5%);-moz-transform:translateX(5%);-ms-transform:translateX(5%);transform:translateX(5%);}"
  ];
  [@css
    ".css-ivpc5dy{-webkit-transform:scale(2);-moz-transform:scale(2);-ms-transform:scale(2);transform:scale(2);}"
  ];
  [@css
    ".css-ivpceo2{-webkit-transform:scale(2, -1);-moz-transform:scale(2, -1);-ms-transform:scale(2, -1);transform:scale(2, -1);}"
  ];
  [@css
    ".css-ivpcwqh{-webkit-transform:scaleX(2);-moz-transform:scaleX(2);-ms-transform:scaleX(2);transform:scaleX(2);}"
  ];
  [@css
    ".css-ivpclwa{-webkit-transform:scaleY(2.5);-moz-transform:scaleY(2.5);-ms-transform:scaleY(2.5);transform:scaleY(2.5);}"
  ];
  [@css
    ".css-ivpcom3{-webkit-transform:rotate(45deg);-moz-transform:rotate(45deg);-ms-transform:rotate(45deg);transform:rotate(45deg);}"
  ];
  [@css
    ".css-ivpcdwo{-webkit-transform:skew(45deg);-moz-transform:skew(45deg);-ms-transform:skew(45deg);transform:skew(45deg);}"
  ];
  [@css
    ".css-ivpc7fi{-webkit-transform:skew(45deg, 15deg);-moz-transform:skew(45deg, 15deg);-ms-transform:skew(45deg, 15deg);transform:skew(45deg, 15deg);}"
  ];
  [@css
    ".css-ivpcrr6{-webkit-transform:skewX(45deg);-moz-transform:skewX(45deg);-ms-transform:skewX(45deg);transform:skewX(45deg);}"
  ];
  [@css
    ".css-ivpc944{-webkit-transform:skewY(45deg);-moz-transform:skewY(45deg);-ms-transform:skewY(45deg);transform:skewY(45deg);}"
  ];
  [@css
    ".css-ivpcbbd{-webkit-transform:translate(50px, -24px) skew(0, 22.5deg);-moz-transform:translate(50px, -24px) skew(0, 22.5deg);-ms-transform:translate(50px, -24px) skew(0, 22.5deg);transform:translate(50px, -24px) skew(0, 22.5deg);}"
  ];
  [@css
    ".css-ivpcz41{-webkit-transform:translate3d(0, 0, 5px);-moz-transform:translate3d(0, 0, 5px);-ms-transform:translate3d(0, 0, 5px);transform:translate3d(0, 0, 5px);}"
  ];
  [@css
    ".css-ivpcz07{-webkit-transform:translateZ(5px);-moz-transform:translateZ(5px);-ms-transform:translateZ(5px);transform:translateZ(5px);}"
  ];
  [@css
    ".css-ivpcq4t{-webkit-transform:scale3d(1, 0, -1);-moz-transform:scale3d(1, 0, -1);-ms-transform:scale3d(1, 0, -1);transform:scale3d(1, 0, -1);}"
  ];
  [@css
    ".css-ivpcpix{-webkit-transform:scaleZ(1.5);-moz-transform:scaleZ(1.5);-ms-transform:scaleZ(1.5);transform:scaleZ(1.5);}"
  ];
  [@css
    ".css-ivpcroj{-webkit-transform:rotate3d(1, 1, 1, 45deg);-moz-transform:rotate3d(1, 1, 1, 45deg);-ms-transform:rotate3d(1, 1, 1, 45deg);transform:rotate3d(1, 1, 1, 45deg);}"
  ];
  [@css
    ".css-ivpc27b{-webkit-transform:rotateX(-45deg);-moz-transform:rotateX(-45deg);-ms-transform:rotateX(-45deg);transform:rotateX(-45deg);}"
  ];
  [@css
    ".css-ivpc6f2{-webkit-transform:rotateY(-45deg);-moz-transform:rotateY(-45deg);-ms-transform:rotateY(-45deg);transform:rotateY(-45deg);}"
  ];
  [@css
    ".css-ivpc6ir{-webkit-transform:rotateZ(-45deg);-moz-transform:rotateZ(-45deg);-ms-transform:rotateZ(-45deg);transform:rotateZ(-45deg);}"
  ];
  [@css
    ".css-ivpc8ya{-webkit-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);-moz-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);-ms-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);}"
  ];
  [@css
    ".css-ivpcc2m{-webkit-transform:perspective(600px);-moz-transform:perspective(600px);-ms-transform:perspective(600px);transform:perspective(600px);}"
  ];
  [@css ".css-ivpc6ve{transform-origin:10px;}"];
  [@css ".css-ivpctwc{transform-origin:top;}"];
  [@css ".css-ivpc2ks{transform-origin:top left;}"];
  [@css ".css-ivpc362{transform-origin:50% 100%;}"];
  [@css ".css-ivpc4bt{transform-origin:left 0%;}"];
  [@css ".css-ivpcpn5{transform-origin:left 50% 0;}"];
  [@css ".css-ivpc710{transform-box:border-box;}"];
  [@css ".css-ivpc0z3{transform-box:fill-box;}"];
  [@css ".css-ivpcpqy{transform-box:view-box;}"];
  [@css ".css-ivpcyhg{transform-box:content-box;}"];
  [@css ".css-ivpc29g{transform-box:stroke-box;}"];
  [@css ".css-ivpcltj{translate:none;}"];
  [@css ".css-ivpc3ob{translate:50%;}"];
  [@css ".css-ivpcyc7{translate:50% 50%;}"];
  [@css ".css-ivpcgt7{translate:50% 50% 10px;}"];
  [@css ".css-ivpcx6y{scale:none;}"];
  [@css ".css-ivpcc47{scale:2;}"];
  [@css ".css-ivpc4k8{scale:2 2;}"];
  [@css ".css-ivpcozh{scale:2 2 2;}"];
  [@css ".css-ivpcdc6{rotate:none;}"];
  [@css ".css-ivpcikx{rotate:45deg;}"];
  [@css ".css-ivpcomo{rotate:x 45deg;}"];
  [@css ".css-ivpcosx{rotate:y 45deg;}"];
  [@css ".css-ivpclvn{rotate:z 45deg;}"];
  [@css ".css-ivpc4f3{rotate:-1 0 2 45deg;}"];
  [@css ".css-ivpc42i{rotate:45deg x;}"];
  [@css ".css-ivpc4tr{rotate:45deg y;}"];
  [@css ".css-ivpc8vs{rotate:45deg z;}"];
  [@css ".css-ivpc80b{rotate:45deg -1 0 2;}"];
  [@css ".css-ivpc0q3{transform-style:flat;}"];
  [@css ".css-ivpcf30{transform-style:preserve-3d;}"];
  [@css ".css-ivpcox9{perspective:none;}"];
  [@css ".css-ivpcls7{perspective:600px;}"];
  [@css ".css-ivpcduu{perspective-origin:10px;}"];
  [@css ".css-ivpcp1a{perspective-origin:top;}"];
  [@css ".css-ivpcef0{perspective-origin:top left;}"];
  [@css ".css-ivpc48c{perspective-origin:50% 100%;}"];
  [@css ".css-ivpcgb2{perspective-origin:left 0%;}"];
  [@css
    ".css-ivpcxn2{-webkit-backface-visibility:visible;backface-visibility:visible;}"
  ];
  [@css
    ".css-ivpcvli{-webkit-backface-visibility:hidden;backface-visibility:hidden;}"
  ];
  [@css.classes
    [
      ("css-ivpc3wd", 0, "", "input.re", 2, 8, 2, 23),
      ("css-ivpcdzs", 1, "", "input.re", 3, 8, 3, 33),
      ("css-ivpct0a", 2, "", "input.re", 4, 8, 4, 39),
      ("css-ivpci02", 3, "", "input.re", 5, 8, 5, 34),
      ("css-ivpcasx", 4, "", "input.re", 6, 8, 6, 34),
      ("css-ivpcorm", 5, "", "input.re", 7, 8, 7, 33),
      ("css-ivpcuq3", 6, "", "input.re", 8, 8, 8, 33),
      ("css-ivpc5dy", 7, "", "input.re", 9, 8, 9, 27),
      ("css-ivpceo2", 8, "", "input.re", 10, 8, 10, 31),
      ("css-ivpcwqh", 9, "", "input.re", 11, 8, 11, 28),
      ("css-ivpclwa", 10, "", "input.re", 12, 8, 12, 30),
      ("css-ivpcom3", 11, "", "input.re", 13, 8, 13, 32),
      ("css-ivpcdwo", 12, "", "input.re", 14, 8, 14, 30),
      ("css-ivpc7fi", 13, "", "input.re", 15, 8, 15, 37),
      ("css-ivpcrr6", 14, "", "input.re", 16, 8, 16, 31),
      ("css-ivpc944", 15, "", "input.re", 17, 8, 17, 31),
      ("css-ivpcbbd", 16, "", "input.re", 20, 8, 20, 58),
      ("css-ivpcz41", 17, "", "input.re", 21, 8, 21, 41),
      ("css-ivpcz07", 18, "", "input.re", 22, 8, 22, 34),
      ("css-ivpcq4t", 19, "", "input.re", 23, 8, 23, 36),
      ("css-ivpcpix", 20, "", "input.re", 24, 8, 24, 30),
      ("css-ivpcroj", 21, "", "input.re", 25, 8, 25, 43),
      ("css-ivpc27b", 22, "", "input.re", 26, 8, 26, 34),
      ("css-ivpc6f2", 23, "", "input.re", 27, 8, 27, 34),
      ("css-ivpc6ir", 24, "", "input.re", 28, 8, 28, 34),
      ("css-ivpc8ya", 25, "", "input.re", 32, 4, 32, 89),
      ("css-ivpcc2m", 26, "", "input.re", 34, 8, 34, 37),
      ("css-ivpc6ve", 27, "", "input.re", 35, 8, 35, 30),
      ("css-ivpctwc", 28, "", "input.re", 36, 8, 36, 29),
      ("css-ivpc2ks", 29, "", "input.re", 37, 8, 37, 34),
      ("css-ivpc362", 30, "", "input.re", 38, 8, 38, 34),
      ("css-ivpc4bt", 31, "", "input.re", 39, 8, 39, 33),
      ("css-ivpcpn5", 32, "", "input.re", 40, 8, 40, 36),
      ("css-ivpc710", 33, "", "input.re", 41, 8, 41, 33),
      ("css-ivpc0z3", 34, "", "input.re", 42, 8, 42, 31),
      ("css-ivpcpqy", 35, "", "input.re", 43, 8, 43, 31),
      ("css-ivpcyhg", 36, "", "input.re", 44, 8, 44, 34),
      ("css-ivpc29g", 37, "", "input.re", 45, 8, 45, 33),
      ("css-ivpcltj", 38, "", "input.re", 48, 8, 48, 23),
      ("css-ivpc3ob", 39, "", "input.re", 49, 8, 49, 22),
      ("css-ivpcyc7", 40, "", "input.re", 50, 8, 50, 26),
      ("css-ivpcgt7", 41, "", "input.re", 51, 8, 51, 31),
      ("css-ivpcx6y", 42, "", "input.re", 52, 8, 52, 19),
      ("css-ivpcc47", 43, "", "input.re", 53, 8, 53, 16),
      ("css-ivpc4k8", 44, "", "input.re", 54, 8, 54, 18),
      ("css-ivpcozh", 45, "", "input.re", 55, 8, 55, 20),
      ("css-ivpcdc6", 46, "", "input.re", 56, 8, 56, 20),
      ("css-ivpcikx", 47, "", "input.re", 57, 8, 57, 22),
      ("css-ivpcomo", 48, "", "input.re", 58, 8, 58, 23),
      ("css-ivpcosx", 49, "", "input.re", 59, 8, 59, 23),
      ("css-ivpclvn", 50, "", "input.re", 60, 8, 60, 23),
      ("css-ivpc4f3", 51, "", "input.re", 61, 8, 61, 28),
      ("css-ivpc42i", 52, "", "input.re", 62, 8, 62, 23),
      ("css-ivpc4tr", 53, "", "input.re", 63, 8, 63, 23),
      ("css-ivpc8vs", 54, "", "input.re", 64, 8, 64, 23),
      ("css-ivpc80b", 55, "", "input.re", 65, 8, 65, 28),
      ("css-ivpc0q3", 56, "", "input.re", 66, 8, 66, 29),
      ("css-ivpcf30", 57, "", "input.re", 67, 8, 67, 36),
      ("css-ivpcox9", 58, "", "input.re", 68, 8, 68, 25),
      ("css-ivpcls7", 59, "", "input.re", 69, 8, 69, 26),
      ("css-ivpcduu", 60, "", "input.re", 70, 8, 70, 32),
      ("css-ivpcp1a", 61, "", "input.re", 71, 8, 71, 31),
      ("css-ivpcef0", 62, "", "input.re", 72, 8, 72, 36),
      ("css-ivpc48c", 63, "", "input.re", 73, 8, 73, 36),
      ("css-ivpcgb2", 64, "", "input.re", 74, 8, 74, 35),
      ("css-ivpcxn2", 65, "", "input.re", 75, 8, 75, 36),
      ("css-ivpcvli", 66, "", "input.re", 76, 8, 76, 35),
    ]
  ];
  
  CSS.make("css-ivpc3wd", []);
  CSS.make("css-ivpcdzs", []);
  CSS.make("css-ivpct0a", []);
  CSS.make("css-ivpci02", []);
  CSS.make("css-ivpcasx", []);
  CSS.make("css-ivpcorm", []);
  CSS.make("css-ivpcuq3", []);
  CSS.make("css-ivpc5dy", []);
  CSS.make("css-ivpceo2", []);
  CSS.make("css-ivpcwqh", []);
  CSS.make("css-ivpclwa", []);
  CSS.make("css-ivpcom3", []);
  CSS.make("css-ivpcdwo", []);
  CSS.make("css-ivpc7fi", []);
  CSS.make("css-ivpcrr6", []);
  CSS.make("css-ivpc944", []);
  
  CSS.make("css-ivpcbbd", []);
  CSS.make("css-ivpcz41", []);
  CSS.make("css-ivpcz07", []);
  CSS.make("css-ivpcq4t", []);
  CSS.make("css-ivpcpix", []);
  CSS.make("css-ivpcroj", []);
  CSS.make("css-ivpc27b", []);
  CSS.make("css-ivpc6f2", []);
  CSS.make("css-ivpc6ir", []);
  
  CSS.make("css-ivpc8ya", []);
  CSS.make("css-ivpcc2m", []);
  CSS.make("css-ivpc6ve", []);
  CSS.make("css-ivpctwc", []);
  CSS.make("css-ivpc2ks", []);
  CSS.make("css-ivpc362", []);
  CSS.make("css-ivpc4bt", []);
  CSS.make("css-ivpcpn5", []);
  CSS.make("css-ivpc710", []);
  CSS.make("css-ivpc0z3", []);
  CSS.make("css-ivpcpqy", []);
  CSS.make("css-ivpcyhg", []);
  CSS.make("css-ivpc29g", []);
  
  CSS.make("css-ivpcltj", []);
  CSS.make("css-ivpc3ob", []);
  CSS.make("css-ivpcyc7", []);
  CSS.make("css-ivpcgt7", []);
  CSS.make("css-ivpcx6y", []);
  CSS.make("css-ivpcc47", []);
  CSS.make("css-ivpc4k8", []);
  CSS.make("css-ivpcozh", []);
  CSS.make("css-ivpcdc6", []);
  CSS.make("css-ivpcikx", []);
  CSS.make("css-ivpcomo", []);
  CSS.make("css-ivpcosx", []);
  CSS.make("css-ivpclvn", []);
  CSS.make("css-ivpc4f3", []);
  CSS.make("css-ivpc42i", []);
  CSS.make("css-ivpc4tr", []);
  CSS.make("css-ivpc8vs", []);
  CSS.make("css-ivpc80b", []);
  CSS.make("css-ivpc0q3", []);
  CSS.make("css-ivpcf30", []);
  CSS.make("css-ivpcox9", []);
  CSS.make("css-ivpcls7", []);
  CSS.make("css-ivpcduu", []);
  CSS.make("css-ivpcp1a", []);
  CSS.make("css-ivpcef0", []);
  CSS.make("css-ivpc48c", []);
  CSS.make("css-ivpcgb2", []);
  CSS.make("css-ivpcxn2", []);
  CSS.make("css-ivpcvli", []);
