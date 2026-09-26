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
  [@css "._a_7q002ulqf{margin-block-start:10px;}"];
  [@css "._a_7q001g6i4{margin-block-end:10px;}"];
  [@css "._a_7rwfix{margin-inline:10px;}"];
  [@css "._a_7rtclh{margin-inline:10px 10px;}"];
  [@css
    "._a_7r002bip2{-webkit-margin-inline-start:10px;margin-inline-start:10px;}"
  ];
  [@css "._a_7r001lgiv{-webkit-margin-inline-end:10px;margin-inline-end:10px;}"];
  [@css "._a_712r9d{inset:10px;}"];
  [@css "._a_71sk63{inset:10px 10px;}"];
  [@css "._a_71kvre{inset:10px 10px 10px;}"];
  [@css "._a_716yfv{inset:10px 10px 10px 10px;}"];
  [@css "._a_73tim3{inset-block:10px;}"];
  [@css "._a_731rg2{inset-block:10px 10px;}"];
  [@css "._a_73002p0xv{inset-block-start:10px;}"];
  [@css "._a_73001aygd{inset-block-end:10px;}"];
  [@css "._a_74qbqh{inset-inline:10px;}"];
  [@css "._a_74ws42{inset-inline:10px 10px;}"];
  [@css "._a_74002ffa3{inset-inline-start:10px;}"];
  [@css "._a_7400183h9{inset-inline-end:10px;}"];
  [@css "._a_95jrvu{padding-block:10px;}"];
  [@css "._a_953v6v{padding-block:10px 10px;}"];
  [@css "._a_95002gdwe{padding-block-start:10px;}"];
  [@css "._a_95001otoy{padding-block-end:10px;}"];
  [@css "._a_962b2w{padding-inline:10px;}"];
  [@css "._a_969f8q{padding-inline:10px 10px;}"];
  [@css
    "._a_96002js84{-webkit-padding-inline-start:10px;padding-inline-start:10px;}"
  ];
  [@css
    "._a_96001ob79{-webkit-padding-inline-end:10px;padding-inline-end:10px;}"
  ];
  [@css "._a_3ijynl{border-block:1px;}"];
  [@css "._a_3ig7ep{border-block:2px dotted;}"];
  [@css "._a_3i5w5p{border-block:medium dashed green;}"];
  [@css "._a_3i01kby03{border-block-start:1px;}"];
  [@css "._a_3i01kza2k{border-block-start:2px dotted;}"];
  [@css "._a_3i01khz8c{border-block-start:medium dashed green;}"];
  [@css "._a_3i00w063y{border-block-start-width:thin;}"];
  [@css "._a_3i00g0t21{border-block-start-style:dotted;}"];
  [@css "._a_3i008rp61{border-block-start-color:navy;}"];
  [@css "._a_3i007ykf6{border-block-end:1px;}"];
  [@css "._a_3i007tfo3{border-block-end:2px dotted;}"];
  [@css "._a_3i0075bci{border-block-end:medium dashed green;}"];
  [@css "._a_3i004luxb{border-block-end-width:thin;}"];
  [@css "._a_3i0025tp4{border-block-end-style:dotted;}"];
  [@css "._a_3i00191sb{border-block-end-color:navy;}"];
  [@css "._a_3i009igez{border-block-color:navy blue;}"];
  [@css "._a_3m5nyj{border-inline:1px;}"];
  [@css "._a_3mu6wq{border-inline:2px dotted;}"];
  [@css "._a_3mcjw6{border-inline:medium dashed green;}"];
  [@css "._a_3m01k7swf{border-inline-start:1px;}"];
  [@css "._a_3m01kir0r{border-inline-start:2px dotted;}"];
  [@css "._a_3m01kssw1{border-inline-start:medium dashed green;}"];
  [@css "._a_3m00woy43{border-inline-start-width:thin;}"];
  [@css "._a_3m00gisyu{border-inline-start-style:dotted;}"];
  [@css "._a_3m008n7fh{border-inline-start-color:navy;}"];
  [@css "._a_3m00775e7{border-inline-end:1px;}"];
  [@css "._a_3m0077gxt{border-inline-end:2px dotted;}"];
  [@css "._a_3m007sdaw{border-inline-end:medium dashed green;}"];
  [@css "._a_3m004oizn{border-inline-end-width:thin;}"];
  [@css "._a_3m002859h{border-inline-end-style:dotted;}"];
  [@css "._a_3m001xfh4{border-inline-end-color:navy;}"];
  [@css "._a_3m009bizc{border-inline-color:navy blue;}"];
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
  CSS.make("_a_7q002ulqf", []);
  CSS.make("_a_7q001g6i4", []);
  CSS.make("_a_7rwfix", []);
  CSS.make("_a_7rtclh", []);
  CSS.make("_a_7r002bip2", []);
  CSS.make("_a_7r001lgiv", []);
  CSS.make("_a_712r9d", []);
  CSS.make("_a_71sk63", []);
  CSS.make("_a_71kvre", []);
  CSS.make("_a_716yfv", []);
  CSS.make("_a_73tim3", []);
  CSS.make("_a_731rg2", []);
  CSS.make("_a_73002p0xv", []);
  CSS.make("_a_73001aygd", []);
  CSS.make("_a_74qbqh", []);
  CSS.make("_a_74ws42", []);
  CSS.make("_a_74002ffa3", []);
  CSS.make("_a_7400183h9", []);
  CSS.make("_a_95jrvu", []);
  CSS.make("_a_953v6v", []);
  CSS.make("_a_95002gdwe", []);
  CSS.make("_a_95001otoy", []);
  CSS.make("_a_962b2w", []);
  CSS.make("_a_969f8q", []);
  CSS.make("_a_96002js84", []);
  CSS.make("_a_96001ob79", []);
  CSS.make("_a_3ijynl", []);
  CSS.make("_a_3ig7ep", []);
  CSS.make("_a_3i5w5p", []);
  CSS.make("_a_3i01kby03", []);
  CSS.make("_a_3i01kza2k", []);
  CSS.make("_a_3i01khz8c", []);
  CSS.make("_a_3i00w063y", []);
  CSS.make("_a_3i00g0t21", []);
  CSS.make("_a_3i008rp61", []);
  CSS.make("_a_3i007ykf6", []);
  CSS.make("_a_3i007tfo3", []);
  CSS.make("_a_3i0075bci", []);
  CSS.make("_a_3i004luxb", []);
  CSS.make("_a_3i0025tp4", []);
  CSS.make("_a_3i00191sb", []);
  
  CSS.make("_a_3i009igez", []);
  CSS.make("_a_3m5nyj", []);
  CSS.make("_a_3mu6wq", []);
  CSS.make("_a_3mcjw6", []);
  CSS.make("_a_3m01k7swf", []);
  CSS.make("_a_3m01kir0r", []);
  CSS.make("_a_3m01kssw1", []);
  CSS.make("_a_3m00woy43", []);
  CSS.make("_a_3m00gisyu", []);
  CSS.make("_a_3m008n7fh", []);
  CSS.make("_a_3m00775e7", []);
  CSS.make("_a_3m0077gxt", []);
  CSS.make("_a_3m007sdaw", []);
  CSS.make("_a_3m004oizn", []);
  CSS.make("_a_3m002859h", []);
  CSS.make("_a_3m001xfh4", []);
  
  CSS.make("_a_3m009bizc", []);
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
