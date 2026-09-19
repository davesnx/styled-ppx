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
    ".css-9y6172{-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}"
  ];
  [@css
    ".css-wdylr4 .recharts-cartesian-grid-horizontal line:nth-last-child(1){stroke-opacity:0;}"
  ];
  [@css
    ".css-3xax0l .recharts-cartesian-grid-horizontal line:nth-last-child(2){stroke-opacity:0;}"
  ];
  [@css
    ".css-1fqvgu0 .recharts-scatter .recharts-scatter-symbol .recharts-symbols{opacity:0.8;}"
  ];
  [@css
    ".css-o0c7xs .recharts-scatter .recharts-scatter-symbol .recharts-symbols:hover{opacity:1;}"
  ];
  [@css.bindings
    [
      (
        "Input._chart",
        "cid-1e3u8p2",
        "css-9y6172 css-wdylr4 css-3xax0l css-1fqvgu0 css-o0c7xs",
      ),
    ]
  ];
  
  let _chart =
    CSS.make(
      "cx-_chart cid-1e3u8p2 css-9y6172 css-wdylr4 css-3xax0l css-1fqvgu0 css-o0c7xs",
      [],
    );
