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
    ".css-9y6172-_chart{-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}"
  ];
  [@css
    ".css-wdylr4-_chart .recharts-cartesian-grid-horizontal line:nth-last-child(1){stroke-opacity:0;}"
  ];
  [@css
    ".css-3xax0l-_chart .recharts-cartesian-grid-horizontal line:nth-last-child(2){stroke-opacity:0;}"
  ];
  [@css
    ".css-1fqvgu0-_chart .recharts-scatter .recharts-scatter-symbol .recharts-symbols{opacity:0.8;}"
  ];
  [@css
    ".css-o0c7xs-_chart .recharts-scatter .recharts-scatter-symbol .recharts-symbols:hover{opacity:1;}"
  ];
  [@css.bindings
    [
      (
        "Input._chart",
        "css-9y6172-_chart css-wdylr4-_chart css-3xax0l-_chart css-1fqvgu0-_chart css-o0c7xs-_chart",
      ),
    ]
  ];
  
  let _chart =
    CSS.make(
      "css-9y6172-_chart css-wdylr4-_chart css-3xax0l-_chart css-1fqvgu0-_chart css-o0c7xs-_chart",
      [],
    );
