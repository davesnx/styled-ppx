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
    ".css-1gnxmyp{-webkit-clip-path:url(\"#clip\");clip-path:url(\"#clip\");}"
  ];
  [@css ".css-4h70ig{-webkit-clip-path:inset(50%);clip-path:inset(50%);}"];
  [@css
    ".css-h38vw0{-webkit-clip-path:path(\"M 20 20 H 80 V 30\");clip-path:path(\"M 20 20 H 80 V 30\");}"
  ];
  [@css
    ".css-12svcf0{-webkit-clip-path:polygon(50% 100%, 0 0, 100% 0);clip-path:polygon(50% 100%, 0 0, 100% 0);}"
  ];
  [@css
    ".css-13tndnl{-webkit-clip-path:polygon(evenodd, 0% 0%, 50% 50%, 0% 100%);clip-path:polygon(evenodd, 0% 0%, 50% 50%, 0% 100%);}"
  ];
  [@css
    ".css-1i08xfu{-webkit-clip-path:polygon(nonzero, 0% 0%, 50% 50%, 0% 100%);clip-path:polygon(nonzero, 0% 0%, 50% 50%, 0% 100%);}"
  ];
  [@css ".css-16cpffv{-webkit-clip-path:border-box;clip-path:border-box;}"];
  [@css ".css-u0l5cp{-webkit-clip-path:padding-box;clip-path:padding-box;}"];
  [@css ".css-1xtwd5b{-webkit-clip-path:content-box;clip-path:content-box;}"];
  [@css ".css-xb2hne{-webkit-clip-path:margin-box;clip-path:margin-box;}"];
  [@css ".css-1dlxeng{-webkit-clip-path:fill-box;clip-path:fill-box;}"];
  [@css ".css-ak5dak{-webkit-clip-path:stroke-box;clip-path:stroke-box;}"];
  [@css ".css-sjfury{-webkit-clip-path:view-box;clip-path:view-box;}"];
  [@css ".css-10en4kl{-webkit-clip-path:none;clip-path:none;}"];
  [@css ".css-fyco4m{clip-rule:nonzero;}"];
  [@css ".css-12y8brg{clip-rule:evenodd;}"];
  [@css ".css-1uhqxnc{-webkit-mask-image:none;mask-image:none;}"];
  [@css
    ".css-142ybd1{-webkit-mask-image:linear-gradient(45deg, #333, #000);mask-image:linear-gradient(45deg, #333, #000);}"
  ];
  [@css
    ".css-1fwknk4{-webkit-mask-image:url(\"image.png\");mask-image:url(\"image.png\");}"
  ];
  [@css ".css-1ouxrtq{-webkit-mask-mode:alpha;mask-mode:alpha;}"];
  [@css ".css-kez79n{-webkit-mask-mode:luminance;mask-mode:luminance;}"];
  [@css ".css-u5u4nt{-webkit-mask-mode:match-source;mask-mode:match-source;}"];
  [@css ".css-4sx2wj{-webkit-mask-repeat:repeat-x;mask-repeat:repeat-x;}"];
  [@css ".css-1126cg9{-webkit-mask-repeat:repeat-y;mask-repeat:repeat-y;}"];
  [@css ".css-1m15f17{-webkit-mask-repeat:repeat;mask-repeat:repeat;}"];
  [@css ".css-1chgnbq{-webkit-mask-repeat:space;mask-repeat:space;}"];
  [@css ".css-mt45r{-webkit-mask-repeat:round;mask-repeat:round;}"];
  [@css ".css-11xtnvx{-webkit-mask-repeat:no-repeat;mask-repeat:no-repeat;}"];
  [@css
    ".css-afjxj5{-webkit-mask-repeat:repeat repeat;mask-repeat:repeat repeat;}"
  ];
  [@css
    ".css-1thzakc{-webkit-mask-repeat:space repeat;mask-repeat:space repeat;}"
  ];
  [@css
    ".css-ygqd9v{-webkit-mask-repeat:round repeat;mask-repeat:round repeat;}"
  ];
  [@css
    ".css-v6mccg{-webkit-mask-repeat:no-repeat repeat;mask-repeat:no-repeat repeat;}"
  ];
  [@css
    ".css-1pk842c{-webkit-mask-repeat:repeat space;mask-repeat:repeat space;}"
  ];
  [@css
    ".css-1rpe7q6{-webkit-mask-repeat:space space;mask-repeat:space space;}"
  ];
  [@css ".css-i5u5ug{-webkit-mask-repeat:round space;mask-repeat:round space;}"];
  [@css
    ".css-1djfut7{-webkit-mask-repeat:no-repeat space;mask-repeat:no-repeat space;}"
  ];
  [@css
    ".css-npnjer{-webkit-mask-repeat:repeat round;mask-repeat:repeat round;}"
  ];
  [@css
    ".css-1uiul50{-webkit-mask-repeat:space round;mask-repeat:space round;}"
  ];
  [@css
    ".css-1rokhdy{-webkit-mask-repeat:round round;mask-repeat:round round;}"
  ];
  [@css
    ".css-123y15l{-webkit-mask-repeat:no-repeat round;mask-repeat:no-repeat round;}"
  ];
  [@css
    ".css-jtm0rd{-webkit-mask-repeat:repeat no-repeat;mask-repeat:repeat no-repeat;}"
  ];
  [@css
    ".css-l6kg92{-webkit-mask-repeat:space no-repeat;mask-repeat:space no-repeat;}"
  ];
  [@css
    ".css-1lrnkdn{-webkit-mask-repeat:round no-repeat;mask-repeat:round no-repeat;}"
  ];
  [@css
    ".css-10urhgr{-webkit-mask-repeat:no-repeat no-repeat;mask-repeat:no-repeat no-repeat;}"
  ];
  [@css ".css-dftmqo{-webkit-mask-position:center;mask-position:center;}"];
  [@css
    ".css-1q6sxd6{-webkit-mask-position:center center;mask-position:center center;}"
  ];
  [@css ".css-11vnllr{-webkit-mask-position:left 50%;mask-position:left 50%;}"];
  [@css
    ".css-1abij05{-webkit-mask-position:bottom 10px right 20px;mask-position:bottom 10px right 20px;}"
  ];
  [@css
    ".css-ay05aq{-webkit-mask-position:1rem 1rem, center;mask-position:1rem 1rem, center;}"
  ];
  [@css ".css-1c5cvvy{-webkit-mask-clip:border-box;mask-clip:border-box;}"];
  [@css ".css-39bb9n{-webkit-mask-clip:padding-box;mask-clip:padding-box;}"];
  [@css ".css-b0opdz{-webkit-mask-clip:content-box;mask-clip:content-box;}"];
  [@css ".css-6jmamp{-webkit-mask-clip:margin-box;mask-clip:margin-box;}"];
  [@css ".css-1xqxf9o{-webkit-mask-clip:fill-box;mask-clip:fill-box;}"];
  [@css ".css-s1jrbf{-webkit-mask-clip:stroke-box;mask-clip:stroke-box;}"];
  [@css ".css-180ol9d{-webkit-mask-clip:view-box;mask-clip:view-box;}"];
  [@css ".css-16l5woh{-webkit-mask-clip:no-clip;mask-clip:no-clip;}"];
  [@css ".css-1roq1xb{-webkit-mask-origin:border-box;mask-origin:border-box;}"];
  [@css ".css-4ocarf{-webkit-mask-origin:padding-box;mask-origin:padding-box;}"];
  [@css ".css-ag56ga{-webkit-mask-origin:content-box;mask-origin:content-box;}"];
  [@css ".css-slf7xt{-webkit-mask-origin:margin-box;mask-origin:margin-box;}"];
  [@css ".css-1fpjetp{-webkit-mask-origin:fill-box;mask-origin:fill-box;}"];
  [@css ".css-tkxa0r{-webkit-mask-origin:stroke-box;mask-origin:stroke-box;}"];
  [@css ".css-1ic6771{-webkit-mask-origin:view-box;mask-origin:view-box;}"];
  [@css ".css-qgrmr6{-webkit-mask-size:auto;mask-size:auto;}"];
  [@css ".css-1uhzsly{-webkit-mask-size:10px;mask-size:10px;}"];
  [@css ".css-o4y9v6{-webkit-mask-size:cover;mask-size:cover;}"];
  [@css ".css-aei9fc{-webkit-mask-size:contain;mask-size:contain;}"];
  [@css ".css-duemq2{-webkit-mask-size:50%;mask-size:50%;}"];
  [@css ".css-1dw3ib8{-webkit-mask-size:10px auto;mask-size:10px auto;}"];
  [@css ".css-10fseyf{-webkit-mask-size:auto 10%;mask-size:auto 10%;}"];
  [@css ".css-2vb164{-webkit-mask-size:50em 50%;mask-size:50em 50%;}"];
  [@css ".css-l7gtig{-webkit-mask-composite:add;mask-composite:add;}"];
  [@css
    ".css-1mhfvh9{-webkit-mask-composite:subtract;mask-composite:subtract;}"
  ];
  [@css
    ".css-js7mnc{-webkit-mask-composite:intersect;mask-composite:intersect;}"
  ];
  [@css ".css-1mf4kge{-webkit-mask-composite:exclude;mask-composite:exclude;}"];
  [@css ".css-d7zsu7{-webkit-mask:top;mask:top;}"];
  [@css ".css-2102bl{-webkit-mask:space;mask:space;}"];
  [@css ".css-yycfqn{-webkit-mask:url(\"image.png\");mask:url(\"image.png\");}"];
  [@css
    ".css-1mfjb22{-webkit-mask:url(\"image.png\") luminance;mask:url(\"image.png\") luminance;}"
  ];
  [@css
    ".css-1i4w8uf{-webkit-mask:url(\"image.png\") luminance top space;mask:url(\"image.png\") luminance top space;}"
  ];
  [@css ".css-1vdatda{mask-border-source:none;}"];
  [@css ".css-1r3jsn7{mask-border-source:url(\"image.png\");}"];
  [@css ".css-19yxcfh{mask-border-slice:0 fill;}"];
  [@css ".css-176i9ki{mask-border-slice:50% fill;}"];
  [@css ".css-61fkvx{mask-border-slice:1.1 fill;}"];
  [@css ".css-1s19c61{mask-border-slice:0 1 fill;}"];
  [@css ".css-1h6fjww{mask-border-slice:0 1 2 fill;}"];
  [@css ".css-xbhrnl{mask-border-slice:0 1 2 3 fill;}"];
  [@css ".css-y82r40{mask-border-width:auto;}"];
  [@css ".css-ti3ntn{mask-border-width:10px;}"];
  [@css ".css-9kpt0n{mask-border-width:50%;}"];
  [@css ".css-3a5q3u{mask-border-width:1;}"];
  [@css ".css-m4zljy{mask-border-width:auto 1;}"];
  [@css ".css-jux06{mask-border-width:auto 1 50%;}"];
  [@css ".css-1cj5jzq{mask-border-width:auto 1 50% 1.1;}"];
  [@css ".css-rpcywh{mask-border-outset:0;}"];
  [@css ".css-w4kc7l{mask-border-outset:1.1;}"];
  [@css ".css-zmwu8c{mask-border-outset:0 1;}"];
  [@css ".css-p1rskq{mask-border-outset:0 1 2;}"];
  [@css ".css-ycmjvn{mask-border-outset:0 1 2 3;}"];
  [@css ".css-3lzvzp{mask-border-repeat:stretch;}"];
  [@css ".css-zvy6wn{mask-border-repeat:repeat;}"];
  [@css ".css-1qcfb7k{mask-border-repeat:round;}"];
  [@css ".css-d10v9e{mask-border-repeat:space;}"];
  [@css ".css-1apeab2{mask-border-repeat:stretch stretch;}"];
  [@css ".css-1jkitxu{mask-border-repeat:repeat stretch;}"];
  [@css ".css-nd263j{mask-border-repeat:round stretch;}"];
  [@css ".css-rkqzbx{mask-border-repeat:space stretch;}"];
  [@css ".css-unuc6c{mask-border-repeat:stretch repeat;}"];
  [@css ".css-1f2k6lp{mask-border-repeat:repeat repeat;}"];
  [@css ".css-wk7nxy{mask-border-repeat:round repeat;}"];
  [@css ".css-1uj57rz{mask-border-repeat:space repeat;}"];
  [@css ".css-1ymltoh{mask-border-repeat:stretch round;}"];
  [@css ".css-1gzu3mu{mask-border-repeat:repeat round;}"];
  [@css ".css-y742lf{mask-border-repeat:round round;}"];
  [@css ".css-ql4f45{mask-border-repeat:space round;}"];
  [@css ".css-10vxmjo{mask-border-repeat:stretch space;}"];
  [@css ".css-1wekxjm{mask-border-repeat:repeat space;}"];
  [@css ".css-gadwtf{mask-border-repeat:round space;}"];
  [@css ".css-14do9ro{mask-border-repeat:space space;}"];
  [@css ".css-ebjxmt{mask-border:url(\"image.png\");}"];
  [@css ".css-13xtemp{mask-type:luminance;}"];
  [@css ".css-16y6v58{mask-type:alpha;}"];
  [@css.classes
    [
      ("css-1gnxmyp", 0, "", "input.re", 1, 8, 1, 31),
      ("css-4h70ig", 1, "", "input.re", 2, 8, 2, 29),
      ("css-h38vw0", 2, "", "input.re", 3, 8, 3, 44),
      ("css-12svcf0", 3, "", "input.re", 4, 8, 4, 49),
      ("css-13tndnl", 4, "", "input.re", 5, 8, 5, 60),
      ("css-1i08xfu", 5, "", "input.re", 6, 8, 6, 60),
      ("css-16cpffv", 6, "", "input.re", 7, 8, 7, 29),
      ("css-u0l5cp", 7, "", "input.re", 8, 8, 8, 30),
      ("css-1xtwd5b", 8, "", "input.re", 9, 8, 9, 30),
      ("css-xb2hne", 9, "", "input.re", 10, 8, 10, 29),
      ("css-1dlxeng", 10, "", "input.re", 11, 8, 11, 27),
      ("css-ak5dak", 11, "", "input.re", 12, 8, 12, 29),
      ("css-sjfury", 12, "", "input.re", 13, 8, 13, 27),
      ("css-10en4kl", 13, "", "input.re", 14, 8, 14, 23),
      ("css-fyco4m", 14, "", "input.re", 15, 8, 15, 26),
      ("css-12y8brg", 15, "", "input.re", 16, 8, 16, 26),
      ("css-1uhqxnc", 16, "", "input.re", 17, 8, 17, 24),
      ("css-142ybd1", 17, "", "input.re", 18, 8, 18, 54),
      ("css-1fwknk4", 18, "", "input.re", 19, 8, 19, 34),
      ("css-1ouxrtq", 19, "", "input.re", 20, 8, 20, 24),
      ("css-kez79n", 20, "", "input.re", 21, 8, 21, 28),
      ("css-u5u4nt", 21, "", "input.re", 22, 8, 22, 31),
      ("css-4sx2wj", 22, "", "input.re", 23, 8, 23, 29),
      ("css-1126cg9", 23, "", "input.re", 24, 8, 24, 29),
      ("css-1m15f17", 24, "", "input.re", 25, 8, 25, 27),
      ("css-1chgnbq", 25, "", "input.re", 26, 8, 26, 26),
      ("css-mt45r", 26, "", "input.re", 27, 8, 27, 26),
      ("css-11xtnvx", 27, "", "input.re", 28, 8, 28, 30),
      ("css-afjxj5", 28, "", "input.re", 29, 8, 29, 34),
      ("css-1thzakc", 29, "", "input.re", 30, 8, 30, 33),
      ("css-ygqd9v", 30, "", "input.re", 31, 8, 31, 33),
      ("css-v6mccg", 31, "", "input.re", 32, 8, 32, 37),
      ("css-1pk842c", 32, "", "input.re", 33, 8, 33, 33),
      ("css-1rpe7q6", 33, "", "input.re", 34, 8, 34, 32),
      ("css-i5u5ug", 34, "", "input.re", 35, 8, 35, 32),
      ("css-1djfut7", 35, "", "input.re", 36, 8, 36, 36),
      ("css-npnjer", 36, "", "input.re", 37, 8, 37, 33),
      ("css-1uiul50", 37, "", "input.re", 38, 8, 38, 32),
      ("css-1rokhdy", 38, "", "input.re", 39, 8, 39, 32),
      ("css-123y15l", 39, "", "input.re", 40, 8, 40, 36),
      ("css-jtm0rd", 40, "", "input.re", 41, 8, 41, 37),
      ("css-l6kg92", 41, "", "input.re", 42, 8, 42, 36),
      ("css-1lrnkdn", 42, "", "input.re", 43, 8, 43, 36),
      ("css-10urhgr", 43, "", "input.re", 44, 8, 44, 40),
      ("css-dftmqo", 44, "", "input.re", 45, 8, 45, 29),
      ("css-1q6sxd6", 45, "", "input.re", 46, 8, 46, 36),
      ("css-11vnllr", 46, "", "input.re", 47, 8, 47, 31),
      ("css-1abij05", 47, "", "input.re", 48, 8, 48, 45),
      ("css-ay05aq", 48, "", "input.re", 49, 8, 49, 40),
      ("css-1c5cvvy", 49, "", "input.re", 50, 8, 50, 29),
      ("css-39bb9n", 50, "", "input.re", 51, 8, 51, 30),
      ("css-b0opdz", 51, "", "input.re", 52, 8, 52, 30),
      ("css-6jmamp", 52, "", "input.re", 53, 8, 53, 29),
      ("css-1xqxf9o", 53, "", "input.re", 54, 8, 54, 27),
      ("css-s1jrbf", 54, "", "input.re", 55, 8, 55, 29),
      ("css-180ol9d", 55, "", "input.re", 56, 8, 56, 27),
      ("css-16l5woh", 56, "", "input.re", 57, 8, 57, 26),
      ("css-1roq1xb", 57, "", "input.re", 58, 8, 58, 31),
      ("css-4ocarf", 58, "", "input.re", 59, 8, 59, 32),
      ("css-ag56ga", 59, "", "input.re", 60, 8, 60, 32),
      ("css-slf7xt", 60, "", "input.re", 61, 8, 61, 31),
      ("css-1fpjetp", 61, "", "input.re", 62, 8, 62, 29),
      ("css-tkxa0r", 62, "", "input.re", 63, 8, 63, 31),
      ("css-1ic6771", 63, "", "input.re", 64, 8, 64, 29),
      ("css-qgrmr6", 64, "", "input.re", 65, 8, 65, 23),
      ("css-1uhzsly", 65, "", "input.re", 66, 8, 66, 23),
      ("css-o4y9v6", 66, "", "input.re", 67, 8, 67, 24),
      ("css-aei9fc", 67, "", "input.re", 68, 8, 68, 26),
      ("css-duemq2", 68, "", "input.re", 70, 8, 70, 22),
      ("css-1dw3ib8", 69, "", "input.re", 71, 8, 71, 28),
      ("css-10fseyf", 70, "", "input.re", 72, 8, 72, 27),
      ("css-2vb164", 71, "", "input.re", 73, 8, 73, 27),
      ("css-l7gtig", 72, "", "input.re", 74, 8, 74, 27),
      ("css-1mhfvh9", 73, "", "input.re", 75, 8, 75, 32),
      ("css-js7mnc", 74, "", "input.re", 76, 8, 76, 33),
      ("css-1mf4kge", 75, "", "input.re", 77, 8, 77, 31),
      ("css-d7zsu7", 76, "", "input.re", 78, 8, 78, 17),
      ("css-2102bl", 77, "", "input.re", 79, 8, 79, 19),
      ("css-yycfqn", 78, "", "input.re", 80, 8, 80, 28),
      ("css-1mfjb22", 79, "", "input.re", 81, 8, 81, 38),
      ("css-1i4w8uf", 80, "", "input.re", 82, 8, 82, 48),
      ("css-1vdatda", 81, "", "input.re", 83, 8, 83, 32),
      ("css-1r3jsn7", 82, "", "input.re", 84, 8, 84, 42),
      ("css-19yxcfh", 83, "", "input.re", 85, 8, 85, 33),
      ("css-176i9ki", 84, "", "input.re", 86, 8, 86, 35),
      ("css-61fkvx", 85, "", "input.re", 87, 8, 87, 35),
      ("css-1s19c61", 86, "", "input.re", 88, 8, 88, 35),
      ("css-1h6fjww", 87, "", "input.re", 89, 8, 89, 37),
      ("css-xbhrnl", 88, "", "input.re", 90, 8, 90, 39),
      ("css-y82r40", 89, "", "input.re", 91, 8, 91, 31),
      ("css-ti3ntn", 90, "", "input.re", 92, 8, 92, 31),
      ("css-9kpt0n", 91, "", "input.re", 93, 8, 93, 30),
      ("css-3a5q3u", 92, "", "input.re", 94, 8, 94, 28),
      ("css-m4zljy", 93, "", "input.re", 96, 8, 96, 33),
      ("css-jux06", 94, "", "input.re", 97, 8, 97, 37),
      ("css-1cj5jzq", 95, "", "input.re", 98, 8, 98, 41),
      ("css-rpcywh", 96, "", "input.re", 99, 8, 99, 29),
      ("css-w4kc7l", 97, "", "input.re", 100, 8, 100, 31),
      ("css-zmwu8c", 98, "", "input.re", 101, 8, 101, 31),
      ("css-p1rskq", 99, "", "input.re", 102, 8, 102, 33),
      ("css-ycmjvn", 100, "", "input.re", 103, 8, 103, 35),
      ("css-3lzvzp", 101, "", "input.re", 104, 8, 104, 35),
      ("css-zvy6wn", 102, "", "input.re", 105, 8, 105, 34),
      ("css-1qcfb7k", 103, "", "input.re", 106, 8, 106, 33),
      ("css-d10v9e", 104, "", "input.re", 107, 8, 107, 33),
      ("css-1apeab2", 105, "", "input.re", 108, 8, 108, 43),
      ("css-1jkitxu", 106, "", "input.re", 109, 8, 109, 42),
      ("css-nd263j", 107, "", "input.re", 110, 8, 110, 41),
      ("css-rkqzbx", 108, "", "input.re", 111, 8, 111, 41),
      ("css-unuc6c", 109, "", "input.re", 112, 8, 112, 42),
      ("css-1f2k6lp", 110, "", "input.re", 113, 8, 113, 41),
      ("css-wk7nxy", 111, "", "input.re", 114, 8, 114, 40),
      ("css-1uj57rz", 112, "", "input.re", 115, 8, 115, 40),
      ("css-1ymltoh", 113, "", "input.re", 116, 8, 116, 41),
      ("css-1gzu3mu", 114, "", "input.re", 117, 8, 117, 40),
      ("css-y742lf", 115, "", "input.re", 118, 8, 118, 39),
      ("css-ql4f45", 116, "", "input.re", 119, 8, 119, 39),
      ("css-10vxmjo", 117, "", "input.re", 120, 8, 120, 41),
      ("css-1wekxjm", 118, "", "input.re", 121, 8, 121, 40),
      ("css-gadwtf", 119, "", "input.re", 122, 8, 122, 39),
      ("css-14do9ro", 120, "", "input.re", 123, 8, 123, 39),
      ("css-ebjxmt", 121, "", "input.re", 124, 8, 124, 35),
      ("css-13xtemp", 122, "", "input.re", 125, 8, 125, 28),
      ("css-16y6v58", 123, "", "input.re", 126, 8, 126, 24),
    ]
  ];
  CSS.make("css-1gnxmyp", []);
  CSS.make("css-4h70ig", []);
  CSS.make("css-h38vw0", []);
  CSS.make("css-12svcf0", []);
  CSS.make("css-13tndnl", []);
  CSS.make("css-1i08xfu", []);
  CSS.make("css-16cpffv", []);
  CSS.make("css-u0l5cp", []);
  CSS.make("css-1xtwd5b", []);
  CSS.make("css-xb2hne", []);
  CSS.make("css-1dlxeng", []);
  CSS.make("css-ak5dak", []);
  CSS.make("css-sjfury", []);
  CSS.make("css-10en4kl", []);
  CSS.make("css-fyco4m", []);
  CSS.make("css-12y8brg", []);
  CSS.make("css-1uhqxnc", []);
  CSS.make("css-142ybd1", []);
  CSS.make("css-1fwknk4", []);
  CSS.make("css-1ouxrtq", []);
  CSS.make("css-kez79n", []);
  CSS.make("css-u5u4nt", []);
  CSS.make("css-4sx2wj", []);
  CSS.make("css-1126cg9", []);
  CSS.make("css-1m15f17", []);
  CSS.make("css-1chgnbq", []);
  CSS.make("css-mt45r", []);
  CSS.make("css-11xtnvx", []);
  CSS.make("css-afjxj5", []);
  CSS.make("css-1thzakc", []);
  CSS.make("css-ygqd9v", []);
  CSS.make("css-v6mccg", []);
  CSS.make("css-1pk842c", []);
  CSS.make("css-1rpe7q6", []);
  CSS.make("css-i5u5ug", []);
  CSS.make("css-1djfut7", []);
  CSS.make("css-npnjer", []);
  CSS.make("css-1uiul50", []);
  CSS.make("css-1rokhdy", []);
  CSS.make("css-123y15l", []);
  CSS.make("css-jtm0rd", []);
  CSS.make("css-l6kg92", []);
  CSS.make("css-1lrnkdn", []);
  CSS.make("css-10urhgr", []);
  CSS.make("css-dftmqo", []);
  CSS.make("css-1q6sxd6", []);
  CSS.make("css-11vnllr", []);
  CSS.make("css-1abij05", []);
  CSS.make("css-ay05aq", []);
  CSS.make("css-1c5cvvy", []);
  CSS.make("css-39bb9n", []);
  CSS.make("css-b0opdz", []);
  CSS.make("css-6jmamp", []);
  CSS.make("css-1xqxf9o", []);
  CSS.make("css-s1jrbf", []);
  CSS.make("css-180ol9d", []);
  CSS.make("css-16l5woh", []);
  CSS.make("css-1roq1xb", []);
  CSS.make("css-4ocarf", []);
  CSS.make("css-ag56ga", []);
  CSS.make("css-slf7xt", []);
  CSS.make("css-1fpjetp", []);
  CSS.make("css-tkxa0r", []);
  CSS.make("css-1ic6771", []);
  CSS.make("css-qgrmr6", []);
  CSS.make("css-1uhzsly", []);
  CSS.make("css-o4y9v6", []);
  CSS.make("css-aei9fc", []);
  CSS.make("css-1uhzsly", []);
  CSS.make("css-duemq2", []);
  CSS.make("css-1dw3ib8", []);
  CSS.make("css-10fseyf", []);
  CSS.make("css-2vb164", []);
  CSS.make("css-l7gtig", []);
  CSS.make("css-1mhfvh9", []);
  CSS.make("css-js7mnc", []);
  CSS.make("css-1mf4kge", []);
  CSS.make("css-d7zsu7", []);
  CSS.make("css-2102bl", []);
  CSS.make("css-yycfqn", []);
  CSS.make("css-1mfjb22", []);
  CSS.make("css-1i4w8uf", []);
  CSS.make("css-1vdatda", []);
  CSS.make("css-1r3jsn7", []);
  CSS.make("css-19yxcfh", []);
  CSS.make("css-176i9ki", []);
  CSS.make("css-61fkvx", []);
  CSS.make("css-1s19c61", []);
  CSS.make("css-1h6fjww", []);
  CSS.make("css-xbhrnl", []);
  CSS.make("css-y82r40", []);
  CSS.make("css-ti3ntn", []);
  CSS.make("css-9kpt0n", []);
  CSS.make("css-3a5q3u", []);
  CSS.make("css-3a5q3u", []);
  CSS.make("css-m4zljy", []);
  CSS.make("css-jux06", []);
  CSS.make("css-1cj5jzq", []);
  CSS.make("css-rpcywh", []);
  CSS.make("css-w4kc7l", []);
  CSS.make("css-zmwu8c", []);
  CSS.make("css-p1rskq", []);
  CSS.make("css-ycmjvn", []);
  CSS.make("css-3lzvzp", []);
  CSS.make("css-zvy6wn", []);
  CSS.make("css-1qcfb7k", []);
  CSS.make("css-d10v9e", []);
  CSS.make("css-1apeab2", []);
  CSS.make("css-1jkitxu", []);
  CSS.make("css-nd263j", []);
  CSS.make("css-rkqzbx", []);
  CSS.make("css-unuc6c", []);
  CSS.make("css-1f2k6lp", []);
  CSS.make("css-wk7nxy", []);
  CSS.make("css-1uj57rz", []);
  CSS.make("css-1ymltoh", []);
  CSS.make("css-1gzu3mu", []);
  CSS.make("css-y742lf", []);
  CSS.make("css-ql4f45", []);
  CSS.make("css-10vxmjo", []);
  CSS.make("css-1wekxjm", []);
  CSS.make("css-gadwtf", []);
  CSS.make("css-14do9ro", []);
  CSS.make("css-ebjxmt", []);
  CSS.make("css-13xtemp", []);
  CSS.make("css-16y6v58", []);
