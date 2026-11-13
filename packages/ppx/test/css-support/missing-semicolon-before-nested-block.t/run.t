This test ensures declaration lists accept nested selectors and `@media` blocks even when the preceding declaration omits its trailing semicolon.

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
  [@css "@property --wacmyh-0{syntax:\"*\";inherits:false;}"];
  [@css
    ".css-gxf3ja{background-color:red;}.css-gxf3ja:nth-child(2n){background-color:blue;}"
  ];
  [@css
    ".css-130xrv{transition:max-height 400ms ease-in-out 0ms;}.css-130xrv > *{opacity:0;transition-duration:400ms;}"
  ];
  [@css
    ".css-1omc9bq{margin-bottom:24px;}@media (min-width: 1024px) {.css-1omc9bq{width:50%;}}"
  ];
  [@css
    ".css-1gqepim{transition:transform 200ms ease-in-out 0ms;}.css-1gqepim.contentAfterOpen{-webkit-transform:translateY(16px);-moz-transform:translateY(16px);-ms-transform:translateY(16px);transform:translateY(16px);}"
  ];
  [@css
    ".css-svjnda{border-bottom:1px solid black;}.css-svjnda:last-child{padding-bottom:0;border-bottom-width:0;}"
  ];
  [@css
    ".css-flu718{justify-content:space-between;}@media (min-width: 768px) {.css-flu718{justify-content:center;}}"
  ];
  [@css
    ".css-1f005ah{width:-webkit-min-content;width:-moz-min-content;width:min-content;}@media (min-width: 1200px) {.css-1f005ah{padding-top:8px;}}"
  ];
  [@css ".css-1sjz93z{height:100%;}.css-1sjz93z h4{padding:0;}"];
  [@css
    ".css-1inrdq4{transition:all 200ms ease 0ms;}.css-1inrdq4.sidebarClosed{min-width:0;max-width:0;opacity:0;overflow:hidden;padding-left:0;padding-right:0;}"
  ];
  [@css ".css-1hsq5nr{color:red;}.css-1hsq5nr .child{color:blue;}"];
  [@css ".css-6kxbgo{color:red;}.css-6kxbgo div{color:blue;}"];
  [@css ".css-c8v7ii{color:red;}.css-c8v7ii #child{color:blue;}"];
  [@css ".css-rdziey{color:red;}.css-rdziey svg path{fill:blue;}"];
  [@css
    ".css-wacmyh{border-bottom:1px solid var(--wacmyh-0);}.css-wacmyh:last-child{padding-bottom:0;border-bottom-width:0;}"
  ];
  [@css.classes
    [
      ("css-gxf3ja", 1, "Input._case1", "input.re", 3, 2, 8, 0),
      ("css-130xrv", 2, "Input._case2", "input.re", 13, 2, 17, 0),
      ("css-1omc9bq", 3, "Input._case3", "input.re", 22, 2, 25, 0),
      ("css-1gqepim", 4, "Input._case4", "input.re", 30, 2, 34, 0),
      ("css-svjnda", 5, "Input._case5", "input.re", 39, 2, 45, 0),
      ("css-flu718", 6, "Input._case6", "input.re", 50, 2, 53, 0),
      ("css-1f005ah", 7, "Input._case7", "input.re", 58, 2, 61, 0),
      ("css-1sjz93z", 8, "Input._case8", "input.re", 66, 2, 69, 0),
      ("css-1inrdq4", 9, "Input._case9", "input.re", 74, 2, 82, 0),
      ("css-1hsq5nr", 10, "Input._case10", "input.re", 87, 2, 91, 0),
      ("css-6kxbgo", 11, "Input._case11", "input.re", 96, 2, 100, 0),
      ("css-c8v7ii", 12, "Input._case12", "input.re", 105, 2, 109, 0),
      ("css-rdziey", 13, "Input._case13", "input.re", 114, 2, 118, 0),
      ("css-wacmyh", 14, "Input._case14", "input.re", 123, 2, 128, 0),
    ]
  ];
  [@css.bindings
    [
      ("Input._case1", "css-gxf3ja"),
      ("Input._case2", "css-130xrv"),
      ("Input._case3", "css-1omc9bq"),
      ("Input._case4", "css-1gqepim"),
      ("Input._case5", "css-svjnda"),
      ("Input._case6", "css-flu718"),
      ("Input._case7", "css-1f005ah"),
      ("Input._case8", "css-1sjz93z"),
      ("Input._case9", "css-1inrdq4"),
      ("Input._case10", "css-1hsq5nr"),
      ("Input._case11", "css-6kxbgo"),
      ("Input._case12", "css-c8v7ii"),
      ("Input._case13", "css-rdziey"),
      ("Input._case14", ""),
    ]
  ];
  let _case1 = CSS.make("css-gxf3ja", []);
  
  let _case2 = CSS.make("css-130xrv", []);
  
  let _case3 = CSS.make("css-1omc9bq", []);
  
  let _case4 = CSS.make("css-1gqepim", []);
  
  let _case5 = CSS.make("css-svjnda", []);
  
  let _case6 = CSS.make("css-flu718", []);
  
  let _case7 = CSS.make("css-1f005ah", []);
  
  let _case8 = CSS.make("css-1sjz93z", []);
  
  let _case9 = CSS.make("css-1inrdq4", []);
  
  let _case10 = CSS.make("css-1hsq5nr", []);
  
  let _case11 = CSS.make("css-6kxbgo", []);
  
  let _case12 = CSS.make("css-c8v7ii", []);
  
  let _case13 = CSS.make("css-rdziey", []);
  
  let _case14 = borderColor =>
    CSS.make(
      "css-wacmyh",
      [("--wacmyh-0", CSS.Types.Color.toString(borderColor))],
    );


