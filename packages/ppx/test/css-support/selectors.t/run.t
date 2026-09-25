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
    ".a-dr6172{-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}"
  ];
  [@css
    ".a-v3rlzc0ylr4 .recharts-cartesian-grid-horizontal line:nth-last-child(1){stroke-opacity:0;}"
  ];
  [@css
    ".a-bhmy9c0ax0l .recharts-cartesian-grid-horizontal line:nth-last-child(2){stroke-opacity:0;}"
  ];
  [@css
    ".a-nfiwp8mvgu0 .recharts-scatter .recharts-scatter-symbol .recharts-symbols{opacity:0.8;}"
  ];
  [@css
    ".a-yuqvu8mc7xs .recharts-scatter .recharts-scatter-symbol .recharts-symbols:hover{opacity:1;}"
  ];
  [@css.bindings
    [
      (
        "Input._chart",
        "id-1e3u8p2",
        "a-dr6172 a-v3rlzc0ylr4 a-bhmy9c0ax0l a-nfiwp8mvgu0 a-yuqvu8mc7xs",
      ),
    ]
  ];
  
  let _chart =
    CSS.make(
      "label:_chart id-1e3u8p2 a-dr6172 a-v3rlzc0ylr4 a-bhmy9c0ax0l a-nfiwp8mvgu0 a-yuqvu8mc7xs",
      [],
    );
