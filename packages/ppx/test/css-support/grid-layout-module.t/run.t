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
  [@css ".a-5rj0h8{display:grid;}"];
  [@css ".a-5rux3o{display:inline-grid;}"];
  [@css ".a-6i00gawez{grid-template-columns:none;}"];
  [@css ".a-6i00gd5pp{grid-template-columns:auto;}"];
  [@css ".a-6i00gnoai{grid-template-columns:100px;}"];
  [@css ".a-6i00g2f7z{grid-template-columns:1fr;}"];
  [@css ".a-6i00g77wr{grid-template-columns:100px 1fr auto;}"];
  [@css ".a-6i00g31z1{grid-template-columns:repeat(2, 100px 1fr);}"];
  [@css
    ".a-6i00geq6h{grid-template-columns:repeat(4, 10px [col-start] 250px [col-end]) 10px;}"
  ];
  [@css
    ".a-6i00g6931{grid-template-columns:100px 1fr max-content minmax(min-content, 1fr);}"
  ];
  [@css
    ".a-6i00gxfq4{grid-template-columns:repeat(auto-fill, minmax(25ch, 1fr));}"
  ];
  [@css ".a-6i00gs16i{grid-template-columns:10px [col-start] 250px [col-end];}"];
  [@css
    ".a-6i00gikxo{grid-template-columns:[first nav-start] 150px [main-start] 1fr [last];}"
  ];
  [@css
    ".a-6i00g5qjg{grid-template-columns:10px [col-start] 250px [col-end] 10px [col-start] 250px [col-end] 10px;}"
  ];
  [@css
    ".a-6i00gx00g{grid-template-columns:[a] auto [b] minmax(min-content, 1fr) [b c d] repeat(2, [e] 40px) repeat(5, auto);}"
  ];
  [@css
    ".a-6i00g2g5g{grid-template-columns:200px repeat(auto-fill, 100px) 300px;}"
  ];
  [@css
    ".a-6i00g9bqb{grid-template-columns:minmax(100px, max-content) repeat(auto-fill, 200px) 20%;}"
  ];
  [@css
    ".a-6i00guhs9{grid-template-columns:[linename1] 100px [linename2] repeat(auto-fit, [linename3 linename4] 300px) 100px;}"
  ];
  [@css
    ".a-6i00ggf7e{grid-template-columns:[linename1 linename2] 100px repeat(auto-fit, [linename1] 300px) [linename3];}"
  ];
  [@css ".a-6i00gfuud{grid-template-columns:var(--value-lltij1);}"];
  [@css ".a-6i00wongh{grid-template-rows:none;}"];
  [@css ".a-6i00wkhlg{grid-template-rows:auto;}"];
  [@css ".a-6i00wgpmy{grid-template-rows:100px;}"];
  [@css ".a-6i00wx5k1{grid-template-rows:1fr;}"];
  [@css ".a-6i00wm4xw{grid-template-rows:100px 1fr auto;}"];
  [@css ".a-6i00w639k{grid-template-rows:repeat(2, 100px 1fr);}"];
  [@css
    ".a-6i00ws3t3{grid-template-rows:100px 1fr max-content minmax(min-content, 1fr);}"
  ];
  [@css ".a-6i00wv40g{grid-template-rows:10px [row-start] 250px [row-end];}"];
  [@css
    ".a-6i00w5w36{grid-template-rows:[first header-start] 50px [main-start] 1fr [footer-start] 50px [last];}"
  ];
  [@css ".a-6i008vbk0{grid-template-areas:none;}"];
  [@css ".a-6i008jsxg{grid-template-areas:\"articles\";}"];
  [@css ".a-6i008ebm2{grid-template-areas:\"head head\";}"];
  [@css
    ".a-6i008ajlc{grid-template-areas:\"head head\" \"nav main\" \"foot ....\";}"
  ];
  [@css ".a-6i01kk02x{grid-template:none;}"];
  [@css ".a-6i01kof85{grid-template:auto 1fr auto / auto 1fr;}"];
  [@css
    ".a-6i01kqbl3{grid-template:[header-top] \"a   a   a\" [header-bottom] [main-top] \"b   b   b\" 1fr [main-bottom] / auto 1fr auto;}"
  ];
  [@css ".a-6i001ct2f{grid-auto-columns:auto;}"];
  [@css ".a-6i001788q{grid-auto-columns:1fr;}"];
  [@css ".a-6i001ucm7{grid-auto-columns:100px;}"];
  [@css ".a-6i001rl89{grid-auto-columns:max-content;}"];
  [@css ".a-6i001b58e{grid-auto-columns:minmax(min-content, 1fr);}"];
  [@css ".a-6i001p52j{grid-auto-columns:min-content max-content auto;}"];
  [@css ".a-6i001etth{grid-auto-columns:100px 150px 390px;}"];
  [@css
    ".a-6i0019fyb{grid-auto-columns:100px minmax(100px, auto) 10% 0.5fr fit-content(400px);}"
  ];
  [@css ".a-6i004j1cp{grid-auto-rows:auto;}"];
  [@css ".a-6i00487mn{grid-auto-rows:1fr;}"];
  [@css ".a-6i004jdl6{grid-auto-rows:100px;}"];
  [@css ".a-6i004n8ka{grid-auto-rows:100px 30%;}"];
  [@css ".a-6i004ogvi{grid-auto-rows:100px 30% 1em;}"];
  [@css ".a-6i004rlx9{grid-auto-rows:min-content;}"];
  [@css ".a-6i004vdaf{grid-auto-rows:minmax(min-content, 1fr);}"];
  [@css ".a-6i0042nfb{grid-auto-rows:min-content max-content auto;}"];
  [@css
    ".a-6i004li5h{grid-auto-rows:100px minmax(100px, auto) 10% 0.5fr fit-content(400px);}"
  ];
  [@css ".a-6i002bia0{grid-auto-flow:row;}"];
  [@css ".a-6i002memo{grid-auto-flow:column;}"];
  [@css ".a-6i002rdxo{grid-auto-flow:row dense;}"];
  [@css ".a-6i002pbhg{grid-auto-flow:column dense;}"];
  [@css ".a-6imumt{grid:auto-flow 1fr / 100px;}"];
  [@css ".a-6itfa6{grid:none / auto-flow 1fr;}"];
  [@css ".a-6iwvt8{grid:auto-flow / auto 1fr;}"];
  [@css ".a-6iqmta{grid:repeat(auto-fill, 5em) / auto-flow 1fr;}"];
  [@css ".a-6iqq5h{grid:auto-flow 1fr / repeat(auto-fill, 5em);}"];
  [@css ".a-6i5ht4{grid:\"H    H \" \"A    B \" \"F    F \" 30px / auto 1fr;}"];
  [@css ".a-6j008zjax{grid-row-start:auto;}"];
  [@css ".a-6j008fvhq{grid-row-start:4;}"];
  [@css ".a-6j0084rsv{grid-row-start:C;}"];
  [@css ".a-6j008n6f3{grid-row-start:C 2;}"];
  [@css ".a-6j008bss9{grid-row-start:span C;}"];
  [@css ".a-6j0088pbd{grid-row-start:span 1;}"];
  [@css ".a-6j002rk85{grid-column-start:auto;}"];
  [@css ".a-6j0026726{grid-column-start:4;}"];
  [@css ".a-6j0027d9e{grid-column-start:C;}"];
  [@css ".a-6j00272n4{grid-column-start:C 2;}"];
  [@css ".a-6j0021anm{grid-column-start:span C;}"];
  [@css ".a-6j0024khj{grid-column-start:span 1;}"];
  [@css ".a-6j0042lck{grid-row-end:auto;}"];
  [@css ".a-6j004owek{grid-row-end:4;}"];
  [@css ".a-6j004st3l{grid-row-end:C;}"];
  [@css ".a-6j004qjrt{grid-row-end:C 2;}"];
  [@css ".a-6j004f9ww{grid-row-end:span C;}"];
  [@css ".a-6j004g46w{grid-row-end:span 1;}"];
  [@css ".a-6j001or5z{grid-column-end:auto;}"];
  [@css ".a-6j0012sxp{grid-column-end:4;}"];
  [@css ".a-6j001g5bp{grid-column-end:C;}"];
  [@css ".a-6j001246j{grid-column-end:C 2;}"];
  [@css ".a-6j0011mgs{grid-column-end:span C;}"];
  [@css ".a-6j001oa7h{grid-column-end:span 1;}"];
  [@css ".a-6j0031t2y{-ms-grid-column:auto;grid-column:auto;}"];
  [@css ".a-6j003y4ls{-ms-grid-column:1;grid-column:1;}"];
  [@css ".a-6j003z211{-ms-grid-column:-1;grid-column:-1;}"];
  [@css ".a-6j003d5pn{-ms-grid-column:1 / 1;grid-column:1 / 1;}"];
  [@css ".a-6j003pmo8{-ms-grid-column:1 / -1;grid-column:1 / -1;}"];
  [@css ".a-6j003f0lh{-ms-grid-column:auto / auto;grid-column:auto / auto;}"];
  [@css ".a-6j0034k46{-ms-grid-column:2 / span 2;grid-column:2 / span 2;}"];
  [@css ".a-6j00crhcf{-ms-grid-row:auto;grid-row:auto;}"];
  [@css ".a-6j00ceqmj{-ms-grid-row:1;grid-row:1;}"];
  [@css ".a-6j00cmsv3{-ms-grid-row:-1;grid-row:-1;}"];
  [@css ".a-6j00co7kt{-ms-grid-row:1 / 1;grid-row:1 / 1;}"];
  [@css ".a-6j00cbz7i{-ms-grid-row:1 / -1;grid-row:1 / -1;}"];
  [@css ".a-6j00cg6o0{-ms-grid-row:auto / auto;grid-row:auto / auto;}"];
  [@css ".a-6j00c17bb{-ms-grid-row:2 / span 2;grid-row:2 / span 2;}"];
  [@css ".a-6jx97r{grid-area:1 / 1;}"];
  [@css ".a-6j8twa{grid-area:var(--area-a9otef);}"];
  [@css ".a-6jrmtw{grid-area:1 / span 1;}"];
  [@css ".a-6j007a{grid-area:span 1 / 10 / -1;}"];
  [@css ".a-6ft3cm{grid-column-gap:0;}"];
  [@css ".a-6f1ss7{grid-column-gap:1em;}"];
  [@css ".a-6fvwck{grid-row-gap:0;}"];
  [@css ".a-6fe9xb{grid-row-gap:1em;}"];
  [@css ".a-6fqgkd{grid-gap:0 0;}"];
  [@css ".a-6fqfdq{grid-gap:0 1em;}"];
  [@css ".a-6f22h1{grid-gap:1em;}"];
  [@css ".a-6fizm2{grid-gap:1em 1em;}"];
  [@css ".a-6i00gl3nx{grid-template-columns:subgrid;}"];
  [@css ".a-6i00gktzg{grid-template-columns:subgrid [sub-a];}"];
  [@css ".a-6i00gqjfz{grid-template-columns:subgrid [sub-a] [sub-b];}"];
  [@css ".a-6i00gecjn{grid-template-columns:subgrid repeat(1, [sub-a]);}"];
  [@css
    ".a-6i00g17e0{grid-template-columns:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}"
  ];
  [@css
    ".a-6i00g93ua{grid-template-columns:subgrid repeat(auto-fill, [sub-a] [sub-b]);}"
  ];
  [@css
    ".a-6i00gn4kv{grid-template-columns:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g]);}"
  ];
  [@css ".a-6i00wdu2f{grid-template-rows:subgrid;}"];
  [@css ".a-6i00wyyt1{grid-template-rows:subgrid [sub-a];}"];
  [@css ".a-6i00wpgnt{grid-template-rows:subgrid [sub-a] [sub-b];}"];
  [@css ".a-6i00w9v9m{grid-template-rows:subgrid repeat(1, [sub-a]);}"];
  [@css
    ".a-6i00whys9{grid-template-rows:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}"
  ];
  [@css
    ".a-6i00wt659{grid-template-rows:subgrid repeat(auto-fill, [sub-a] [sub-b]);}"
  ];
  [@css
    ".a-6i00wwrvq{grid-template-rows:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g]);}"
  ];
  [@css ".a-6i00go398{grid-template-columns:masonry;}"];
  [@css ".a-6i00w4vh0{grid-template-rows:masonry;}"];
  [@css ".a-80owej{masonry-auto-flow:pack;}"];
  [@css ".a-80wgmu{masonry-auto-flow:next;}"];
  [@css ".a-80tv39{masonry-auto-flow:definite-first;}"];
  [@css ".a-80n96u{masonry-auto-flow:ordered;}"];
  [@css ".a-80l2hz{masonry-auto-flow:pack definite-first;}"];
  [@css ".a-807ym7{masonry-auto-flow:pack ordered;}"];
  [@css ".a-802buy{masonry-auto-flow:next definite-first;}"];
  [@css ".a-80w1v0{masonry-auto-flow:next ordered;}"];
  [@css ".a-804l3r{masonry-auto-flow:ordered pack;}"];
  
  CSS.make("a-5rj0h8", []);
  CSS.make("a-5rux3o", []);
  CSS.make("a-6i00gawez", []);
  CSS.make("a-6i00gd5pp", []);
  CSS.make("a-6i00gnoai", []);
  CSS.make("a-6i00g2f7z", []);
  CSS.make("a-6i00g77wr", []);
  CSS.make("a-6i00g31z1", []);
  CSS.make("a-6i00geq6h", []);
  CSS.make("a-6i00g6931", []);
  CSS.make("a-6i00gxfq4", []);
  CSS.make("a-6i00gs16i", []);
  CSS.make("a-6i00gikxo", []);
  CSS.make("a-6i00g5qjg", []);
  CSS.make("a-6i00gx00g", []);
  CSS.make("a-6i00g2g5g", []);
  CSS.make("a-6i00g9bqb", []);
  CSS.make("a-6i00guhs9", []);
  
  CSS.make("a-6i00ggf7e", []);
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
    "a-6i00gfuud",
    [("--value-lltij1", CSS.Types.GridTemplateColumns.toString(value))],
  );
  CSS.make("a-6i00wongh", []);
  CSS.make("a-6i00wkhlg", []);
  CSS.make("a-6i00wgpmy", []);
  CSS.make("a-6i00wx5k1", []);
  CSS.make("a-6i00wm4xw", []);
  CSS.make("a-6i00w639k", []);
  CSS.make("a-6i00ws3t3", []);
  CSS.make("a-6i00wv40g", []);
  CSS.make("a-6i00w5w36", []);
  CSS.make("a-6i008vbk0", []);
  CSS.make("a-6i008jsxg", []);
  CSS.make("a-6i008ebm2", []);
  CSS.make("a-6i008ajlc", []);
  CSS.make("a-6i01kk02x", []);
  CSS.make("a-6i01kof85", []);
  CSS.make("a-6i01kqbl3", []);
  CSS.make("a-6i001ct2f", []);
  CSS.make("a-6i001788q", []);
  CSS.make("a-6i001ucm7", []);
  CSS.make("a-6i001rl89", []);
  CSS.make("a-6i001b58e", []);
  CSS.make("a-6i001p52j", []);
  CSS.make("a-6i001etth", []);
  CSS.make("a-6i0019fyb", []);
  CSS.make("a-6i004j1cp", []);
  CSS.make("a-6i00487mn", []);
  CSS.make("a-6i004jdl6", []);
  CSS.make("a-6i004n8ka", []);
  CSS.make("a-6i004ogvi", []);
  CSS.make("a-6i004rlx9", []);
  CSS.make("a-6i004vdaf", []);
  CSS.make("a-6i0042nfb", []);
  CSS.make("a-6i004li5h", []);
  CSS.make("a-6i002bia0", []);
  CSS.make("a-6i002memo", []);
  CSS.make("a-6i002rdxo", []);
  CSS.make("a-6i002pbhg", []);
  CSS.make("a-6imumt", []);
  CSS.make("a-6itfa6", []);
  CSS.make("a-6iwvt8", []);
  CSS.make("a-6iqmta", []);
  CSS.make("a-6iqq5h", []);
  CSS.make("a-6i5ht4", []);
  CSS.make("a-6j008zjax", []);
  CSS.make("a-6j008fvhq", []);
  CSS.make("a-6j0084rsv", []);
  CSS.make("a-6j008n6f3", []);
  CSS.make("a-6j008bss9", []);
  CSS.make("a-6j0088pbd", []);
  CSS.make("a-6j002rk85", []);
  CSS.make("a-6j0026726", []);
  CSS.make("a-6j0027d9e", []);
  CSS.make("a-6j00272n4", []);
  CSS.make("a-6j0021anm", []);
  CSS.make("a-6j0024khj", []);
  CSS.make("a-6j0042lck", []);
  CSS.make("a-6j004owek", []);
  CSS.make("a-6j004st3l", []);
  CSS.make("a-6j004qjrt", []);
  CSS.make("a-6j004f9ww", []);
  CSS.make("a-6j004g46w", []);
  CSS.make("a-6j001or5z", []);
  CSS.make("a-6j0012sxp", []);
  CSS.make("a-6j001g5bp", []);
  CSS.make("a-6j001246j", []);
  CSS.make("a-6j0011mgs", []);
  CSS.make("a-6j001oa7h", []);
  CSS.make("a-6j0031t2y", []);
  CSS.make("a-6j003y4ls", []);
  CSS.make("a-6j003z211", []);
  CSS.make("a-6j003d5pn", []);
  CSS.make("a-6j003pmo8", []);
  CSS.make("a-6j003f0lh", []);
  CSS.make("a-6j0034k46", []);
  CSS.make("a-6j00crhcf", []);
  CSS.make("a-6j00ceqmj", []);
  CSS.make("a-6j00cmsv3", []);
  CSS.make("a-6j00co7kt", []);
  CSS.make("a-6j00cbz7i", []);
  CSS.make("a-6j00cg6o0", []);
  CSS.make("a-6j00c17bb", []);
  CSS.make("a-6jx97r", []);
  let area = `num(33);
  CSS.make(
    "a-6j8twa",
    [("--area-a9otef", CSS.Types.GridArea.toString(area))],
  );
  CSS.make("a-6jrmtw", []);
  CSS.make("a-6j007a", []);
  CSS.make("a-6ft3cm", []);
  CSS.make("a-6f1ss7", []);
  CSS.make("a-6fvwck", []);
  CSS.make("a-6fe9xb", []);
  CSS.make("a-6fqgkd", []);
  CSS.make("a-6fqfdq", []);
  CSS.make("a-6f22h1", []);
  CSS.make("a-6fizm2", []);
  
  CSS.make("a-6i00gl3nx", []);
  CSS.make("a-6i00gktzg", []);
  CSS.make("a-6i00gqjfz", []);
  CSS.make("a-6i00gecjn", []);
  CSS.make("a-6i00g17e0", []);
  CSS.make("a-6i00g93ua", []);
  CSS.make("a-6i00gn4kv", []);
  CSS.make("a-6i00wdu2f", []);
  CSS.make("a-6i00wyyt1", []);
  CSS.make("a-6i00wpgnt", []);
  CSS.make("a-6i00w9v9m", []);
  CSS.make("a-6i00whys9", []);
  CSS.make("a-6i00wt659", []);
  CSS.make("a-6i00wwrvq", []);
  
  CSS.make("a-6i00go398", []);
  CSS.make("a-6i00w4vh0", []);
  CSS.make("a-80owej", []);
  CSS.make("a-80wgmu", []);
  CSS.make("a-80tv39", []);
  CSS.make("a-80n96u", []);
  CSS.make("a-80l2hz", []);
  CSS.make("a-807ym7", []);
  CSS.make("a-802buy", []);
  CSS.make("a-80w1v0", []);
  CSS.make("a-804l3r", []);
