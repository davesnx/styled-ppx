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
  [@css "@property --elevation1-xawwdw_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation1-xawwdw_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation1-xawwdw_3{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-vcr1i_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-vcr1i_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-vcr1i_3{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-pys9ag_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-pys9ag_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-pys9ag_3{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-pys9ag_4{syntax:\"*\";inherits:false;}"];
  [@css "@property --boxDark-17ffdav{syntax:\"*\";inherits:false;}"];
  [@css ".a-1eddbzm{background-repeat:space;}"];
  [@css ".a-kbwgys{background-repeat:round;}"];
  [@css ".a-yppiw6{background-repeat:repeat repeat;}"];
  [@css ".a-sxxji5{background-repeat:space repeat;}"];
  [@css ".a-km0kx7{background-repeat:round repeat;}"];
  [@css ".a-kiqiir{background-repeat:no-repeat repeat;}"];
  [@css ".a-7bff62{background-repeat:repeat space;}"];
  [@css ".a-11glrh1{background-repeat:space space;}"];
  [@css ".a-1mczuyd{background-repeat:round space;}"];
  [@css ".a-c7o3tu{background-repeat:no-repeat space;}"];
  [@css ".a-422l1t{background-repeat:repeat round;}"];
  [@css ".a-1qgpz8i{background-repeat:space round;}"];
  [@css ".a-1gtvp4f{background-repeat:round round;}"];
  [@css ".a-zcttlz{background-repeat:no-repeat round;}"];
  [@css ".a-j95y1{background-repeat:repeat no-repeat;}"];
  [@css ".a-e3yae4{background-repeat:space no-repeat;}"];
  [@css ".a-hghx0d{background-repeat:round no-repeat;}"];
  [@css ".a-rfr6kt{background-repeat:no-repeat no-repeat;}"];
  [@css ".a-1kobp5t{background-repeat:repeat-x, repeat-y;}"];
  [@css ".a-wfp2j1{background-attachment:local;}"];
  [@css
    ".a-1h94kwg{-webkit-background-clip:border-box;background-clip:border-box;}"
  ];
  [@css
    ".a-1ie5w5o{-webkit-background-clip:padding-box;background-clip:padding-box;}"
  ];
  [@css
    ".a-15p50rv{-webkit-background-clip:content-box;background-clip:content-box;}"
  ];
  [@css ".a-1mb8734{-webkit-background-clip:text;background-clip:text;}"];
  [@css
    ".a-pm5rmj{-webkit-background-clip:border-area;background-clip:border-area;}"
  ];
  [@css
    ".a-11w45y6{-webkit-background-clip:text, border-area;background-clip:text, border-area;}"
  ];
  [@css ".a-1eckwyo{background-origin:border-box;}"];
  [@css ".a-1k5r9hb{background-origin:padding-box;}"];
  [@css ".a-1agwo89{background-origin:content-box;}"];
  [@css ".a-w64aob{background-size:auto;}"];
  [@css ".a-1d5k97u{background-size:cover;}"];
  [@css ".a-okxylo{background-size:contain;}"];
  [@css ".a-b7m5qu{background-size:10px;}"];
  [@css ".a-1obu6v3{background-size:50%;}"];
  [@css ".a-1brxytx{background-size:10px auto;}"];
  [@css ".a-1x9a9zh{background-size:auto 10%;}"];
  [@css ".a-1wp4rix{background-size:50em 50%;}"];
  [@css ".a-gwzw1h{background-size:20px 20px;}"];
  [@css ".a-1vuo254{background:top left / 50% 60%;}"];
  [@css ".a-1jwvagn{background:border-box;}"];
  [@css ".a-ky2d75{background:blue;}"];
  [@css ".a-1h2hvrj{background:border-box red;}"];
  [@css ".a-phlssi{background:border-box padding-box;}"];
  [@css
    ".a-2uuq7y{background:url(\"foo.png\") bottom right / cover padding-box content-box;}"
  ];
  [@css ".a-h1ffk7{border-top-left-radius:0;}"];
  [@css ".a-1eky41g{border-top-left-radius:50%;}"];
  [@css ".a-1yeccvj{border-top-left-radius:250px 100px;}"];
  [@css ".a-1kgozmz{border-top-right-radius:0;}"];
  [@css ".a-1ugh6x9{border-top-right-radius:50%;}"];
  [@css ".a-bm0ho1{border-top-right-radius:250px 100px;}"];
  [@css ".a-17dm6su{border-bottom-right-radius:0;}"];
  [@css ".a-1o25ugq{border-bottom-right-radius:50%;}"];
  [@css ".a-7x8l07{border-bottom-right-radius:250px 100px;}"];
  [@css ".a-156vopp{border-bottom-left-radius:0;}"];
  [@css ".a-anz4ix{border-bottom-left-radius:50%;}"];
  [@css ".a-1ufj6a{border-bottom-left-radius:250px 100px;}"];
  [@css ".a-qqv389{border-radius:10px;}"];
  [@css ".a-uodor8{border-radius:50%;}"];
  [@css ".a-2ook9k{border-radius:2px 4px;}"];
  [@css ".a-i1l4dm{border-radius:2px 4px 8px;}"];
  [@css ".a-xubni5{border-radius:2px 4px 8px 16px;}"];
  [@css ".a-6wk2xe{border-radius:10px / 20px;}"];
  [@css ".a-11z5w7s{border-radius:2px 4px 8px 16px / 2px 4px 8px 16px;}"];
  [@css ".a-p167n4{border-image-source:none;}"];
  [@css ".a-u2djw{border-image-source:url(\"foo.png\");}"];
  [@css ".a-11v8fag{border-image-slice:10;}"];
  [@css ".a-osou03{border-image-slice:30%;}"];
  [@css ".a-1iop0ma{border-image-slice:10 10;}"];
  [@css ".a-1iblsp{border-image-slice:30% 10;}"];
  [@css ".a-2a5gxt{border-image-slice:10 30%;}"];
  [@css ".a-ropwt3{border-image-slice:30% 30%;}"];
  [@css ".a-j0g3fs{border-image-slice:10 10 10;}"];
  [@css ".a-1l1b146{border-image-slice:30% 10 10;}"];
  [@css ".a-xkyk9k{border-image-slice:10 30% 10;}"];
  [@css ".a-2pdy38{border-image-slice:30% 30% 10;}"];
  [@css ".a-12bfa9m{border-image-slice:10 10 30%;}"];
  [@css ".a-paz16p{border-image-slice:30% 10 30%;}"];
  [@css ".a-wt8zfs{border-image-slice:10 30% 30%;}"];
  [@css ".a-1k7uel6{border-image-slice:30% 30% 30%;}"];
  [@css ".a-8m27b9{border-image-slice:10 10 10 10;}"];
  [@css ".a-6tciru{border-image-slice:30% 10 10 10;}"];
  [@css ".a-1uoj984{border-image-slice:10 30% 10 10;}"];
  [@css ".a-1lpeygg{border-image-slice:30% 30% 10 10;}"];
  [@css ".a-1iku8vs{border-image-slice:10 10 30% 10;}"];
  [@css ".a-15q4ctj{border-image-slice:30% 10 30% 10;}"];
  [@css ".a-c2rqu8{border-image-slice:10 30% 30% 10;}"];
  [@css ".a-12o535k{border-image-slice:30% 30% 30% 10;}"];
  [@css ".a-tymqly{border-image-slice:10 10 10 30%;}"];
  [@css ".a-1rg334v{border-image-slice:30% 10 10 30%;}"];
  [@css ".a-xh10it{border-image-slice:10 30% 10 30%;}"];
  [@css ".a-5t24bv{border-image-slice:30% 30% 10 30%;}"];
  [@css ".a-15noopq{border-image-slice:10 10 30% 30%;}"];
  [@css ".a-1okc6k6{border-image-slice:30% 10 30% 30%;}"];
  [@css ".a-pmce7t{border-image-slice:10 30% 30% 30%;}"];
  [@css ".a-1773xq3{border-image-slice:30% 30% 30% 30%;}"];
  [@css ".a-1xipp7o{border-image-slice:fill 30%;}"];
  [@css ".a-vrsoql{border-image-slice:fill 10;}"];
  [@css ".a-18qljby{border-image-slice:fill 2 4 8% 16%;}"];
  [@css ".a-1vnb5be{border-image-slice:30% fill;}"];
  [@css ".a-1s1se3r{border-image-slice:10 fill;}"];
  [@css ".a-1mnst01{border-image-slice:2 4 8% 16% fill;}"];
  [@css ".a-11smtq7{border-image-width:10px;}"];
  [@css ".a-c62lna{border-image-width:5%;}"];
  [@css ".a-xmvskx{border-image-width:28;}"];
  [@css ".a-ch12to{border-image-width:auto;}"];
  [@css ".a-yhqzt3{border-image-width:10px 10px;}"];
  [@css ".a-ya1b9l{border-image-width:5% 10px;}"];
  [@css ".a-8xa5d6{border-image-width:28 10px;}"];
  [@css ".a-1o9gsb5{border-image-width:auto 10px;}"];
  [@css ".a-1sqtfkm{border-image-width:10px 5%;}"];
  [@css ".a-1xafrk8{border-image-width:5% 5%;}"];
  [@css ".a-fvsgtx{border-image-width:28 5%;}"];
  [@css ".a-5io8wy{border-image-width:auto 5%;}"];
  [@css ".a-eyyjgi{border-image-width:10px 28;}"];
  [@css ".a-vp05n6{border-image-width:5% 28;}"];
  [@css ".a-1o7pian{border-image-width:28 28;}"];
  [@css ".a-1d47o1w{border-image-width:auto 28;}"];
  [@css ".a-3bbki1{border-image-width:10px auto;}"];
  [@css ".a-vwsfme{border-image-width:5% auto;}"];
  [@css ".a-drlhmj{border-image-width:28 auto;}"];
  [@css ".a-ttiwnw{border-image-width:auto auto;}"];
  [@css ".a-k81i6r{border-image-width:10px 10% 10;}"];
  [@css ".a-6b03j7{border-image-width:5% 10px 20 auto;}"];
  [@css ".a-1u3lw5x{border-image-outset:10px;}"];
  [@css ".a-b6x2bn{border-image-outset:20;}"];
  [@css ".a-1gxjka5{border-image-outset:10px 20;}"];
  [@css ".a-rkv07i{border-image-outset:10px 20px;}"];
  [@css ".a-vrixn9{border-image-outset:20 30;}"];
  [@css ".a-9d3q5z{border-image-outset:2px 3px 4;}"];
  [@css ".a-16tdhma{border-image-outset:1 2px 3px 4;}"];
  [@css ".a-et8amr{border-image-repeat:stretch;}"];
  [@css ".a-1vpvfhi{border-image-repeat:repeat;}"];
  [@css ".a-1jssbb7{border-image-repeat:round;}"];
  [@css ".a-17kfada{border-image-repeat:space;}"];
  [@css ".a-1rv930f{border-image-repeat:stretch stretch;}"];
  [@css ".a-34ipsj{border-image-repeat:repeat stretch;}"];
  [@css ".a-120h3hn{border-image-repeat:round stretch;}"];
  [@css ".a-1v3d92{border-image-repeat:space stretch;}"];
  [@css ".a-1195f3q{border-image-repeat:stretch repeat;}"];
  [@css ".a-vjdrj5{border-image-repeat:repeat repeat;}"];
  [@css ".a-1ih6kfj{border-image-repeat:round repeat;}"];
  [@css ".a-1gnahlj{border-image-repeat:space repeat;}"];
  [@css ".a-n4d86l{border-image-repeat:stretch round;}"];
  [@css ".a-11u5ktc{border-image-repeat:repeat round;}"];
  [@css ".a-13kllwt{border-image-repeat:round round;}"];
  [@css ".a-h4eu9k{border-image-repeat:space round;}"];
  [@css ".a-y3orbo{border-image-repeat:stretch space;}"];
  [@css ".a-yvcpic{border-image-repeat:repeat space;}"];
  [@css ".a-1vw2bpm{border-image-repeat:round space;}"];
  [@css ".a-1a8iv0g{border-image-repeat:space space;}"];
  [@css ".a-13sl0e3{border-image:url(\"foo.png\") 10;}"];
  [@css ".a-17cc16s{border-image:url(\"foo.png\") 10%;}"];
  [@css ".a-slk48c{border-image:url(\"foo.png\") 10% fill;}"];
  [@css ".a-lnndfl{border-image:url(\"foo.png\") 10 round;}"];
  [@css ".a-bloh1n{border-image:url(\"foo.png\") 10 stretch repeat;}"];
  [@css ".a-h8vdj4{border-image:url(\"foo.png\") 10 / 10px;}"];
  [@css ".a-1oqx17x{border-image:url(\"foo.png\") 10 / 10% / 10px;}"];
  [@css ".a-35zcfy{border-image:url(\"foo.png\") fill 10 / 10% / 10px;}"];
  [@css ".a-1oe30nn{border-image:url(\"foo.png\") fill 10 / 10% / 10px space;}"];
  [@css ".a-gokeqi{box-shadow:none;}"];
  [@css ".a-3sye8k{box-shadow:1px 1px;}"];
  [@css ".a-i2r8u1{box-shadow:0 0 black;}"];
  [@css ".a-1r1uemi{box-shadow:1px 2px 3px;}"];
  [@css ".a-1wumflx{box-shadow:1px 2px 3px black;}"];
  [@css ".a-13956p9{box-shadow:1px 2px 3px 4px;}"];
  [@css ".a-dvxcnx{box-shadow:1px 2px 3px 4px black;}"];
  [@css ".a-1scios5{box-shadow:inset 1px 1px;}"];
  [@css ".a-1qf5tpn{box-shadow:inset 0 0 black;}"];
  [@css ".a-1r7izzs{box-shadow:inset 1px 2px 3px;}"];
  [@css ".a-19gyjsg{box-shadow:inset 1px 2px 3px black;}"];
  [@css ".a-z4khnb{box-shadow:inset 1px 2px 3px 4px;}"];
  [@css ".a-1jw3f6l{box-shadow:inset 1px 2px 3px 4px black;}"];
  [@css
    ".a-yqotsx{box-shadow:inset 1px 2px 3px 4px black, 1px 2px 3px 4px black;}"
  ];
  [@css ".a-ce85p6{box-shadow:1px 1px, inset 2px 2px red;}"];
  [@css ".a-1q5q314{box-shadow:0 0 5px, inset 0 0 10px black;}"];
  [@css
    ".in-1cg0xa4{box-shadow:-1px 1px 0px 0px var(--elevation1-xawwdw_1), 1px 1px 0px 0px var(--elevation1-xawwdw_2), 0px -1px 0px 0px var(--elevation1-xawwdw_3);}"
  ];
  [@css ".a-1jv2nfr{background-position-x:right;}"];
  [@css ".a-1fivq06{background-position-x:center;}"];
  [@css ".a-hxcezg{background-position-x:50%;}"];
  [@css ".a-11xe8x4{background-position-x:left, left;}"];
  [@css ".a-g4em91{background-position-x:left, right;}"];
  [@css ".a-1v9h4p{background-position-x:right, left;}"];
  [@css ".a-1ytz26j{background-position-x:left, 0%;}"];
  [@css ".a-a7bcib{background-position-x:10%, 20%, 40%;}"];
  [@css ".a-f8ehso{background-position-x:0px;}"];
  [@css ".a-n3vpvo{background-position-x:30px;}"];
  [@css ".a-1lsjlye{background-position-x:0%, 10%, 20%, 30%;}"];
  [@css ".a-1r6uvjq{background-position-x:left, left, left, left, left;}"];
  [@css ".a-14w1f37{background-position-x:calc(20px);}"];
  [@css ".a-lz1ldt{background-position-x:calc(20px + 1em);}"];
  [@css ".a-99w4iu{background-position-x:calc(20px / 2);}"];
  [@css ".a-1sok1yt{background-position-x:calc(20px + 50%);}"];
  [@css ".a-16z363d{background-position-x:calc(50% - 10px);}"];
  [@css ".a-13x78wf{background-position-x:calc(-20px);}"];
  [@css ".a-1lryx3{background-position-x:calc(-50%);}"];
  [@css ".a-55be59{background-position-x:calc(-20%);}"];
  [@css ".a-1p57w9s{background-position-x:right 20px;}"];
  [@css ".a-o38n01{background-position-x:left 20px;}"];
  [@css ".a-18df6oz{background-position-x:right -50px;}"];
  [@css ".a-ckata8{background-position-x:left -50px;}"];
  [@css ".a-7bxup1{background-position-y:bottom;}"];
  [@css ".a-1it9ewh{background-position-y:center;}"];
  [@css ".a-wahsum{background-position-y:50%;}"];
  [@css ".a-2u04xu{background-position-y:top, top;}"];
  [@css ".a-19mqqtz{background-position-y:top, bottom;}"];
  [@css ".a-13w54xk{background-position-y:bottom, top;}"];
  [@css ".a-1c7d2k{background-position-y:top, 0%;}"];
  [@css ".a-m293ok{background-position-y:10%, 20%, 40%;}"];
  [@css ".a-1gbcs51{background-position-y:0px;}"];
  [@css ".a-1it2wtl{background-position-y:30px;}"];
  [@css ".a-rgd3sd{background-position-y:0%, 10%, 20%, 30%;}"];
  [@css ".a-jdfv8k{background-position-y:top, top, top, top, top;}"];
  [@css ".a-1xo2yw6{background-position-y:calc(20px);}"];
  [@css ".a-nnpdqz{background-position-y:calc(20px + 1em);}"];
  [@css ".a-1ey8w9h{background-position-y:calc(20px / 2);}"];
  [@css ".a-1azkkb2{background-position-y:calc(20px + 50%);}"];
  [@css ".a-uedt8x{background-position-y:calc(50% - 10px);}"];
  [@css ".a-d5c0ip{background-position-y:calc(-20px);}"];
  [@css ".a-p4ckm0{background-position-y:calc(-50%);}"];
  [@css ".a-1xyw002{background-position-y:calc(-20%);}"];
  [@css ".a-70z8v2{background-position-y:bottom 20px;}"];
  [@css ".a-1x42qfz{background-position-y:top 20px;}"];
  [@css ".a-esmhad{background-position-y:bottom -50px;}"];
  [@css ".a-1uc0o43{background-position-y:top -50px;}"];
  [@css ".a-1iwhz2r{background-image:linear-gradient(45deg, blue, red);}"];
  [@css
    ".a-1kbqfjp{background-image:linear-gradient(90deg, blue 10%, red 20%);}"
  ];
  [@css ".a-14mab29{background-image:linear-gradient(90deg, blue 10%, red);}"];
  [@css ".a-1yq1u4d{background-image:linear-gradient(90deg, blue, 10%, red);}"];
  [@css ".a-zcuss4{background-image:linear-gradient(white, black);}"];
  [@css ".a-orn2r8{background-image:linear-gradient(to right, white, black);}"];
  [@css ".a-9mys2x{background-image:linear-gradient(45deg, white, black);}"];
  [@css ".a-snojtb{background-image:linear-gradient(white 50%, black);}"];
  [@css ".a-bw0xs1{background-image:linear-gradient(white, #f06, black);}"];
  [@css
    ".a-1hvyimv{background-image:linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);}"
  ];
  [@css
    ".a-e4fmes{background-image:linear-gradient(45deg, blue, red), linear-gradient(red -50px, white calc(-25px + 50%), blue 100%), linear-gradient(45deg, blue, red);}"
  ];
  [@css
    ".in-1vt38s1{background-image:linear-gradient(45deg, var(--color-vcr1i_1) 25%, transparent 0%, transparent 50%, var(--color-vcr1i_2) 0%, var(--color-vcr1i_3) 75%, transparent 0%, transparent 100% );}"
  ];
  [@css
    ".in-1q2tv7y{background-image:repeating-linear-gradient( 45deg, var(--color-pys9ag_1) 0px, var(--color-pys9ag_2) 4px, var(--color-pys9ag_3) 5px, var(--color-pys9ag_4) 9px );}"
  ];
  [@css
    ".in-1mgigxz{background-image:linear-gradient(45deg, var(--boxDark-17ffdav) 25%, transparent 25%), linear-gradient(red -50px, white calc(-25px + 50%), blue 100%), linear-gradient(45deg, blue, red);}"
  ];
  [@css ".a-1y1fodl{background-image:radial-gradient(white, black);}"];
  [@css ".a-1bm5i1d{background-image:radial-gradient(circle, white, black);}"];
  [@css ".a-1c5rni{background-image:radial-gradient(ellipse, white, black);}"];
  [@css
    ".a-binqg5{background-image:radial-gradient(circle closest-corner, white, black);}"
  ];
  [@css
    ".a-frdzbz{background-image:radial-gradient(farthest-side, white, black);}"
  ];
  [@css
    ".a-1p01b7p{background-image:radial-gradient(circle farthest-side, white, black);}"
  ];
  [@css ".a-1sffl0e{background-image:radial-gradient(50%, white, black);}"];
  [@css ".a-e75uiv{background-image:radial-gradient(60% 60%, white, black);}"];
  [@css ".a-1xwird3{list-style-image:linear-gradient(white, black);}"];
  [@css ".a-lyeq2u{list-style-image:linear-gradient(to right, white, black);}"];
  [@css ".a-1c77x4a{list-style-image:linear-gradient(45deg, white, black);}"];
  [@css ".a-20kxhc{list-style-image:linear-gradient(white 50%, black);}"];
  [@css ".a-14r74rj{list-style-image:linear-gradient(white 5px, black);}"];
  [@css ".a-a5c0fc{list-style-image:linear-gradient(white, #f06, black);}"];
  [@css ".a-jpualz{list-style-image:linear-gradient(currentColor, black);}"];
  [@css
    ".a-1s68cv6{list-style-image:linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);}"
  ];
  [@css ".a-1dt7vp0{list-style-image:radial-gradient(white, black);}"];
  [@css ".a-zdkg5x{list-style-image:radial-gradient(circle, white, black);}"];
  [@css ".a-a242dq{list-style-image:radial-gradient(ellipse, white, black);}"];
  [@css
    ".a-icouy8{list-style-image:radial-gradient(closest-corner, white, black);}"
  ];
  [@css
    ".a-14vzi1j{list-style-image:radial-gradient(circle closest-corner, white, black);}"
  ];
  [@css
    ".a-14ibp18{list-style-image:radial-gradient(farthest-side, white, black);}"
  ];
  [@css
    ".a-pnbl3b{list-style-image:radial-gradient(circle farthest-side, white, black);}"
  ];
  [@css ".a-3m0ihr{list-style-image:radial-gradient(50%, white, black);}"];
  [@css ".a-w08tou{list-style-image:radial-gradient(60% 60%, white, black);}"];
  [@css ".a-11tobub{image-rendering:auto;}"];
  [@css ".a-1hc7xqd{image-rendering:smooth;}"];
  [@css ".a-but5e9{image-rendering:high-quality;}"];
  [@css ".a-fjhmlf{image-rendering:pixelated;}"];
  [@css ".a-1e7m01f{image-rendering:crisp-edges;}"];
  [@css ".a-1jvylgn{background-position:bottom;}"];
  [@css ".a-1oiniqy{background-position-y:0;}"];
  [@css ".a-121ueyu{background-position:0 0;}"];
  [@css ".a-yq3hnb{background-position:1rem 0;}"];
  [@css ".a-1rldqt2{background-position:bottom 10px right;}"];
  [@css ".a-24z38j{background-position:bottom 10px right 20px;}"];
  [@css ".a-1h2n9c9{background-position:0 0, center;}"];
  [@css ".a-1czqhry{object-position:top;}"];
  [@css ".a-18au2x3{object-position:bottom;}"];
  [@css ".a-eex73u{object-position:left;}"];
  [@css ".a-xicm6t{object-position:right;}"];
  [@css ".a-1xolpb4{object-position:center;}"];
  [@css ".a-1aih0g1{object-position:25% 75%;}"];
  [@css ".a-1whlnwd{object-position:25%;}"];
  [@css ".a-1iq0ddq{object-position:0 0;}"];
  [@css ".a-1dwopaa{object-position:1cm 2cm;}"];
  [@css ".a-13renxt{object-position:10ch 8em;}"];
  [@css ".a-1qease9{object-position:bottom 10px right 20px;}"];
  [@css ".a-m3ana2{object-position:right 3em bottom 10px;}"];
  [@css ".a-1us11ag{object-position:top 0 right 10px;}"];
  [@css ".a-plhhjc{object-position:inherit;}"];
  [@css ".a-13qj4w6{object-position:initial;}"];
  [@css ".a-286ns1{object-position:revert;}"];
  [@css ".a-jujpx4{object-position:revert-layer;}"];
  [@css ".a-b54k9o{object-position:unset;}"];
  [@css
    "@keyframes k-1b5h4ts{0%{background-position:0 0;}100%{background-position:1rem 0;}}"
  ];
  module Color = {
    module Background = {
      let boxDark = `hex("000000");
    };
    module Shadow = {
      let elevation1 = `rgba((0, 0, 0, `num(0.03)));
    };
  };
  
  CSS.make("a-1eddbzm", []);
  CSS.make("a-kbwgys", []);
  CSS.make("a-yppiw6", []);
  CSS.make("a-sxxji5", []);
  CSS.make("a-km0kx7", []);
  CSS.make("a-kiqiir", []);
  CSS.make("a-7bff62", []);
  CSS.make("a-11glrh1", []);
  CSS.make("a-1mczuyd", []);
  CSS.make("a-c7o3tu", []);
  CSS.make("a-422l1t", []);
  CSS.make("a-1qgpz8i", []);
  CSS.make("a-1gtvp4f", []);
  CSS.make("a-zcttlz", []);
  CSS.make("a-j95y1", []);
  CSS.make("a-e3yae4", []);
  CSS.make("a-hghx0d", []);
  CSS.make("a-rfr6kt", []);
  CSS.make("a-1kobp5t", []);
  CSS.make("a-wfp2j1", []);
  CSS.make("a-1h94kwg", []);
  CSS.make("a-1ie5w5o", []);
  CSS.make("a-15p50rv", []);
  CSS.make("a-1mb8734", []);
  CSS.make("a-pm5rmj", []);
  CSS.make("a-11w45y6", []);
  CSS.make("a-1eckwyo", []);
  CSS.make("a-1k5r9hb", []);
  CSS.make("a-1agwo89", []);
  CSS.make("a-w64aob", []);
  CSS.make("a-1d5k97u", []);
  CSS.make("a-okxylo", []);
  CSS.make("a-b7m5qu", []);
  CSS.make("a-1obu6v3", []);
  CSS.make("a-1brxytx", []);
  CSS.make("a-1x9a9zh", []);
  CSS.make("a-1wp4rix", []);
  CSS.make("a-gwzw1h", []);
  
  CSS.make("a-1vuo254", []);
  CSS.make("a-1jwvagn", []);
  CSS.make("a-ky2d75", []);
  CSS.make("a-1h2hvrj", []);
  
  CSS.make("a-phlssi", []);
  CSS.make("a-2uuq7y", []);
  CSS.make("a-h1ffk7", []);
  CSS.make("a-1eky41g", []);
  CSS.make("a-1yeccvj", []);
  CSS.make("a-1kgozmz", []);
  CSS.make("a-1ugh6x9", []);
  CSS.make("a-bm0ho1", []);
  CSS.make("a-17dm6su", []);
  CSS.make("a-1o25ugq", []);
  CSS.make("a-7x8l07", []);
  CSS.make("a-156vopp", []);
  CSS.make("a-anz4ix", []);
  CSS.make("a-1ufj6a", []);
  CSS.make("a-qqv389", []);
  CSS.make("a-uodor8", []);
  CSS.make("a-2ook9k", []);
  CSS.make("a-i1l4dm", []);
  CSS.make("a-xubni5", []);
  CSS.make("a-6wk2xe", []);
  CSS.make("a-11z5w7s", []);
  CSS.make("a-p167n4", []);
  CSS.make("a-u2djw", []);
  CSS.make("a-11v8fag", []);
  CSS.make("a-osou03", []);
  CSS.make("a-1iop0ma", []);
  CSS.make("a-1iblsp", []);
  CSS.make("a-2a5gxt", []);
  CSS.make("a-ropwt3", []);
  CSS.make("a-j0g3fs", []);
  CSS.make("a-1l1b146", []);
  CSS.make("a-xkyk9k", []);
  CSS.make("a-2pdy38", []);
  CSS.make("a-12bfa9m", []);
  CSS.make("a-paz16p", []);
  CSS.make("a-wt8zfs", []);
  CSS.make("a-1k7uel6", []);
  CSS.make("a-8m27b9", []);
  CSS.make("a-6tciru", []);
  CSS.make("a-1uoj984", []);
  CSS.make("a-1lpeygg", []);
  CSS.make("a-1iku8vs", []);
  CSS.make("a-15q4ctj", []);
  CSS.make("a-c2rqu8", []);
  CSS.make("a-12o535k", []);
  CSS.make("a-tymqly", []);
  CSS.make("a-1rg334v", []);
  CSS.make("a-xh10it", []);
  CSS.make("a-5t24bv", []);
  CSS.make("a-15noopq", []);
  CSS.make("a-1okc6k6", []);
  CSS.make("a-pmce7t", []);
  CSS.make("a-1773xq3", []);
  CSS.make("a-1xipp7o", []);
  CSS.make("a-vrsoql", []);
  CSS.make("a-18qljby", []);
  CSS.make("a-1vnb5be", []);
  CSS.make("a-1s1se3r", []);
  CSS.make("a-1mnst01", []);
  CSS.make("a-11smtq7", []);
  CSS.make("a-c62lna", []);
  CSS.make("a-xmvskx", []);
  CSS.make("a-ch12to", []);
  CSS.make("a-yhqzt3", []);
  CSS.make("a-ya1b9l", []);
  CSS.make("a-8xa5d6", []);
  CSS.make("a-1o9gsb5", []);
  CSS.make("a-1sqtfkm", []);
  CSS.make("a-1xafrk8", []);
  CSS.make("a-fvsgtx", []);
  CSS.make("a-5io8wy", []);
  CSS.make("a-eyyjgi", []);
  CSS.make("a-vp05n6", []);
  CSS.make("a-1o7pian", []);
  CSS.make("a-1d47o1w", []);
  CSS.make("a-3bbki1", []);
  CSS.make("a-vwsfme", []);
  CSS.make("a-drlhmj", []);
  CSS.make("a-ttiwnw", []);
  CSS.make("a-k81i6r", []);
  CSS.make("a-6b03j7", []);
  CSS.make("a-1u3lw5x", []);
  CSS.make("a-b6x2bn", []);
  CSS.make("a-1gxjka5", []);
  CSS.make("a-rkv07i", []);
  CSS.make("a-vrixn9", []);
  CSS.make("a-9d3q5z", []);
  CSS.make("a-16tdhma", []);
  CSS.make("a-et8amr", []);
  CSS.make("a-1vpvfhi", []);
  CSS.make("a-1jssbb7", []);
  CSS.make("a-17kfada", []);
  CSS.make("a-1rv930f", []);
  CSS.make("a-34ipsj", []);
  CSS.make("a-120h3hn", []);
  CSS.make("a-1v3d92", []);
  CSS.make("a-1195f3q", []);
  CSS.make("a-vjdrj5", []);
  CSS.make("a-1ih6kfj", []);
  CSS.make("a-1gnahlj", []);
  CSS.make("a-n4d86l", []);
  CSS.make("a-11u5ktc", []);
  CSS.make("a-13kllwt", []);
  CSS.make("a-h4eu9k", []);
  CSS.make("a-y3orbo", []);
  CSS.make("a-yvcpic", []);
  CSS.make("a-1vw2bpm", []);
  CSS.make("a-1a8iv0g", []);
  CSS.make("a-13sl0e3", []);
  CSS.make("a-17cc16s", []);
  CSS.make("a-slk48c", []);
  CSS.make("a-lnndfl", []);
  CSS.make("a-bloh1n", []);
  CSS.make("a-h8vdj4", []);
  CSS.make("a-1oqx17x", []);
  CSS.make("a-35zcfy", []);
  CSS.make("a-1oe30nn", []);
  
  CSS.make("a-gokeqi", []);
  
  CSS.make("a-3sye8k", []);
  
  CSS.make("a-i2r8u1", []);
  
  CSS.make("a-1r1uemi", []);
  
  CSS.make("a-1wumflx", []);
  
  CSS.make("a-13956p9", []);
  
  CSS.make("a-dvxcnx", []);
  
  CSS.make("a-1scios5", []);
  
  CSS.make("a-1qf5tpn", []);
  
  CSS.make("a-1r7izzs", []);
  
  CSS.make("a-19gyjsg", []);
  
  CSS.make("a-z4khnb", []);
  
  CSS.make("a-1jw3f6l", []);
  
  CSS.make("a-yqotsx", []);
  CSS.make("a-ce85p6", []);
  CSS.make("a-1q5q314", []);
  CSS.make(
    "in-1cg0xa4",
    [
      (
        "--elevation1-xawwdw_1",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
      (
        "--elevation1-xawwdw_2",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
      (
        "--elevation1-xawwdw_3",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
    ],
  );
  
  CSS.make("a-1jv2nfr", []);
  CSS.make("a-1fivq06", []);
  CSS.make("a-hxcezg", []);
  CSS.make("a-11xe8x4", []);
  CSS.make("a-g4em91", []);
  CSS.make("a-1v9h4p", []);
  CSS.make("a-1ytz26j", []);
  CSS.make("a-a7bcib", []);
  CSS.make("a-f8ehso", []);
  CSS.make("a-n3vpvo", []);
  CSS.make("a-1lsjlye", []);
  CSS.make("a-1r6uvjq", []);
  CSS.make("a-14w1f37", []);
  CSS.make("a-lz1ldt", []);
  CSS.make("a-99w4iu", []);
  CSS.make("a-1sok1yt", []);
  CSS.make("a-16z363d", []);
  CSS.make("a-13x78wf", []);
  CSS.make("a-1lryx3", []);
  CSS.make("a-55be59", []);
  CSS.make("a-1p57w9s", []);
  CSS.make("a-o38n01", []);
  CSS.make("a-18df6oz", []);
  CSS.make("a-ckata8", []);
  CSS.make("a-1p57w9s", []);
  CSS.make("a-7bxup1", []);
  CSS.make("a-1it9ewh", []);
  CSS.make("a-wahsum", []);
  CSS.make("a-2u04xu", []);
  CSS.make("a-19mqqtz", []);
  CSS.make("a-13w54xk", []);
  CSS.make("a-1c7d2k", []);
  CSS.make("a-m293ok", []);
  CSS.make("a-1gbcs51", []);
  CSS.make("a-1it2wtl", []);
  CSS.make("a-rgd3sd", []);
  CSS.make("a-jdfv8k", []);
  CSS.make("a-1xo2yw6", []);
  CSS.make("a-nnpdqz", []);
  CSS.make("a-1ey8w9h", []);
  CSS.make("a-1azkkb2", []);
  CSS.make("a-uedt8x", []);
  CSS.make("a-d5c0ip", []);
  CSS.make("a-p4ckm0", []);
  CSS.make("a-1xyw002", []);
  CSS.make("a-70z8v2", []);
  CSS.make("a-1x42qfz", []);
  CSS.make("a-esmhad", []);
  CSS.make("a-1uc0o43", []);
  CSS.make("a-70z8v2", []);
  
  CSS.make("a-1iwhz2r", []);
  CSS.make("a-1kbqfjp", []);
  CSS.make("a-14mab29", []);
  CSS.make("a-1yq1u4d", []);
  CSS.make("a-zcuss4", []);
  CSS.make("a-orn2r8", []);
  CSS.make("a-9mys2x", []);
  CSS.make("a-snojtb", []);
  CSS.make("a-bw0xs1", []);
  CSS.make("a-1hvyimv", []);
  CSS.make("a-e4fmes", []);
  let color = `hex("333");
  CSS.make(
    "in-1vt38s1",
    [
      ("--color-vcr1i_1", CSS.Types.Color.toString(color)),
      ("--color-vcr1i_2", CSS.Types.Color.toString(color)),
      ("--color-vcr1i_3", CSS.Types.Color.toString(color)),
    ],
  );
  CSS.make(
    "in-1q2tv7y",
    [
      ("--color-pys9ag_1", CSS.Types.Color.toString(color)),
      ("--color-pys9ag_2", CSS.Types.Color.toString(color)),
      ("--color-pys9ag_3", CSS.Types.Color.toString(color)),
      ("--color-pys9ag_4", CSS.Types.Color.toString(color)),
    ],
  );
  
  CSS.make(
    "in-1mgigxz",
    [
      ("--boxDark-17ffdav", CSS.Types.Color.toString(Color.Background.boxDark)),
    ],
  );
  
  CSS.make("a-1y1fodl", []);
  CSS.make("a-1bm5i1d", []);
  CSS.make("a-1c5rni", []);
  CSS.make("a-binqg5", []);
  CSS.make("a-frdzbz", []);
  CSS.make("a-1p01b7p", []);
  CSS.make("a-1sffl0e", []);
  CSS.make("a-e75uiv", []);
  
  CSS.make("a-1xwird3", []);
  CSS.make("a-lyeq2u", []);
  CSS.make("a-1c77x4a", []);
  CSS.make("a-20kxhc", []);
  CSS.make("a-14r74rj", []);
  CSS.make("a-a5c0fc", []);
  CSS.make("a-jpualz", []);
  CSS.make("a-1s68cv6", []);
  CSS.make("a-1dt7vp0", []);
  CSS.make("a-zdkg5x", []);
  CSS.make("a-a242dq", []);
  CSS.make("a-icouy8", []);
  CSS.make("a-14vzi1j", []);
  CSS.make("a-14ibp18", []);
  CSS.make("a-pnbl3b", []);
  CSS.make("a-3m0ihr", []);
  CSS.make("a-w08tou", []);
  
  CSS.make("a-11tobub", []);
  CSS.make("a-1hc7xqd", []);
  CSS.make("a-but5e9", []);
  CSS.make("a-fjhmlf", []);
  CSS.make("a-1e7m01f", []);
  
  CSS.make("a-1jvylgn", []);
  CSS.make("a-hxcezg", []);
  CSS.make("a-1oiniqy", []);
  CSS.make("a-121ueyu", []);
  CSS.make("a-yq3hnb", []);
  CSS.make("a-1rldqt2", []);
  CSS.make("a-24z38j", []);
  CSS.make("a-1h2n9c9", []);
  
  CSS.make("a-1czqhry", []);
  CSS.make("a-18au2x3", []);
  CSS.make("a-eex73u", []);
  CSS.make("a-xicm6t", []);
  CSS.make("a-1xolpb4", []);
  
  CSS.make("a-1aih0g1", []);
  CSS.make("a-1whlnwd", []);
  
  CSS.make("a-1iq0ddq", []);
  CSS.make("a-1dwopaa", []);
  CSS.make("a-13renxt", []);
  
  CSS.make("a-1qease9", []);
  CSS.make("a-m3ana2", []);
  CSS.make("a-1us11ag", []);
  
  CSS.make("a-plhhjc", []);
  CSS.make("a-13qj4w6", []);
  CSS.make("a-286ns1", []);
  CSS.make("a-jujpx4", []);
  CSS.make("a-b54k9o", []);
  
  let _loadingKeyframes = CSS.Types.AnimationName.make("k-1b5h4ts");
