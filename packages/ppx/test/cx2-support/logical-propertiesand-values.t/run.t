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
    ".css-1nf900h{caption-side:inline-start;}\n.css-p2oysp{caption-side:inline-end;}\n.css-1ij1xtx{float:inline-start;}\n.css-1yth57g{float:inline-end;}\n.css-1m94ozg{clear:inline-start;}\n.css-15iii6p{clear:inline-end;}\n.css-11ipnzc{resize:block;}\n.css-1ndxrmj{resize:inline;}\n.css-1ttn5n9{block-size:100px;}\n.css-qnfzex{inline-size:100px;}\n.css-b7r9v3{min-block-size:100px;}\n.css-iu5b66{min-inline-size:100px;}\n.css-f1htmj{max-block-size:100px;}\n.css-1tc3dki{max-inline-size:100px;}\n.css-odvqzj{margin-block:10px;}\n.css-1e1wkom{margin-block:10px 10px;}\n.css-20ulqf{margin-block-start:10px;}\n.css-114g6i4{margin-block-end:10px;}\n.css-jfwfix{margin-inline:10px;}\n.css-1c3tclh{margin-inline:10px 10px;}\n.css-14lbip2{margin-inline-start:10px;}\n.css-avlgiv{margin-inline-end:10px;}\n.css-ea2r9d{inset:10px;}\n.css-l2sk63{inset:10px 10px;}\n.css-1ukkvre{inset:10px 10px 10px;}\n.css-1n66yfv{inset:10px 10px 10px 10px;}\n.css-b3tim3{inset-block:10px;}\n.css-1751rg2{inset-block:10px 10px;}\n.css-1cop0xv{inset-block-start:10px;}\n.css-tnaygd{inset-block-end:10px;}\n.css-1qgqbqh{inset-inline:10px;}\n.css-5lws42{inset-inline:10px 10px;}\n.css-i2ffa3{inset-inline-start:10px;}\n.css-1ht83h9{inset-inline-end:10px;}\n.css-1sxjrvu{padding-block:10px;}\n.css-15u3v6v{padding-block:10px 10px;}\n.css-lvgdwe{padding-block-start:10px;}\n.css-1s9otoy{padding-block-end:10px;}\n.css-1sk2b2w{padding-inline:10px;}\n.css-13w9f8q{padding-inline:10px 10px;}\n.css-i5js84{padding-inline-start:10px;}\n.css-1kwob79{padding-inline-end:10px;}\n.css-h9jynl{border-block:1px;}\n.css-3vg7ep{border-block:2px dotted;}\n.css-1ru5w5p{border-block:medium dashed green;}\n.css-1efby03{border-block-start:1px;}\n.css-blza2k{border-block-start:2px dotted;}\n.css-1qlhz8c{border-block-start:medium dashed green;}\n.css-11r063y{border-block-start-width:thin;}\n.css-1cr0t21{border-block-start-style:dotted;}\n.css-1m8rp61{border-block-start-color:navy;}\n.css-u4ykf6{border-block-end:1px;}\n.css-k1tfo3{border-block-end:2px dotted;}\n.css-ii5bci{border-block-end:medium dashed green;}\n.css-1dyluxb{border-block-end-width:thin;}\n.css-115tp4{border-block-end-style:dotted;}\n.css-1ey91sb{border-block-end-color:navy;}\n.css-1fdigez{border-block-color:navy blue;}\n.css-1ac5nyj{border-inline:1px;}\n.css-9hu6wq{border-inline:2px dotted;}\n.css-zacjw6{border-inline:medium dashed green;}\n.css-1fl7swf{border-inline-start:1px;}\n.css-12ir0r{border-inline-start:2px dotted;}\n.css-3pssw1{border-inline-start:medium dashed green;}\n.css-1g7oy43{border-inline-start-width:thin;}\n.css-giisyu{border-inline-start-style:dotted;}\n.css-s6n7fh{border-inline-start-color:navy;}\n.css-1pn75e7{border-inline-end:1px;}\n.css-1at7gxt{border-inline-end:2px dotted;}\n.css-12ysdaw{border-inline-end:medium dashed green;}\n.css-hloizn{border-inline-end-width:thin;}\n.css-1ik859h{border-inline-end-style:dotted;}\n.css-btxfh4{border-inline-end-color:navy;}\n.css-yubizc{border-inline-color:navy blue;}\n.css-1vwbrnc{border-start-start-radius:0;}\n.css-17umh0y{border-start-start-radius:50%;}\n.css-1421n85{border-start-start-radius:250px 100px;}\n.css-17um2f9{border-start-end-radius:0;}\n.css-1ag9q25{border-start-end-radius:50%;}\n.css-1k8hy3x{border-start-end-radius:250px 100px;}\n.css-c466ea{border-end-start-radius:0;}\n.css-1vmewnt{border-end-start-radius:50%;}\n.css-10i2la2{border-end-start-radius:250px 100px;}\n.css-17b720n{border-end-end-radius:0;}\n.css-1m09gs1{border-end-end-radius:50%;}\n.css-178dnac{border-end-end-radius:250px 100px;}\n"
  ];
  
  CSS.make("css-1nf900h", []);
  CSS.make("css-p2oysp", []);
  CSS.make("css-1ij1xtx", []);
  CSS.make("css-1yth57g", []);
  CSS.make("css-1m94ozg", []);
  CSS.make("css-15iii6p", []);
  CSS.make("css-11ipnzc", []);
  CSS.make("css-1ndxrmj", []);
  CSS.make("css-1ttn5n9", []);
  CSS.make("css-qnfzex", []);
  CSS.make("css-b7r9v3", []);
  CSS.make("css-iu5b66", []);
  CSS.make("css-f1htmj", []);
  CSS.make("css-1tc3dki", []);
  CSS.make("css-odvqzj", []);
  CSS.make("css-1e1wkom", []);
  CSS.make("css-20ulqf", []);
  CSS.make("css-114g6i4", []);
  CSS.make("css-jfwfix", []);
  CSS.make("css-1c3tclh", []);
  CSS.make("css-14lbip2", []);
  CSS.make("css-avlgiv", []);
  CSS.make("css-ea2r9d", []);
  CSS.make("css-l2sk63", []);
  CSS.make("css-1ukkvre", []);
  CSS.make("css-1n66yfv", []);
  CSS.make("css-b3tim3", []);
  CSS.make("css-1751rg2", []);
  CSS.make("css-1cop0xv", []);
  CSS.make("css-tnaygd", []);
  CSS.make("css-1qgqbqh", []);
  CSS.make("css-5lws42", []);
  CSS.make("css-i2ffa3", []);
  CSS.make("css-1ht83h9", []);
  CSS.make("css-1sxjrvu", []);
  CSS.make("css-15u3v6v", []);
  CSS.make("css-lvgdwe", []);
  CSS.make("css-1s9otoy", []);
  CSS.make("css-1sk2b2w", []);
  CSS.make("css-13w9f8q", []);
  CSS.make("css-i5js84", []);
  CSS.make("css-1kwob79", []);
  CSS.make("css-h9jynl", []);
  CSS.make("css-3vg7ep", []);
  CSS.make("css-1ru5w5p", []);
  CSS.make("css-1efby03", []);
  CSS.make("css-blza2k", []);
  CSS.make("css-1qlhz8c", []);
  CSS.make("css-11r063y", []);
  CSS.make("css-1cr0t21", []);
  CSS.make("css-1m8rp61", []);
  CSS.make("css-u4ykf6", []);
  CSS.make("css-k1tfo3", []);
  CSS.make("css-ii5bci", []);
  CSS.make("css-1dyluxb", []);
  CSS.make("css-115tp4", []);
  CSS.make("css-1ey91sb", []);
  
  CSS.make("css-1fdigez", []);
  CSS.make("css-1ac5nyj", []);
  CSS.make("css-9hu6wq", []);
  CSS.make("css-zacjw6", []);
  CSS.make("css-1fl7swf", []);
  CSS.make("css-12ir0r", []);
  CSS.make("css-3pssw1", []);
  CSS.make("css-1g7oy43", []);
  CSS.make("css-giisyu", []);
  CSS.make("css-s6n7fh", []);
  CSS.make("css-1pn75e7", []);
  CSS.make("css-1at7gxt", []);
  CSS.make("css-12ysdaw", []);
  CSS.make("css-hloizn", []);
  CSS.make("css-1ik859h", []);
  CSS.make("css-btxfh4", []);
  
  CSS.make("css-yubizc", []);
  CSS.make("css-1vwbrnc", []);
  CSS.make("css-17umh0y", []);
  CSS.make("css-1421n85", []);
  CSS.make("css-17um2f9", []);
  CSS.make("css-1ag9q25", []);
  CSS.make("css-1k8hy3x", []);
  CSS.make("css-c466ea", []);
  CSS.make("css-1vmewnt", []);
  CSS.make("css-10i2la2", []);
  CSS.make("css-17b720n", []);
  CSS.make("css-1m09gs1", []);
  CSS.make("css-178dnac", []);
