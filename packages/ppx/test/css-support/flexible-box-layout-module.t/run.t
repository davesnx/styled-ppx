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
  File "input.re", line 29, characters 6-13:
  29 | [%css {|flex: $(X.value) $(X.value2);|}];
             ^^^^^^^
  Error: The value X.value has type float
         but an expression was expected of type [< `num of float ]
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css ".css-1crvgc7{align-content:flex-start;}"];
  [@css ".css-4zx96o{align-content:flex-end;}"];
  [@css ".css-1c5t6ef{align-content:space-between;}"];
  [@css ".css-1okulzr{align-content:space-around;}"];
  [@css ".css-1jfvg9w{align-items:flex-start;}"];
  [@css ".css-y1kcm0{align-items:flex-end;}"];
  [@css ".css-1bf7e4w{align-self:flex-start;}"];
  [@css ".css-56sg73{align-self:flex-end;}"];
  [@css ".css-k008qs{display:flex;}"];
  [@css ".css-vxcmzt{display:inline-flex;}"];
  [@css ".css-me3p27{-webkit-flex:none;-ms-flex:none;flex:none;}"];
  [@css ".css-yrit56{-webkit-flex:5 7 10%;-ms-flex:5 7 10%;flex:5 7 10%;}"];
  [@css ".css-kzfr2u{-webkit-flex:2;-ms-flex:2;flex:2;}"];
  [@css ".css-p6wv0x{-webkit-flex:10em;-ms-flex:10em;flex:10em;}"];
  [@css ".css-t6vgg1{-webkit-flex:30%;-ms-flex:30%;flex:30%;}"];
  [@css
    ".css-1draax7{-webkit-flex:min-content;-ms-flex:min-content;flex:min-content;}"
  ];
  [@css ".css-ilthbz{-webkit-flex:1 30px;-ms-flex:1 30px;flex:1 30px;}"];
  [@css ".css-6hx0uu{-webkit-flex:2 2;-ms-flex:2 2;flex:2 2;}"];
  [@css ".css-1rr8a55{-webkit-flex:2 2 10%;-ms-flex:2 2 10%;flex:2 2 10%;}"];
  [@css
    ".css-1x4f3wz{-webkit-flex:var(--var-hvez6j);-ms-flex:var(--var-hvez6j);flex:var(--var-hvez6j);}"
  ];
  [@css
    ".css-19g0la7{-webkit-flex:var(--var-volh69) var(--var-1qwalu0);-ms-flex:var(--var-volh69) var(--var-1qwalu0);flex:var(--var-volh69) var(--var-1qwalu0);}"
  ];
  [@css
    ".css-djecpy{-webkit-flex:var(--var-volh69) var(--var-1qwalu0) var(--var-1u1axvx);-ms-flex:var(--var-volh69) var(--var-1qwalu0) var(--var-1u1axvx);flex:var(--var-volh69) var(--var-1qwalu0) var(--var-1u1axvx);}"
  ];
  [@css
    ".css-1f5dbv2{-webkit-flex:var(--var-volh69_1) var(--var-volh69_2);-ms-flex:var(--var-volh69_1) var(--var-volh69_2);flex:var(--var-volh69_1) var(--var-volh69_2);}"
  ];
  [@css ".css-1vu4n70{flex-basis:auto;}"];
  [@css ".css-1ibwkcj{flex-basis:content;}"];
  [@css ".css-71cjcr{flex-basis:1px;}"];
  [@css
    ".css-1l0z8uk{-webkit-flex-direction:row;-ms-flex-direction:row;flex-direction:row;}"
  ];
  [@css
    ".css-8kj89b{-webkit-flex-direction:row-reverse;-ms-flex-direction:row-reverse;flex-direction:row-reverse;}"
  ];
  [@css
    ".css-cgq59l{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}"
  ];
  [@css
    ".css-qpiomr{-webkit-flex-direction:column-reverse;-ms-flex-direction:column-reverse;flex-direction:column-reverse;}"
  ];
  [@css ".css-19a80vn{flex-flow:row;}"];
  [@css ".css-o5a89u{flex-flow:row-reverse;}"];
  [@css ".css-14pgqdn{flex-flow:column;}"];
  [@css ".css-1tp8tu8{flex-flow:column-reverse;}"];
  [@css ".css-3hl61a{flex-flow:wrap;}"];
  [@css ".css-3myvs8{flex-flow:wrap-reverse;}"];
  [@css ".css-1tshqlk{flex-flow:row wrap;}"];
  [@css ".css-1a1zoft{flex-flow:row-reverse nowrap;}"];
  [@css ".css-1bnl4v1{flex-flow:column wrap;}"];
  [@css ".css-1n8o660{flex-flow:column-reverse wrap-reverse;}"];
  [@css ".css-2uchni{flex-grow:0;}"];
  [@css ".css-otv6bo{flex-grow:5;}"];
  [@css ".css-6voltb{flex-shrink:1;}"];
  [@css ".css-1b75a5q{flex-shrink:10;}"];
  [@css ".css-1n0sxg9{flex-wrap:nowrap;}"];
  [@css ".css-1jkp9i7{flex-wrap:wrap;}"];
  [@css ".css-hp4whp{flex-wrap:wrap-reverse;}"];
  [@css ".css-1fn0841{justify-content:flex-start;}"];
  [@css ".css-1a9getn{justify-content:flex-end;}"];
  [@css ".css-x4dmss{justify-content:space-between;}"];
  [@css ".css-kp4oss{justify-content:space-around;}"];
  [@css ".css-127g5zj{min-height:auto;}"];
  [@css ".css-i9682b{min-width:auto;}"];
  [@css ".css-12zvlbw{order:0;}"];
  [@css ".css-ali80x{order:1;}"];
  module X = {
    let value = 1.;
    let value2 = 1.;
    let flex1 = `num(1.);
    let min = `px(500);
  };
  
  CSS.make("css-1crvgc7", []);
  CSS.make("css-4zx96o", []);
  CSS.make("css-1c5t6ef", []);
  CSS.make("css-1okulzr", []);
  CSS.make("css-1jfvg9w", []);
  CSS.make("css-y1kcm0", []);
  CSS.make("css-1bf7e4w", []);
  CSS.make("css-56sg73", []);
  CSS.make("css-k008qs", []);
  CSS.make("css-vxcmzt", []);
  CSS.make("css-me3p27", []);
  CSS.make("css-yrit56", []);
  CSS.make("css-kzfr2u", []);
  CSS.make("css-p6wv0x", []);
  CSS.make("css-t6vgg1", []);
  CSS.make("css-1draax7", []);
  CSS.make("css-ilthbz", []);
  CSS.make("css-6hx0uu", []);
  CSS.make("css-1rr8a55", []);
  CSS.make(
    "css-1x4f3wz",
    [("--var-hvez6j", CSS.Types.Flex.toString(X.flex1))],
  );
  CSS.make(
    "css-19g0la7",
    [
      ("--var-volh69", CSS.Types.FlexGrow.toString(X.value)),
      ("--var-1qwalu0", CSS.Types.FlexShrink.toString(X.value2)),
    ],
  );
  CSS.make(
    "css-djecpy",
    [
      ("--var-volh69", CSS.Types.FlexGrow.toString(X.value)),
      ("--var-1qwalu0", CSS.Types.FlexShrink.toString(X.value2)),
      ("--var-1u1axvx", CSS.Types.FlexBasis.toString(X.min)),
    ],
  );
  CSS.make(
    "css-1f5dbv2",
    [
      ("--var-volh69_1", CSS.Types.FlexGrow.toString(X.value)),
      ("--var-volh69_2", CSS.Types.FlexShrink.toString(X.value)),
    ],
  );
  CSS.make("css-1vu4n70", []);
  CSS.make("css-1ibwkcj", []);
  CSS.make("css-71cjcr", []);
  CSS.make("css-1l0z8uk", []);
  CSS.make("css-8kj89b", []);
  CSS.make("css-cgq59l", []);
  CSS.make("css-qpiomr", []);
  CSS.make("css-19a80vn", []);
  CSS.make("css-o5a89u", []);
  CSS.make("css-14pgqdn", []);
  CSS.make("css-1tp8tu8", []);
  CSS.make("css-3hl61a", []);
  CSS.make("css-3myvs8", []);
  CSS.make("css-1tshqlk", []);
  CSS.make("css-1a1zoft", []);
  CSS.make("css-1bnl4v1", []);
  CSS.make("css-1n8o660", []);
  CSS.make("css-2uchni", []);
  CSS.make("css-otv6bo", []);
  CSS.make("css-6voltb", []);
  CSS.make("css-1b75a5q", []);
  CSS.make("css-1n0sxg9", []);
  CSS.make("css-1jkp9i7", []);
  CSS.make("css-hp4whp", []);
  CSS.make("css-1fn0841", []);
  CSS.make("css-1a9getn", []);
  CSS.make("css-x4dmss", []);
  CSS.make("css-kp4oss", []);
  CSS.make("css-127g5zj", []);
  CSS.make("css-i9682b", []);
  CSS.make("css-12zvlbw", []);
  CSS.make("css-ali80x", []);
