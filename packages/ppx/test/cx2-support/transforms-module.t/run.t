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


  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-1l0uucg{transform:none;}\n.css-1bxlsr6{transform:translate(5px);}\n.css-14phdak{transform:translate(5px, 10px);}\n.css-19ffbzo{transform:translateY(5px);}\n.css-yagj3z{transform:translateX(5px);}\n.css-246llm{transform:translateY(5%);}\n.css-191bqi7{transform:translateX(5%);}\n.css-1gsmep6{transform:scale(2);}\n.css-1hihuo{transform:scale(2, -1);}\n.css-1lz7wl3{transform:scaleX(2);}\n.css-wowczw{transform:scaleY(2.5);}\n.css-envhbk{transform:rotate(45deg);}\n.css-iko84h{transform:skew(45deg);}\n.css-148btt1{transform:skew(45deg, 15deg);}\n.css-jugqd2{transform:skewX(45deg);}\n.css-k6rlxt{transform:skewY(45deg);}\n.css-1aizqc7{transform:translate(50px, -24px) skew(0, 22.5deg);}\n.css-1jwv2u5{transform:translate3d(0, 0, 5px);}\n.css-ngdcmy{transform:translateZ(5px);}\n.css-ko4av4{transform:scale3d(1, 0, -1);}\n.css-59eyuw{transform:scaleZ(1.5);}\n.css-rymph4{transform:rotate3d(1, 1, 1, 45deg);}\n.css-12a4lr2{transform:rotateX(-45deg);}\n.css-i4stga{transform:rotateY(-45deg);}\n.css-1ht78v3{transform:rotateZ(-45deg);}\n.css-bu1n2j{transform:perspective(600px);}\n.css-uqz1s7{transform-origin:10px;}\n.css-z1z8dm{transform-origin:top;}\n.css-a7enzb{transform-origin:top left;}\n.css-5xpis9{transform-origin:50% 100%;}\n.css-mw0na3{transform-origin:left 0%;}\n.css-19ocb2r{transform-origin:left 50% 0;}\n.css-18j3lnu{transform-box:border-box;}\n.css-1q0d6y7{transform-box:fill-box;}\n.css-1y1oond{transform-box:view-box;}\n.css-pejedl{transform-box:content-box;}\n.css-16oocfm{transform-box:stroke-box;}\n.css-1lba84j{translate:none;}\n.css-1vljzei{translate:50%;}\n.css-g7hr71{translate:50% 50%;}\n.css-117aizz{translate:50% 50% 10px;}\n.css-8512yp{scale:none;}\n.css-9ekjw9{scale:2;}\n.css-19t9brl{scale:2 2;}\n.css-n5etf0{scale:2 2 2;}\n.css-q9r8a8{rotate:none;}\n.css-bl2vtg{rotate:45deg;}\n.css-1o56584{rotate:x 45deg;}\n.css-11kscq1{rotate:y 45deg;}\n.css-pos2ae{rotate:z 45deg;}\n.css-1t3zkti{rotate:-1 0 2 45deg;}\n.css-n90z7z{rotate:45deg x;}\n.css-17ih22e{rotate:45deg y;}\n.css-nrc7zu{rotate:45deg z;}\n.css-7nat92{rotate:45deg -1 0 2;}\n.css-178mzai{transform-style:flat;}\n.css-f9drg4{transform-style:preserve-3d;}\n.css-1n3xu8o{perspective:none;}\n.css-1rnuytb{perspective:600px;}\n.css-1tcvvta{perspective-origin:10px;}\n.css-1g837vq{perspective-origin:top;}\n.css-16ul0kj{perspective-origin:top left;}\n.css-16g0ds0{perspective-origin:50% 100%;}\n.css-wskl0e{perspective-origin:left 0%;}\n.css-1ycdtzq{backface-visibility:visible;}\n.css-1hmgmgm{backface-visibility:hidden;}\n"
  ];
  
  CSS.make("css-1l0uucg", []);
  CSS.make("css-1bxlsr6", []);
  CSS.make("css-14phdak", []);
  CSS.make("css-19ffbzo", []);
  CSS.make("css-yagj3z", []);
  CSS.make("css-246llm", []);
  CSS.make("css-191bqi7", []);
  CSS.make("css-1gsmep6", []);
  CSS.make("css-1hihuo", []);
  CSS.make("css-1lz7wl3", []);
  CSS.make("css-wowczw", []);
  CSS.make("css-envhbk", []);
  CSS.make("css-iko84h", []);
  CSS.make("css-148btt1", []);
  CSS.make("css-jugqd2", []);
  CSS.make("css-k6rlxt", []);
  
  CSS.make("css-1aizqc7", []);
  CSS.make("css-1jwv2u5", []);
  CSS.make("css-ngdcmy", []);
  CSS.make("css-ko4av4", []);
  CSS.make("css-59eyuw", []);
  CSS.make("css-rymph4", []);
  CSS.make("css-12a4lr2", []);
  CSS.make("css-i4stga", []);
  CSS.make("css-1ht78v3", []);
  
  CSS.transforms([|
    CSS.translate3d(`pxFloat(50.), `pxFloat(-24.), `pxFloat(5.)),
    CSS.rotate3d(1., 2., 3., `deg(180.)),
    CSS.scale3d(-1., 0., 0.5),
  |]);
  CSS.make("css-bu1n2j", []);
  CSS.make("css-uqz1s7", []);
  CSS.make("css-z1z8dm", []);
  CSS.make("css-a7enzb", []);
  CSS.make("css-5xpis9", []);
  CSS.make("css-mw0na3", []);
  CSS.make("css-19ocb2r", []);
  CSS.make("css-18j3lnu", []);
  CSS.make("css-1q0d6y7", []);
  CSS.make("css-1y1oond", []);
  CSS.make("css-pejedl", []);
  CSS.make("css-16oocfm", []);
  
  CSS.make("css-1lba84j", []);
  CSS.make("css-1vljzei", []);
  CSS.make("css-g7hr71", []);
  CSS.make("css-117aizz", []);
  CSS.make("css-8512yp", []);
  CSS.make("css-9ekjw9", []);
  CSS.make("css-19t9brl", []);
  CSS.make("css-n5etf0", []);
  CSS.make("css-q9r8a8", []);
  CSS.make("css-bl2vtg", []);
  CSS.make("css-1o56584", []);
  CSS.make("css-11kscq1", []);
  CSS.make("css-pos2ae", []);
  CSS.make("css-1t3zkti", []);
  CSS.make("css-n90z7z", []);
  CSS.make("css-17ih22e", []);
  CSS.make("css-nrc7zu", []);
  CSS.make("css-7nat92", []);
  CSS.make("css-178mzai", []);
  CSS.make("css-f9drg4", []);
  CSS.make("css-1n3xu8o", []);
  CSS.make("css-1rnuytb", []);
  CSS.make("css-1tcvvta", []);
  CSS.make("css-1g837vq", []);
  CSS.make("css-16ul0kj", []);
  CSS.make("css-16g0ds0", []);
  CSS.make("css-wskl0e", []);
  CSS.make("css-1ycdtzq", []);
  CSS.make("css-1hmgmgm", []);
