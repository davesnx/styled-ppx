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
  File "input.re", line 1, characters 0-22:
  Error: Property 'border-radius' has an invalid value: ' 2px 4px', Unexpected
         trailing input '4px'.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-1eddbzm{background-repeat:space;}\n.css-kbwgys{background-repeat:round;}\n.css-yppiw6{background-repeat:repeat repeat;}\n.css-sxxji5{background-repeat:space repeat;}\n.css-km0kx7{background-repeat:round repeat;}\n.css-kiqiir{background-repeat:no-repeat repeat;}\n.css-7bff62{background-repeat:repeat space;}\n.css-11glrh1{background-repeat:space space;}\n.css-1mczuyd{background-repeat:round space;}\n.css-c7o3tu{background-repeat:no-repeat space;}\n.css-422l1t{background-repeat:repeat round;}\n.css-1qgpz8i{background-repeat:space round;}\n.css-1gtvp4f{background-repeat:round round;}\n.css-zcttlz{background-repeat:no-repeat round;}\n.css-j95y1{background-repeat:repeat no-repeat;}\n.css-e3yae4{background-repeat:space no-repeat;}\n.css-hghx0d{background-repeat:round no-repeat;}\n.css-rfr6kt{background-repeat:no-repeat no-repeat;}\n.css-1kobp5t{background-repeat:repeat-x, repeat-y;}\n.css-wfp2j1{background-attachment:local;}\n.css-1h94kwg{background-clip:border-box;}\n.css-1ie5w5o{background-clip:padding-box;}\n.css-15p50rv{background-clip:content-box;}\n.css-1mb8734{background-clip:text;}\n.css-pm5rmj{background-clip:border-area;}\n.css-11w45y6{background-clip:text, border-area;}\n.css-1eckwyo{background-origin:border-box;}\n.css-1k5r9hb{background-origin:padding-box;}\n.css-1agwo89{background-origin:content-box;}\n.css-w64aob{background-size:auto;}\n.css-1d5k97u{background-size:cover;}\n.css-okxylo{background-size:contain;}\n.css-b7m5qu{background-size:10px;}\n.css-1obu6v3{background-size:50%;}\n.css-1brxytx{background-size:10px auto;}\n.css-1x9a9zh{background-size:auto 10%;}\n.css-1wp4rix{background-size:50em 50%;}\n.css-gwzw1h{background-size:20px 20px;}\n.css-1vuo254{background:top left / 50% 60%;}\n.css-1jwvagn{background:border-box;}\n.css-ky2d75{background:blue;}\n.css-1h2hvrj{background:border-box red;}\n.css-phlssi{background:border-box padding-box;}\n.css-h1ffk7{border-top-left-radius:0;}\n.css-1eky41g{border-top-left-radius:50%;}\n.css-1yeccvj{border-top-left-radius:250px 100px;}\n.css-1kgozmz{border-top-right-radius:0;}\n.css-1ugh6x9{border-top-right-radius:50%;}\n.css-bm0ho1{border-top-right-radius:250px 100px;}\n.css-17dm6su{border-bottom-right-radius:0;}\n.css-1o25ugq{border-bottom-right-radius:50%;}\n.css-7x8l07{border-bottom-right-radius:250px 100px;}\n.css-156vopp{border-bottom-left-radius:0;}\n.css-anz4ix{border-bottom-left-radius:50%;}\n.css-1ufj6a{border-bottom-left-radius:250px 100px;}\n.css-qqv389{border-radius:10px;}\n.css-uodor8{border-radius:50%;}\n.css-p167n4{border-image-source:none;}\n.css-u2djw{border-image-source:url(\"foo.png\");}\n.css-11v8fag{border-image-slice:10;}\n.css-osou03{border-image-slice:30%;}\n.css-1iop0ma{border-image-slice:10 10;}\n.css-1iblsp{border-image-slice:30% 10;}\n.css-2a5gxt{border-image-slice:10 30%;}\n.css-ropwt3{border-image-slice:30% 30%;}\n.css-j0g3fs{border-image-slice:10 10 10;}\n.css-1l1b146{border-image-slice:30% 10 10;}\n.css-xkyk9k{border-image-slice:10 30% 10;}\n.css-2pdy38{border-image-slice:30% 30% 10;}\n.css-12bfa9m{border-image-slice:10 10 30%;}\n.css-paz16p{border-image-slice:30% 10 30%;}\n.css-wt8zfs{border-image-slice:10 30% 30%;}\n.css-1k7uel6{border-image-slice:30% 30% 30%;}\n.css-8m27b9{border-image-slice:10 10 10 10;}\n.css-6tciru{border-image-slice:30% 10 10 10;}\n.css-1uoj984{border-image-slice:10 30% 10 10;}\n.css-1lpeygg{border-image-slice:30% 30% 10 10;}\n.css-1iku8vs{border-image-slice:10 10 30% 10;}\n.css-15q4ctj{border-image-slice:30% 10 30% 10;}\n.css-c2rqu8{border-image-slice:10 30% 30% 10;}\n.css-12o535k{border-image-slice:30% 30% 30% 10;}\n.css-tymqly{border-image-slice:10 10 10 30%;}\n.css-1rg334v{border-image-slice:30% 10 10 30%;}\n.css-xh10it{border-image-slice:10 30% 10 30%;}\n.css-5t24bv{border-image-slice:30% 30% 10 30%;}\n.css-15noopq{border-image-slice:10 10 30% 30%;}\n.css-1okc6k6{border-image-slice:30% 10 30% 30%;}\n.css-pmce7t{border-image-slice:10 30% 30% 30%;}\n.css-1773xq3{border-image-slice:30% 30% 30% 30%;}\n.css-1xipp7o{border-image-slice:fill 30%;}\n.css-vrsoql{border-image-slice:fill 10;}\n.css-18qljby{border-image-slice:fill 2 4 8% 16%;}\n.css-1vnb5be{border-image-slice:30% fill;}\n.css-1s1se3r{border-image-slice:10 fill;}\n.css-1mnst01{border-image-slice:2 4 8% 16% fill;}\n.css-11smtq7{border-image-width:10px;}\n.css-c62lna{border-image-width:5%;}\n.css-xmvskx{border-image-width:28;}\n.css-ch12to{border-image-width:auto;}\n.css-yhqzt3{border-image-width:10px 10px;}\n.css-ya1b9l{border-image-width:5% 10px;}\n.css-8xa5d6{border-image-width:28 10px;}\n.css-1o9gsb5{border-image-width:auto 10px;}\n.css-1sqtfkm{border-image-width:10px 5%;}\n.css-1xafrk8{border-image-width:5% 5%;}\n.css-fvsgtx{border-image-width:28 5%;}\n.css-5io8wy{border-image-width:auto 5%;}\n.css-eyyjgi{border-image-width:10px 28;}\n.css-vp05n6{border-image-width:5% 28;}\n.css-1o7pian{border-image-width:28 28;}\n.css-1d47o1w{border-image-width:auto 28;}\n.css-3bbki1{border-image-width:10px auto;}\n.css-vwsfme{border-image-width:5% auto;}\n.css-drlhmj{border-image-width:28 auto;}\n.css-ttiwnw{border-image-width:auto auto;}\n.css-k81i6r{border-image-width:10px 10% 10;}\n.css-6b03j7{border-image-width:5% 10px 20 auto;}\n.css-1u3lw5x{border-image-outset:10px;}\n.css-b6x2bn{border-image-outset:20;}\n.css-1gxjka5{border-image-outset:10px 20;}\n.css-rkv07i{border-image-outset:10px 20px;}\n.css-vrixn9{border-image-outset:20 30;}\n.css-9d3q5z{border-image-outset:2px 3px 4;}\n.css-16tdhma{border-image-outset:1 2px 3px 4;}\n.css-et8amr{border-image-repeat:stretch;}\n.css-1vpvfhi{border-image-repeat:repeat;}\n.css-1jssbb7{border-image-repeat:round;}\n.css-17kfada{border-image-repeat:space;}\n.css-1rv930f{border-image-repeat:stretch stretch;}\n.css-34ipsj{border-image-repeat:repeat stretch;}\n.css-120h3hn{border-image-repeat:round stretch;}\n.css-1v3d92{border-image-repeat:space stretch;}\n.css-1195f3q{border-image-repeat:stretch repeat;}\n.css-vjdrj5{border-image-repeat:repeat repeat;}\n.css-1ih6kfj{border-image-repeat:round repeat;}\n.css-1gnahlj{border-image-repeat:space repeat;}\n.css-n4d86l{border-image-repeat:stretch round;}\n.css-11u5ktc{border-image-repeat:repeat round;}\n.css-13kllwt{border-image-repeat:round round;}\n.css-h4eu9k{border-image-repeat:space round;}\n.css-y3orbo{border-image-repeat:stretch space;}\n.css-yvcpic{border-image-repeat:repeat space;}\n.css-1vw2bpm{border-image-repeat:round space;}\n.css-1a8iv0g{border-image-repeat:space space;}\n.css-13sl0e3{border-image:url(\"foo.png\") 10;}\n.css-17cc16s{border-image:url(\"foo.png\") 10%;}\n.css-slk48c{border-image:url(\"foo.png\") 10% fill;}\n.css-lnndfl{border-image:url(\"foo.png\") 10 round;}\n.css-bloh1n{border-image:url(\"foo.png\") 10 stretch repeat;}\n.css-h8vdj4{border-image:url(\"foo.png\") 10 / 10px;}\n.css-1oqx17x{border-image:url(\"foo.png\") 10 / 10% / 10px;}\n.css-35zcfy{border-image:url(\"foo.png\") fill 10 / 10% / 10px;}\n.css-1oe30nn{border-image:url(\"foo.png\") fill 10 / 10% / 10px space;}\n.css-gokeqi{box-shadow:none;}\n.css-3sye8k{box-shadow:1px 1px;}\n.css-i2r8u1{box-shadow:0 0 black;}\n.css-1r1uemi{box-shadow:1px 2px 3px;}\n.css-1wumflx{box-shadow:1px 2px 3px black;}\n.css-13956p9{box-shadow:1px 2px 3px 4px;}\n.css-dvxcnx{box-shadow:1px 2px 3px 4px black;}\n.css-1scios5{box-shadow:inset 1px 1px;}\n.css-1qf5tpn{box-shadow:inset 0 0 black;}\n.css-1r7izzs{box-shadow:inset 1px 2px 3px;}\n.css-19gyjsg{box-shadow:inset 1px 2px 3px black;}\n.css-z4khnb{box-shadow:inset 1px 2px 3px 4px;}\n.css-1jw3f6l{box-shadow:inset 1px 2px 3px 4px black;}\n.css-yqotsx{box-shadow:inset 1px 2px 3px 4px black, 1px 2px 3px 4px black;}\n.css-ce85p6{box-shadow:1px 1px, inset 2px 2px red;}\n.css-1q5q314{box-shadow:0 0 5px, inset 0 0 10px black;}\n.css-1jv2nfr{background-position-x:right;}\n.css-1fivq06{background-position-x:center;}\n.css-hxcezg{background-position-x:50%;}\n.css-11xe8x4{background-position-x:left, left;}\n.css-g4em91{background-position-x:left, right;}\n.css-1v9h4p{background-position-x:right, left;}\n.css-1ytz26j{background-position-x:left, 0%;}\n.css-a7bcib{background-position-x:10%, 20%, 40%;}\n.css-f8ehso{background-position-x:0px;}\n.css-n3vpvo{background-position-x:30px;}\n.css-1lsjlye{background-position-x:0%, 10%, 20%, 30%;}\n.css-1r6uvjq{background-position-x:left, left, left, left, left;}\n.css-14w1f37{background-position-x:calc(20px);}\n.css-lz1ldt{background-position-x:calc(20px + 1em);}\n.css-99w4iu{background-position-x:calc(20px / 2);}\n.css-1sok1yt{background-position-x:calc(20px + 50%);}\n.css-16z363d{background-position-x:calc(50% - 10px);}\n.css-13x78wf{background-position-x:calc(-20px);}\n.css-1lryx3{background-position-x:calc(-50%);}\n.css-55be59{background-position-x:calc(-20%);}\n.css-1p57w9s{background-position-x:right 20px;}\n.css-o38n01{background-position-x:left 20px;}\n.css-18df6oz{background-position-x:right -50px;}\n.css-ckata8{background-position-x:left -50px;}\n.css-7bxup1{background-position-y:bottom;}\n.css-1it9ewh{background-position-y:center;}\n.css-wahsum{background-position-y:50%;}\n.css-2u04xu{background-position-y:top, top;}\n.css-19mqqtz{background-position-y:top, bottom;}\n.css-13w54xk{background-position-y:bottom, top;}\n.css-1c7d2k{background-position-y:top, 0%;}\n.css-m293ok{background-position-y:10%, 20%, 40%;}\n.css-1gbcs51{background-position-y:0px;}\n.css-1it2wtl{background-position-y:30px;}\n.css-rgd3sd{background-position-y:0%, 10%, 20%, 30%;}\n.css-jdfv8k{background-position-y:top, top, top, top, top;}\n.css-1xo2yw6{background-position-y:calc(20px);}\n.css-nnpdqz{background-position-y:calc(20px + 1em);}\n.css-1ey8w9h{background-position-y:calc(20px / 2);}\n.css-1azkkb2{background-position-y:calc(20px + 50%);}\n.css-uedt8x{background-position-y:calc(50% - 10px);}\n.css-d5c0ip{background-position-y:calc(-20px);}\n.css-p4ckm0{background-position-y:calc(-50%);}\n.css-1xyw002{background-position-y:calc(-20%);}\n.css-70z8v2{background-position-y:bottom 20px;}\n.css-1x42qfz{background-position-y:top 20px;}\n.css-esmhad{background-position-y:bottom -50px;}\n.css-1uc0o43{background-position-y:top -50px;}\n.css-1iwhz2r{background-image:linear-gradient(45deg, blue, red);}\n.css-1kbqfjp{background-image:linear-gradient(90deg, blue 10%, red 20%);}\n.css-14mab29{background-image:linear-gradient(90deg, blue 10%, red);}\n.css-1yq1u4d{background-image:linear-gradient(90deg, blue, 10%, red);}\n.css-zcuss4{background-image:linear-gradient(white, black);}\n.css-orn2r8{background-image:linear-gradient(to right, white, black);}\n.css-9mys2x{background-image:linear-gradient(45deg, white, black);}\n.css-snojtb{background-image:linear-gradient(white 50%, black);}\n.css-bw0xs1{background-image:linear-gradient(white, #f06, black);}\n.css-1y1fodl{background-image:radial-gradient(white, black);}\n.css-1bm5i1d{background-image:radial-gradient(circle, white, black);}\n.css-1c5rni{background-image:radial-gradient(ellipse, white, black);}\n.css-frdzbz{background-image:radial-gradient(farthest-side, white, black);}\n.css-1sffl0e{background-image:radial-gradient(50%, white, black);}\n.css-e75uiv{background-image:radial-gradient(60% 60%, white, black);}\n.css-1xwird3{list-style-image:linear-gradient(white, black);}\n.css-lyeq2u{list-style-image:linear-gradient(to right, white, black);}\n.css-1c77x4a{list-style-image:linear-gradient(45deg, white, black);}\n.css-20kxhc{list-style-image:linear-gradient(white 50%, black);}\n.css-14r74rj{list-style-image:linear-gradient(white 5px, black);}\n.css-a5c0fc{list-style-image:linear-gradient(white, #f06, black);}\n.css-jpualz{list-style-image:linear-gradient(currentColor, black);}\n.css-1dt7vp0{list-style-image:radial-gradient(white, black);}\n.css-zdkg5x{list-style-image:radial-gradient(circle, white, black);}\n.css-a242dq{list-style-image:radial-gradient(ellipse, white, black);}\n.css-icouy8{list-style-image:radial-gradient(closest-corner, white, black);}\n.css-14ibp18{list-style-image:radial-gradient(farthest-side, white, black);}\n.css-3m0ihr{list-style-image:radial-gradient(50%, white, black);}\n.css-w08tou{list-style-image:radial-gradient(60% 60%, white, black);}\n.css-11tobub{image-rendering:auto;}\n.css-1hc7xqd{image-rendering:smooth;}\n.css-but5e9{image-rendering:high-quality;}\n.css-fjhmlf{image-rendering:pixelated;}\n.css-1e7m01f{image-rendering:crisp-edges;}\n.css-1jvylgn{background-position:bottom;}\n.css-1oiniqy{background-position-y:0;}\n.css-121ueyu{background-position:0 0;}\n.css-yq3hnb{background-position:1rem 0;}\n.css-1rldqt2{background-position:bottom 10px right;}\n.css-24z38j{background-position:bottom 10px right 20px;}\n.css-1h2n9c9{background-position:0 0, center;}\n.css-n81h4k{object-position:top ;}\n.css-7fkzlz{object-position:bottom ;}\n.css-ymgga3{object-position:left ;}\n.css-1w8iwfs{object-position:right ;}\n.css-19v17nb{object-position:center ;}\n.css-18x56gd{object-position:25% 75% ;}\n.css-b4h1sw{object-position:25% ;}\n.css-16v4000{object-position:0 0 ;}\n.css-kz9n4e{object-position:1cm 2cm ;}\n.css-14d8bq0{object-position:10ch 8em ;}\n.css-uvxj01{object-position:bottom 10px right 20px ;}\n.css-o5jbis{object-position:right 3em bottom 10px ;}\n.css-xhzfzt{object-position:top 0 right 10px ;}\n.css-1l3159e{object-position:inherit ;}\n.css-4m3t5s{object-position:initial ;}\n.css-1j5c605{object-position:revert ;}\n.css-2a3742{object-position:revert-layer ;}\n.css-6lnld3{object-position:unset ;}\n"
  ];
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
  [%ocaml.error
    "Property 'border-radius' has an invalid value: ' 2px 4px', Unexpected trailing input '4px'."
  ];
  [%ocaml.error
    "Property 'border-radius' has an invalid value: ' 2px 4px 8px', Unexpected trailing input '4px 8px'."
  ];
  [%ocaml.error
    "Property 'border-radius' has an invalid value: ' 2px 4px 8px 16px', Unexpected trailing input '4px 8px 16px'."
  ];
  [%ocaml.error
    "Property 'border-radius' has an invalid value: ' 10px / 20px', Unexpected trailing input '/ 20px'."
  ];
  [%ocaml.error
    "Property 'border-radius' has an invalid value: ' 2px 4px 8px 16px / 2px 4px 8px 16px', Unexpected trailing input '4px 8px 16px / 2px 4px 8px 16px'."
  ];
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

