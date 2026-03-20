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
    ".css-8mcpnl{clip-path:url(\"#clip\");}\n.css-182dshe{clip-path:inset(50%);}\n.css-1mglbca{clip-path:path(\"M 20 20 H 80 V 30\");}\n.css-1wl8b54{clip-path:polygon(50% 100%, 0 0, 100% 0);}\n.css-23yasd{clip-path:polygon(evenodd, 0% 0%, 50% 50%, 0% 100%);}\n.css-tyz3kz{clip-path:polygon(nonzero, 0% 0%, 50% 50%, 0% 100%);}\n.css-9wq8iu{clip-path:border-box;}\n.css-1pbivbf{clip-path:padding-box;}\n.css-n54dpx{clip-path:content-box;}\n.css-1up8q0p{clip-path:margin-box;}\n.css-12t3bw4{clip-path:fill-box;}\n.css-iuww8a{clip-path:stroke-box;}\n.css-115ivni{clip-path:view-box;}\n.css-1ivaqcy{clip-path:none;}\n.css-1snszcd{clip-rule:nonzero;}\n.css-1q46lnx{clip-rule:evenodd;}\n.css-130lv46{mask-image:none;}\n.css-191xpd6{mask-image:linear-gradient(45deg, #333, #000);}\n.css-dulaft{mask-image:url(\"image.png\");}\n.css-1avdp5t{mask-mode:alpha;}\n.css-1qwhtsi{mask-mode:luminance;}\n.css-nqdqk{mask-mode:match-source;}\n.css-12nkdr1{mask-repeat:repeat-x;}\n.css-1c10g9h{mask-repeat:repeat-y;}\n.css-5x0wgz{mask-repeat:repeat;}\n.css-ndbi8s{mask-repeat:space;}\n.css-l620fn{mask-repeat:round;}\n.css-71awfw{mask-repeat:no-repeat;}\n.css-cksx21{mask-repeat:repeat repeat;}\n.css-1lt0fa9{mask-repeat:space repeat;}\n.css-13mjxaa{mask-repeat:round repeat;}\n.css-1dt3pxt{mask-repeat:no-repeat repeat;}\n.css-1lgn6bx{mask-repeat:repeat space;}\n.css-1lkudfe{mask-repeat:space space;}\n.css-18j6z3w{mask-repeat:round space;}\n.css-dmpthf{mask-repeat:no-repeat space;}\n.css-gl8b1s{mask-repeat:repeat round;}\n.css-4c6dy3{mask-repeat:space round;}\n.css-dc035m{mask-repeat:round round;}\n.css-c51vap{mask-repeat:no-repeat round;}\n.css-sqpu1u{mask-repeat:repeat no-repeat;}\n.css-1kaa087{mask-repeat:space no-repeat;}\n.css-1gxt6kf{mask-repeat:round no-repeat;}\n.css-19obql5{mask-repeat:no-repeat no-repeat;}\n.css-1pe9y42{mask-position:center;}\n.css-1wjck5z{mask-position:center center;}\n.css-6vqk76{mask-position:left 50%;}\n.css-uam1vo{mask-position:bottom 10px right 20px;}\n.css-1z2gp6{mask-position:1rem 1rem, center;}\n.css-1xcj5or{mask-clip:border-box;}\n.css-1ib1q3a{mask-clip:padding-box;}\n.css-i7v6ku{mask-clip:content-box;}\n.css-1x5597p{mask-clip:margin-box;}\n.css-19iay14{mask-clip:fill-box;}\n.css-1eij1e5{mask-clip:stroke-box;}\n.css-16iy1a{mask-clip:view-box;}\n.css-1pcc5vo{mask-clip:no-clip;}\n.css-frjmd7{mask-origin:border-box;}\n.css-xm0f4k{mask-origin:padding-box;}\n.css-1gth4gk{mask-origin:content-box;}\n.css-1ik7k5t{mask-origin:margin-box;}\n.css-a9e45n{mask-origin:fill-box;}\n.css-4y6p58{mask-origin:stroke-box;}\n.css-9h3jkb{mask-origin:view-box;}\n.css-xgqgoj{mask-size:auto;}\n.css-14pahf4{mask-size:10px;}\n.css-1n4hzm2{mask-size:cover;}\n.css-v5np7r{mask-size:contain;}\n.css-ji0jbb{mask-size:50%;}\n.css-1wr3cq7{mask-size:10px auto;}\n.css-rpieio{mask-size:auto 10%;}\n.css-2y41vb{mask-size:50em 50%;}\n.css-32tv7g{mask-composite:add;}\n.css-s075he{mask-composite:subtract;}\n.css-10phvhq{mask-composite:intersect;}\n.css-1dn57xj{mask-composite:exclude;}\n.css-u6f6ef{mask:top;}\n.css-1w8yoaq{mask:space;}\n.css-cfk999{mask:url(\"image.png\");}\n.css-1f1dmg{mask:url(\"image.png\") luminance;}\n.css-co80ky{mask:url(\"image.png\") luminance top space;}\n.css-b1i8us{mask-border-source:none;}\n.css-au7msv{mask-border-source:url(\"image.png\");}\n.css-1i18jwz{mask-border-slice:0 fill;}\n.css-1gz3qse{mask-border-slice:50% fill;}\n.css-yxwqe0{mask-border-slice:1.1 fill;}\n.css-81tc58{mask-border-slice:0 1 fill;}\n.css-o9t8yr{mask-border-slice:0 1 2 fill;}\n.css-ibrxuj{mask-border-slice:0 1 2 3 fill;}\n.css-1gjnwbq{mask-border-width:auto;}\n.css-1bxnkum{mask-border-width:10px;}\n.css-1oj340c{mask-border-width:50%;}\n.css-xquap{mask-border-width:1;}\n.css-14gwtrw{mask-border-width:auto 1;}\n.css-1424i71{mask-border-width:auto 1 50%;}\n.css-1yaw63w{mask-border-width:auto 1 50% 1.1;}\n.css-snbtf2{mask-border-outset:0;}\n.css-18kfzm0{mask-border-outset:1.1;}\n.css-j8h5pa{mask-border-outset:0 1;}\n.css-11zbadx{mask-border-outset:0 1 2;}\n.css-j1vur3{mask-border-outset:0 1 2 3;}\n.css-1r8vgr1{mask-border-repeat:stretch;}\n.css-1x9j3or{mask-border-repeat:repeat;}\n.css-19q17r4{mask-border-repeat:round;}\n.css-1ucchn8{mask-border-repeat:space;}\n.css-14paifj{mask-border-repeat:stretch stretch;}\n.css-7kiybl{mask-border-repeat:repeat stretch;}\n.css-5zwbwc{mask-border-repeat:round stretch;}\n.css-b7x2ld{mask-border-repeat:space stretch;}\n.css-1x6sdt0{mask-border-repeat:stretch repeat;}\n.css-1s8vjb8{mask-border-repeat:repeat repeat;}\n.css-j7o22d{mask-border-repeat:round repeat;}\n.css-1vhqntc{mask-border-repeat:space repeat;}\n.css-1hbj4vd{mask-border-repeat:stretch round;}\n.css-56az9g{mask-border-repeat:repeat round;}\n.css-ram5lc{mask-border-repeat:round round;}\n.css-1o4zmh8{mask-border-repeat:space round;}\n.css-1qdfg8f{mask-border-repeat:stretch space;}\n.css-b98ni5{mask-border-repeat:repeat space;}\n.css-28fmsi{mask-border-repeat:round space;}\n.css-9xi2sh{mask-border-repeat:space space;}\n.css-hs0miw{mask-border:url(\"image.png\");}\n.css-nefx9l{mask-type:luminance;}\n.css-1l16il5{mask-type:alpha;}\n"
  ];
  CSS.make("css-8mcpnl", []);
  CSS.make("css-182dshe", []);
  CSS.make("css-1mglbca", []);
  CSS.make("css-1wl8b54", []);
  CSS.make("css-23yasd", []);
  CSS.make("css-tyz3kz", []);
  CSS.make("css-9wq8iu", []);
  CSS.make("css-1pbivbf", []);
  CSS.make("css-n54dpx", []);
  CSS.make("css-1up8q0p", []);
  CSS.make("css-12t3bw4", []);
  CSS.make("css-iuww8a", []);
  CSS.make("css-115ivni", []);
  CSS.make("css-1ivaqcy", []);
  CSS.make("css-1snszcd", []);
  CSS.make("css-1q46lnx", []);
  CSS.make("css-130lv46", []);
  CSS.make("css-191xpd6", []);
  CSS.make("css-dulaft", []);
  CSS.make("css-1avdp5t", []);
  CSS.make("css-1qwhtsi", []);
  CSS.make("css-nqdqk", []);
  CSS.make("css-12nkdr1", []);
  CSS.make("css-1c10g9h", []);
  CSS.make("css-5x0wgz", []);
  CSS.make("css-ndbi8s", []);
  CSS.make("css-l620fn", []);
  CSS.make("css-71awfw", []);
  CSS.make("css-cksx21", []);
  CSS.make("css-1lt0fa9", []);
  CSS.make("css-13mjxaa", []);
  CSS.make("css-1dt3pxt", []);
  CSS.make("css-1lgn6bx", []);
  CSS.make("css-1lkudfe", []);
  CSS.make("css-18j6z3w", []);
  CSS.make("css-dmpthf", []);
  CSS.make("css-gl8b1s", []);
  CSS.make("css-4c6dy3", []);
  CSS.make("css-dc035m", []);
  CSS.make("css-c51vap", []);
  CSS.make("css-sqpu1u", []);
  CSS.make("css-1kaa087", []);
  CSS.make("css-1gxt6kf", []);
  CSS.make("css-19obql5", []);
  CSS.make("css-1pe9y42", []);
  CSS.make("css-1wjck5z", []);
  CSS.make("css-6vqk76", []);
  CSS.make("css-uam1vo", []);
  CSS.make("css-1z2gp6", []);
  CSS.make("css-1xcj5or", []);
  CSS.make("css-1ib1q3a", []);
  CSS.make("css-i7v6ku", []);
  CSS.make("css-1x5597p", []);
  CSS.make("css-19iay14", []);
  CSS.make("css-1eij1e5", []);
  CSS.make("css-16iy1a", []);
  CSS.make("css-1pcc5vo", []);
  CSS.make("css-frjmd7", []);
  CSS.make("css-xm0f4k", []);
  CSS.make("css-1gth4gk", []);
  CSS.make("css-1ik7k5t", []);
  CSS.make("css-a9e45n", []);
  CSS.make("css-4y6p58", []);
  CSS.make("css-9h3jkb", []);
  CSS.make("css-xgqgoj", []);
  CSS.make("css-14pahf4", []);
  CSS.make("css-1n4hzm2", []);
  CSS.make("css-v5np7r", []);
  CSS.make("css-14pahf4", []);
  CSS.make("css-ji0jbb", []);
  CSS.make("css-1wr3cq7", []);
  CSS.make("css-rpieio", []);
  CSS.make("css-2y41vb", []);
  CSS.make("css-32tv7g", []);
  CSS.make("css-s075he", []);
  CSS.make("css-10phvhq", []);
  CSS.make("css-1dn57xj", []);
  CSS.make("css-u6f6ef", []);
  CSS.make("css-1w8yoaq", []);
  CSS.make("css-cfk999", []);
  CSS.make("css-1f1dmg", []);
  CSS.make("css-co80ky", []);
  CSS.make("css-b1i8us", []);
  CSS.make("css-au7msv", []);
  CSS.make("css-1i18jwz", []);
  CSS.make("css-1gz3qse", []);
  CSS.make("css-yxwqe0", []);
  CSS.make("css-81tc58", []);
  CSS.make("css-o9t8yr", []);
  CSS.make("css-ibrxuj", []);
  CSS.make("css-1gjnwbq", []);
  CSS.make("css-1bxnkum", []);
  CSS.make("css-1oj340c", []);
  CSS.make("css-xquap", []);
  CSS.make("css-xquap", []);
  CSS.make("css-14gwtrw", []);
  CSS.make("css-1424i71", []);
  CSS.make("css-1yaw63w", []);
  CSS.make("css-snbtf2", []);
  CSS.make("css-18kfzm0", []);
  CSS.make("css-j8h5pa", []);
  CSS.make("css-11zbadx", []);
  CSS.make("css-j1vur3", []);
  CSS.make("css-1r8vgr1", []);
  CSS.make("css-1x9j3or", []);
  CSS.make("css-19q17r4", []);
  CSS.make("css-1ucchn8", []);
  CSS.make("css-14paifj", []);
  CSS.make("css-7kiybl", []);
  CSS.make("css-5zwbwc", []);
  CSS.make("css-b7x2ld", []);
  CSS.make("css-1x6sdt0", []);
  CSS.make("css-1s8vjb8", []);
  CSS.make("css-j7o22d", []);
  CSS.make("css-1vhqntc", []);
  CSS.make("css-1hbj4vd", []);
  CSS.make("css-56az9g", []);
  CSS.make("css-ram5lc", []);
  CSS.make("css-1o4zmh8", []);
  CSS.make("css-1qdfg8f", []);
  CSS.make("css-b98ni5", []);
  CSS.make("css-28fmsi", []);
  CSS.make("css-9xi2sh", []);
  CSS.make("css-hs0miw", []);
  CSS.make("css-nefx9l", []);
  CSS.make("css-1l16il5", []);
