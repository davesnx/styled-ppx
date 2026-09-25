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
  [@css ".a-3903kdbzm{background-repeat:space;}"];
  [@css ".a-3903kwgys{background-repeat:round;}"];
  [@css ".a-3903kpiw6{background-repeat:repeat repeat;}"];
  [@css ".a-3903kxji5{background-repeat:space repeat;}"];
  [@css ".a-3903k0kx7{background-repeat:round repeat;}"];
  [@css ".a-3903kqiir{background-repeat:no-repeat repeat;}"];
  [@css ".a-3903kff62{background-repeat:repeat space;}"];
  [@css ".a-3903klrh1{background-repeat:space space;}"];
  [@css ".a-3903kzuyd{background-repeat:round space;}"];
  [@css ".a-3903ko3tu{background-repeat:no-repeat space;}"];
  [@css ".a-3903k2l1t{background-repeat:repeat round;}"];
  [@css ".a-3903kpz8i{background-repeat:space round;}"];
  [@css ".a-3903kvp4f{background-repeat:round round;}"];
  [@css ".a-3903kttlz{background-repeat:no-repeat round;}"];
  [@css ".a-3903k95y1{background-repeat:repeat no-repeat;}"];
  [@css ".a-3903kyae4{background-repeat:space no-repeat;}"];
  [@css ".a-3903khx0d{background-repeat:round no-repeat;}"];
  [@css ".a-3903kr6kt{background-repeat:no-repeat no-repeat;}"];
  [@css ".a-3903kbp5t{background-repeat:repeat-x, repeat-y;}"];
  [@css ".a-39001p2j1{background-attachment:local;}"];
  [@css
    ".a-390024kwg{-webkit-background-clip:border-box;background-clip:border-box;}"
  ];
  [@css
    ".a-390025w5o{-webkit-background-clip:padding-box;background-clip:padding-box;}"
  ];
  [@css
    ".a-3900250rv{-webkit-background-clip:content-box;background-clip:content-box;}"
  ];
  [@css ".a-390028734{-webkit-background-clip:text;background-clip:text;}"];
  [@css
    ".a-390025rmj{-webkit-background-clip:border-area;background-clip:border-area;}"
  ];
  [@css
    ".a-3900245y6{-webkit-background-clip:text, border-area;background-clip:text, border-area;}"
  ];
  [@css ".a-3900gkwyo{background-origin:border-box;}"];
  [@css ".a-3900gr9hb{background-origin:padding-box;}"];
  [@css ".a-3900gwo89{background-origin:content-box;}"];
  [@css ".a-390744aob{background-size:auto;}"];
  [@css ".a-39074k97u{background-size:cover;}"];
  [@css ".a-39074xylo{background-size:contain;}"];
  [@css ".a-39074m5qu{background-size:10px;}"];
  [@css ".a-39074u6v3{background-size:50%;}"];
  [@css ".a-39074xytx{background-size:10px auto;}"];
  [@css ".a-39074a9zh{background-size:auto 10%;}"];
  [@css ".a-390744rix{background-size:50em 50%;}"];
  [@css ".a-39074zw1h{background-size:20px 20px;}"];
  [@css ".a-39o254{background:top left / 50% 60%;}"];
  [@css ".a-39vagn{background:border-box;}"];
  [@css ".a-392d75{background:blue;}"];
  [@css ".a-39hvrj{background:border-box red;}"];
  [@css ".a-39lssi{background:border-box padding-box;}"];
  [@css
    ".a-39uq7y{background:url(\"foo.png\") bottom right / cover padding-box content-box;}"
  ];
  [@css ".a-3n004ffk7{border-top-left-radius:0;}"];
  [@css ".a-3n004y41g{border-top-left-radius:50%;}"];
  [@css ".a-3n004ccvj{border-top-left-radius:250px 100px;}"];
  [@css ".a-3n008ozmz{border-top-right-radius:0;}"];
  [@css ".a-3n008h6x9{border-top-right-radius:50%;}"];
  [@css ".a-3n0080ho1{border-top-right-radius:250px 100px;}"];
  [@css ".a-3n002m6su{border-bottom-right-radius:0;}"];
  [@css ".a-3n0025ugq{border-bottom-right-radius:50%;}"];
  [@css ".a-3n0028l07{border-bottom-right-radius:250px 100px;}"];
  [@css ".a-3n001vopp{border-bottom-left-radius:0;}"];
  [@css ".a-3n001z4ix{border-bottom-left-radius:50%;}"];
  [@css ".a-3n001fj6a{border-bottom-left-radius:250px 100px;}"];
  [@css ".a-3nv389{border-radius:10px;}"];
  [@css ".a-3ndor8{border-radius:50%;}"];
  [@css ".a-3nok9k{border-radius:2px 4px;}"];
  [@css ".a-3nl4dm{border-radius:2px 4px 8px;}"];
  [@css ".a-3nbni5{border-radius:2px 4px 8px 16px;}"];
  [@css ".a-3nk2xe{border-radius:10px / 20px;}"];
  [@css ".a-3n5w7s{border-radius:2px 4px 8px 16px / 2px 4px 8px 16px;}"];
  [@css ".a-3h01s67n4{border-image-source:none;}"];
  [@css ".a-3h01s2djw{border-image-source:url(\"foo.png\");}"];
  [@css ".a-3h00w8fag{border-image-slice:10;}"];
  [@css ".a-3h00wou03{border-image-slice:30%;}"];
  [@css ".a-3h00wp0ma{border-image-slice:10 10;}"];
  [@css ".a-3h00wblsp{border-image-slice:30% 10;}"];
  [@css ".a-3h00w5gxt{border-image-slice:10 30%;}"];
  [@css ".a-3h00wpwt3{border-image-slice:30% 30%;}"];
  [@css ".a-3h00wg3fs{border-image-slice:10 10 10;}"];
  [@css ".a-3h00wb146{border-image-slice:30% 10 10;}"];
  [@css ".a-3h00wyk9k{border-image-slice:10 30% 10;}"];
  [@css ".a-3h00wdy38{border-image-slice:30% 30% 10;}"];
  [@css ".a-3h00wfa9m{border-image-slice:10 10 30%;}"];
  [@css ".a-3h00wz16p{border-image-slice:30% 10 30%;}"];
  [@css ".a-3h00w8zfs{border-image-slice:10 30% 30%;}"];
  [@css ".a-3h00wuel6{border-image-slice:30% 30% 30%;}"];
  [@css ".a-3h00w27b9{border-image-slice:10 10 10 10;}"];
  [@css ".a-3h00wciru{border-image-slice:30% 10 10 10;}"];
  [@css ".a-3h00wj984{border-image-slice:10 30% 10 10;}"];
  [@css ".a-3h00weygg{border-image-slice:30% 30% 10 10;}"];
  [@css ".a-3h00wu8vs{border-image-slice:10 10 30% 10;}"];
  [@css ".a-3h00w4ctj{border-image-slice:30% 10 30% 10;}"];
  [@css ".a-3h00wrqu8{border-image-slice:10 30% 30% 10;}"];
  [@css ".a-3h00w535k{border-image-slice:30% 30% 30% 10;}"];
  [@css ".a-3h00wmqly{border-image-slice:10 10 10 30%;}"];
  [@css ".a-3h00w334v{border-image-slice:30% 10 10 30%;}"];
  [@css ".a-3h00w10it{border-image-slice:10 30% 10 30%;}"];
  [@css ".a-3h00w24bv{border-image-slice:30% 30% 10 30%;}"];
  [@css ".a-3h00woopq{border-image-slice:10 10 30% 30%;}"];
  [@css ".a-3h00wc6k6{border-image-slice:30% 10 30% 30%;}"];
  [@css ".a-3h00wce7t{border-image-slice:10 30% 30% 30%;}"];
  [@css ".a-3h00w3xq3{border-image-slice:30% 30% 30% 30%;}"];
  [@css ".a-3h00wpp7o{border-image-slice:fill 30%;}"];
  [@css ".a-3h00wsoql{border-image-slice:fill 10;}"];
  [@css ".a-3h00wljby{border-image-slice:fill 2 4 8% 16%;}"];
  [@css ".a-3h00wb5be{border-image-slice:30% fill;}"];
  [@css ".a-3h00wse3r{border-image-slice:10 fill;}"];
  [@css ".a-3h00wst01{border-image-slice:2 4 8% 16% fill;}"];
  [@css ".a-3h03kmtq7{border-image-width:10px;}"];
  [@css ".a-3h03k2lna{border-image-width:5%;}"];
  [@css ".a-3h03kvskx{border-image-width:28;}"];
  [@css ".a-3h03k12to{border-image-width:auto;}"];
  [@css ".a-3h03kqzt3{border-image-width:10px 10px;}"];
  [@css ".a-3h03k1b9l{border-image-width:5% 10px;}"];
  [@css ".a-3h03ka5d6{border-image-width:28 10px;}"];
  [@css ".a-3h03kgsb5{border-image-width:auto 10px;}"];
  [@css ".a-3h03ktfkm{border-image-width:10px 5%;}"];
  [@css ".a-3h03kfrk8{border-image-width:5% 5%;}"];
  [@css ".a-3h03ksgtx{border-image-width:28 5%;}"];
  [@css ".a-3h03ko8wy{border-image-width:auto 5%;}"];
  [@css ".a-3h03kyjgi{border-image-width:10px 28;}"];
  [@css ".a-3h03k05n6{border-image-width:5% 28;}"];
  [@css ".a-3h03kpian{border-image-width:28 28;}"];
  [@css ".a-3h03k7o1w{border-image-width:auto 28;}"];
  [@css ".a-3h03kbki1{border-image-width:10px auto;}"];
  [@css ".a-3h03ksfme{border-image-width:5% auto;}"];
  [@css ".a-3h03klhmj{border-image-width:28 auto;}"];
  [@css ".a-3h03kiwnw{border-image-width:auto auto;}"];
  [@css ".a-3h03k1i6r{border-image-width:10px 10% 10;}"];
  [@css ".a-3h03k03j7{border-image-width:5% 10px 20 auto;}"];
  [@css ".a-3h008lw5x{border-image-outset:10px;}"];
  [@css ".a-3h008x2bn{border-image-outset:20;}"];
  [@css ".a-3h008jka5{border-image-outset:10px 20;}"];
  [@css ".a-3h008v07i{border-image-outset:10px 20px;}"];
  [@css ".a-3h008ixn9{border-image-outset:20 30;}"];
  [@css ".a-3h0083q5z{border-image-outset:2px 3px 4;}"];
  [@css ".a-3h008dhma{border-image-outset:1 2px 3px 4;}"];
  [@css ".a-3h00g8amr{border-image-repeat:stretch;}"];
  [@css ".a-3h00gvfhi{border-image-repeat:repeat;}"];
  [@css ".a-3h00gsbb7{border-image-repeat:round;}"];
  [@css ".a-3h00gfada{border-image-repeat:space;}"];
  [@css ".a-3h00g930f{border-image-repeat:stretch stretch;}"];
  [@css ".a-3h00gipsj{border-image-repeat:repeat stretch;}"];
  [@css ".a-3h00gh3hn{border-image-repeat:round stretch;}"];
  [@css ".a-3h00g3d92{border-image-repeat:space stretch;}"];
  [@css ".a-3h00g5f3q{border-image-repeat:stretch repeat;}"];
  [@css ".a-3h00gdrj5{border-image-repeat:repeat repeat;}"];
  [@css ".a-3h00g6kfj{border-image-repeat:round repeat;}"];
  [@css ".a-3h00gahlj{border-image-repeat:space repeat;}"];
  [@css ".a-3h00gd86l{border-image-repeat:stretch round;}"];
  [@css ".a-3h00g5ktc{border-image-repeat:repeat round;}"];
  [@css ".a-3h00gllwt{border-image-repeat:round round;}"];
  [@css ".a-3h00geu9k{border-image-repeat:space round;}"];
  [@css ".a-3h00gorbo{border-image-repeat:stretch space;}"];
  [@css ".a-3h00gcpic{border-image-repeat:repeat space;}"];
  [@css ".a-3h00g2bpm{border-image-repeat:round space;}"];
  [@css ".a-3h00giv0g{border-image-repeat:space space;}"];
  [@css ".a-3h06wl0e3{border-image:url(\"foo.png\") 10;}"];
  [@css ".a-3h06wc16s{border-image:url(\"foo.png\") 10%;}"];
  [@css ".a-3h06wk48c{border-image:url(\"foo.png\") 10% fill;}"];
  [@css ".a-3h06wndfl{border-image:url(\"foo.png\") 10 round;}"];
  [@css ".a-3h06woh1n{border-image:url(\"foo.png\") 10 stretch repeat;}"];
  [@css ".a-3h06wvdj4{border-image:url(\"foo.png\") 10 / 10px;}"];
  [@css ".a-3h06wx17x{border-image:url(\"foo.png\") 10 / 10% / 10px;}"];
  [@css ".a-3h06wzcfy{border-image:url(\"foo.png\") fill 10 / 10% / 10px;}"];
  [@css
    ".a-3h06w30nn{border-image:url(\"foo.png\") fill 10 / 10% / 10px space;}"
  ];
  [@css ".a-40keqi{box-shadow:none;}"];
  [@css ".a-40ye8k{box-shadow:1px 1px;}"];
  [@css ".a-40r8u1{box-shadow:0 0 black;}"];
  [@css ".a-40uemi{box-shadow:1px 2px 3px;}"];
  [@css ".a-40mflx{box-shadow:1px 2px 3px black;}"];
  [@css ".a-4056p9{box-shadow:1px 2px 3px 4px;}"];
  [@css ".a-40xcnx{box-shadow:1px 2px 3px 4px black;}"];
  [@css ".a-40ios5{box-shadow:inset 1px 1px;}"];
  [@css ".a-405tpn{box-shadow:inset 0 0 black;}"];
  [@css ".a-40izzs{box-shadow:inset 1px 2px 3px;}"];
  [@css ".a-40yjsg{box-shadow:inset 1px 2px 3px black;}"];
  [@css ".a-40khnb{box-shadow:inset 1px 2px 3px 4px;}"];
  [@css ".a-403f6l{box-shadow:inset 1px 2px 3px 4px black;}"];
  [@css
    ".a-40otsx{box-shadow:inset 1px 2px 3px 4px black, 1px 2px 3px 4px black;}"
  ];
  [@css ".a-4085p6{box-shadow:1px 1px, inset 2px 2px red;}"];
  [@css ".a-40q314{box-shadow:0 0 5px, inset 0 0 10px black;}"];
  [@css
    ".in-1cg0xa4{box-shadow:-1px 1px 0px 0px var(--elevation1-xawwdw_1), 1px 1px 0px 0px var(--elevation1-xawwdw_2), 0px -1px 0px 0px var(--elevation1-xawwdw_3);}"
  ];
  [@css ".a-3900w2nfr{background-position-x:right;}"];
  [@css ".a-3900wvq06{background-position-x:center;}"];
  [@css ".a-3900wcezg{background-position-x:50%;}"];
  [@css ".a-3900we8x4{background-position-x:left, left;}"];
  [@css ".a-3900wem91{background-position-x:left, right;}"];
  [@css ".a-3900w9h4p{background-position-x:right, left;}"];
  [@css ".a-3900wz26j{background-position-x:left, 0%;}"];
  [@css ".a-3900wbcib{background-position-x:10%, 20%, 40%;}"];
  [@css ".a-3900wehso{background-position-x:0px;}"];
  [@css ".a-3900wvpvo{background-position-x:30px;}"];
  [@css ".a-3900wjlye{background-position-x:0%, 10%, 20%, 30%;}"];
  [@css ".a-3900wuvjq{background-position-x:left, left, left, left, left;}"];
  [@css ".a-3900w1f37{background-position-x:calc(20px);}"];
  [@css ".a-3900w1ldt{background-position-x:calc(20px + 1em);}"];
  [@css ".a-3900ww4iu{background-position-x:calc(20px / 2);}"];
  [@css ".a-3900wk1yt{background-position-x:calc(20px + 50%);}"];
  [@css ".a-3900w363d{background-position-x:calc(50% - 10px);}"];
  [@css ".a-3900w78wf{background-position-x:calc(-20px);}"];
  [@css ".a-3900wryx3{background-position-x:calc(-50%);}"];
  [@css ".a-3900wbe59{background-position-x:calc(-20%);}"];
  [@css ".a-3900w7w9s{background-position-x:right 20px;}"];
  [@css ".a-3900w8n01{background-position-x:left 20px;}"];
  [@css ".a-3900wf6oz{background-position-x:right -50px;}"];
  [@css ".a-3900wata8{background-position-x:left -50px;}"];
  [@css ".a-3901sxup1{background-position-y:bottom;}"];
  [@css ".a-3901s9ewh{background-position-y:center;}"];
  [@css ".a-3901shsum{background-position-y:50%;}"];
  [@css ".a-3901s04xu{background-position-y:top, top;}"];
  [@css ".a-3901sqqtz{background-position-y:top, bottom;}"];
  [@css ".a-3901s54xk{background-position-y:bottom, top;}"];
  [@css ".a-3901s7d2k{background-position-y:top, 0%;}"];
  [@css ".a-3901s93ok{background-position-y:10%, 20%, 40%;}"];
  [@css ".a-3901scs51{background-position-y:0px;}"];
  [@css ".a-3901s2wtl{background-position-y:30px;}"];
  [@css ".a-3901sd3sd{background-position-y:0%, 10%, 20%, 30%;}"];
  [@css ".a-3901sfv8k{background-position-y:top, top, top, top, top;}"];
  [@css ".a-3901s2yw6{background-position-y:calc(20px);}"];
  [@css ".a-3901spdqz{background-position-y:calc(20px + 1em);}"];
  [@css ".a-3901s8w9h{background-position-y:calc(20px / 2);}"];
  [@css ".a-3901skkb2{background-position-y:calc(20px + 50%);}"];
  [@css ".a-3901sdt8x{background-position-y:calc(50% - 10px);}"];
  [@css ".a-3901sc0ip{background-position-y:calc(-20px);}"];
  [@css ".a-3901sckm0{background-position-y:calc(-50%);}"];
  [@css ".a-3901sw002{background-position-y:calc(-20%);}"];
  [@css ".a-3901sz8v2{background-position-y:bottom 20px;}"];
  [@css ".a-3901s2qfz{background-position-y:top 20px;}"];
  [@css ".a-3901smhad{background-position-y:bottom -50px;}"];
  [@css ".a-3901s0o43{background-position-y:top -50px;}"];
  [@css ".a-39008hz2r{background-image:linear-gradient(45deg, blue, red);}"];
  [@css
    ".a-39008qfjp{background-image:linear-gradient(90deg, blue 10%, red 20%);}"
  ];
  [@css ".a-39008ab29{background-image:linear-gradient(90deg, blue 10%, red);}"];
  [@css
    ".a-390081u4d{background-image:linear-gradient(90deg, blue, 10%, red);}"
  ];
  [@css ".a-39008uss4{background-image:linear-gradient(white, black);}"];
  [@css
    ".a-39008n2r8{background-image:linear-gradient(to right, white, black);}"
  ];
  [@css ".a-39008ys2x{background-image:linear-gradient(45deg, white, black);}"];
  [@css ".a-39008ojtb{background-image:linear-gradient(white 50%, black);}"];
  [@css ".a-390080xs1{background-image:linear-gradient(white, #f06, black);}"];
  [@css
    ".a-39008yimv{background-image:linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);}"
  ];
  [@css
    ".a-39008fmes{background-image:linear-gradient(45deg, blue, red), linear-gradient(red -50px, white calc(-25px + 50%), blue 100%), linear-gradient(45deg, blue, red);}"
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
  [@css ".a-39008fodl{background-image:radial-gradient(white, black);}"];
  [@css ".a-390085i1d{background-image:radial-gradient(circle, white, black);}"];
  [@css
    ".a-390085rni{background-image:radial-gradient(ellipse, white, black);}"
  ];
  [@css
    ".a-39008nqg5{background-image:radial-gradient(circle closest-corner, white, black);}"
  ];
  [@css
    ".a-39008dzbz{background-image:radial-gradient(farthest-side, white, black);}"
  ];
  [@css
    ".a-390081b7p{background-image:radial-gradient(circle farthest-side, white, black);}"
  ];
  [@css ".a-39008fl0e{background-image:radial-gradient(50%, white, black);}"];
  [@css
    ".a-390085uiv{background-image:radial-gradient(60% 60%, white, black);}"
  ];
  [@css ".a-7o001ird3{list-style-image:linear-gradient(white, black);}"];
  [@css
    ".a-7o001eq2u{list-style-image:linear-gradient(to right, white, black);}"
  ];
  [@css ".a-7o0017x4a{list-style-image:linear-gradient(45deg, white, black);}"];
  [@css ".a-7o001kxhc{list-style-image:linear-gradient(white 50%, black);}"];
  [@css ".a-7o00174rj{list-style-image:linear-gradient(white 5px, black);}"];
  [@css ".a-7o001c0fc{list-style-image:linear-gradient(white, #f06, black);}"];
  [@css ".a-7o001ualz{list-style-image:linear-gradient(currentColor, black);}"];
  [@css
    ".a-7o0018cv6{list-style-image:linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);}"
  ];
  [@css ".a-7o0017vp0{list-style-image:radial-gradient(white, black);}"];
  [@css ".a-7o001kg5x{list-style-image:radial-gradient(circle, white, black);}"];
  [@css
    ".a-7o00142dq{list-style-image:radial-gradient(ellipse, white, black);}"
  ];
  [@css
    ".a-7o001ouy8{list-style-image:radial-gradient(closest-corner, white, black);}"
  ];
  [@css
    ".a-7o001zi1j{list-style-image:radial-gradient(circle closest-corner, white, black);}"
  ];
  [@css
    ".a-7o001bp18{list-style-image:radial-gradient(farthest-side, white, black);}"
  ];
  [@css
    ".a-7o001bl3b{list-style-image:radial-gradient(circle farthest-side, white, black);}"
  ];
  [@css ".a-7o0010ihr{list-style-image:radial-gradient(50%, white, black);}"];
  [@css
    ".a-7o0018tou{list-style-image:radial-gradient(60% 60%, white, black);}"
  ];
  [@css ".a-6tobub{image-rendering:auto;}"];
  [@css ".a-6t7xqd{image-rendering:smooth;}"];
  [@css ".a-6tt5e9{image-rendering:high-quality;}"];
  [@css ".a-6thmlf{image-rendering:pixelated;}"];
  [@css ".a-6tm01f{image-rendering:crisp-edges;}"];
  [@css ".a-3902oylgn{background-position:bottom;}"];
  [@css ".a-3901sniqy{background-position-y:0;}"];
  [@css ".a-3902oueyu{background-position:0 0;}"];
  [@css ".a-3902o3hnb{background-position:1rem 0;}"];
  [@css ".a-3902odqt2{background-position:bottom 10px right;}"];
  [@css ".a-3902oz38j{background-position:bottom 10px right 20px;}"];
  [@css ".a-3902on9c9{background-position:0 0, center;}"];
  [@css ".a-8jqhry{object-position:top;}"];
  [@css ".a-8ju2x3{object-position:bottom;}"];
  [@css ".a-8jx73u{object-position:left;}"];
  [@css ".a-8jcm6t{object-position:right;}"];
  [@css ".a-8jlpb4{object-position:center;}"];
  [@css ".a-8jh0g1{object-position:25% 75%;}"];
  [@css ".a-8jlnwd{object-position:25%;}"];
  [@css ".a-8j0ddq{object-position:0 0;}"];
  [@css ".a-8jopaa{object-position:1cm 2cm;}"];
  [@css ".a-8jenxt{object-position:10ch 8em;}"];
  [@css ".a-8jase9{object-position:bottom 10px right 20px;}"];
  [@css ".a-8jana2{object-position:right 3em bottom 10px;}"];
  [@css ".a-8j11ag{object-position:top 0 right 10px;}"];
  [@css ".a-8jhhjc{object-position:inherit;}"];
  [@css ".a-8jj4w6{object-position:initial;}"];
  [@css ".a-8j6ns1{object-position:revert;}"];
  [@css ".a-8jjpx4{object-position:revert-layer;}"];
  [@css ".a-8j4k9o{object-position:unset;}"];
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
  
  CSS.make("a-3903kdbzm", []);
  CSS.make("a-3903kwgys", []);
  CSS.make("a-3903kpiw6", []);
  CSS.make("a-3903kxji5", []);
  CSS.make("a-3903k0kx7", []);
  CSS.make("a-3903kqiir", []);
  CSS.make("a-3903kff62", []);
  CSS.make("a-3903klrh1", []);
  CSS.make("a-3903kzuyd", []);
  CSS.make("a-3903ko3tu", []);
  CSS.make("a-3903k2l1t", []);
  CSS.make("a-3903kpz8i", []);
  CSS.make("a-3903kvp4f", []);
  CSS.make("a-3903kttlz", []);
  CSS.make("a-3903k95y1", []);
  CSS.make("a-3903kyae4", []);
  CSS.make("a-3903khx0d", []);
  CSS.make("a-3903kr6kt", []);
  CSS.make("a-3903kbp5t", []);
  CSS.make("a-39001p2j1", []);
  CSS.make("a-390024kwg", []);
  CSS.make("a-390025w5o", []);
  CSS.make("a-3900250rv", []);
  CSS.make("a-390028734", []);
  CSS.make("a-390025rmj", []);
  CSS.make("a-3900245y6", []);
  CSS.make("a-3900gkwyo", []);
  CSS.make("a-3900gr9hb", []);
  CSS.make("a-3900gwo89", []);
  CSS.make("a-390744aob", []);
  CSS.make("a-39074k97u", []);
  CSS.make("a-39074xylo", []);
  CSS.make("a-39074m5qu", []);
  CSS.make("a-39074u6v3", []);
  CSS.make("a-39074xytx", []);
  CSS.make("a-39074a9zh", []);
  CSS.make("a-390744rix", []);
  CSS.make("a-39074zw1h", []);
  
  CSS.make("a-39o254", []);
  CSS.make("a-39vagn", []);
  CSS.make("a-392d75", []);
  CSS.make("a-39hvrj", []);
  
  CSS.make("a-39lssi", []);
  CSS.make("a-39uq7y", []);
  CSS.make("a-3n004ffk7", []);
  CSS.make("a-3n004y41g", []);
  CSS.make("a-3n004ccvj", []);
  CSS.make("a-3n008ozmz", []);
  CSS.make("a-3n008h6x9", []);
  CSS.make("a-3n0080ho1", []);
  CSS.make("a-3n002m6su", []);
  CSS.make("a-3n0025ugq", []);
  CSS.make("a-3n0028l07", []);
  CSS.make("a-3n001vopp", []);
  CSS.make("a-3n001z4ix", []);
  CSS.make("a-3n001fj6a", []);
  CSS.make("a-3nv389", []);
  CSS.make("a-3ndor8", []);
  CSS.make("a-3nok9k", []);
  CSS.make("a-3nl4dm", []);
  CSS.make("a-3nbni5", []);
  CSS.make("a-3nk2xe", []);
  CSS.make("a-3n5w7s", []);
  CSS.make("a-3h01s67n4", []);
  CSS.make("a-3h01s2djw", []);
  CSS.make("a-3h00w8fag", []);
  CSS.make("a-3h00wou03", []);
  CSS.make("a-3h00wp0ma", []);
  CSS.make("a-3h00wblsp", []);
  CSS.make("a-3h00w5gxt", []);
  CSS.make("a-3h00wpwt3", []);
  CSS.make("a-3h00wg3fs", []);
  CSS.make("a-3h00wb146", []);
  CSS.make("a-3h00wyk9k", []);
  CSS.make("a-3h00wdy38", []);
  CSS.make("a-3h00wfa9m", []);
  CSS.make("a-3h00wz16p", []);
  CSS.make("a-3h00w8zfs", []);
  CSS.make("a-3h00wuel6", []);
  CSS.make("a-3h00w27b9", []);
  CSS.make("a-3h00wciru", []);
  CSS.make("a-3h00wj984", []);
  CSS.make("a-3h00weygg", []);
  CSS.make("a-3h00wu8vs", []);
  CSS.make("a-3h00w4ctj", []);
  CSS.make("a-3h00wrqu8", []);
  CSS.make("a-3h00w535k", []);
  CSS.make("a-3h00wmqly", []);
  CSS.make("a-3h00w334v", []);
  CSS.make("a-3h00w10it", []);
  CSS.make("a-3h00w24bv", []);
  CSS.make("a-3h00woopq", []);
  CSS.make("a-3h00wc6k6", []);
  CSS.make("a-3h00wce7t", []);
  CSS.make("a-3h00w3xq3", []);
  CSS.make("a-3h00wpp7o", []);
  CSS.make("a-3h00wsoql", []);
  CSS.make("a-3h00wljby", []);
  CSS.make("a-3h00wb5be", []);
  CSS.make("a-3h00wse3r", []);
  CSS.make("a-3h00wst01", []);
  CSS.make("a-3h03kmtq7", []);
  CSS.make("a-3h03k2lna", []);
  CSS.make("a-3h03kvskx", []);
  CSS.make("a-3h03k12to", []);
  CSS.make("a-3h03kqzt3", []);
  CSS.make("a-3h03k1b9l", []);
  CSS.make("a-3h03ka5d6", []);
  CSS.make("a-3h03kgsb5", []);
  CSS.make("a-3h03ktfkm", []);
  CSS.make("a-3h03kfrk8", []);
  CSS.make("a-3h03ksgtx", []);
  CSS.make("a-3h03ko8wy", []);
  CSS.make("a-3h03kyjgi", []);
  CSS.make("a-3h03k05n6", []);
  CSS.make("a-3h03kpian", []);
  CSS.make("a-3h03k7o1w", []);
  CSS.make("a-3h03kbki1", []);
  CSS.make("a-3h03ksfme", []);
  CSS.make("a-3h03klhmj", []);
  CSS.make("a-3h03kiwnw", []);
  CSS.make("a-3h03k1i6r", []);
  CSS.make("a-3h03k03j7", []);
  CSS.make("a-3h008lw5x", []);
  CSS.make("a-3h008x2bn", []);
  CSS.make("a-3h008jka5", []);
  CSS.make("a-3h008v07i", []);
  CSS.make("a-3h008ixn9", []);
  CSS.make("a-3h0083q5z", []);
  CSS.make("a-3h008dhma", []);
  CSS.make("a-3h00g8amr", []);
  CSS.make("a-3h00gvfhi", []);
  CSS.make("a-3h00gsbb7", []);
  CSS.make("a-3h00gfada", []);
  CSS.make("a-3h00g930f", []);
  CSS.make("a-3h00gipsj", []);
  CSS.make("a-3h00gh3hn", []);
  CSS.make("a-3h00g3d92", []);
  CSS.make("a-3h00g5f3q", []);
  CSS.make("a-3h00gdrj5", []);
  CSS.make("a-3h00g6kfj", []);
  CSS.make("a-3h00gahlj", []);
  CSS.make("a-3h00gd86l", []);
  CSS.make("a-3h00g5ktc", []);
  CSS.make("a-3h00gllwt", []);
  CSS.make("a-3h00geu9k", []);
  CSS.make("a-3h00gorbo", []);
  CSS.make("a-3h00gcpic", []);
  CSS.make("a-3h00g2bpm", []);
  CSS.make("a-3h00giv0g", []);
  CSS.make("a-3h06wl0e3", []);
  CSS.make("a-3h06wc16s", []);
  CSS.make("a-3h06wk48c", []);
  CSS.make("a-3h06wndfl", []);
  CSS.make("a-3h06woh1n", []);
  CSS.make("a-3h06wvdj4", []);
  CSS.make("a-3h06wx17x", []);
  CSS.make("a-3h06wzcfy", []);
  CSS.make("a-3h06w30nn", []);
  
  CSS.make("a-40keqi", []);
  
  CSS.make("a-40ye8k", []);
  
  CSS.make("a-40r8u1", []);
  
  CSS.make("a-40uemi", []);
  
  CSS.make("a-40mflx", []);
  
  CSS.make("a-4056p9", []);
  
  CSS.make("a-40xcnx", []);
  
  CSS.make("a-40ios5", []);
  
  CSS.make("a-405tpn", []);
  
  CSS.make("a-40izzs", []);
  
  CSS.make("a-40yjsg", []);
  
  CSS.make("a-40khnb", []);
  
  CSS.make("a-403f6l", []);
  
  CSS.make("a-40otsx", []);
  CSS.make("a-4085p6", []);
  CSS.make("a-40q314", []);
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
  
  CSS.make("a-3900w2nfr", []);
  CSS.make("a-3900wvq06", []);
  CSS.make("a-3900wcezg", []);
  CSS.make("a-3900we8x4", []);
  CSS.make("a-3900wem91", []);
  CSS.make("a-3900w9h4p", []);
  CSS.make("a-3900wz26j", []);
  CSS.make("a-3900wbcib", []);
  CSS.make("a-3900wehso", []);
  CSS.make("a-3900wvpvo", []);
  CSS.make("a-3900wjlye", []);
  CSS.make("a-3900wuvjq", []);
  CSS.make("a-3900w1f37", []);
  CSS.make("a-3900w1ldt", []);
  CSS.make("a-3900ww4iu", []);
  CSS.make("a-3900wk1yt", []);
  CSS.make("a-3900w363d", []);
  CSS.make("a-3900w78wf", []);
  CSS.make("a-3900wryx3", []);
  CSS.make("a-3900wbe59", []);
  CSS.make("a-3900w7w9s", []);
  CSS.make("a-3900w8n01", []);
  CSS.make("a-3900wf6oz", []);
  CSS.make("a-3900wata8", []);
  CSS.make("a-3900w7w9s", []);
  CSS.make("a-3901sxup1", []);
  CSS.make("a-3901s9ewh", []);
  CSS.make("a-3901shsum", []);
  CSS.make("a-3901s04xu", []);
  CSS.make("a-3901sqqtz", []);
  CSS.make("a-3901s54xk", []);
  CSS.make("a-3901s7d2k", []);
  CSS.make("a-3901s93ok", []);
  CSS.make("a-3901scs51", []);
  CSS.make("a-3901s2wtl", []);
  CSS.make("a-3901sd3sd", []);
  CSS.make("a-3901sfv8k", []);
  CSS.make("a-3901s2yw6", []);
  CSS.make("a-3901spdqz", []);
  CSS.make("a-3901s8w9h", []);
  CSS.make("a-3901skkb2", []);
  CSS.make("a-3901sdt8x", []);
  CSS.make("a-3901sc0ip", []);
  CSS.make("a-3901sckm0", []);
  CSS.make("a-3901sw002", []);
  CSS.make("a-3901sz8v2", []);
  CSS.make("a-3901s2qfz", []);
  CSS.make("a-3901smhad", []);
  CSS.make("a-3901s0o43", []);
  CSS.make("a-3901sz8v2", []);
  
  CSS.make("a-39008hz2r", []);
  CSS.make("a-39008qfjp", []);
  CSS.make("a-39008ab29", []);
  CSS.make("a-390081u4d", []);
  CSS.make("a-39008uss4", []);
  CSS.make("a-39008n2r8", []);
  CSS.make("a-39008ys2x", []);
  CSS.make("a-39008ojtb", []);
  CSS.make("a-390080xs1", []);
  CSS.make("a-39008yimv", []);
  CSS.make("a-39008fmes", []);
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
  
  CSS.make("a-39008fodl", []);
  CSS.make("a-390085i1d", []);
  CSS.make("a-390085rni", []);
  CSS.make("a-39008nqg5", []);
  CSS.make("a-39008dzbz", []);
  CSS.make("a-390081b7p", []);
  CSS.make("a-39008fl0e", []);
  CSS.make("a-390085uiv", []);
  
  CSS.make("a-7o001ird3", []);
  CSS.make("a-7o001eq2u", []);
  CSS.make("a-7o0017x4a", []);
  CSS.make("a-7o001kxhc", []);
  CSS.make("a-7o00174rj", []);
  CSS.make("a-7o001c0fc", []);
  CSS.make("a-7o001ualz", []);
  CSS.make("a-7o0018cv6", []);
  CSS.make("a-7o0017vp0", []);
  CSS.make("a-7o001kg5x", []);
  CSS.make("a-7o00142dq", []);
  CSS.make("a-7o001ouy8", []);
  CSS.make("a-7o001zi1j", []);
  CSS.make("a-7o001bp18", []);
  CSS.make("a-7o001bl3b", []);
  CSS.make("a-7o0010ihr", []);
  CSS.make("a-7o0018tou", []);
  
  CSS.make("a-6tobub", []);
  CSS.make("a-6t7xqd", []);
  CSS.make("a-6tt5e9", []);
  CSS.make("a-6thmlf", []);
  CSS.make("a-6tm01f", []);
  
  CSS.make("a-3902oylgn", []);
  CSS.make("a-3900wcezg", []);
  CSS.make("a-3901sniqy", []);
  CSS.make("a-3902oueyu", []);
  CSS.make("a-3902o3hnb", []);
  CSS.make("a-3902odqt2", []);
  CSS.make("a-3902oz38j", []);
  CSS.make("a-3902on9c9", []);
  
  CSS.make("a-8jqhry", []);
  CSS.make("a-8ju2x3", []);
  CSS.make("a-8jx73u", []);
  CSS.make("a-8jcm6t", []);
  CSS.make("a-8jlpb4", []);
  
  CSS.make("a-8jh0g1", []);
  CSS.make("a-8jlnwd", []);
  
  CSS.make("a-8j0ddq", []);
  CSS.make("a-8jopaa", []);
  CSS.make("a-8jenxt", []);
  
  CSS.make("a-8jase9", []);
  CSS.make("a-8jana2", []);
  CSS.make("a-8j11ag", []);
  
  CSS.make("a-8jhhjc", []);
  CSS.make("a-8jj4w6", []);
  CSS.make("a-8j6ns1", []);
  CSS.make("a-8jjpx4", []);
  CSS.make("a-8j4k9o", []);
  
  let _loadingKeyframes = CSS.Types.AnimationName.make("k-1b5h4ts");
