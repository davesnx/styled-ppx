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


  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-1crvgc7{align-content:flex-start;}\n.css-4zx96o{align-content:flex-end;}\n.css-1c5t6ef{align-content:space-between;}\n.css-1okulzr{align-content:space-around;}\n.css-1jfvg9w{align-items:flex-start;}\n.css-y1kcm0{align-items:flex-end;}\n.css-1bf7e4w{align-self:flex-start;}\n.css-56sg73{align-self:flex-end;}\n.css-k008qs{display:flex;}\n.css-vxcmzt{display:inline-flex;}\n.css-me3p27{flex:none;}\n.css-yrit56{flex:5 7 10%;}\n.css-kzfr2u{flex:2;}\n.css-p6wv0x{flex:10em;}\n.css-t6vgg1{flex:30%;}\n.css-1draax7{flex:min-content;}\n.css-ilthbz{flex:1 30px;}\n.css-6hx0uu{flex:2 2;}\n.css-1rr8a55{flex:2 2 10%;}\n.css-1x4f3wz{flex:var(--var-hvez6j);}\n.css-1f5dbv2{flex:var(--var-volh69) var(--var-volh69);}\n.css-k78zd2{flex:var(--var-volh69) var(--var-volh69) var(--var-1u1axvx);}\n.css-1vu4n70{flex-basis:auto;}\n.css-1ibwkcj{flex-basis:content;}\n.css-71cjcr{flex-basis:1px;}\n.css-1l0z8uk{flex-direction:row;}\n.css-8kj89b{flex-direction:row-reverse;}\n.css-cgq59l{flex-direction:column;}\n.css-qpiomr{flex-direction:column-reverse;}\n.css-19a80vn{flex-flow:row;}\n.css-o5a89u{flex-flow:row-reverse;}\n.css-14pgqdn{flex-flow:column;}\n.css-1tp8tu8{flex-flow:column-reverse;}\n.css-3hl61a{flex-flow:wrap;}\n.css-3myvs8{flex-flow:wrap-reverse;}\n.css-1tshqlk{flex-flow:row wrap;}\n.css-1a1zoft{flex-flow:row-reverse nowrap;}\n.css-1bnl4v1{flex-flow:column wrap;}\n.css-1n8o660{flex-flow:column-reverse wrap-reverse;}\n.css-2uchni{flex-grow:0;}\n.css-otv6bo{flex-grow:5;}\n.css-6voltb{flex-shrink:1;}\n.css-1b75a5q{flex-shrink:10;}\n.css-1n0sxg9{flex-wrap:nowrap;}\n.css-1jkp9i7{flex-wrap:wrap;}\n.css-hp4whp{flex-wrap:wrap-reverse;}\n.css-1fn0841{justify-content:flex-start;}\n.css-1a9getn{justify-content:flex-end;}\n.css-x4dmss{justify-content:space-between;}\n.css-kp4oss{justify-content:space-around;}\n.css-127g5zj{min-height:auto;}\n.css-i9682b{min-width:auto;}\n.css-12zvlbw{order:0;}\n.css-ali80x{order:1;}\n"
  ];
  module X = {
    let value = 1.;
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
    "css-1f5dbv2",
    [("--var-volh69", CSS.Types.Flex.toString(X.value))],
  );
  CSS.make(
    "css-k78zd2",
    [
      ("--var-volh69", CSS.Types.Flex.toString(X.value)),
      ("--var-1u1axvx", CSS.Types.Flex.toString(X.min)),
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
