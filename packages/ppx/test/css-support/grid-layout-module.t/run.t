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
  [@css "._a_5rj0h8{display:grid;}"];
  [@css "._a_5rux3o{display:inline-grid;}"];
  [@css "._a_6i000gawez{grid-template-columns:none;}"];
  [@css "._a_6i000gd5pp{grid-template-columns:auto;}"];
  [@css "._a_6i000gnoai{grid-template-columns:100px;}"];
  [@css "._a_6i000g2f7z{grid-template-columns:1fr;}"];
  [@css "._a_6i000g77wr{grid-template-columns:100px 1fr auto;}"];
  [@css "._a_6i000g31z1{grid-template-columns:repeat(2, 100px 1fr);}"];
  [@css
    "._a_6i000geq6h{grid-template-columns:repeat(4, 10px [col-start] 250px [col-end]) 10px;}"
  ];
  [@css
    "._a_6i000g6931{grid-template-columns:100px 1fr max-content minmax(min-content, 1fr);}"
  ];
  [@css
    "._a_6i000gxfq4{grid-template-columns:repeat(auto-fill, minmax(25ch, 1fr));}"
  ];
  [@css
    "._a_6i000gs16i{grid-template-columns:10px [col-start] 250px [col-end];}"
  ];
  [@css
    "._a_6i000gikxo{grid-template-columns:[first nav-start] 150px [main-start] 1fr [last];}"
  ];
  [@css
    "._a_6i000g5qjg{grid-template-columns:10px [col-start] 250px [col-end] 10px [col-start] 250px [col-end] 10px;}"
  ];
  [@css
    "._a_6i000gx00g{grid-template-columns:[a] auto [b] minmax(min-content, 1fr) [b c d] repeat(2, [e] 40px) repeat(5, auto);}"
  ];
  [@css
    "._a_6i000g2g5g{grid-template-columns:200px repeat(auto-fill, 100px) 300px;}"
  ];
  [@css
    "._a_6i000g9bqb{grid-template-columns:minmax(100px, max-content) repeat(auto-fill, 200px) 20%;}"
  ];
  [@css
    "._a_6i000guhs9{grid-template-columns:[linename1] 100px [linename2] repeat(auto-fit, [linename3 linename4] 300px) 100px;}"
  ];
  [@css
    "._a_6i000ggf7e{grid-template-columns:[linename1 linename2] 100px repeat(auto-fit, [linename1] 300px) [linename3];}"
  ];
  [@css "._a_6i000gfuud{grid-template-columns:var(--value-lltij1);}"];
  [@css "._a_6i000wongh{grid-template-rows:none;}"];
  [@css "._a_6i000wkhlg{grid-template-rows:auto;}"];
  [@css "._a_6i000wgpmy{grid-template-rows:100px;}"];
  [@css "._a_6i000wx5k1{grid-template-rows:1fr;}"];
  [@css "._a_6i000wm4xw{grid-template-rows:100px 1fr auto;}"];
  [@css "._a_6i000w639k{grid-template-rows:repeat(2, 100px 1fr);}"];
  [@css
    "._a_6i000ws3t3{grid-template-rows:100px 1fr max-content minmax(min-content, 1fr);}"
  ];
  [@css "._a_6i000wv40g{grid-template-rows:10px [row-start] 250px [row-end];}"];
  [@css
    "._a_6i000w5w36{grid-template-rows:[first header-start] 50px [main-start] 1fr [footer-start] 50px [last];}"
  ];
  [@css "._a_6i0008vbk0{grid-template-areas:none;}"];
  [@css "._a_6i0008jsxg{grid-template-areas:\"articles\";}"];
  [@css "._a_6i0008ebm2{grid-template-areas:\"head head\";}"];
  [@css
    "._a_6i0008ajlc{grid-template-areas:\"head head\" \"nav main\" \"foot ....\";}"
  ];
  [@css "._a_6i001kk02x{grid-template:none;}"];
  [@css "._a_6i001kof85{grid-template:auto 1fr auto / auto 1fr;}"];
  [@css
    "._a_6i001kqbl3{grid-template:[header-top] \"a   a   a\" [header-bottom] [main-top] \"b   b   b\" 1fr [main-bottom] / auto 1fr auto;}"
  ];
  [@css "._a_6i0001ct2f{grid-auto-columns:auto;}"];
  [@css "._a_6i0001788q{grid-auto-columns:1fr;}"];
  [@css "._a_6i0001ucm7{grid-auto-columns:100px;}"];
  [@css "._a_6i0001rl89{grid-auto-columns:max-content;}"];
  [@css "._a_6i0001b58e{grid-auto-columns:minmax(min-content, 1fr);}"];
  [@css "._a_6i0001p52j{grid-auto-columns:min-content max-content auto;}"];
  [@css "._a_6i0001etth{grid-auto-columns:100px 150px 390px;}"];
  [@css
    "._a_6i00019fyb{grid-auto-columns:100px minmax(100px, auto) 10% 0.5fr fit-content(400px);}"
  ];
  [@css "._a_6i0004j1cp{grid-auto-rows:auto;}"];
  [@css "._a_6i000487mn{grid-auto-rows:1fr;}"];
  [@css "._a_6i0004jdl6{grid-auto-rows:100px;}"];
  [@css "._a_6i0004n8ka{grid-auto-rows:100px 30%;}"];
  [@css "._a_6i0004ogvi{grid-auto-rows:100px 30% 1em;}"];
  [@css "._a_6i0004rlx9{grid-auto-rows:min-content;}"];
  [@css "._a_6i0004vdaf{grid-auto-rows:minmax(min-content, 1fr);}"];
  [@css "._a_6i00042nfb{grid-auto-rows:min-content max-content auto;}"];
  [@css
    "._a_6i0004li5h{grid-auto-rows:100px minmax(100px, auto) 10% 0.5fr fit-content(400px);}"
  ];
  [@css "._a_6i0002bia0{grid-auto-flow:row;}"];
  [@css "._a_6i0002memo{grid-auto-flow:column;}"];
  [@css "._a_6i0002rdxo{grid-auto-flow:row dense;}"];
  [@css "._a_6i0002pbhg{grid-auto-flow:column dense;}"];
  [@css "._a_6imumt{grid:auto-flow 1fr / 100px;}"];
  [@css "._a_6itfa6{grid:none / auto-flow 1fr;}"];
  [@css "._a_6iwvt8{grid:auto-flow / auto 1fr;}"];
  [@css "._a_6iqmta{grid:repeat(auto-fill, 5em) / auto-flow 1fr;}"];
  [@css "._a_6iqq5h{grid:auto-flow 1fr / repeat(auto-fill, 5em);}"];
  [@css "._a_6i5ht4{grid:\"H    H \" \"A    B \" \"F    F \" 30px / auto 1fr;}"];
  [@css "._a_6j0008zjax{grid-row-start:auto;}"];
  [@css "._a_6j0008fvhq{grid-row-start:4;}"];
  [@css "._a_6j00084rsv{grid-row-start:C;}"];
  [@css "._a_6j0008n6f3{grid-row-start:C 2;}"];
  [@css "._a_6j0008bss9{grid-row-start:span C;}"];
  [@css "._a_6j00088pbd{grid-row-start:span 1;}"];
  [@css "._a_6j0002rk85{grid-column-start:auto;}"];
  [@css "._a_6j00026726{grid-column-start:4;}"];
  [@css "._a_6j00027d9e{grid-column-start:C;}"];
  [@css "._a_6j000272n4{grid-column-start:C 2;}"];
  [@css "._a_6j00021anm{grid-column-start:span C;}"];
  [@css "._a_6j00024khj{grid-column-start:span 1;}"];
  [@css "._a_6j00042lck{grid-row-end:auto;}"];
  [@css "._a_6j0004owek{grid-row-end:4;}"];
  [@css "._a_6j0004st3l{grid-row-end:C;}"];
  [@css "._a_6j0004qjrt{grid-row-end:C 2;}"];
  [@css "._a_6j0004f9ww{grid-row-end:span C;}"];
  [@css "._a_6j0004g46w{grid-row-end:span 1;}"];
  [@css "._a_6j0001or5z{grid-column-end:auto;}"];
  [@css "._a_6j00012sxp{grid-column-end:4;}"];
  [@css "._a_6j0001g5bp{grid-column-end:C;}"];
  [@css "._a_6j0001246j{grid-column-end:C 2;}"];
  [@css "._a_6j00011mgs{grid-column-end:span C;}"];
  [@css "._a_6j0001oa7h{grid-column-end:span 1;}"];
  [@css "._a_6j00031t2y{grid-column:auto;}"];
  [@css "._a_6j0003y4ls{grid-column:1;}"];
  [@css "._a_6j0003z211{grid-column:-1;}"];
  [@css "._a_6j0003d5pn{grid-column:1 / 1;}"];
  [@css "._a_6j0003pmo8{grid-column:1 / -1;}"];
  [@css "._a_6j0003f0lh{grid-column:auto / auto;}"];
  [@css "._a_6j00034k46{grid-column:2 / span 2;}"];
  [@css "._a_6j000crhcf{grid-row:auto;}"];
  [@css "._a_6j000ceqmj{grid-row:1;}"];
  [@css "._a_6j000cmsv3{grid-row:-1;}"];
  [@css "._a_6j000co7kt{grid-row:1 / 1;}"];
  [@css "._a_6j000cbz7i{grid-row:1 / -1;}"];
  [@css "._a_6j000cg6o0{grid-row:auto / auto;}"];
  [@css "._a_6j000c17bb{grid-row:2 / span 2;}"];
  [@css "._a_6jx97r{grid-area:1 / 1;}"];
  [@css "._a_6j8twa{grid-area:var(--area-a9otef);}"];
  [@css "._a_6jrmtw{grid-area:1 / span 1;}"];
  [@css "._a_6j007a{grid-area:span 1 / 10 / -1;}"];
  [@css "._a_6f0001t3cm{grid-column-gap:0;}"];
  [@css "._a_6f00011ss7{grid-column-gap:1em;}"];
  [@css "._a_6f0002vwck{grid-row-gap:0;}"];
  [@css "._a_6f0002e9xb{grid-row-gap:1em;}"];
  [@css "._a_6fqgkd{grid-gap:0 0;}"];
  [@css "._a_6fqfdq{grid-gap:0 1em;}"];
  [@css "._a_6f22h1{grid-gap:1em;}"];
  [@css "._a_6fizm2{grid-gap:1em 1em;}"];
  [@css "._a_6i000gl3nx{grid-template-columns:subgrid;}"];
  [@css "._a_6i000gktzg{grid-template-columns:subgrid [sub-a];}"];
  [@css "._a_6i000gqjfz{grid-template-columns:subgrid [sub-a] [sub-b];}"];
  [@css "._a_6i000gecjn{grid-template-columns:subgrid repeat(1, [sub-a]);}"];
  [@css
    "._a_6i000g17e0{grid-template-columns:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}"
  ];
  [@css
    "._a_6i000g93ua{grid-template-columns:subgrid repeat(auto-fill, [sub-a] [sub-b]);}"
  ];
  [@css
    "._a_6i000gn4kv{grid-template-columns:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g]);}"
  ];
  [@css "._a_6i000wdu2f{grid-template-rows:subgrid;}"];
  [@css "._a_6i000wyyt1{grid-template-rows:subgrid [sub-a];}"];
  [@css "._a_6i000wpgnt{grid-template-rows:subgrid [sub-a] [sub-b];}"];
  [@css "._a_6i000w9v9m{grid-template-rows:subgrid repeat(1, [sub-a]);}"];
  [@css
    "._a_6i000whys9{grid-template-rows:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}"
  ];
  [@css
    "._a_6i000wt659{grid-template-rows:subgrid repeat(auto-fill, [sub-a] [sub-b]);}"
  ];
  [@css
    "._a_6i000wwrvq{grid-template-rows:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g]);}"
  ];
  [@css "._a_6i000go398{grid-template-columns:masonry;}"];
  [@css "._a_6i000w4vh0{grid-template-rows:masonry;}"];
  [@css "._a_80owej{masonry-auto-flow:pack;}"];
  [@css "._a_80wgmu{masonry-auto-flow:next;}"];
  [@css "._a_80tv39{masonry-auto-flow:definite-first;}"];
  [@css "._a_80n96u{masonry-auto-flow:ordered;}"];
  [@css "._a_80l2hz{masonry-auto-flow:pack definite-first;}"];
  [@css "._a_807ym7{masonry-auto-flow:pack ordered;}"];
  [@css "._a_802buy{masonry-auto-flow:next definite-first;}"];
  [@css "._a_80w1v0{masonry-auto-flow:next ordered;}"];
  [@css "._a_804l3r{masonry-auto-flow:ordered pack;}"];
  [@css.blocks
    [
      (2, "_a_5rj0h8"),
      (3, "_a_5rux3o"),
      (4, "_a_6i000gawez"),
      (5, "_a_6i000gd5pp"),
      (6, "_a_6i000gnoai"),
      (7, "_a_6i000g2f7z"),
      (8, "_a_6i000g77wr"),
      (9, "_a_6i000g31z1"),
      (11, "_a_6i000geq6h"),
      (14, "_a_6i000g6931"),
      (16, "_a_6i000gxfq4"),
      (17, "_a_6i000gs16i"),
      (19, "_a_6i000gikxo"),
      (22, "_a_6i000g5qjg"),
      (25, "_a_6i000gx00g"),
      (27, "_a_6i000g2g5g"),
      (29, "_a_6i000g9bqb"),
      (32, "_a_6i000guhs9"),
      (36, "_a_6i000ggf7e"),
      (51, "_a_6i000gfuud"),
      (52, "_a_6i000wongh"),
      (53, "_a_6i000wkhlg"),
      (54, "_a_6i000wgpmy"),
      (55, "_a_6i000wx5k1"),
      (56, "_a_6i000wm4xw"),
      (57, "_a_6i000w639k"),
      (58, "_a_6i000ws3t3"),
      (59, "_a_6i000wv40g"),
      (61, "_a_6i000w5w36"),
      (63, "_a_6i0008vbk0"),
      (64, "_a_6i0008jsxg"),
      (65, "_a_6i0008ebm2"),
      (66, "_a_6i0008ajlc"),
      (67, "_a_6i001kk02x"),
      (68, "_a_6i001kof85"),
      (70, "_a_6i001kqbl3"),
      (72, "_a_6i0001ct2f"),
      (73, "_a_6i0001788q"),
      (74, "_a_6i0001ucm7"),
      (75, "_a_6i0001rl89"),
      (76, "_a_6i0001b58e"),
      (77, "_a_6i0001p52j"),
      (78, "_a_6i0001etth"),
      (80, "_a_6i00019fyb"),
      (82, "_a_6i0004j1cp"),
      (83, "_a_6i000487mn"),
      (84, "_a_6i0004jdl6"),
      (85, "_a_6i0004n8ka"),
      (86, "_a_6i0004ogvi"),
      (87, "_a_6i0004rlx9"),
      (88, "_a_6i0004vdaf"),
      (89, "_a_6i00042nfb"),
      (91, "_a_6i0004li5h"),
      (93, "_a_6i0002bia0"),
      (94, "_a_6i0002memo"),
      (95, "_a_6i0002rdxo"),
      (96, "_a_6i0002pbhg"),
      (97, "_a_6imumt"),
      (98, "_a_6itfa6"),
      (99, "_a_6iwvt8"),
      (100, "_a_6iqmta"),
      (101, "_a_6iqq5h"),
      (102, "_a_6i5ht4"),
      (103, "_a_6j0008zjax"),
      (104, "_a_6j0008fvhq"),
      (105, "_a_6j00084rsv"),
      (106, "_a_6j0008n6f3"),
      (107, "_a_6j0008bss9"),
      (108, "_a_6j00088pbd"),
      (109, "_a_6j0002rk85"),
      (110, "_a_6j00026726"),
      (111, "_a_6j00027d9e"),
      (112, "_a_6j000272n4"),
      (113, "_a_6j00021anm"),
      (114, "_a_6j00024khj"),
      (115, "_a_6j00042lck"),
      (116, "_a_6j0004owek"),
      (117, "_a_6j0004st3l"),
      (118, "_a_6j0004qjrt"),
      (119, "_a_6j0004f9ww"),
      (120, "_a_6j0004g46w"),
      (121, "_a_6j0001or5z"),
      (122, "_a_6j00012sxp"),
      (123, "_a_6j0001g5bp"),
      (124, "_a_6j0001246j"),
      (125, "_a_6j00011mgs"),
      (126, "_a_6j0001oa7h"),
      (127, "_a_6j00031t2y"),
      (128, "_a_6j0003y4ls"),
      (129, "_a_6j0003z211"),
      (130, "_a_6j0003d5pn"),
      (131, "_a_6j0003pmo8"),
      (132, "_a_6j0003f0lh"),
      (133, "_a_6j00034k46"),
      (134, "_a_6j000crhcf"),
      (135, "_a_6j000ceqmj"),
      (136, "_a_6j000cmsv3"),
      (137, "_a_6j000co7kt"),
      (138, "_a_6j000cbz7i"),
      (139, "_a_6j000cg6o0"),
      (140, "_a_6j000c17bb"),
      (141, "_a_6jx97r"),
      (143, "_a_6j8twa"),
      (144, "_a_6jrmtw"),
      (145, "_a_6j007a"),
      (146, "_a_6f0001t3cm"),
      (147, "_a_6f00011ss7"),
      (148, "_a_6f0002vwck"),
      (149, "_a_6f0002e9xb"),
      (150, "_a_6fqgkd"),
      (151, "_a_6fqfdq"),
      (152, "_a_6f22h1"),
      (153, "_a_6fizm2"),
      (156, "_a_6i000gl3nx"),
      (157, "_a_6i000gktzg"),
      (158, "_a_6i000gqjfz"),
      (159, "_a_6i000gecjn"),
      (160, "_a_6i000g17e0"),
      (161, "_a_6i000g93ua"),
      (163, "_a_6i000gn4kv"),
      (165, "_a_6i000wdu2f"),
      (166, "_a_6i000wyyt1"),
      (167, "_a_6i000wpgnt"),
      (168, "_a_6i000w9v9m"),
      (169, "_a_6i000whys9"),
      (170, "_a_6i000wt659"),
      (172, "_a_6i000wwrvq"),
      (176, "_a_6i000go398"),
      (177, "_a_6i000w4vh0"),
      (178, "_a_80owej"),
      (179, "_a_80wgmu"),
      (180, "_a_80tv39"),
      (181, "_a_80n96u"),
      (182, "_a_80l2hz"),
      (183, "_a_807ym7"),
      (184, "_a_802buy"),
      (185, "_a_80w1v0"),
      (186, "_a_804l3r"),
    ]
  ];
  
  CSS.make("_a_5rj0h8", []);
  CSS.make("_a_5rux3o", []);
  CSS.make("_a_6i000gawez", []);
  CSS.make("_a_6i000gd5pp", []);
  CSS.make("_a_6i000gnoai", []);
  CSS.make("_a_6i000g2f7z", []);
  CSS.make("_a_6i000g77wr", []);
  CSS.make("_a_6i000g31z1", []);
  CSS.make("_a_6i000geq6h", []);
  CSS.make("_a_6i000g6931", []);
  CSS.make("_a_6i000gxfq4", []);
  CSS.make("_a_6i000gs16i", []);
  CSS.make("_a_6i000gikxo", []);
  CSS.make("_a_6i000g5qjg", []);
  CSS.make("_a_6i000gx00g", []);
  CSS.make("_a_6i000g2g5g", []);
  CSS.make("_a_6i000g9bqb", []);
  CSS.make("_a_6i000guhs9", []);
  
  CSS.make("_a_6i000ggf7e", []);
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
    "_a_6i000gfuud",
    [("--value-lltij1", CSS.Types.GridTemplateColumns.toString(value))],
  );
  CSS.make("_a_6i000wongh", []);
  CSS.make("_a_6i000wkhlg", []);
  CSS.make("_a_6i000wgpmy", []);
  CSS.make("_a_6i000wx5k1", []);
  CSS.make("_a_6i000wm4xw", []);
  CSS.make("_a_6i000w639k", []);
  CSS.make("_a_6i000ws3t3", []);
  CSS.make("_a_6i000wv40g", []);
  CSS.make("_a_6i000w5w36", []);
  CSS.make("_a_6i0008vbk0", []);
  CSS.make("_a_6i0008jsxg", []);
  CSS.make("_a_6i0008ebm2", []);
  CSS.make("_a_6i0008ajlc", []);
  CSS.make("_a_6i001kk02x", []);
  CSS.make("_a_6i001kof85", []);
  CSS.make("_a_6i001kqbl3", []);
  CSS.make("_a_6i0001ct2f", []);
  CSS.make("_a_6i0001788q", []);
  CSS.make("_a_6i0001ucm7", []);
  CSS.make("_a_6i0001rl89", []);
  CSS.make("_a_6i0001b58e", []);
  CSS.make("_a_6i0001p52j", []);
  CSS.make("_a_6i0001etth", []);
  CSS.make("_a_6i00019fyb", []);
  CSS.make("_a_6i0004j1cp", []);
  CSS.make("_a_6i000487mn", []);
  CSS.make("_a_6i0004jdl6", []);
  CSS.make("_a_6i0004n8ka", []);
  CSS.make("_a_6i0004ogvi", []);
  CSS.make("_a_6i0004rlx9", []);
  CSS.make("_a_6i0004vdaf", []);
  CSS.make("_a_6i00042nfb", []);
  CSS.make("_a_6i0004li5h", []);
  CSS.make("_a_6i0002bia0", []);
  CSS.make("_a_6i0002memo", []);
  CSS.make("_a_6i0002rdxo", []);
  CSS.make("_a_6i0002pbhg", []);
  CSS.make("_a_6imumt", []);
  CSS.make("_a_6itfa6", []);
  CSS.make("_a_6iwvt8", []);
  CSS.make("_a_6iqmta", []);
  CSS.make("_a_6iqq5h", []);
  CSS.make("_a_6i5ht4", []);
  CSS.make("_a_6j0008zjax", []);
  CSS.make("_a_6j0008fvhq", []);
  CSS.make("_a_6j00084rsv", []);
  CSS.make("_a_6j0008n6f3", []);
  CSS.make("_a_6j0008bss9", []);
  CSS.make("_a_6j00088pbd", []);
  CSS.make("_a_6j0002rk85", []);
  CSS.make("_a_6j00026726", []);
  CSS.make("_a_6j00027d9e", []);
  CSS.make("_a_6j000272n4", []);
  CSS.make("_a_6j00021anm", []);
  CSS.make("_a_6j00024khj", []);
  CSS.make("_a_6j00042lck", []);
  CSS.make("_a_6j0004owek", []);
  CSS.make("_a_6j0004st3l", []);
  CSS.make("_a_6j0004qjrt", []);
  CSS.make("_a_6j0004f9ww", []);
  CSS.make("_a_6j0004g46w", []);
  CSS.make("_a_6j0001or5z", []);
  CSS.make("_a_6j00012sxp", []);
  CSS.make("_a_6j0001g5bp", []);
  CSS.make("_a_6j0001246j", []);
  CSS.make("_a_6j00011mgs", []);
  CSS.make("_a_6j0001oa7h", []);
  CSS.make("_a_6j00031t2y", []);
  CSS.make("_a_6j0003y4ls", []);
  CSS.make("_a_6j0003z211", []);
  CSS.make("_a_6j0003d5pn", []);
  CSS.make("_a_6j0003pmo8", []);
  CSS.make("_a_6j0003f0lh", []);
  CSS.make("_a_6j00034k46", []);
  CSS.make("_a_6j000crhcf", []);
  CSS.make("_a_6j000ceqmj", []);
  CSS.make("_a_6j000cmsv3", []);
  CSS.make("_a_6j000co7kt", []);
  CSS.make("_a_6j000cbz7i", []);
  CSS.make("_a_6j000cg6o0", []);
  CSS.make("_a_6j000c17bb", []);
  CSS.make("_a_6jx97r", []);
  let area = `num(33);
  CSS.make(
    "_a_6j8twa",
    [("--area-a9otef", CSS.Types.GridArea.toString(area))],
  );
  CSS.make("_a_6jrmtw", []);
  CSS.make("_a_6j007a", []);
  CSS.make("_a_6f0001t3cm", []);
  CSS.make("_a_6f00011ss7", []);
  CSS.make("_a_6f0002vwck", []);
  CSS.make("_a_6f0002e9xb", []);
  CSS.make("_a_6fqgkd", []);
  CSS.make("_a_6fqfdq", []);
  CSS.make("_a_6f22h1", []);
  CSS.make("_a_6fizm2", []);
  
  CSS.make("_a_6i000gl3nx", []);
  CSS.make("_a_6i000gktzg", []);
  CSS.make("_a_6i000gqjfz", []);
  CSS.make("_a_6i000gecjn", []);
  CSS.make("_a_6i000g17e0", []);
  CSS.make("_a_6i000g93ua", []);
  CSS.make("_a_6i000gn4kv", []);
  CSS.make("_a_6i000wdu2f", []);
  CSS.make("_a_6i000wyyt1", []);
  CSS.make("_a_6i000wpgnt", []);
  CSS.make("_a_6i000w9v9m", []);
  CSS.make("_a_6i000whys9", []);
  CSS.make("_a_6i000wt659", []);
  CSS.make("_a_6i000wwrvq", []);
  
  CSS.make("_a_6i000go398", []);
  CSS.make("_a_6i000w4vh0", []);
  CSS.make("_a_80owej", []);
  CSS.make("_a_80wgmu", []);
  CSS.make("_a_80tv39", []);
  CSS.make("_a_80n96u", []);
  CSS.make("_a_80l2hz", []);
  CSS.make("_a_807ym7", []);
  CSS.make("_a_802buy", []);
  CSS.make("_a_80w1v0", []);
  CSS.make("_a_804l3r", []);
