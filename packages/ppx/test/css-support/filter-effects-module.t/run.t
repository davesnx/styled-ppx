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
  [@css "._a_5znm6u{-webkit-filter:none;filter:none;}"];
  [@css "._a_5zcuuo{-webkit-filter:url(\"#id\");filter:url(\"#id\");}"];
  [@css
    "._a_5zp7li{-webkit-filter:url(\"image.svg#id\");filter:url(\"image.svg#id\");}"
  ];
  [@css "._a_5zxr2q{-webkit-filter:blur(5px);filter:blur(5px);}"];
  [@css "._a_5zxntt{-webkit-filter:brightness(0.5);filter:brightness(0.5);}"];
  [@css "._a_5z40fd{-webkit-filter:contrast(150%);filter:contrast(150%);}"];
  [@css
    "._a_5z4bqh{-webkit-filter:drop-shadow(5px 5px 10px);filter:drop-shadow(5px 5px 10px);}"
  ];
  [@css
    "._a_5zlta4{-webkit-filter:drop-shadow(15px 15px 15px #123);filter:drop-shadow(15px 15px 15px #123);}"
  ];
  [@css "._a_5zv1a9{-webkit-filter:grayscale(50%);filter:grayscale(50%);}"];
  [@css
    "._a_5zcrc5{-webkit-filter:hue-rotate(50deg);filter:hue-rotate(50deg);}"
  ];
  [@css "._a_5zakyf{-webkit-filter:invert(50%);filter:invert(50%);}"];
  [@css "._a_5ztt82{-webkit-filter:opacity(50%);filter:opacity(50%);}"];
  [@css "._a_5zh2v6{-webkit-filter:sepia(50%);filter:sepia(50%);}"];
  [@css "._a_5z0jie{-webkit-filter:saturate(150%);filter:saturate(150%);}"];
  [@css
    "._a_5z13v6{-webkit-filter:grayscale(100%) sepia(100%);filter:grayscale(100%) sepia(100%);}"
  ];
  [@css
    "._a_5zvds4{-webkit-filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}"
  ];
  [@css
    "._a_5zla48{-webkit-filter:drop-shadow(0 1px 0 var(--color-qfwu7a_1)) drop-shadow(0 1px 0 var(--color-qfwu7a_2)) drop-shadow(0 1px 0 var(--color-qfwu7a_3)) drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075)) drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));filter:drop-shadow(0 1px 0 var(--color-qfwu7a_1)) drop-shadow(0 1px 0 var(--color-qfwu7a_2)) drop-shadow(0 1px 0 var(--color-qfwu7a_3)) drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075)) drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}"
  ];
  [@css "._a_37q0hq{-webkit-backdrop-filter:none;backdrop-filter:none;}"];
  [@css
    "._a_379q1s{-webkit-backdrop-filter:url(\"#id\");backdrop-filter:url(\"#id\");}"
  ];
  [@css
    "._a_37czb9{-webkit-backdrop-filter:url(\"image.svg#id\");backdrop-filter:url(\"image.svg#id\");}"
  ];
  [@css
    "._a_37pdax{-webkit-backdrop-filter:blur(5px);backdrop-filter:blur(5px);}"
  ];
  [@css
    "._a_37smr4{-webkit-backdrop-filter:brightness(0.5);backdrop-filter:brightness(0.5);}"
  ];
  [@css
    "._a_375lod{-webkit-backdrop-filter:contrast(150%);backdrop-filter:contrast(150%);}"
  ];
  [@css
    "._a_37n3bb{-webkit-backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));}"
  ];
  [@css
    "._a_37jicj{-webkit-backdrop-filter:grayscale(50%);backdrop-filter:grayscale(50%);}"
  ];
  [@css
    "._a_37jduf{-webkit-backdrop-filter:hue-rotate(50deg);backdrop-filter:hue-rotate(50deg);}"
  ];
  [@css
    "._a_37smnx{-webkit-backdrop-filter:invert(50%);backdrop-filter:invert(50%);}"
  ];
  [@css
    "._a_37whax{-webkit-backdrop-filter:opacity(50%);backdrop-filter:opacity(50%);}"
  ];
  [@css
    "._a_37b97y{-webkit-backdrop-filter:sepia(50%);backdrop-filter:sepia(50%);}"
  ];
  [@css
    "._a_37ltqs{-webkit-backdrop-filter:saturate(150%);backdrop-filter:saturate(150%);}"
  ];
  [@css
    "._a_37aokm{-webkit-backdrop-filter:grayscale(100%) sepia(100%);backdrop-filter:grayscale(100%) sepia(100%);}"
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
