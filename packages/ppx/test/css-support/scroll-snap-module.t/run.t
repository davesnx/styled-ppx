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
  [@css "._a_acoiv8{scroll-margin:0px;}"];
  [@css "._a_acqcuf{scroll-margin:6px 5px;}"];
  [@css "._a_acxymj{scroll-margin:10px 20px 30px;}"];
  [@css "._a_acu2fa{scroll-margin:10px 20px 30px 40px;}"];
  [@css "._a_ac13tb{scroll-margin:20px 3em 1in 5rem;}"];
  [@css "._a_ac9mki{scroll-margin:calc(2px);}"];
  [@css "._a_ac3nfx{scroll-margin:calc(3 * 25px);}"];
  [@css "._a_ac600i{scroll-margin:calc(3 * 25px) 5px 10em calc(1vw - 5px);}"];
  [@css "._a_adu6my{scroll-margin-block:10px;}"];
  [@css "._a_ad4sq4{scroll-margin-block:10px 10px;}"];
  [@css "._a_ad000115zm{scroll-margin-block-end:10px;}"];
  [@css "._a_ad00024bj5{scroll-margin-block-start:10px;}"];
  [@css "._a_ac0001vqxc{scroll-margin-bottom:10px;}"];
  [@css "._a_ae12qs{scroll-margin-inline:10px;}"];
  [@css "._a_aemvdw{scroll-margin-inline:10px 10px;}"];
  [@css "._a_ae0002snad{scroll-margin-inline-start:10px;}"];
  [@css "._a_ae00019xfm{scroll-margin-inline-end:10px;}"];
  [@css "._a_ac0002fvv1{scroll-margin-left:10px;}"];
  [@css "._a_ac0004la2e{scroll-margin-right:10px;}"];
  [@css "._a_ac0008aols{scroll-margin-top:10px;}"];
  [@css "._a_ag5nxv{scroll-padding:auto;}"];
  [@css "._a_aghj9v{scroll-padding:0px;}"];
  [@css "._a_ag5af6{scroll-padding:6px 5px;}"];
  [@css "._a_agms3y{scroll-padding:10px 20px 30px;}"];
  [@css "._a_agalk9{scroll-padding:10px 20px 30px 40px;}"];
  [@css "._a_ag7x4v{scroll-padding:10px auto 30px auto;}"];
  [@css "._a_agywb5{scroll-padding:10%;}"];
  [@css "._a_agdoub{scroll-padding:20% 3em 1in 5rem;}"];
  [@css "._a_agicma{scroll-padding:calc(2px);}"];
  [@css "._a_ags866{scroll-padding:calc(50%);}"];
  [@css "._a_ag6ps6{scroll-padding:calc(3 * 25px);}"];
  [@css "._a_agm7if{scroll-padding:calc(3 * 25px) 5px 10% calc(10% - 5px);}"];
  [@css "._a_ah3npc{scroll-padding-block:10px;}"];
  [@css "._a_ah7n61{scroll-padding-block:50%;}"];
  [@css "._a_ahn72y{scroll-padding-block:10px 50%;}"];
  [@css "._a_ahbmh3{scroll-padding-block:50% 50%;}"];
  [@css "._a_ah0001a4an{scroll-padding-block-end:10px;}"];
  [@css "._a_ah0001wq8b{scroll-padding-block-end:50%;}"];
  [@css "._a_ah0002tyb1{scroll-padding-block-start:10px;}"];
  [@css "._a_ah0002kly5{scroll-padding-block-start:50%;}"];
  [@css "._a_ag0001568d{scroll-padding-bottom:10px;}"];
  [@css "._a_ag0001czmj{scroll-padding-bottom:50%;}"];
  [@css "._a_aihvee{scroll-padding-inline:10px;}"];
  [@css "._a_ai178e{scroll-padding-inline:50%;}"];
  [@css "._a_aifqw4{scroll-padding-inline:10px 50%;}"];
  [@css "._a_aijitd{scroll-padding-inline:50% 50%;}"];
  [@css "._a_ai0001xv1o{scroll-padding-inline-end:10px;}"];
  [@css "._a_ai0001ybsb{scroll-padding-inline-end:50%;}"];
  [@css "._a_ai000221xl{scroll-padding-inline-start:10px;}"];
  [@css "._a_ai0002s74z{scroll-padding-inline-start:50%;}"];
  [@css "._a_ag0002mm5y{scroll-padding-left:10px;}"];
  [@css "._a_ag0002jsh3{scroll-padding-left:50%;}"];
  [@css "._a_ag00043z1d{scroll-padding-right:10px;}"];
  [@css "._a_ag0004pbq8{scroll-padding-right:50%;}"];
  [@css "._a_ag000805tp{scroll-padding-top:10px;}"];
  [@css "._a_ag0008o8nm{scroll-padding-top:50%;}"];
  [@css "._a_ajhsyj{scroll-snap-align:none;}"];
  [@css "._a_ajpqsp{scroll-snap-align:start;}"];
  [@css "._a_ajic9p{scroll-snap-align:end;}"];
  [@css "._a_ajf1ss{scroll-snap-align:center;}"];
  [@css "._a_ajkzni{scroll-snap-align:none start;}"];
  [@css "._a_ajvewf{scroll-snap-align:end center;}"];
  [@css "._a_ajgzch{scroll-snap-align:center start;}"];
  [@css "._a_aj5icl{scroll-snap-align:end none;}"];
  [@css "._a_ajkijw{scroll-snap-align:center center;}"];
  [@css "._a_aoahur{scroll-snap-stop:normal;}"];
  [@css "._a_aoqcsf{scroll-snap-stop:always;}"];
  [@css "._a_apu1g1{scroll-snap-type:none;}"];
  [@css "._a_apigf3{scroll-snap-type:x mandatory;}"];
  [@css "._a_ap8bwf{scroll-snap-type:y mandatory;}"];
  [@css "._a_apyx25{scroll-snap-type:block mandatory;}"];
  [@css "._a_ape0h2{scroll-snap-type:inline mandatory;}"];
  [@css "._a_ap2jo5{scroll-snap-type:both mandatory;}"];
  [@css "._a_apl9bg{scroll-snap-type:x proximity;}"];
  [@css "._a_api18o{scroll-snap-type:y proximity;}"];
  [@css "._a_apeyk4{scroll-snap-type:block proximity;}"];
  [@css "._a_apr31t{scroll-snap-type:inline proximity;}"];
  [@css "._a_apvwfl{scroll-snap-type:both proximity;}"];
  [@css.blocks
    [
      (2, "_a_acoiv8"),
      (3, "_a_acqcuf"),
      (4, "_a_acxymj"),
      (5, "_a_acu2fa"),
      (6, "_a_ac13tb"),
      (7, "_a_ac9mki"),
      (8, "_a_ac3nfx"),
      (9, "_a_ac600i"),
      (10, "_a_adu6my"),
      (11, "_a_ad4sq4"),
      (12, "_a_ad000115zm"),
      (13, "_a_ad00024bj5"),
      (14, "_a_ac0001vqxc"),
      (15, "_a_ae12qs"),
      (16, "_a_aemvdw"),
      (17, "_a_ae0002snad"),
      (18, "_a_ae00019xfm"),
      (19, "_a_ac0002fvv1"),
      (20, "_a_ac0004la2e"),
      (21, "_a_ac0008aols"),
      (22, "_a_ag5nxv"),
      (23, "_a_aghj9v"),
      (24, "_a_ag5af6"),
      (25, "_a_agms3y"),
      (26, "_a_agalk9"),
      (27, "_a_ag7x4v"),
      (28, "_a_agywb5"),
      (29, "_a_agdoub"),
      (30, "_a_agicma"),
      (31, "_a_ags866"),
      (32, "_a_ag6ps6"),
      (33, "_a_agm7if"),
      (34, "_a_ah3npc"),
      (35, "_a_ah7n61"),
      (36, "_a_ahn72y"),
      (37, "_a_ahbmh3"),
      (38, "_a_ah0001a4an"),
      (39, "_a_ah0001wq8b"),
      (40, "_a_ah0002tyb1"),
      (41, "_a_ah0002kly5"),
      (42, "_a_ag0001568d"),
      (43, "_a_ag0001czmj"),
      (44, "_a_aihvee"),
      (45, "_a_ai178e"),
      (46, "_a_aifqw4"),
      (47, "_a_aijitd"),
      (48, "_a_ai0001xv1o"),
      (49, "_a_ai0001ybsb"),
      (50, "_a_ai000221xl"),
      (51, "_a_ai0002s74z"),
      (52, "_a_ag0002mm5y"),
      (53, "_a_ag0002jsh3"),
      (54, "_a_ag00043z1d"),
      (55, "_a_ag0004pbq8"),
      (56, "_a_ag000805tp"),
      (57, "_a_ag0008o8nm"),
      (58, "_a_ajhsyj"),
      (59, "_a_ajpqsp"),
      (60, "_a_ajic9p"),
      (61, "_a_ajf1ss"),
      (62, "_a_ajkzni"),
      (63, "_a_ajvewf"),
      (64, "_a_ajgzch"),
      (65, "_a_aj5icl"),
      (66, "_a_ajkijw"),
      (67, "_a_aoahur"),
      (68, "_a_aoqcsf"),
      (69, "_a_apu1g1"),
      (70, "_a_apigf3"),
      (71, "_a_ap8bwf"),
      (72, "_a_apyx25"),
      (73, "_a_ape0h2"),
      (74, "_a_ap2jo5"),
      (75, "_a_apl9bg"),
      (76, "_a_api18o"),
      (77, "_a_apeyk4"),
      (78, "_a_apr31t"),
      (79, "_a_apvwfl"),
    ]
  ];
  
  CSS.make("_a_acoiv8", []);
  CSS.make("_a_acqcuf", []);
  CSS.make("_a_acxymj", []);
  CSS.make("_a_acu2fa", []);
  CSS.make("_a_ac13tb", []);
  CSS.make("_a_ac9mki", []);
  CSS.make("_a_ac3nfx", []);
  CSS.make("_a_ac600i", []);
  CSS.make("_a_adu6my", []);
  CSS.make("_a_ad4sq4", []);
  CSS.make("_a_ad000115zm", []);
  CSS.make("_a_ad00024bj5", []);
  CSS.make("_a_ac0001vqxc", []);
  CSS.make("_a_ae12qs", []);
  CSS.make("_a_aemvdw", []);
  CSS.make("_a_ae0002snad", []);
  CSS.make("_a_ae00019xfm", []);
  CSS.make("_a_ac0002fvv1", []);
  CSS.make("_a_ac0004la2e", []);
  CSS.make("_a_ac0008aols", []);
  CSS.make("_a_ag5nxv", []);
  CSS.make("_a_aghj9v", []);
  CSS.make("_a_ag5af6", []);
  CSS.make("_a_agms3y", []);
  CSS.make("_a_agalk9", []);
  CSS.make("_a_ag7x4v", []);
  CSS.make("_a_agywb5", []);
  CSS.make("_a_agdoub", []);
  CSS.make("_a_agicma", []);
  CSS.make("_a_ags866", []);
  CSS.make("_a_ag6ps6", []);
  CSS.make("_a_agm7if", []);
  CSS.make("_a_ah3npc", []);
  CSS.make("_a_ah7n61", []);
  CSS.make("_a_ahn72y", []);
  CSS.make("_a_ahbmh3", []);
  CSS.make("_a_ah0001a4an", []);
  CSS.make("_a_ah0001wq8b", []);
  CSS.make("_a_ah0002tyb1", []);
  CSS.make("_a_ah0002kly5", []);
  CSS.make("_a_ag0001568d", []);
  CSS.make("_a_ag0001czmj", []);
  CSS.make("_a_aihvee", []);
  CSS.make("_a_ai178e", []);
  CSS.make("_a_aifqw4", []);
  CSS.make("_a_aijitd", []);
  CSS.make("_a_ai0001xv1o", []);
  CSS.make("_a_ai0001ybsb", []);
  CSS.make("_a_ai000221xl", []);
  CSS.make("_a_ai0002s74z", []);
  CSS.make("_a_ag0002mm5y", []);
  CSS.make("_a_ag0002jsh3", []);
  CSS.make("_a_ag00043z1d", []);
  CSS.make("_a_ag0004pbq8", []);
  CSS.make("_a_ag000805tp", []);
  CSS.make("_a_ag0008o8nm", []);
  CSS.make("_a_ajhsyj", []);
  CSS.make("_a_ajpqsp", []);
  CSS.make("_a_ajic9p", []);
  CSS.make("_a_ajf1ss", []);
  CSS.make("_a_ajkzni", []);
  CSS.make("_a_ajvewf", []);
  CSS.make("_a_ajgzch", []);
  CSS.make("_a_aj5icl", []);
  CSS.make("_a_ajkijw", []);
  CSS.make("_a_aoahur", []);
  CSS.make("_a_aoqcsf", []);
  CSS.make("_a_apu1g1", []);
  CSS.make("_a_apigf3", []);
  CSS.make("_a_ap8bwf", []);
  CSS.make("_a_apyx25", []);
  CSS.make("_a_ape0h2", []);
  CSS.make("_a_ap2jo5", []);
  CSS.make("_a_apl9bg", []);
  CSS.make("_a_api18o", []);
  CSS.make("_a_apeyk4", []);
  CSS.make("_a_apr31t", []);
  CSS.make("_a_apvwfl", []);
