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
  [@css "@property --4qjwcf-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --jy4s5h-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --jy4s5h-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --s61frk-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --s61frk-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --s61frk-2{syntax:\"*\";inherits:false;}"];
  [@css "@property --1pwc8d-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1pwc8d-1{syntax:\"*\";inherits:false;}"];
  [@css ".css-18zheuw{align-content:flex-start;}"];
  [@css ".css-w042q{align-content:flex-end;}"];
  [@css ".css-qqo29o{align-content:space-between;}"];
  [@css ".css-17z1l5v{align-content:space-around;}"];
  [@css ".css-91axpi{align-items:flex-start;}"];
  [@css ".css-y87vcs{align-items:flex-end;}"];
  [@css ".css-t5epsi{align-self:flex-start;}"];
  [@css ".css-189m1wn{align-self:flex-end;}"];
  [@css ".css-1ycmu5d{display:flex;}"];
  [@css ".css-13t9kv0{display:inline-flex;}"];
  [@css ".css-krl3lc{-webkit-flex:none;-ms-flex:none;flex:none;}"];
  [@css ".css-3x7c4q{-webkit-flex:5 7 10%;-ms-flex:5 7 10%;flex:5 7 10%;}"];
  [@css ".css-pz7v5s{-webkit-flex:2;-ms-flex:2;flex:2;}"];
  [@css ".css-1x8t50t{-webkit-flex:10em;-ms-flex:10em;flex:10em;}"];
  [@css ".css-h2ioij{-webkit-flex:30%;-ms-flex:30%;flex:30%;}"];
  [@css
    ".css-1ql9urq{-webkit-flex:min-content;-ms-flex:min-content;flex:min-content;}"
  ];
  [@css ".css-p0kgvu{-webkit-flex:1 30px;-ms-flex:1 30px;flex:1 30px;}"];
  [@css ".css-pfrh0q{-webkit-flex:2 2;-ms-flex:2 2;flex:2 2;}"];
  [@css ".css-1v0k0is{-webkit-flex:2 2 10%;-ms-flex:2 2 10%;flex:2 2 10%;}"];
  [@css
    ".css-4qjwcf{-webkit-flex:var(--4qjwcf-0);-ms-flex:var(--4qjwcf-0);flex:var(--4qjwcf-0);}"
  ];
  [@css
    ".css-jy4s5h{-webkit-flex:var(--jy4s5h-0) var(--jy4s5h-1);-ms-flex:var(--jy4s5h-0) var(--jy4s5h-1);flex:var(--jy4s5h-0) var(--jy4s5h-1);}"
  ];
  [@css
    ".css-s61frk{-webkit-flex:var(--s61frk-0) var(--s61frk-1) var(--s61frk-2);-ms-flex:var(--s61frk-0) var(--s61frk-1) var(--s61frk-2);flex:var(--s61frk-0) var(--s61frk-1) var(--s61frk-2);}"
  ];
  [@css
    ".css-1pwc8d{-webkit-flex:var(--1pwc8d-0) var(--1pwc8d-1);-ms-flex:var(--1pwc8d-0) var(--1pwc8d-1);flex:var(--1pwc8d-0) var(--1pwc8d-1);}"
  ];
  [@css ".css-1hz8ct3{flex-basis:auto;}"];
  [@css ".css-wye65z{flex-basis:content;}"];
  [@css ".css-8rcp8n{flex-basis:1px;}"];
  [@css
    ".css-1kfz4hz{-webkit-flex-direction:row;-ms-flex-direction:row;flex-direction:row;}"
  ];
  [@css
    ".css-1embepo{-webkit-flex-direction:row-reverse;-ms-flex-direction:row-reverse;flex-direction:row-reverse;}"
  ];
  [@css
    ".css-81mhjl{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}"
  ];
  [@css
    ".css-1n18ilq{-webkit-flex-direction:column-reverse;-ms-flex-direction:column-reverse;flex-direction:column-reverse;}"
  ];
  [@css ".css-1h1fmbc{flex-flow:row;}"];
  [@css ".css-1v2hse5{flex-flow:row-reverse;}"];
  [@css ".css-wd5sr8{flex-flow:column;}"];
  [@css ".css-185pm6e{flex-flow:column-reverse;}"];
  [@css ".css-o29s4v{flex-flow:wrap;}"];
  [@css ".css-4jb5y4{flex-flow:wrap-reverse;}"];
  [@css ".css-n4q4uj{flex-flow:row wrap;}"];
  [@css ".css-1u6volk{flex-flow:row-reverse nowrap;}"];
  [@css ".css-1yxf8qt{flex-flow:column wrap;}"];
  [@css ".css-smkprg{flex-flow:column-reverse wrap-reverse;}"];
  [@css ".css-1t03h6w{flex-grow:0;}"];
  [@css ".css-js1s4f{flex-grow:5;}"];
  [@css ".css-10l5srq{flex-shrink:1;}"];
  [@css ".css-htd6j{flex-shrink:10;}"];
  [@css ".css-10czps5{flex-wrap:nowrap;}"];
  [@css ".css-sua0hp{flex-wrap:wrap;}"];
  [@css ".css-j5xhvt{flex-wrap:wrap-reverse;}"];
  [@css ".css-eyzn10{justify-content:flex-start;}"];
  [@css ".css-e2q2i8{justify-content:flex-end;}"];
  [@css ".css-1ij33rv{justify-content:space-between;}"];
  [@css ".css-bvt3p0{justify-content:space-around;}"];
  [@css ".css-olvvoc{min-height:auto;}"];
  [@css ".css-15wm6um{min-width:auto;}"];
  [@css ".css-1bz2151{order:0;}"];
  [@css ".css-17x3nre{order:1;}"];
  [@css.classes
    [
      ("css-18zheuw", 8, "", "input.re", 9, 8, 9, 33),
      ("css-w042q", 9, "", "input.re", 10, 8, 10, 31),
      ("css-qqo29o", 10, "", "input.re", 11, 8, 11, 36),
      ("css-17z1l5v", 11, "", "input.re", 12, 8, 12, 35),
      ("css-91axpi", 12, "", "input.re", 13, 8, 13, 31),
      ("css-y87vcs", 13, "", "input.re", 14, 8, 14, 29),
      ("css-t5epsi", 14, "", "input.re", 15, 8, 15, 30),
      ("css-189m1wn", 15, "", "input.re", 16, 8, 16, 28),
      ("css-1ycmu5d", 16, "", "input.re", 17, 8, 17, 21),
      ("css-13t9kv0", 17, "", "input.re", 18, 8, 18, 28),
      ("css-krl3lc", 18, "", "input.re", 19, 8, 19, 18),
      ("css-3x7c4q", 19, "", "input.re", 20, 8, 20, 21),
      ("css-pz7v5s", 20, "", "input.re", 21, 8, 21, 16),
      ("css-1x8t50t", 21, "", "input.re", 22, 8, 22, 19),
      ("css-h2ioij", 22, "", "input.re", 23, 8, 23, 18),
      ("css-1ql9urq", 23, "", "input.re", 24, 8, 24, 26),
      ("css-p0kgvu", 24, "", "input.re", 25, 8, 25, 21),
      ("css-pfrh0q", 25, "", "input.re", 26, 8, 26, 18),
      ("css-1v0k0is", 26, "", "input.re", 27, 8, 27, 22),
      ("css-4qjwcf", 27, "", "input.re", 28, 8, 28, 25),
      ("css-jy4s5h", 28, "", "input.re", 29, 8, 29, 37),
      ("css-s61frk", 29, "", "input.re", 30, 8, 30, 46),
      ("css-1pwc8d", 30, "", "input.re", 31, 8, 31, 36),
      ("css-1hz8ct3", 31, "", "input.re", 32, 8, 32, 24),
      ("css-wye65z", 32, "", "input.re", 33, 8, 33, 27),
      ("css-8rcp8n", 33, "", "input.re", 34, 8, 34, 23),
      ("css-1kfz4hz", 34, "", "input.re", 35, 8, 35, 27),
      ("css-1embepo", 35, "", "input.re", 36, 8, 36, 35),
      ("css-81mhjl", 36, "", "input.re", 37, 8, 37, 30),
      ("css-1n18ilq", 37, "", "input.re", 38, 8, 38, 38),
      ("css-1h1fmbc", 38, "", "input.re", 39, 8, 39, 22),
      ("css-1v2hse5", 39, "", "input.re", 40, 8, 40, 30),
      ("css-wd5sr8", 40, "", "input.re", 41, 8, 41, 25),
      ("css-185pm6e", 41, "", "input.re", 42, 8, 42, 33),
      ("css-o29s4v", 42, "", "input.re", 43, 8, 43, 23),
      ("css-4jb5y4", 43, "", "input.re", 44, 8, 44, 31),
      ("css-n4q4uj", 44, "", "input.re", 45, 8, 45, 27),
      ("css-1u6volk", 45, "", "input.re", 46, 8, 46, 37),
      ("css-1yxf8qt", 46, "", "input.re", 47, 8, 47, 30),
      ("css-smkprg", 47, "", "input.re", 48, 8, 48, 46),
      ("css-1t03h6w", 48, "", "input.re", 49, 8, 49, 20),
      ("css-js1s4f", 49, "", "input.re", 50, 8, 50, 20),
      ("css-10l5srq", 50, "", "input.re", 51, 8, 51, 22),
      ("css-htd6j", 51, "", "input.re", 52, 8, 52, 23),
      ("css-10czps5", 52, "", "input.re", 53, 8, 53, 25),
      ("css-sua0hp", 53, "", "input.re", 54, 8, 54, 23),
      ("css-j5xhvt", 54, "", "input.re", 55, 8, 55, 31),
      ("css-eyzn10", 55, "", "input.re", 56, 8, 56, 35),
      ("css-e2q2i8", 56, "", "input.re", 57, 8, 57, 33),
      ("css-1ij33rv", 57, "", "input.re", 58, 8, 58, 38),
      ("css-bvt3p0", 58, "", "input.re", 59, 8, 59, 37),
      ("css-olvvoc", 59, "", "input.re", 60, 8, 60, 24),
      ("css-15wm6um", 60, "", "input.re", 61, 8, 61, 23),
      ("css-1bz2151", 61, "", "input.re", 62, 8, 62, 16),
      ("css-17x3nre", 62, "", "input.re", 63, 8, 63, 16),
    ]
  ];
  module X = {
    let value = `num(1.);
    let value2 = `num(1.);
    let flex1 = `num(1.);
    let min = `px(500);
  };
  
  CSS.make("css-18zheuw", []);
  CSS.make("css-w042q", []);
  CSS.make("css-qqo29o", []);
  CSS.make("css-17z1l5v", []);
  CSS.make("css-91axpi", []);
  CSS.make("css-y87vcs", []);
  CSS.make("css-t5epsi", []);
  CSS.make("css-189m1wn", []);
  CSS.make("css-1ycmu5d", []);
  CSS.make("css-13t9kv0", []);
  CSS.make("css-krl3lc", []);
  CSS.make("css-3x7c4q", []);
  CSS.make("css-pz7v5s", []);
  CSS.make("css-1x8t50t", []);
  CSS.make("css-h2ioij", []);
  CSS.make("css-1ql9urq", []);
  CSS.make("css-p0kgvu", []);
  CSS.make("css-pfrh0q", []);
  CSS.make("css-1v0k0is", []);
  CSS.make("css-4qjwcf", [("--4qjwcf-0", CSS.Types.Flex.toString(X.flex1))]);
  CSS.make(
    "css-jy4s5h",
    [
      ("--jy4s5h-0", CSS.Types.FlexGrow.toString(X.value)),
      ("--jy4s5h-1", CSS.Types.FlexShrink.toString(X.value2)),
    ],
  );
  CSS.make(
    "css-s61frk",
    [
      ("--s61frk-0", CSS.Types.FlexGrow.toString(X.value)),
      ("--s61frk-1", CSS.Types.FlexShrink.toString(X.value2)),
      ("--s61frk-2", CSS.Types.FlexBasis.toString(X.min)),
    ],
  );
  CSS.make(
    "css-1pwc8d",
    [
      ("--1pwc8d-0", CSS.Types.FlexGrow.toString(X.value)),
      ("--1pwc8d-1", CSS.Types.FlexShrink.toString(X.value)),
    ],
  );
  CSS.make("css-1hz8ct3", []);
  CSS.make("css-wye65z", []);
  CSS.make("css-8rcp8n", []);
  CSS.make("css-1kfz4hz", []);
  CSS.make("css-1embepo", []);
  CSS.make("css-81mhjl", []);
  CSS.make("css-1n18ilq", []);
  CSS.make("css-1h1fmbc", []);
  CSS.make("css-1v2hse5", []);
  CSS.make("css-wd5sr8", []);
  CSS.make("css-185pm6e", []);
  CSS.make("css-o29s4v", []);
  CSS.make("css-4jb5y4", []);
  CSS.make("css-n4q4uj", []);
  CSS.make("css-1u6volk", []);
  CSS.make("css-1yxf8qt", []);
  CSS.make("css-smkprg", []);
  CSS.make("css-1t03h6w", []);
  CSS.make("css-js1s4f", []);
  CSS.make("css-10l5srq", []);
  CSS.make("css-htd6j", []);
  CSS.make("css-10czps5", []);
  CSS.make("css-sua0hp", []);
  CSS.make("css-j5xhvt", []);
  CSS.make("css-eyzn10", []);
  CSS.make("css-e2q2i8", []);
  CSS.make("css-1ij33rv", []);
  CSS.make("css-bvt3p0", []);
  CSS.make("css-olvvoc", []);
  CSS.make("css-15wm6um", []);
  CSS.make("css-1bz2151", []);
  CSS.make("css-17x3nre", []);
