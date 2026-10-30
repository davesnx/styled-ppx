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
      "._a_7o00047qfq{list-style-type:disclosure-closed;}",
      "_a_7o00047qfq",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004a7xp{list-style-type:disclosure-open;}",
      "_a_7o0004a7xp",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o000429pt{list-style-type:hebrew;}",
      "_a_7o000429pt",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004gvd0{list-style-type:cjk-decimal;}",
      "_a_7o0004gvd0",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004cgrv{list-style-type:cjk-ideographic;}",
      "_a_7o0004cgrv",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o00041x6a{list-style-type:hiragana;}",
      "_a_7o00041x6a",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004g83j{list-style-type:katakana;}",
      "_a_7o0004g83j",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004cvle{list-style-type:hiragana-iroha;}",
      "_a_7o0004cvle",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004x9p6{list-style-type:katakana-iroha;}",
      "_a_7o0004x9p6",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o00040nt8{list-style-type:japanese-informal;}",
      "_a_7o00040nt8",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o00041qzs{list-style-type:japanese-formal;}",
      "_a_7o00041qzs",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o00043x3n{list-style-type:korean-hangul-formal;}",
      "_a_7o00043x3n",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004ci9d{list-style-type:korean-hanja-informal;}",
      "_a_7o0004ci9d",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004rmxn{list-style-type:korean-hanja-formal;}",
      "_a_7o0004rmxn",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004epun{list-style-type:simp-chinese-informal;}",
      "_a_7o0004epun",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004rzxz{list-style-type:simp-chinese-formal;}",
      "_a_7o0004rzxz",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004x53p{list-style-type:trad-chinese-informal;}",
      "_a_7o0004x53p",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o00047nk5{list-style-type:trad-chinese-formal;}",
      "_a_7o00047nk5",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004ah5j{list-style-type:cjk-heavenly-stem;}",
      "_a_7o0004ah5j",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004k2eu{list-style-type:cjk-earthly-branch;}",
      "_a_7o0004k2eu",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004g87t{list-style-type:arabic-indic;}",
      "_a_7o0004g87t",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004q4ct{list-style-type:persian;}",
      "_a_7o0004q4ct",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004wplg{list-style-type:urdu;}",
      "_a_7o0004wplg",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004t1xg{list-style-type:devanagari;}",
      "_a_7o0004t1xg",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o00042uqw{list-style-type:gurmukhi;}",
      "_a_7o00042uqw",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004sykj{list-style-type:gujarati;}",
      "_a_7o0004sykj",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004xd5p{list-style-type:oriya;}",
      "_a_7o0004xd5p",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o00040osi{list-style-type:kannada;}",
      "_a_7o00040osi",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o00047eay{list-style-type:malayalam;}",
      "_a_7o00047eay",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o00041vws{list-style-type:bengali;}",
      "_a_7o00041vws",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004niwu{list-style-type:tamil;}",
      "_a_7o0004niwu",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004e5tz{list-style-type:telugu;}",
      "_a_7o0004e5tz",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o000466xg{list-style-type:thai;}",
      "_a_7o000466xg",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004d88w{list-style-type:lao;}",
      "_a_7o0004d88w",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004tt7z{list-style-type:myanmar;}",
      "_a_7o0004tt7z",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004a9oz{list-style-type:khmer;}",
      "_a_7o0004a9oz",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o00044hjf{list-style-type:hangul;}",
      "_a_7o00044hjf",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004bwmg{list-style-type:hangul-consonant;}",
      "_a_7o0004bwmg",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004vi2g{list-style-type:ethiopic-halehame;}",
      "_a_7o0004vi2g",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004bwzk{list-style-type:ethiopic-numeric;}",
      "_a_7o0004bwzk",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004y86w{list-style-type:ethiopic-halehame-am;}",
      "_a_7o0004y86w",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004b4u0{list-style-type:ethiopic-halehame-ti-er;}",
      "_a_7o0004b4u0",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004ek1d{list-style-type:ethiopic-halehame-ti-et;}",
      "_a_7o0004ek1d",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004kulm{list-style-type:other-style;}",
      "_a_7o0004kulm",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o00047fla{list-style-type:inside;}",
      "_a_7o00047fla",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004zn63{list-style-type:outside;}",
      "_a_7o0004zn63",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004pnng{list-style-type:\\32 style;}",
      "_a_7o0004pnng",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004wudt{list-style-type:custom-counter-style;}",
      "_a_7o0004wudt",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o0004mnj4{list-style-type:\"👍\";}",
      "_a_7o0004mnj4",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_7o000401lu{list-style-type:\"-\";}",
      "_a_7o000401lu",
      "0,1,0 own",
      "276",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_5gca5o{counter-reset:foo;}",
      "_a_5gca5o",
      "0,1,0 own",
      "196",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5gbp66{counter-reset:foo 1;}",
      "_a_5gbp66",
      "0,1,0 own",
      "196",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5g9y6l{counter-reset:foo 1 bar;}",
      "_a_5g9y6l",
      "0,1,0 own",
      "196",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5g56lo{counter-reset:foo 1 bar 2;}",
      "_a_5g56lo",
      "0,1,0 own",
      "196",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5gr1od{counter-reset:none;}",
      "_a_5gr1od",
      "0,1,0 own",
      "196",
      1,
      false,
    )
  ];
  [@css
    ("._a_5huxrl{counter-set:foo;}", "_a_5huxrl", "0,1,0 own", "197", 1, false)
  ];
  [@css
    (
      "._a_5hmudj{counter-set:foo 1;}",
      "_a_5hmudj",
      "0,1,0 own",
      "197",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5h4fvg{counter-set:foo 1 bar;}",
      "_a_5h4fvg",
      "0,1,0 own",
      "197",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5hq2fl{counter-set:foo 1 bar 2;}",
      "_a_5hq2fl",
      "0,1,0 own",
      "197",
      1,
      false,
    )
  ];
  [@css
    ("._a_5hk1na{counter-set:none;}", "_a_5hk1na", "0,1,0 own", "197", 1, false)
  ];
  [@css
    (
      "._a_5f213t{counter-increment:foo;}",
      "_a_5f213t",
      "0,1,0 own",
      "195",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5f82oh{counter-increment:foo 1;}",
      "_a_5f82oh",
      "0,1,0 own",
      "195",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5fxkjf{counter-increment:foo 1 bar;}",
      "_a_5fxkjf",
      "0,1,0 own",
      "195",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5fuicq{counter-increment:foo 1 bar 2;}",
      "_a_5fuicq",
      "0,1,0 own",
      "195",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5f5tkf{counter-increment:none;}",
      "_a_5f5tkf",
      "0,1,0 own",
      "195",
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
      (22, "", [16]),
      (23, "", [17]),
      (24, "", [14]),
      (25, "", [15]),
      (26, "", [9]),
      (27, "", [10]),
      (28, "", [20]),
      (29, "", [21]),
      (30, "", [22]),
      (31, "", [23]),
      (32, "", [24]),
      (33, "", [25]),
      (34, "", [26]),
      (35, "", [27]),
      (36, "", [28]),
      (37, "", [29]),
      (38, "", [30]),
      (39, "", [31]),
      (40, "", [32]),
      (41, "", [33]),
      (42, "", [34]),
      (43, "", [35]),
      (44, "", [36]),
      (45, "", [37]),
      (46, "", [38]),
      (47, "", [39]),
      (48, "", [40]),
      (49, "", [41]),
      (50, "", [42]),
      (51, "", [43]),
      (52, "", [44]),
      (53, "", [45]),
      (55, "", [46]),
      (56, "", [47]),
      (57, "", [48]),
      (58, "", [49]),
      (59, "", [49]),
      (64, "", [50]),
      (65, "", [51]),
      (66, "", [52]),
      (67, "", [53]),
      (68, "", [54]),
      (69, "", [55]),
      (70, "", [56]),
      (71, "", [57]),
      (72, "", [58]),
      (73, "", [59]),
      (74, "", [60]),
      (75, "", [61]),
      (76, "", [62]),
      (77, "", [63]),
      (78, "", [64]),
    ]
  ];
  
  CSS.make("_a_7o00047qfq", []);
  CSS.make("_a_7o0004a7xp", []);
  CSS.make("_a_7o000429pt", []);
  CSS.make("_a_7o0004gvd0", []);
  CSS.make("_a_7o0004cgrv", []);
  CSS.make("_a_7o00041x6a", []);
  CSS.make("_a_7o0004g83j", []);
  CSS.make("_a_7o0004cvle", []);
  CSS.make("_a_7o0004x9p6", []);
  CSS.make("_a_7o00040nt8", []);
  CSS.make("_a_7o00041qzs", []);
  CSS.make("_a_7o00043x3n", []);
  CSS.make("_a_7o0004ci9d", []);
  CSS.make("_a_7o0004rmxn", []);
  CSS.make("_a_7o0004epun", []);
  CSS.make("_a_7o0004rzxz", []);
  CSS.make("_a_7o0004x53p", []);
  CSS.make("_a_7o00047nk5", []);
  CSS.make("_a_7o0004ah5j", []);
  CSS.make("_a_7o0004k2eu", []);
  CSS.make("_a_7o0004x53p", []);
  CSS.make("_a_7o00047nk5", []);
  CSS.make("_a_7o0004epun", []);
  CSS.make("_a_7o0004rzxz", []);
  CSS.make("_a_7o00040nt8", []);
  CSS.make("_a_7o00041qzs", []);
  CSS.make("_a_7o0004g87t", []);
  CSS.make("_a_7o0004q4ct", []);
  CSS.make("_a_7o0004wplg", []);
  CSS.make("_a_7o0004t1xg", []);
  CSS.make("_a_7o00042uqw", []);
  CSS.make("_a_7o0004sykj", []);
  CSS.make("_a_7o0004xd5p", []);
  CSS.make("_a_7o00040osi", []);
  CSS.make("_a_7o00047eay", []);
  CSS.make("_a_7o00041vws", []);
  CSS.make("_a_7o0004niwu", []);
  CSS.make("_a_7o0004e5tz", []);
  CSS.make("_a_7o000466xg", []);
  CSS.make("_a_7o0004d88w", []);
  CSS.make("_a_7o0004tt7z", []);
  CSS.make("_a_7o0004a9oz", []);
  CSS.make("_a_7o00044hjf", []);
  CSS.make("_a_7o0004bwmg", []);
  CSS.make("_a_7o0004vi2g", []);
  CSS.make("_a_7o0004bwzk", []);
  CSS.make("_a_7o0004y86w", []);
  CSS.make("_a_7o0004b4u0", []);
  CSS.make("_a_7o0004ek1d", []);
  CSS.make("_a_7o0004kulm", []);
  CSS.make("_a_7o00047fla", []);
  CSS.make("_a_7o0004zn63", []);
  
  CSS.make("_a_7o0004pnng", []);
  CSS.make("_a_7o0004wudt", []);
  CSS.make("_a_7o0004mnj4", []);
  CSS.make("_a_7o000401lu", []);
  CSS.make("_a_7o000401lu", []);
  
  CSS.make("_a_5gca5o", []);
  CSS.make("_a_5gbp66", []);
  CSS.make("_a_5g9y6l", []);
  CSS.make("_a_5g56lo", []);
  CSS.make("_a_5gr1od", []);
  CSS.make("_a_5huxrl", []);
  CSS.make("_a_5hmudj", []);
  CSS.make("_a_5h4fvg", []);
  CSS.make("_a_5hq2fl", []);
  CSS.make("_a_5hk1na", []);
  CSS.make("_a_5f213t", []);
  CSS.make("_a_5f82oh", []);
  CSS.make("_a_5fxkjf", []);
  CSS.make("_a_5fuicq", []);
  CSS.make("_a_5f5tkf", []);
