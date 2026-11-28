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
  [@css "@property --ivpczqd{syntax:\"*\";inherits:false;}"];
  [@css
    ".css-ivpc3ja{background-color:red;}.css-ivpc3ja:nth-child(2n){background-color:blue;}"
  ];
  [@css
    ".css-ivpcxrv{transition:max-height 400ms ease-in-out 0ms;}.css-ivpcxrv > *{opacity:0;transition-duration:400ms;}"
  ];
  [@css
    ".css-ivpc9bq{margin-bottom:24px;}@media (min-width: 1024px) {.css-ivpc9bq{width:50%;}}"
  ];
  [@css
    ".css-ivpcpim{transition:transform 200ms ease-in-out 0ms;}.css-ivpcpim.contentAfterOpen{-webkit-transform:translateY(16px);-moz-transform:translateY(16px);-ms-transform:translateY(16px);transform:translateY(16px);}"
  ];
  [@css
    ".css-ivpcnda{border-bottom:1px solid black;}.css-ivpcnda:last-child{padding-bottom:0;border-bottom-width:0;}"
  ];
  [@css
    ".css-ivpc718{justify-content:space-between;}@media (min-width: 768px) {.css-ivpc718{justify-content:center;}}"
  ];
  [@css
    ".css-ivpc5ah{width:-webkit-min-content;width:-moz-min-content;width:min-content;}@media (min-width: 1200px) {.css-ivpc5ah{padding-top:8px;}}"
  ];
  [@css ".css-ivpc93z{height:100%;}.css-ivpc93z h4{padding:0;}"];
  [@css
    ".css-ivpcdq4{transition:all 200ms ease 0ms;}.css-ivpcdq4.sidebarClosed{min-width:0;max-width:0;opacity:0;overflow:hidden;padding-left:0;padding-right:0;}"
  ];
  [@css ".css-ivpc5nr{color:red;}.css-ivpc5nr .child{color:blue;}"];
  [@css ".css-ivpcbgo{color:red;}.css-ivpcbgo div{color:blue;}"];
  [@css ".css-ivpc7ii{color:red;}.css-ivpc7ii #child{color:blue;}"];
  [@css ".css-ivpciey{color:red;}.css-ivpciey svg path{fill:blue;}"];
  [@css
    ".css-ivpc019{border-bottom:1px solid var(--ivpczqd);}.css-ivpc019:last-child{padding-bottom:0;border-bottom-width:0;}"
  ];
  [@css.classes
    [
      ("css-ivpc3ja", 1, "Input._case1", "input.re", 3, 2, 8, 0),
      ("css-ivpcxrv", 2, "Input._case2", "input.re", 13, 2, 17, 0),
      ("css-ivpc9bq", 3, "Input._case3", "input.re", 22, 2, 25, 0),
      ("css-ivpcpim", 4, "Input._case4", "input.re", 30, 2, 34, 0),
      ("css-ivpcnda", 5, "Input._case5", "input.re", 39, 2, 45, 0),
      ("css-ivpc718", 6, "Input._case6", "input.re", 50, 2, 53, 0),
      ("css-ivpc5ah", 7, "Input._case7", "input.re", 58, 2, 61, 0),
      ("css-ivpc93z", 8, "Input._case8", "input.re", 66, 2, 69, 0),
      ("css-ivpcdq4", 9, "Input._case9", "input.re", 74, 2, 82, 0),
      ("css-ivpc5nr", 10, "Input._case10", "input.re", 87, 2, 91, 0),
      ("css-ivpcbgo", 11, "Input._case11", "input.re", 96, 2, 100, 0),
      ("css-ivpc7ii", 12, "Input._case12", "input.re", 105, 2, 109, 0),
      ("css-ivpciey", 13, "Input._case13", "input.re", 114, 2, 118, 0),
      ("css-ivpc019", 14, "Input._case14", "input.re", 123, 2, 128, 0),
    ]
  ];
  [@css.bindings
    [
      ("Input._case1", "css-ivpc3ja"),
      ("Input._case2", "css-ivpcxrv"),
      ("Input._case3", "css-ivpc9bq"),
      ("Input._case4", "css-ivpcpim"),
      ("Input._case5", "css-ivpcnda"),
      ("Input._case6", "css-ivpc718"),
      ("Input._case7", "css-ivpc5ah"),
      ("Input._case8", "css-ivpc93z"),
      ("Input._case9", "css-ivpcdq4"),
      ("Input._case10", "css-ivpc5nr"),
      ("Input._case11", "css-ivpcbgo"),
      ("Input._case12", "css-ivpc7ii"),
      ("Input._case13", "css-ivpciey"),
      ("Input._case14", ""),
    ]
  ];
  let _case1 = CSS.make("css-ivpc3ja", []);
  
  let _case2 = CSS.make("css-ivpcxrv", []);
  
  let _case3 = CSS.make("css-ivpc9bq", []);
  
  let _case4 = CSS.make("css-ivpcpim", []);
  
  let _case5 = CSS.make("css-ivpcnda", []);
  
  let _case6 = CSS.make("css-ivpc718", []);
  
  let _case7 = CSS.make("css-ivpc5ah", []);
  
  let _case8 = CSS.make("css-ivpc93z", []);
  
  let _case9 = CSS.make("css-ivpcdq4", []);
  
  let _case10 = CSS.make("css-ivpc5nr", []);
  
  let _case11 = CSS.make("css-ivpcbgo", []);
  
  let _case12 = CSS.make("css-ivpc7ii", []);
  
  let _case13 = CSS.make("css-ivpciey", []);
  
  let _case14 = borderColor =>
    CSS.make(
      "css-ivpc019",
      [("--ivpczqd", CSS.Types.Color.toString(borderColor))],
    );


