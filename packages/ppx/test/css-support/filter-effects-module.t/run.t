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
  [@css ".a-5znm6u{-webkit-filter:none;filter:none;}"];
  [@css ".a-5zcuuo{-webkit-filter:url(\"#id\");filter:url(\"#id\");}"];
  [@css
    ".a-5zp7li{-webkit-filter:url(\"image.svg#id\");filter:url(\"image.svg#id\");}"
  ];
  [@css ".a-5zxr2q{-webkit-filter:blur(5px);filter:blur(5px);}"];
  [@css ".a-5zxntt{-webkit-filter:brightness(0.5);filter:brightness(0.5);}"];
  [@css ".a-5z40fd{-webkit-filter:contrast(150%);filter:contrast(150%);}"];
  [@css
    ".a-5z4bqh{-webkit-filter:drop-shadow(5px 5px 10px);filter:drop-shadow(5px 5px 10px);}"
  ];
  [@css
    ".a-5zlta4{-webkit-filter:drop-shadow(15px 15px 15px #123);filter:drop-shadow(15px 15px 15px #123);}"
  ];
  [@css ".a-5zv1a9{-webkit-filter:grayscale(50%);filter:grayscale(50%);}"];
  [@css ".a-5zcrc5{-webkit-filter:hue-rotate(50deg);filter:hue-rotate(50deg);}"];
  [@css ".a-5zakyf{-webkit-filter:invert(50%);filter:invert(50%);}"];
  [@css ".a-5ztt82{-webkit-filter:opacity(50%);filter:opacity(50%);}"];
  [@css ".a-5zh2v6{-webkit-filter:sepia(50%);filter:sepia(50%);}"];
  [@css ".a-5z0jie{-webkit-filter:saturate(150%);filter:saturate(150%);}"];
  [@css
    ".a-5z13v6{-webkit-filter:grayscale(100%) sepia(100%);filter:grayscale(100%) sepia(100%);}"
  ];
  [@css
    ".a-5zvds4{-webkit-filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}"
  ];
  [@css
    ".a-5zla48{-webkit-filter:drop-shadow(0 1px 0 var(--color-qfwu7a_1)) drop-shadow(0 1px 0 var(--color-qfwu7a_2)) drop-shadow(0 1px 0 var(--color-qfwu7a_3)) drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075)) drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));filter:drop-shadow(0 1px 0 var(--color-qfwu7a_1)) drop-shadow(0 1px 0 var(--color-qfwu7a_2)) drop-shadow(0 1px 0 var(--color-qfwu7a_3)) drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075)) drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}"
  ];
  [@css ".a-37q0hq{-webkit-backdrop-filter:none;backdrop-filter:none;}"];
  [@css
    ".a-379q1s{-webkit-backdrop-filter:url(\"#id\");backdrop-filter:url(\"#id\");}"
  ];
  [@css
    ".a-37czb9{-webkit-backdrop-filter:url(\"image.svg#id\");backdrop-filter:url(\"image.svg#id\");}"
  ];
  [@css
    ".a-37pdax{-webkit-backdrop-filter:blur(5px);backdrop-filter:blur(5px);}"
  ];
  [@css
    ".a-37smr4{-webkit-backdrop-filter:brightness(0.5);backdrop-filter:brightness(0.5);}"
  ];
  [@css
    ".a-375lod{-webkit-backdrop-filter:contrast(150%);backdrop-filter:contrast(150%);}"
  ];
  [@css
    ".a-37n3bb{-webkit-backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));}"
  ];
  [@css
    ".a-37jicj{-webkit-backdrop-filter:grayscale(50%);backdrop-filter:grayscale(50%);}"
  ];
  [@css
    ".a-37jduf{-webkit-backdrop-filter:hue-rotate(50deg);backdrop-filter:hue-rotate(50deg);}"
  ];
  [@css
    ".a-37smnx{-webkit-backdrop-filter:invert(50%);backdrop-filter:invert(50%);}"
  ];
  [@css
    ".a-37whax{-webkit-backdrop-filter:opacity(50%);backdrop-filter:opacity(50%);}"
  ];
  [@css
    ".a-37b97y{-webkit-backdrop-filter:sepia(50%);backdrop-filter:sepia(50%);}"
  ];
  [@css
    ".a-37ltqs{-webkit-backdrop-filter:saturate(150%);backdrop-filter:saturate(150%);}"
  ];
  [@css
    ".a-37aokm{-webkit-backdrop-filter:grayscale(100%) sepia(100%);backdrop-filter:grayscale(100%) sepia(100%);}"
  ];
  let color = CSS.hex("333");
  
  CSS.make("a-5znm6u", []);
  CSS.make("a-5zcuuo", []);
  CSS.make("a-5zp7li", []);
  CSS.make("a-5zxr2q", []);
  CSS.make("a-5zxntt", []);
  CSS.make("a-5z40fd", []);
  
  CSS.make("a-5z4bqh", []);
  
  CSS.make("a-5zlta4", []);
  CSS.make("a-5zv1a9", []);
  CSS.make("a-5zcrc5", []);
  CSS.make("a-5zakyf", []);
  CSS.make("a-5ztt82", []);
  CSS.make("a-5zh2v6", []);
  CSS.make("a-5z0jie", []);
  CSS.make("a-5z13v6", []);
  CSS.make("a-5zvds4", []);
  CSS.make(
    "a-5zla48",
    [
      ("--color-qfwu7a_1", CSS.Types.Color.toString(color)),
      ("--color-qfwu7a_2", CSS.Types.Color.toString(color)),
      ("--color-qfwu7a_3", CSS.Types.Color.toString(color)),
    ],
  );
  
  CSS.make("a-37q0hq", []);
  CSS.make("a-379q1s", []);
  CSS.make("a-37czb9", []);
  CSS.make("a-37pdax", []);
  CSS.make("a-37smr4", []);
  CSS.make("a-375lod", []);
  CSS.make("a-37n3bb", []);
  CSS.make("a-37jicj", []);
  CSS.make("a-37jduf", []);
  CSS.make("a-37smnx", []);
  CSS.make("a-37whax", []);
  CSS.make("a-37b97y", []);
  CSS.make("a-37ltqs", []);
  CSS.make("a-37aokm", []);
