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
  [@css ".a-45900h{caption-side:inline-start;}"];
  [@css ".a-45oysp{caption-side:inline-end;}"];
  [@css ".a-621xtx{float:inline-start;}"];
  [@css ".a-62h57g{float:inline-end;}"];
  [@css ".a-4a4ozg{clear:inline-start;}"];
  [@css ".a-4aii6p{clear:inline-end;}"];
  [@css ".a-9ypnzc{resize:block;}"];
  [@css ".a-9yxrmj{resize:inline;}"];
  [@css ".a-3gn5n9{block-size:100px;}"];
  [@css ".a-70fzex{inline-size:100px;}"];
  [@css ".a-89r9v3{min-block-size:100px;}"];
  [@css ".a-8b5b66{min-inline-size:100px;}"];
  [@css ".a-84htmj{max-block-size:100px;}"];
  [@css ".a-863dki{max-inline-size:100px;}"];
  [@css ".a-7qvqzj{margin-block:10px;}"];
  [@css ".a-7qwkom{margin-block:10px 10px;}"];
  [@css ".a-7q002ulqf{margin-block-start:10px;}"];
  [@css ".a-7q001g6i4{margin-block-end:10px;}"];
  [@css ".a-7rwfix{margin-inline:10px;}"];
  [@css ".a-7rtclh{margin-inline:10px 10px;}"];
  [@css
    ".a-7r002bip2{-webkit-margin-inline-start:10px;margin-inline-start:10px;}"
  ];
  [@css ".a-7r001lgiv{-webkit-margin-inline-end:10px;margin-inline-end:10px;}"];
  [@css ".a-712r9d{inset:10px;}"];
  [@css ".a-71sk63{inset:10px 10px;}"];
  [@css ".a-71kvre{inset:10px 10px 10px;}"];
  [@css ".a-716yfv{inset:10px 10px 10px 10px;}"];
  [@css ".a-73tim3{inset-block:10px;}"];
  [@css ".a-731rg2{inset-block:10px 10px;}"];
  [@css ".a-73002p0xv{inset-block-start:10px;}"];
  [@css ".a-73001aygd{inset-block-end:10px;}"];
  [@css ".a-74qbqh{inset-inline:10px;}"];
  [@css ".a-74ws42{inset-inline:10px 10px;}"];
  [@css ".a-74002ffa3{inset-inline-start:10px;}"];
  [@css ".a-7400183h9{inset-inline-end:10px;}"];
  [@css ".a-95jrvu{padding-block:10px;}"];
  [@css ".a-953v6v{padding-block:10px 10px;}"];
  [@css ".a-95002gdwe{padding-block-start:10px;}"];
  [@css ".a-95001otoy{padding-block-end:10px;}"];
  [@css ".a-962b2w{padding-inline:10px;}"];
  [@css ".a-969f8q{padding-inline:10px 10px;}"];
  [@css
    ".a-96002js84{-webkit-padding-inline-start:10px;padding-inline-start:10px;}"
  ];
  [@css
    ".a-96001ob79{-webkit-padding-inline-end:10px;padding-inline-end:10px;}"
  ];
  [@css ".a-3ijynl{border-block:1px;}"];
  [@css ".a-3ig7ep{border-block:2px dotted;}"];
  [@css ".a-3i5w5p{border-block:medium dashed green;}"];
  [@css ".a-3i01kby03{border-block-start:1px;}"];
  [@css ".a-3i01kza2k{border-block-start:2px dotted;}"];
  [@css ".a-3i01khz8c{border-block-start:medium dashed green;}"];
  [@css ".a-3i00w063y{border-block-start-width:thin;}"];
  [@css ".a-3i00g0t21{border-block-start-style:dotted;}"];
  [@css ".a-3i008rp61{border-block-start-color:navy;}"];
  [@css ".a-3i007ykf6{border-block-end:1px;}"];
  [@css ".a-3i007tfo3{border-block-end:2px dotted;}"];
  [@css ".a-3i0075bci{border-block-end:medium dashed green;}"];
  [@css ".a-3i004luxb{border-block-end-width:thin;}"];
  [@css ".a-3i0025tp4{border-block-end-style:dotted;}"];
  [@css ".a-3i00191sb{border-block-end-color:navy;}"];
  [@css ".a-3i009igez{border-block-color:navy blue;}"];
  [@css ".a-3m5nyj{border-inline:1px;}"];
  [@css ".a-3mu6wq{border-inline:2px dotted;}"];
  [@css ".a-3mcjw6{border-inline:medium dashed green;}"];
  [@css ".a-3m01k7swf{border-inline-start:1px;}"];
  [@css ".a-3m01kir0r{border-inline-start:2px dotted;}"];
  [@css ".a-3m01kssw1{border-inline-start:medium dashed green;}"];
  [@css ".a-3m00woy43{border-inline-start-width:thin;}"];
  [@css ".a-3m00gisyu{border-inline-start-style:dotted;}"];
  [@css ".a-3m008n7fh{border-inline-start-color:navy;}"];
  [@css ".a-3m00775e7{border-inline-end:1px;}"];
  [@css ".a-3m0077gxt{border-inline-end:2px dotted;}"];
  [@css ".a-3m007sdaw{border-inline-end:medium dashed green;}"];
  [@css ".a-3m004oizn{border-inline-end-width:thin;}"];
  [@css ".a-3m002859h{border-inline-end-style:dotted;}"];
  [@css ".a-3m001xfh4{border-inline-end-color:navy;}"];
  [@css ".a-3m009bizc{border-inline-color:navy blue;}"];
  [@css ".a-3qbrnc{border-start-start-radius:0;}"];
  [@css ".a-3qmh0y{border-start-start-radius:50%;}"];
  [@css ".a-3q1n85{border-start-start-radius:250px 100px;}"];
  [@css ".a-3pm2f9{border-start-end-radius:0;}"];
  [@css ".a-3p9q25{border-start-end-radius:50%;}"];
  [@css ".a-3phy3x{border-start-end-radius:250px 100px;}"];
  [@css ".a-3l66ea{border-end-start-radius:0;}"];
  [@css ".a-3lewnt{border-end-start-radius:50%;}"];
  [@css ".a-3l2la2{border-end-start-radius:250px 100px;}"];
  [@css ".a-3k720n{border-end-end-radius:0;}"];
  [@css ".a-3k9gs1{border-end-end-radius:50%;}"];
  [@css ".a-3kdnac{border-end-end-radius:250px 100px;}"];
  
  CSS.make("a-45900h", []);
  CSS.make("a-45oysp", []);
  CSS.make("a-621xtx", []);
  CSS.make("a-62h57g", []);
  CSS.make("a-4a4ozg", []);
  CSS.make("a-4aii6p", []);
  CSS.make("a-9ypnzc", []);
  CSS.make("a-9yxrmj", []);
  CSS.make("a-3gn5n9", []);
  CSS.make("a-70fzex", []);
  CSS.make("a-89r9v3", []);
  CSS.make("a-8b5b66", []);
  CSS.make("a-84htmj", []);
  CSS.make("a-863dki", []);
  CSS.make("a-7qvqzj", []);
  CSS.make("a-7qwkom", []);
  CSS.make("a-7q002ulqf", []);
  CSS.make("a-7q001g6i4", []);
  CSS.make("a-7rwfix", []);
  CSS.make("a-7rtclh", []);
  CSS.make("a-7r002bip2", []);
  CSS.make("a-7r001lgiv", []);
  CSS.make("a-712r9d", []);
  CSS.make("a-71sk63", []);
  CSS.make("a-71kvre", []);
  CSS.make("a-716yfv", []);
  CSS.make("a-73tim3", []);
  CSS.make("a-731rg2", []);
  CSS.make("a-73002p0xv", []);
  CSS.make("a-73001aygd", []);
  CSS.make("a-74qbqh", []);
  CSS.make("a-74ws42", []);
  CSS.make("a-74002ffa3", []);
  CSS.make("a-7400183h9", []);
  CSS.make("a-95jrvu", []);
  CSS.make("a-953v6v", []);
  CSS.make("a-95002gdwe", []);
  CSS.make("a-95001otoy", []);
  CSS.make("a-962b2w", []);
  CSS.make("a-969f8q", []);
  CSS.make("a-96002js84", []);
  CSS.make("a-96001ob79", []);
  CSS.make("a-3ijynl", []);
  CSS.make("a-3ig7ep", []);
  CSS.make("a-3i5w5p", []);
  CSS.make("a-3i01kby03", []);
  CSS.make("a-3i01kza2k", []);
  CSS.make("a-3i01khz8c", []);
  CSS.make("a-3i00w063y", []);
  CSS.make("a-3i00g0t21", []);
  CSS.make("a-3i008rp61", []);
  CSS.make("a-3i007ykf6", []);
  CSS.make("a-3i007tfo3", []);
  CSS.make("a-3i0075bci", []);
  CSS.make("a-3i004luxb", []);
  CSS.make("a-3i0025tp4", []);
  CSS.make("a-3i00191sb", []);
  
  CSS.make("a-3i009igez", []);
  CSS.make("a-3m5nyj", []);
  CSS.make("a-3mu6wq", []);
  CSS.make("a-3mcjw6", []);
  CSS.make("a-3m01k7swf", []);
  CSS.make("a-3m01kir0r", []);
  CSS.make("a-3m01kssw1", []);
  CSS.make("a-3m00woy43", []);
  CSS.make("a-3m00gisyu", []);
  CSS.make("a-3m008n7fh", []);
  CSS.make("a-3m00775e7", []);
  CSS.make("a-3m0077gxt", []);
  CSS.make("a-3m007sdaw", []);
  CSS.make("a-3m004oizn", []);
  CSS.make("a-3m002859h", []);
  CSS.make("a-3m001xfh4", []);
  
  CSS.make("a-3m009bizc", []);
  CSS.make("a-3qbrnc", []);
  CSS.make("a-3qmh0y", []);
  CSS.make("a-3q1n85", []);
  CSS.make("a-3pm2f9", []);
  CSS.make("a-3p9q25", []);
  CSS.make("a-3phy3x", []);
  CSS.make("a-3l66ea", []);
  CSS.make("a-3lewnt", []);
  CSS.make("a-3l2la2", []);
  CSS.make("a-3k720n", []);
  CSS.make("a-3k9gs1", []);
  CSS.make("a-3kdnac", []);
