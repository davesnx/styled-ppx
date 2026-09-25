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
    ".a-diuucg{-webkit-transform:none;-moz-transform:none;-ms-transform:none;transform:none;}"
  ];
  [@css
    ".a-dilsr6{-webkit-transform:translate(5px);-moz-transform:translate(5px);-ms-transform:translate(5px);transform:translate(5px);}"
  ];
  [@css
    ".a-dihdak{-webkit-transform:translate(5px, 10px);-moz-transform:translate(5px, 10px);-ms-transform:translate(5px, 10px);transform:translate(5px, 10px);}"
  ];
  [@css
    ".a-difbzo{-webkit-transform:translateY(5px);-moz-transform:translateY(5px);-ms-transform:translateY(5px);transform:translateY(5px);}"
  ];
  [@css
    ".a-digj3z{-webkit-transform:translateX(5px);-moz-transform:translateX(5px);-ms-transform:translateX(5px);transform:translateX(5px);}"
  ];
  [@css
    ".a-di6llm{-webkit-transform:translateY(5%);-moz-transform:translateY(5%);-ms-transform:translateY(5%);transform:translateY(5%);}"
  ];
  [@css
    ".a-dibqi7{-webkit-transform:translateX(5%);-moz-transform:translateX(5%);-ms-transform:translateX(5%);transform:translateX(5%);}"
  ];
  [@css
    ".a-dimep6{-webkit-transform:scale(2);-moz-transform:scale(2);-ms-transform:scale(2);transform:scale(2);}"
  ];
  [@css
    ".a-diihuo{-webkit-transform:scale(2, -1);-moz-transform:scale(2, -1);-ms-transform:scale(2, -1);transform:scale(2, -1);}"
  ];
  [@css
    ".a-di7wl3{-webkit-transform:scaleX(2);-moz-transform:scaleX(2);-ms-transform:scaleX(2);transform:scaleX(2);}"
  ];
  [@css
    ".a-diwczw{-webkit-transform:scaleY(2.5);-moz-transform:scaleY(2.5);-ms-transform:scaleY(2.5);transform:scaleY(2.5);}"
  ];
  [@css
    ".a-divhbk{-webkit-transform:rotate(45deg);-moz-transform:rotate(45deg);-ms-transform:rotate(45deg);transform:rotate(45deg);}"
  ];
  [@css
    ".a-dio84h{-webkit-transform:skew(45deg);-moz-transform:skew(45deg);-ms-transform:skew(45deg);transform:skew(45deg);}"
  ];
  [@css
    ".a-dibtt1{-webkit-transform:skew(45deg, 15deg);-moz-transform:skew(45deg, 15deg);-ms-transform:skew(45deg, 15deg);transform:skew(45deg, 15deg);}"
  ];
  [@css
    ".a-digqd2{-webkit-transform:skewX(45deg);-moz-transform:skewX(45deg);-ms-transform:skewX(45deg);transform:skewX(45deg);}"
  ];
  [@css
    ".a-dirlxt{-webkit-transform:skewY(45deg);-moz-transform:skewY(45deg);-ms-transform:skewY(45deg);transform:skewY(45deg);}"
  ];
  [@css
    ".a-dizqc7{-webkit-transform:translate(50px, -24px) skew(0, 22.5deg);-moz-transform:translate(50px, -24px) skew(0, 22.5deg);-ms-transform:translate(50px, -24px) skew(0, 22.5deg);transform:translate(50px, -24px) skew(0, 22.5deg);}"
  ];
  [@css
    ".a-div2u5{-webkit-transform:translate3d(0, 0, 5px);-moz-transform:translate3d(0, 0, 5px);-ms-transform:translate3d(0, 0, 5px);transform:translate3d(0, 0, 5px);}"
  ];
  [@css
    ".a-didcmy{-webkit-transform:translateZ(5px);-moz-transform:translateZ(5px);-ms-transform:translateZ(5px);transform:translateZ(5px);}"
  ];
  [@css
    ".a-di4av4{-webkit-transform:scale3d(1, 0, -1);-moz-transform:scale3d(1, 0, -1);-ms-transform:scale3d(1, 0, -1);transform:scale3d(1, 0, -1);}"
  ];
  [@css
    ".a-dieyuw{-webkit-transform:scaleZ(1.5);-moz-transform:scaleZ(1.5);-ms-transform:scaleZ(1.5);transform:scaleZ(1.5);}"
  ];
  [@css
    ".a-dimph4{-webkit-transform:rotate3d(1, 1, 1, 45deg);-moz-transform:rotate3d(1, 1, 1, 45deg);-ms-transform:rotate3d(1, 1, 1, 45deg);transform:rotate3d(1, 1, 1, 45deg);}"
  ];
  [@css
    ".a-di4lr2{-webkit-transform:rotateX(-45deg);-moz-transform:rotateX(-45deg);-ms-transform:rotateX(-45deg);transform:rotateX(-45deg);}"
  ];
  [@css
    ".a-distga{-webkit-transform:rotateY(-45deg);-moz-transform:rotateY(-45deg);-ms-transform:rotateY(-45deg);transform:rotateY(-45deg);}"
  ];
  [@css
    ".a-di78v3{-webkit-transform:rotateZ(-45deg);-moz-transform:rotateZ(-45deg);-ms-transform:rotateZ(-45deg);transform:rotateZ(-45deg);}"
  ];
  [@css
    ".a-di7g01{-webkit-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);-moz-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);-ms-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);}"
  ];
  [@css
    ".a-di1n2j{-webkit-transform:perspective(600px);-moz-transform:perspective(600px);-ms-transform:perspective(600px);transform:perspective(600px);}"
  ];
  [@css ".a-dkz1s7{transform-origin:10px;}"];
  [@css ".a-dkz8dm{transform-origin:top;}"];
  [@css ".a-dkenzb{transform-origin:top left;}"];
  [@css ".a-dkpis9{transform-origin:50% 100%;}"];
  [@css ".a-dk0na3{transform-origin:left 0%;}"];
  [@css ".a-dkcb2r{transform-origin:left 50% 0;}"];
  [@css ".a-dj3lnu{transform-box:border-box;}"];
  [@css ".a-djd6y7{transform-box:fill-box;}"];
  [@css ".a-djoond{transform-box:view-box;}"];
  [@css ".a-djjedl{transform-box:content-box;}"];
  [@css ".a-djocfm{transform-box:stroke-box;}"];
  [@css ".a-dna84j{translate:none;}"];
  [@css ".a-dnjzei{translate:50%;}"];
  [@css ".a-dnhr71{translate:50% 50%;}"];
  [@css ".a-dnaizz{translate:50% 50% 10px;}"];
  [@css ".a-a912yp{scale:none;}"];
  [@css ".a-a9kjw9{scale:2;}"];
  [@css ".a-a99brl{scale:2 2;}"];
  [@css ".a-a9etf0{scale:2 2 2;}"];
  [@css ".a-a2r8a8{rotate:none;}"];
  [@css ".a-a22vtg{rotate:45deg;}"];
  [@css ".a-a26584{rotate:x 45deg;}"];
  [@css ".a-a2scq1{rotate:y 45deg;}"];
  [@css ".a-a2s2ae{rotate:z 45deg;}"];
  [@css ".a-a2zkti{rotate:-1 0 2 45deg;}"];
  [@css ".a-a20z7z{rotate:45deg x;}"];
  [@css ".a-a2h22e{rotate:45deg y;}"];
  [@css ".a-a2c7zu{rotate:45deg z;}"];
  [@css ".a-a2at92{rotate:45deg -1 0 2;}"];
  [@css ".a-dlmzai{transform-style:flat;}"];
  [@css ".a-dldrg4{transform-style:preserve-3d;}"];
  [@css ".a-9fxu8o{perspective:none;}"];
  [@css ".a-9fuytb{perspective:600px;}"];
  [@css ".a-9gvvta{perspective-origin:10px;}"];
  [@css ".a-9g37vq{perspective-origin:top;}"];
  [@css ".a-9gl0kj{perspective-origin:top left;}"];
  [@css ".a-9g0ds0{perspective-origin:50% 100%;}"];
  [@css ".a-9gkl0e{perspective-origin:left 0%;}"];
  [@css
    ".a-38dtzq{-webkit-backface-visibility:visible;backface-visibility:visible;}"
  ];
  [@css
    ".a-38gmgm{-webkit-backface-visibility:hidden;backface-visibility:hidden;}"
  ];
  
  CSS.make("a-diuucg", []);
  CSS.make("a-dilsr6", []);
  CSS.make("a-dihdak", []);
  CSS.make("a-difbzo", []);
  CSS.make("a-digj3z", []);
  CSS.make("a-di6llm", []);
  CSS.make("a-dibqi7", []);
  CSS.make("a-dimep6", []);
  CSS.make("a-diihuo", []);
  CSS.make("a-di7wl3", []);
  CSS.make("a-diwczw", []);
  CSS.make("a-divhbk", []);
  CSS.make("a-dio84h", []);
  CSS.make("a-dibtt1", []);
  CSS.make("a-digqd2", []);
  CSS.make("a-dirlxt", []);
  
  CSS.make("a-dizqc7", []);
  CSS.make("a-div2u5", []);
  CSS.make("a-didcmy", []);
  CSS.make("a-di4av4", []);
  CSS.make("a-dieyuw", []);
  CSS.make("a-dimph4", []);
  CSS.make("a-di4lr2", []);
  CSS.make("a-distga", []);
  CSS.make("a-di78v3", []);
  
  CSS.make("a-di7g01", []);
  CSS.make("a-di1n2j", []);
  CSS.make("a-dkz1s7", []);
  CSS.make("a-dkz8dm", []);
  CSS.make("a-dkenzb", []);
  CSS.make("a-dkpis9", []);
  CSS.make("a-dk0na3", []);
  CSS.make("a-dkcb2r", []);
  CSS.make("a-dj3lnu", []);
  CSS.make("a-djd6y7", []);
  CSS.make("a-djoond", []);
  CSS.make("a-djjedl", []);
  CSS.make("a-djocfm", []);
  
  CSS.make("a-dna84j", []);
  CSS.make("a-dnjzei", []);
  CSS.make("a-dnhr71", []);
  CSS.make("a-dnaizz", []);
  CSS.make("a-a912yp", []);
  CSS.make("a-a9kjw9", []);
  CSS.make("a-a99brl", []);
  CSS.make("a-a9etf0", []);
  CSS.make("a-a2r8a8", []);
  CSS.make("a-a22vtg", []);
  CSS.make("a-a26584", []);
  CSS.make("a-a2scq1", []);
  CSS.make("a-a2s2ae", []);
  CSS.make("a-a2zkti", []);
  CSS.make("a-a20z7z", []);
  CSS.make("a-a2h22e", []);
  CSS.make("a-a2c7zu", []);
  CSS.make("a-a2at92", []);
  CSS.make("a-dlmzai", []);
  CSS.make("a-dldrg4", []);
  CSS.make("a-9fxu8o", []);
  CSS.make("a-9fuytb", []);
  CSS.make("a-9gvvta", []);
  CSS.make("a-9g37vq", []);
  CSS.make("a-9gl0kj", []);
  CSS.make("a-9g0ds0", []);
  CSS.make("a-9gkl0e", []);
  CSS.make("a-38dtzq", []);
  CSS.make("a-38gmgm", []);
