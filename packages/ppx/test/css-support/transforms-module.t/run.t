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
    ".a-1l0uucg{-webkit-transform:none;-moz-transform:none;-ms-transform:none;transform:none;}"
  ];
  [@css
    ".a-1bxlsr6{-webkit-transform:translate(5px);-moz-transform:translate(5px);-ms-transform:translate(5px);transform:translate(5px);}"
  ];
  [@css
    ".a-14phdak{-webkit-transform:translate(5px, 10px);-moz-transform:translate(5px, 10px);-ms-transform:translate(5px, 10px);transform:translate(5px, 10px);}"
  ];
  [@css
    ".a-19ffbzo{-webkit-transform:translateY(5px);-moz-transform:translateY(5px);-ms-transform:translateY(5px);transform:translateY(5px);}"
  ];
  [@css
    ".a-yagj3z{-webkit-transform:translateX(5px);-moz-transform:translateX(5px);-ms-transform:translateX(5px);transform:translateX(5px);}"
  ];
  [@css
    ".a-246llm{-webkit-transform:translateY(5%);-moz-transform:translateY(5%);-ms-transform:translateY(5%);transform:translateY(5%);}"
  ];
  [@css
    ".a-191bqi7{-webkit-transform:translateX(5%);-moz-transform:translateX(5%);-ms-transform:translateX(5%);transform:translateX(5%);}"
  ];
  [@css
    ".a-1gsmep6{-webkit-transform:scale(2);-moz-transform:scale(2);-ms-transform:scale(2);transform:scale(2);}"
  ];
  [@css
    ".a-1hihuo{-webkit-transform:scale(2, -1);-moz-transform:scale(2, -1);-ms-transform:scale(2, -1);transform:scale(2, -1);}"
  ];
  [@css
    ".a-1lz7wl3{-webkit-transform:scaleX(2);-moz-transform:scaleX(2);-ms-transform:scaleX(2);transform:scaleX(2);}"
  ];
  [@css
    ".a-wowczw{-webkit-transform:scaleY(2.5);-moz-transform:scaleY(2.5);-ms-transform:scaleY(2.5);transform:scaleY(2.5);}"
  ];
  [@css
    ".a-envhbk{-webkit-transform:rotate(45deg);-moz-transform:rotate(45deg);-ms-transform:rotate(45deg);transform:rotate(45deg);}"
  ];
  [@css
    ".a-iko84h{-webkit-transform:skew(45deg);-moz-transform:skew(45deg);-ms-transform:skew(45deg);transform:skew(45deg);}"
  ];
  [@css
    ".a-148btt1{-webkit-transform:skew(45deg, 15deg);-moz-transform:skew(45deg, 15deg);-ms-transform:skew(45deg, 15deg);transform:skew(45deg, 15deg);}"
  ];
  [@css
    ".a-jugqd2{-webkit-transform:skewX(45deg);-moz-transform:skewX(45deg);-ms-transform:skewX(45deg);transform:skewX(45deg);}"
  ];
  [@css
    ".a-k6rlxt{-webkit-transform:skewY(45deg);-moz-transform:skewY(45deg);-ms-transform:skewY(45deg);transform:skewY(45deg);}"
  ];
  [@css
    ".a-1aizqc7{-webkit-transform:translate(50px, -24px) skew(0, 22.5deg);-moz-transform:translate(50px, -24px) skew(0, 22.5deg);-ms-transform:translate(50px, -24px) skew(0, 22.5deg);transform:translate(50px, -24px) skew(0, 22.5deg);}"
  ];
  [@css
    ".a-1jwv2u5{-webkit-transform:translate3d(0, 0, 5px);-moz-transform:translate3d(0, 0, 5px);-ms-transform:translate3d(0, 0, 5px);transform:translate3d(0, 0, 5px);}"
  ];
  [@css
    ".a-ngdcmy{-webkit-transform:translateZ(5px);-moz-transform:translateZ(5px);-ms-transform:translateZ(5px);transform:translateZ(5px);}"
  ];
  [@css
    ".a-ko4av4{-webkit-transform:scale3d(1, 0, -1);-moz-transform:scale3d(1, 0, -1);-ms-transform:scale3d(1, 0, -1);transform:scale3d(1, 0, -1);}"
  ];
  [@css
    ".a-59eyuw{-webkit-transform:scaleZ(1.5);-moz-transform:scaleZ(1.5);-ms-transform:scaleZ(1.5);transform:scaleZ(1.5);}"
  ];
  [@css
    ".a-rymph4{-webkit-transform:rotate3d(1, 1, 1, 45deg);-moz-transform:rotate3d(1, 1, 1, 45deg);-ms-transform:rotate3d(1, 1, 1, 45deg);transform:rotate3d(1, 1, 1, 45deg);}"
  ];
  [@css
    ".a-12a4lr2{-webkit-transform:rotateX(-45deg);-moz-transform:rotateX(-45deg);-ms-transform:rotateX(-45deg);transform:rotateX(-45deg);}"
  ];
  [@css
    ".a-i4stga{-webkit-transform:rotateY(-45deg);-moz-transform:rotateY(-45deg);-ms-transform:rotateY(-45deg);transform:rotateY(-45deg);}"
  ];
  [@css
    ".a-1ht78v3{-webkit-transform:rotateZ(-45deg);-moz-transform:rotateZ(-45deg);-ms-transform:rotateZ(-45deg);transform:rotateZ(-45deg);}"
  ];
  [@css
    ".a-1k57g01{-webkit-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);-moz-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);-ms-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);}"
  ];
  [@css
    ".a-bu1n2j{-webkit-transform:perspective(600px);-moz-transform:perspective(600px);-ms-transform:perspective(600px);transform:perspective(600px);}"
  ];
  [@css ".a-uqz1s7{transform-origin:10px;}"];
  [@css ".a-z1z8dm{transform-origin:top;}"];
  [@css ".a-a7enzb{transform-origin:top left;}"];
  [@css ".a-5xpis9{transform-origin:50% 100%;}"];
  [@css ".a-mw0na3{transform-origin:left 0%;}"];
  [@css ".a-19ocb2r{transform-origin:left 50% 0;}"];
  [@css ".a-18j3lnu{transform-box:border-box;}"];
  [@css ".a-1q0d6y7{transform-box:fill-box;}"];
  [@css ".a-1y1oond{transform-box:view-box;}"];
  [@css ".a-pejedl{transform-box:content-box;}"];
  [@css ".a-16oocfm{transform-box:stroke-box;}"];
  [@css ".a-1lba84j{translate:none;}"];
  [@css ".a-1vljzei{translate:50%;}"];
  [@css ".a-g7hr71{translate:50% 50%;}"];
  [@css ".a-117aizz{translate:50% 50% 10px;}"];
  [@css ".a-8512yp{scale:none;}"];
  [@css ".a-9ekjw9{scale:2;}"];
  [@css ".a-19t9brl{scale:2 2;}"];
  [@css ".a-n5etf0{scale:2 2 2;}"];
  [@css ".a-q9r8a8{rotate:none;}"];
  [@css ".a-bl2vtg{rotate:45deg;}"];
  [@css ".a-1o56584{rotate:x 45deg;}"];
  [@css ".a-11kscq1{rotate:y 45deg;}"];
  [@css ".a-pos2ae{rotate:z 45deg;}"];
  [@css ".a-1t3zkti{rotate:-1 0 2 45deg;}"];
  [@css ".a-n90z7z{rotate:45deg x;}"];
  [@css ".a-17ih22e{rotate:45deg y;}"];
  [@css ".a-nrc7zu{rotate:45deg z;}"];
  [@css ".a-7nat92{rotate:45deg -1 0 2;}"];
  [@css ".a-178mzai{transform-style:flat;}"];
  [@css ".a-f9drg4{transform-style:preserve-3d;}"];
  [@css ".a-1n3xu8o{perspective:none;}"];
  [@css ".a-1rnuytb{perspective:600px;}"];
  [@css ".a-1tcvvta{perspective-origin:10px;}"];
  [@css ".a-1g837vq{perspective-origin:top;}"];
  [@css ".a-16ul0kj{perspective-origin:top left;}"];
  [@css ".a-16g0ds0{perspective-origin:50% 100%;}"];
  [@css ".a-wskl0e{perspective-origin:left 0%;}"];
  [@css
    ".a-1ycdtzq{-webkit-backface-visibility:visible;backface-visibility:visible;}"
  ];
  [@css
    ".a-1hmgmgm{-webkit-backface-visibility:hidden;backface-visibility:hidden;}"
  ];
  
  CSS.make("a-1l0uucg", []);
  CSS.make("a-1bxlsr6", []);
  CSS.make("a-14phdak", []);
  CSS.make("a-19ffbzo", []);
  CSS.make("a-yagj3z", []);
  CSS.make("a-246llm", []);
  CSS.make("a-191bqi7", []);
  CSS.make("a-1gsmep6", []);
  CSS.make("a-1hihuo", []);
  CSS.make("a-1lz7wl3", []);
  CSS.make("a-wowczw", []);
  CSS.make("a-envhbk", []);
  CSS.make("a-iko84h", []);
  CSS.make("a-148btt1", []);
  CSS.make("a-jugqd2", []);
  CSS.make("a-k6rlxt", []);
  
  CSS.make("a-1aizqc7", []);
  CSS.make("a-1jwv2u5", []);
  CSS.make("a-ngdcmy", []);
  CSS.make("a-ko4av4", []);
  CSS.make("a-59eyuw", []);
  CSS.make("a-rymph4", []);
  CSS.make("a-12a4lr2", []);
  CSS.make("a-i4stga", []);
  CSS.make("a-1ht78v3", []);
  
  CSS.make("a-1k57g01", []);
  CSS.make("a-bu1n2j", []);
  CSS.make("a-uqz1s7", []);
  CSS.make("a-z1z8dm", []);
  CSS.make("a-a7enzb", []);
  CSS.make("a-5xpis9", []);
  CSS.make("a-mw0na3", []);
  CSS.make("a-19ocb2r", []);
  CSS.make("a-18j3lnu", []);
  CSS.make("a-1q0d6y7", []);
  CSS.make("a-1y1oond", []);
  CSS.make("a-pejedl", []);
  CSS.make("a-16oocfm", []);
  
  CSS.make("a-1lba84j", []);
  CSS.make("a-1vljzei", []);
  CSS.make("a-g7hr71", []);
  CSS.make("a-117aizz", []);
  CSS.make("a-8512yp", []);
  CSS.make("a-9ekjw9", []);
  CSS.make("a-19t9brl", []);
  CSS.make("a-n5etf0", []);
  CSS.make("a-q9r8a8", []);
  CSS.make("a-bl2vtg", []);
  CSS.make("a-1o56584", []);
  CSS.make("a-11kscq1", []);
  CSS.make("a-pos2ae", []);
  CSS.make("a-1t3zkti", []);
  CSS.make("a-n90z7z", []);
  CSS.make("a-17ih22e", []);
  CSS.make("a-nrc7zu", []);
  CSS.make("a-7nat92", []);
  CSS.make("a-178mzai", []);
  CSS.make("a-f9drg4", []);
  CSS.make("a-1n3xu8o", []);
  CSS.make("a-1rnuytb", []);
  CSS.make("a-1tcvvta", []);
  CSS.make("a-1g837vq", []);
  CSS.make("a-16ul0kj", []);
  CSS.make("a-16g0ds0", []);
  CSS.make("a-wskl0e", []);
  CSS.make("a-1ycdtzq", []);
  CSS.make("a-1hmgmgm", []);
