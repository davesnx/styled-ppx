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
  [@css ".css-1eddbzm{background-repeat:space;}"];
  [@css ".css-kbwgys{background-repeat:round;}"];
  [@css ".css-yppiw6{background-repeat:repeat repeat;}"];
  [@css ".css-sxxji5{background-repeat:space repeat;}"];
  [@css ".css-km0kx7{background-repeat:round repeat;}"];
  [@css ".css-kiqiir{background-repeat:no-repeat repeat;}"];
  [@css ".css-7bff62{background-repeat:repeat space;}"];
  [@css ".css-11glrh1{background-repeat:space space;}"];
  [@css ".css-1mczuyd{background-repeat:round space;}"];
  [@css ".css-c7o3tu{background-repeat:no-repeat space;}"];
  [@css ".css-422l1t{background-repeat:repeat round;}"];
  [@css ".css-1qgpz8i{background-repeat:space round;}"];
  [@css ".css-1gtvp4f{background-repeat:round round;}"];
  [@css ".css-zcttlz{background-repeat:no-repeat round;}"];
  [@css ".css-j95y1{background-repeat:repeat no-repeat;}"];
  [@css ".css-e3yae4{background-repeat:space no-repeat;}"];
  [@css ".css-hghx0d{background-repeat:round no-repeat;}"];
  [@css ".css-rfr6kt{background-repeat:no-repeat no-repeat;}"];
  [@css ".css-1kobp5t{background-repeat:repeat-x, repeat-y;}"];
  [@css ".css-wfp2j1{background-attachment:local;}"];
  [@css ".css-1h94kwg{background-clip:border-box;}"];
  [@css ".css-1ie5w5o{background-clip:padding-box;}"];
  [@css ".css-15p50rv{background-clip:content-box;}"];
  [@css ".css-1mb8734{background-clip:text;}"];
  [@css ".css-pm5rmj{background-clip:border-area;}"];
  [@css ".css-11w45y6{background-clip:text, border-area;}"];
  [@css ".css-1eckwyo{background-origin:border-box;}"];
  [@css ".css-1k5r9hb{background-origin:padding-box;}"];
  [@css ".css-1agwo89{background-origin:content-box;}"];
  [@css ".css-w64aob{background-size:auto;}"];
  [@css ".css-1d5k97u{background-size:cover;}"];
  [@css ".css-okxylo{background-size:contain;}"];
  [@css ".css-b7m5qu{background-size:10px;}"];
  [@css ".css-1obu6v3{background-size:50%;}"];
  [@css ".css-1brxytx{background-size:10px auto;}"];
  [@css ".css-1x9a9zh{background-size:auto 10%;}"];
  [@css ".css-1wp4rix{background-size:50em 50%;}"];
  [@css ".css-gwzw1h{background-size:20px 20px;}"];
  [@css ".css-1vuo254{background:top left / 50% 60%;}"];
  [@css ".css-1jwvagn{background:border-box;}"];
  [@css ".css-ky2d75{background:blue;}"];
  [@css ".css-1h2hvrj{background:border-box red;}"];
  [@css ".css-phlssi{background:border-box padding-box;}"];
  [@css ".css-h1ffk7{border-top-left-radius:0;}"];
  [@css ".css-1eky41g{border-top-left-radius:50%;}"];
  [@css ".css-1yeccvj{border-top-left-radius:250px 100px;}"];
  [@css ".css-1kgozmz{border-top-right-radius:0;}"];
  [@css ".css-1ugh6x9{border-top-right-radius:50%;}"];
  [@css ".css-bm0ho1{border-top-right-radius:250px 100px;}"];
  [@css ".css-17dm6su{border-bottom-right-radius:0;}"];
  [@css ".css-1o25ugq{border-bottom-right-radius:50%;}"];
  [@css ".css-7x8l07{border-bottom-right-radius:250px 100px;}"];
  [@css ".css-156vopp{border-bottom-left-radius:0;}"];
  [@css ".css-anz4ix{border-bottom-left-radius:50%;}"];
  [@css ".css-1ufj6a{border-bottom-left-radius:250px 100px;}"];
  [@css ".css-qqv389{border-radius:10px;}"];
  [@css ".css-uodor8{border-radius:50%;}"];
  [@css ".css-2ook9k{border-radius:2px 4px;}"];
  [@css ".css-i1l4dm{border-radius:2px 4px 8px;}"];
  [@css ".css-xubni5{border-radius:2px 4px 8px 16px;}"];
  [@css ".css-6wk2xe{border-radius:10px / 20px;}"];
  [@css ".css-11z5w7s{border-radius:2px 4px 8px 16px / 2px 4px 8px 16px;}"];
  [@css ".css-p167n4{border-image-source:none;}"];
  [@css ".css-u2djw{border-image-source:url(\"foo.png\");}"];
  [@css ".css-11v8fag{border-image-slice:10;}"];
  [@css ".css-osou03{border-image-slice:30%;}"];
  [@css ".css-1iop0ma{border-image-slice:10 10;}"];
  [@css ".css-1iblsp{border-image-slice:30% 10;}"];
  [@css ".css-2a5gxt{border-image-slice:10 30%;}"];
  [@css ".css-ropwt3{border-image-slice:30% 30%;}"];
  [@css ".css-j0g3fs{border-image-slice:10 10 10;}"];
  [@css ".css-1l1b146{border-image-slice:30% 10 10;}"];
  [@css ".css-xkyk9k{border-image-slice:10 30% 10;}"];
  [@css ".css-2pdy38{border-image-slice:30% 30% 10;}"];
  [@css ".css-12bfa9m{border-image-slice:10 10 30%;}"];
  [@css ".css-paz16p{border-image-slice:30% 10 30%;}"];
  [@css ".css-wt8zfs{border-image-slice:10 30% 30%;}"];
  [@css ".css-1k7uel6{border-image-slice:30% 30% 30%;}"];
  [@css ".css-8m27b9{border-image-slice:10 10 10 10;}"];
  [@css ".css-6tciru{border-image-slice:30% 10 10 10;}"];
  [@css ".css-1uoj984{border-image-slice:10 30% 10 10;}"];
  [@css ".css-1lpeygg{border-image-slice:30% 30% 10 10;}"];
  [@css ".css-1iku8vs{border-image-slice:10 10 30% 10;}"];
  [@css ".css-15q4ctj{border-image-slice:30% 10 30% 10;}"];
  [@css ".css-c2rqu8{border-image-slice:10 30% 30% 10;}"];
  [@css ".css-12o535k{border-image-slice:30% 30% 30% 10;}"];
  [@css ".css-tymqly{border-image-slice:10 10 10 30%;}"];
  [@css ".css-1rg334v{border-image-slice:30% 10 10 30%;}"];
  [@css ".css-xh10it{border-image-slice:10 30% 10 30%;}"];
  [@css ".css-5t24bv{border-image-slice:30% 30% 10 30%;}"];
  [@css ".css-15noopq{border-image-slice:10 10 30% 30%;}"];
  [@css ".css-1okc6k6{border-image-slice:30% 10 30% 30%;}"];
  [@css ".css-pmce7t{border-image-slice:10 30% 30% 30%;}"];
  [@css ".css-1773xq3{border-image-slice:30% 30% 30% 30%;}"];
  [@css ".css-1xipp7o{border-image-slice:fill 30%;}"];
  [@css ".css-vrsoql{border-image-slice:fill 10;}"];
  [@css ".css-18qljby{border-image-slice:fill 2 4 8% 16%;}"];
  [@css ".css-1vnb5be{border-image-slice:30% fill;}"];
  [@css ".css-1s1se3r{border-image-slice:10 fill;}"];
  [@css ".css-1mnst01{border-image-slice:2 4 8% 16% fill;}"];
  [@css ".css-11smtq7{border-image-width:10px;}"];
  [@css ".css-c62lna{border-image-width:5%;}"];
  [@css ".css-xmvskx{border-image-width:28;}"];
  [@css ".css-ch12to{border-image-width:auto;}"];
  [@css ".css-yhqzt3{border-image-width:10px 10px;}"];
  [@css ".css-ya1b9l{border-image-width:5% 10px;}"];
  [@css ".css-8xa5d6{border-image-width:28 10px;}"];
  [@css ".css-1o9gsb5{border-image-width:auto 10px;}"];
  [@css ".css-1sqtfkm{border-image-width:10px 5%;}"];
  [@css ".css-1xafrk8{border-image-width:5% 5%;}"];
  [@css ".css-fvsgtx{border-image-width:28 5%;}"];
  [@css ".css-5io8wy{border-image-width:auto 5%;}"];
  [@css ".css-eyyjgi{border-image-width:10px 28;}"];
  [@css ".css-vp05n6{border-image-width:5% 28;}"];
  [@css ".css-1o7pian{border-image-width:28 28;}"];
  [@css ".css-1d47o1w{border-image-width:auto 28;}"];
  [@css ".css-3bbki1{border-image-width:10px auto;}"];
  [@css ".css-vwsfme{border-image-width:5% auto;}"];
  [@css ".css-drlhmj{border-image-width:28 auto;}"];
  [@css ".css-ttiwnw{border-image-width:auto auto;}"];
  [@css ".css-k81i6r{border-image-width:10px 10% 10;}"];
  [@css ".css-6b03j7{border-image-width:5% 10px 20 auto;}"];
  [@css ".css-1u3lw5x{border-image-outset:10px;}"];
  [@css ".css-b6x2bn{border-image-outset:20;}"];
  [@css ".css-1gxjka5{border-image-outset:10px 20;}"];
  [@css ".css-rkv07i{border-image-outset:10px 20px;}"];
  [@css ".css-vrixn9{border-image-outset:20 30;}"];
  [@css ".css-9d3q5z{border-image-outset:2px 3px 4;}"];
  [@css ".css-16tdhma{border-image-outset:1 2px 3px 4;}"];
  [@css ".css-et8amr{border-image-repeat:stretch;}"];
  [@css ".css-1vpvfhi{border-image-repeat:repeat;}"];
  [@css ".css-1jssbb7{border-image-repeat:round;}"];
  [@css ".css-17kfada{border-image-repeat:space;}"];
  [@css ".css-1rv930f{border-image-repeat:stretch stretch;}"];
  [@css ".css-34ipsj{border-image-repeat:repeat stretch;}"];
  [@css ".css-120h3hn{border-image-repeat:round stretch;}"];
  [@css ".css-1v3d92{border-image-repeat:space stretch;}"];
  [@css ".css-1195f3q{border-image-repeat:stretch repeat;}"];
  [@css ".css-vjdrj5{border-image-repeat:repeat repeat;}"];
  [@css ".css-1ih6kfj{border-image-repeat:round repeat;}"];
  [@css ".css-1gnahlj{border-image-repeat:space repeat;}"];
  [@css ".css-n4d86l{border-image-repeat:stretch round;}"];
  [@css ".css-11u5ktc{border-image-repeat:repeat round;}"];
  [@css ".css-13kllwt{border-image-repeat:round round;}"];
  [@css ".css-h4eu9k{border-image-repeat:space round;}"];
  [@css ".css-y3orbo{border-image-repeat:stretch space;}"];
  [@css ".css-yvcpic{border-image-repeat:repeat space;}"];
  [@css ".css-1vw2bpm{border-image-repeat:round space;}"];
  [@css ".css-1a8iv0g{border-image-repeat:space space;}"];
  [@css ".css-13sl0e3{border-image:url(\"foo.png\") 10;}"];
  [@css ".css-17cc16s{border-image:url(\"foo.png\") 10%;}"];
  [@css ".css-slk48c{border-image:url(\"foo.png\") 10% fill;}"];
  [@css ".css-lnndfl{border-image:url(\"foo.png\") 10 round;}"];
  [@css ".css-bloh1n{border-image:url(\"foo.png\") 10 stretch repeat;}"];
  [@css ".css-h8vdj4{border-image:url(\"foo.png\") 10 / 10px;}"];
  [@css ".css-1oqx17x{border-image:url(\"foo.png\") 10 / 10% / 10px;}"];
  [@css ".css-35zcfy{border-image:url(\"foo.png\") fill 10 / 10% / 10px;}"];
  [@css
    ".css-1oe30nn{border-image:url(\"foo.png\") fill 10 / 10% / 10px space;}"
  ];
  [@css ".css-gokeqi{box-shadow:none;}"];
  [@css ".css-3sye8k{box-shadow:1px 1px;}"];
  [@css ".css-i2r8u1{box-shadow:0 0 black;}"];
  [@css ".css-1r1uemi{box-shadow:1px 2px 3px;}"];
  [@css ".css-1wumflx{box-shadow:1px 2px 3px black;}"];
  [@css ".css-13956p9{box-shadow:1px 2px 3px 4px;}"];
  [@css ".css-dvxcnx{box-shadow:1px 2px 3px 4px black;}"];
  [@css ".css-1scios5{box-shadow:inset 1px 1px;}"];
  [@css ".css-1qf5tpn{box-shadow:inset 0 0 black;}"];
  [@css ".css-1r7izzs{box-shadow:inset 1px 2px 3px;}"];
  [@css ".css-19gyjsg{box-shadow:inset 1px 2px 3px black;}"];
  [@css ".css-z4khnb{box-shadow:inset 1px 2px 3px 4px;}"];
  [@css ".css-1jw3f6l{box-shadow:inset 1px 2px 3px 4px black;}"];
  [@css
    ".css-yqotsx{box-shadow:inset 1px 2px 3px 4px black, 1px 2px 3px 4px black;}"
  ];
  [@css ".css-ce85p6{box-shadow:1px 1px, inset 2px 2px red;}"];
  [@css ".css-1q5q314{box-shadow:0 0 5px, inset 0 0 10px black;}"];
  [@css ".css-1jv2nfr{background-position-x:right;}"];
  [@css ".css-1fivq06{background-position-x:center;}"];
  [@css ".css-hxcezg{background-position-x:50%;}"];
  [@css ".css-11xe8x4{background-position-x:left, left;}"];
  [@css ".css-g4em91{background-position-x:left, right;}"];
  [@css ".css-1v9h4p{background-position-x:right, left;}"];
  [@css ".css-1ytz26j{background-position-x:left, 0%;}"];
  [@css ".css-a7bcib{background-position-x:10%, 20%, 40%;}"];
  [@css ".css-f8ehso{background-position-x:0px;}"];
  [@css ".css-n3vpvo{background-position-x:30px;}"];
  [@css ".css-1lsjlye{background-position-x:0%, 10%, 20%, 30%;}"];
  [@css ".css-1r6uvjq{background-position-x:left, left, left, left, left;}"];
  [@css ".css-14w1f37{background-position-x:calc(20px);}"];
  [@css ".css-lz1ldt{background-position-x:calc(20px + 1em);}"];
  [@css ".css-99w4iu{background-position-x:calc(20px / 2);}"];
  [@css ".css-1sok1yt{background-position-x:calc(20px + 50%);}"];
  [@css ".css-16z363d{background-position-x:calc(50% - 10px);}"];
  [@css ".css-13x78wf{background-position-x:calc(-20px);}"];
  [@css ".css-1lryx3{background-position-x:calc(-50%);}"];
  [@css ".css-55be59{background-position-x:calc(-20%);}"];
  [@css ".css-1p57w9s{background-position-x:right 20px;}"];
  [@css ".css-o38n01{background-position-x:left 20px;}"];
  [@css ".css-18df6oz{background-position-x:right -50px;}"];
  [@css ".css-ckata8{background-position-x:left -50px;}"];
  [@css ".css-7bxup1{background-position-y:bottom;}"];
  [@css ".css-1it9ewh{background-position-y:center;}"];
  [@css ".css-wahsum{background-position-y:50%;}"];
  [@css ".css-2u04xu{background-position-y:top, top;}"];
  [@css ".css-19mqqtz{background-position-y:top, bottom;}"];
  [@css ".css-13w54xk{background-position-y:bottom, top;}"];
  [@css ".css-1c7d2k{background-position-y:top, 0%;}"];
  [@css ".css-m293ok{background-position-y:10%, 20%, 40%;}"];
  [@css ".css-1gbcs51{background-position-y:0px;}"];
  [@css ".css-1it2wtl{background-position-y:30px;}"];
  [@css ".css-rgd3sd{background-position-y:0%, 10%, 20%, 30%;}"];
  [@css ".css-jdfv8k{background-position-y:top, top, top, top, top;}"];
  [@css ".css-1xo2yw6{background-position-y:calc(20px);}"];
  [@css ".css-nnpdqz{background-position-y:calc(20px + 1em);}"];
  [@css ".css-1ey8w9h{background-position-y:calc(20px / 2);}"];
  [@css ".css-1azkkb2{background-position-y:calc(20px + 50%);}"];
  [@css ".css-uedt8x{background-position-y:calc(50% - 10px);}"];
  [@css ".css-d5c0ip{background-position-y:calc(-20px);}"];
  [@css ".css-p4ckm0{background-position-y:calc(-50%);}"];
  [@css ".css-1xyw002{background-position-y:calc(-20%);}"];
  [@css ".css-70z8v2{background-position-y:bottom 20px;}"];
  [@css ".css-1x42qfz{background-position-y:top 20px;}"];
  [@css ".css-esmhad{background-position-y:bottom -50px;}"];
  [@css ".css-1uc0o43{background-position-y:top -50px;}"];
  [@css ".css-1iwhz2r{background-image:linear-gradient(45deg, blue, red);}"];
  [@css
    ".css-1kbqfjp{background-image:linear-gradient(90deg, blue 10%, red 20%);}"
  ];
  [@css ".css-14mab29{background-image:linear-gradient(90deg, blue 10%, red);}"];
  [@css
    ".css-1yq1u4d{background-image:linear-gradient(90deg, blue, 10%, red);}"
  ];
  [@css ".css-zcuss4{background-image:linear-gradient(white, black);}"];
  [@css
    ".css-orn2r8{background-image:linear-gradient(to right, white, black);}"
  ];
  [@css ".css-9mys2x{background-image:linear-gradient(45deg, white, black);}"];
  [@css ".css-snojtb{background-image:linear-gradient(white 50%, black);}"];
  [@css ".css-bw0xs1{background-image:linear-gradient(white, #f06, black);}"];
  [@css ".css-1y1fodl{background-image:radial-gradient(white, black);}"];
  [@css ".css-1bm5i1d{background-image:radial-gradient(circle, white, black);}"];
  [@css ".css-1c5rni{background-image:radial-gradient(ellipse, white, black);}"];
  [@css
    ".css-frdzbz{background-image:radial-gradient(farthest-side, white, black);}"
  ];
  [@css ".css-1sffl0e{background-image:radial-gradient(50%, white, black);}"];
  [@css ".css-e75uiv{background-image:radial-gradient(60% 60%, white, black);}"];
  [@css ".css-1xwird3{list-style-image:linear-gradient(white, black);}"];
  [@css
    ".css-lyeq2u{list-style-image:linear-gradient(to right, white, black);}"
  ];
  [@css ".css-1c77x4a{list-style-image:linear-gradient(45deg, white, black);}"];
  [@css ".css-20kxhc{list-style-image:linear-gradient(white 50%, black);}"];
  [@css ".css-14r74rj{list-style-image:linear-gradient(white 5px, black);}"];
  [@css ".css-a5c0fc{list-style-image:linear-gradient(white, #f06, black);}"];
  [@css ".css-jpualz{list-style-image:linear-gradient(currentColor, black);}"];
  [@css ".css-1dt7vp0{list-style-image:radial-gradient(white, black);}"];
  [@css ".css-zdkg5x{list-style-image:radial-gradient(circle, white, black);}"];
  [@css ".css-a242dq{list-style-image:radial-gradient(ellipse, white, black);}"];
  [@css
    ".css-icouy8{list-style-image:radial-gradient(closest-corner, white, black);}"
  ];
  [@css
    ".css-14ibp18{list-style-image:radial-gradient(farthest-side, white, black);}"
  ];
  [@css ".css-3m0ihr{list-style-image:radial-gradient(50%, white, black);}"];
  [@css ".css-w08tou{list-style-image:radial-gradient(60% 60%, white, black);}"];
  [@css ".css-11tobub{image-rendering:auto;}"];
  [@css ".css-1hc7xqd{image-rendering:smooth;}"];
  [@css ".css-but5e9{image-rendering:high-quality;}"];
  [@css ".css-fjhmlf{image-rendering:pixelated;}"];
  [@css ".css-1e7m01f{image-rendering:crisp-edges;}"];
  [@css ".css-1jvylgn{background-position:bottom;}"];
  [@css ".css-1oiniqy{background-position-y:0;}"];
  [@css ".css-121ueyu{background-position:0 0;}"];
  [@css ".css-yq3hnb{background-position:1rem 0;}"];
  [@css ".css-1rldqt2{background-position:bottom 10px right;}"];
  [@css ".css-24z38j{background-position:bottom 10px right 20px;}"];
  [@css ".css-1h2n9c9{background-position:0 0, center;}"];
  [@css ".css-n81h4k{object-position:top ;}"];
  [@css ".css-7fkzlz{object-position:bottom ;}"];
  [@css ".css-ymgga3{object-position:left ;}"];
  [@css ".css-1w8iwfs{object-position:right ;}"];
  [@css ".css-19v17nb{object-position:center ;}"];
  [@css ".css-18x56gd{object-position:25% 75% ;}"];
  [@css ".css-b4h1sw{object-position:25% ;}"];
  [@css ".css-16v4000{object-position:0 0 ;}"];
  [@css ".css-kz9n4e{object-position:1cm 2cm ;}"];
  [@css ".css-14d8bq0{object-position:10ch 8em ;}"];
  [@css ".css-uvxj01{object-position:bottom 10px right 20px ;}"];
  [@css ".css-o5jbis{object-position:right 3em bottom 10px ;}"];
  [@css ".css-xhzfzt{object-position:top 0 right 10px ;}"];
  [@css ".css-1l3159e{object-position:inherit ;}"];
  [@css ".css-4m3t5s{object-position:initial ;}"];
  [@css ".css-1j5c605{object-position:revert ;}"];
  [@css ".css-2a3742{object-position:revert-layer ;}"];
  [@css ".css-6lnld3{object-position:unset ;}"];
  module Color = {
    module Background = {
      let boxDark = `hex("000000");
    };
    module Shadow = {
      let elevation1 = `rgba((0, 0, 0, `num(0.03)));
    };
  };
  
  CSS.make("css-1eddbzm", []);
  CSS.make("css-kbwgys", []);
  CSS.make("css-yppiw6", []);
  CSS.make("css-sxxji5", []);
  CSS.make("css-km0kx7", []);
  CSS.make("css-kiqiir", []);
  CSS.make("css-7bff62", []);
  CSS.make("css-11glrh1", []);
  CSS.make("css-1mczuyd", []);
  CSS.make("css-c7o3tu", []);
  CSS.make("css-422l1t", []);
  CSS.make("css-1qgpz8i", []);
  CSS.make("css-1gtvp4f", []);
  CSS.make("css-zcttlz", []);
  CSS.make("css-j95y1", []);
  CSS.make("css-e3yae4", []);
  CSS.make("css-hghx0d", []);
  CSS.make("css-rfr6kt", []);
  CSS.make("css-1kobp5t", []);
  CSS.make("css-wfp2j1", []);
  CSS.make("css-1h94kwg", []);
  CSS.make("css-1ie5w5o", []);
  CSS.make("css-15p50rv", []);
  CSS.make("css-1mb8734", []);
  CSS.make("css-pm5rmj", []);
  CSS.make("css-11w45y6", []);
  CSS.make("css-1eckwyo", []);
  CSS.make("css-1k5r9hb", []);
  CSS.make("css-1agwo89", []);
  CSS.make("css-w64aob", []);
  CSS.make("css-1d5k97u", []);
  CSS.make("css-okxylo", []);
  CSS.make("css-b7m5qu", []);
  CSS.make("css-1obu6v3", []);
  CSS.make("css-1brxytx", []);
  CSS.make("css-1x9a9zh", []);
  CSS.make("css-1wp4rix", []);
  CSS.make("css-gwzw1h", []);
  
  CSS.make("css-1vuo254", []);
  CSS.make("css-1jwvagn", []);
  CSS.make("css-ky2d75", []);
  CSS.make("css-1h2hvrj", []);
  
  CSS.make("css-phlssi", []);
  CSS.backgroundImage(`url({js|foo.png|js}));
  CSS.make("css-h1ffk7", []);
  CSS.make("css-1eky41g", []);
  CSS.make("css-1yeccvj", []);
  CSS.make("css-1kgozmz", []);
  CSS.make("css-1ugh6x9", []);
  CSS.make("css-bm0ho1", []);
  CSS.make("css-17dm6su", []);
  CSS.make("css-1o25ugq", []);
  CSS.make("css-7x8l07", []);
  CSS.make("css-156vopp", []);
  CSS.make("css-anz4ix", []);
  CSS.make("css-1ufj6a", []);
  CSS.make("css-qqv389", []);
  CSS.make("css-uodor8", []);
  CSS.make("css-2ook9k", []);
  CSS.make("css-i1l4dm", []);
  CSS.make("css-xubni5", []);
  CSS.make("css-6wk2xe", []);
  CSS.make("css-11z5w7s", []);
  CSS.make("css-p167n4", []);
  CSS.make("css-u2djw", []);
  CSS.make("css-11v8fag", []);
  CSS.make("css-osou03", []);
  CSS.make("css-1iop0ma", []);
  CSS.make("css-1iblsp", []);
  CSS.make("css-2a5gxt", []);
  CSS.make("css-ropwt3", []);
  CSS.make("css-j0g3fs", []);
  CSS.make("css-1l1b146", []);
  CSS.make("css-xkyk9k", []);
  CSS.make("css-2pdy38", []);
  CSS.make("css-12bfa9m", []);
  CSS.make("css-paz16p", []);
  CSS.make("css-wt8zfs", []);
  CSS.make("css-1k7uel6", []);
  CSS.make("css-8m27b9", []);
  CSS.make("css-6tciru", []);
  CSS.make("css-1uoj984", []);
  CSS.make("css-1lpeygg", []);
  CSS.make("css-1iku8vs", []);
  CSS.make("css-15q4ctj", []);
  CSS.make("css-c2rqu8", []);
  CSS.make("css-12o535k", []);
  CSS.make("css-tymqly", []);
  CSS.make("css-1rg334v", []);
  CSS.make("css-xh10it", []);
  CSS.make("css-5t24bv", []);
  CSS.make("css-15noopq", []);
  CSS.make("css-1okc6k6", []);
  CSS.make("css-pmce7t", []);
  CSS.make("css-1773xq3", []);
  CSS.make("css-1xipp7o", []);
  CSS.make("css-vrsoql", []);
  CSS.make("css-18qljby", []);
  CSS.make("css-1vnb5be", []);
  CSS.make("css-1s1se3r", []);
  CSS.make("css-1mnst01", []);
  CSS.make("css-11smtq7", []);
  CSS.make("css-c62lna", []);
  CSS.make("css-xmvskx", []);
  CSS.make("css-ch12to", []);
  CSS.make("css-yhqzt3", []);
  CSS.make("css-ya1b9l", []);
  CSS.make("css-8xa5d6", []);
  CSS.make("css-1o9gsb5", []);
  CSS.make("css-1sqtfkm", []);
  CSS.make("css-1xafrk8", []);
  CSS.make("css-fvsgtx", []);
  CSS.make("css-5io8wy", []);
  CSS.make("css-eyyjgi", []);
  CSS.make("css-vp05n6", []);
  CSS.make("css-1o7pian", []);
  CSS.make("css-1d47o1w", []);
  CSS.make("css-3bbki1", []);
  CSS.make("css-vwsfme", []);
  CSS.make("css-drlhmj", []);
  CSS.make("css-ttiwnw", []);
  CSS.make("css-k81i6r", []);
  CSS.make("css-6b03j7", []);
  CSS.make("css-1u3lw5x", []);
  CSS.make("css-b6x2bn", []);
  CSS.make("css-1gxjka5", []);
  CSS.make("css-rkv07i", []);
  CSS.make("css-vrixn9", []);
  CSS.make("css-9d3q5z", []);
  CSS.make("css-16tdhma", []);
  CSS.make("css-et8amr", []);
  CSS.make("css-1vpvfhi", []);
  CSS.make("css-1jssbb7", []);
  CSS.make("css-17kfada", []);
  CSS.make("css-1rv930f", []);
  CSS.make("css-34ipsj", []);
  CSS.make("css-120h3hn", []);
  CSS.make("css-1v3d92", []);
  CSS.make("css-1195f3q", []);
  CSS.make("css-vjdrj5", []);
  CSS.make("css-1ih6kfj", []);
  CSS.make("css-1gnahlj", []);
  CSS.make("css-n4d86l", []);
  CSS.make("css-11u5ktc", []);
  CSS.make("css-13kllwt", []);
  CSS.make("css-h4eu9k", []);
  CSS.make("css-y3orbo", []);
  CSS.make("css-yvcpic", []);
  CSS.make("css-1vw2bpm", []);
  CSS.make("css-1a8iv0g", []);
  CSS.make("css-13sl0e3", []);
  CSS.make("css-17cc16s", []);
  CSS.make("css-slk48c", []);
  CSS.make("css-lnndfl", []);
  CSS.make("css-bloh1n", []);
  CSS.make("css-h8vdj4", []);
  CSS.make("css-1oqx17x", []);
  CSS.make("css-35zcfy", []);
  CSS.make("css-1oe30nn", []);
  
  CSS.make("css-gokeqi", []);
  
  CSS.make("css-3sye8k", []);
  
  CSS.make("css-i2r8u1", []);
  
  CSS.make("css-1r1uemi", []);
  
  CSS.make("css-1wumflx", []);
  
  CSS.make("css-13956p9", []);
  
  CSS.make("css-dvxcnx", []);
  
  CSS.make("css-1scios5", []);
  
  CSS.make("css-1qf5tpn", []);
  
  CSS.make("css-1r7izzs", []);
  
  CSS.make("css-19gyjsg", []);
  
  CSS.make("css-z4khnb", []);
  
  CSS.make("css-1jw3f6l", []);
  
  CSS.make("css-yqotsx", []);
  CSS.make("css-ce85p6", []);
  CSS.make("css-1q5q314", []);
  CSS.boxShadows([|
    CSS.Shadow.box(
      ~x=`pxFloat(-1.),
      ~y=`pxFloat(1.),
      ~blur=`pxFloat(0.),
      ~spread=`pxFloat(0.),
      Color.Shadow.elevation1,
    ),
    CSS.Shadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(1.),
      ~blur=`pxFloat(0.),
      ~spread=`pxFloat(0.),
      Color.Shadow.elevation1,
    ),
    CSS.Shadow.box(
      ~x=`pxFloat(0.),
      ~y=`pxFloat(-1.),
      ~blur=`pxFloat(0.),
      ~spread=`pxFloat(0.),
      Color.Shadow.elevation1,
    ),
  |]);
  
  CSS.make("css-1jv2nfr", []);
  CSS.make("css-1fivq06", []);
  CSS.make("css-hxcezg", []);
  CSS.make("css-11xe8x4", []);
  CSS.make("css-g4em91", []);
  CSS.make("css-1v9h4p", []);
  CSS.make("css-1ytz26j", []);
  CSS.make("css-a7bcib", []);
  CSS.make("css-f8ehso", []);
  CSS.make("css-n3vpvo", []);
  CSS.make("css-1lsjlye", []);
  CSS.make("css-1r6uvjq", []);
  CSS.make("css-14w1f37", []);
  CSS.make("css-lz1ldt", []);
  CSS.make("css-99w4iu", []);
  CSS.make("css-1sok1yt", []);
  CSS.make("css-16z363d", []);
  CSS.make("css-13x78wf", []);
  CSS.make("css-1lryx3", []);
  CSS.make("css-55be59", []);
  CSS.make("css-1p57w9s", []);
  CSS.make("css-o38n01", []);
  CSS.make("css-18df6oz", []);
  CSS.make("css-ckata8", []);
  CSS.make("css-1p57w9s", []);
  CSS.make("css-7bxup1", []);
  CSS.make("css-1it9ewh", []);
  CSS.make("css-wahsum", []);
  CSS.make("css-2u04xu", []);
  CSS.make("css-19mqqtz", []);
  CSS.make("css-13w54xk", []);
  CSS.make("css-1c7d2k", []);
  CSS.make("css-m293ok", []);
  CSS.make("css-1gbcs51", []);
  CSS.make("css-1it2wtl", []);
  CSS.make("css-rgd3sd", []);
  CSS.make("css-jdfv8k", []);
  CSS.make("css-1xo2yw6", []);
  CSS.make("css-nnpdqz", []);
  CSS.make("css-1ey8w9h", []);
  CSS.make("css-1azkkb2", []);
  CSS.make("css-uedt8x", []);
  CSS.make("css-d5c0ip", []);
  CSS.make("css-p4ckm0", []);
  CSS.make("css-1xyw002", []);
  CSS.make("css-70z8v2", []);
  CSS.make("css-1x42qfz", []);
  CSS.make("css-esmhad", []);
  CSS.make("css-1uc0o43", []);
  CSS.make("css-70z8v2", []);
  
  CSS.make("css-1iwhz2r", []);
  CSS.make("css-1kbqfjp", []);
  CSS.make("css-14mab29", []);
  CSS.make("css-1yq1u4d", []);
  CSS.make("css-zcuss4", []);
  CSS.make("css-orn2r8", []);
  CSS.make("css-9mys2x", []);
  CSS.make("css-snojtb", []);
  CSS.make("css-bw0xs1", []);
  CSS.backgroundImage(
    `linearGradient((
      None,
      [|
        (Some(CSS.red), Some(`pxFloat(-50.))),
        (
          Some(CSS.white),
          Some(`calc(`add((`pxFloat(-25.), `percent(50.))))),
        ),
        (Some(CSS.blue), Some(`percent(100.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImages([|
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CSS.blue), None), (Some(CSS.red), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
    `linearGradient((
      None,
      [|
        (Some(CSS.red), Some(`pxFloat(-50.))),
        (
          Some(CSS.white),
          Some(`calc(`add((`pxFloat(-25.), `percent(50.))))),
        ),
        (Some(CSS.blue), Some(`percent(100.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CSS.blue), None), (Some(CSS.red), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  |]);
  let color = `hex("333");
  CSS.backgroundImage(
    `linearGradient((
      Some(`deg(45.)),
      [|
        (Some(color), Some(`percent(25.))),
        (Some(`transparent), Some(`percent(0.))),
        (Some(`transparent), Some(`percent(50.))),
        (Some(color), Some(`percent(0.))),
        (Some(color), Some(`percent(75.))),
        (Some(`transparent), Some(`percent(0.))),
        (Some(`transparent), Some(`percent(100.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `repeatingLinearGradient((
      Some(`deg(45.)),
      [|
        (Some(color), Some(`pxFloat(0.))),
        (Some(color), Some(`pxFloat(4.))),
        (Some(color), Some(`pxFloat(5.))),
        (Some(color), Some(`pxFloat(9.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  
  CSS.backgroundImages([|
    `linearGradient((
      Some(`deg(45.)),
      [|
        (Some(Color.Background.boxDark), Some(`percent(25.))),
        (Some(`transparent), Some(`percent(25.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
    `linearGradient((
      None,
      [|
        (Some(CSS.red), Some(`pxFloat(-50.))),
        (
          Some(CSS.white),
          Some(`calc(`add((`pxFloat(-25.), `percent(50.))))),
        ),
        (Some(CSS.blue), Some(`percent(100.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CSS.blue), None), (Some(CSS.red), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  |]);
  
  CSS.make("css-1y1fodl", []);
  CSS.make("css-1bm5i1d", []);
  CSS.make("css-1c5rni", []);
  CSS.backgroundImage(
    `radialGradient((
      Some(`circle),
      Some(`closestCorner),
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.make("css-frdzbz", []);
  CSS.backgroundImage(
    `radialGradient((
      Some(`circle),
      Some(`farthestSide),
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.make("css-1sffl0e", []);
  CSS.make("css-e75uiv", []);
  
  CSS.make("css-1xwird3", []);
  CSS.make("css-lyeq2u", []);
  CSS.make("css-1c77x4a", []);
  CSS.make("css-20kxhc", []);
  CSS.make("css-14r74rj", []);
  CSS.make("css-a5c0fc", []);
  CSS.make("css-jpualz", []);
  CSS.listStyleImage(
    `linearGradient((
      None,
      [|
        (Some(CSS.red), Some(`pxFloat(-50.))),
        (
          Some(CSS.white),
          Some(`calc(`add((`pxFloat(-25.), `percent(50.))))),
        ),
        (Some(CSS.blue), Some(`percent(100.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.make("css-1dt7vp0", []);
  CSS.make("css-zdkg5x", []);
  CSS.make("css-a242dq", []);
  CSS.make("css-icouy8", []);
  CSS.listStyleImage(
    `radialGradient((
      Some(`circle),
      Some(`closestCorner),
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.make("css-14ibp18", []);
  CSS.listStyleImage(
    `radialGradient((
      Some(`circle),
      Some(`farthestSide),
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.make("css-3m0ihr", []);
  CSS.make("css-w08tou", []);
  
  CSS.make("css-11tobub", []);
  CSS.make("css-1hc7xqd", []);
  CSS.make("css-but5e9", []);
  CSS.make("css-fjhmlf", []);
  CSS.make("css-1e7m01f", []);
  
  CSS.make("css-1jvylgn", []);
  CSS.make("css-hxcezg", []);
  CSS.make("css-1oiniqy", []);
  CSS.make("css-121ueyu", []);
  CSS.make("css-yq3hnb", []);
  CSS.make("css-1rldqt2", []);
  CSS.make("css-24z38j", []);
  CSS.make("css-1h2n9c9", []);
  
  CSS.make("css-n81h4k", []);
  CSS.make("css-7fkzlz", []);
  CSS.make("css-ymgga3", []);
  CSS.make("css-1w8iwfs", []);
  CSS.make("css-19v17nb", []);
  
  CSS.make("css-18x56gd", []);
  CSS.make("css-b4h1sw", []);
  
  CSS.make("css-16v4000", []);
  CSS.make("css-kz9n4e", []);
  CSS.make("css-14d8bq0", []);
  
  CSS.make("css-uvxj01", []);
  CSS.make("css-o5jbis", []);
  CSS.make("css-xhzfzt", []);
  
  CSS.make("css-1l3159e", []);
  CSS.make("css-4m3t5s", []);
  CSS.make("css-1j5c605", []);
  CSS.make("css-2a3742", []);
  CSS.make("css-6lnld3", []);
  
  let _loadingKeyframes =
    CSS.keyframes([|
      (0, [|CSS.backgroundPosition(`hv((`zero, `zero)))|]),
      (100, [|CSS.backgroundPosition(`hv((`rem(1.), `zero)))|]),
    |]);

