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
  [@css "._a_45900h{caption-side:inline-start;}"];
  [@css "._a_45oysp{caption-side:inline-end;}"];
  [@css "._a_621xtx{float:inline-start;}"];
  [@css "._a_62h57g{float:inline-end;}"];
  [@css "._a_4a4ozg{clear:inline-start;}"];
  [@css "._a_4aii6p{clear:inline-end;}"];
  [@css "._a_9ypnzc{resize:block;}"];
  [@css "._a_9yxrmj{resize:inline;}"];
  [@css "._a_3gn5n9{block-size:100px;}"];
  [@css "._a_70fzex{inline-size:100px;}"];
  [@css "._a_89r9v3{min-block-size:100px;}"];
  [@css "._a_8b5b66{min-inline-size:100px;}"];
  [@css "._a_84htmj{max-block-size:100px;}"];
  [@css "._a_863dki{max-inline-size:100px;}"];
  [@css "._a_7qvqzj{margin-block:10px;}"];
  [@css "._a_7qwkom{margin-block:10px 10px;}"];
  [@css "._a_7q0002ulqf{margin-block-start:10px;}"];
  [@css "._a_7q0001g6i4{margin-block-end:10px;}"];
  [@css "._a_7rwfix{margin-inline:10px;}"];
  [@css "._a_7rtclh{margin-inline:10px 10px;}"];
  [@css "._a_7r0002bip2{-webkit-margin-start:10px;margin-inline-start:10px;}"];
  [@css "._a_7r0001lgiv{-webkit-margin-end:10px;margin-inline-end:10px;}"];
  [@css "._a_712r9d{inset:10px;}"];
  [@css "._a_71sk63{inset:10px 10px;}"];
  [@css "._a_71kvre{inset:10px 10px 10px;}"];
  [@css "._a_716yfv{inset:10px 10px 10px 10px;}"];
  [@css "._a_73tim3{inset-block:10px;}"];
  [@css "._a_731rg2{inset-block:10px 10px;}"];
  [@css "._a_730002p0xv{inset-block-start:10px;}"];
  [@css "._a_730001aygd{inset-block-end:10px;}"];
  [@css "._a_74qbqh{inset-inline:10px;}"];
  [@css "._a_74ws42{inset-inline:10px 10px;}"];
  [@css "._a_740002ffa3{inset-inline-start:10px;}"];
  [@css "._a_74000183h9{inset-inline-end:10px;}"];
  [@css "._a_95jrvu{padding-block:10px;}"];
  [@css "._a_953v6v{padding-block:10px 10px;}"];
  [@css "._a_950002gdwe{padding-block-start:10px;}"];
  [@css "._a_950001otoy{padding-block-end:10px;}"];
  [@css "._a_962b2w{padding-inline:10px;}"];
  [@css "._a_969f8q{padding-inline:10px 10px;}"];
  [@css "._a_960002js84{-webkit-padding-start:10px;padding-inline-start:10px;}"];
  [@css "._a_960001ob79{-webkit-padding-end:10px;padding-inline-end:10px;}"];
  [@css "._a_3ijynl{border-block:1px;}"];
  [@css "._a_3ig7ep{border-block:2px dotted;}"];
  [@css "._a_3i5w5p{border-block:medium dashed green;}"];
  [@css "._a_3i001kby03{border-block-start:1px;}"];
  [@css "._a_3i001kza2k{border-block-start:2px dotted;}"];
  [@css "._a_3i001khz8c{border-block-start:medium dashed green;}"];
  [@css "._a_3i000w063y{border-block-start-width:thin;}"];
  [@css "._a_3i000g0t21{border-block-start-style:dotted;}"];
  [@css "._a_3i0008rp61{border-block-start-color:navy;}"];
  [@css "._a_3i0007ykf6{border-block-end:1px;}"];
  [@css "._a_3i0007tfo3{border-block-end:2px dotted;}"];
  [@css "._a_3i00075bci{border-block-end:medium dashed green;}"];
  [@css "._a_3i0004luxb{border-block-end-width:thin;}"];
  [@css "._a_3i00025tp4{border-block-end-style:dotted;}"];
  [@css "._a_3i000191sb{border-block-end-color:navy;}"];
  [@css "._a_3i0009igez{border-block-color:navy blue;}"];
  [@css "._a_3m5nyj{border-inline:1px;}"];
  [@css "._a_3mu6wq{border-inline:2px dotted;}"];
  [@css "._a_3mcjw6{border-inline:medium dashed green;}"];
  [@css "._a_3m001k7swf{border-inline-start:1px;}"];
  [@css "._a_3m001kir0r{border-inline-start:2px dotted;}"];
  [@css "._a_3m001kssw1{border-inline-start:medium dashed green;}"];
  [@css "._a_3m000woy43{border-inline-start-width:thin;}"];
  [@css "._a_3m000gisyu{border-inline-start-style:dotted;}"];
  [@css "._a_3m0008n7fh{border-inline-start-color:navy;}"];
  [@css "._a_3m000775e7{border-inline-end:1px;}"];
  [@css "._a_3m00077gxt{border-inline-end:2px dotted;}"];
  [@css "._a_3m0007sdaw{border-inline-end:medium dashed green;}"];
  [@css "._a_3m0004oizn{border-inline-end-width:thin;}"];
  [@css "._a_3m0002859h{border-inline-end-style:dotted;}"];
  [@css "._a_3m0001xfh4{border-inline-end-color:navy;}"];
  [@css "._a_3m0009bizc{border-inline-color:navy blue;}"];
  [@css "._a_3qbrnc{border-start-start-radius:0;}"];
  [@css "._a_3qmh0y{border-start-start-radius:50%;}"];
  [@css "._a_3q1n85{border-start-start-radius:250px 100px;}"];
  [@css "._a_3pm2f9{border-start-end-radius:0;}"];
  [@css "._a_3p9q25{border-start-end-radius:50%;}"];
  [@css "._a_3phy3x{border-start-end-radius:250px 100px;}"];
  [@css "._a_3l66ea{border-end-start-radius:0;}"];
  [@css "._a_3lewnt{border-end-start-radius:50%;}"];
  [@css "._a_3l2la2{border-end-start-radius:250px 100px;}"];
  [@css "._a_3k720n{border-end-end-radius:0;}"];
  [@css "._a_3k9gs1{border-end-end-radius:50%;}"];
  [@css "._a_3kdnac{border-end-end-radius:250px 100px;}"];
  [@css.blocks
    [
      (2, "_a_45900h"),
      (3, "_a_45oysp"),
      (4, "_a_621xtx"),
      (5, "_a_62h57g"),
      (6, "_a_4a4ozg"),
      (7, "_a_4aii6p"),
      (8, "_a_9ypnzc"),
      (9, "_a_9yxrmj"),
      (10, "_a_3gn5n9"),
      (11, "_a_70fzex"),
      (12, "_a_89r9v3"),
      (13, "_a_8b5b66"),
      (14, "_a_84htmj"),
      (15, "_a_863dki"),
      (16, "_a_7qvqzj"),
      (17, "_a_7qwkom"),
      (18, "_a_7q0002ulqf"),
      (19, "_a_7q0001g6i4"),
      (20, "_a_7rwfix"),
      (21, "_a_7rtclh"),
      (22, "_a_7r0002bip2"),
      (23, "_a_7r0001lgiv"),
      (24, "_a_712r9d"),
      (25, "_a_71sk63"),
      (26, "_a_71kvre"),
      (27, "_a_716yfv"),
      (28, "_a_73tim3"),
      (29, "_a_731rg2"),
      (30, "_a_730002p0xv"),
      (31, "_a_730001aygd"),
      (32, "_a_74qbqh"),
      (33, "_a_74ws42"),
      (34, "_a_740002ffa3"),
      (35, "_a_74000183h9"),
      (36, "_a_95jrvu"),
      (37, "_a_953v6v"),
      (38, "_a_950002gdwe"),
      (39, "_a_950001otoy"),
      (40, "_a_962b2w"),
      (41, "_a_969f8q"),
      (42, "_a_960002js84"),
      (43, "_a_960001ob79"),
      (44, "_a_3ijynl"),
      (45, "_a_3ig7ep"),
      (46, "_a_3i5w5p"),
      (47, "_a_3i001kby03"),
      (48, "_a_3i001kza2k"),
      (49, "_a_3i001khz8c"),
      (50, "_a_3i000w063y"),
      (51, "_a_3i000g0t21"),
      (52, "_a_3i0008rp61"),
      (53, "_a_3i0007ykf6"),
      (54, "_a_3i0007tfo3"),
      (55, "_a_3i00075bci"),
      (56, "_a_3i0004luxb"),
      (57, "_a_3i00025tp4"),
      (58, "_a_3i000191sb"),
      (61, "_a_3i0009igez"),
      (62, "_a_3m5nyj"),
      (63, "_a_3mu6wq"),
      (64, "_a_3mcjw6"),
      (65, "_a_3m001k7swf"),
      (66, "_a_3m001kir0r"),
      (67, "_a_3m001kssw1"),
      (68, "_a_3m000woy43"),
      (69, "_a_3m000gisyu"),
      (70, "_a_3m0008n7fh"),
      (71, "_a_3m000775e7"),
      (72, "_a_3m00077gxt"),
      (73, "_a_3m0007sdaw"),
      (74, "_a_3m0004oizn"),
      (75, "_a_3m0002859h"),
      (76, "_a_3m0001xfh4"),
      (79, "_a_3m0009bizc"),
      (80, "_a_3qbrnc"),
      (81, "_a_3qmh0y"),
      (82, "_a_3q1n85"),
      (83, "_a_3pm2f9"),
      (84, "_a_3p9q25"),
      (85, "_a_3phy3x"),
      (86, "_a_3l66ea"),
      (87, "_a_3lewnt"),
      (88, "_a_3l2la2"),
      (89, "_a_3k720n"),
      (90, "_a_3k9gs1"),
      (91, "_a_3kdnac"),
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
