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
    ("._a_7lcixw{line-clamp:none;}", "_a_7lcixw", "0,1,0 own", "273", 1, false)
  ];
  [@css
    ("._a_7lhhy3{line-clamp:1;}", "_a_7lhhy3", "0,1,0 own", "273", 1, false)
  ];
  [@css
    ("._a_87eyiu{max-lines:none;}", "_a_87eyiu", "0,1,0 own", "295", 1, false)
  ];
  [@css
    ("._a_87khmq{max-lines:1;}", "_a_87khmq", "0,1,0 own", "295", 1, false)
  ];
  [@css
    (
      "._a_8r0001bhz6{overflow-x:visible;}",
      "_a_8r0001bhz6",
      "0,1,0 own",
      "315",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8r0001o3b9{overflow-x:hidden;}",
      "_a_8r0001o3b9",
      "0,1,0 own",
      "315",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8r00013fel{overflow-x:clip;}",
      "_a_8r00013fel",
      "0,1,0 own",
      "315",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8r0001d1he{overflow-x:scroll;}",
      "_a_8r0001d1he",
      "0,1,0 own",
      "315",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8r0001shjd{overflow-x:auto;}",
      "_a_8r0001shjd",
      "0,1,0 own",
      "315",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8r0002v34m{overflow-y:visible;}",
      "_a_8r0002v34m",
      "0,1,0 own",
      "315",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8r0002vlu9{overflow-y:hidden;}",
      "_a_8r0002vlu9",
      "0,1,0 own",
      "315",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8r00023dqe{overflow-y:clip;}",
      "_a_8r00023dqe",
      "0,1,0 own",
      "315",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8r0002vnbz{overflow-y:scroll;}",
      "_a_8r0002vnbz",
      "0,1,0 own",
      "315",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8r00023rg8{overflow-y:auto;}",
      "_a_8r00023rg8",
      "0,1,0 own",
      "315",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8w7o30{overflow-inline:visible;}",
      "_a_8w7o30",
      "0,1,0 own",
      "320",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8wocar{overflow-inline:hidden;}",
      "_a_8wocar",
      "0,1,0 own",
      "320",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8wmbnd{overflow-inline:clip;}",
      "_a_8wmbnd",
      "0,1,0 own",
      "320",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8wvnt4{overflow-inline:scroll;}",
      "_a_8wvnt4",
      "0,1,0 own",
      "320",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8wl3d7{overflow-inline:auto;}",
      "_a_8wl3d7",
      "0,1,0 own",
      "320",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8t376w{overflow-block:visible;}",
      "_a_8t376w",
      "0,1,0 own",
      "317",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8ti9nl{overflow-block:hidden;}",
      "_a_8ti9nl",
      "0,1,0 own",
      "317",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8tmqtl{overflow-block:clip;}",
      "_a_8tmqtl",
      "0,1,0 own",
      "317",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8t7b3k{overflow-block:scroll;}",
      "_a_8t7b3k",
      "0,1,0 own",
      "317",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8te70x{overflow-block:auto;}",
      "_a_8te70x",
      "0,1,0 own",
      "317",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_bdyyg0{scrollbar-gutter:auto;}",
      "_a_bdyyg0",
      "0,1,0 own",
      "409",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_bdkn4i{scrollbar-gutter:stable;}",
      "_a_bdkn4i",
      "0,1,0 own",
      "409",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_bd0g5d{scrollbar-gutter:both-edges stable;}",
      "_a_bd0g5d",
      "0,1,0 own",
      "409",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_bdacsl{scrollbar-gutter:stable both-edges;}",
      "_a_bdacsl",
      "0,1,0 own",
      "409",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8vw8p9{overflow-clip-margin:content-box;}",
      "_a_8vw8p9",
      "0,1,0 own",
      "319",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_8vc69b{overflow-clip-margin:padding-box;}",
      "_a_8vc69b",
      "0,1,0 own",
      "319",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_8v4htk{overflow-clip-margin:border-box;}",
      "_a_8v4htk",
      "0,1,0 own",
      "319",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_8vg26a{overflow-clip-margin:20px;}",
      "_a_8vg26a",
      "0,1,0 own",
      "319",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_8vluqi{overflow-clip-margin:1em;}",
      "_a_8vluqi",
      "0,1,0 own",
      "319",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_8vxgse{overflow-clip-margin:content-box 5px;}",
      "_a_8vxgse",
      "0,1,0 own",
      "319",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_8v8vwx{overflow-clip-margin:5px content-box;}",
      "_a_8v8vwx",
      "0,1,0 own",
      "319",
      15,
      false,
    )
  ];
  [@css.blocks
    [
      (2, "", [0]),
      (3, "", [1]),
      (6, "", [2]),
      (7, "", [3]),
      (8, "", [4]),
      (9, "", [5]),
      (10, "", [6]),
      (11, "", [7]),
      (12, "", [8]),
      (13, "", [9]),
      (14, "", [10]),
      (15, "", [11]),
      (16, "", [12]),
      (17, "", [13]),
      (18, "", [14]),
      (19, "", [15]),
      (20, "", [16]),
      (21, "", [17]),
      (22, "", [18]),
      (23, "", [19]),
      (24, "", [20]),
      (25, "", [21]),
      (26, "", [22]),
      (27, "", [23]),
      (28, "", [24]),
      (29, "", [25]),
      (30, "", [26]),
      (31, "", [27]),
      (32, "", [28]),
      (33, "", [29]),
      (34, "", [30]),
      (35, "", [31]),
      (36, "", [32]),
      (37, "", [33]),
      (38, "", [34]),
    ]
  ];
  
  CSS.make("_a_7lcixw", []);
  CSS.make("_a_7lhhy3", []);
  
  CSS.make("_a_87eyiu", []);
  CSS.make("_a_87khmq", []);
  CSS.make("_a_8r0001bhz6", []);
  CSS.make("_a_8r0001o3b9", []);
  CSS.make("_a_8r00013fel", []);
  CSS.make("_a_8r0001d1he", []);
  CSS.make("_a_8r0001shjd", []);
  CSS.make("_a_8r0002v34m", []);
  CSS.make("_a_8r0002vlu9", []);
  CSS.make("_a_8r00023dqe", []);
  CSS.make("_a_8r0002vnbz", []);
  CSS.make("_a_8r00023rg8", []);
  CSS.make("_a_8w7o30", []);
  CSS.make("_a_8wocar", []);
  CSS.make("_a_8wmbnd", []);
  CSS.make("_a_8wvnt4", []);
  CSS.make("_a_8wl3d7", []);
  CSS.make("_a_8t376w", []);
  CSS.make("_a_8ti9nl", []);
  CSS.make("_a_8tmqtl", []);
  CSS.make("_a_8t7b3k", []);
  CSS.make("_a_8te70x", []);
  CSS.make("_a_bdyyg0", []);
  CSS.make("_a_bdkn4i", []);
  CSS.make("_a_bd0g5d", []);
  CSS.make("_a_bdacsl", []);
  CSS.make("_a_8vw8p9", []);
  CSS.make("_a_8vc69b", []);
  CSS.make("_a_8v4htk", []);
  CSS.make("_a_8vg26a", []);
  CSS.make("_a_8vluqi", []);
  CSS.make("_a_8vxgse", []);
  CSS.make("_a_8v8vwx", []);
