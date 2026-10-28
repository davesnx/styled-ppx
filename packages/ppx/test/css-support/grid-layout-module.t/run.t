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
  [@css
    ("._a_5rj0h8{display:grid;}", "_a_5rj0h8", "0,1,0 own", "207", 1, false)
  ];
  [@css
    (
      "._a_5rux3o{display:inline-grid;}",
      "_a_5rux3o",
      "0,1,0 own",
      "207",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gawez{grid-template-columns:none;}",
      "_a_6i000gawez",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gd5pp{grid-template-columns:auto;}",
      "_a_6i000gd5pp",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gnoai{grid-template-columns:100px;}",
      "_a_6i000gnoai",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000g2f7z{grid-template-columns:1fr;}",
      "_a_6i000g2f7z",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000g77wr{grid-template-columns:100px 1fr auto;}",
      "_a_6i000g77wr",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000g31z1{grid-template-columns:repeat(2, 100px 1fr);}",
      "_a_6i000g31z1",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000geq6h{grid-template-columns:repeat(4, 10px [col-start] 250px [col-end]) 10px;}",
      "_a_6i000geq6h",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000g6931{grid-template-columns:100px 1fr max-content minmax(min-content, 1fr);}",
      "_a_6i000g6931",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gxfq4{grid-template-columns:repeat(auto-fill, minmax(25ch, 1fr));}",
      "_a_6i000gxfq4",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gs16i{grid-template-columns:10px [col-start] 250px [col-end];}",
      "_a_6i000gs16i",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gikxo{grid-template-columns:[first nav-start] 150px [main-start] 1fr [last];}",
      "_a_6i000gikxo",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000g5qjg{grid-template-columns:10px [col-start] 250px [col-end] 10px [col-start] 250px [col-end] 10px;}",
      "_a_6i000g5qjg",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gx00g{grid-template-columns:[a] auto [b] minmax(min-content, 1fr) [b c d] repeat(2, [e] 40px) repeat(5, auto);}",
      "_a_6i000gx00g",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000g2g5g{grid-template-columns:200px repeat(auto-fill, 100px) 300px;}",
      "_a_6i000g2g5g",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000g9bqb{grid-template-columns:minmax(100px, max-content) repeat(auto-fill, 200px) 20%;}",
      "_a_6i000g9bqb",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000guhs9{grid-template-columns:[linename1] 100px [linename2] repeat(auto-fit, [linename3 linename4] 300px) 100px;}",
      "_a_6i000guhs9",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000ggf7e{grid-template-columns:[linename1 linename2] 100px repeat(auto-fit, [linename1] 300px) [linename3];}",
      "_a_6i000ggf7e",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gfuud{grid-template-columns:var(--value-lltij1);}",
      "_a_6i000gfuud",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000wongh{grid-template-rows:none;}",
      "_a_6i000wongh",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i000wkhlg{grid-template-rows:auto;}",
      "_a_6i000wkhlg",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i000wgpmy{grid-template-rows:100px;}",
      "_a_6i000wgpmy",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i000wx5k1{grid-template-rows:1fr;}",
      "_a_6i000wx5k1",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i000wm4xw{grid-template-rows:100px 1fr auto;}",
      "_a_6i000wm4xw",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i000w639k{grid-template-rows:repeat(2, 100px 1fr);}",
      "_a_6i000w639k",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i000ws3t3{grid-template-rows:100px 1fr max-content minmax(min-content, 1fr);}",
      "_a_6i000ws3t3",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i000wv40g{grid-template-rows:10px [row-start] 250px [row-end];}",
      "_a_6i000wv40g",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i000w5w36{grid-template-rows:[first header-start] 50px [main-start] 1fr [footer-start] 50px [last];}",
      "_a_6i000w5w36",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i0008vbk0{grid-template-areas:none;}",
      "_a_6i0008vbk0",
      "0,1,0 own",
      "234",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_6i0008jsxg{grid-template-areas:\"articles\";}",
      "_a_6i0008jsxg",
      "0,1,0 own",
      "234",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_6i0008ebm2{grid-template-areas:\"head head\";}",
      "_a_6i0008ebm2",
      "0,1,0 own",
      "234",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_6i0008ajlc{grid-template-areas:\"head head\" \"nav main\" \"foot ....\";}",
      "_a_6i0008ajlc",
      "0,1,0 own",
      "234",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_6i001kk02x{grid-template:none;}",
      "_a_6i001kk02x",
      "0,1,0 own",
      "234",
      56,
      false,
    )
  ];
  [@css
    (
      "._a_6i001kof85{grid-template:auto 1fr auto / auto 1fr;}",
      "_a_6i001kof85",
      "0,1,0 own",
      "234",
      56,
      false,
    )
  ];
  [@css
    (
      "._a_6i001kqbl3{grid-template:[header-top] \"a   a   a\" [header-bottom] [main-top] \"b   b   b\" 1fr [main-bottom] / auto 1fr auto;}",
      "_a_6i001kqbl3",
      "0,1,0 own",
      "234",
      56,
      false,
    )
  ];
  [@css
    (
      "._a_6i0001ct2f{grid-auto-columns:auto;}",
      "_a_6i0001ct2f",
      "0,1,0 own",
      "234",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6i0001788q{grid-auto-columns:1fr;}",
      "_a_6i0001788q",
      "0,1,0 own",
      "234",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6i0001ucm7{grid-auto-columns:100px;}",
      "_a_6i0001ucm7",
      "0,1,0 own",
      "234",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6i0001rl89{grid-auto-columns:max-content;}",
      "_a_6i0001rl89",
      "0,1,0 own",
      "234",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6i0001b58e{grid-auto-columns:minmax(min-content, 1fr);}",
      "_a_6i0001b58e",
      "0,1,0 own",
      "234",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6i0001p52j{grid-auto-columns:min-content max-content auto;}",
      "_a_6i0001p52j",
      "0,1,0 own",
      "234",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6i0001etth{grid-auto-columns:100px 150px 390px;}",
      "_a_6i0001etth",
      "0,1,0 own",
      "234",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6i00019fyb{grid-auto-columns:100px minmax(100px, auto) 10% 0.5fr fit-content(400px);}",
      "_a_6i00019fyb",
      "0,1,0 own",
      "234",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6i0004j1cp{grid-auto-rows:auto;}",
      "_a_6i0004j1cp",
      "0,1,0 own",
      "234",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6i000487mn{grid-auto-rows:1fr;}",
      "_a_6i000487mn",
      "0,1,0 own",
      "234",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6i0004jdl6{grid-auto-rows:100px;}",
      "_a_6i0004jdl6",
      "0,1,0 own",
      "234",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6i0004n8ka{grid-auto-rows:100px 30%;}",
      "_a_6i0004n8ka",
      "0,1,0 own",
      "234",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6i0004ogvi{grid-auto-rows:100px 30% 1em;}",
      "_a_6i0004ogvi",
      "0,1,0 own",
      "234",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6i0004rlx9{grid-auto-rows:min-content;}",
      "_a_6i0004rlx9",
      "0,1,0 own",
      "234",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6i0004vdaf{grid-auto-rows:minmax(min-content, 1fr);}",
      "_a_6i0004vdaf",
      "0,1,0 own",
      "234",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6i00042nfb{grid-auto-rows:min-content max-content auto;}",
      "_a_6i00042nfb",
      "0,1,0 own",
      "234",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6i0004li5h{grid-auto-rows:100px minmax(100px, auto) 10% 0.5fr fit-content(400px);}",
      "_a_6i0004li5h",
      "0,1,0 own",
      "234",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6i0002bia0{grid-auto-flow:row;}",
      "_a_6i0002bia0",
      "0,1,0 own",
      "234",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_6i0002memo{grid-auto-flow:column;}",
      "_a_6i0002memo",
      "0,1,0 own",
      "234",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_6i0002rdxo{grid-auto-flow:row dense;}",
      "_a_6i0002rdxo",
      "0,1,0 own",
      "234",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_6i0002pbhg{grid-auto-flow:column dense;}",
      "_a_6i0002pbhg",
      "0,1,0 own",
      "234",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_6imumt{grid:auto-flow 1fr / 100px;}",
      "_a_6imumt",
      "0,1,0 own",
      "234",
      63,
      false,
    )
  ];
  [@css
    (
      "._a_6itfa6{grid:none / auto-flow 1fr;}",
      "_a_6itfa6",
      "0,1,0 own",
      "234",
      63,
      false,
    )
  ];
  [@css
    (
      "._a_6iwvt8{grid:auto-flow / auto 1fr;}",
      "_a_6iwvt8",
      "0,1,0 own",
      "234",
      63,
      false,
    )
  ];
  [@css
    (
      "._a_6iqmta{grid:repeat(auto-fill, 5em) / auto-flow 1fr;}",
      "_a_6iqmta",
      "0,1,0 own",
      "234",
      63,
      false,
    )
  ];
  [@css
    (
      "._a_6iqq5h{grid:auto-flow 1fr / repeat(auto-fill, 5em);}",
      "_a_6iqq5h",
      "0,1,0 own",
      "234",
      63,
      false,
    )
  ];
  [@css
    (
      "._a_6i5ht4{grid:\"H    H \" \"A    B \" \"F    F \" 30px / auto 1fr;}",
      "_a_6i5ht4",
      "0,1,0 own",
      "234",
      63,
      false,
    )
  ];
  [@css
    (
      "._a_6j0008zjax{grid-row-start:auto;}",
      "_a_6j0008zjax",
      "0,1,0 own",
      "235",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_6j0008fvhq{grid-row-start:4;}",
      "_a_6j0008fvhq",
      "0,1,0 own",
      "235",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_6j00084rsv{grid-row-start:C;}",
      "_a_6j00084rsv",
      "0,1,0 own",
      "235",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_6j0008n6f3{grid-row-start:C 2;}",
      "_a_6j0008n6f3",
      "0,1,0 own",
      "235",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_6j0008bss9{grid-row-start:span C;}",
      "_a_6j0008bss9",
      "0,1,0 own",
      "235",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_6j00088pbd{grid-row-start:span 1;}",
      "_a_6j00088pbd",
      "0,1,0 own",
      "235",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_6j0002rk85{grid-column-start:auto;}",
      "_a_6j0002rk85",
      "0,1,0 own",
      "235",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_6j00026726{grid-column-start:4;}",
      "_a_6j00026726",
      "0,1,0 own",
      "235",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_6j00027d9e{grid-column-start:C;}",
      "_a_6j00027d9e",
      "0,1,0 own",
      "235",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_6j000272n4{grid-column-start:C 2;}",
      "_a_6j000272n4",
      "0,1,0 own",
      "235",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_6j00021anm{grid-column-start:span C;}",
      "_a_6j00021anm",
      "0,1,0 own",
      "235",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_6j00024khj{grid-column-start:span 1;}",
      "_a_6j00024khj",
      "0,1,0 own",
      "235",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_6j00042lck{grid-row-end:auto;}",
      "_a_6j00042lck",
      "0,1,0 own",
      "235",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6j0004owek{grid-row-end:4;}",
      "_a_6j0004owek",
      "0,1,0 own",
      "235",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6j0004st3l{grid-row-end:C;}",
      "_a_6j0004st3l",
      "0,1,0 own",
      "235",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6j0004qjrt{grid-row-end:C 2;}",
      "_a_6j0004qjrt",
      "0,1,0 own",
      "235",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6j0004f9ww{grid-row-end:span C;}",
      "_a_6j0004f9ww",
      "0,1,0 own",
      "235",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6j0004g46w{grid-row-end:span 1;}",
      "_a_6j0004g46w",
      "0,1,0 own",
      "235",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6j0001or5z{grid-column-end:auto;}",
      "_a_6j0001or5z",
      "0,1,0 own",
      "235",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6j00012sxp{grid-column-end:4;}",
      "_a_6j00012sxp",
      "0,1,0 own",
      "235",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6j0001g5bp{grid-column-end:C;}",
      "_a_6j0001g5bp",
      "0,1,0 own",
      "235",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6j0001246j{grid-column-end:C 2;}",
      "_a_6j0001246j",
      "0,1,0 own",
      "235",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6j00011mgs{grid-column-end:span C;}",
      "_a_6j00011mgs",
      "0,1,0 own",
      "235",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6j0001oa7h{grid-column-end:span 1;}",
      "_a_6j0001oa7h",
      "0,1,0 own",
      "235",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6j00031t2y{grid-column:auto;}",
      "_a_6j00031t2y",
      "0,1,0 own",
      "235",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_6j0003y4ls{grid-column:1;}",
      "_a_6j0003y4ls",
      "0,1,0 own",
      "235",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_6j0003z211{grid-column:-1;}",
      "_a_6j0003z211",
      "0,1,0 own",
      "235",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_6j0003d5pn{grid-column:1 / 1;}",
      "_a_6j0003d5pn",
      "0,1,0 own",
      "235",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_6j0003pmo8{grid-column:1 / -1;}",
      "_a_6j0003pmo8",
      "0,1,0 own",
      "235",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_6j0003f0lh{grid-column:auto / auto;}",
      "_a_6j0003f0lh",
      "0,1,0 own",
      "235",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_6j00034k46{grid-column:2 / span 2;}",
      "_a_6j00034k46",
      "0,1,0 own",
      "235",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_6j000crhcf{grid-row:auto;}",
      "_a_6j000crhcf",
      "0,1,0 own",
      "235",
      12,
      false,
    )
  ];
  [@css
    (
      "._a_6j000ceqmj{grid-row:1;}",
      "_a_6j000ceqmj",
      "0,1,0 own",
      "235",
      12,
      false,
    )
  ];
  [@css
    (
      "._a_6j000cmsv3{grid-row:-1;}",
      "_a_6j000cmsv3",
      "0,1,0 own",
      "235",
      12,
      false,
    )
  ];
  [@css
    (
      "._a_6j000co7kt{grid-row:1 / 1;}",
      "_a_6j000co7kt",
      "0,1,0 own",
      "235",
      12,
      false,
    )
  ];
  [@css
    (
      "._a_6j000cbz7i{grid-row:1 / -1;}",
      "_a_6j000cbz7i",
      "0,1,0 own",
      "235",
      12,
      false,
    )
  ];
  [@css
    (
      "._a_6j000cg6o0{grid-row:auto / auto;}",
      "_a_6j000cg6o0",
      "0,1,0 own",
      "235",
      12,
      false,
    )
  ];
  [@css
    (
      "._a_6j000c17bb{grid-row:2 / span 2;}",
      "_a_6j000c17bb",
      "0,1,0 own",
      "235",
      12,
      false,
    )
  ];
  [@css
    ("._a_6jx97r{grid-area:1 / 1;}", "_a_6jx97r", "0,1,0 own", "235", 15, false)
  ];
  [@css
    (
      "._a_6j8twa{grid-area:var(--area-a9otef);}",
      "_a_6j8twa",
      "0,1,0 own",
      "235",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_6jrmtw{grid-area:1 / span 1;}",
      "_a_6jrmtw",
      "0,1,0 own",
      "235",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_6j007a{grid-area:span 1 / 10 / -1;}",
      "_a_6j007a",
      "0,1,0 own",
      "235",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_6f0001t3cm{grid-column-gap:0;}",
      "_a_6f0001t3cm",
      "0,1,0 own",
      "231",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6f00011ss7{grid-column-gap:1em;}",
      "_a_6f00011ss7",
      "0,1,0 own",
      "231",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6f0002vwck{grid-row-gap:0;}",
      "_a_6f0002vwck",
      "0,1,0 own",
      "231",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_6f0002e9xb{grid-row-gap:1em;}",
      "_a_6f0002e9xb",
      "0,1,0 own",
      "231",
      2,
      false,
    )
  ];
  [@css
    ("._a_6fqgkd{grid-gap:0 0;}", "_a_6fqgkd", "0,1,0 own", "231", 3, false)
  ];
  [@css
    ("._a_6fqfdq{grid-gap:0 1em;}", "_a_6fqfdq", "0,1,0 own", "231", 3, false)
  ];
  [@css
    ("._a_6f22h1{grid-gap:1em;}", "_a_6f22h1", "0,1,0 own", "231", 3, false)
  ];
  [@css
    ("._a_6fizm2{grid-gap:1em 1em;}", "_a_6fizm2", "0,1,0 own", "231", 3, false)
  ];
  [@css
    (
      "._a_6i000gl3nx{grid-template-columns:subgrid;}",
      "_a_6i000gl3nx",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gktzg{grid-template-columns:subgrid [sub-a];}",
      "_a_6i000gktzg",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gqjfz{grid-template-columns:subgrid [sub-a] [sub-b];}",
      "_a_6i000gqjfz",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gecjn{grid-template-columns:subgrid repeat(1, [sub-a]);}",
      "_a_6i000gecjn",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000g17e0{grid-template-columns:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}",
      "_a_6i000g17e0",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000g93ua{grid-template-columns:subgrid repeat(auto-fill, [sub-a] [sub-b]);}",
      "_a_6i000g93ua",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gn4kv{grid-template-columns:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g]);}",
      "_a_6i000gn4kv",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000wdu2f{grid-template-rows:subgrid;}",
      "_a_6i000wdu2f",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i000wyyt1{grid-template-rows:subgrid [sub-a];}",
      "_a_6i000wyyt1",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i000wpgnt{grid-template-rows:subgrid [sub-a] [sub-b];}",
      "_a_6i000wpgnt",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i000w9v9m{grid-template-rows:subgrid repeat(1, [sub-a]);}",
      "_a_6i000w9v9m",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i000whys9{grid-template-rows:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}",
      "_a_6i000whys9",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i000wt659{grid-template-rows:subgrid repeat(auto-fill, [sub-a] [sub-b]);}",
      "_a_6i000wt659",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i000wwrvq{grid-template-rows:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g]);}",
      "_a_6i000wwrvq",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6i000go398{grid-template-columns:masonry;}",
      "_a_6i000go398",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000w4vh0{grid-template-rows:masonry;}",
      "_a_6i000w4vh0",
      "0,1,0 own",
      "234",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_80owej{masonry-auto-flow:pack;}",
      "_a_80owej",
      "0,1,0 own",
      "288",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_80wgmu{masonry-auto-flow:next;}",
      "_a_80wgmu",
      "0,1,0 own",
      "288",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_80tv39{masonry-auto-flow:definite-first;}",
      "_a_80tv39",
      "0,1,0 own",
      "288",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_80n96u{masonry-auto-flow:ordered;}",
      "_a_80n96u",
      "0,1,0 own",
      "288",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_80l2hz{masonry-auto-flow:pack definite-first;}",
      "_a_80l2hz",
      "0,1,0 own",
      "288",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_807ym7{masonry-auto-flow:pack ordered;}",
      "_a_807ym7",
      "0,1,0 own",
      "288",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_802buy{masonry-auto-flow:next definite-first;}",
      "_a_802buy",
      "0,1,0 own",
      "288",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_80w1v0{masonry-auto-flow:next ordered;}",
      "_a_80w1v0",
      "0,1,0 own",
      "288",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_804l3r{masonry-auto-flow:ordered pack;}",
      "_a_804l3r",
      "0,1,0 own",
      "288",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (2, "", [2]),
      (3, "", [3]),
      (4, "", [4]),
      (5, "", [5]),
      (6, "", [6]),
      (7, "", [7]),
      (8, "", [8]),
      (9, "", [9]),
      (11, "", [10]),
      (14, "", [11]),
      (16, "", [12]),
      (17, "", [13]),
      (19, "", [14]),
      (22, "", [15]),
      (25, "", [16]),
      (27, "", [17]),
      (29, "", [18]),
      (32, "", [19]),
      (36, "", [20]),
      (51, "", [21]),
      (52, "", [22]),
      (53, "", [23]),
      (54, "", [24]),
      (55, "", [25]),
      (56, "", [26]),
      (57, "", [27]),
      (58, "", [28]),
      (59, "", [29]),
      (61, "", [30]),
      (63, "", [31]),
      (64, "", [32]),
      (65, "", [33]),
      (66, "", [34]),
      (67, "", [35]),
      (68, "", [36]),
      (70, "", [37]),
      (72, "", [38]),
      (73, "", [39]),
      (74, "", [40]),
      (75, "", [41]),
      (76, "", [42]),
      (77, "", [43]),
      (78, "", [44]),
      (80, "", [45]),
      (82, "", [46]),
      (83, "", [47]),
      (84, "", [48]),
      (85, "", [49]),
      (86, "", [50]),
      (87, "", [51]),
      (88, "", [52]),
      (89, "", [53]),
      (91, "", [54]),
      (93, "", [55]),
      (94, "", [56]),
      (95, "", [57]),
      (96, "", [58]),
      (97, "", [59]),
      (98, "", [60]),
      (99, "", [61]),
      (100, "", [62]),
      (101, "", [63]),
      (102, "", [64]),
      (103, "", [65]),
      (104, "", [66]),
      (105, "", [67]),
      (106, "", [68]),
      (107, "", [69]),
      (108, "", [70]),
      (109, "", [71]),
      (110, "", [72]),
      (111, "", [73]),
      (112, "", [74]),
      (113, "", [75]),
      (114, "", [76]),
      (115, "", [77]),
      (116, "", [78]),
      (117, "", [79]),
      (118, "", [80]),
      (119, "", [81]),
      (120, "", [82]),
      (121, "", [83]),
      (122, "", [84]),
      (123, "", [85]),
      (124, "", [86]),
      (125, "", [87]),
      (126, "", [88]),
      (127, "", [89]),
      (128, "", [90]),
      (129, "", [91]),
      (130, "", [92]),
      (131, "", [93]),
      (132, "", [94]),
      (133, "", [95]),
      (134, "", [96]),
      (135, "", [97]),
      (136, "", [98]),
      (137, "", [99]),
      (138, "", [100]),
      (139, "", [101]),
      (140, "", [102]),
      (141, "", [103]),
      (143, "", [104]),
      (144, "", [105]),
      (145, "", [106]),
      (146, "", [107]),
      (147, "", [108]),
      (148, "", [109]),
      (149, "", [110]),
      (150, "", [111]),
      (151, "", [112]),
      (152, "", [113]),
      (153, "", [114]),
      (156, "", [115]),
      (157, "", [116]),
      (158, "", [117]),
      (159, "", [118]),
      (160, "", [119]),
      (161, "", [120]),
      (163, "", [121]),
      (165, "", [122]),
      (166, "", [123]),
      (167, "", [124]),
      (168, "", [125]),
      (169, "", [126]),
      (170, "", [127]),
      (172, "", [128]),
      (176, "", [129]),
      (177, "", [130]),
      (178, "", [131]),
      (179, "", [132]),
      (180, "", [133]),
      (181, "", [134]),
      (182, "", [135]),
      (183, "", [136]),
      (184, "", [137]),
      (185, "", [138]),
      (186, "", [139]),
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
