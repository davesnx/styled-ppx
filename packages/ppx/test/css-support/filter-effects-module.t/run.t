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
  [@css "@property --color-qfwu7a_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-qfwu7a_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-qfwu7a_3{syntax:\"*\";inherits:false;}"];
  [@css
    (
      "._a_5znm6u{-webkit-filter:none;filter:none;}",
      "_a_5znm6u",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5zcuuo{-webkit-filter:url(\"#id\");filter:url(\"#id\");}",
      "_a_5zcuuo",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5zp7li{-webkit-filter:url(\"image.svg#id\");filter:url(\"image.svg#id\");}",
      "_a_5zp7li",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5zxr2q{-webkit-filter:blur(5px);filter:blur(5px);}",
      "_a_5zxr2q",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5zxntt{-webkit-filter:brightness(0.5);filter:brightness(0.5);}",
      "_a_5zxntt",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5z40fd{-webkit-filter:contrast(150%);filter:contrast(150%);}",
      "_a_5z40fd",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5z4bqh{-webkit-filter:drop-shadow(5px 5px 10px);filter:drop-shadow(5px 5px 10px);}",
      "_a_5z4bqh",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5zlta4{-webkit-filter:drop-shadow(15px 15px 15px #123);filter:drop-shadow(15px 15px 15px #123);}",
      "_a_5zlta4",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5zv1a9{-webkit-filter:grayscale(50%);filter:grayscale(50%);}",
      "_a_5zv1a9",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5zcrc5{-webkit-filter:hue-rotate(50deg);filter:hue-rotate(50deg);}",
      "_a_5zcrc5",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5zakyf{-webkit-filter:invert(50%);filter:invert(50%);}",
      "_a_5zakyf",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5ztt82{-webkit-filter:opacity(50%);filter:opacity(50%);}",
      "_a_5ztt82",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5zh2v6{-webkit-filter:sepia(50%);filter:sepia(50%);}",
      "_a_5zh2v6",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5z0jie{-webkit-filter:saturate(150%);filter:saturate(150%);}",
      "_a_5z0jie",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5z13v6{-webkit-filter:grayscale(100%) sepia(100%);filter:grayscale(100%) sepia(100%);}",
      "_a_5z13v6",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5zvds4{-webkit-filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}",
      "_a_5zvds4",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5zla48{-webkit-filter:drop-shadow(0 1px 0 var(--color-qfwu7a_1)) drop-shadow(0 1px 0 var(--color-qfwu7a_2)) drop-shadow(0 1px 0 var(--color-qfwu7a_3)) drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075)) drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));filter:drop-shadow(0 1px 0 var(--color-qfwu7a_1)) drop-shadow(0 1px 0 var(--color-qfwu7a_2)) drop-shadow(0 1px 0 var(--color-qfwu7a_3)) drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075)) drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}",
      "_a_5zla48",
      "0,1,0 own",
      "215",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_37q0hq{-webkit-backdrop-filter:none;backdrop-filter:none;}",
      "_a_37q0hq",
      "0,1,0 own",
      "115",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_379q1s{-webkit-backdrop-filter:url(\"#id\");backdrop-filter:url(\"#id\");}",
      "_a_379q1s",
      "0,1,0 own",
      "115",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_37czb9{-webkit-backdrop-filter:url(\"image.svg#id\");backdrop-filter:url(\"image.svg#id\");}",
      "_a_37czb9",
      "0,1,0 own",
      "115",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_37pdax{-webkit-backdrop-filter:blur(5px);backdrop-filter:blur(5px);}",
      "_a_37pdax",
      "0,1,0 own",
      "115",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_37smr4{-webkit-backdrop-filter:brightness(0.5);backdrop-filter:brightness(0.5);}",
      "_a_37smr4",
      "0,1,0 own",
      "115",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_375lod{-webkit-backdrop-filter:contrast(150%);backdrop-filter:contrast(150%);}",
      "_a_375lod",
      "0,1,0 own",
      "115",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_37n3bb{-webkit-backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));}",
      "_a_37n3bb",
      "0,1,0 own",
      "115",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_37jicj{-webkit-backdrop-filter:grayscale(50%);backdrop-filter:grayscale(50%);}",
      "_a_37jicj",
      "0,1,0 own",
      "115",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_37jduf{-webkit-backdrop-filter:hue-rotate(50deg);backdrop-filter:hue-rotate(50deg);}",
      "_a_37jduf",
      "0,1,0 own",
      "115",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_37smnx{-webkit-backdrop-filter:invert(50%);backdrop-filter:invert(50%);}",
      "_a_37smnx",
      "0,1,0 own",
      "115",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_37whax{-webkit-backdrop-filter:opacity(50%);backdrop-filter:opacity(50%);}",
      "_a_37whax",
      "0,1,0 own",
      "115",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_37b97y{-webkit-backdrop-filter:sepia(50%);backdrop-filter:sepia(50%);}",
      "_a_37b97y",
      "0,1,0 own",
      "115",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_37ltqs{-webkit-backdrop-filter:saturate(150%);backdrop-filter:saturate(150%);}",
      "_a_37ltqs",
      "0,1,0 own",
      "115",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_37aokm{-webkit-backdrop-filter:grayscale(100%) sepia(100%);backdrop-filter:grayscale(100%) sepia(100%);}",
      "_a_37aokm",
      "0,1,0 own",
      "115",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (4, "", [3]),
      (5, "", [4]),
      (6, "", [5]),
      (7, "", [6]),
      (8, "", [7]),
      (9, "", [8]),
      (14, "", [9]),
      (16, "", [10]),
      (17, "", [11]),
      (18, "", [12]),
      (19, "", [13]),
      (20, "", [14]),
      (21, "", [15]),
      (22, "", [16]),
      (23, "", [17]),
      (24, "", [18]),
      (27, "", [19]),
      (36, "", [20]),
      (37, "", [21]),
      (38, "", [22]),
      (39, "", [23]),
      (40, "", [24]),
      (41, "", [25]),
      (42, "", [26]),
      (43, "", [27]),
      (44, "", [28]),
      (45, "", [29]),
      (46, "", [30]),
      (47, "", [31]),
      (48, "", [32]),
      (49, "", [33]),
    ]
  ];
  let color = CSS.hex("333");
  
  CSS.make("_a_5znm6u", []);
  CSS.make("_a_5zcuuo", []);
  CSS.make("_a_5zp7li", []);
  CSS.make("_a_5zxr2q", []);
  CSS.make("_a_5zxntt", []);
  CSS.make("_a_5z40fd", []);
  
  CSS.make("_a_5z4bqh", []);
  
  CSS.make("_a_5zlta4", []);
  CSS.make("_a_5zv1a9", []);
  CSS.make("_a_5zcrc5", []);
  CSS.make("_a_5zakyf", []);
  CSS.make("_a_5ztt82", []);
  CSS.make("_a_5zh2v6", []);
  CSS.make("_a_5z0jie", []);
  CSS.make("_a_5z13v6", []);
  CSS.make("_a_5zvds4", []);
  CSS.make(
    "_a_5zla48",
    [
      ("--color-qfwu7a_1", CSS.Types.Color.toString(color)),
      ("--color-qfwu7a_2", CSS.Types.Color.toString(color)),
      ("--color-qfwu7a_3", CSS.Types.Color.toString(color)),
    ],
  );
  
  CSS.make("_a_37q0hq", []);
  CSS.make("_a_379q1s", []);
  CSS.make("_a_37czb9", []);
  CSS.make("_a_37pdax", []);
  CSS.make("_a_37smr4", []);
  CSS.make("_a_375lod", []);
  CSS.make("_a_37n3bb", []);
  CSS.make("_a_37jicj", []);
  CSS.make("_a_37jduf", []);
  CSS.make("_a_37smnx", []);
  CSS.make("_a_37whax", []);
  CSS.make("_a_37b97y", []);
  CSS.make("_a_37ltqs", []);
  CSS.make("_a_37aokm", []);
