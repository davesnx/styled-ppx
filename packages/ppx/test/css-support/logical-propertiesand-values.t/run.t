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
  [@css ".a-1nf900h{caption-side:inline-start;}"];
  [@css ".a-p2oysp{caption-side:inline-end;}"];
  [@css ".a-1ij1xtx{float:inline-start;}"];
  [@css ".a-1yth57g{float:inline-end;}"];
  [@css ".a-1m94ozg{clear:inline-start;}"];
  [@css ".a-15iii6p{clear:inline-end;}"];
  [@css ".a-11ipnzc{resize:block;}"];
  [@css ".a-1ndxrmj{resize:inline;}"];
  [@css ".a-1ttn5n9{block-size:100px;}"];
  [@css ".a-qnfzex{inline-size:100px;}"];
  [@css ".a-b7r9v3{min-block-size:100px;}"];
  [@css ".a-iu5b66{min-inline-size:100px;}"];
  [@css ".a-f1htmj{max-block-size:100px;}"];
  [@css ".a-1tc3dki{max-inline-size:100px;}"];
  [@css ".a-odvqzj{margin-block:10px;}"];
  [@css ".a-1e1wkom{margin-block:10px 10px;}"];
  [@css ".a-20ulqf{margin-block-start:10px;}"];
  [@css ".a-114g6i4{margin-block-end:10px;}"];
  [@css ".a-jfwfix{margin-inline:10px;}"];
  [@css ".a-1c3tclh{margin-inline:10px 10px;}"];
  [@css
    ".a-14lbip2{-webkit-margin-inline-start:10px;margin-inline-start:10px;}"
  ];
  [@css ".a-avlgiv{-webkit-margin-inline-end:10px;margin-inline-end:10px;}"];
  [@css ".a-ea2r9d{inset:10px;}"];
  [@css ".a-l2sk63{inset:10px 10px;}"];
  [@css ".a-1ukkvre{inset:10px 10px 10px;}"];
  [@css ".a-1n66yfv{inset:10px 10px 10px 10px;}"];
  [@css ".a-b3tim3{inset-block:10px;}"];
  [@css ".a-1751rg2{inset-block:10px 10px;}"];
  [@css ".a-1cop0xv{inset-block-start:10px;}"];
  [@css ".a-tnaygd{inset-block-end:10px;}"];
  [@css ".a-1qgqbqh{inset-inline:10px;}"];
  [@css ".a-5lws42{inset-inline:10px 10px;}"];
  [@css ".a-i2ffa3{inset-inline-start:10px;}"];
  [@css ".a-1ht83h9{inset-inline-end:10px;}"];
  [@css ".a-1sxjrvu{padding-block:10px;}"];
  [@css ".a-15u3v6v{padding-block:10px 10px;}"];
  [@css ".a-lvgdwe{padding-block-start:10px;}"];
  [@css ".a-1s9otoy{padding-block-end:10px;}"];
  [@css ".a-1sk2b2w{padding-inline:10px;}"];
  [@css ".a-13w9f8q{padding-inline:10px 10px;}"];
  [@css
    ".a-i5js84{-webkit-padding-inline-start:10px;padding-inline-start:10px;}"
  ];
  [@css ".a-1kwob79{-webkit-padding-inline-end:10px;padding-inline-end:10px;}"];
  [@css ".a-h9jynl{border-block:1px;}"];
  [@css ".a-3vg7ep{border-block:2px dotted;}"];
  [@css ".a-1ru5w5p{border-block:medium dashed green;}"];
  [@css ".a-1efby03{border-block-start:1px;}"];
  [@css ".a-blza2k{border-block-start:2px dotted;}"];
  [@css ".a-1qlhz8c{border-block-start:medium dashed green;}"];
  [@css ".a-11r063y{border-block-start-width:thin;}"];
  [@css ".a-1cr0t21{border-block-start-style:dotted;}"];
  [@css ".a-1m8rp61{border-block-start-color:navy;}"];
  [@css ".a-u4ykf6{border-block-end:1px;}"];
  [@css ".a-k1tfo3{border-block-end:2px dotted;}"];
  [@css ".a-ii5bci{border-block-end:medium dashed green;}"];
  [@css ".a-1dyluxb{border-block-end-width:thin;}"];
  [@css ".a-115tp4{border-block-end-style:dotted;}"];
  [@css ".a-1ey91sb{border-block-end-color:navy;}"];
  [@css ".a-1fdigez{border-block-color:navy blue;}"];
  [@css ".a-1ac5nyj{border-inline:1px;}"];
  [@css ".a-9hu6wq{border-inline:2px dotted;}"];
  [@css ".a-zacjw6{border-inline:medium dashed green;}"];
  [@css ".a-1fl7swf{border-inline-start:1px;}"];
  [@css ".a-12ir0r{border-inline-start:2px dotted;}"];
  [@css ".a-3pssw1{border-inline-start:medium dashed green;}"];
  [@css ".a-1g7oy43{border-inline-start-width:thin;}"];
  [@css ".a-giisyu{border-inline-start-style:dotted;}"];
  [@css ".a-s6n7fh{border-inline-start-color:navy;}"];
  [@css ".a-1pn75e7{border-inline-end:1px;}"];
  [@css ".a-1at7gxt{border-inline-end:2px dotted;}"];
  [@css ".a-12ysdaw{border-inline-end:medium dashed green;}"];
  [@css ".a-hloizn{border-inline-end-width:thin;}"];
  [@css ".a-1ik859h{border-inline-end-style:dotted;}"];
  [@css ".a-btxfh4{border-inline-end-color:navy;}"];
  [@css ".a-yubizc{border-inline-color:navy blue;}"];
  [@css ".a-1vwbrnc{border-start-start-radius:0;}"];
  [@css ".a-17umh0y{border-start-start-radius:50%;}"];
  [@css ".a-1421n85{border-start-start-radius:250px 100px;}"];
  [@css ".a-17um2f9{border-start-end-radius:0;}"];
  [@css ".a-1ag9q25{border-start-end-radius:50%;}"];
  [@css ".a-1k8hy3x{border-start-end-radius:250px 100px;}"];
  [@css ".a-c466ea{border-end-start-radius:0;}"];
  [@css ".a-1vmewnt{border-end-start-radius:50%;}"];
  [@css ".a-10i2la2{border-end-start-radius:250px 100px;}"];
  [@css ".a-17b720n{border-end-end-radius:0;}"];
  [@css ".a-1m09gs1{border-end-end-radius:50%;}"];
  [@css ".a-178dnac{border-end-end-radius:250px 100px;}"];
  
  CSS.make("a-1nf900h", []);
  CSS.make("a-p2oysp", []);
  CSS.make("a-1ij1xtx", []);
  CSS.make("a-1yth57g", []);
  CSS.make("a-1m94ozg", []);
  CSS.make("a-15iii6p", []);
  CSS.make("a-11ipnzc", []);
  CSS.make("a-1ndxrmj", []);
  CSS.make("a-1ttn5n9", []);
  CSS.make("a-qnfzex", []);
  CSS.make("a-b7r9v3", []);
  CSS.make("a-iu5b66", []);
  CSS.make("a-f1htmj", []);
  CSS.make("a-1tc3dki", []);
  CSS.make("a-odvqzj", []);
  CSS.make("a-1e1wkom", []);
  CSS.make("a-20ulqf", []);
  CSS.make("a-114g6i4", []);
  CSS.make("a-jfwfix", []);
  CSS.make("a-1c3tclh", []);
  CSS.make("a-14lbip2", []);
  CSS.make("a-avlgiv", []);
  CSS.make("a-ea2r9d", []);
  CSS.make("a-l2sk63", []);
  CSS.make("a-1ukkvre", []);
  CSS.make("a-1n66yfv", []);
  CSS.make("a-b3tim3", []);
  CSS.make("a-1751rg2", []);
  CSS.make("a-1cop0xv", []);
  CSS.make("a-tnaygd", []);
  CSS.make("a-1qgqbqh", []);
  CSS.make("a-5lws42", []);
  CSS.make("a-i2ffa3", []);
  CSS.make("a-1ht83h9", []);
  CSS.make("a-1sxjrvu", []);
  CSS.make("a-15u3v6v", []);
  CSS.make("a-lvgdwe", []);
  CSS.make("a-1s9otoy", []);
  CSS.make("a-1sk2b2w", []);
  CSS.make("a-13w9f8q", []);
  CSS.make("a-i5js84", []);
  CSS.make("a-1kwob79", []);
  CSS.make("a-h9jynl", []);
  CSS.make("a-3vg7ep", []);
  CSS.make("a-1ru5w5p", []);
  CSS.make("a-1efby03", []);
  CSS.make("a-blza2k", []);
  CSS.make("a-1qlhz8c", []);
  CSS.make("a-11r063y", []);
  CSS.make("a-1cr0t21", []);
  CSS.make("a-1m8rp61", []);
  CSS.make("a-u4ykf6", []);
  CSS.make("a-k1tfo3", []);
  CSS.make("a-ii5bci", []);
  CSS.make("a-1dyluxb", []);
  CSS.make("a-115tp4", []);
  CSS.make("a-1ey91sb", []);
  
  CSS.make("a-1fdigez", []);
  CSS.make("a-1ac5nyj", []);
  CSS.make("a-9hu6wq", []);
  CSS.make("a-zacjw6", []);
  CSS.make("a-1fl7swf", []);
  CSS.make("a-12ir0r", []);
  CSS.make("a-3pssw1", []);
  CSS.make("a-1g7oy43", []);
  CSS.make("a-giisyu", []);
  CSS.make("a-s6n7fh", []);
  CSS.make("a-1pn75e7", []);
  CSS.make("a-1at7gxt", []);
  CSS.make("a-12ysdaw", []);
  CSS.make("a-hloizn", []);
  CSS.make("a-1ik859h", []);
  CSS.make("a-btxfh4", []);
  
  CSS.make("a-yubizc", []);
  CSS.make("a-1vwbrnc", []);
  CSS.make("a-17umh0y", []);
  CSS.make("a-1421n85", []);
  CSS.make("a-17um2f9", []);
  CSS.make("a-1ag9q25", []);
  CSS.make("a-1k8hy3x", []);
  CSS.make("a-c466ea", []);
  CSS.make("a-1vmewnt", []);
  CSS.make("a-10i2la2", []);
  CSS.make("a-17b720n", []);
  CSS.make("a-1m09gs1", []);
  CSS.make("a-178dnac", []);
