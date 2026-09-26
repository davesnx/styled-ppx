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
  [@css "._a_3903kdbzm{background-repeat:space;}"];
  [@css "._a_3903kwgys{background-repeat:round;}"];
  [@css "._a_3903kpiw6{background-repeat:repeat repeat;}"];
  [@css "._a_3903kxji5{background-repeat:space repeat;}"];
  [@css "._a_3903k0kx7{background-repeat:round repeat;}"];
  [@css "._a_3903kqiir{background-repeat:no-repeat repeat;}"];
  [@css "._a_3903kff62{background-repeat:repeat space;}"];
  [@css "._a_3903klrh1{background-repeat:space space;}"];
  [@css "._a_3903kzuyd{background-repeat:round space;}"];
  [@css "._a_3903ko3tu{background-repeat:no-repeat space;}"];
  [@css "._a_3903k2l1t{background-repeat:repeat round;}"];
  [@css "._a_3903kpz8i{background-repeat:space round;}"];
  [@css "._a_3903kvp4f{background-repeat:round round;}"];
  [@css "._a_3903kttlz{background-repeat:no-repeat round;}"];
  [@css "._a_3903k95y1{background-repeat:repeat no-repeat;}"];
  [@css "._a_3903kyae4{background-repeat:space no-repeat;}"];
  [@css "._a_3903khx0d{background-repeat:round no-repeat;}"];
  [@css "._a_3903kr6kt{background-repeat:no-repeat no-repeat;}"];
  [@css "._a_3903kbp5t{background-repeat:repeat-x, repeat-y;}"];
  [@css "._a_39001p2j1{background-attachment:local;}"];
  [@css
    "._a_390024kwg{-webkit-background-clip:border-box;background-clip:border-box;}"
  ];
  [@css
    "._a_390025w5o{-webkit-background-clip:padding-box;background-clip:padding-box;}"
  ];
  [@css
    "._a_3900250rv{-webkit-background-clip:content-box;background-clip:content-box;}"
  ];
  [@css "._a_390028734{-webkit-background-clip:text;background-clip:text;}"];
  [@css
    "._a_390025rmj{-webkit-background-clip:border-area;background-clip:border-area;}"
  ];
  [@css
    "._a_3900245y6{-webkit-background-clip:text, border-area;background-clip:text, border-area;}"
  ];
  [@css "._a_3900gkwyo{background-origin:border-box;}"];
  [@css "._a_3900gr9hb{background-origin:padding-box;}"];
  [@css "._a_3900gwo89{background-origin:content-box;}"];
  [@css "._a_390744aob{background-size:auto;}"];
  [@css "._a_39074k97u{background-size:cover;}"];
  [@css "._a_39074xylo{background-size:contain;}"];
  [@css "._a_39074m5qu{background-size:10px;}"];
  [@css "._a_39074u6v3{background-size:50%;}"];
  [@css "._a_39074xytx{background-size:10px auto;}"];
  [@css "._a_39074a9zh{background-size:auto 10%;}"];
  [@css "._a_390744rix{background-size:50em 50%;}"];
  [@css "._a_39074zw1h{background-size:20px 20px;}"];
  [@css "._a_39o254{background:top left / 50% 60%;}"];
  [@css "._a_39vagn{background:border-box;}"];
  [@css "._a_392d75{background:blue;}"];
  [@css "._a_39hvrj{background:border-box red;}"];
  [@css "._a_39lssi{background:border-box padding-box;}"];
  [@css
    "._a_39uq7y{background:url(\"foo.png\") bottom right / cover padding-box content-box;}"
  ];
  [@css "._a_3n004ffk7{border-top-left-radius:0;}"];
  [@css "._a_3n004y41g{border-top-left-radius:50%;}"];
  [@css "._a_3n004ccvj{border-top-left-radius:250px 100px;}"];
  [@css "._a_3n008ozmz{border-top-right-radius:0;}"];
  [@css "._a_3n008h6x9{border-top-right-radius:50%;}"];
  [@css "._a_3n0080ho1{border-top-right-radius:250px 100px;}"];
  [@css "._a_3n002m6su{border-bottom-right-radius:0;}"];
  [@css "._a_3n0025ugq{border-bottom-right-radius:50%;}"];
  [@css "._a_3n0028l07{border-bottom-right-radius:250px 100px;}"];
  [@css "._a_3n001vopp{border-bottom-left-radius:0;}"];
  [@css "._a_3n001z4ix{border-bottom-left-radius:50%;}"];
  [@css "._a_3n001fj6a{border-bottom-left-radius:250px 100px;}"];
  [@css "._a_3nv389{border-radius:10px;}"];
  [@css "._a_3ndor8{border-radius:50%;}"];
  [@css "._a_3nok9k{border-radius:2px 4px;}"];
  [@css "._a_3nl4dm{border-radius:2px 4px 8px;}"];
  [@css "._a_3nbni5{border-radius:2px 4px 8px 16px;}"];
  [@css "._a_3nk2xe{border-radius:10px / 20px;}"];
  [@css "._a_3n5w7s{border-radius:2px 4px 8px 16px / 2px 4px 8px 16px;}"];
  [@css "._a_3h01s67n4{border-image-source:none;}"];
  [@css "._a_3h01s2djw{border-image-source:url(\"foo.png\");}"];
  [@css "._a_3h00w8fag{border-image-slice:10;}"];
  [@css "._a_3h00wou03{border-image-slice:30%;}"];
  [@css "._a_3h00wp0ma{border-image-slice:10 10;}"];
  [@css "._a_3h00wblsp{border-image-slice:30% 10;}"];
  [@css "._a_3h00w5gxt{border-image-slice:10 30%;}"];
  [@css "._a_3h00wpwt3{border-image-slice:30% 30%;}"];
  [@css "._a_3h00wg3fs{border-image-slice:10 10 10;}"];
  [@css "._a_3h00wb146{border-image-slice:30% 10 10;}"];
  [@css "._a_3h00wyk9k{border-image-slice:10 30% 10;}"];
  [@css "._a_3h00wdy38{border-image-slice:30% 30% 10;}"];
  [@css "._a_3h00wfa9m{border-image-slice:10 10 30%;}"];
  [@css "._a_3h00wz16p{border-image-slice:30% 10 30%;}"];
  [@css "._a_3h00w8zfs{border-image-slice:10 30% 30%;}"];
  [@css "._a_3h00wuel6{border-image-slice:30% 30% 30%;}"];
  [@css "._a_3h00w27b9{border-image-slice:10 10 10 10;}"];
  [@css "._a_3h00wciru{border-image-slice:30% 10 10 10;}"];
  [@css "._a_3h00wj984{border-image-slice:10 30% 10 10;}"];
  [@css "._a_3h00weygg{border-image-slice:30% 30% 10 10;}"];
  [@css "._a_3h00wu8vs{border-image-slice:10 10 30% 10;}"];
  [@css "._a_3h00w4ctj{border-image-slice:30% 10 30% 10;}"];
  [@css "._a_3h00wrqu8{border-image-slice:10 30% 30% 10;}"];
  [@css "._a_3h00w535k{border-image-slice:30% 30% 30% 10;}"];
  [@css "._a_3h00wmqly{border-image-slice:10 10 10 30%;}"];
  [@css "._a_3h00w334v{border-image-slice:30% 10 10 30%;}"];
  [@css "._a_3h00w10it{border-image-slice:10 30% 10 30%;}"];
  [@css "._a_3h00w24bv{border-image-slice:30% 30% 10 30%;}"];
  [@css "._a_3h00woopq{border-image-slice:10 10 30% 30%;}"];
  [@css "._a_3h00wc6k6{border-image-slice:30% 10 30% 30%;}"];
  [@css "._a_3h00wce7t{border-image-slice:10 30% 30% 30%;}"];
  [@css "._a_3h00w3xq3{border-image-slice:30% 30% 30% 30%;}"];
  [@css "._a_3h00wpp7o{border-image-slice:fill 30%;}"];
  [@css "._a_3h00wsoql{border-image-slice:fill 10;}"];
  [@css "._a_3h00wljby{border-image-slice:fill 2 4 8% 16%;}"];
  [@css "._a_3h00wb5be{border-image-slice:30% fill;}"];
  [@css "._a_3h00wse3r{border-image-slice:10 fill;}"];
  [@css "._a_3h00wst01{border-image-slice:2 4 8% 16% fill;}"];
  [@css "._a_3h03kmtq7{border-image-width:10px;}"];
  [@css "._a_3h03k2lna{border-image-width:5%;}"];
  [@css "._a_3h03kvskx{border-image-width:28;}"];
  [@css "._a_3h03k12to{border-image-width:auto;}"];
  [@css "._a_3h03kqzt3{border-image-width:10px 10px;}"];
  [@css "._a_3h03k1b9l{border-image-width:5% 10px;}"];
  [@css "._a_3h03ka5d6{border-image-width:28 10px;}"];
  [@css "._a_3h03kgsb5{border-image-width:auto 10px;}"];
  [@css "._a_3h03ktfkm{border-image-width:10px 5%;}"];
  [@css "._a_3h03kfrk8{border-image-width:5% 5%;}"];
  [@css "._a_3h03ksgtx{border-image-width:28 5%;}"];
  [@css "._a_3h03ko8wy{border-image-width:auto 5%;}"];
  [@css "._a_3h03kyjgi{border-image-width:10px 28;}"];
  [@css "._a_3h03k05n6{border-image-width:5% 28;}"];
  [@css "._a_3h03kpian{border-image-width:28 28;}"];
  [@css "._a_3h03k7o1w{border-image-width:auto 28;}"];
  [@css "._a_3h03kbki1{border-image-width:10px auto;}"];
  [@css "._a_3h03ksfme{border-image-width:5% auto;}"];
  [@css "._a_3h03klhmj{border-image-width:28 auto;}"];
  [@css "._a_3h03kiwnw{border-image-width:auto auto;}"];
  [@css "._a_3h03k1i6r{border-image-width:10px 10% 10;}"];
  [@css "._a_3h03k03j7{border-image-width:5% 10px 20 auto;}"];
  [@css "._a_3h008lw5x{border-image-outset:10px;}"];
  [@css "._a_3h008x2bn{border-image-outset:20;}"];
  [@css "._a_3h008jka5{border-image-outset:10px 20;}"];
  [@css "._a_3h008v07i{border-image-outset:10px 20px;}"];
  [@css "._a_3h008ixn9{border-image-outset:20 30;}"];
  [@css "._a_3h0083q5z{border-image-outset:2px 3px 4;}"];
  [@css "._a_3h008dhma{border-image-outset:1 2px 3px 4;}"];
  [@css "._a_3h00g8amr{border-image-repeat:stretch;}"];
  [@css "._a_3h00gvfhi{border-image-repeat:repeat;}"];
  [@css "._a_3h00gsbb7{border-image-repeat:round;}"];
  [@css "._a_3h00gfada{border-image-repeat:space;}"];
  [@css "._a_3h00g930f{border-image-repeat:stretch stretch;}"];
  [@css "._a_3h00gipsj{border-image-repeat:repeat stretch;}"];
  [@css "._a_3h00gh3hn{border-image-repeat:round stretch;}"];
  [@css "._a_3h00g3d92{border-image-repeat:space stretch;}"];
  [@css "._a_3h00g5f3q{border-image-repeat:stretch repeat;}"];
  [@css "._a_3h00gdrj5{border-image-repeat:repeat repeat;}"];
  [@css "._a_3h00g6kfj{border-image-repeat:round repeat;}"];
  [@css "._a_3h00gahlj{border-image-repeat:space repeat;}"];
  [@css "._a_3h00gd86l{border-image-repeat:stretch round;}"];
  [@css "._a_3h00g5ktc{border-image-repeat:repeat round;}"];
  [@css "._a_3h00gllwt{border-image-repeat:round round;}"];
  [@css "._a_3h00geu9k{border-image-repeat:space round;}"];
  [@css "._a_3h00gorbo{border-image-repeat:stretch space;}"];
  [@css "._a_3h00gcpic{border-image-repeat:repeat space;}"];
  [@css "._a_3h00g2bpm{border-image-repeat:round space;}"];
  [@css "._a_3h00giv0g{border-image-repeat:space space;}"];
  [@css "._a_3h06wl0e3{border-image:url(\"foo.png\") 10;}"];
  [@css "._a_3h06wc16s{border-image:url(\"foo.png\") 10%;}"];
  [@css "._a_3h06wk48c{border-image:url(\"foo.png\") 10% fill;}"];
  [@css "._a_3h06wndfl{border-image:url(\"foo.png\") 10 round;}"];
  [@css "._a_3h06woh1n{border-image:url(\"foo.png\") 10 stretch repeat;}"];
  [@css "._a_3h06wvdj4{border-image:url(\"foo.png\") 10 / 10px;}"];
  [@css "._a_3h06wx17x{border-image:url(\"foo.png\") 10 / 10% / 10px;}"];
  [@css "._a_3h06wzcfy{border-image:url(\"foo.png\") fill 10 / 10% / 10px;}"];
  [@css
    "._a_3h06w30nn{border-image:url(\"foo.png\") fill 10 / 10% / 10px space;}"
  ];
  [@css "._a_40keqi{box-shadow:none;}"];
  [@css "._a_40ye8k{box-shadow:1px 1px;}"];
  [@css "._a_40r8u1{box-shadow:0 0 black;}"];
  [@css "._a_40uemi{box-shadow:1px 2px 3px;}"];
  [@css "._a_40mflx{box-shadow:1px 2px 3px black;}"];
  [@css "._a_4056p9{box-shadow:1px 2px 3px 4px;}"];
  [@css "._a_40xcnx{box-shadow:1px 2px 3px 4px black;}"];
  [@css "._a_40ios5{box-shadow:inset 1px 1px;}"];
  [@css "._a_405tpn{box-shadow:inset 0 0 black;}"];
  [@css "._a_40izzs{box-shadow:inset 1px 2px 3px;}"];
  [@css "._a_40yjsg{box-shadow:inset 1px 2px 3px black;}"];
  [@css "._a_40khnb{box-shadow:inset 1px 2px 3px 4px;}"];
  [@css "._a_403f6l{box-shadow:inset 1px 2px 3px 4px black;}"];
  [@css
    "._a_40otsx{box-shadow:inset 1px 2px 3px 4px black, 1px 2px 3px 4px black;}"
  ];
  [@css "._a_4085p6{box-shadow:1px 1px, inset 2px 2px red;}"];
  [@css "._a_40q314{box-shadow:0 0 5px, inset 0 0 10px black;}"];
  [@css
    "._a_400xa4{box-shadow:-1px 1px 0px 0px var(--elevation1-xawwdw_1), 1px 1px 0px 0px var(--elevation1-xawwdw_2), 0px -1px 0px 0px var(--elevation1-xawwdw_3);}"
  ];
  [@css "._a_3900w2nfr{background-position-x:right;}"];
  [@css "._a_3900wvq06{background-position-x:center;}"];
  [@css "._a_3900wcezg{background-position-x:50%;}"];
  [@css "._a_3900we8x4{background-position-x:left, left;}"];
  [@css "._a_3900wem91{background-position-x:left, right;}"];
  [@css "._a_3900w9h4p{background-position-x:right, left;}"];
  [@css "._a_3900wz26j{background-position-x:left, 0%;}"];
  [@css "._a_3900wbcib{background-position-x:10%, 20%, 40%;}"];
  [@css "._a_3900wehso{background-position-x:0px;}"];
  [@css "._a_3900wvpvo{background-position-x:30px;}"];
  [@css "._a_3900wjlye{background-position-x:0%, 10%, 20%, 30%;}"];
  [@css "._a_3900wuvjq{background-position-x:left, left, left, left, left;}"];
  [@css "._a_3900w1f37{background-position-x:calc(20px);}"];
  [@css "._a_3900w1ldt{background-position-x:calc(20px + 1em);}"];
  [@css "._a_3900ww4iu{background-position-x:calc(20px / 2);}"];
  [@css "._a_3900wk1yt{background-position-x:calc(20px + 50%);}"];
  [@css "._a_3900w363d{background-position-x:calc(50% - 10px);}"];
  [@css "._a_3900w78wf{background-position-x:calc(-20px);}"];
  [@css "._a_3900wryx3{background-position-x:calc(-50%);}"];
  [@css "._a_3900wbe59{background-position-x:calc(-20%);}"];
  [@css "._a_3900w7w9s{background-position-x:right 20px;}"];
  [@css "._a_3900w8n01{background-position-x:left 20px;}"];
  [@css "._a_3900wf6oz{background-position-x:right -50px;}"];
  [@css "._a_3900wata8{background-position-x:left -50px;}"];
  [@css "._a_3901sxup1{background-position-y:bottom;}"];
  [@css "._a_3901s9ewh{background-position-y:center;}"];
  [@css "._a_3901shsum{background-position-y:50%;}"];
  [@css "._a_3901s04xu{background-position-y:top, top;}"];
  [@css "._a_3901sqqtz{background-position-y:top, bottom;}"];
  [@css "._a_3901s54xk{background-position-y:bottom, top;}"];
  [@css "._a_3901s7d2k{background-position-y:top, 0%;}"];
  [@css "._a_3901s93ok{background-position-y:10%, 20%, 40%;}"];
  [@css "._a_3901scs51{background-position-y:0px;}"];
  [@css "._a_3901s2wtl{background-position-y:30px;}"];
  [@css "._a_3901sd3sd{background-position-y:0%, 10%, 20%, 30%;}"];
  [@css "._a_3901sfv8k{background-position-y:top, top, top, top, top;}"];
  [@css "._a_3901s2yw6{background-position-y:calc(20px);}"];
  [@css "._a_3901spdqz{background-position-y:calc(20px + 1em);}"];
  [@css "._a_3901s8w9h{background-position-y:calc(20px / 2);}"];
  [@css "._a_3901skkb2{background-position-y:calc(20px + 50%);}"];
  [@css "._a_3901sdt8x{background-position-y:calc(50% - 10px);}"];
  [@css "._a_3901sc0ip{background-position-y:calc(-20px);}"];
  [@css "._a_3901sckm0{background-position-y:calc(-50%);}"];
  [@css "._a_3901sw002{background-position-y:calc(-20%);}"];
  [@css "._a_3901sz8v2{background-position-y:bottom 20px;}"];
  [@css "._a_3901s2qfz{background-position-y:top 20px;}"];
  [@css "._a_3901smhad{background-position-y:bottom -50px;}"];
  [@css "._a_3901s0o43{background-position-y:top -50px;}"];
  [@css "._a_39008hz2r{background-image:linear-gradient(45deg, blue, red);}"];
  [@css
    "._a_39008qfjp{background-image:linear-gradient(90deg, blue 10%, red 20%);}"
  ];
  [@css
    "._a_39008ab29{background-image:linear-gradient(90deg, blue 10%, red);}"
  ];
  [@css
    "._a_390081u4d{background-image:linear-gradient(90deg, blue, 10%, red);}"
  ];
  [@css "._a_39008uss4{background-image:linear-gradient(white, black);}"];
  [@css
    "._a_39008n2r8{background-image:linear-gradient(to right, white, black);}"
  ];
  [@css "._a_39008ys2x{background-image:linear-gradient(45deg, white, black);}"];
  [@css "._a_39008ojtb{background-image:linear-gradient(white 50%, black);}"];
  [@css "._a_390080xs1{background-image:linear-gradient(white, #f06, black);}"];
  [@css
    "._a_39008yimv{background-image:linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);}"
  ];
  [@css
    "._a_39008fmes{background-image:linear-gradient(45deg, blue, red), linear-gradient(red -50px, white calc(-25px + 50%), blue 100%), linear-gradient(45deg, blue, red);}"
  ];
  [@css
    "._a_3900838s1{background-image:linear-gradient(45deg, var(--color-vcr1i_1) 25%, transparent 0%, transparent 50%, var(--color-vcr1i_2) 0%, var(--color-vcr1i_3) 75%, transparent 0%, transparent 100% );}"
  ];
  [@css
    "._a_39008tv7y{background-image:repeating-linear-gradient( 45deg, var(--color-pys9ag_1) 0px, var(--color-pys9ag_2) 4px, var(--color-pys9ag_3) 5px, var(--color-pys9ag_4) 9px );}"
  ];
  [@css
    "._a_39008igxz{background-image:linear-gradient(45deg, var(--boxDark-17ffdav) 25%, transparent 25%), linear-gradient(red -50px, white calc(-25px + 50%), blue 100%), linear-gradient(45deg, blue, red);}"
  ];
  [@css "._a_39008fodl{background-image:radial-gradient(white, black);}"];
  [@css
    "._a_390085i1d{background-image:radial-gradient(circle, white, black);}"
  ];
  [@css
    "._a_390085rni{background-image:radial-gradient(ellipse, white, black);}"
  ];
  [@css
    "._a_39008nqg5{background-image:radial-gradient(circle closest-corner, white, black);}"
  ];
  [@css
    "._a_39008dzbz{background-image:radial-gradient(farthest-side, white, black);}"
  ];
  [@css
    "._a_390081b7p{background-image:radial-gradient(circle farthest-side, white, black);}"
  ];
  [@css "._a_39008fl0e{background-image:radial-gradient(50%, white, black);}"];
  [@css
    "._a_390085uiv{background-image:radial-gradient(60% 60%, white, black);}"
  ];
  [@css "._a_7o001ird3{list-style-image:linear-gradient(white, black);}"];
  [@css
    "._a_7o001eq2u{list-style-image:linear-gradient(to right, white, black);}"
  ];
  [@css "._a_7o0017x4a{list-style-image:linear-gradient(45deg, white, black);}"];
  [@css "._a_7o001kxhc{list-style-image:linear-gradient(white 50%, black);}"];
  [@css "._a_7o00174rj{list-style-image:linear-gradient(white 5px, black);}"];
  [@css "._a_7o001c0fc{list-style-image:linear-gradient(white, #f06, black);}"];
  [@css "._a_7o001ualz{list-style-image:linear-gradient(currentColor, black);}"];
  [@css
    "._a_7o0018cv6{list-style-image:linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);}"
  ];
  [@css "._a_7o0017vp0{list-style-image:radial-gradient(white, black);}"];
  [@css
    "._a_7o001kg5x{list-style-image:radial-gradient(circle, white, black);}"
  ];
  [@css
    "._a_7o00142dq{list-style-image:radial-gradient(ellipse, white, black);}"
  ];
  [@css
    "._a_7o001ouy8{list-style-image:radial-gradient(closest-corner, white, black);}"
  ];
  [@css
    "._a_7o001zi1j{list-style-image:radial-gradient(circle closest-corner, white, black);}"
  ];
  [@css
    "._a_7o001bp18{list-style-image:radial-gradient(farthest-side, white, black);}"
  ];
  [@css
    "._a_7o001bl3b{list-style-image:radial-gradient(circle farthest-side, white, black);}"
  ];
  [@css "._a_7o0010ihr{list-style-image:radial-gradient(50%, white, black);}"];
  [@css
    "._a_7o0018tou{list-style-image:radial-gradient(60% 60%, white, black);}"
  ];
  [@css "._a_6tobub{image-rendering:auto;}"];
  [@css "._a_6t7xqd{image-rendering:smooth;}"];
  [@css "._a_6tt5e9{image-rendering:high-quality;}"];
  [@css "._a_6thmlf{image-rendering:pixelated;}"];
  [@css "._a_6tm01f{image-rendering:crisp-edges;}"];
  [@css "._a_3902oylgn{background-position:bottom;}"];
  [@css "._a_3901sniqy{background-position-y:0;}"];
  [@css "._a_3902oueyu{background-position:0 0;}"];
  [@css "._a_3902o3hnb{background-position:1rem 0;}"];
  [@css "._a_3902odqt2{background-position:bottom 10px right;}"];
  [@css "._a_3902oz38j{background-position:bottom 10px right 20px;}"];
  [@css "._a_3902on9c9{background-position:0 0, center;}"];
  [@css "._a_8jqhry{object-position:top;}"];
  [@css "._a_8ju2x3{object-position:bottom;}"];
  [@css "._a_8jx73u{object-position:left;}"];
  [@css "._a_8jcm6t{object-position:right;}"];
  [@css "._a_8jlpb4{object-position:center;}"];
  [@css "._a_8jh0g1{object-position:25% 75%;}"];
  [@css "._a_8jlnwd{object-position:25%;}"];
  [@css "._a_8j0ddq{object-position:0 0;}"];
  [@css "._a_8jopaa{object-position:1cm 2cm;}"];
  [@css "._a_8jenxt{object-position:10ch 8em;}"];
  [@css "._a_8jase9{object-position:bottom 10px right 20px;}"];
  [@css "._a_8jana2{object-position:right 3em bottom 10px;}"];
  [@css "._a_8j11ag{object-position:top 0 right 10px;}"];
  [@css "._a_8jhhjc{object-position:inherit;}"];
  [@css "._a_8jj4w6{object-position:initial;}"];
  [@css "._a_8j6ns1{object-position:revert;}"];
  [@css "._a_8jjpx4{object-position:revert-layer;}"];
  [@css "._a_8j4k9o{object-position:unset;}"];
  [@css
    "@keyframes _k_1b5h4ts{0%{background-position:0 0;}100%{background-position:1rem 0;}}"
  ];
  module Color = {
    module Background = {
      let boxDark = `hex("000000");
    };
    module Shadow = {
      let elevation1 = `rgba((0, 0, 0, `num(0.03)));
    };
  };
  
  CSS.make("_a_3903kdbzm", []);
  CSS.make("_a_3903kwgys", []);
  CSS.make("_a_3903kpiw6", []);
  CSS.make("_a_3903kxji5", []);
  CSS.make("_a_3903k0kx7", []);
  CSS.make("_a_3903kqiir", []);
  CSS.make("_a_3903kff62", []);
  CSS.make("_a_3903klrh1", []);
  CSS.make("_a_3903kzuyd", []);
  CSS.make("_a_3903ko3tu", []);
  CSS.make("_a_3903k2l1t", []);
  CSS.make("_a_3903kpz8i", []);
  CSS.make("_a_3903kvp4f", []);
  CSS.make("_a_3903kttlz", []);
  CSS.make("_a_3903k95y1", []);
  CSS.make("_a_3903kyae4", []);
  CSS.make("_a_3903khx0d", []);
  CSS.make("_a_3903kr6kt", []);
  CSS.make("_a_3903kbp5t", []);
  CSS.make("_a_39001p2j1", []);
  CSS.make("_a_390024kwg", []);
  CSS.make("_a_390025w5o", []);
  CSS.make("_a_3900250rv", []);
  CSS.make("_a_390028734", []);
  CSS.make("_a_390025rmj", []);
  CSS.make("_a_3900245y6", []);
  CSS.make("_a_3900gkwyo", []);
  CSS.make("_a_3900gr9hb", []);
  CSS.make("_a_3900gwo89", []);
  CSS.make("_a_390744aob", []);
  CSS.make("_a_39074k97u", []);
  CSS.make("_a_39074xylo", []);
  CSS.make("_a_39074m5qu", []);
  CSS.make("_a_39074u6v3", []);
  CSS.make("_a_39074xytx", []);
  CSS.make("_a_39074a9zh", []);
  CSS.make("_a_390744rix", []);
  CSS.make("_a_39074zw1h", []);
  
  CSS.make("_a_39o254", []);
  CSS.make("_a_39vagn", []);
  CSS.make("_a_392d75", []);
  CSS.make("_a_39hvrj", []);
  
  CSS.make("_a_39lssi", []);
  CSS.make("_a_39uq7y", []);
  CSS.make("_a_3n004ffk7", []);
  CSS.make("_a_3n004y41g", []);
  CSS.make("_a_3n004ccvj", []);
  CSS.make("_a_3n008ozmz", []);
  CSS.make("_a_3n008h6x9", []);
  CSS.make("_a_3n0080ho1", []);
  CSS.make("_a_3n002m6su", []);
  CSS.make("_a_3n0025ugq", []);
  CSS.make("_a_3n0028l07", []);
  CSS.make("_a_3n001vopp", []);
  CSS.make("_a_3n001z4ix", []);
  CSS.make("_a_3n001fj6a", []);
  CSS.make("_a_3nv389", []);
  CSS.make("_a_3ndor8", []);
  CSS.make("_a_3nok9k", []);
  CSS.make("_a_3nl4dm", []);
  CSS.make("_a_3nbni5", []);
  CSS.make("_a_3nk2xe", []);
  CSS.make("_a_3n5w7s", []);
  CSS.make("_a_3h01s67n4", []);
  CSS.make("_a_3h01s2djw", []);
  CSS.make("_a_3h00w8fag", []);
  CSS.make("_a_3h00wou03", []);
  CSS.make("_a_3h00wp0ma", []);
  CSS.make("_a_3h00wblsp", []);
  CSS.make("_a_3h00w5gxt", []);
  CSS.make("_a_3h00wpwt3", []);
  CSS.make("_a_3h00wg3fs", []);
  CSS.make("_a_3h00wb146", []);
  CSS.make("_a_3h00wyk9k", []);
  CSS.make("_a_3h00wdy38", []);
  CSS.make("_a_3h00wfa9m", []);
  CSS.make("_a_3h00wz16p", []);
  CSS.make("_a_3h00w8zfs", []);
  CSS.make("_a_3h00wuel6", []);
  CSS.make("_a_3h00w27b9", []);
  CSS.make("_a_3h00wciru", []);
  CSS.make("_a_3h00wj984", []);
  CSS.make("_a_3h00weygg", []);
  CSS.make("_a_3h00wu8vs", []);
  CSS.make("_a_3h00w4ctj", []);
  CSS.make("_a_3h00wrqu8", []);
  CSS.make("_a_3h00w535k", []);
  CSS.make("_a_3h00wmqly", []);
  CSS.make("_a_3h00w334v", []);
  CSS.make("_a_3h00w10it", []);
  CSS.make("_a_3h00w24bv", []);
  CSS.make("_a_3h00woopq", []);
  CSS.make("_a_3h00wc6k6", []);
  CSS.make("_a_3h00wce7t", []);
  CSS.make("_a_3h00w3xq3", []);
  CSS.make("_a_3h00wpp7o", []);
  CSS.make("_a_3h00wsoql", []);
  CSS.make("_a_3h00wljby", []);
  CSS.make("_a_3h00wb5be", []);
  CSS.make("_a_3h00wse3r", []);
  CSS.make("_a_3h00wst01", []);
  CSS.make("_a_3h03kmtq7", []);
  CSS.make("_a_3h03k2lna", []);
  CSS.make("_a_3h03kvskx", []);
  CSS.make("_a_3h03k12to", []);
  CSS.make("_a_3h03kqzt3", []);
  CSS.make("_a_3h03k1b9l", []);
  CSS.make("_a_3h03ka5d6", []);
  CSS.make("_a_3h03kgsb5", []);
  CSS.make("_a_3h03ktfkm", []);
  CSS.make("_a_3h03kfrk8", []);
  CSS.make("_a_3h03ksgtx", []);
  CSS.make("_a_3h03ko8wy", []);
  CSS.make("_a_3h03kyjgi", []);
  CSS.make("_a_3h03k05n6", []);
  CSS.make("_a_3h03kpian", []);
  CSS.make("_a_3h03k7o1w", []);
  CSS.make("_a_3h03kbki1", []);
  CSS.make("_a_3h03ksfme", []);
  CSS.make("_a_3h03klhmj", []);
  CSS.make("_a_3h03kiwnw", []);
  CSS.make("_a_3h03k1i6r", []);
  CSS.make("_a_3h03k03j7", []);
  CSS.make("_a_3h008lw5x", []);
  CSS.make("_a_3h008x2bn", []);
  CSS.make("_a_3h008jka5", []);
  CSS.make("_a_3h008v07i", []);
  CSS.make("_a_3h008ixn9", []);
  CSS.make("_a_3h0083q5z", []);
  CSS.make("_a_3h008dhma", []);
  CSS.make("_a_3h00g8amr", []);
  CSS.make("_a_3h00gvfhi", []);
  CSS.make("_a_3h00gsbb7", []);
  CSS.make("_a_3h00gfada", []);
  CSS.make("_a_3h00g930f", []);
  CSS.make("_a_3h00gipsj", []);
  CSS.make("_a_3h00gh3hn", []);
  CSS.make("_a_3h00g3d92", []);
  CSS.make("_a_3h00g5f3q", []);
  CSS.make("_a_3h00gdrj5", []);
  CSS.make("_a_3h00g6kfj", []);
  CSS.make("_a_3h00gahlj", []);
  CSS.make("_a_3h00gd86l", []);
  CSS.make("_a_3h00g5ktc", []);
  CSS.make("_a_3h00gllwt", []);
  CSS.make("_a_3h00geu9k", []);
  CSS.make("_a_3h00gorbo", []);
  CSS.make("_a_3h00gcpic", []);
  CSS.make("_a_3h00g2bpm", []);
  CSS.make("_a_3h00giv0g", []);
  CSS.make("_a_3h06wl0e3", []);
  CSS.make("_a_3h06wc16s", []);
  CSS.make("_a_3h06wk48c", []);
  CSS.make("_a_3h06wndfl", []);
  CSS.make("_a_3h06woh1n", []);
  CSS.make("_a_3h06wvdj4", []);
  CSS.make("_a_3h06wx17x", []);
  CSS.make("_a_3h06wzcfy", []);
  CSS.make("_a_3h06w30nn", []);
  
  CSS.make("_a_40keqi", []);
  
  CSS.make("_a_40ye8k", []);
  
  CSS.make("_a_40r8u1", []);
  
  CSS.make("_a_40uemi", []);
  
  CSS.make("_a_40mflx", []);
  
  CSS.make("_a_4056p9", []);
  
  CSS.make("_a_40xcnx", []);
  
  CSS.make("_a_40ios5", []);
  
  CSS.make("_a_405tpn", []);
  
  CSS.make("_a_40izzs", []);
  
  CSS.make("_a_40yjsg", []);
  
  CSS.make("_a_40khnb", []);
  
  CSS.make("_a_403f6l", []);
  
  CSS.make("_a_40otsx", []);
  CSS.make("_a_4085p6", []);
  CSS.make("_a_40q314", []);
  CSS.make(
    "_a_400xa4",
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
  
  CSS.make("_a_3900w2nfr", []);
  CSS.make("_a_3900wvq06", []);
  CSS.make("_a_3900wcezg", []);
  CSS.make("_a_3900we8x4", []);
  CSS.make("_a_3900wem91", []);
  CSS.make("_a_3900w9h4p", []);
  CSS.make("_a_3900wz26j", []);
  CSS.make("_a_3900wbcib", []);
  CSS.make("_a_3900wehso", []);
  CSS.make("_a_3900wvpvo", []);
  CSS.make("_a_3900wjlye", []);
  CSS.make("_a_3900wuvjq", []);
  CSS.make("_a_3900w1f37", []);
  CSS.make("_a_3900w1ldt", []);
  CSS.make("_a_3900ww4iu", []);
  CSS.make("_a_3900wk1yt", []);
  CSS.make("_a_3900w363d", []);
  CSS.make("_a_3900w78wf", []);
  CSS.make("_a_3900wryx3", []);
  CSS.make("_a_3900wbe59", []);
  CSS.make("_a_3900w7w9s", []);
  CSS.make("_a_3900w8n01", []);
  CSS.make("_a_3900wf6oz", []);
  CSS.make("_a_3900wata8", []);
  CSS.make("_a_3900w7w9s", []);
  CSS.make("_a_3901sxup1", []);
  CSS.make("_a_3901s9ewh", []);
  CSS.make("_a_3901shsum", []);
  CSS.make("_a_3901s04xu", []);
  CSS.make("_a_3901sqqtz", []);
  CSS.make("_a_3901s54xk", []);
  CSS.make("_a_3901s7d2k", []);
  CSS.make("_a_3901s93ok", []);
  CSS.make("_a_3901scs51", []);
  CSS.make("_a_3901s2wtl", []);
  CSS.make("_a_3901sd3sd", []);
  CSS.make("_a_3901sfv8k", []);
  CSS.make("_a_3901s2yw6", []);
  CSS.make("_a_3901spdqz", []);
  CSS.make("_a_3901s8w9h", []);
  CSS.make("_a_3901skkb2", []);
  CSS.make("_a_3901sdt8x", []);
  CSS.make("_a_3901sc0ip", []);
  CSS.make("_a_3901sckm0", []);
  CSS.make("_a_3901sw002", []);
  CSS.make("_a_3901sz8v2", []);
  CSS.make("_a_3901s2qfz", []);
  CSS.make("_a_3901smhad", []);
  CSS.make("_a_3901s0o43", []);
  CSS.make("_a_3901sz8v2", []);
  
  CSS.make("_a_39008hz2r", []);
  CSS.make("_a_39008qfjp", []);
  CSS.make("_a_39008ab29", []);
  CSS.make("_a_390081u4d", []);
  CSS.make("_a_39008uss4", []);
  CSS.make("_a_39008n2r8", []);
  CSS.make("_a_39008ys2x", []);
  CSS.make("_a_39008ojtb", []);
  CSS.make("_a_390080xs1", []);
  CSS.make("_a_39008yimv", []);
  CSS.make("_a_39008fmes", []);
  let color = `hex("333");
  CSS.make(
    "_a_3900838s1",
    [
      ("--color-vcr1i_1", CSS.Types.Color.toString(color)),
      ("--color-vcr1i_2", CSS.Types.Color.toString(color)),
      ("--color-vcr1i_3", CSS.Types.Color.toString(color)),
    ],
  );
  CSS.make(
    "_a_39008tv7y",
    [
      ("--color-pys9ag_1", CSS.Types.Color.toString(color)),
      ("--color-pys9ag_2", CSS.Types.Color.toString(color)),
      ("--color-pys9ag_3", CSS.Types.Color.toString(color)),
      ("--color-pys9ag_4", CSS.Types.Color.toString(color)),
    ],
  );
  
  CSS.make(
    "_a_39008igxz",
    [
      ("--boxDark-17ffdav", CSS.Types.Color.toString(Color.Background.boxDark)),
    ],
  );
  
  CSS.make("_a_39008fodl", []);
  CSS.make("_a_390085i1d", []);
  CSS.make("_a_390085rni", []);
  CSS.make("_a_39008nqg5", []);
  CSS.make("_a_39008dzbz", []);
  CSS.make("_a_390081b7p", []);
  CSS.make("_a_39008fl0e", []);
  CSS.make("_a_390085uiv", []);
  
  CSS.make("_a_7o001ird3", []);
  CSS.make("_a_7o001eq2u", []);
  CSS.make("_a_7o0017x4a", []);
  CSS.make("_a_7o001kxhc", []);
  CSS.make("_a_7o00174rj", []);
  CSS.make("_a_7o001c0fc", []);
  CSS.make("_a_7o001ualz", []);
  CSS.make("_a_7o0018cv6", []);
  CSS.make("_a_7o0017vp0", []);
  CSS.make("_a_7o001kg5x", []);
  CSS.make("_a_7o00142dq", []);
  CSS.make("_a_7o001ouy8", []);
  CSS.make("_a_7o001zi1j", []);
  CSS.make("_a_7o001bp18", []);
  CSS.make("_a_7o001bl3b", []);
  CSS.make("_a_7o0010ihr", []);
  CSS.make("_a_7o0018tou", []);
  
  CSS.make("_a_6tobub", []);
  CSS.make("_a_6t7xqd", []);
  CSS.make("_a_6tt5e9", []);
  CSS.make("_a_6thmlf", []);
  CSS.make("_a_6tm01f", []);
  
  CSS.make("_a_3902oylgn", []);
  CSS.make("_a_3900wcezg", []);
  CSS.make("_a_3901sniqy", []);
  CSS.make("_a_3902oueyu", []);
  CSS.make("_a_3902o3hnb", []);
  CSS.make("_a_3902odqt2", []);
  CSS.make("_a_3902oz38j", []);
  CSS.make("_a_3902on9c9", []);
  
  CSS.make("_a_8jqhry", []);
  CSS.make("_a_8ju2x3", []);
  CSS.make("_a_8jx73u", []);
  CSS.make("_a_8jcm6t", []);
  CSS.make("_a_8jlpb4", []);
  
  CSS.make("_a_8jh0g1", []);
  CSS.make("_a_8jlnwd", []);
  
  CSS.make("_a_8j0ddq", []);
  CSS.make("_a_8jopaa", []);
  CSS.make("_a_8jenxt", []);
  
  CSS.make("_a_8jase9", []);
  CSS.make("_a_8jana2", []);
  CSS.make("_a_8j11ag", []);
  
  CSS.make("_a_8jhhjc", []);
  CSS.make("_a_8jj4w6", []);
  CSS.make("_a_8j6ns1", []);
  CSS.make("_a_8jjpx4", []);
  CSS.make("_a_8j4k9o", []);
  
  let _loadingKeyframes = CSS.Types.AnimationName.make("_k_1b5h4ts");
