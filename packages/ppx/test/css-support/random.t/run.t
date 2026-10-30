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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "@property --colorTextString-1or9u9e{syntax:\"*\";inherits:false;}"];
  [@css "@property --c-17nwon4{syntax:\"*\";inherits:false;}"];
  [@css "@property --c-1729nrm{syntax:\"*\";inherits:false;}"];
  [@css "@property --maskedImageUrl-q8tx22{syntax:\"*\";inherits:false;}"];
  [@css "@property --text-1dckpp2{syntax:\"*\";inherits:false;}"];
  [@css "@property --lola-1i7n24a{syntax:\"*\";inherits:false;}"];
  [@css "@property --lola-s8vp25{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-d1jms4{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-4g8iss{syntax:\"*\";inherits:false;}"];
  [@css "@property --interpolation-it7nat{syntax:\"*\";inherits:false;}"];
  [@css "@property --interpolation-h66riu{syntax:\"*\";inherits:false;}"];
  [@css
    (
      "._a_aahc5w{scroll-behavior:auto;}",
      "_a_aahc5w",
      "0,1,0 own",
      "370",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_aajuhq{scroll-behavior:smooth;}",
      "_a_aajuhq",
      "0,1,0 own",
      "370",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8snuue{overflow-anchor:none;}",
      "_a_8snuue",
      "0,1,0 own",
      "316",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8so7gw{overflow-anchor:auto;}",
      "_a_8so7gw",
      "0,1,0 own",
      "316",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_0114rl{-moz-appearance:textfield;}",
      "_a_0114rl",
      "0,1,0 own",
      "1",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_24pbln{-webkit-appearance:none;}",
      "_a_24pbln",
      "0,1,0 own",
      "76",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_27odft{-webkit-box-orient:vertical;}",
      "_a_27odft",
      "0,1,0 own",
      "79",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_2emjql{-webkit-line-clamp:2;}",
      "_a_2emjql",
      "0,1,0 own",
      "86",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_2hwqei{-webkit-overflow-scrolling:touch;}",
      "_a_2hwqei",
      "0,1,0 own",
      "89",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_2jzphb{-webkit-tap-highlight-color:transparent;}",
      "_a_2jzphb",
      "0,1,0 own",
      "91",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_2kgs7p{-webkit-text-fill-color:var(--colorTextString-1or9u9e);}",
      "_a_2kgs7p",
      "0,1,0 own",
      "92",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_2zkrf0{-webkit-animation:none;animation:none;}",
      "_a_2zkrf0",
      "0,1,0 own",
      "107",
      4095,
      false,
    )
  ];
  [@css
    (
      "._a_33rcf8{-webkit-appearance:none;-moz-appearance:none;appearance:none;}",
      "_a_33rcf8",
      "0,1,0 own",
      "111",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_35qiim{aspect-ratio:21 / 8;}",
      "_a_35qiim",
      "0,1,0 own",
      "113",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3900049niw{background-color:var(--c-17nwon4);}",
      "_a_3900049niw",
      "0,1,0 own",
      "117",
      4,
      false,
    )
  ];
  [@css
    ("._a_3hanm4{border:none;}", "_a_3hanm4", "0,1,0 own", "125", 131071, false)
  ];
  [@css
    ("._a_3hz56g{border:1px;}", "_a_3hz56g", "0,1,0 own", "125", 131071, false)
  ];
  [@css
    ("._a_3hqhxu{border:thin;}", "_a_3hqhxu", "0,1,0 own", "125", 131071, false)
  ];
  [@css
    (
      "._a_3hrhyr{border:1px solid;}",
      "_a_3hrhyr",
      "0,1,0 own",
      "125",
      131071,
      false,
    )
  ];
  [@css
    (
      "._a_3hr2u1{border:thin dashed;}",
      "_a_3hr2u1",
      "0,1,0 own",
      "125",
      131071,
      false,
    )
  ];
  [@css
    (
      "._a_3h2auv{border:1px solid black;}",
      "_a_3h2auv",
      "0,1,0 own",
      "125",
      131071,
      false,
    )
  ];
  [@css
    (
      "._a_3hrvox{border:thin dashed red;}",
      "_a_3hrvox",
      "0,1,0 own",
      "125",
      131071,
      false,
    )
  ];
  [@css
    (
      "._a_3hh4t0{border:2px dotted #333;}",
      "_a_3hh4t0",
      "0,1,0 own",
      "125",
      131071,
      false,
    )
  ];
  [@css
    (
      "._a_3hznxf{border:medium double blue;}",
      "_a_3hznxf",
      "0,1,0 own",
      "125",
      131071,
      false,
    )
  ];
  [@css
    (
      "._a_710001842v{bottom:unset;}",
      "_a_710001842v",
      "0,1,0 own",
      "253",
      1,
      false,
    )
  ];
  [@css
    ("._a_40keqi{box-shadow:none;}", "_a_40keqi", "0,1,0 own", "144", 1, false)
  ];
  [@css
    (
      "._a_44n7nl{break-inside:avoid;}",
      "_a_44n7nl",
      "0,1,0 own",
      "148",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_48dnqv{caret-color:#e15a46;}",
      "_a_48dnqv",
      "0,1,0 own",
      "152",
      1,
      false,
    )
  ];
  [@css
    ("._a_4ey3yl{color:inherit;}", "_a_4ey3yl", "0,1,0 own", "158", 1, false)
  ];
  [@css
    (
      "._a_4ec5tt{color:var(--color-link);}",
      "_a_4ec5tt",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4o0004mo4e{-webkit-column-width:125px;column-width:125px;}",
      "_a_4o0004mo4e",
      "0,1,0 own",
      "168",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_4o000422l4{-webkit-column-width:auto;column-width:auto;}",
      "_a_4o000422l4",
      "0,1,0 own",
      "168",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_5f5by5{counter-increment:ol;}",
      "_a_5f5by5",
      "0,1,0 own",
      "195",
      1,
      false,
    )
  ];
  [@css
    ("._a_5gor4s{counter-reset:ol;}", "_a_5gor4s", "0,1,0 own", "196", 1, false)
  ];
  [@css
    (
      "._a_5rejxd{display:-webkit-box;}",
      "_a_5rejxd",
      "0,1,0 own",
      "207",
      1,
      false,
    )
  ];
  [@css
    ("._a_5rf64m{display:contents;}", "_a_5rf64m", "0,1,0 own", "207", 1, false)
  ];
  [@css
    ("._a_5r20ed{display:table;}", "_a_5r20ed", "0,1,0 own", "207", 1, false)
  ];
  [@css
    (
      "._a_5wu6n6{fill:var(--c-1729nrm);}",
      "_a_5wu6n6",
      "0,1,0 own",
      "212",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5wzqgg{fill:currentColor;}",
      "_a_5wzqgg",
      "0,1,0 own",
      "212",
      1,
      false,
    )
  ];
  [@css ("._a_6ffv11{gap:4px;}", "_a_6ffv11", "0,1,0 own", "231", 3, false)];
  [@css
    (
      "._a_6j0001xyc7{grid-column-end:span 2;}",
      "_a_6j0001xyc7",
      "0,1,0 own",
      "235",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6j0003e1eh{grid-column:unset;}",
      "_a_6j0003e1eh",
      "0,1,0 own",
      "235",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_6j000crf94{grid-row:unset;}",
      "_a_6j000crf94",
      "0,1,0 own",
      "235",
      12,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gz6hb{grid-template-columns:max-content max-content;}",
      "_a_6i000gz6hb",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000ggo9j{grid-template-columns:minmax(10px, auto) fit-content(20px) fit-content(20px);}",
      "_a_6i000ggo9j",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gyg51{grid-template-columns:minmax(51px, auto) fit-content(20px) fit-content(20px);}",
      "_a_6i000gyg51",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gwvwy{grid-template-columns:repeat(2, auto);}",
      "_a_6i000gwvwy",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6i000gu6jz{grid-template-columns:repeat(3, auto);}",
      "_a_6i000gu6jz",
      "0,1,0 own",
      "234",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6l0xge{height:-webkit-fit-content;height:-moz-fit-content;height:fit-content;}",
      "_a_6l0xge",
      "0,1,0 own",
      "237",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9i00027xd1{justify-items:start;}",
      "_a_9i00027xd1",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j0002oybl{justify-self:unset;}",
      "_a_9j0002oybl",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_710002rhel{left:unset;}",
      "_a_710002rhel",
      "0,1,0 own",
      "253",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_7y0074aouu{-webkit-mask-image:var(--maskedImageUrl-q8tx22);mask-image:var(--maskedImageUrl-q8tx22);}",
      "_a_7y0074aouu",
      "0,1,0 own",
      "286",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_7y01kwck5z{-webkit-mask-position:center center;mask-position:center center;}",
      "_a_7y01kwck5z",
      "0,1,0 own",
      "286",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_7y035sawfw{-webkit-mask-repeat:no-repeat;mask-repeat:no-repeat;}",
      "_a_7y035sawfw",
      "0,1,0 own",
      "286",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_88c9a0{max-width:-webkit-max-content;max-width:-moz-max-content;max-width:max-content;}",
      "_a_88c9a0",
      "0,1,0 own",
      "296",
      1,
      false,
    )
  ];
  [@css
    ("._a_8p12fz{outline:none;}", "_a_8p12fz", "0,1,0 own", "313", 7, false)
  ];
  [@css
    ("._a_9ln4zy{position:unset;}", "_a_9ln4zy", "0,1,0 own", "345", 1, false)
  ];
  [@css
    ("._a_9y6l6w{resize:none;}", "_a_9y6l6w", "0,1,0 own", "358", 1, false)
  ];
  [@css
    (
      "._a_710004k6z4{right:calc(50% - 4px);}",
      "_a_710004k6z4",
      "0,1,0 own",
      "253",
      4,
      false,
    )
  ];
  [@css
    ("._a_c0y1y6{stroke-opacity:0;}", "_a_c0y1y6", "0,1,0 own", "432", 1, false)
  ];
  [@css
    (
      "._a_btaxxd{stroke:var(--text-1dckpp2);}",
      "_a_btaxxd",
      "0,1,0 own",
      "425",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7100083v5j{top:calc(50% - 1px);}",
      "_a_7100083v5j",
      "0,1,0 own",
      "253",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_7100081c45{top:unset;}",
      "_a_7100081c45",
      "0,1,0 own",
      "253",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_dhsbrd{touch-action:none;}",
      "_a_dhsbrd",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhee94{touch-action:pan-x pan-y;}",
      "_a_dhee94",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dkf4tj{transform-origin:center bottom;}",
      "_a_dkf4tj",
      "0,1,0 own",
      "488",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dkmm6s{transform-origin:center left;}",
      "_a_dkmm6s",
      "0,1,0 own",
      "488",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dkn9hl{transform-origin:center right;}",
      "_a_dkn9hl",
      "0,1,0 own",
      "488",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dkjzv0{transform-origin:2px;}",
      "_a_dkjzv0",
      "0,1,0 own",
      "488",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dkuei5{transform-origin:bottom;}",
      "_a_dkuei5",
      "0,1,0 own",
      "488",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dk79kk{transform-origin:3cm 2px;}",
      "_a_dk79kk",
      "0,1,0 own",
      "488",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dkmaf2{transform-origin:left 2px;}",
      "_a_dkmaf2",
      "0,1,0 own",
      "488",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dk5eih{transform-origin:center top;}",
      "_a_dk5eih",
      "0,1,0 own",
      "488",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_diuucg{-webkit-transform:none;-moz-transform:none;-ms-transform:none;transform:none;}",
      "_a_diuucg",
      "0,1,0 own",
      "486",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ecanqs{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}",
      "_a_ecanqs",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ec3le8{width:-webkit-max-content;width:-moz-max-content;width:max-content;}",
      "_a_ec3le8",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dm0002v97v{transition-delay:240ms;}",
      "_a_dm0002v97v",
      "0,1,0 own",
      "490",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_2z0008i4el{-webkit-animation-duration:150ms;animation-duration:150ms;}",
      "_a_2z0008i4el",
      "0,1,0 own",
      "107",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3h1lokslom{border-width:thin;}",
      "_a_3h1lokslom",
      "0,1,0 own",
      "125",
      74756,
      false,
    )
  ];
  [@css
    (
      "._a_8p0004cl79{outline-width:medium;}",
      "_a_8p0004cl79",
      "0,1,0 own",
      "313",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8pehrx{outline:medium solid red;}",
      "_a_8pehrx",
      "0,1,0 own",
      "313",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_8rd3yo{overflow:var(--lola-1i7n24a);}",
      "_a_8rd3yo",
      "0,1,0 own",
      "315",
      3,
      false,
    )
  ];
  [@css
    ("._a_8rbazn{overflow:hidden;}", "_a_8rbazn", "0,1,0 own", "315", 3, false)
  ];
  [@css
    (
      "._a_8r00022x0l{overflow-y:var(--lola-s8vp25);}",
      "_a_8r00022x0l",
      "0,1,0 own",
      "315",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_8r0001o3b9{overflow-x:hidden;}",
      "_a_8r0001o3b9",
      "0,1,0 own",
      "315",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8ti9nl{overflow-block:hidden;}",
      "_a_8ti9nl",
      "0,1,0 own",
      "317",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8trkd7{overflow-block:var(--value-d1jms4);}",
      "_a_8trkd7",
      "0,1,0 own",
      "317",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8wl9bh{overflow-inline:var(--value-4g8iss);}",
      "_a_8wl9bh",
      "0,1,0 own",
      "320",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_390008a0mj{background-image:linear-gradient(84deg, #F80 0%, rgba(255, 255, 255, 0.8) 50%, #2A97FF 100%);}",
      "_a_390008a0mj",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_35vr3s{aspect-ratio:16 / 9;}",
      "_a_35vr3s",
      "0,1,0 own",
      "113",
      1,
      false,
    )
  ];
  [@css
    (
      "._in_1ter7ii{right:var(--interpolation-it7nat);}",
      "_in_1ter7ii",
      "0,1,0 own",
      "253",
      4,
      false,
    )
  ];
  [@css
    (
      "._in_1ter7ii{bottom:var(--interpolation-h66riu);}",
      "_in_1ter7ii",
      "0,1,0 own",
      "253",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (2, "", [11]),
      (3, "", [12]),
      (6, "", [13]),
      (7, "", [14]),
      (9, "", [15]),
      (10, "", [16]),
      (11, "", [17]),
      (23, "", [18]),
      (24, "", [19]),
      (25, "", [20]),
      (26, "", [21]),
      (27, "", [22]),
      (28, "", [23]),
      (29, "", [24]),
      (32, "", [25]),
      (36, "", [26]),
      (38, "", [27]),
      (39, "", [28]),
      (41, "", [29]),
      (42, "", [30]),
      (44, "", [31]),
      (45, "", [32]),
      (46, "", [33]),
      (47, "", [34]),
      (48, "", [35]),
      (49, "", [36]),
      (50, "", [37]),
      (51, "", [38]),
      (52, "", [39]),
      (53, "", [40]),
      (54, "", [41]),
      (55, "", [42]),
      (56, "", [43]),
      (57, "", [44]),
      (58, "", [45]),
      (59, "", [46]),
      (60, "", [47]),
      (61, "", [48]),
      (62, "", [49]),
      (63, "", [50]),
      (64, "", [51]),
      (65, "", [52]),
      (66, "", [53]),
      (67, "", [54]),
      (69, "", [55]),
      (72, "", [56]),
      (74, "", [57]),
      (75, "", [58]),
      (76, "", [59]),
      (77, "", [60]),
      (78, "", [61]),
      (79, "", [62]),
      (81, "", [63]),
      (82, "", [64]),
      (83, "", [65]),
      (84, "", [66]),
      (85, "", [67]),
      (86, "", [13]),
      (87, "", [68]),
      (88, "", [69]),
      (89, "", [70]),
      (90, "", [12]),
      (91, "", [71]),
      (92, "", [72]),
      (93, "", [73]),
      (94, "", [74]),
      (95, "", [75]),
      (96, "", [76]),
      (97, "", [77]),
      (98, "", [78]),
      (99, "", [79]),
      (100, "", [80]),
      (101, "", [81]),
      (102, "", [82]),
      (103, "", [83]),
      (104, "", [84]),
      (105, "", [85]),
      (107, "", [86]),
      (108, "", [87]),
      (110, "", [88]),
      (111, "", [89]),
      (115, "", [90]),
      (116, "", [91]),
      (117, "", [92]),
      (121, "", [93]),
      (122, "", [94]),
      (123, "", [95]),
      (124, "", [96]),
      (127, "", [97]),
      (128, "", [98]),
      (129, "", [99]),
      (132, "", [100]),
      (137, "", [101]),
      (139, "", [40]),
      (142, "", [102, 103]),
    ]
  ];
  
  CSS.make("_a_aahc5w", []);
  CSS.make("_a_aajuhq", []);
  
  CSS.make("_a_8snuue", []);
  CSS.make("_a_8so7gw", []);
  
  CSS.make("_a_0114rl", []);
  CSS.make("_a_24pbln", []);
  CSS.make("_a_27odft", []);
  
  module Color = {
    let text = CSS.hex("444");
    let background = CSS.hex("333");
  };
  let _backgroundString = Color.background |> CSS.Types.Color.toString;
  let colorTextString = Color.text |> CSS.Types.Color.toString;
  
  CSS.make("_a_2emjql", []);
  CSS.make("_a_2hwqei", []);
  CSS.make("_a_2jzphb", []);
  CSS.make(
    "_a_2kgs7p",
    [
      (
        "--colorTextString-1or9u9e",
        CSS.Types.WebkitTextFillColor.toString(colorTextString),
      ),
    ],
  );
  CSS.make("_a_2zkrf0", []);
  CSS.make("_a_33rcf8", []);
  CSS.make("_a_35qiim", []);
  
  let c = CSS.hex("e15a46");
  CSS.make("_a_3900049niw", [("--c-17nwon4", CSS.Types.Color.toString(c))]);
  
  CSS.make("_a_3hanm4", []);
  
  CSS.make("_a_3hz56g", []);
  CSS.make("_a_3hqhxu", []);
  
  CSS.make("_a_3hrhyr", []);
  CSS.make("_a_3hr2u1", []);
  
  CSS.make("_a_3h2auv", []);
  CSS.make("_a_3hrvox", []);
  CSS.make("_a_3hh4t0", []);
  CSS.make("_a_3hznxf", []);
  CSS.make("_a_710001842v", []);
  CSS.make("_a_40keqi", []);
  CSS.make("_a_44n7nl", []);
  CSS.make("_a_48dnqv", []);
  CSS.make("_a_4ey3yl", []);
  CSS.make("_a_4ec5tt", []);
  CSS.make("_a_4o0004mo4e", []);
  CSS.make("_a_4o000422l4", []);
  CSS.make("_a_5f5by5", []);
  CSS.make("_a_5gor4s", []);
  CSS.make("_a_5rejxd", []);
  CSS.make("_a_5rf64m", []);
  CSS.make("_a_5r20ed", []);
  CSS.make("_a_5wu6n6", [("--c-1729nrm", CSS.Types.Paint.toString(c))]);
  CSS.make("_a_5wzqgg", []);
  CSS.make("_a_6ffv11", []);
  CSS.make("_a_6j0001xyc7", []);
  CSS.make("_a_6j0003e1eh", []);
  CSS.make("_a_6j000crf94", []);
  CSS.make("_a_6i000gz6hb", []);
  CSS.make("_a_6i000ggo9j", []);
  CSS.make("_a_6i000gyg51", []);
  CSS.make("_a_6i000gwvwy", []);
  CSS.make("_a_6i000gu6jz", []);
  CSS.make("_a_6l0xge", []);
  CSS.make("_a_9i00027xd1", []);
  CSS.make("_a_9j0002oybl", []);
  CSS.make("_a_710002rhel", []);
  let maskedImageUrl = `url("https://www.example.com/eye-uncrossed.svg");
  CSS.make(
    "_a_7y0074aouu",
    [
      ("--maskedImageUrl-q8tx22", CSS.Types.MaskImage.toString(maskedImageUrl)),
    ],
  );
  CSS.make("_a_7y01kwck5z", []);
  CSS.make("_a_7y035sawfw", []);
  CSS.make("_a_88c9a0", []);
  CSS.make("_a_8p12fz", []);
  CSS.make("_a_8snuue", []);
  CSS.make("_a_9ln4zy", []);
  CSS.make("_a_9y6l6w", []);
  CSS.make("_a_710004k6z4", []);
  CSS.make("_a_aajuhq", []);
  CSS.make("_a_c0y1y6", []);
  CSS.make(
    "_a_btaxxd",
    [("--text-1dckpp2", CSS.Types.Paint.toString(Color.text))],
  );
  CSS.make("_a_7100083v5j", []);
  CSS.make("_a_7100081c45", []);
  CSS.make("_a_dhsbrd", []);
  CSS.make("_a_dhee94", []);
  CSS.make("_a_dkf4tj", []);
  CSS.make("_a_dkmm6s", []);
  CSS.make("_a_dkn9hl", []);
  CSS.make("_a_dkjzv0", []);
  CSS.make("_a_dkuei5", []);
  CSS.make("_a_dk79kk", []);
  CSS.make("_a_dkmaf2", []);
  CSS.make("_a_dk5eih", []);
  CSS.make("_a_diuucg", []);
  
  CSS.make("_a_ecanqs", []);
  CSS.make("_a_ec3le8", []);
  
  CSS.make("_a_dm0002v97v", []);
  CSS.make("_a_2z0008i4el", []);
  
  CSS.make("_a_3h1lokslom", []);
  CSS.make("_a_8p0004cl79", []);
  CSS.make("_a_8pehrx", []);
  
  let lola = `hidden;
  CSS.make(
    "_a_8rd3yo",
    [("--lola-1i7n24a", CSS.Types.Overflow.toString(lola))],
  );
  CSS.make("_a_8rbazn", []);
  CSS.make(
    "_a_8r00022x0l",
    [("--lola-s8vp25", CSS.Types.OverflowY.toString(lola))],
  );
  CSS.make("_a_8r0001o3b9", []);
  
  let value = `clip;
  CSS.make("_a_8ti9nl", []);
  CSS.make(
    "_a_8trkd7",
    [("--value-d1jms4", CSS.Types.OverflowBlock.toString(value))],
  );
  CSS.make(
    "_a_8wl9bh",
    [("--value-4g8iss", CSS.Types.OverflowInline.toString(value))],
  );
  
  CSS.make("_a_390008a0mj", []);
  
  CSS.make("_a_35vr3s", []);
  
  CSS.make("_a_4ec5tt", []);
  
  let interpolation = `px(10);
  CSS.make(
    "_in_1ter7ii",
    [
      ("--interpolation-it7nat", CSS.Types.Right.toString(interpolation)),
      ("--interpolation-h66riu", CSS.Types.Bottom.toString(interpolation)),
    ],
  );

  $ dune build
