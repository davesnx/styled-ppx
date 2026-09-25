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
  [@css "@property --value-lltij1{syntax:\"*\";inherits:false;}"];
  [@css "@property --area-a9otef{syntax:\"*\";inherits:false;}"];
  [@css ".a-lgj0h8{display:grid;}"];
  [@css ".a-19rux3o{display:inline-grid;}"];
  [@css ".a-1xsawez{grid-template-columns:none;}"];
  [@css ".a-mod5pp{grid-template-columns:auto;}"];
  [@css ".a-1cmnoai{grid-template-columns:100px;}"];
  [@css ".a-1ez2f7z{grid-template-columns:1fr;}"];
  [@css ".a-1ey77wr{grid-template-columns:100px 1fr auto;}"];
  [@css ".a-k831z1{grid-template-columns:repeat(2, 100px 1fr);}"];
  [@css
    ".a-cueq6h{grid-template-columns:repeat(4, 10px [col-start] 250px [col-end]) 10px;}"
  ];
  [@css
    ".a-md6931{grid-template-columns:100px 1fr max-content minmax(min-content, 1fr);}"
  ];
  [@css
    ".a-djxfq4{grid-template-columns:repeat(auto-fill, minmax(25ch, 1fr));}"
  ];
  [@css ".a-gs16i{grid-template-columns:10px [col-start] 250px [col-end];}"];
  [@css
    ".a-9kikxo{grid-template-columns:[first nav-start] 150px [main-start] 1fr [last];}"
  ];
  [@css
    ".a-6m5qjg{grid-template-columns:10px [col-start] 250px [col-end] 10px [col-start] 250px [col-end] 10px;}"
  ];
  [@css
    ".a-46x00g{grid-template-columns:[a] auto [b] minmax(min-content, 1fr) [b c d] repeat(2, [e] 40px) repeat(5, auto);}"
  ];
  [@css
    ".a-1v52g5g{grid-template-columns:200px repeat(auto-fill, 100px) 300px;}"
  ];
  [@css
    ".a-1ms9bqb{grid-template-columns:minmax(100px, max-content) repeat(auto-fill, 200px) 20%;}"
  ];
  [@css
    ".a-qduhs9{grid-template-columns:[linename1] 100px [linename2] repeat(auto-fit, [linename3 linename4] 300px) 100px;}"
  ];
  [@css
    ".a-1ykgf7e{grid-template-columns:[linename1 linename2] 100px repeat(auto-fit, [linename1] 300px) [linename3];}"
  ];
  [@css ".in-68fuud{grid-template-columns:var(--value-lltij1);}"];
  [@css ".a-1p5ongh{grid-template-rows:none;}"];
  [@css ".a-1xkhlg{grid-template-rows:auto;}"];
  [@css ".a-1w8gpmy{grid-template-rows:100px;}"];
  [@css ".a-1t6x5k1{grid-template-rows:1fr;}"];
  [@css ".a-blm4xw{grid-template-rows:100px 1fr auto;}"];
  [@css ".a-1hq639k{grid-template-rows:repeat(2, 100px 1fr);}"];
  [@css
    ".a-17zs3t3{grid-template-rows:100px 1fr max-content minmax(min-content, 1fr);}"
  ];
  [@css ".a-3ev40g{grid-template-rows:10px [row-start] 250px [row-end];}"];
  [@css
    ".a-oq5w36{grid-template-rows:[first header-start] 50px [main-start] 1fr [footer-start] 50px [last];}"
  ];
  [@css ".a-19kvbk0{grid-template-areas:none;}"];
  [@css ".a-hrjsxg{grid-template-areas:\"articles\";}"];
  [@css ".a-2debm2{grid-template-areas:\"head head\";}"];
  [@css
    ".a-iaajlc{grid-template-areas:\"head head\" \"nav main\" \"foot ....\";}"
  ];
  [@css ".a-rpk02x{grid-template:none;}"];
  [@css ".a-vvof85{grid-template:auto 1fr auto / auto 1fr;}"];
  [@css
    ".a-adqbl3{grid-template:[header-top] \"a   a   a\" [header-bottom] [main-top] \"b   b   b\" 1fr [main-bottom] / auto 1fr auto;}"
  ];
  [@css ".a-fyct2f{grid-auto-columns:auto;}"];
  [@css ".a-na788q{grid-auto-columns:1fr;}"];
  [@css ".a-3wucm7{grid-auto-columns:100px;}"];
  [@css ".a-xmrl89{grid-auto-columns:max-content;}"];
  [@css ".a-mhb58e{grid-auto-columns:minmax(min-content, 1fr);}"];
  [@css ".a-1m0p52j{grid-auto-columns:min-content max-content auto;}"];
  [@css ".a-1yyetth{grid-auto-columns:100px 150px 390px;}"];
  [@css
    ".a-qb9fyb{grid-auto-columns:100px minmax(100px, auto) 10% 0.5fr fit-content(400px);}"
  ];
  [@css ".a-3sj1cp{grid-auto-rows:auto;}"];
  [@css ".a-4m87mn{grid-auto-rows:1fr;}"];
  [@css ".a-1gcjdl6{grid-auto-rows:100px;}"];
  [@css ".a-1ewn8ka{grid-auto-rows:100px 30%;}"];
  [@css ".a-xgogvi{grid-auto-rows:100px 30% 1em;}"];
  [@css ".a-1jrlx9{grid-auto-rows:min-content;}"];
  [@css ".a-a5vdaf{grid-auto-rows:minmax(min-content, 1fr);}"];
  [@css ".a-1bw2nfb{grid-auto-rows:min-content max-content auto;}"];
  [@css
    ".a-prli5h{grid-auto-rows:100px minmax(100px, auto) 10% 0.5fr fit-content(400px);}"
  ];
  [@css ".a-1x6bia0{grid-auto-flow:row;}"];
  [@css ".a-qdmemo{grid-auto-flow:column;}"];
  [@css ".a-12rrdxo{grid-auto-flow:row dense;}"];
  [@css ".a-o8pbhg{grid-auto-flow:column dense;}"];
  [@css ".a-15smumt{grid:auto-flow 1fr / 100px;}"];
  [@css ".a-10utfa6{grid:none / auto-flow 1fr;}"];
  [@css ".a-1sawvt8{grid:auto-flow / auto 1fr;}"];
  [@css ".a-6uqmta{grid:repeat(auto-fill, 5em) / auto-flow 1fr;}"];
  [@css ".a-ibqq5h{grid:auto-flow 1fr / repeat(auto-fill, 5em);}"];
  [@css ".a-1dx5ht4{grid:\"H    H \" \"A    B \" \"F    F \" 30px / auto 1fr;}"];
  [@css ".a-23zjax{grid-row-start:auto;}"];
  [@css ".a-3bfvhq{grid-row-start:4;}"];
  [@css ".a-k44rsv{grid-row-start:C;}"];
  [@css ".a-3zn6f3{grid-row-start:C 2;}"];
  [@css ".a-1mbss9{grid-row-start:span C;}"];
  [@css ".a-12n8pbd{grid-row-start:span 1;}"];
  [@css ".a-qwrk85{grid-column-start:auto;}"];
  [@css ".a-9s6726{grid-column-start:4;}"];
  [@css ".a-1v57d9e{grid-column-start:C;}"];
  [@css ".a-1lr72n4{grid-column-start:C 2;}"];
  [@css ".a-z01anm{grid-column-start:span C;}"];
  [@css ".a-1in4khj{grid-column-start:span 1;}"];
  [@css ".a-12a2lck{grid-row-end:auto;}"];
  [@css ".a-n8owek{grid-row-end:4;}"];
  [@css ".a-nmst3l{grid-row-end:C;}"];
  [@css ".a-1a6qjrt{grid-row-end:C 2;}"];
  [@css ".a-1d0f9ww{grid-row-end:span C;}"];
  [@css ".a-1x7g46w{grid-row-end:span 1;}"];
  [@css ".a-ftor5z{grid-column-end:auto;}"];
  [@css ".a-1gs2sxp{grid-column-end:4;}"];
  [@css ".a-14jg5bp{grid-column-end:C;}"];
  [@css ".a-3m246j{grid-column-end:C 2;}"];
  [@css ".a-f91mgs{grid-column-end:span C;}"];
  [@css ".a-1c1oa7h{grid-column-end:span 1;}"];
  [@css ".a-ir1t2y{-ms-grid-column:auto;grid-column:auto;}"];
  [@css ".a-dhy4ls{-ms-grid-column:1;grid-column:1;}"];
  [@css ".a-19dz211{-ms-grid-column:-1;grid-column:-1;}"];
  [@css ".a-1qd5pn{-ms-grid-column:1 / 1;grid-column:1 / 1;}"];
  [@css ".a-180pmo8{-ms-grid-column:1 / -1;grid-column:1 / -1;}"];
  [@css ".a-1f8f0lh{-ms-grid-column:auto / auto;grid-column:auto / auto;}"];
  [@css ".a-1s94k46{-ms-grid-column:2 / span 2;grid-column:2 / span 2;}"];
  [@css ".a-1qnrhcf{-ms-grid-row:auto;grid-row:auto;}"];
  [@css ".a-y1eqmj{-ms-grid-row:1;grid-row:1;}"];
  [@css ".a-1j6msv3{-ms-grid-row:-1;grid-row:-1;}"];
  [@css ".a-bpo7kt{-ms-grid-row:1 / 1;grid-row:1 / 1;}"];
  [@css ".a-lybz7i{-ms-grid-row:1 / -1;grid-row:1 / -1;}"];
  [@css ".a-img6o0{-ms-grid-row:auto / auto;grid-row:auto / auto;}"];
  [@css ".a-g317bb{-ms-grid-row:2 / span 2;grid-row:2 / span 2;}"];
  [@css ".a-1s9x97r{grid-area:1 / 1;}"];
  [@css ".in-98twa{grid-area:var(--area-a9otef);}"];
  [@css ".a-1furmtw{grid-area:1 / span 1;}"];
  [@css ".a-aq007a{grid-area:span 1 / 10 / -1;}"];
  [@css ".a-dat3cm{grid-column-gap:0;}"];
  [@css ".a-r01ss7{grid-column-gap:1em;}"];
  [@css ".a-1r7vwck{grid-row-gap:0;}"];
  [@css ".a-6se9xb{grid-row-gap:1em;}"];
  [@css ".a-1wuqgkd{grid-gap:0 0;}"];
  [@css ".a-o0qfdq{grid-gap:0 1em;}"];
  [@css ".a-1qb22h1{grid-gap:1em;}"];
  [@css ".a-phizm2{grid-gap:1em 1em;}"];
  [@css ".a-ncl3nx{grid-template-columns:subgrid;}"];
  [@css ".a-5ektzg{grid-template-columns:subgrid [sub-a];}"];
  [@css ".a-29qjfz{grid-template-columns:subgrid [sub-a] [sub-b];}"];
  [@css ".a-44ecjn{grid-template-columns:subgrid repeat(1, [sub-a]);}"];
  [@css
    ".a-1qi17e0{grid-template-columns:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}"
  ];
  [@css
    ".a-1mh93ua{grid-template-columns:subgrid repeat(auto-fill, [sub-a] [sub-b]);}"
  ];
  [@css
    ".a-qun4kv{grid-template-columns:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g]);}"
  ];
  [@css ".a-5fdu2f{grid-template-rows:subgrid;}"];
  [@css ".a-1lryyt1{grid-template-rows:subgrid [sub-a];}"];
  [@css ".a-y4pgnt{grid-template-rows:subgrid [sub-a] [sub-b];}"];
  [@css ".a-1e39v9m{grid-template-rows:subgrid repeat(1, [sub-a]);}"];
  [@css
    ".a-86hys9{grid-template-rows:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}"
  ];
  [@css
    ".a-18ot659{grid-template-rows:subgrid repeat(auto-fill, [sub-a] [sub-b]);}"
  ];
  [@css
    ".a-xnwrvq{grid-template-rows:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g]);}"
  ];
  [@css ".a-1rjo398{grid-template-columns:masonry;}"];
  [@css ".a-1fq4vh0{grid-template-rows:masonry;}"];
  [@css ".a-p6owej{masonry-auto-flow:pack;}"];
  [@css ".a-u6wgmu{masonry-auto-flow:next;}"];
  [@css ".a-bjtv39{masonry-auto-flow:definite-first;}"];
  [@css ".a-5kn96u{masonry-auto-flow:ordered;}"];
  [@css ".a-ysl2hz{masonry-auto-flow:pack definite-first;}"];
  [@css ".a-9t7ym7{masonry-auto-flow:pack ordered;}"];
  [@css ".a-14f2buy{masonry-auto-flow:next definite-first;}"];
  [@css ".a-1rxw1v0{masonry-auto-flow:next ordered;}"];
  [@css ".a-nt4l3r{masonry-auto-flow:ordered pack;}"];
  
  CSS.make("a-lgj0h8", []);
  CSS.make("a-19rux3o", []);
  CSS.make("a-1xsawez", []);
  CSS.make("a-mod5pp", []);
  CSS.make("a-1cmnoai", []);
  CSS.make("a-1ez2f7z", []);
  CSS.make("a-1ey77wr", []);
  CSS.make("a-k831z1", []);
  CSS.make("a-cueq6h", []);
  CSS.make("a-md6931", []);
  CSS.make("a-djxfq4", []);
  CSS.make("a-gs16i", []);
  CSS.make("a-9kikxo", []);
  CSS.make("a-6m5qjg", []);
  CSS.make("a-46x00g", []);
  CSS.make("a-1v52g5g", []);
  CSS.make("a-1ms9bqb", []);
  CSS.make("a-qduhs9", []);
  
  CSS.make("a-1ykgf7e", []);
  let value =
    CSS.tracks([|
      CSS.repeatFn(
        CSS.numInt(4),
        [|
          CSS.pxFloat(10.),
          CSS.lineNames({js|[col-start]|js}),
          CSS.pxFloat(250.),
          CSS.lineNames({js|[col-end]|js}),
        |],
      ),
      CSS.pxFloat(10.),
    |]);
  CSS.make(
    "in-68fuud",
    [("--value-lltij1", CSS.Types.GridTemplateColumns.toString(value))],
  );
  CSS.make("a-1p5ongh", []);
  CSS.make("a-1xkhlg", []);
  CSS.make("a-1w8gpmy", []);
  CSS.make("a-1t6x5k1", []);
  CSS.make("a-blm4xw", []);
  CSS.make("a-1hq639k", []);
  CSS.make("a-17zs3t3", []);
  CSS.make("a-3ev40g", []);
  CSS.make("a-oq5w36", []);
  CSS.make("a-19kvbk0", []);
  CSS.make("a-hrjsxg", []);
  CSS.make("a-2debm2", []);
  CSS.make("a-iaajlc", []);
  CSS.make("a-rpk02x", []);
  CSS.make("a-vvof85", []);
  CSS.make("a-adqbl3", []);
  CSS.make("a-fyct2f", []);
  CSS.make("a-na788q", []);
  CSS.make("a-3wucm7", []);
  CSS.make("a-xmrl89", []);
  CSS.make("a-mhb58e", []);
  CSS.make("a-1m0p52j", []);
  CSS.make("a-1yyetth", []);
  CSS.make("a-qb9fyb", []);
  CSS.make("a-3sj1cp", []);
  CSS.make("a-4m87mn", []);
  CSS.make("a-1gcjdl6", []);
  CSS.make("a-1ewn8ka", []);
  CSS.make("a-xgogvi", []);
  CSS.make("a-1jrlx9", []);
  CSS.make("a-a5vdaf", []);
  CSS.make("a-1bw2nfb", []);
  CSS.make("a-prli5h", []);
  CSS.make("a-1x6bia0", []);
  CSS.make("a-qdmemo", []);
  CSS.make("a-12rrdxo", []);
  CSS.make("a-o8pbhg", []);
  CSS.make("a-15smumt", []);
  CSS.make("a-10utfa6", []);
  CSS.make("a-1sawvt8", []);
  CSS.make("a-6uqmta", []);
  CSS.make("a-ibqq5h", []);
  CSS.make("a-1dx5ht4", []);
  CSS.make("a-23zjax", []);
  CSS.make("a-3bfvhq", []);
  CSS.make("a-k44rsv", []);
  CSS.make("a-3zn6f3", []);
  CSS.make("a-1mbss9", []);
  CSS.make("a-12n8pbd", []);
  CSS.make("a-qwrk85", []);
  CSS.make("a-9s6726", []);
  CSS.make("a-1v57d9e", []);
  CSS.make("a-1lr72n4", []);
  CSS.make("a-z01anm", []);
  CSS.make("a-1in4khj", []);
  CSS.make("a-12a2lck", []);
  CSS.make("a-n8owek", []);
  CSS.make("a-nmst3l", []);
  CSS.make("a-1a6qjrt", []);
  CSS.make("a-1d0f9ww", []);
  CSS.make("a-1x7g46w", []);
  CSS.make("a-ftor5z", []);
  CSS.make("a-1gs2sxp", []);
  CSS.make("a-14jg5bp", []);
  CSS.make("a-3m246j", []);
  CSS.make("a-f91mgs", []);
  CSS.make("a-1c1oa7h", []);
  CSS.make("a-ir1t2y", []);
  CSS.make("a-dhy4ls", []);
  CSS.make("a-19dz211", []);
  CSS.make("a-1qd5pn", []);
  CSS.make("a-180pmo8", []);
  CSS.make("a-1f8f0lh", []);
  CSS.make("a-1s94k46", []);
  CSS.make("a-1qnrhcf", []);
  CSS.make("a-y1eqmj", []);
  CSS.make("a-1j6msv3", []);
  CSS.make("a-bpo7kt", []);
  CSS.make("a-lybz7i", []);
  CSS.make("a-img6o0", []);
  CSS.make("a-g317bb", []);
  CSS.make("a-1s9x97r", []);
  let area = `num(33);
  CSS.make(
    "in-98twa",
    [("--area-a9otef", CSS.Types.GridArea.toString(area))],
  );
  CSS.make("a-1furmtw", []);
  CSS.make("a-aq007a", []);
  CSS.make("a-dat3cm", []);
  CSS.make("a-r01ss7", []);
  CSS.make("a-1r7vwck", []);
  CSS.make("a-6se9xb", []);
  CSS.make("a-1wuqgkd", []);
  CSS.make("a-o0qfdq", []);
  CSS.make("a-1qb22h1", []);
  CSS.make("a-phizm2", []);
  
  CSS.make("a-ncl3nx", []);
  CSS.make("a-5ektzg", []);
  CSS.make("a-29qjfz", []);
  CSS.make("a-44ecjn", []);
  CSS.make("a-1qi17e0", []);
  CSS.make("a-1mh93ua", []);
  CSS.make("a-qun4kv", []);
  CSS.make("a-5fdu2f", []);
  CSS.make("a-1lryyt1", []);
  CSS.make("a-y4pgnt", []);
  CSS.make("a-1e39v9m", []);
  CSS.make("a-86hys9", []);
  CSS.make("a-18ot659", []);
  CSS.make("a-xnwrvq", []);
  
  CSS.make("a-1rjo398", []);
  CSS.make("a-1fq4vh0", []);
  CSS.make("a-p6owej", []);
  CSS.make("a-u6wgmu", []);
  CSS.make("a-bjtv39", []);
  CSS.make("a-5kn96u", []);
  CSS.make("a-ysl2hz", []);
  CSS.make("a-9t7ym7", []);
  CSS.make("a-14f2buy", []);
  CSS.make("a-1rxw1v0", []);
  CSS.make("a-nt4l3r", []);
