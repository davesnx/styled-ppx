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
  [@css ".a-8mcpnl{-webkit-clip-path:url(\"#clip\");clip-path:url(\"#clip\");}"];
  [@css ".a-182dshe{-webkit-clip-path:inset(50%);clip-path:inset(50%);}"];
  [@css
    ".a-1mglbca{-webkit-clip-path:path(\"M 20 20 H 80 V 30\");clip-path:path(\"M 20 20 H 80 V 30\");}"
  ];
  [@css
    ".a-1wl8b54{-webkit-clip-path:polygon(50% 100%, 0 0, 100% 0);clip-path:polygon(50% 100%, 0 0, 100% 0);}"
  ];
  [@css
    ".a-23yasd{-webkit-clip-path:polygon(evenodd, 0% 0%, 50% 50%, 0% 100%);clip-path:polygon(evenodd, 0% 0%, 50% 50%, 0% 100%);}"
  ];
  [@css
    ".a-tyz3kz{-webkit-clip-path:polygon(nonzero, 0% 0%, 50% 50%, 0% 100%);clip-path:polygon(nonzero, 0% 0%, 50% 50%, 0% 100%);}"
  ];
  [@css ".a-9wq8iu{-webkit-clip-path:border-box;clip-path:border-box;}"];
  [@css ".a-1pbivbf{-webkit-clip-path:padding-box;clip-path:padding-box;}"];
  [@css ".a-n54dpx{-webkit-clip-path:content-box;clip-path:content-box;}"];
  [@css ".a-1up8q0p{-webkit-clip-path:margin-box;clip-path:margin-box;}"];
  [@css ".a-12t3bw4{-webkit-clip-path:fill-box;clip-path:fill-box;}"];
  [@css ".a-iuww8a{-webkit-clip-path:stroke-box;clip-path:stroke-box;}"];
  [@css ".a-115ivni{-webkit-clip-path:view-box;clip-path:view-box;}"];
  [@css ".a-1ivaqcy{-webkit-clip-path:none;clip-path:none;}"];
  [@css ".a-1snszcd{clip-rule:nonzero;}"];
  [@css ".a-1q46lnx{clip-rule:evenodd;}"];
  [@css ".a-130lv46{-webkit-mask-image:none;mask-image:none;}"];
  [@css
    ".a-191xpd6{-webkit-mask-image:linear-gradient(45deg, #333, #000);mask-image:linear-gradient(45deg, #333, #000);}"
  ];
  [@css
    ".a-dulaft{-webkit-mask-image:url(\"image.png\");mask-image:url(\"image.png\");}"
  ];
  [@css ".a-1avdp5t{-webkit-mask-mode:alpha;mask-mode:alpha;}"];
  [@css ".a-1qwhtsi{-webkit-mask-mode:luminance;mask-mode:luminance;}"];
  [@css ".a-nqdqk{-webkit-mask-mode:match-source;mask-mode:match-source;}"];
  [@css ".a-12nkdr1{-webkit-mask-repeat:repeat-x;mask-repeat:repeat-x;}"];
  [@css ".a-1c10g9h{-webkit-mask-repeat:repeat-y;mask-repeat:repeat-y;}"];
  [@css ".a-5x0wgz{-webkit-mask-repeat:repeat;mask-repeat:repeat;}"];
  [@css ".a-ndbi8s{-webkit-mask-repeat:space;mask-repeat:space;}"];
  [@css ".a-l620fn{-webkit-mask-repeat:round;mask-repeat:round;}"];
  [@css ".a-71awfw{-webkit-mask-repeat:no-repeat;mask-repeat:no-repeat;}"];
  [@css
    ".a-cksx21{-webkit-mask-repeat:repeat repeat;mask-repeat:repeat repeat;}"
  ];
  [@css
    ".a-1lt0fa9{-webkit-mask-repeat:space repeat;mask-repeat:space repeat;}"
  ];
  [@css
    ".a-13mjxaa{-webkit-mask-repeat:round repeat;mask-repeat:round repeat;}"
  ];
  [@css
    ".a-1dt3pxt{-webkit-mask-repeat:no-repeat repeat;mask-repeat:no-repeat repeat;}"
  ];
  [@css
    ".a-1lgn6bx{-webkit-mask-repeat:repeat space;mask-repeat:repeat space;}"
  ];
  [@css ".a-1lkudfe{-webkit-mask-repeat:space space;mask-repeat:space space;}"];
  [@css ".a-18j6z3w{-webkit-mask-repeat:round space;mask-repeat:round space;}"];
  [@css
    ".a-dmpthf{-webkit-mask-repeat:no-repeat space;mask-repeat:no-repeat space;}"
  ];
  [@css ".a-gl8b1s{-webkit-mask-repeat:repeat round;mask-repeat:repeat round;}"];
  [@css ".a-4c6dy3{-webkit-mask-repeat:space round;mask-repeat:space round;}"];
  [@css ".a-dc035m{-webkit-mask-repeat:round round;mask-repeat:round round;}"];
  [@css
    ".a-c51vap{-webkit-mask-repeat:no-repeat round;mask-repeat:no-repeat round;}"
  ];
  [@css
    ".a-sqpu1u{-webkit-mask-repeat:repeat no-repeat;mask-repeat:repeat no-repeat;}"
  ];
  [@css
    ".a-1kaa087{-webkit-mask-repeat:space no-repeat;mask-repeat:space no-repeat;}"
  ];
  [@css
    ".a-1gxt6kf{-webkit-mask-repeat:round no-repeat;mask-repeat:round no-repeat;}"
  ];
  [@css
    ".a-19obql5{-webkit-mask-repeat:no-repeat no-repeat;mask-repeat:no-repeat no-repeat;}"
  ];
  [@css ".a-1pe9y42{-webkit-mask-position:center;mask-position:center;}"];
  [@css
    ".a-1wjck5z{-webkit-mask-position:center center;mask-position:center center;}"
  ];
  [@css ".a-6vqk76{-webkit-mask-position:left 50%;mask-position:left 50%;}"];
  [@css
    ".a-uam1vo{-webkit-mask-position:bottom 10px right 20px;mask-position:bottom 10px right 20px;}"
  ];
  [@css
    ".a-1z2gp6{-webkit-mask-position:1rem 1rem, center;mask-position:1rem 1rem, center;}"
  ];
  [@css ".a-1xcj5or{-webkit-mask-clip:border-box;mask-clip:border-box;}"];
  [@css ".a-1ib1q3a{-webkit-mask-clip:padding-box;mask-clip:padding-box;}"];
  [@css ".a-i7v6ku{-webkit-mask-clip:content-box;mask-clip:content-box;}"];
  [@css ".a-1x5597p{-webkit-mask-clip:margin-box;mask-clip:margin-box;}"];
  [@css ".a-19iay14{-webkit-mask-clip:fill-box;mask-clip:fill-box;}"];
  [@css ".a-1eij1e5{-webkit-mask-clip:stroke-box;mask-clip:stroke-box;}"];
  [@css ".a-16iy1a{-webkit-mask-clip:view-box;mask-clip:view-box;}"];
  [@css ".a-1pcc5vo{-webkit-mask-clip:no-clip;mask-clip:no-clip;}"];
  [@css ".a-frjmd7{-webkit-mask-origin:border-box;mask-origin:border-box;}"];
  [@css ".a-xm0f4k{-webkit-mask-origin:padding-box;mask-origin:padding-box;}"];
  [@css ".a-1gth4gk{-webkit-mask-origin:content-box;mask-origin:content-box;}"];
  [@css ".a-1ik7k5t{-webkit-mask-origin:margin-box;mask-origin:margin-box;}"];
  [@css ".a-a9e45n{-webkit-mask-origin:fill-box;mask-origin:fill-box;}"];
  [@css ".a-4y6p58{-webkit-mask-origin:stroke-box;mask-origin:stroke-box;}"];
  [@css ".a-9h3jkb{-webkit-mask-origin:view-box;mask-origin:view-box;}"];
  [@css ".a-xgqgoj{-webkit-mask-size:auto;mask-size:auto;}"];
  [@css ".a-14pahf4{-webkit-mask-size:10px;mask-size:10px;}"];
  [@css ".a-1n4hzm2{-webkit-mask-size:cover;mask-size:cover;}"];
  [@css ".a-v5np7r{-webkit-mask-size:contain;mask-size:contain;}"];
  [@css ".a-ji0jbb{-webkit-mask-size:50%;mask-size:50%;}"];
  [@css ".a-1wr3cq7{-webkit-mask-size:10px auto;mask-size:10px auto;}"];
  [@css ".a-rpieio{-webkit-mask-size:auto 10%;mask-size:auto 10%;}"];
  [@css ".a-2y41vb{-webkit-mask-size:50em 50%;mask-size:50em 50%;}"];
  [@css ".a-32tv7g{-webkit-mask-composite:add;mask-composite:add;}"];
  [@css ".a-s075he{-webkit-mask-composite:subtract;mask-composite:subtract;}"];
  [@css
    ".a-10phvhq{-webkit-mask-composite:intersect;mask-composite:intersect;}"
  ];
  [@css ".a-1dn57xj{-webkit-mask-composite:exclude;mask-composite:exclude;}"];
  [@css ".a-u6f6ef{-webkit-mask:top;mask:top;}"];
  [@css ".a-1w8yoaq{-webkit-mask:space;mask:space;}"];
  [@css ".a-cfk999{-webkit-mask:url(\"image.png\");mask:url(\"image.png\");}"];
  [@css
    ".a-1f1dmg{-webkit-mask:url(\"image.png\") luminance;mask:url(\"image.png\") luminance;}"
  ];
  [@css
    ".a-co80ky{-webkit-mask:url(\"image.png\") luminance top space;mask:url(\"image.png\") luminance top space;}"
  ];
  [@css ".a-b1i8us{mask-border-source:none;}"];
  [@css ".a-au7msv{mask-border-source:url(\"image.png\");}"];
  [@css ".a-1i18jwz{mask-border-slice:0 fill;}"];
  [@css ".a-1gz3qse{mask-border-slice:50% fill;}"];
  [@css ".a-yxwqe0{mask-border-slice:1.1 fill;}"];
  [@css ".a-81tc58{mask-border-slice:0 1 fill;}"];
  [@css ".a-o9t8yr{mask-border-slice:0 1 2 fill;}"];
  [@css ".a-ibrxuj{mask-border-slice:0 1 2 3 fill;}"];
  [@css ".a-1gjnwbq{mask-border-width:auto;}"];
  [@css ".a-1bxnkum{mask-border-width:10px;}"];
  [@css ".a-1oj340c{mask-border-width:50%;}"];
  [@css ".a-xquap{mask-border-width:1;}"];
  [@css ".a-14gwtrw{mask-border-width:auto 1;}"];
  [@css ".a-1424i71{mask-border-width:auto 1 50%;}"];
  [@css ".a-1yaw63w{mask-border-width:auto 1 50% 1.1;}"];
  [@css ".a-snbtf2{mask-border-outset:0;}"];
  [@css ".a-18kfzm0{mask-border-outset:1.1;}"];
  [@css ".a-j8h5pa{mask-border-outset:0 1;}"];
  [@css ".a-11zbadx{mask-border-outset:0 1 2;}"];
  [@css ".a-j1vur3{mask-border-outset:0 1 2 3;}"];
  [@css ".a-1r8vgr1{mask-border-repeat:stretch;}"];
  [@css ".a-1x9j3or{mask-border-repeat:repeat;}"];
  [@css ".a-19q17r4{mask-border-repeat:round;}"];
  [@css ".a-1ucchn8{mask-border-repeat:space;}"];
  [@css ".a-14paifj{mask-border-repeat:stretch stretch;}"];
  [@css ".a-7kiybl{mask-border-repeat:repeat stretch;}"];
  [@css ".a-5zwbwc{mask-border-repeat:round stretch;}"];
  [@css ".a-b7x2ld{mask-border-repeat:space stretch;}"];
  [@css ".a-1x6sdt0{mask-border-repeat:stretch repeat;}"];
  [@css ".a-1s8vjb8{mask-border-repeat:repeat repeat;}"];
  [@css ".a-j7o22d{mask-border-repeat:round repeat;}"];
  [@css ".a-1vhqntc{mask-border-repeat:space repeat;}"];
  [@css ".a-1hbj4vd{mask-border-repeat:stretch round;}"];
  [@css ".a-56az9g{mask-border-repeat:repeat round;}"];
  [@css ".a-ram5lc{mask-border-repeat:round round;}"];
  [@css ".a-1o4zmh8{mask-border-repeat:space round;}"];
  [@css ".a-1qdfg8f{mask-border-repeat:stretch space;}"];
  [@css ".a-b98ni5{mask-border-repeat:repeat space;}"];
  [@css ".a-28fmsi{mask-border-repeat:round space;}"];
  [@css ".a-9xi2sh{mask-border-repeat:space space;}"];
  [@css ".a-hs0miw{mask-border:url(\"image.png\");}"];
  [@css ".a-nefx9l{mask-type:luminance;}"];
  [@css ".a-1l16il5{mask-type:alpha;}"];
  CSS.make("a-8mcpnl", []);
  CSS.make("a-182dshe", []);
  CSS.make("a-1mglbca", []);
  CSS.make("a-1wl8b54", []);
  CSS.make("a-23yasd", []);
  CSS.make("a-tyz3kz", []);
  CSS.make("a-9wq8iu", []);
  CSS.make("a-1pbivbf", []);
  CSS.make("a-n54dpx", []);
  CSS.make("a-1up8q0p", []);
  CSS.make("a-12t3bw4", []);
  CSS.make("a-iuww8a", []);
  CSS.make("a-115ivni", []);
  CSS.make("a-1ivaqcy", []);
  CSS.make("a-1snszcd", []);
  CSS.make("a-1q46lnx", []);
  CSS.make("a-130lv46", []);
  CSS.make("a-191xpd6", []);
  CSS.make("a-dulaft", []);
  CSS.make("a-1avdp5t", []);
  CSS.make("a-1qwhtsi", []);
  CSS.make("a-nqdqk", []);
  CSS.make("a-12nkdr1", []);
  CSS.make("a-1c10g9h", []);
  CSS.make("a-5x0wgz", []);
  CSS.make("a-ndbi8s", []);
  CSS.make("a-l620fn", []);
  CSS.make("a-71awfw", []);
  CSS.make("a-cksx21", []);
  CSS.make("a-1lt0fa9", []);
  CSS.make("a-13mjxaa", []);
  CSS.make("a-1dt3pxt", []);
  CSS.make("a-1lgn6bx", []);
  CSS.make("a-1lkudfe", []);
  CSS.make("a-18j6z3w", []);
  CSS.make("a-dmpthf", []);
  CSS.make("a-gl8b1s", []);
  CSS.make("a-4c6dy3", []);
  CSS.make("a-dc035m", []);
  CSS.make("a-c51vap", []);
  CSS.make("a-sqpu1u", []);
  CSS.make("a-1kaa087", []);
  CSS.make("a-1gxt6kf", []);
  CSS.make("a-19obql5", []);
  CSS.make("a-1pe9y42", []);
  CSS.make("a-1wjck5z", []);
  CSS.make("a-6vqk76", []);
  CSS.make("a-uam1vo", []);
  CSS.make("a-1z2gp6", []);
  CSS.make("a-1xcj5or", []);
  CSS.make("a-1ib1q3a", []);
  CSS.make("a-i7v6ku", []);
  CSS.make("a-1x5597p", []);
  CSS.make("a-19iay14", []);
  CSS.make("a-1eij1e5", []);
  CSS.make("a-16iy1a", []);
  CSS.make("a-1pcc5vo", []);
  CSS.make("a-frjmd7", []);
  CSS.make("a-xm0f4k", []);
  CSS.make("a-1gth4gk", []);
  CSS.make("a-1ik7k5t", []);
  CSS.make("a-a9e45n", []);
  CSS.make("a-4y6p58", []);
  CSS.make("a-9h3jkb", []);
  CSS.make("a-xgqgoj", []);
  CSS.make("a-14pahf4", []);
  CSS.make("a-1n4hzm2", []);
  CSS.make("a-v5np7r", []);
  CSS.make("a-14pahf4", []);
  CSS.make("a-ji0jbb", []);
  CSS.make("a-1wr3cq7", []);
  CSS.make("a-rpieio", []);
  CSS.make("a-2y41vb", []);
  CSS.make("a-32tv7g", []);
  CSS.make("a-s075he", []);
  CSS.make("a-10phvhq", []);
  CSS.make("a-1dn57xj", []);
  CSS.make("a-u6f6ef", []);
  CSS.make("a-1w8yoaq", []);
  CSS.make("a-cfk999", []);
  CSS.make("a-1f1dmg", []);
  CSS.make("a-co80ky", []);
  CSS.make("a-b1i8us", []);
  CSS.make("a-au7msv", []);
  CSS.make("a-1i18jwz", []);
  CSS.make("a-1gz3qse", []);
  CSS.make("a-yxwqe0", []);
  CSS.make("a-81tc58", []);
  CSS.make("a-o9t8yr", []);
  CSS.make("a-ibrxuj", []);
  CSS.make("a-1gjnwbq", []);
  CSS.make("a-1bxnkum", []);
  CSS.make("a-1oj340c", []);
  CSS.make("a-xquap", []);
  CSS.make("a-xquap", []);
  CSS.make("a-14gwtrw", []);
  CSS.make("a-1424i71", []);
  CSS.make("a-1yaw63w", []);
  CSS.make("a-snbtf2", []);
  CSS.make("a-18kfzm0", []);
  CSS.make("a-j8h5pa", []);
  CSS.make("a-11zbadx", []);
  CSS.make("a-j1vur3", []);
  CSS.make("a-1r8vgr1", []);
  CSS.make("a-1x9j3or", []);
  CSS.make("a-19q17r4", []);
  CSS.make("a-1ucchn8", []);
  CSS.make("a-14paifj", []);
  CSS.make("a-7kiybl", []);
  CSS.make("a-5zwbwc", []);
  CSS.make("a-b7x2ld", []);
  CSS.make("a-1x6sdt0", []);
  CSS.make("a-1s8vjb8", []);
  CSS.make("a-j7o22d", []);
  CSS.make("a-1vhqntc", []);
  CSS.make("a-1hbj4vd", []);
  CSS.make("a-56az9g", []);
  CSS.make("a-ram5lc", []);
  CSS.make("a-1o4zmh8", []);
  CSS.make("a-1qdfg8f", []);
  CSS.make("a-b98ni5", []);
  CSS.make("a-28fmsi", []);
  CSS.make("a-9xi2sh", []);
  CSS.make("a-hs0miw", []);
  CSS.make("a-nefx9l", []);
  CSS.make("a-1l16il5", []);
