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
      "._a_ec3le8{width:-webkit-max-content;width:-moz-max-content;width:max-content;}",
      "_a_ec3le8",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ecckkm{width:-moz-min-content;width:min-content;}",
      "_a_ecckkm",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ecccy6{width:fit-content(10%);}",
      "_a_ecccy6",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8cktvk{min-width:-webkit-max-content;min-width:-moz-max-content;min-width:max-content;}",
      "_a_8cktvk",
      "0,1,0 own",
      "300",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8creoz{min-width:-moz-min-content;min-width:min-content;}",
      "_a_8creoz",
      "0,1,0 own",
      "300",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8ckswh{min-width:fit-content(10%);}",
      "_a_8ckswh",
      "0,1,0 own",
      "300",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_88c9a0{max-width:-webkit-max-content;max-width:-moz-max-content;max-width:max-content;}",
      "_a_88c9a0",
      "0,1,0 own",
      "296",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_88nlwm{max-width:-moz-min-content;max-width:min-content;}",
      "_a_88nlwm",
      "0,1,0 own",
      "296",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_88zzeg{max-width:fit-content(10%);}",
      "_a_88zzeg",
      "0,1,0 own",
      "296",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6l27ji{height:-webkit-max-content;height:-moz-max-content;height:max-content;}",
      "_a_6l27ji",
      "0,1,0 own",
      "237",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6lzl7o{height:-moz-min-content;height:min-content;}",
      "_a_6lzl7o",
      "0,1,0 own",
      "237",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6lv2pj{height:fit-content(10%);}",
      "_a_6lv2pj",
      "0,1,0 own",
      "237",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8ayx8i{min-height:-webkit-max-content;min-height:-moz-max-content;min-height:max-content;}",
      "_a_8ayx8i",
      "0,1,0 own",
      "298",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8ap2tk{min-height:-moz-min-content;min-height:min-content;}",
      "_a_8ap2tk",
      "0,1,0 own",
      "298",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8abza9{min-height:fit-content(10%);}",
      "_a_8abza9",
      "0,1,0 own",
      "298",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_85yxes{max-height:-webkit-max-content;max-height:-moz-max-content;max-height:max-content;}",
      "_a_85yxes",
      "0,1,0 own",
      "293",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_854hk2{max-height:-moz-min-content;max-height:min-content;}",
      "_a_854hk2",
      "0,1,0 own",
      "293",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_85ct3b{max-height:fit-content(10%);}",
      "_a_85ct3b",
      "0,1,0 own",
      "293",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_35cmp3{aspect-ratio:auto;}",
      "_a_35cmp3",
      "0,1,0 own",
      "113",
      1,
      false,
    )
  ];
  [@css
    ("._a_35qo31{aspect-ratio:2;}", "_a_35qo31", "0,1,0 own", "113", 1, false)
  ];
  [@css
    (
      "._a_35vr3s{aspect-ratio:16 / 9;}",
      "_a_35vr3s",
      "0,1,0 own",
      "113",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ecanqs{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}",
      "_a_ecanqs",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8c4rbf{min-width:-webkit-fit-content;min-width:-moz-fit-content;min-width:fit-content;}",
      "_a_8c4rbf",
      "0,1,0 own",
      "300",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_88hjh6{max-width:-webkit-fit-content;max-width:-moz-fit-content;max-width:fit-content;}",
      "_a_88hjh6",
      "0,1,0 own",
      "296",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6l0xge{height:-webkit-fit-content;height:-moz-fit-content;height:fit-content;}",
      "_a_6l0xge",
      "0,1,0 own",
      "237",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8ax31z{min-height:-webkit-fit-content;min-height:-moz-fit-content;min-height:fit-content;}",
      "_a_8ax31z",
      "0,1,0 own",
      "298",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_85e59j{max-height:-webkit-fit-content;max-height:-moz-fit-content;max-height:fit-content;}",
      "_a_85e59j",
      "0,1,0 own",
      "293",
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
      (25, "", [18]),
      (26, "", [19]),
      (27, "", [20]),
      (41, "", [21]),
      (44, "", [22]),
      (47, "", [23]),
      (50, "", [24]),
      (53, "", [25]),
      (56, "", [26]),
    ]
  ];
  
  CSS.make("_a_ec3le8", []);
  CSS.make("_a_ecckkm", []);
  CSS.make("_a_ecccy6", []);
  CSS.make("_a_8cktvk", []);
  CSS.make("_a_8creoz", []);
  CSS.make("_a_8ckswh", []);
  CSS.make("_a_88c9a0", []);
  CSS.make("_a_88nlwm", []);
  CSS.make("_a_88zzeg", []);
  CSS.make("_a_6l27ji", []);
  CSS.make("_a_6lzl7o", []);
  CSS.make("_a_6lv2pj", []);
  CSS.make("_a_8ayx8i", []);
  CSS.make("_a_8ap2tk", []);
  CSS.make("_a_8abza9", []);
  CSS.make("_a_85yxes", []);
  CSS.make("_a_854hk2", []);
  CSS.make("_a_85ct3b", []);
  
  CSS.make("_a_35cmp3", []);
  CSS.make("_a_35qo31", []);
  CSS.make("_a_35vr3s", []);
  
  CSS.make("_a_ecanqs", []);
  
  CSS.make("_a_8c4rbf", []);
  
  CSS.make("_a_88hjh6", []);
  
  CSS.make("_a_6l0xge", []);
  
  CSS.make("_a_8ax31z", []);
  
  CSS.make("_a_85e59j", []);
