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
  [@css "@property --elevation1-xawwdw_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation1-xawwdw_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation1-xawwdw_3{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-vcr1i_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-vcr1i_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-vcr1i_3{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-pys9ag_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-pys9ag_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-pys9ag_3{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-pys9ag_4{syntax:\"*\";inherits:false;}"];
  [@css "@property --boxDark-17ffdav{syntax:\"*\";inherits:false;}"];
  [@css
    (
      "._a_39003kdbzm{background-repeat:space;}",
      "_a_39003kdbzm",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003kwgys{background-repeat:round;}",
      "_a_39003kwgys",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003kpiw6{background-repeat:repeat repeat;}",
      "_a_39003kpiw6",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003kxji5{background-repeat:space repeat;}",
      "_a_39003kxji5",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003k0kx7{background-repeat:round repeat;}",
      "_a_39003k0kx7",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003kqiir{background-repeat:no-repeat repeat;}",
      "_a_39003kqiir",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003kff62{background-repeat:repeat space;}",
      "_a_39003kff62",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003klrh1{background-repeat:space space;}",
      "_a_39003klrh1",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003kzuyd{background-repeat:round space;}",
      "_a_39003kzuyd",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003ko3tu{background-repeat:no-repeat space;}",
      "_a_39003ko3tu",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003k2l1t{background-repeat:repeat round;}",
      "_a_39003k2l1t",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003kpz8i{background-repeat:space round;}",
      "_a_39003kpz8i",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003kvp4f{background-repeat:round round;}",
      "_a_39003kvp4f",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003kttlz{background-repeat:no-repeat round;}",
      "_a_39003kttlz",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003k95y1{background-repeat:repeat no-repeat;}",
      "_a_39003k95y1",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003kyae4{background-repeat:space no-repeat;}",
      "_a_39003kyae4",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003khx0d{background-repeat:round no-repeat;}",
      "_a_39003khx0d",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003kr6kt{background-repeat:no-repeat no-repeat;}",
      "_a_39003kr6kt",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_39003kbp5t{background-repeat:repeat-x, repeat-y;}",
      "_a_39003kbp5t",
      "0,1,0 own",
      "117",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_390001p2j1{background-attachment:local;}",
      "_a_390001p2j1",
      "0,1,0 own",
      "117",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3900024kwg{-webkit-background-clip:border-box;background-clip:border-box;}",
      "_a_3900024kwg",
      "0,1,0 own",
      "117",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_3900025w5o{-webkit-background-clip:padding-box;background-clip:padding-box;}",
      "_a_3900025w5o",
      "0,1,0 own",
      "117",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_39000250rv{-webkit-background-clip:content-box;background-clip:content-box;}",
      "_a_39000250rv",
      "0,1,0 own",
      "117",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_3900028734{-webkit-background-clip:text;background-clip:text;}",
      "_a_3900028734",
      "0,1,0 own",
      "117",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_3900025rmj{-webkit-background-clip:border-area;background-clip:border-area;}",
      "_a_3900025rmj",
      "0,1,0 own",
      "117",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_39000245y6{-webkit-background-clip:text, border-area;background-clip:text, border-area;}",
      "_a_39000245y6",
      "0,1,0 own",
      "117",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_39000gkwyo{background-origin:border-box;}",
      "_a_39000gkwyo",
      "0,1,0 own",
      "117",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_39000gr9hb{background-origin:padding-box;}",
      "_a_39000gr9hb",
      "0,1,0 own",
      "117",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_39000gwo89{background-origin:content-box;}",
      "_a_39000gwo89",
      "0,1,0 own",
      "117",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3900744aob{background-size:auto;}",
      "_a_3900744aob",
      "0,1,0 own",
      "117",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_390074k97u{background-size:cover;}",
      "_a_390074k97u",
      "0,1,0 own",
      "117",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_390074xylo{background-size:contain;}",
      "_a_390074xylo",
      "0,1,0 own",
      "117",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_390074m5qu{background-size:10px;}",
      "_a_390074m5qu",
      "0,1,0 own",
      "117",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_390074u6v3{background-size:50%;}",
      "_a_390074u6v3",
      "0,1,0 own",
      "117",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_390074xytx{background-size:10px auto;}",
      "_a_390074xytx",
      "0,1,0 own",
      "117",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_390074a9zh{background-size:auto 10%;}",
      "_a_390074a9zh",
      "0,1,0 own",
      "117",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_3900744rix{background-size:50em 50%;}",
      "_a_3900744rix",
      "0,1,0 own",
      "117",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_390074zw1h{background-size:20px 20px;}",
      "_a_390074zw1h",
      "0,1,0 own",
      "117",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_39o254{background:top left / 50% 60%;}",
      "_a_39o254",
      "0,1,0 own",
      "117",
      511,
      false,
    )
  ];
  [@css
    (
      "._a_39vagn{background:border-box;}",
      "_a_39vagn",
      "0,1,0 own",
      "117",
      511,
      false,
    )
  ];
  [@css
    (
      "._a_392d75{background:blue;}",
      "_a_392d75",
      "0,1,0 own",
      "117",
      511,
      false,
    )
  ];
  [@css
    (
      "._a_39hvrj{background:border-box red;}",
      "_a_39hvrj",
      "0,1,0 own",
      "117",
      511,
      false,
    )
  ];
  [@css
    (
      "._a_39lssi{background:border-box padding-box;}",
      "_a_39lssi",
      "0,1,0 own",
      "117",
      511,
      false,
    )
  ];
  [@css
    (
      "._a_39uq7y{background:url(\"foo.png\") bottom right / cover padding-box content-box;}",
      "_a_39uq7y",
      "0,1,0 own",
      "117",
      511,
      false,
    )
  ];
  [@css
    (
      "._a_3n0004ffk7{border-top-left-radius:0;}",
      "_a_3n0004ffk7",
      "0,1,0 own",
      "131",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_3n0004y41g{border-top-left-radius:50%;}",
      "_a_3n0004y41g",
      "0,1,0 own",
      "131",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_3n0004ccvj{border-top-left-radius:250px 100px;}",
      "_a_3n0004ccvj",
      "0,1,0 own",
      "131",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_3n0008ozmz{border-top-right-radius:0;}",
      "_a_3n0008ozmz",
      "0,1,0 own",
      "131",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3n0008h6x9{border-top-right-radius:50%;}",
      "_a_3n0008h6x9",
      "0,1,0 own",
      "131",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3n00080ho1{border-top-right-radius:250px 100px;}",
      "_a_3n00080ho1",
      "0,1,0 own",
      "131",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3n0002m6su{border-bottom-right-radius:0;}",
      "_a_3n0002m6su",
      "0,1,0 own",
      "131",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_3n00025ugq{border-bottom-right-radius:50%;}",
      "_a_3n00025ugq",
      "0,1,0 own",
      "131",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_3n00028l07{border-bottom-right-radius:250px 100px;}",
      "_a_3n00028l07",
      "0,1,0 own",
      "131",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_3n0001vopp{border-bottom-left-radius:0;}",
      "_a_3n0001vopp",
      "0,1,0 own",
      "131",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3n0001z4ix{border-bottom-left-radius:50%;}",
      "_a_3n0001z4ix",
      "0,1,0 own",
      "131",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3n0001fj6a{border-bottom-left-radius:250px 100px;}",
      "_a_3n0001fj6a",
      "0,1,0 own",
      "131",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3nv389{border-radius:10px;}",
      "_a_3nv389",
      "0,1,0 own",
      "131",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_3ndor8{border-radius:50%;}",
      "_a_3ndor8",
      "0,1,0 own",
      "131",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_3nok9k{border-radius:2px 4px;}",
      "_a_3nok9k",
      "0,1,0 own",
      "131",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_3nl4dm{border-radius:2px 4px 8px;}",
      "_a_3nl4dm",
      "0,1,0 own",
      "131",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_3nbni5{border-radius:2px 4px 8px 16px;}",
      "_a_3nbni5",
      "0,1,0 own",
      "131",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_3nk2xe{border-radius:10px / 20px;}",
      "_a_3nk2xe",
      "0,1,0 own",
      "131",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_3n5w7s{border-radius:2px 4px 8px 16px / 2px 4px 8px 16px;}",
      "_a_3n5w7s",
      "0,1,0 own",
      "131",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_3h001s67n4{border-image-source:none;}",
      "_a_3h001s67n4",
      "0,1,0 own",
      "125",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_3h001s2djw{border-image-source:url(\"foo.png\");}",
      "_a_3h001s2djw",
      "0,1,0 own",
      "125",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_3h000w8fag{border-image-slice:10;}",
      "_a_3h000w8fag",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wou03{border-image-slice:30%;}",
      "_a_3h000wou03",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wp0ma{border-image-slice:10 10;}",
      "_a_3h000wp0ma",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wblsp{border-image-slice:30% 10;}",
      "_a_3h000wblsp",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000w5gxt{border-image-slice:10 30%;}",
      "_a_3h000w5gxt",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wpwt3{border-image-slice:30% 30%;}",
      "_a_3h000wpwt3",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wg3fs{border-image-slice:10 10 10;}",
      "_a_3h000wg3fs",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wb146{border-image-slice:30% 10 10;}",
      "_a_3h000wb146",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wyk9k{border-image-slice:10 30% 10;}",
      "_a_3h000wyk9k",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wdy38{border-image-slice:30% 30% 10;}",
      "_a_3h000wdy38",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wfa9m{border-image-slice:10 10 30%;}",
      "_a_3h000wfa9m",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wz16p{border-image-slice:30% 10 30%;}",
      "_a_3h000wz16p",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000w8zfs{border-image-slice:10 30% 30%;}",
      "_a_3h000w8zfs",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wuel6{border-image-slice:30% 30% 30%;}",
      "_a_3h000wuel6",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000w27b9{border-image-slice:10 10 10 10;}",
      "_a_3h000w27b9",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wciru{border-image-slice:30% 10 10 10;}",
      "_a_3h000wciru",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wj984{border-image-slice:10 30% 10 10;}",
      "_a_3h000wj984",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000weygg{border-image-slice:30% 30% 10 10;}",
      "_a_3h000weygg",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wu8vs{border-image-slice:10 10 30% 10;}",
      "_a_3h000wu8vs",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000w4ctj{border-image-slice:30% 10 30% 10;}",
      "_a_3h000w4ctj",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wrqu8{border-image-slice:10 30% 30% 10;}",
      "_a_3h000wrqu8",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000w535k{border-image-slice:30% 30% 30% 10;}",
      "_a_3h000w535k",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wmqly{border-image-slice:10 10 10 30%;}",
      "_a_3h000wmqly",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000w334v{border-image-slice:30% 10 10 30%;}",
      "_a_3h000w334v",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000w10it{border-image-slice:10 30% 10 30%;}",
      "_a_3h000w10it",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000w24bv{border-image-slice:30% 30% 10 30%;}",
      "_a_3h000w24bv",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000woopq{border-image-slice:10 10 30% 30%;}",
      "_a_3h000woopq",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wc6k6{border-image-slice:30% 10 30% 30%;}",
      "_a_3h000wc6k6",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wce7t{border-image-slice:10 30% 30% 30%;}",
      "_a_3h000wce7t",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000w3xq3{border-image-slice:30% 30% 30% 30%;}",
      "_a_3h000w3xq3",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wpp7o{border-image-slice:fill 30%;}",
      "_a_3h000wpp7o",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wsoql{border-image-slice:fill 10;}",
      "_a_3h000wsoql",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wljby{border-image-slice:fill 2 4 8% 16%;}",
      "_a_3h000wljby",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wb5be{border-image-slice:30% fill;}",
      "_a_3h000wb5be",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wse3r{border-image-slice:10 fill;}",
      "_a_3h000wse3r",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h000wst01{border-image-slice:2 4 8% 16% fill;}",
      "_a_3h000wst01",
      "0,1,0 own",
      "125",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_3h003kmtq7{border-image-width:10px;}",
      "_a_3h003kmtq7",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003k2lna{border-image-width:5%;}",
      "_a_3h003k2lna",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003kvskx{border-image-width:28;}",
      "_a_3h003kvskx",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003k12to{border-image-width:auto;}",
      "_a_3h003k12to",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003kqzt3{border-image-width:10px 10px;}",
      "_a_3h003kqzt3",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003k1b9l{border-image-width:5% 10px;}",
      "_a_3h003k1b9l",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003ka5d6{border-image-width:28 10px;}",
      "_a_3h003ka5d6",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003kgsb5{border-image-width:auto 10px;}",
      "_a_3h003kgsb5",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003ktfkm{border-image-width:10px 5%;}",
      "_a_3h003ktfkm",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003kfrk8{border-image-width:5% 5%;}",
      "_a_3h003kfrk8",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003ksgtx{border-image-width:28 5%;}",
      "_a_3h003ksgtx",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003ko8wy{border-image-width:auto 5%;}",
      "_a_3h003ko8wy",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003kyjgi{border-image-width:10px 28;}",
      "_a_3h003kyjgi",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003k05n6{border-image-width:5% 28;}",
      "_a_3h003k05n6",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003kpian{border-image-width:28 28;}",
      "_a_3h003kpian",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003k7o1w{border-image-width:auto 28;}",
      "_a_3h003k7o1w",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003kbki1{border-image-width:10px auto;}",
      "_a_3h003kbki1",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003ksfme{border-image-width:5% auto;}",
      "_a_3h003ksfme",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003klhmj{border-image-width:28 auto;}",
      "_a_3h003klhmj",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003kiwnw{border-image-width:auto auto;}",
      "_a_3h003kiwnw",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003k1i6r{border-image-width:10px 10% 10;}",
      "_a_3h003k1i6r",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h003k03j7{border-image-width:5% 10px 20 auto;}",
      "_a_3h003k03j7",
      "0,1,0 own",
      "125",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_3h0008lw5x{border-image-outset:10px;}",
      "_a_3h0008lw5x",
      "0,1,0 own",
      "125",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3h0008x2bn{border-image-outset:20;}",
      "_a_3h0008x2bn",
      "0,1,0 own",
      "125",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3h0008jka5{border-image-outset:10px 20;}",
      "_a_3h0008jka5",
      "0,1,0 own",
      "125",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3h0008v07i{border-image-outset:10px 20px;}",
      "_a_3h0008v07i",
      "0,1,0 own",
      "125",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3h0008ixn9{border-image-outset:20 30;}",
      "_a_3h0008ixn9",
      "0,1,0 own",
      "125",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3h00083q5z{border-image-outset:2px 3px 4;}",
      "_a_3h00083q5z",
      "0,1,0 own",
      "125",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3h0008dhma{border-image-outset:1 2px 3px 4;}",
      "_a_3h0008dhma",
      "0,1,0 own",
      "125",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3h000g8amr{border-image-repeat:stretch;}",
      "_a_3h000g8amr",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000gvfhi{border-image-repeat:repeat;}",
      "_a_3h000gvfhi",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000gsbb7{border-image-repeat:round;}",
      "_a_3h000gsbb7",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000gfada{border-image-repeat:space;}",
      "_a_3h000gfada",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000g930f{border-image-repeat:stretch stretch;}",
      "_a_3h000g930f",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000gipsj{border-image-repeat:repeat stretch;}",
      "_a_3h000gipsj",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000gh3hn{border-image-repeat:round stretch;}",
      "_a_3h000gh3hn",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000g3d92{border-image-repeat:space stretch;}",
      "_a_3h000g3d92",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000g5f3q{border-image-repeat:stretch repeat;}",
      "_a_3h000g5f3q",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000gdrj5{border-image-repeat:repeat repeat;}",
      "_a_3h000gdrj5",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000g6kfj{border-image-repeat:round repeat;}",
      "_a_3h000g6kfj",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000gahlj{border-image-repeat:space repeat;}",
      "_a_3h000gahlj",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000gd86l{border-image-repeat:stretch round;}",
      "_a_3h000gd86l",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000g5ktc{border-image-repeat:repeat round;}",
      "_a_3h000g5ktc",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000gllwt{border-image-repeat:round round;}",
      "_a_3h000gllwt",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000geu9k{border-image-repeat:space round;}",
      "_a_3h000geu9k",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000gorbo{border-image-repeat:stretch space;}",
      "_a_3h000gorbo",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000gcpic{border-image-repeat:repeat space;}",
      "_a_3h000gcpic",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000g2bpm{border-image-repeat:round space;}",
      "_a_3h000g2bpm",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h000giv0g{border-image-repeat:space space;}",
      "_a_3h000giv0g",
      "0,1,0 own",
      "125",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_3h006wl0e3{border-image:url(\"foo.png\") 10;}",
      "_a_3h006wl0e3",
      "0,1,0 own",
      "125",
      248,
      false,
    )
  ];
  [@css
    (
      "._a_3h006wc16s{border-image:url(\"foo.png\") 10%;}",
      "_a_3h006wc16s",
      "0,1,0 own",
      "125",
      248,
      false,
    )
  ];
  [@css
    (
      "._a_3h006wk48c{border-image:url(\"foo.png\") 10% fill;}",
      "_a_3h006wk48c",
      "0,1,0 own",
      "125",
      248,
      false,
    )
  ];
  [@css
    (
      "._a_3h006wndfl{border-image:url(\"foo.png\") 10 round;}",
      "_a_3h006wndfl",
      "0,1,0 own",
      "125",
      248,
      false,
    )
  ];
  [@css
    (
      "._a_3h006woh1n{border-image:url(\"foo.png\") 10 stretch repeat;}",
      "_a_3h006woh1n",
      "0,1,0 own",
      "125",
      248,
      false,
    )
  ];
  [@css
    (
      "._a_3h006wvdj4{border-image:url(\"foo.png\") 10 / 10px;}",
      "_a_3h006wvdj4",
      "0,1,0 own",
      "125",
      248,
      false,
    )
  ];
  [@css
    (
      "._a_3h006wx17x{border-image:url(\"foo.png\") 10 / 10% / 10px;}",
      "_a_3h006wx17x",
      "0,1,0 own",
      "125",
      248,
      false,
    )
  ];
  [@css
    (
      "._a_3h006wzcfy{border-image:url(\"foo.png\") fill 10 / 10% / 10px;}",
      "_a_3h006wzcfy",
      "0,1,0 own",
      "125",
      248,
      false,
    )
  ];
  [@css
    (
      "._a_3h006w30nn{border-image:url(\"foo.png\") fill 10 / 10% / 10px space;}",
      "_a_3h006w30nn",
      "0,1,0 own",
      "125",
      248,
      false,
    )
  ];
  [@css
    ("._a_40keqi{box-shadow:none;}", "_a_40keqi", "0,1,0 own", "144", 1, false)
  ];
  [@css
    (
      "._a_40ye8k{box-shadow:1px 1px;}",
      "_a_40ye8k",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_40r8u1{box-shadow:0 0 black;}",
      "_a_40r8u1",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_40uemi{box-shadow:1px 2px 3px;}",
      "_a_40uemi",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_40mflx{box-shadow:1px 2px 3px black;}",
      "_a_40mflx",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4056p9{box-shadow:1px 2px 3px 4px;}",
      "_a_4056p9",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_40xcnx{box-shadow:1px 2px 3px 4px black;}",
      "_a_40xcnx",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_40ios5{box-shadow:inset 1px 1px;}",
      "_a_40ios5",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_405tpn{box-shadow:inset 0 0 black;}",
      "_a_405tpn",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_40izzs{box-shadow:inset 1px 2px 3px;}",
      "_a_40izzs",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_40yjsg{box-shadow:inset 1px 2px 3px black;}",
      "_a_40yjsg",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_40khnb{box-shadow:inset 1px 2px 3px 4px;}",
      "_a_40khnb",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_403f6l{box-shadow:inset 1px 2px 3px 4px black;}",
      "_a_403f6l",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_40otsx{box-shadow:inset 1px 2px 3px 4px black, 1px 2px 3px 4px black;}",
      "_a_40otsx",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4085p6{box-shadow:1px 1px, inset 2px 2px red;}",
      "_a_4085p6",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_40q314{box-shadow:0 0 5px, inset 0 0 10px black;}",
      "_a_40q314",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_400xa4{box-shadow:-1px 1px 0px 0px var(--elevation1-xawwdw_1), 1px 1px 0px 0px var(--elevation1-xawwdw_2), 0px -1px 0px 0px var(--elevation1-xawwdw_3);}",
      "_a_400xa4",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_39000w2nfr{background-position-x:right;}",
      "_a_39000w2nfr",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000wvq06{background-position-x:center;}",
      "_a_39000wvq06",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000wcezg{background-position-x:50%;}",
      "_a_39000wcezg",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000we8x4{background-position-x:left, left;}",
      "_a_39000we8x4",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000wem91{background-position-x:left, right;}",
      "_a_39000wem91",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000w9h4p{background-position-x:right, left;}",
      "_a_39000w9h4p",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000wz26j{background-position-x:left, 0%;}",
      "_a_39000wz26j",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000wbcib{background-position-x:10%, 20%, 40%;}",
      "_a_39000wbcib",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000wehso{background-position-x:0px;}",
      "_a_39000wehso",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000wvpvo{background-position-x:30px;}",
      "_a_39000wvpvo",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000wjlye{background-position-x:0%, 10%, 20%, 30%;}",
      "_a_39000wjlye",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000wuvjq{background-position-x:left, left, left, left, left;}",
      "_a_39000wuvjq",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000w1f37{background-position-x:calc(20px);}",
      "_a_39000w1f37",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000w1ldt{background-position-x:calc(20px + 1em);}",
      "_a_39000w1ldt",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000ww4iu{background-position-x:calc(20px / 2);}",
      "_a_39000ww4iu",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000wk1yt{background-position-x:calc(20px + 50%);}",
      "_a_39000wk1yt",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000w363d{background-position-x:calc(50% - 10px);}",
      "_a_39000w363d",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000w78wf{background-position-x:calc(-20px);}",
      "_a_39000w78wf",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000wryx3{background-position-x:calc(-50%);}",
      "_a_39000wryx3",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000wbe59{background-position-x:calc(-20%);}",
      "_a_39000wbe59",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000w7w9s{background-position-x:right 20px;}",
      "_a_39000w7w9s",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000w8n01{background-position-x:left 20px;}",
      "_a_39000w8n01",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000wf6oz{background-position-x:right -50px;}",
      "_a_39000wf6oz",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39000wata8{background-position-x:left -50px;}",
      "_a_39000wata8",
      "0,1,0 own",
      "117",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_39001sxup1{background-position-y:bottom;}",
      "_a_39001sxup1",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001s9ewh{background-position-y:center;}",
      "_a_39001s9ewh",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001shsum{background-position-y:50%;}",
      "_a_39001shsum",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001s04xu{background-position-y:top, top;}",
      "_a_39001s04xu",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001sqqtz{background-position-y:top, bottom;}",
      "_a_39001sqqtz",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001s54xk{background-position-y:bottom, top;}",
      "_a_39001s54xk",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001s7d2k{background-position-y:top, 0%;}",
      "_a_39001s7d2k",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001s93ok{background-position-y:10%, 20%, 40%;}",
      "_a_39001s93ok",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001scs51{background-position-y:0px;}",
      "_a_39001scs51",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001s2wtl{background-position-y:30px;}",
      "_a_39001s2wtl",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001sd3sd{background-position-y:0%, 10%, 20%, 30%;}",
      "_a_39001sd3sd",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001sfv8k{background-position-y:top, top, top, top, top;}",
      "_a_39001sfv8k",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001s2yw6{background-position-y:calc(20px);}",
      "_a_39001s2yw6",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001spdqz{background-position-y:calc(20px + 1em);}",
      "_a_39001spdqz",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001s8w9h{background-position-y:calc(20px / 2);}",
      "_a_39001s8w9h",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001skkb2{background-position-y:calc(20px + 50%);}",
      "_a_39001skkb2",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001sdt8x{background-position-y:calc(50% - 10px);}",
      "_a_39001sdt8x",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001sc0ip{background-position-y:calc(-20px);}",
      "_a_39001sc0ip",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001sckm0{background-position-y:calc(-50%);}",
      "_a_39001sckm0",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001sw002{background-position-y:calc(-20%);}",
      "_a_39001sw002",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001sz8v2{background-position-y:bottom 20px;}",
      "_a_39001sz8v2",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001s2qfz{background-position-y:top 20px;}",
      "_a_39001s2qfz",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001smhad{background-position-y:bottom -50px;}",
      "_a_39001smhad",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39001s0o43{background-position-y:top -50px;}",
      "_a_39001s0o43",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_390008hz2r{background-image:linear-gradient(45deg, blue, red);}",
      "_a_390008hz2r",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008qfjp{background-image:linear-gradient(90deg, blue 10%, red 20%);}",
      "_a_390008qfjp",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008ab29{background-image:linear-gradient(90deg, blue 10%, red);}",
      "_a_390008ab29",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3900081u4d{background-image:linear-gradient(90deg, blue, 10%, red);}",
      "_a_3900081u4d",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008uss4{background-image:linear-gradient(white, black);}",
      "_a_390008uss4",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008n2r8{background-image:linear-gradient(to right, white, black);}",
      "_a_390008n2r8",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008ys2x{background-image:linear-gradient(45deg, white, black);}",
      "_a_390008ys2x",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008ojtb{background-image:linear-gradient(white 50%, black);}",
      "_a_390008ojtb",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3900080xs1{background-image:linear-gradient(white, #f06, black);}",
      "_a_3900080xs1",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008yimv{background-image:linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);}",
      "_a_390008yimv",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008fmes{background-image:linear-gradient(45deg, blue, red), linear-gradient(red -50px, white calc(-25px + 50%), blue 100%), linear-gradient(45deg, blue, red);}",
      "_a_390008fmes",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_39000838s1{background-image:linear-gradient(45deg, var(--color-vcr1i_1) 25%, transparent 0%, transparent 50%, var(--color-vcr1i_2) 0%, var(--color-vcr1i_3) 75%, transparent 0%, transparent 100% );}",
      "_a_39000838s1",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008tv7y{background-image:repeating-linear-gradient( 45deg, var(--color-pys9ag_1) 0px, var(--color-pys9ag_2) 4px, var(--color-pys9ag_3) 5px, var(--color-pys9ag_4) 9px );}",
      "_a_390008tv7y",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008igxz{background-image:linear-gradient(45deg, var(--boxDark-17ffdav) 25%, transparent 25%), linear-gradient(red -50px, white calc(-25px + 50%), blue 100%), linear-gradient(45deg, blue, red);}",
      "_a_390008igxz",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008fodl{background-image:radial-gradient(white, black);}",
      "_a_390008fodl",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3900085i1d{background-image:radial-gradient(circle, white, black);}",
      "_a_3900085i1d",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3900085rni{background-image:radial-gradient(ellipse, white, black);}",
      "_a_3900085rni",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008nqg5{background-image:radial-gradient(circle closest-corner, white, black);}",
      "_a_390008nqg5",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008dzbz{background-image:radial-gradient(farthest-side, white, black);}",
      "_a_390008dzbz",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3900081b7p{background-image:radial-gradient(circle farthest-side, white, black);}",
      "_a_3900081b7p",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008fl0e{background-image:radial-gradient(50%, white, black);}",
      "_a_390008fl0e",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3900085uiv{background-image:radial-gradient(60% 60%, white, black);}",
      "_a_3900085uiv",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_7o0001ird3{list-style-image:linear-gradient(white, black);}",
      "_a_7o0001ird3",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o0001eq2u{list-style-image:linear-gradient(to right, white, black);}",
      "_a_7o0001eq2u",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o00017x4a{list-style-image:linear-gradient(45deg, white, black);}",
      "_a_7o00017x4a",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o0001kxhc{list-style-image:linear-gradient(white 50%, black);}",
      "_a_7o0001kxhc",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o000174rj{list-style-image:linear-gradient(white 5px, black);}",
      "_a_7o000174rj",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o0001c0fc{list-style-image:linear-gradient(white, #f06, black);}",
      "_a_7o0001c0fc",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o0001ualz{list-style-image:linear-gradient(currentColor, black);}",
      "_a_7o0001ualz",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o00018cv6{list-style-image:linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);}",
      "_a_7o00018cv6",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o00017vp0{list-style-image:radial-gradient(white, black);}",
      "_a_7o00017vp0",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o0001kg5x{list-style-image:radial-gradient(circle, white, black);}",
      "_a_7o0001kg5x",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o000142dq{list-style-image:radial-gradient(ellipse, white, black);}",
      "_a_7o000142dq",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o0001ouy8{list-style-image:radial-gradient(closest-corner, white, black);}",
      "_a_7o0001ouy8",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o0001zi1j{list-style-image:radial-gradient(circle closest-corner, white, black);}",
      "_a_7o0001zi1j",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o0001bp18{list-style-image:radial-gradient(farthest-side, white, black);}",
      "_a_7o0001bp18",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o0001bl3b{list-style-image:radial-gradient(circle farthest-side, white, black);}",
      "_a_7o0001bl3b",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o00010ihr{list-style-image:radial-gradient(50%, white, black);}",
      "_a_7o00010ihr",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7o00018tou{list-style-image:radial-gradient(60% 60%, white, black);}",
      "_a_7o00018tou",
      "0,1,0 own",
      "276",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6tobub{image-rendering:auto;}",
      "_a_6tobub",
      "0,1,0 own",
      "245",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6t7xqd{image-rendering:smooth;}",
      "_a_6t7xqd",
      "0,1,0 own",
      "245",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6tt5e9{image-rendering:high-quality;}",
      "_a_6tt5e9",
      "0,1,0 own",
      "245",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6thmlf{image-rendering:pixelated;}",
      "_a_6thmlf",
      "0,1,0 own",
      "245",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6tm01f{image-rendering:crisp-edges;}",
      "_a_6tm01f",
      "0,1,0 own",
      "245",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_39002oylgn{background-position:bottom;}",
      "_a_39002oylgn",
      "0,1,0 own",
      "117",
      96,
      false,
    )
  ];
  [@css
    (
      "._a_39001sniqy{background-position-y:0;}",
      "_a_39001sniqy",
      "0,1,0 own",
      "117",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_39002oueyu{background-position:0 0;}",
      "_a_39002oueyu",
      "0,1,0 own",
      "117",
      96,
      false,
    )
  ];
  [@css
    (
      "._a_39002o3hnb{background-position:1rem 0;}",
      "_a_39002o3hnb",
      "0,1,0 own",
      "117",
      96,
      false,
    )
  ];
  [@css
    (
      "._a_39002odqt2{background-position:bottom 10px right;}",
      "_a_39002odqt2",
      "0,1,0 own",
      "117",
      96,
      false,
    )
  ];
  [@css
    (
      "._a_39002oz38j{background-position:bottom 10px right 20px;}",
      "_a_39002oz38j",
      "0,1,0 own",
      "117",
      96,
      false,
    )
  ];
  [@css
    (
      "._a_39002on9c9{background-position:0 0, center;}",
      "_a_39002on9c9",
      "0,1,0 own",
      "117",
      96,
      false,
    )
  ];
  [@css
    (
      "._a_8jqhry{object-position:top;}",
      "_a_8jqhry",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8ju2x3{object-position:bottom;}",
      "_a_8ju2x3",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8jx73u{object-position:left;}",
      "_a_8jx73u",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8jcm6t{object-position:right;}",
      "_a_8jcm6t",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8jlpb4{object-position:center;}",
      "_a_8jlpb4",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8jh0g1{object-position:25% 75%;}",
      "_a_8jh0g1",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8jlnwd{object-position:25%;}",
      "_a_8jlnwd",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8j0ddq{object-position:0 0;}",
      "_a_8j0ddq",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8jopaa{object-position:1cm 2cm;}",
      "_a_8jopaa",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8jenxt{object-position:10ch 8em;}",
      "_a_8jenxt",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8jase9{object-position:bottom 10px right 20px;}",
      "_a_8jase9",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8jana2{object-position:right 3em bottom 10px;}",
      "_a_8jana2",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8j11ag{object-position:top 0 right 10px;}",
      "_a_8j11ag",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8jhhjc{object-position:inherit;}",
      "_a_8jhhjc",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8jj4w6{object-position:initial;}",
      "_a_8jj4w6",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8j6ns1{object-position:revert;}",
      "_a_8j6ns1",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8jjpx4{object-position:revert-layer;}",
      "_a_8jjpx4",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8j4k9o{object-position:unset;}",
      "_a_8j4k9o",
      "0,1,0 own",
      "307",
      1,
      false,
    )
  ];
  [@css
    "@keyframes _k_1b5h4ts{0%{background-position:0 0;}100%{background-position:1rem 0;}}"
  ];
  [@css.blocks
    [
      (11, "", [11]),
      (12, "", [12]),
      (13, "", [13]),
      (14, "", [14]),
      (15, "", [15]),
      (16, "", [16]),
      (17, "", [17]),
      (18, "", [18]),
      (19, "", [19]),
      (20, "", [20]),
      (21, "", [21]),
      (22, "", [22]),
      (23, "", [23]),
      (24, "", [24]),
      (25, "", [25]),
      (26, "", [26]),
      (27, "", [27]),
      (28, "", [28]),
      (29, "", [29]),
      (30, "", [30]),
      (31, "", [31]),
      (32, "", [32]),
      (33, "", [33]),
      (34, "", [34]),
      (35, "", [35]),
      (36, "", [36]),
      (37, "", [37]),
      (38, "", [38]),
      (39, "", [39]),
      (40, "", [40]),
      (41, "", [41]),
      (42, "", [42]),
      (43, "", [43]),
      (44, "", [44]),
      (45, "", [45]),
      (46, "", [46]),
      (47, "", [47]),
      (48, "", [48]),
      (50, "", [49]),
      (51, "", [50]),
      (52, "", [51]),
      (53, "", [52]),
      (55, "", [53]),
      (57, "", [54]),
      (59, "", [55]),
      (60, "", [56]),
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
      (77, "", [73]),
      (78, "", [74]),
      (79, "", [75]),
      (80, "", [76]),
      (81, "", [77]),
      (82, "", [78]),
      (83, "", [79]),
      (84, "", [80]),
      (85, "", [81]),
      (86, "", [82]),
      (87, "", [83]),
      (88, "", [84]),
      (89, "", [85]),
      (90, "", [86]),
      (91, "", [87]),
      (92, "", [88]),
      (93, "", [89]),
      (94, "", [90]),
      (95, "", [91]),
      (96, "", [92]),
      (97, "", [93]),
      (98, "", [94]),
      (99, "", [95]),
      (100, "", [96]),
      (101, "", [97]),
      (102, "", [98]),
      (103, "", [99]),
      (104, "", [100]),
      (105, "", [101]),
      (106, "", [102]),
      (107, "", [103]),
      (108, "", [104]),
      (109, "", [105]),
      (110, "", [106]),
      (111, "", [107]),
      (112, "", [108]),
      (113, "", [109]),
      (114, "", [110]),
      (115, "", [111]),
      (116, "", [112]),
      (117, "", [113]),
      (118, "", [114]),
      (119, "", [115]),
      (120, "", [116]),
      (121, "", [117]),
      (122, "", [118]),
      (123, "", [119]),
      (124, "", [120]),
      (125, "", [121]),
      (126, "", [122]),
      (127, "", [123]),
      (128, "", [124]),
      (129, "", [125]),
      (130, "", [126]),
      (131, "", [127]),
      (132, "", [128]),
      (133, "", [129]),
      (134, "", [130]),
      (135, "", [131]),
      (136, "", [132]),
      (137, "", [133]),
      (138, "", [134]),
      (139, "", [135]),
      (140, "", [136]),
      (141, "", [137]),
      (142, "", [138]),
      (143, "", [139]),
      (144, "", [140]),
      (145, "", [141]),
      (146, "", [142]),
      (147, "", [143]),
      (148, "", [144]),
      (149, "", [145]),
      (150, "", [146]),
      (151, "", [147]),
      (152, "", [148]),
      (153, "", [149]),
      (154, "", [150]),
      (155, "", [151]),
      (156, "", [152]),
      (157, "", [153]),
      (158, "", [154]),
      (159, "", [155]),
      (160, "", [156]),
      (161, "", [157]),
      (162, "", [158]),
      (163, "", [159]),
      (164, "", [160]),
      (165, "", [161]),
      (166, "", [162]),
      (167, "", [163]),
      (168, "", [164]),
      (169, "", [165]),
      (170, "", [166]),
      (171, "", [167]),
      (172, "", [168]),
      (173, "", [169]),
      (176, "", [170]),
      (179, "", [171]),
      (181, "", [172]),
      (183, "", [173]),
      (185, "", [174]),
      (187, "", [175]),
      (189, "", [176]),
      (192, "", [177]),
      (194, "", [178]),
      (196, "", [179]),
      (198, "", [180]),
      (200, "", [181]),
      (202, "", [182]),
      (204, "", [183]),
      (205, "", [184]),
      (206, "", [185]),
      (208, "", [186]),
      (214, "", [187]),
      (215, "", [188]),
      (216, "", [189]),
      (217, "", [190]),
      (218, "", [191]),
      (219, "", [192]),
      (220, "", [193]),
      (221, "", [194]),
      (222, "", [195]),
      (223, "", [196]),
      (224, "", [197]),
      (225, "", [198]),
      (226, "", [199]),
      (227, "", [200]),
      (228, "", [201]),
      (229, "", [202]),
      (230, "", [203]),
      (231, "", [204]),
      (232, "", [205]),
      (233, "", [206]),
      (234, "", [207]),
      (235, "", [208]),
      (236, "", [209]),
      (237, "", [210]),
      (238, "", [207]),
      (239, "", [211]),
      (240, "", [212]),
      (241, "", [213]),
      (242, "", [214]),
      (243, "", [215]),
      (244, "", [216]),
      (245, "", [217]),
      (246, "", [218]),
      (247, "", [219]),
      (248, "", [220]),
      (249, "", [221]),
      (250, "", [222]),
      (251, "", [223]),
      (252, "", [224]),
      (253, "", [225]),
      (254, "", [226]),
      (255, "", [227]),
      (256, "", [228]),
      (257, "", [229]),
      (258, "", [230]),
      (259, "", [231]),
      (260, "", [232]),
      (261, "", [233]),
      (262, "", [234]),
      (263, "", [231]),
      (266, "", [235]),
      (267, "", [236]),
      (268, "", [237]),
      (269, "", [238]),
      (270, "", [239]),
      (271, "", [240]),
      (272, "", [241]),
      (273, "", [242]),
      (274, "", [243]),
      (276, "", [244]),
      (279, "", [245]),
      (288, "", [246]),
      (302, "", [247]),
      (315, "", [248]),
      (326, "", [249]),
      (327, "", [250]),
      (328, "", [251]),
      (330, "", [252]),
      (332, "", [253]),
      (334, "", [254]),
      (336, "", [255]),
      (337, "", [256]),
      (340, "", [257]),
      (341, "", [258]),
      (342, "", [259]),
      (343, "", [260]),
      (344, "", [261]),
      (345, "", [262]),
      (346, "", [263]),
      (348, "", [264]),
      (350, "", [265]),
      (351, "", [266]),
      (352, "", [267]),
      (353, "", [268]),
      (355, "", [269]),
      (357, "", [270]),
      (359, "", [271]),
      (361, "", [272]),
      (362, "", [273]),
      (384, "", [274]),
      (385, "", [275]),
      (386, "", [276]),
      (387, "", [277]),
      (388, "", [278]),
      (428, "", [279]),
      (429, "", [189]),
      (430, "", [280]),
      (431, "", [281]),
      (432, "", [282]),
      (433, "", [283]),
      (434, "", [284]),
      (435, "", [285]),
      (438, "", [286]),
      (439, "", [287]),
      (440, "", [288]),
      (441, "", [289]),
      (442, "", [290]),
      (444, "", [291]),
      (445, "", [292]),
      (447, "", [293]),
      (448, "", [294]),
      (449, "", [295]),
      (451, "", [296]),
      (452, "", [297]),
      (453, "", [298]),
      (455, "", [299]),
      (456, "", [300]),
      (457, "", [301]),
      (458, "", [302]),
      (459, "", [303]),
    ]
  ];
  module Color = {
    module Background = {
      let boxDark = `hex("000000");
    };
    module Shadow = {
      let elevation1 = `rgba((0, 0, 0, `num(0.03)));
    };
  };
  
  CSS.make("_a_39003kdbzm", []);
  CSS.make("_a_39003kwgys", []);
  CSS.make("_a_39003kpiw6", []);
  CSS.make("_a_39003kxji5", []);
  CSS.make("_a_39003k0kx7", []);
  CSS.make("_a_39003kqiir", []);
  CSS.make("_a_39003kff62", []);
  CSS.make("_a_39003klrh1", []);
  CSS.make("_a_39003kzuyd", []);
  CSS.make("_a_39003ko3tu", []);
  CSS.make("_a_39003k2l1t", []);
  CSS.make("_a_39003kpz8i", []);
  CSS.make("_a_39003kvp4f", []);
  CSS.make("_a_39003kttlz", []);
  CSS.make("_a_39003k95y1", []);
  CSS.make("_a_39003kyae4", []);
  CSS.make("_a_39003khx0d", []);
  CSS.make("_a_39003kr6kt", []);
  CSS.make("_a_39003kbp5t", []);
  CSS.make("_a_390001p2j1", []);
  CSS.make("_a_3900024kwg", []);
  CSS.make("_a_3900025w5o", []);
  CSS.make("_a_39000250rv", []);
  CSS.make("_a_3900028734", []);
  CSS.make("_a_3900025rmj", []);
  CSS.make("_a_39000245y6", []);
  CSS.make("_a_39000gkwyo", []);
  CSS.make("_a_39000gr9hb", []);
  CSS.make("_a_39000gwo89", []);
  CSS.make("_a_3900744aob", []);
  CSS.make("_a_390074k97u", []);
  CSS.make("_a_390074xylo", []);
  CSS.make("_a_390074m5qu", []);
  CSS.make("_a_390074u6v3", []);
  CSS.make("_a_390074xytx", []);
  CSS.make("_a_390074a9zh", []);
  CSS.make("_a_3900744rix", []);
  CSS.make("_a_390074zw1h", []);
  
  CSS.make("_a_39o254", []);
  CSS.make("_a_39vagn", []);
  CSS.make("_a_392d75", []);
  CSS.make("_a_39hvrj", []);
  
  CSS.make("_a_39lssi", []);
  CSS.make("_a_39uq7y", []);
  CSS.make("_a_3n0004ffk7", []);
  CSS.make("_a_3n0004y41g", []);
  CSS.make("_a_3n0004ccvj", []);
  CSS.make("_a_3n0008ozmz", []);
  CSS.make("_a_3n0008h6x9", []);
  CSS.make("_a_3n00080ho1", []);
  CSS.make("_a_3n0002m6su", []);
  CSS.make("_a_3n00025ugq", []);
  CSS.make("_a_3n00028l07", []);
  CSS.make("_a_3n0001vopp", []);
  CSS.make("_a_3n0001z4ix", []);
  CSS.make("_a_3n0001fj6a", []);
  CSS.make("_a_3nv389", []);
  CSS.make("_a_3ndor8", []);
  CSS.make("_a_3nok9k", []);
  CSS.make("_a_3nl4dm", []);
  CSS.make("_a_3nbni5", []);
  CSS.make("_a_3nk2xe", []);
  CSS.make("_a_3n5w7s", []);
  CSS.make("_a_3h001s67n4", []);
  CSS.make("_a_3h001s2djw", []);
  CSS.make("_a_3h000w8fag", []);
  CSS.make("_a_3h000wou03", []);
  CSS.make("_a_3h000wp0ma", []);
  CSS.make("_a_3h000wblsp", []);
  CSS.make("_a_3h000w5gxt", []);
  CSS.make("_a_3h000wpwt3", []);
  CSS.make("_a_3h000wg3fs", []);
  CSS.make("_a_3h000wb146", []);
  CSS.make("_a_3h000wyk9k", []);
  CSS.make("_a_3h000wdy38", []);
  CSS.make("_a_3h000wfa9m", []);
  CSS.make("_a_3h000wz16p", []);
  CSS.make("_a_3h000w8zfs", []);
  CSS.make("_a_3h000wuel6", []);
  CSS.make("_a_3h000w27b9", []);
  CSS.make("_a_3h000wciru", []);
  CSS.make("_a_3h000wj984", []);
  CSS.make("_a_3h000weygg", []);
  CSS.make("_a_3h000wu8vs", []);
  CSS.make("_a_3h000w4ctj", []);
  CSS.make("_a_3h000wrqu8", []);
  CSS.make("_a_3h000w535k", []);
  CSS.make("_a_3h000wmqly", []);
  CSS.make("_a_3h000w334v", []);
  CSS.make("_a_3h000w10it", []);
  CSS.make("_a_3h000w24bv", []);
  CSS.make("_a_3h000woopq", []);
  CSS.make("_a_3h000wc6k6", []);
  CSS.make("_a_3h000wce7t", []);
  CSS.make("_a_3h000w3xq3", []);
  CSS.make("_a_3h000wpp7o", []);
  CSS.make("_a_3h000wsoql", []);
  CSS.make("_a_3h000wljby", []);
  CSS.make("_a_3h000wb5be", []);
  CSS.make("_a_3h000wse3r", []);
  CSS.make("_a_3h000wst01", []);
  CSS.make("_a_3h003kmtq7", []);
  CSS.make("_a_3h003k2lna", []);
  CSS.make("_a_3h003kvskx", []);
  CSS.make("_a_3h003k12to", []);
  CSS.make("_a_3h003kqzt3", []);
  CSS.make("_a_3h003k1b9l", []);
  CSS.make("_a_3h003ka5d6", []);
  CSS.make("_a_3h003kgsb5", []);
  CSS.make("_a_3h003ktfkm", []);
  CSS.make("_a_3h003kfrk8", []);
  CSS.make("_a_3h003ksgtx", []);
  CSS.make("_a_3h003ko8wy", []);
  CSS.make("_a_3h003kyjgi", []);
  CSS.make("_a_3h003k05n6", []);
  CSS.make("_a_3h003kpian", []);
  CSS.make("_a_3h003k7o1w", []);
  CSS.make("_a_3h003kbki1", []);
  CSS.make("_a_3h003ksfme", []);
  CSS.make("_a_3h003klhmj", []);
  CSS.make("_a_3h003kiwnw", []);
  CSS.make("_a_3h003k1i6r", []);
  CSS.make("_a_3h003k03j7", []);
  CSS.make("_a_3h0008lw5x", []);
  CSS.make("_a_3h0008x2bn", []);
  CSS.make("_a_3h0008jka5", []);
  CSS.make("_a_3h0008v07i", []);
  CSS.make("_a_3h0008ixn9", []);
  CSS.make("_a_3h00083q5z", []);
  CSS.make("_a_3h0008dhma", []);
  CSS.make("_a_3h000g8amr", []);
  CSS.make("_a_3h000gvfhi", []);
  CSS.make("_a_3h000gsbb7", []);
  CSS.make("_a_3h000gfada", []);
  CSS.make("_a_3h000g930f", []);
  CSS.make("_a_3h000gipsj", []);
  CSS.make("_a_3h000gh3hn", []);
  CSS.make("_a_3h000g3d92", []);
  CSS.make("_a_3h000g5f3q", []);
  CSS.make("_a_3h000gdrj5", []);
  CSS.make("_a_3h000g6kfj", []);
  CSS.make("_a_3h000gahlj", []);
  CSS.make("_a_3h000gd86l", []);
  CSS.make("_a_3h000g5ktc", []);
  CSS.make("_a_3h000gllwt", []);
  CSS.make("_a_3h000geu9k", []);
  CSS.make("_a_3h000gorbo", []);
  CSS.make("_a_3h000gcpic", []);
  CSS.make("_a_3h000g2bpm", []);
  CSS.make("_a_3h000giv0g", []);
  CSS.make("_a_3h006wl0e3", []);
  CSS.make("_a_3h006wc16s", []);
  CSS.make("_a_3h006wk48c", []);
  CSS.make("_a_3h006wndfl", []);
  CSS.make("_a_3h006woh1n", []);
  CSS.make("_a_3h006wvdj4", []);
  CSS.make("_a_3h006wx17x", []);
  CSS.make("_a_3h006wzcfy", []);
  CSS.make("_a_3h006w30nn", []);
  
  CSS.make("_a_40keqi", []);
  
  CSS.make("_a_40ye8k", []);
  
  CSS.make("_a_40r8u1", []);
  
  CSS.make("_a_40uemi", []);
  
  CSS.make("_a_40mflx", []);
  
  CSS.make("_a_4056p9", []);
  
  CSS.make("_a_40xcnx", []);
  
  CSS.make("_a_40ios5", []);
  
  CSS.make("_a_405tpn", []);
  
  CSS.make("_a_40izzs", []);
  
  CSS.make("_a_40yjsg", []);
  
  CSS.make("_a_40khnb", []);
  
  CSS.make("_a_403f6l", []);
  
  CSS.make("_a_40otsx", []);
  CSS.make("_a_4085p6", []);
  CSS.make("_a_40q314", []);
  CSS.make(
    "_a_400xa4",
    [
      (
        "--elevation1-xawwdw_1",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
      (
        "--elevation1-xawwdw_2",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
      (
        "--elevation1-xawwdw_3",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
    ],
  );
  
  CSS.make("_a_39000w2nfr", []);
  CSS.make("_a_39000wvq06", []);
  CSS.make("_a_39000wcezg", []);
  CSS.make("_a_39000we8x4", []);
  CSS.make("_a_39000wem91", []);
  CSS.make("_a_39000w9h4p", []);
  CSS.make("_a_39000wz26j", []);
  CSS.make("_a_39000wbcib", []);
  CSS.make("_a_39000wehso", []);
  CSS.make("_a_39000wvpvo", []);
  CSS.make("_a_39000wjlye", []);
  CSS.make("_a_39000wuvjq", []);
  CSS.make("_a_39000w1f37", []);
  CSS.make("_a_39000w1ldt", []);
  CSS.make("_a_39000ww4iu", []);
  CSS.make("_a_39000wk1yt", []);
  CSS.make("_a_39000w363d", []);
  CSS.make("_a_39000w78wf", []);
  CSS.make("_a_39000wryx3", []);
  CSS.make("_a_39000wbe59", []);
  CSS.make("_a_39000w7w9s", []);
  CSS.make("_a_39000w8n01", []);
  CSS.make("_a_39000wf6oz", []);
  CSS.make("_a_39000wata8", []);
  CSS.make("_a_39000w7w9s", []);
  CSS.make("_a_39001sxup1", []);
  CSS.make("_a_39001s9ewh", []);
  CSS.make("_a_39001shsum", []);
  CSS.make("_a_39001s04xu", []);
  CSS.make("_a_39001sqqtz", []);
  CSS.make("_a_39001s54xk", []);
  CSS.make("_a_39001s7d2k", []);
  CSS.make("_a_39001s93ok", []);
  CSS.make("_a_39001scs51", []);
  CSS.make("_a_39001s2wtl", []);
  CSS.make("_a_39001sd3sd", []);
  CSS.make("_a_39001sfv8k", []);
  CSS.make("_a_39001s2yw6", []);
  CSS.make("_a_39001spdqz", []);
  CSS.make("_a_39001s8w9h", []);
  CSS.make("_a_39001skkb2", []);
  CSS.make("_a_39001sdt8x", []);
  CSS.make("_a_39001sc0ip", []);
  CSS.make("_a_39001sckm0", []);
  CSS.make("_a_39001sw002", []);
  CSS.make("_a_39001sz8v2", []);
  CSS.make("_a_39001s2qfz", []);
  CSS.make("_a_39001smhad", []);
  CSS.make("_a_39001s0o43", []);
  CSS.make("_a_39001sz8v2", []);
  
  CSS.make("_a_390008hz2r", []);
  CSS.make("_a_390008qfjp", []);
  CSS.make("_a_390008ab29", []);
  CSS.make("_a_3900081u4d", []);
  CSS.make("_a_390008uss4", []);
  CSS.make("_a_390008n2r8", []);
  CSS.make("_a_390008ys2x", []);
  CSS.make("_a_390008ojtb", []);
  CSS.make("_a_3900080xs1", []);
  CSS.make("_a_390008yimv", []);
  CSS.make("_a_390008fmes", []);
  let color = `hex("333");
  CSS.make(
    "_a_39000838s1",
    [
      ("--color-vcr1i_1", CSS.Types.Color.toString(color)),
      ("--color-vcr1i_2", CSS.Types.Color.toString(color)),
      ("--color-vcr1i_3", CSS.Types.Color.toString(color)),
    ],
  );
  CSS.make(
    "_a_390008tv7y",
    [
      ("--color-pys9ag_1", CSS.Types.Color.toString(color)),
      ("--color-pys9ag_2", CSS.Types.Color.toString(color)),
      ("--color-pys9ag_3", CSS.Types.Color.toString(color)),
      ("--color-pys9ag_4", CSS.Types.Color.toString(color)),
    ],
  );
  
  CSS.make(
    "_a_390008igxz",
    [
      ("--boxDark-17ffdav", CSS.Types.Color.toString(Color.Background.boxDark)),
    ],
  );
  
  CSS.make("_a_390008fodl", []);
  CSS.make("_a_3900085i1d", []);
  CSS.make("_a_3900085rni", []);
  CSS.make("_a_390008nqg5", []);
  CSS.make("_a_390008dzbz", []);
  CSS.make("_a_3900081b7p", []);
  CSS.make("_a_390008fl0e", []);
  CSS.make("_a_3900085uiv", []);
  
  CSS.make("_a_7o0001ird3", []);
  CSS.make("_a_7o0001eq2u", []);
  CSS.make("_a_7o00017x4a", []);
  CSS.make("_a_7o0001kxhc", []);
  CSS.make("_a_7o000174rj", []);
  CSS.make("_a_7o0001c0fc", []);
  CSS.make("_a_7o0001ualz", []);
  CSS.make("_a_7o00018cv6", []);
  CSS.make("_a_7o00017vp0", []);
  CSS.make("_a_7o0001kg5x", []);
  CSS.make("_a_7o000142dq", []);
  CSS.make("_a_7o0001ouy8", []);
  CSS.make("_a_7o0001zi1j", []);
  CSS.make("_a_7o0001bp18", []);
  CSS.make("_a_7o0001bl3b", []);
  CSS.make("_a_7o00010ihr", []);
  CSS.make("_a_7o00018tou", []);
  
  CSS.make("_a_6tobub", []);
  CSS.make("_a_6t7xqd", []);
  CSS.make("_a_6tt5e9", []);
  CSS.make("_a_6thmlf", []);
  CSS.make("_a_6tm01f", []);
  
  CSS.make("_a_39002oylgn", []);
  CSS.make("_a_39000wcezg", []);
  CSS.make("_a_39001sniqy", []);
  CSS.make("_a_39002oueyu", []);
  CSS.make("_a_39002o3hnb", []);
  CSS.make("_a_39002odqt2", []);
  CSS.make("_a_39002oz38j", []);
  CSS.make("_a_39002on9c9", []);
  
  CSS.make("_a_8jqhry", []);
  CSS.make("_a_8ju2x3", []);
  CSS.make("_a_8jx73u", []);
  CSS.make("_a_8jcm6t", []);
  CSS.make("_a_8jlpb4", []);
  
  CSS.make("_a_8jh0g1", []);
  CSS.make("_a_8jlnwd", []);
  
  CSS.make("_a_8j0ddq", []);
  CSS.make("_a_8jopaa", []);
  CSS.make("_a_8jenxt", []);
  
  CSS.make("_a_8jase9", []);
  CSS.make("_a_8jana2", []);
  CSS.make("_a_8j11ag", []);
  
  CSS.make("_a_8jhhjc", []);
  CSS.make("_a_8jj4w6", []);
  CSS.make("_a_8j6ns1", []);
  CSS.make("_a_8jjpx4", []);
  CSS.make("_a_8j4k9o", []);
  
  let _loadingKeyframes = CSS.Types.AnimationName.make("_k_1b5h4ts");
