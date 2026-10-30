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
    (
      "._a_dr6172{-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}",
      "_a_dr6172",
      "0,1,0 own",
      "495",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_v3rlzc0ylr4 .recharts-cartesian-grid-horizontal line:nth-last-child(1){stroke-opacity:0;}",
      "_a_v3rlzc0ylr4",
      "0,3,1 & .recharts-cartesian-grid-horizontal line:nth-last-child(1)",
      "432",
      1,
      true,
    )
  ];
  [@css
    (
      "._a_bhmy9c0ax0l .recharts-cartesian-grid-horizontal line:nth-last-child(2){stroke-opacity:0;}",
      "_a_bhmy9c0ax0l",
      "0,3,1 & .recharts-cartesian-grid-horizontal line:nth-last-child(2)",
      "432",
      1,
      true,
    )
  ];
  [@css
    (
      "._a_nfiwp8mvgu0 .recharts-scatter .recharts-scatter-symbol .recharts-symbols{opacity:0.8;}",
      "_a_nfiwp8mvgu0",
      "0,4,0 & .recharts-scatter .recharts-scatter-symbol .recharts-symbols",
      "310",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_yuqvu8mc7xs .recharts-scatter .recharts-scatter-symbol .recharts-symbols:hover{opacity:1;}",
      "_a_yuqvu8mc7xs",
      "0,5,0 & .recharts-scatter .recharts-scatter-symbol .recharts-symbols:hover",
      "310",
      1,
      false,
    )
  ];
  [@css.bindings
    [
      (
        "Input._chart",
        "_id_1thfo89",
        "_a_dr6172 _a_v3rlzc0ylr4 _a_bhmy9c0ax0l _a_nfiwp8mvgu0 _a_yuqvu8mc7xs",
      ),
    ]
  ];
  [@css.blocks [(9, "_id_1thfo89", [0, 1, 2, 3, 4])]];
  
  let _chart =
    CSS.make(
      "label:_chart _id_1thfo89 _a_dr6172 _a_v3rlzc0ylr4 _a_bhmy9c0ax0l _a_nfiwp8mvgu0 _a_yuqvu8mc7xs",
      [],
    );
