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
  [@css "@property --borderColor-knlnef{syntax:\"*\";inherits:false;}"];
  [@css ".css-f5yfbg-_case1{background-color:red;}"];
  [@css ".css-dtjebq-_case1:nth-child(2n){background-color:blue;}"];
  [@css ".css-1mzhirp-_case2{transition:max-height 400ms ease-in-out 0ms;}"];
  [@css ".css-lwctui-_case2 > *{opacity:0;}"];
  [@css ".css-15xyb5v-_case2 > *{transition-duration:400ms;}"];
  [@css ".css-i3pbo-_case3{margin-bottom:24px;}"];
  [@css "@media (min-width: 1024px) {.css-1h5ewfy-_case3{width:50%;}}"];
  [@css ".css-xrfqgp-_case4{transition:transform 200ms ease-in-out 0ms;}"];
  [@css
    ".css-19gg2jl-_case4.contentAfterOpen{-webkit-transform:translateY(16px);-moz-transform:translateY(16px);-ms-transform:translateY(16px);transform:translateY(16px);}"
  ];
  [@css ".css-ycfik3-_case5{border-bottom:1px solid black;}"];
  [@css ".css-yhnnmp-_case5:last-child{padding-bottom:0;}"];
  [@css ".css-dyk6wi-_case5:last-child{border-bottom-width:0;}"];
  [@css ".css-x4dmss-_case6{justify-content:space-between;}"];
  [@css
    "@media (min-width: 768px) {.css-iaynwb-_case6{justify-content:center;}}"
  ];
  [@css
    ".css-17hckkm-_case7{width:-webkit-min-content;width:-moz-min-content;width:min-content;}"
  ];
  [@css "@media (min-width: 1200px) {.css-1ffl96r-_case7{padding-top:8px;}}"];
  [@css ".css-10klw3m-_case8{height:100%;}"];
  [@css ".css-xkam5k-_case8 h4{padding:0;}"];
  [@css ".css-tjsoaq-_case9{transition:all 200ms ease 0ms;}"];
  [@css ".css-jvb0jf-_case9.sidebarClosed{min-width:0;}"];
  [@css ".css-18jcclb-_case9.sidebarClosed{max-width:0;}"];
  [@css ".css-v8p7lg-_case9.sidebarClosed{opacity:0;}"];
  [@css ".css-8asth4-_case9.sidebarClosed{overflow:hidden;}"];
  [@css ".css-cs7psf-_case9.sidebarClosed{padding-left:0;}"];
  [@css ".css-1u700a4-_case9.sidebarClosed{padding-right:0;}"];
  [@css ".css-tokvmb-_case10{color:red;}"];
  [@css ".css-1bx01wv-_case10 .child{color:blue;}"];
  [@css ".css-tokvmb-_case11{color:red;}"];
  [@css ".css-1rwzcut-_case11 div{color:blue;}"];
  [@css ".css-tokvmb-_case12{color:red;}"];
  [@css ".css-zvekaf-_case12 #child{color:blue;}"];
  [@css ".css-tokvmb-_case13{color:red;}"];
  [@css ".css-1jt3q3v-_case13 svg path{fill:blue;}"];
  [@css
    ".css-17mmn6x-_case14{border-bottom:1px solid var(--borderColor-knlnef);}"
  ];
  [@css ".css-yhnnmp-_case14:last-child{padding-bottom:0;}"];
  [@css ".css-dyk6wi-_case14:last-child{border-bottom-width:0;}"];
  [@css.bindings
    [
      ("Input._case1", "css-f5yfbg-_case1 css-dtjebq-_case1"),
      (
        "Input._case2",
        "css-1mzhirp-_case2 css-lwctui-_case2 css-15xyb5v-_case2",
      ),
      ("Input._case3", "css-i3pbo-_case3 css-1h5ewfy-_case3"),
      ("Input._case4", "css-xrfqgp-_case4 css-19gg2jl-_case4"),
      ("Input._case5", "css-ycfik3-_case5 css-yhnnmp-_case5 css-dyk6wi-_case5"),
      ("Input._case6", "css-x4dmss-_case6 css-iaynwb-_case6"),
      ("Input._case7", "css-17hckkm-_case7 css-1ffl96r-_case7"),
      ("Input._case8", "css-10klw3m-_case8 css-xkam5k-_case8"),
      (
        "Input._case9",
        "css-tjsoaq-_case9 css-jvb0jf-_case9 css-18jcclb-_case9 css-v8p7lg-_case9 css-8asth4-_case9 css-cs7psf-_case9 css-1u700a4-_case9",
      ),
      ("Input._case10", "css-tokvmb-_case10 css-1bx01wv-_case10"),
      ("Input._case11", "css-tokvmb-_case11 css-1rwzcut-_case11"),
      ("Input._case12", "css-tokvmb-_case12 css-zvekaf-_case12"),
      ("Input._case13", "css-tokvmb-_case13 css-1jt3q3v-_case13"),
      (
        "Input._case14",
        "css-17mmn6x-_case14 css-yhnnmp-_case14 css-dyk6wi-_case14",
      ),
    ]
  ];
  let _case1 = CSS.make("css-f5yfbg-_case1 css-dtjebq-_case1", []);
  
  let _case2 =
    CSS.make("css-1mzhirp-_case2 css-lwctui-_case2 css-15xyb5v-_case2", []);
  
  let _case3 = CSS.make("css-i3pbo-_case3 css-1h5ewfy-_case3", []);
  
  let _case4 = CSS.make("css-xrfqgp-_case4 css-19gg2jl-_case4", []);
  
  let _case5 =
    CSS.make("css-ycfik3-_case5 css-yhnnmp-_case5 css-dyk6wi-_case5", []);
  
  let _case6 = CSS.make("css-x4dmss-_case6 css-iaynwb-_case6", []);
  
  let _case7 = CSS.make("css-17hckkm-_case7 css-1ffl96r-_case7", []);
  
  let _case8 = CSS.make("css-10klw3m-_case8 css-xkam5k-_case8", []);
  
  let _case9 =
    CSS.make(
      "css-tjsoaq-_case9 css-jvb0jf-_case9 css-18jcclb-_case9 css-v8p7lg-_case9 css-8asth4-_case9 css-cs7psf-_case9 css-1u700a4-_case9",
      [],
    );
  
  let _case10 = CSS.make("css-tokvmb-_case10 css-1bx01wv-_case10", []);
  
  let _case11 = CSS.make("css-tokvmb-_case11 css-1rwzcut-_case11", []);
  
  let _case12 = CSS.make("css-tokvmb-_case12 css-zvekaf-_case12", []);
  
  let _case13 = CSS.make("css-tokvmb-_case13 css-1jt3q3v-_case13", []);
  
  let _case14 = borderColor =>
    CSS.make(
      "css-17mmn6x-_case14 css-yhnnmp-_case14 css-dyk6wi-_case14",
      [("--borderColor-knlnef", CSS.Types.Color.toString(borderColor))],
    );


