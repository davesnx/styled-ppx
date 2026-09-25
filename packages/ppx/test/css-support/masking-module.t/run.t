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
  [@css ".a-4ccpnl{-webkit-clip-path:url(\"#clip\");clip-path:url(\"#clip\");}"];
  [@css ".a-4cdshe{-webkit-clip-path:inset(50%);clip-path:inset(50%);}"];
  [@css
    ".a-4clbca{-webkit-clip-path:path(\"M 20 20 H 80 V 30\");clip-path:path(\"M 20 20 H 80 V 30\");}"
  ];
  [@css
    ".a-4c8b54{-webkit-clip-path:polygon(50% 100%, 0 0, 100% 0);clip-path:polygon(50% 100%, 0 0, 100% 0);}"
  ];
  [@css
    ".a-4cyasd{-webkit-clip-path:polygon(evenodd, 0% 0%, 50% 50%, 0% 100%);clip-path:polygon(evenodd, 0% 0%, 50% 50%, 0% 100%);}"
  ];
  [@css
    ".a-4cz3kz{-webkit-clip-path:polygon(nonzero, 0% 0%, 50% 50%, 0% 100%);clip-path:polygon(nonzero, 0% 0%, 50% 50%, 0% 100%);}"
  ];
  [@css ".a-4cq8iu{-webkit-clip-path:border-box;clip-path:border-box;}"];
  [@css ".a-4civbf{-webkit-clip-path:padding-box;clip-path:padding-box;}"];
  [@css ".a-4c4dpx{-webkit-clip-path:content-box;clip-path:content-box;}"];
  [@css ".a-4c8q0p{-webkit-clip-path:margin-box;clip-path:margin-box;}"];
  [@css ".a-4c3bw4{-webkit-clip-path:fill-box;clip-path:fill-box;}"];
  [@css ".a-4cww8a{-webkit-clip-path:stroke-box;clip-path:stroke-box;}"];
  [@css ".a-4civni{-webkit-clip-path:view-box;clip-path:view-box;}"];
  [@css ".a-4caqcy{-webkit-clip-path:none;clip-path:none;}"];
  [@css ".a-4dszcd{clip-rule:nonzero;}"];
  [@css ".a-4d6lnx{clip-rule:evenodd;}"];
  [@css ".a-7y074lv46{-webkit-mask-image:none;mask-image:none;}"];
  [@css
    ".a-7y074xpd6{-webkit-mask-image:linear-gradient(45deg, #333, #000);mask-image:linear-gradient(45deg, #333, #000);}"
  ];
  [@css
    ".a-7y074laft{-webkit-mask-image:url(\"image.png\");mask-image:url(\"image.png\");}"
  ];
  [@css ".a-7y0e8dp5t{-webkit-mask-mode:alpha;mask-mode:alpha;}"];
  [@css ".a-7y0e8htsi{-webkit-mask-mode:luminance;mask-mode:luminance;}"];
  [@css ".a-7y0e8qdqk{-webkit-mask-mode:match-source;mask-mode:match-source;}"];
  [@css ".a-7y35skdr1{-webkit-mask-repeat:repeat-x;mask-repeat:repeat-x;}"];
  [@css ".a-7y35s0g9h{-webkit-mask-repeat:repeat-y;mask-repeat:repeat-y;}"];
  [@css ".a-7y35s0wgz{-webkit-mask-repeat:repeat;mask-repeat:repeat;}"];
  [@css ".a-7y35sbi8s{-webkit-mask-repeat:space;mask-repeat:space;}"];
  [@css ".a-7y35s20fn{-webkit-mask-repeat:round;mask-repeat:round;}"];
  [@css ".a-7y35sawfw{-webkit-mask-repeat:no-repeat;mask-repeat:no-repeat;}"];
  [@css
    ".a-7y35ssx21{-webkit-mask-repeat:repeat repeat;mask-repeat:repeat repeat;}"
  ];
  [@css
    ".a-7y35s0fa9{-webkit-mask-repeat:space repeat;mask-repeat:space repeat;}"
  ];
  [@css
    ".a-7y35sjxaa{-webkit-mask-repeat:round repeat;mask-repeat:round repeat;}"
  ];
  [@css
    ".a-7y35s3pxt{-webkit-mask-repeat:no-repeat repeat;mask-repeat:no-repeat repeat;}"
  ];
  [@css
    ".a-7y35sn6bx{-webkit-mask-repeat:repeat space;mask-repeat:repeat space;}"
  ];
  [@css
    ".a-7y35sudfe{-webkit-mask-repeat:space space;mask-repeat:space space;}"
  ];
  [@css
    ".a-7y35s6z3w{-webkit-mask-repeat:round space;mask-repeat:round space;}"
  ];
  [@css
    ".a-7y35spthf{-webkit-mask-repeat:no-repeat space;mask-repeat:no-repeat space;}"
  ];
  [@css
    ".a-7y35s8b1s{-webkit-mask-repeat:repeat round;mask-repeat:repeat round;}"
  ];
  [@css
    ".a-7y35s6dy3{-webkit-mask-repeat:space round;mask-repeat:space round;}"
  ];
  [@css
    ".a-7y35s035m{-webkit-mask-repeat:round round;mask-repeat:round round;}"
  ];
  [@css
    ".a-7y35s1vap{-webkit-mask-repeat:no-repeat round;mask-repeat:no-repeat round;}"
  ];
  [@css
    ".a-7y35spu1u{-webkit-mask-repeat:repeat no-repeat;mask-repeat:repeat no-repeat;}"
  ];
  [@css
    ".a-7y35sa087{-webkit-mask-repeat:space no-repeat;mask-repeat:space no-repeat;}"
  ];
  [@css
    ".a-7y35st6kf{-webkit-mask-repeat:round no-repeat;mask-repeat:round no-repeat;}"
  ];
  [@css
    ".a-7y35sbql5{-webkit-mask-repeat:no-repeat no-repeat;mask-repeat:no-repeat no-repeat;}"
  ];
  [@css ".a-7y1kw9y42{-webkit-mask-position:center;mask-position:center;}"];
  [@css
    ".a-7y1kwck5z{-webkit-mask-position:center center;mask-position:center center;}"
  ];
  [@css ".a-7y1kwqk76{-webkit-mask-position:left 50%;mask-position:left 50%;}"];
  [@css
    ".a-7y1kwm1vo{-webkit-mask-position:bottom 10px right 20px;mask-position:bottom 10px right 20px;}"
  ];
  [@css
    ".a-7y1kw2gp6{-webkit-mask-position:1rem 1rem, center;mask-position:1rem 1rem, center;}"
  ];
  [@css ".a-7y01sj5or{-webkit-mask-clip:border-box;mask-clip:border-box;}"];
  [@css ".a-7y01s1q3a{-webkit-mask-clip:padding-box;mask-clip:padding-box;}"];
  [@css ".a-7y01sv6ku{-webkit-mask-clip:content-box;mask-clip:content-box;}"];
  [@css ".a-7y01s597p{-webkit-mask-clip:margin-box;mask-clip:margin-box;}"];
  [@css ".a-7y01say14{-webkit-mask-clip:fill-box;mask-clip:fill-box;}"];
  [@css ".a-7y01sj1e5{-webkit-mask-clip:stroke-box;mask-clip:stroke-box;}"];
  [@css ".a-7y01siy1a{-webkit-mask-clip:view-box;mask-clip:view-box;}"];
  [@css ".a-7y01sc5vo{-webkit-mask-clip:no-clip;mask-clip:no-clip;}"];
  [@css ".a-7y0sgjmd7{-webkit-mask-origin:border-box;mask-origin:border-box;}"];
  [@css
    ".a-7y0sg0f4k{-webkit-mask-origin:padding-box;mask-origin:padding-box;}"
  ];
  [@css
    ".a-7y0sgh4gk{-webkit-mask-origin:content-box;mask-origin:content-box;}"
  ];
  [@css ".a-7y0sg7k5t{-webkit-mask-origin:margin-box;mask-origin:margin-box;}"];
  [@css ".a-7y0sge45n{-webkit-mask-origin:fill-box;mask-origin:fill-box;}"];
  [@css ".a-7y0sg6p58{-webkit-mask-origin:stroke-box;mask-origin:stroke-box;}"];
  [@css ".a-7y0sg3jkb{-webkit-mask-origin:view-box;mask-origin:view-box;}"];
  [@css ".a-7y6bkqgoj{-webkit-mask-size:auto;mask-size:auto;}"];
  [@css ".a-7y6bkahf4{-webkit-mask-size:10px;mask-size:10px;}"];
  [@css ".a-7y6bkhzm2{-webkit-mask-size:cover;mask-size:cover;}"];
  [@css ".a-7y6bknp7r{-webkit-mask-size:contain;mask-size:contain;}"];
  [@css ".a-7y6bk0jbb{-webkit-mask-size:50%;mask-size:50%;}"];
  [@css ".a-7y6bk3cq7{-webkit-mask-size:10px auto;mask-size:10px auto;}"];
  [@css ".a-7y6bkieio{-webkit-mask-size:auto 10%;mask-size:auto 10%;}"];
  [@css ".a-7y6bk41vb{-webkit-mask-size:50em 50%;mask-size:50em 50%;}"];
  [@css ".a-7y03ktv7g{-webkit-mask-composite:add;mask-composite:add;}"];
  [@css
    ".a-7y03k75he{-webkit-mask-composite:subtract;mask-composite:subtract;}"
  ];
  [@css
    ".a-7y03khvhq{-webkit-mask-composite:intersect;mask-composite:intersect;}"
  ];
  [@css ".a-7y03k57xj{-webkit-mask-composite:exclude;mask-composite:exclude;}"];
  [@css ".a-7yf6ef{-webkit-mask:top;mask:top;}"];
  [@css ".a-7yyoaq{-webkit-mask:space;mask:space;}"];
  [@css ".a-7yk999{-webkit-mask:url(\"image.png\");mask:url(\"image.png\");}"];
  [@css
    ".a-7y1dmg{-webkit-mask:url(\"image.png\") luminance;mask:url(\"image.png\") luminance;}"
  ];
  [@css
    ".a-7y80ky{-webkit-mask:url(\"image.png\") luminance top space;mask:url(\"image.png\") luminance top space;}"
  ];
  [@css ".a-7y00gi8us{mask-border-source:none;}"];
  [@css ".a-7y00g7msv{mask-border-source:url(\"image.png\");}"];
  [@css ".a-7y0088jwz{mask-border-slice:0 fill;}"];
  [@css ".a-7y0083qse{mask-border-slice:50% fill;}"];
  [@css ".a-7y008wqe0{mask-border-slice:1.1 fill;}"];
  [@css ".a-7y008tc58{mask-border-slice:0 1 fill;}"];
  [@css ".a-7y008t8yr{mask-border-slice:0 1 2 fill;}"];
  [@css ".a-7y008rxuj{mask-border-slice:0 1 2 3 fill;}"];
  [@css ".a-7y00wnwbq{mask-border-width:auto;}"];
  [@css ".a-7y00wnkum{mask-border-width:10px;}"];
  [@css ".a-7y00w340c{mask-border-width:50%;}"];
  [@css ".a-7y00wquap{mask-border-width:1;}"];
  [@css ".a-7y00wwtrw{mask-border-width:auto 1;}"];
  [@css ".a-7y00w4i71{mask-border-width:auto 1 50%;}"];
  [@css ".a-7y00ww63w{mask-border-width:auto 1 50% 1.1;}"];
  [@css ".a-7y002btf2{mask-border-outset:0;}"];
  [@css ".a-7y002fzm0{mask-border-outset:1.1;}"];
  [@css ".a-7y002h5pa{mask-border-outset:0 1;}"];
  [@css ".a-7y002badx{mask-border-outset:0 1 2;}"];
  [@css ".a-7y002vur3{mask-border-outset:0 1 2 3;}"];
  [@css ".a-7y004vgr1{mask-border-repeat:stretch;}"];
  [@css ".a-7y004j3or{mask-border-repeat:repeat;}"];
  [@css ".a-7y00417r4{mask-border-repeat:round;}"];
  [@css ".a-7y004chn8{mask-border-repeat:space;}"];
  [@css ".a-7y004aifj{mask-border-repeat:stretch stretch;}"];
  [@css ".a-7y004iybl{mask-border-repeat:repeat stretch;}"];
  [@css ".a-7y004wbwc{mask-border-repeat:round stretch;}"];
  [@css ".a-7y004x2ld{mask-border-repeat:space stretch;}"];
  [@css ".a-7y004sdt0{mask-border-repeat:stretch repeat;}"];
  [@css ".a-7y004vjb8{mask-border-repeat:repeat repeat;}"];
  [@css ".a-7y004o22d{mask-border-repeat:round repeat;}"];
  [@css ".a-7y004qntc{mask-border-repeat:space repeat;}"];
  [@css ".a-7y004j4vd{mask-border-repeat:stretch round;}"];
  [@css ".a-7y004az9g{mask-border-repeat:repeat round;}"];
  [@css ".a-7y004m5lc{mask-border-repeat:round round;}"];
  [@css ".a-7y004zmh8{mask-border-repeat:space round;}"];
  [@css ".a-7y004fg8f{mask-border-repeat:stretch space;}"];
  [@css ".a-7y0048ni5{mask-border-repeat:repeat space;}"];
  [@css ".a-7y004fmsi{mask-border-repeat:round space;}"];
  [@css ".a-7y004i2sh{mask-border-repeat:space space;}"];
  [@css ".a-7y01r0miw{mask-border:url(\"image.png\");}"];
  [@css ".a-7zfx9l{mask-type:luminance;}"];
  [@css ".a-7z6il5{mask-type:alpha;}"];
  CSS.make("a-4ccpnl", []);
  CSS.make("a-4cdshe", []);
  CSS.make("a-4clbca", []);
  CSS.make("a-4c8b54", []);
  CSS.make("a-4cyasd", []);
  CSS.make("a-4cz3kz", []);
  CSS.make("a-4cq8iu", []);
  CSS.make("a-4civbf", []);
  CSS.make("a-4c4dpx", []);
  CSS.make("a-4c8q0p", []);
  CSS.make("a-4c3bw4", []);
  CSS.make("a-4cww8a", []);
  CSS.make("a-4civni", []);
  CSS.make("a-4caqcy", []);
  CSS.make("a-4dszcd", []);
  CSS.make("a-4d6lnx", []);
  CSS.make("a-7y074lv46", []);
  CSS.make("a-7y074xpd6", []);
  CSS.make("a-7y074laft", []);
  CSS.make("a-7y0e8dp5t", []);
  CSS.make("a-7y0e8htsi", []);
  CSS.make("a-7y0e8qdqk", []);
  CSS.make("a-7y35skdr1", []);
  CSS.make("a-7y35s0g9h", []);
  CSS.make("a-7y35s0wgz", []);
  CSS.make("a-7y35sbi8s", []);
  CSS.make("a-7y35s20fn", []);
  CSS.make("a-7y35sawfw", []);
  CSS.make("a-7y35ssx21", []);
  CSS.make("a-7y35s0fa9", []);
  CSS.make("a-7y35sjxaa", []);
  CSS.make("a-7y35s3pxt", []);
  CSS.make("a-7y35sn6bx", []);
  CSS.make("a-7y35sudfe", []);
  CSS.make("a-7y35s6z3w", []);
  CSS.make("a-7y35spthf", []);
  CSS.make("a-7y35s8b1s", []);
  CSS.make("a-7y35s6dy3", []);
  CSS.make("a-7y35s035m", []);
  CSS.make("a-7y35s1vap", []);
  CSS.make("a-7y35spu1u", []);
  CSS.make("a-7y35sa087", []);
  CSS.make("a-7y35st6kf", []);
  CSS.make("a-7y35sbql5", []);
  CSS.make("a-7y1kw9y42", []);
  CSS.make("a-7y1kwck5z", []);
  CSS.make("a-7y1kwqk76", []);
  CSS.make("a-7y1kwm1vo", []);
  CSS.make("a-7y1kw2gp6", []);
  CSS.make("a-7y01sj5or", []);
  CSS.make("a-7y01s1q3a", []);
  CSS.make("a-7y01sv6ku", []);
  CSS.make("a-7y01s597p", []);
  CSS.make("a-7y01say14", []);
  CSS.make("a-7y01sj1e5", []);
  CSS.make("a-7y01siy1a", []);
  CSS.make("a-7y01sc5vo", []);
  CSS.make("a-7y0sgjmd7", []);
  CSS.make("a-7y0sg0f4k", []);
  CSS.make("a-7y0sgh4gk", []);
  CSS.make("a-7y0sg7k5t", []);
  CSS.make("a-7y0sge45n", []);
  CSS.make("a-7y0sg6p58", []);
  CSS.make("a-7y0sg3jkb", []);
  CSS.make("a-7y6bkqgoj", []);
  CSS.make("a-7y6bkahf4", []);
  CSS.make("a-7y6bkhzm2", []);
  CSS.make("a-7y6bknp7r", []);
  CSS.make("a-7y6bkahf4", []);
  CSS.make("a-7y6bk0jbb", []);
  CSS.make("a-7y6bk3cq7", []);
  CSS.make("a-7y6bkieio", []);
  CSS.make("a-7y6bk41vb", []);
  CSS.make("a-7y03ktv7g", []);
  CSS.make("a-7y03k75he", []);
  CSS.make("a-7y03khvhq", []);
  CSS.make("a-7y03k57xj", []);
  CSS.make("a-7yf6ef", []);
  CSS.make("a-7yyoaq", []);
  CSS.make("a-7yk999", []);
  CSS.make("a-7y1dmg", []);
  CSS.make("a-7y80ky", []);
  CSS.make("a-7y00gi8us", []);
  CSS.make("a-7y00g7msv", []);
  CSS.make("a-7y0088jwz", []);
  CSS.make("a-7y0083qse", []);
  CSS.make("a-7y008wqe0", []);
  CSS.make("a-7y008tc58", []);
  CSS.make("a-7y008t8yr", []);
  CSS.make("a-7y008rxuj", []);
  CSS.make("a-7y00wnwbq", []);
  CSS.make("a-7y00wnkum", []);
  CSS.make("a-7y00w340c", []);
  CSS.make("a-7y00wquap", []);
  CSS.make("a-7y00wquap", []);
  CSS.make("a-7y00wwtrw", []);
  CSS.make("a-7y00w4i71", []);
  CSS.make("a-7y00ww63w", []);
  CSS.make("a-7y002btf2", []);
  CSS.make("a-7y002fzm0", []);
  CSS.make("a-7y002h5pa", []);
  CSS.make("a-7y002badx", []);
  CSS.make("a-7y002vur3", []);
  CSS.make("a-7y004vgr1", []);
  CSS.make("a-7y004j3or", []);
  CSS.make("a-7y00417r4", []);
  CSS.make("a-7y004chn8", []);
  CSS.make("a-7y004aifj", []);
  CSS.make("a-7y004iybl", []);
  CSS.make("a-7y004wbwc", []);
  CSS.make("a-7y004x2ld", []);
  CSS.make("a-7y004sdt0", []);
  CSS.make("a-7y004vjb8", []);
  CSS.make("a-7y004o22d", []);
  CSS.make("a-7y004qntc", []);
  CSS.make("a-7y004j4vd", []);
  CSS.make("a-7y004az9g", []);
  CSS.make("a-7y004m5lc", []);
  CSS.make("a-7y004zmh8", []);
  CSS.make("a-7y004fg8f", []);
  CSS.make("a-7y0048ni5", []);
  CSS.make("a-7y004fmsi", []);
  CSS.make("a-7y004i2sh", []);
  CSS.make("a-7y01r0miw", []);
  CSS.make("a-7zfx9l", []);
  CSS.make("a-7z6il5", []);
