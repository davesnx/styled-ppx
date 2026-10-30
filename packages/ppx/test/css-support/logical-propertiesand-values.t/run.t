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
      "._a_45900h{caption-side:inline-start;}",
      "_a_45900h",
      "0,1,0 own",
      "149",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_45oysp{caption-side:inline-end;}",
      "_a_45oysp",
      "0,1,0 own",
      "149",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_621xtx{float:inline-start;}",
      "_a_621xtx",
      "0,1,0 own",
      "218",
      1,
      false,
    )
  ];
  [@css
    ("._a_62h57g{float:inline-end;}", "_a_62h57g", "0,1,0 own", "218", 1, false)
  ];
  [@css
    (
      "._a_4a4ozg{clear:inline-start;}",
      "_a_4a4ozg",
      "0,1,0 own",
      "154",
      1,
      false,
    )
  ];
  [@css
    ("._a_4aii6p{clear:inline-end;}", "_a_4aii6p", "0,1,0 own", "154", 1, false)
  ];
  [@css
    ("._a_9ypnzc{resize:block;}", "_a_9ypnzc", "0,1,0 own", "358", 1, false)
  ];
  [@css
    ("._a_9yxrmj{resize:inline;}", "_a_9yxrmj", "0,1,0 own", "358", 1, false)
  ];
  [@css
    ("._a_3gn5n9{block-size:100px;}", "_a_3gn5n9", "0,1,0 own", "124", 1, false)
  ];
  [@css
    (
      "._a_70fzex{inline-size:100px;}",
      "_a_70fzex",
      "0,1,0 own",
      "252",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_89r9v3{min-block-size:100px;}",
      "_a_89r9v3",
      "0,1,0 own",
      "297",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8b5b66{min-inline-size:100px;}",
      "_a_8b5b66",
      "0,1,0 own",
      "299",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_84htmj{max-block-size:100px;}",
      "_a_84htmj",
      "0,1,0 own",
      "292",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_863dki{max-inline-size:100px;}",
      "_a_863dki",
      "0,1,0 own",
      "294",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7qvqzj{margin-block:10px;}",
      "_a_7qvqzj",
      "0,1,0 own",
      "278",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_7qwkom{margin-block:10px 10px;}",
      "_a_7qwkom",
      "0,1,0 own",
      "278",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_7q0002ulqf{margin-block-start:10px;}",
      "_a_7q0002ulqf",
      "0,1,0 own",
      "278",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_7q0001g6i4{margin-block-end:10px;}",
      "_a_7q0001g6i4",
      "0,1,0 own",
      "278",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7rwfix{margin-inline:10px;}",
      "_a_7rwfix",
      "0,1,0 own",
      "279",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_7rtclh{margin-inline:10px 10px;}",
      "_a_7rtclh",
      "0,1,0 own",
      "279",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_7r0002bip2{-webkit-margin-start:10px;margin-inline-start:10px;}",
      "_a_7r0002bip2",
      "0,1,0 own",
      "279",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_7r0001lgiv{-webkit-margin-end:10px;margin-inline-end:10px;}",
      "_a_7r0001lgiv",
      "0,1,0 own",
      "279",
      1,
      false,
    )
  ];
  [@css
    ("._a_712r9d{inset:10px;}", "_a_712r9d", "0,1,0 own", "253", 15, false)
  ];
  [@css
    ("._a_71sk63{inset:10px 10px;}", "_a_71sk63", "0,1,0 own", "253", 15, false)
  ];
  [@css
    (
      "._a_71kvre{inset:10px 10px 10px;}",
      "_a_71kvre",
      "0,1,0 own",
      "253",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_716yfv{inset:10px 10px 10px 10px;}",
      "_a_716yfv",
      "0,1,0 own",
      "253",
      15,
      false,
    )
  ];
  [@css
    ("._a_73tim3{inset-block:10px;}", "_a_73tim3", "0,1,0 own", "255", 3, false)
  ];
  [@css
    (
      "._a_731rg2{inset-block:10px 10px;}",
      "_a_731rg2",
      "0,1,0 own",
      "255",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_730002p0xv{inset-block-start:10px;}",
      "_a_730002p0xv",
      "0,1,0 own",
      "255",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_730001aygd{inset-block-end:10px;}",
      "_a_730001aygd",
      "0,1,0 own",
      "255",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_74qbqh{inset-inline:10px;}",
      "_a_74qbqh",
      "0,1,0 own",
      "256",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_74ws42{inset-inline:10px 10px;}",
      "_a_74ws42",
      "0,1,0 own",
      "256",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_740002ffa3{inset-inline-start:10px;}",
      "_a_740002ffa3",
      "0,1,0 own",
      "256",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_74000183h9{inset-inline-end:10px;}",
      "_a_74000183h9",
      "0,1,0 own",
      "256",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_95jrvu{padding-block:10px;}",
      "_a_95jrvu",
      "0,1,0 own",
      "329",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_953v6v{padding-block:10px 10px;}",
      "_a_953v6v",
      "0,1,0 own",
      "329",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_950002gdwe{padding-block-start:10px;}",
      "_a_950002gdwe",
      "0,1,0 own",
      "329",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_950001otoy{padding-block-end:10px;}",
      "_a_950001otoy",
      "0,1,0 own",
      "329",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_962b2w{padding-inline:10px;}",
      "_a_962b2w",
      "0,1,0 own",
      "330",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_969f8q{padding-inline:10px 10px;}",
      "_a_969f8q",
      "0,1,0 own",
      "330",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_960002js84{-webkit-padding-start:10px;padding-inline-start:10px;}",
      "_a_960002js84",
      "0,1,0 own",
      "330",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_960001ob79{-webkit-padding-end:10px;padding-inline-end:10px;}",
      "_a_960001ob79",
      "0,1,0 own",
      "330",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3ijynl{border-block:1px;}",
      "_a_3ijynl",
      "0,1,0 own",
      "126",
      63,
      false,
    )
  ];
  [@css
    (
      "._a_3ig7ep{border-block:2px dotted;}",
      "_a_3ig7ep",
      "0,1,0 own",
      "126",
      63,
      false,
    )
  ];
  [@css
    (
      "._a_3i5w5p{border-block:medium dashed green;}",
      "_a_3i5w5p",
      "0,1,0 own",
      "126",
      63,
      false,
    )
  ];
  [@css
    (
      "._a_3i001kby03{border-block-start:1px;}",
      "_a_3i001kby03",
      "0,1,0 own",
      "126",
      56,
      false,
    )
  ];
  [@css
    (
      "._a_3i001kza2k{border-block-start:2px dotted;}",
      "_a_3i001kza2k",
      "0,1,0 own",
      "126",
      56,
      false,
    )
  ];
  [@css
    (
      "._a_3i001khz8c{border-block-start:medium dashed green;}",
      "_a_3i001khz8c",
      "0,1,0 own",
      "126",
      56,
      false,
    )
  ];
  [@css
    (
      "._a_3i000w063y{border-block-start-width:thin;}",
      "_a_3i000w063y",
      "0,1,0 own",
      "126",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3i000g0t21{border-block-start-style:dotted;}",
      "_a_3i000g0t21",
      "0,1,0 own",
      "126",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3i0008rp61{border-block-start-color:navy;}",
      "_a_3i0008rp61",
      "0,1,0 own",
      "126",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3i0007ykf6{border-block-end:1px;}",
      "_a_3i0007ykf6",
      "0,1,0 own",
      "126",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_3i0007tfo3{border-block-end:2px dotted;}",
      "_a_3i0007tfo3",
      "0,1,0 own",
      "126",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_3i00075bci{border-block-end:medium dashed green;}",
      "_a_3i00075bci",
      "0,1,0 own",
      "126",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_3i0004luxb{border-block-end-width:thin;}",
      "_a_3i0004luxb",
      "0,1,0 own",
      "126",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_3i00025tp4{border-block-end-style:dotted;}",
      "_a_3i00025tp4",
      "0,1,0 own",
      "126",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_3i000191sb{border-block-end-color:navy;}",
      "_a_3i000191sb",
      "0,1,0 own",
      "126",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3i0009igez{border-block-color:navy blue;}",
      "_a_3i0009igez",
      "0,1,0 own",
      "126",
      9,
      false,
    )
  ];
  [@css
    (
      "._a_3m5nyj{border-inline:1px;}",
      "_a_3m5nyj",
      "0,1,0 own",
      "130",
      63,
      false,
    )
  ];
  [@css
    (
      "._a_3mu6wq{border-inline:2px dotted;}",
      "_a_3mu6wq",
      "0,1,0 own",
      "130",
      63,
      false,
    )
  ];
  [@css
    (
      "._a_3mcjw6{border-inline:medium dashed green;}",
      "_a_3mcjw6",
      "0,1,0 own",
      "130",
      63,
      false,
    )
  ];
  [@css
    (
      "._a_3m001k7swf{border-inline-start:1px;}",
      "_a_3m001k7swf",
      "0,1,0 own",
      "130",
      56,
      false,
    )
  ];
  [@css
    (
      "._a_3m001kir0r{border-inline-start:2px dotted;}",
      "_a_3m001kir0r",
      "0,1,0 own",
      "130",
      56,
      false,
    )
  ];
  [@css
    (
      "._a_3m001kssw1{border-inline-start:medium dashed green;}",
      "_a_3m001kssw1",
      "0,1,0 own",
      "130",
      56,
      false,
    )
  ];
  [@css
    (
      "._a_3m000woy43{border-inline-start-width:thin;}",
      "_a_3m000woy43",
      "0,1,0 own",
      "130",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3m000gisyu{border-inline-start-style:dotted;}",
      "_a_3m000gisyu",
      "0,1,0 own",
      "130",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3m0008n7fh{border-inline-start-color:navy;}",
      "_a_3m0008n7fh",
      "0,1,0 own",
      "130",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3m000775e7{border-inline-end:1px;}",
      "_a_3m000775e7",
      "0,1,0 own",
      "130",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_3m00077gxt{border-inline-end:2px dotted;}",
      "_a_3m00077gxt",
      "0,1,0 own",
      "130",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_3m0007sdaw{border-inline-end:medium dashed green;}",
      "_a_3m0007sdaw",
      "0,1,0 own",
      "130",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_3m0004oizn{border-inline-end-width:thin;}",
      "_a_3m0004oizn",
      "0,1,0 own",
      "130",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_3m0002859h{border-inline-end-style:dotted;}",
      "_a_3m0002859h",
      "0,1,0 own",
      "130",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_3m0001xfh4{border-inline-end-color:navy;}",
      "_a_3m0001xfh4",
      "0,1,0 own",
      "130",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3m0009bizc{border-inline-color:navy blue;}",
      "_a_3m0009bizc",
      "0,1,0 own",
      "130",
      9,
      false,
    )
  ];
  [@css
    (
      "._a_3qbrnc{border-start-start-radius:0;}",
      "_a_3qbrnc",
      "0,1,0 own",
      "134",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3qmh0y{border-start-start-radius:50%;}",
      "_a_3qmh0y",
      "0,1,0 own",
      "134",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3q1n85{border-start-start-radius:250px 100px;}",
      "_a_3q1n85",
      "0,1,0 own",
      "134",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3pm2f9{border-start-end-radius:0;}",
      "_a_3pm2f9",
      "0,1,0 own",
      "133",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3p9q25{border-start-end-radius:50%;}",
      "_a_3p9q25",
      "0,1,0 own",
      "133",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3phy3x{border-start-end-radius:250px 100px;}",
      "_a_3phy3x",
      "0,1,0 own",
      "133",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3l66ea{border-end-start-radius:0;}",
      "_a_3l66ea",
      "0,1,0 own",
      "129",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3lewnt{border-end-start-radius:50%;}",
      "_a_3lewnt",
      "0,1,0 own",
      "129",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3l2la2{border-end-start-radius:250px 100px;}",
      "_a_3l2la2",
      "0,1,0 own",
      "129",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3k720n{border-end-end-radius:0;}",
      "_a_3k720n",
      "0,1,0 own",
      "128",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3k9gs1{border-end-end-radius:50%;}",
      "_a_3k9gs1",
      "0,1,0 own",
      "128",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3kdnac{border-end-end-radius:250px 100px;}",
      "_a_3kdnac",
      "0,1,0 own",
      "128",
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
      (61, "", [57]),
      (62, "", [58]),
      (63, "", [59]),
      (64, "", [60]),
      (65, "", [61]),
      (66, "", [62]),
      (67, "", [63]),
      (68, "", [64]),
      (69, "", [65]),
      (70, "", [66]),
      (71, "", [67]),
      (72, "", [68]),
      (73, "", [69]),
      (74, "", [70]),
      (75, "", [71]),
      (76, "", [72]),
      (79, "", [73]),
      (80, "", [74]),
      (81, "", [75]),
      (82, "", [76]),
      (83, "", [77]),
      (84, "", [78]),
      (85, "", [79]),
      (86, "", [80]),
      (87, "", [81]),
      (88, "", [82]),
      (89, "", [83]),
      (90, "", [84]),
      (91, "", [85]),
    ]
  ];
  
  CSS.make("_a_45900h", []);
  CSS.make("_a_45oysp", []);
  CSS.make("_a_621xtx", []);
  CSS.make("_a_62h57g", []);
  CSS.make("_a_4a4ozg", []);
  CSS.make("_a_4aii6p", []);
  CSS.make("_a_9ypnzc", []);
  CSS.make("_a_9yxrmj", []);
  CSS.make("_a_3gn5n9", []);
  CSS.make("_a_70fzex", []);
  CSS.make("_a_89r9v3", []);
  CSS.make("_a_8b5b66", []);
  CSS.make("_a_84htmj", []);
  CSS.make("_a_863dki", []);
  CSS.make("_a_7qvqzj", []);
  CSS.make("_a_7qwkom", []);
  CSS.make("_a_7q0002ulqf", []);
  CSS.make("_a_7q0001g6i4", []);
  CSS.make("_a_7rwfix", []);
  CSS.make("_a_7rtclh", []);
  CSS.make("_a_7r0002bip2", []);
  CSS.make("_a_7r0001lgiv", []);
  CSS.make("_a_712r9d", []);
  CSS.make("_a_71sk63", []);
  CSS.make("_a_71kvre", []);
  CSS.make("_a_716yfv", []);
  CSS.make("_a_73tim3", []);
  CSS.make("_a_731rg2", []);
  CSS.make("_a_730002p0xv", []);
  CSS.make("_a_730001aygd", []);
  CSS.make("_a_74qbqh", []);
  CSS.make("_a_74ws42", []);
  CSS.make("_a_740002ffa3", []);
  CSS.make("_a_74000183h9", []);
  CSS.make("_a_95jrvu", []);
  CSS.make("_a_953v6v", []);
  CSS.make("_a_950002gdwe", []);
  CSS.make("_a_950001otoy", []);
  CSS.make("_a_962b2w", []);
  CSS.make("_a_969f8q", []);
  CSS.make("_a_960002js84", []);
  CSS.make("_a_960001ob79", []);
  CSS.make("_a_3ijynl", []);
  CSS.make("_a_3ig7ep", []);
  CSS.make("_a_3i5w5p", []);
  CSS.make("_a_3i001kby03", []);
  CSS.make("_a_3i001kza2k", []);
  CSS.make("_a_3i001khz8c", []);
  CSS.make("_a_3i000w063y", []);
  CSS.make("_a_3i000g0t21", []);
  CSS.make("_a_3i0008rp61", []);
  CSS.make("_a_3i0007ykf6", []);
  CSS.make("_a_3i0007tfo3", []);
  CSS.make("_a_3i00075bci", []);
  CSS.make("_a_3i0004luxb", []);
  CSS.make("_a_3i00025tp4", []);
  CSS.make("_a_3i000191sb", []);
  
  CSS.make("_a_3i0009igez", []);
  CSS.make("_a_3m5nyj", []);
  CSS.make("_a_3mu6wq", []);
  CSS.make("_a_3mcjw6", []);
  CSS.make("_a_3m001k7swf", []);
  CSS.make("_a_3m001kir0r", []);
  CSS.make("_a_3m001kssw1", []);
  CSS.make("_a_3m000woy43", []);
  CSS.make("_a_3m000gisyu", []);
  CSS.make("_a_3m0008n7fh", []);
  CSS.make("_a_3m000775e7", []);
  CSS.make("_a_3m00077gxt", []);
  CSS.make("_a_3m0007sdaw", []);
  CSS.make("_a_3m0004oizn", []);
  CSS.make("_a_3m0002859h", []);
  CSS.make("_a_3m0001xfh4", []);
  
  CSS.make("_a_3m0009bizc", []);
  CSS.make("_a_3qbrnc", []);
  CSS.make("_a_3qmh0y", []);
  CSS.make("_a_3q1n85", []);
  CSS.make("_a_3pm2f9", []);
  CSS.make("_a_3p9q25", []);
  CSS.make("_a_3phy3x", []);
  CSS.make("_a_3l66ea", []);
  CSS.make("_a_3lewnt", []);
  CSS.make("_a_3l2la2", []);
  CSS.make("_a_3k720n", []);
  CSS.make("_a_3k9gs1", []);
  CSS.make("_a_3kdnac", []);
