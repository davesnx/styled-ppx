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
    ".css-1dol3wd{-webkit-transform:none;-moz-transform:none;-ms-transform:none;transform:none;}"
  ];
  [@css
    ".css-ljddzs{-webkit-transform:translate(5px);-moz-transform:translate(5px);-ms-transform:translate(5px);transform:translate(5px);}"
  ];
  [@css
    ".css-1q9mt0a{-webkit-transform:translate(5px, 10px);-moz-transform:translate(5px, 10px);-ms-transform:translate(5px, 10px);transform:translate(5px, 10px);}"
  ];
  [@css
    ".css-1btoi02{-webkit-transform:translateY(5px);-moz-transform:translateY(5px);-ms-transform:translateY(5px);transform:translateY(5px);}"
  ];
  [@css
    ".css-1bqfasx{-webkit-transform:translateX(5px);-moz-transform:translateX(5px);-ms-transform:translateX(5px);transform:translateX(5px);}"
  ];
  [@css
    ".css-2mjorm{-webkit-transform:translateY(5%);-moz-transform:translateY(5%);-ms-transform:translateY(5%);transform:translateY(5%);}"
  ];
  [@css
    ".css-3z9uq3{-webkit-transform:translateX(5%);-moz-transform:translateX(5%);-ms-transform:translateX(5%);transform:translateX(5%);}"
  ];
  [@css
    ".css-6h25dy{-webkit-transform:scale(2);-moz-transform:scale(2);-ms-transform:scale(2);transform:scale(2);}"
  ];
  [@css
    ".css-1q4keo2{-webkit-transform:scale(2, -1);-moz-transform:scale(2, -1);-ms-transform:scale(2, -1);transform:scale(2, -1);}"
  ];
  [@css
    ".css-1isdwqh{-webkit-transform:scaleX(2);-moz-transform:scaleX(2);-ms-transform:scaleX(2);transform:scaleX(2);}"
  ];
  [@css
    ".css-12w6lwa{-webkit-transform:scaleY(2.5);-moz-transform:scaleY(2.5);-ms-transform:scaleY(2.5);transform:scaleY(2.5);}"
  ];
  [@css
    ".css-nk9om3{-webkit-transform:rotate(45deg);-moz-transform:rotate(45deg);-ms-transform:rotate(45deg);transform:rotate(45deg);}"
  ];
  [@css
    ".css-f7odwo{-webkit-transform:skew(45deg);-moz-transform:skew(45deg);-ms-transform:skew(45deg);transform:skew(45deg);}"
  ];
  [@css
    ".css-jar7fi{-webkit-transform:skew(45deg, 15deg);-moz-transform:skew(45deg, 15deg);-ms-transform:skew(45deg, 15deg);transform:skew(45deg, 15deg);}"
  ];
  [@css
    ".css-1d1arr6{-webkit-transform:skewX(45deg);-moz-transform:skewX(45deg);-ms-transform:skewX(45deg);transform:skewX(45deg);}"
  ];
  [@css
    ".css-fwd944{-webkit-transform:skewY(45deg);-moz-transform:skewY(45deg);-ms-transform:skewY(45deg);transform:skewY(45deg);}"
  ];
  [@css
    ".css-9g1bbd{-webkit-transform:translate(50px, -24px) skew(0, 22.5deg);-moz-transform:translate(50px, -24px) skew(0, 22.5deg);-ms-transform:translate(50px, -24px) skew(0, 22.5deg);transform:translate(50px, -24px) skew(0, 22.5deg);}"
  ];
  [@css
    ".css-vzz41{-webkit-transform:translate3d(0, 0, 5px);-moz-transform:translate3d(0, 0, 5px);-ms-transform:translate3d(0, 0, 5px);transform:translate3d(0, 0, 5px);}"
  ];
  [@css
    ".css-1x56z07{-webkit-transform:translateZ(5px);-moz-transform:translateZ(5px);-ms-transform:translateZ(5px);transform:translateZ(5px);}"
  ];
  [@css
    ".css-cfq4t{-webkit-transform:scale3d(1, 0, -1);-moz-transform:scale3d(1, 0, -1);-ms-transform:scale3d(1, 0, -1);transform:scale3d(1, 0, -1);}"
  ];
  [@css
    ".css-19b9pix{-webkit-transform:scaleZ(1.5);-moz-transform:scaleZ(1.5);-ms-transform:scaleZ(1.5);transform:scaleZ(1.5);}"
  ];
  [@css
    ".css-hh2roj{-webkit-transform:rotate3d(1, 1, 1, 45deg);-moz-transform:rotate3d(1, 1, 1, 45deg);-ms-transform:rotate3d(1, 1, 1, 45deg);transform:rotate3d(1, 1, 1, 45deg);}"
  ];
  [@css
    ".css-rst27b{-webkit-transform:rotateX(-45deg);-moz-transform:rotateX(-45deg);-ms-transform:rotateX(-45deg);transform:rotateX(-45deg);}"
  ];
  [@css
    ".css-1w296f2{-webkit-transform:rotateY(-45deg);-moz-transform:rotateY(-45deg);-ms-transform:rotateY(-45deg);transform:rotateY(-45deg);}"
  ];
  [@css
    ".css-1ln96ir{-webkit-transform:rotateZ(-45deg);-moz-transform:rotateZ(-45deg);-ms-transform:rotateZ(-45deg);transform:rotateZ(-45deg);}"
  ];
  [@css
    ".css-ger8ya{-webkit-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);-moz-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);-ms-transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);transform:translate3d(50px, -24px, 5px) rotate3d(1, 2, 3, 180deg) scale3d(-1, 0, 0.5);}"
  ];
  [@css
    ".css-v95c2m{-webkit-transform:perspective(600px);-moz-transform:perspective(600px);-ms-transform:perspective(600px);transform:perspective(600px);}"
  ];
  [@css ".css-uge6ve{transform-origin:10px;}"];
  [@css ".css-ym3twc{transform-origin:top;}"];
  [@css ".css-gam2ks{transform-origin:top left;}"];
  [@css ".css-1ocp362{transform-origin:50% 100%;}"];
  [@css ".css-3xn4bt{transform-origin:left 0%;}"];
  [@css ".css-1mw5pn5{transform-origin:left 50% 0;}"];
  [@css ".css-11di710{transform-box:border-box;}"];
  [@css ".css-8s60z3{transform-box:fill-box;}"];
  [@css ".css-1eevpqy{transform-box:view-box;}"];
  [@css ".css-1qo7yhg{transform-box:content-box;}"];
  [@css ".css-1g1t29g{transform-box:stroke-box;}"];
  [@css ".css-1acoltj{translate:none;}"];
  [@css ".css-qz33ob{translate:50%;}"];
  [@css ".css-1cs4yc7{translate:50% 50%;}"];
  [@css ".css-1orqgt7{translate:50% 50% 10px;}"];
  [@css ".css-1cm1x6y{scale:none;}"];
  [@css ".css-drcc47{scale:2;}"];
  [@css ".css-zv64k8{scale:2 2;}"];
  [@css ".css-1w73ozh{scale:2 2 2;}"];
  [@css ".css-1kbydc6{rotate:none;}"];
  [@css ".css-ebqikx{rotate:45deg;}"];
  [@css ".css-1e1zomo{rotate:x 45deg;}"];
  [@css ".css-1c72osx{rotate:y 45deg;}"];
  [@css ".css-h09lvn{rotate:z 45deg;}"];
  [@css ".css-ikb4f3{rotate:-1 0 2 45deg;}"];
  [@css ".css-b4g42i{rotate:45deg x;}"];
  [@css ".css-17og4tr{rotate:45deg y;}"];
  [@css ".css-lzs8vs{rotate:45deg z;}"];
  [@css ".css-l3r80b{rotate:45deg -1 0 2;}"];
  [@css ".css-1cq70q3{transform-style:flat;}"];
  [@css ".css-1995f30{transform-style:preserve-3d;}"];
  [@css ".css-x35ox9{perspective:none;}"];
  [@css ".css-1o1fls7{perspective:600px;}"];
  [@css ".css-11unduu{perspective-origin:10px;}"];
  [@css ".css-1sqap1a{perspective-origin:top;}"];
  [@css ".css-g13ef0{perspective-origin:top left;}"];
  [@css ".css-1rbi48c{perspective-origin:50% 100%;}"];
  [@css ".css-1f7ggb2{perspective-origin:left 0%;}"];
  [@css
    ".css-kpjxn2{-webkit-backface-visibility:visible;backface-visibility:visible;}"
  ];
  [@css
    ".css-1cn0vli{-webkit-backface-visibility:hidden;backface-visibility:hidden;}"
  ];
  [@css.classes
    [
      ("css-1dol3wd", 0, "", "input.re", 2, 8, 2, 23),
      ("css-ljddzs", 1, "", "input.re", 3, 8, 3, 33),
      ("css-1q9mt0a", 2, "", "input.re", 4, 8, 4, 39),
      ("css-1btoi02", 3, "", "input.re", 5, 8, 5, 34),
      ("css-1bqfasx", 4, "", "input.re", 6, 8, 6, 34),
      ("css-2mjorm", 5, "", "input.re", 7, 8, 7, 33),
      ("css-3z9uq3", 6, "", "input.re", 8, 8, 8, 33),
      ("css-6h25dy", 7, "", "input.re", 9, 8, 9, 27),
      ("css-1q4keo2", 8, "", "input.re", 10, 8, 10, 31),
      ("css-1isdwqh", 9, "", "input.re", 11, 8, 11, 28),
      ("css-12w6lwa", 10, "", "input.re", 12, 8, 12, 30),
      ("css-nk9om3", 11, "", "input.re", 13, 8, 13, 32),
      ("css-f7odwo", 12, "", "input.re", 14, 8, 14, 30),
      ("css-jar7fi", 13, "", "input.re", 15, 8, 15, 37),
      ("css-1d1arr6", 14, "", "input.re", 16, 8, 16, 31),
      ("css-fwd944", 15, "", "input.re", 17, 8, 17, 31),
      ("css-9g1bbd", 16, "", "input.re", 20, 8, 20, 58),
      ("css-vzz41", 17, "", "input.re", 21, 8, 21, 41),
      ("css-1x56z07", 18, "", "input.re", 22, 8, 22, 34),
      ("css-cfq4t", 19, "", "input.re", 23, 8, 23, 36),
      ("css-19b9pix", 20, "", "input.re", 24, 8, 24, 30),
      ("css-hh2roj", 21, "", "input.re", 25, 8, 25, 43),
      ("css-rst27b", 22, "", "input.re", 26, 8, 26, 34),
      ("css-1w296f2", 23, "", "input.re", 27, 8, 27, 34),
      ("css-1ln96ir", 24, "", "input.re", 28, 8, 28, 34),
      ("css-ger8ya", 25, "", "input.re", 32, 4, 32, 89),
      ("css-v95c2m", 26, "", "input.re", 34, 8, 34, 37),
      ("css-uge6ve", 27, "", "input.re", 35, 8, 35, 30),
      ("css-ym3twc", 28, "", "input.re", 36, 8, 36, 29),
      ("css-gam2ks", 29, "", "input.re", 37, 8, 37, 34),
      ("css-1ocp362", 30, "", "input.re", 38, 8, 38, 34),
      ("css-3xn4bt", 31, "", "input.re", 39, 8, 39, 33),
      ("css-1mw5pn5", 32, "", "input.re", 40, 8, 40, 36),
      ("css-11di710", 33, "", "input.re", 41, 8, 41, 33),
      ("css-8s60z3", 34, "", "input.re", 42, 8, 42, 31),
      ("css-1eevpqy", 35, "", "input.re", 43, 8, 43, 31),
      ("css-1qo7yhg", 36, "", "input.re", 44, 8, 44, 34),
      ("css-1g1t29g", 37, "", "input.re", 45, 8, 45, 33),
      ("css-1acoltj", 38, "", "input.re", 48, 8, 48, 23),
      ("css-qz33ob", 39, "", "input.re", 49, 8, 49, 22),
      ("css-1cs4yc7", 40, "", "input.re", 50, 8, 50, 26),
      ("css-1orqgt7", 41, "", "input.re", 51, 8, 51, 31),
      ("css-1cm1x6y", 42, "", "input.re", 52, 8, 52, 19),
      ("css-drcc47", 43, "", "input.re", 53, 8, 53, 16),
      ("css-zv64k8", 44, "", "input.re", 54, 8, 54, 18),
      ("css-1w73ozh", 45, "", "input.re", 55, 8, 55, 20),
      ("css-1kbydc6", 46, "", "input.re", 56, 8, 56, 20),
      ("css-ebqikx", 47, "", "input.re", 57, 8, 57, 22),
      ("css-1e1zomo", 48, "", "input.re", 58, 8, 58, 23),
      ("css-1c72osx", 49, "", "input.re", 59, 8, 59, 23),
      ("css-h09lvn", 50, "", "input.re", 60, 8, 60, 23),
      ("css-ikb4f3", 51, "", "input.re", 61, 8, 61, 28),
      ("css-b4g42i", 52, "", "input.re", 62, 8, 62, 23),
      ("css-17og4tr", 53, "", "input.re", 63, 8, 63, 23),
      ("css-lzs8vs", 54, "", "input.re", 64, 8, 64, 23),
      ("css-l3r80b", 55, "", "input.re", 65, 8, 65, 28),
      ("css-1cq70q3", 56, "", "input.re", 66, 8, 66, 29),
      ("css-1995f30", 57, "", "input.re", 67, 8, 67, 36),
      ("css-x35ox9", 58, "", "input.re", 68, 8, 68, 25),
      ("css-1o1fls7", 59, "", "input.re", 69, 8, 69, 26),
      ("css-11unduu", 60, "", "input.re", 70, 8, 70, 32),
      ("css-1sqap1a", 61, "", "input.re", 71, 8, 71, 31),
      ("css-g13ef0", 62, "", "input.re", 72, 8, 72, 36),
      ("css-1rbi48c", 63, "", "input.re", 73, 8, 73, 36),
      ("css-1f7ggb2", 64, "", "input.re", 74, 8, 74, 35),
      ("css-kpjxn2", 65, "", "input.re", 75, 8, 75, 36),
      ("css-1cn0vli", 66, "", "input.re", 76, 8, 76, 35),
    ]
  ];
  
  CSS.make("css-1dol3wd", []);
  CSS.make("css-ljddzs", []);
  CSS.make("css-1q9mt0a", []);
  CSS.make("css-1btoi02", []);
  CSS.make("css-1bqfasx", []);
  CSS.make("css-2mjorm", []);
  CSS.make("css-3z9uq3", []);
  CSS.make("css-6h25dy", []);
  CSS.make("css-1q4keo2", []);
  CSS.make("css-1isdwqh", []);
  CSS.make("css-12w6lwa", []);
  CSS.make("css-nk9om3", []);
  CSS.make("css-f7odwo", []);
  CSS.make("css-jar7fi", []);
  CSS.make("css-1d1arr6", []);
  CSS.make("css-fwd944", []);
  
  CSS.make("css-9g1bbd", []);
  CSS.make("css-vzz41", []);
  CSS.make("css-1x56z07", []);
  CSS.make("css-cfq4t", []);
  CSS.make("css-19b9pix", []);
  CSS.make("css-hh2roj", []);
  CSS.make("css-rst27b", []);
  CSS.make("css-1w296f2", []);
  CSS.make("css-1ln96ir", []);
  
  CSS.make("css-ger8ya", []);
  CSS.make("css-v95c2m", []);
  CSS.make("css-uge6ve", []);
  CSS.make("css-ym3twc", []);
  CSS.make("css-gam2ks", []);
  CSS.make("css-1ocp362", []);
  CSS.make("css-3xn4bt", []);
  CSS.make("css-1mw5pn5", []);
  CSS.make("css-11di710", []);
  CSS.make("css-8s60z3", []);
  CSS.make("css-1eevpqy", []);
  CSS.make("css-1qo7yhg", []);
  CSS.make("css-1g1t29g", []);
  
  CSS.make("css-1acoltj", []);
  CSS.make("css-qz33ob", []);
  CSS.make("css-1cs4yc7", []);
  CSS.make("css-1orqgt7", []);
  CSS.make("css-1cm1x6y", []);
  CSS.make("css-drcc47", []);
  CSS.make("css-zv64k8", []);
  CSS.make("css-1w73ozh", []);
  CSS.make("css-1kbydc6", []);
  CSS.make("css-ebqikx", []);
  CSS.make("css-1e1zomo", []);
  CSS.make("css-1c72osx", []);
  CSS.make("css-h09lvn", []);
  CSS.make("css-ikb4f3", []);
  CSS.make("css-b4g42i", []);
  CSS.make("css-17og4tr", []);
  CSS.make("css-lzs8vs", []);
  CSS.make("css-l3r80b", []);
  CSS.make("css-1cq70q3", []);
  CSS.make("css-1995f30", []);
  CSS.make("css-x35ox9", []);
  CSS.make("css-1o1fls7", []);
  CSS.make("css-11unduu", []);
  CSS.make("css-1sqap1a", []);
  CSS.make("css-g13ef0", []);
  CSS.make("css-1rbi48c", []);
  CSS.make("css-1f7ggb2", []);
  CSS.make("css-kpjxn2", []);
  CSS.make("css-1cn0vli", []);
