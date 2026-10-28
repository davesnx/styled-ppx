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
      "._a_diuucg{-webkit-transform:none;-moz-transform:none;-ms-transform:none;transform:none;}",
      "_a_diuucg",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dilsr6{-webkit-transform:translate(5px);-moz-transform:translate(5px);-ms-transform:translate(5px);transform:translate(5px);}",
      "_a_dilsr6",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dihdak{-webkit-transform:translate(5px, 10px);-moz-transform:translate(5px, 10px);-ms-transform:translate(5px, 10px);transform:translate(5px, 10px);}",
      "_a_dihdak",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_difbzo{-webkit-transform:translateY(5px);-moz-transform:translateY(5px);-ms-transform:translateY(5px);transform:translateY(5px);}",
      "_a_difbzo",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_digj3z{-webkit-transform:translateX(5px);-moz-transform:translateX(5px);-ms-transform:translateX(5px);transform:translateX(5px);}",
      "_a_digj3z",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_di6llm{-webkit-transform:translateY(5%);-moz-transform:translateY(5%);-ms-transform:translateY(5%);transform:translateY(5%);}",
      "_a_di6llm",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dibqi7{-webkit-transform:translateX(5%);-moz-transform:translateX(5%);-ms-transform:translateX(5%);transform:translateX(5%);}",
      "_a_dibqi7",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dimep6{-webkit-transform:scale(2);-moz-transform:scale(2);-ms-transform:scale(2);transform:scale(2);}",
      "_a_dimep6",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_diihuo{-webkit-transform:scale(2, -1);-moz-transform:scale(2, -1);-ms-transform:scale(2, -1);transform:scale(2, -1);}",
      "_a_diihuo",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_di7wl3{-webkit-transform:scaleX(2);-moz-transform:scaleX(2);-ms-transform:scaleX(2);transform:scaleX(2);}",
      "_a_di7wl3",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_diwczw{-webkit-transform:scaleY(2.5);-moz-transform:scaleY(2.5);-ms-transform:scaleY(2.5);transform:scaleY(2.5);}",
      "_a_diwczw",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_divhbk{-webkit-transform:rotate(45deg);-moz-transform:rotate(45deg);-ms-transform:rotate(45deg);transform:rotate(45deg);}",
      "_a_divhbk",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dio84h{-webkit-transform:skew(45deg);-moz-transform:skew(45deg);-ms-transform:skew(45deg);transform:skew(45deg);}",
      "_a_dio84h",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dibtt1{-webkit-transform:skew(45deg, 15deg);-moz-transform:skew(45deg, 15deg);-ms-transform:skew(45deg, 15deg);transform:skew(45deg, 15deg);}",
      "_a_dibtt1",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_digqd2{-webkit-transform:skewX(45deg);-moz-transform:skewX(45deg);-ms-transform:skewX(45deg);transform:skewX(45deg);}",
      "_a_digqd2",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dirlxt{-webkit-transform:skewY(45deg);-moz-transform:skewY(45deg);-ms-transform:skewY(45deg);transform:skewY(45deg);}",
      "_a_dirlxt",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dizqc7{-webkit-transform:translate(50px, -24px) skew(0, 22.5deg);-moz-transform:translate(50px, -24px) skew(0, 22.5deg);-ms-transform:translate(50px, -24px) skew(0, 22.5deg);transform:translate(50px, -24px) skew(0, 22.5deg);}",
      "_a_dizqc7",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_div2u5{-webkit-transform:translate3d(0, 0, 5px);-moz-transform:translate3d(0, 0, 5px);-ms-transform:translate3d(0, 0, 5px);transform:translate3d(0, 0, 5px);}",
      "_a_div2u5",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_didcmy{-webkit-transform:translateZ(5px);-moz-transform:translateZ(5px);-ms-transform:translateZ(5px);transform:translateZ(5px);}",
      "_a_didcmy",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_di4av4{-webkit-transform:scale3d(1, 0, -1);-moz-transform:scale3d(1, 0, -1);-ms-transform:scale3d(1, 0, -1);transform:scale3d(1, 0, -1);}",
      "_a_di4av4",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dieyuw{-webkit-transform:scaleZ(1.5);-moz-transform:scaleZ(1.5);-ms-transform:scaleZ(1.5);transform:scaleZ(1.5);}",
      "_a_dieyuw",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dimph4{-webkit-transform:rotate3d(1, 1, 1, 45deg);-moz-transform:rotate3d(1, 1, 1, 45deg);-ms-transform:rotate3d(1, 1, 1, 45deg);transform:rotate3d(1, 1, 1, 45deg);}",
      "_a_dimph4",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_di4lr2{-webkit-transform:rotateX(-45deg);-moz-transform:rotateX(-45deg);-ms-transform:rotateX(-45deg);transform:rotateX(-45deg);}",
      "_a_di4lr2",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_distga{-webkit-transform:rotateY(-45deg);-moz-transform:rotateY(-45deg);-ms-transform:rotateY(-45deg);transform:rotateY(-45deg);}",
      "_a_distga",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_di78v3{-webkit-transform:rotateZ(-45deg);-moz-transform:rotateZ(-45deg);-ms-transform:rotateZ(-45deg);transform:rotateZ(-45deg);}",
      "_a_di78v3",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_di7g01{-webkit-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);-moz-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);-ms-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);}",
      "_a_di7g01",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_di1n2j{-webkit-transform:perspective(600px);-moz-transform:perspective(600px);-ms-transform:perspective(600px);transform:perspective(600px);}",
      "_a_di1n2j",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dkz1s7{transform-origin:10px;}",
      "_a_dkz1s7",
      "0,1,0 own",
      "488",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dkz8dm{transform-origin:top;}",
      "_a_dkz8dm",
      "0,1,0 own",
      "488",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dkenzb{transform-origin:top left;}",
      "_a_dkenzb",
      "0,1,0 own",
      "488",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dkpis9{transform-origin:50% 100%;}",
      "_a_dkpis9",
      "0,1,0 own",
      "488",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dk0na3{transform-origin:left 0%;}",
      "_a_dk0na3",
      "0,1,0 own",
      "488",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dkcb2r{transform-origin:left 50% 0;}",
      "_a_dkcb2r",
      "0,1,0 own",
      "488",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dj3lnu{transform-box:border-box;}",
      "_a_dj3lnu",
      "0,1,0 own",
      "487",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_djd6y7{transform-box:fill-box;}",
      "_a_djd6y7",
      "0,1,0 own",
      "487",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_djoond{transform-box:view-box;}",
      "_a_djoond",
      "0,1,0 own",
      "487",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_djjedl{transform-box:content-box;}",
      "_a_djjedl",
      "0,1,0 own",
      "487",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_djocfm{transform-box:stroke-box;}",
      "_a_djocfm",
      "0,1,0 own",
      "487",
      1,
      false,
    )
  ];
  [@css
    ("._a_dna84j{translate:none;}", "_a_dna84j", "0,1,0 own", "491", 1, false)
  ];
  [@css
    ("._a_dnjzei{translate:50%;}", "_a_dnjzei", "0,1,0 own", "491", 1, false)
  ];
  [@css
    (
      "._a_dnhr71{translate:50% 50%;}",
      "_a_dnhr71",
      "0,1,0 own",
      "491",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dnaizz{translate:50% 50% 10px;}",
      "_a_dnaizz",
      "0,1,0 own",
      "491",
      1,
      false,
    )
  ];
  [@css ("._a_a912yp{scale:none;}", "_a_a912yp", "0,1,0 own", "369", 1, false)];
  [@css ("._a_a9kjw9{scale:2;}", "_a_a9kjw9", "0,1,0 own", "369", 1, false)];
  [@css ("._a_a99brl{scale:2 2;}", "_a_a99brl", "0,1,0 own", "369", 1, false)];
  [@css
    ("._a_a9etf0{scale:2 2 2;}", "_a_a9etf0", "0,1,0 own", "369", 1, false)
  ];
  [@css
    ("._a_a2r8a8{rotate:none;}", "_a_a2r8a8", "0,1,0 own", "362", 1, false)
  ];
  [@css
    ("._a_a22vtg{rotate:45deg;}", "_a_a22vtg", "0,1,0 own", "362", 1, false)
  ];
  [@css
    ("._a_a26584{rotate:x 45deg;}", "_a_a26584", "0,1,0 own", "362", 1, false)
  ];
  [@css
    ("._a_a2scq1{rotate:y 45deg;}", "_a_a2scq1", "0,1,0 own", "362", 1, false)
  ];
  [@css
    ("._a_a2s2ae{rotate:z 45deg;}", "_a_a2s2ae", "0,1,0 own", "362", 1, false)
  ];
  [@css
    (
      "._a_a2zkti{rotate:-1 0 2 45deg;}",
      "_a_a2zkti",
      "0,1,0 own",
      "362",
      1,
      false,
    )
  ];
  [@css
    ("._a_a20z7z{rotate:45deg x;}", "_a_a20z7z", "0,1,0 own", "362", 1, false)
  ];
  [@css
    ("._a_a2h22e{rotate:45deg y;}", "_a_a2h22e", "0,1,0 own", "362", 1, false)
  ];
  [@css
    ("._a_a2c7zu{rotate:45deg z;}", "_a_a2c7zu", "0,1,0 own", "362", 1, false)
  ];
  [@css
    (
      "._a_a2at92{rotate:45deg -1 0 2;}",
      "_a_a2at92",
      "0,1,0 own",
      "362",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dlmzai{transform-style:flat;}",
      "_a_dlmzai",
      "0,1,0 own",
      "489",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dldrg4{transform-style:preserve-3d;}",
      "_a_dldrg4",
      "0,1,0 own",
      "489",
      1,
      false,
    )
  ];
  [@css
    ("._a_9fxu8o{perspective:none;}", "_a_9fxu8o", "0,1,0 own", "339", 1, false)
  ];
  [@css
    (
      "._a_9fuytb{perspective:600px;}",
      "_a_9fuytb",
      "0,1,0 own",
      "339",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9gvvta{perspective-origin:10px;}",
      "_a_9gvvta",
      "0,1,0 own",
      "340",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9g37vq{perspective-origin:top;}",
      "_a_9g37vq",
      "0,1,0 own",
      "340",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9gl0kj{perspective-origin:top left;}",
      "_a_9gl0kj",
      "0,1,0 own",
      "340",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9g0ds0{perspective-origin:50% 100%;}",
      "_a_9g0ds0",
      "0,1,0 own",
      "340",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9gkl0e{perspective-origin:left 0%;}",
      "_a_9gkl0e",
      "0,1,0 own",
      "340",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_38dtzq{-webkit-backface-visibility:visible;backface-visibility:visible;}",
      "_a_38dtzq",
      "0,1,0 own",
      "116",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_38gmgm{-webkit-backface-visibility:hidden;backface-visibility:hidden;}",
      "_a_38gmgm",
      "0,1,0 own",
      "116",
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
      (20, "", [16]),
      (21, "", [17]),
      (22, "", [18]),
      (23, "", [19]),
      (24, "", [20]),
      (25, "", [21]),
      (26, "", [22]),
      (27, "", [23]),
      (28, "", [24]),
      (32, "", [25]),
      (34, "", [26]),
      (35, "", [27]),
      (36, "", [28]),
      (37, "", [29]),
      (38, "", [30]),
      (39, "", [31]),
      (40, "", [32]),
      (41, "", [33]),
      (42, "", [34]),
      (43, "", [35]),
      (44, "", [36]),
      (45, "", [37]),
      (48, "", [38]),
      (49, "", [39]),
      (50, "", [40]),
      (51, "", [41]),
      (52, "", [42]),
      (53, "", [43]),
      (54, "", [44]),
      (55, "", [45]),
      (56, "", [46]),
      (57, "", [47]),
      (58, "", [48]),
      (59, "", [49]),
      (60, "", [50]),
      (61, "", [51]),
      (62, "", [52]),
      (63, "", [53]),
      (64, "", [54]),
      (65, "", [55]),
      (66, "", [56]),
      (67, "", [57]),
      (68, "", [58]),
      (69, "", [59]),
      (70, "", [60]),
      (71, "", [61]),
      (72, "", [62]),
      (73, "", [63]),
      (74, "", [64]),
      (75, "", [65]),
      (76, "", [66]),
    ]
  ];
  
  CSS.make("_a_diuucg", []);
  CSS.make("_a_dilsr6", []);
  CSS.make("_a_dihdak", []);
  CSS.make("_a_difbzo", []);
  CSS.make("_a_digj3z", []);
  CSS.make("_a_di6llm", []);
  CSS.make("_a_dibqi7", []);
  CSS.make("_a_dimep6", []);
  CSS.make("_a_diihuo", []);
  CSS.make("_a_di7wl3", []);
  CSS.make("_a_diwczw", []);
  CSS.make("_a_divhbk", []);
  CSS.make("_a_dio84h", []);
  CSS.make("_a_dibtt1", []);
  CSS.make("_a_digqd2", []);
  CSS.make("_a_dirlxt", []);
  
  CSS.make("_a_dizqc7", []);
  CSS.make("_a_div2u5", []);
  CSS.make("_a_didcmy", []);
  CSS.make("_a_di4av4", []);
  CSS.make("_a_dieyuw", []);
  CSS.make("_a_dimph4", []);
  CSS.make("_a_di4lr2", []);
  CSS.make("_a_distga", []);
  CSS.make("_a_di78v3", []);
  
  CSS.make("_a_di7g01", []);
  CSS.make("_a_di1n2j", []);
  CSS.make("_a_dkz1s7", []);
  CSS.make("_a_dkz8dm", []);
  CSS.make("_a_dkenzb", []);
  CSS.make("_a_dkpis9", []);
  CSS.make("_a_dk0na3", []);
  CSS.make("_a_dkcb2r", []);
  CSS.make("_a_dj3lnu", []);
  CSS.make("_a_djd6y7", []);
  CSS.make("_a_djoond", []);
  CSS.make("_a_djjedl", []);
  CSS.make("_a_djocfm", []);
  
  CSS.make("_a_dna84j", []);
  CSS.make("_a_dnjzei", []);
  CSS.make("_a_dnhr71", []);
  CSS.make("_a_dnaizz", []);
  CSS.make("_a_a912yp", []);
  CSS.make("_a_a9kjw9", []);
  CSS.make("_a_a99brl", []);
  CSS.make("_a_a9etf0", []);
  CSS.make("_a_a2r8a8", []);
  CSS.make("_a_a22vtg", []);
  CSS.make("_a_a26584", []);
  CSS.make("_a_a2scq1", []);
  CSS.make("_a_a2s2ae", []);
  CSS.make("_a_a2zkti", []);
  CSS.make("_a_a20z7z", []);
  CSS.make("_a_a2h22e", []);
  CSS.make("_a_a2c7zu", []);
  CSS.make("_a_a2at92", []);
  CSS.make("_a_dlmzai", []);
  CSS.make("_a_dldrg4", []);
  CSS.make("_a_9fxu8o", []);
  CSS.make("_a_9fuytb", []);
  CSS.make("_a_9gvvta", []);
  CSS.make("_a_9g37vq", []);
  CSS.make("_a_9gl0kj", []);
  CSS.make("_a_9g0ds0", []);
  CSS.make("_a_9gkl0e", []);
  CSS.make("_a_38dtzq", []);
  CSS.make("_a_38gmgm", []);
