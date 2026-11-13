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
    ".css-lj9e4y{-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}.css-lj9e4y .recharts-cartesian-grid-horizontal line:nth-last-child(1){stroke-opacity:0;}.css-lj9e4y .recharts-cartesian-grid-horizontal line:nth-last-child(2){stroke-opacity:0;}.css-lj9e4y .recharts-scatter .recharts-scatter-symbol .recharts-symbols{opacity:0.8;}.css-lj9e4y .recharts-scatter .recharts-scatter-symbol .recharts-symbols:hover{opacity:1;}"
  ];
  [@css.classes [("css-lj9e4y", 0, "Input._chart", "input.re", 10, 2, 27, 0)]];
  [@css.bindings [("Input._chart", "css-lj9e4y")]];
  
  let _chart = CSS.make("css-lj9e4y", []);
