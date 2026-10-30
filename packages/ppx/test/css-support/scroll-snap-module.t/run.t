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
    (
      "._a_acoiv8{scroll-margin:0px;}",
      "_a_acoiv8",
      "0,1,0 own",
      "372",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_acqcuf{scroll-margin:6px 5px;}",
      "_a_acqcuf",
      "0,1,0 own",
      "372",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_acxymj{scroll-margin:10px 20px 30px;}",
      "_a_acxymj",
      "0,1,0 own",
      "372",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_acu2fa{scroll-margin:10px 20px 30px 40px;}",
      "_a_acu2fa",
      "0,1,0 own",
      "372",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_ac13tb{scroll-margin:20px 3em 1in 5rem;}",
      "_a_ac13tb",
      "0,1,0 own",
      "372",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_ac9mki{scroll-margin:calc(2px);}",
      "_a_ac9mki",
      "0,1,0 own",
      "372",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_ac3nfx{scroll-margin:calc(3 * 25px);}",
      "_a_ac3nfx",
      "0,1,0 own",
      "372",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_ac600i{scroll-margin:calc(3 * 25px) 5px 10em calc(1vw - 5px);}",
      "_a_ac600i",
      "0,1,0 own",
      "372",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_adu6my{scroll-margin-block:10px;}",
      "_a_adu6my",
      "0,1,0 own",
      "373",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_ad4sq4{scroll-margin-block:10px 10px;}",
      "_a_ad4sq4",
      "0,1,0 own",
      "373",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_ad000115zm{scroll-margin-block-end:10px;}",
      "_a_ad000115zm",
      "0,1,0 own",
      "373",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ad00024bj5{scroll-margin-block-start:10px;}",
      "_a_ad00024bj5",
      "0,1,0 own",
      "373",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_ac0001vqxc{scroll-margin-bottom:10px;}",
      "_a_ac0001vqxc",
      "0,1,0 own",
      "372",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ae12qs{scroll-margin-inline:10px;}",
      "_a_ae12qs",
      "0,1,0 own",
      "374",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_aemvdw{scroll-margin-inline:10px 10px;}",
      "_a_aemvdw",
      "0,1,0 own",
      "374",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_ae0002snad{scroll-margin-inline-start:10px;}",
      "_a_ae0002snad",
      "0,1,0 own",
      "374",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_ae00019xfm{scroll-margin-inline-end:10px;}",
      "_a_ae00019xfm",
      "0,1,0 own",
      "374",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ac0002fvv1{scroll-margin-left:10px;}",
      "_a_ac0002fvv1",
      "0,1,0 own",
      "372",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_ac0004la2e{scroll-margin-right:10px;}",
      "_a_ac0004la2e",
      "0,1,0 own",
      "372",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_ac0008aols{scroll-margin-top:10px;}",
      "_a_ac0008aols",
      "0,1,0 own",
      "372",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_ag5nxv{scroll-padding:auto;}",
      "_a_ag5nxv",
      "0,1,0 own",
      "376",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_aghj9v{scroll-padding:0px;}",
      "_a_aghj9v",
      "0,1,0 own",
      "376",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_ag5af6{scroll-padding:6px 5px;}",
      "_a_ag5af6",
      "0,1,0 own",
      "376",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_agms3y{scroll-padding:10px 20px 30px;}",
      "_a_agms3y",
      "0,1,0 own",
      "376",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_agalk9{scroll-padding:10px 20px 30px 40px;}",
      "_a_agalk9",
      "0,1,0 own",
      "376",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_ag7x4v{scroll-padding:10px auto 30px auto;}",
      "_a_ag7x4v",
      "0,1,0 own",
      "376",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_agywb5{scroll-padding:10%;}",
      "_a_agywb5",
      "0,1,0 own",
      "376",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_agdoub{scroll-padding:20% 3em 1in 5rem;}",
      "_a_agdoub",
      "0,1,0 own",
      "376",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_agicma{scroll-padding:calc(2px);}",
      "_a_agicma",
      "0,1,0 own",
      "376",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_ags866{scroll-padding:calc(50%);}",
      "_a_ags866",
      "0,1,0 own",
      "376",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_ag6ps6{scroll-padding:calc(3 * 25px);}",
      "_a_ag6ps6",
      "0,1,0 own",
      "376",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_agm7if{scroll-padding:calc(3 * 25px) 5px 10% calc(10% - 5px);}",
      "_a_agm7if",
      "0,1,0 own",
      "376",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_ah3npc{scroll-padding-block:10px;}",
      "_a_ah3npc",
      "0,1,0 own",
      "377",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_ah7n61{scroll-padding-block:50%;}",
      "_a_ah7n61",
      "0,1,0 own",
      "377",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_ahn72y{scroll-padding-block:10px 50%;}",
      "_a_ahn72y",
      "0,1,0 own",
      "377",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_ahbmh3{scroll-padding-block:50% 50%;}",
      "_a_ahbmh3",
      "0,1,0 own",
      "377",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_ah0001a4an{scroll-padding-block-end:10px;}",
      "_a_ah0001a4an",
      "0,1,0 own",
      "377",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ah0001wq8b{scroll-padding-block-end:50%;}",
      "_a_ah0001wq8b",
      "0,1,0 own",
      "377",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ah0002tyb1{scroll-padding-block-start:10px;}",
      "_a_ah0002tyb1",
      "0,1,0 own",
      "377",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_ah0002kly5{scroll-padding-block-start:50%;}",
      "_a_ah0002kly5",
      "0,1,0 own",
      "377",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_ag0001568d{scroll-padding-bottom:10px;}",
      "_a_ag0001568d",
      "0,1,0 own",
      "376",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ag0001czmj{scroll-padding-bottom:50%;}",
      "_a_ag0001czmj",
      "0,1,0 own",
      "376",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_aihvee{scroll-padding-inline:10px;}",
      "_a_aihvee",
      "0,1,0 own",
      "378",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_ai178e{scroll-padding-inline:50%;}",
      "_a_ai178e",
      "0,1,0 own",
      "378",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_aifqw4{scroll-padding-inline:10px 50%;}",
      "_a_aifqw4",
      "0,1,0 own",
      "378",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_aijitd{scroll-padding-inline:50% 50%;}",
      "_a_aijitd",
      "0,1,0 own",
      "378",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_ai0001xv1o{scroll-padding-inline-end:10px;}",
      "_a_ai0001xv1o",
      "0,1,0 own",
      "378",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ai0001ybsb{scroll-padding-inline-end:50%;}",
      "_a_ai0001ybsb",
      "0,1,0 own",
      "378",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ai000221xl{scroll-padding-inline-start:10px;}",
      "_a_ai000221xl",
      "0,1,0 own",
      "378",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_ai0002s74z{scroll-padding-inline-start:50%;}",
      "_a_ai0002s74z",
      "0,1,0 own",
      "378",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_ag0002mm5y{scroll-padding-left:10px;}",
      "_a_ag0002mm5y",
      "0,1,0 own",
      "376",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_ag0002jsh3{scroll-padding-left:50%;}",
      "_a_ag0002jsh3",
      "0,1,0 own",
      "376",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_ag00043z1d{scroll-padding-right:10px;}",
      "_a_ag00043z1d",
      "0,1,0 own",
      "376",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_ag0004pbq8{scroll-padding-right:50%;}",
      "_a_ag0004pbq8",
      "0,1,0 own",
      "376",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_ag000805tp{scroll-padding-top:10px;}",
      "_a_ag000805tp",
      "0,1,0 own",
      "376",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_ag0008o8nm{scroll-padding-top:50%;}",
      "_a_ag0008o8nm",
      "0,1,0 own",
      "376",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_ajhsyj{scroll-snap-align:none;}",
      "_a_ajhsyj",
      "0,1,0 own",
      "379",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ajpqsp{scroll-snap-align:start;}",
      "_a_ajpqsp",
      "0,1,0 own",
      "379",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ajic9p{scroll-snap-align:end;}",
      "_a_ajic9p",
      "0,1,0 own",
      "379",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ajf1ss{scroll-snap-align:center;}",
      "_a_ajf1ss",
      "0,1,0 own",
      "379",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ajkzni{scroll-snap-align:none start;}",
      "_a_ajkzni",
      "0,1,0 own",
      "379",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ajvewf{scroll-snap-align:end center;}",
      "_a_ajvewf",
      "0,1,0 own",
      "379",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ajgzch{scroll-snap-align:center start;}",
      "_a_ajgzch",
      "0,1,0 own",
      "379",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_aj5icl{scroll-snap-align:end none;}",
      "_a_aj5icl",
      "0,1,0 own",
      "379",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ajkijw{scroll-snap-align:center center;}",
      "_a_ajkijw",
      "0,1,0 own",
      "379",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_aoahur{scroll-snap-stop:normal;}",
      "_a_aoahur",
      "0,1,0 own",
      "384",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_aoqcsf{scroll-snap-stop:always;}",
      "_a_aoqcsf",
      "0,1,0 own",
      "384",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_apu1g1{scroll-snap-type:none;}",
      "_a_apu1g1",
      "0,1,0 own",
      "385",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_apigf3{scroll-snap-type:x mandatory;}",
      "_a_apigf3",
      "0,1,0 own",
      "385",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ap8bwf{scroll-snap-type:y mandatory;}",
      "_a_ap8bwf",
      "0,1,0 own",
      "385",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_apyx25{scroll-snap-type:block mandatory;}",
      "_a_apyx25",
      "0,1,0 own",
      "385",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ape0h2{scroll-snap-type:inline mandatory;}",
      "_a_ape0h2",
      "0,1,0 own",
      "385",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ap2jo5{scroll-snap-type:both mandatory;}",
      "_a_ap2jo5",
      "0,1,0 own",
      "385",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_apl9bg{scroll-snap-type:x proximity;}",
      "_a_apl9bg",
      "0,1,0 own",
      "385",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_api18o{scroll-snap-type:y proximity;}",
      "_a_api18o",
      "0,1,0 own",
      "385",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_apeyk4{scroll-snap-type:block proximity;}",
      "_a_apeyk4",
      "0,1,0 own",
      "385",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_apr31t{scroll-snap-type:inline proximity;}",
      "_a_apr31t",
      "0,1,0 own",
      "385",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_apvwfl{scroll-snap-type:both proximity;}",
      "_a_apvwfl",
      "0,1,0 own",
      "385",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (2, "", [0]),
      (3, "", [1]),
      (4, "", [2]),
      (5, "", [3]),
      (6, "", [4]),
      (7, "", [5]),
      (8, "", [6]),
      (9, "", [7]),
      (10, "", [8]),
      (11, "", [9]),
      (12, "", [10]),
      (13, "", [11]),
      (14, "", [12]),
      (15, "", [13]),
      (16, "", [14]),
      (17, "", [15]),
      (18, "", [16]),
      (19, "", [17]),
      (20, "", [18]),
      (21, "", [19]),
      (22, "", [20]),
      (23, "", [21]),
      (24, "", [22]),
      (25, "", [23]),
      (26, "", [24]),
      (27, "", [25]),
      (28, "", [26]),
      (29, "", [27]),
      (30, "", [28]),
      (31, "", [29]),
      (32, "", [30]),
      (33, "", [31]),
      (34, "", [32]),
      (35, "", [33]),
      (36, "", [34]),
      (37, "", [35]),
      (38, "", [36]),
      (39, "", [37]),
      (40, "", [38]),
      (41, "", [39]),
      (42, "", [40]),
      (43, "", [41]),
      (44, "", [42]),
      (45, "", [43]),
      (46, "", [44]),
      (47, "", [45]),
      (48, "", [46]),
      (49, "", [47]),
      (50, "", [48]),
      (51, "", [49]),
      (52, "", [50]),
      (53, "", [51]),
      (54, "", [52]),
      (55, "", [53]),
      (56, "", [54]),
      (57, "", [55]),
      (58, "", [56]),
      (59, "", [57]),
      (60, "", [58]),
      (61, "", [59]),
      (62, "", [60]),
      (63, "", [61]),
      (64, "", [62]),
      (65, "", [63]),
      (66, "", [64]),
      (67, "", [65]),
      (68, "", [66]),
      (69, "", [67]),
      (70, "", [68]),
      (71, "", [69]),
      (72, "", [70]),
      (73, "", [71]),
      (74, "", [72]),
      (75, "", [73]),
      (76, "", [74]),
      (77, "", [75]),
      (78, "", [76]),
      (79, "", [77]),
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
