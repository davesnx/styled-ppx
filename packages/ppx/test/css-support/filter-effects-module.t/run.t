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
  [@css "@property --color-qfwu7a_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-qfwu7a_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-qfwu7a_3{syntax:\"*\";inherits:false;}"];
  [@css ".a-lcnm6u{-webkit-filter:none;filter:none;}"];
  [@css ".a-1ifcuuo{-webkit-filter:url(\"#id\");filter:url(\"#id\");}"];
  [@css
    ".a-wzp7li{-webkit-filter:url(\"image.svg#id\");filter:url(\"image.svg#id\");}"
  ];
  [@css ".a-enxr2q{-webkit-filter:blur(5px);filter:blur(5px);}"];
  [@css ".a-ckxntt{-webkit-filter:brightness(0.5);filter:brightness(0.5);}"];
  [@css ".a-1o440fd{-webkit-filter:contrast(150%);filter:contrast(150%);}"];
  [@css
    ".a-1xj4bqh{-webkit-filter:drop-shadow(5px 5px 10px);filter:drop-shadow(5px 5px 10px);}"
  ];
  [@css
    ".a-1arlta4{-webkit-filter:drop-shadow(15px 15px 15px #123);filter:drop-shadow(15px 15px 15px #123);}"
  ];
  [@css ".a-10pv1a9{-webkit-filter:grayscale(50%);filter:grayscale(50%);}"];
  [@css ".a-dycrc5{-webkit-filter:hue-rotate(50deg);filter:hue-rotate(50deg);}"];
  [@css ".a-1vaakyf{-webkit-filter:invert(50%);filter:invert(50%);}"];
  [@css ".a-nhtt82{-webkit-filter:opacity(50%);filter:opacity(50%);}"];
  [@css ".a-nwh2v6{-webkit-filter:sepia(50%);filter:sepia(50%);}"];
  [@css ".a-1e0jie{-webkit-filter:saturate(150%);filter:saturate(150%);}"];
  [@css
    ".a-vc13v6{-webkit-filter:grayscale(100%) sepia(100%);filter:grayscale(100%) sepia(100%);}"
  ];
  [@css
    ".a-1twvds4{-webkit-filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}"
  ];
  [@css
    ".in-sjla48{-webkit-filter:drop-shadow(0 1px 0 var(--color-qfwu7a_1)) drop-shadow(0 1px 0 var(--color-qfwu7a_2)) drop-shadow(0 1px 0 var(--color-qfwu7a_3)) drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075)) drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));filter:drop-shadow(0 1px 0 var(--color-qfwu7a_1)) drop-shadow(0 1px 0 var(--color-qfwu7a_2)) drop-shadow(0 1px 0 var(--color-qfwu7a_3)) drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075)) drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}"
  ];
  [@css ".a-47q0hq{-webkit-backdrop-filter:none;backdrop-filter:none;}"];
  [@css
    ".a-dj9q1s{-webkit-backdrop-filter:url(\"#id\");backdrop-filter:url(\"#id\");}"
  ];
  [@css
    ".a-fhczb9{-webkit-backdrop-filter:url(\"image.svg#id\");backdrop-filter:url(\"image.svg#id\");}"
  ];
  [@css
    ".a-cdpdax{-webkit-backdrop-filter:blur(5px);backdrop-filter:blur(5px);}"
  ];
  [@css
    ".a-134smr4{-webkit-backdrop-filter:brightness(0.5);backdrop-filter:brightness(0.5);}"
  ];
  [@css
    ".a-ii5lod{-webkit-backdrop-filter:contrast(150%);backdrop-filter:contrast(150%);}"
  ];
  [@css
    ".a-byn3bb{-webkit-backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));}"
  ];
  [@css
    ".a-14pjicj{-webkit-backdrop-filter:grayscale(50%);backdrop-filter:grayscale(50%);}"
  ];
  [@css
    ".a-15xjduf{-webkit-backdrop-filter:hue-rotate(50deg);backdrop-filter:hue-rotate(50deg);}"
  ];
  [@css
    ".a-1xysmnx{-webkit-backdrop-filter:invert(50%);backdrop-filter:invert(50%);}"
  ];
  [@css
    ".a-bfwhax{-webkit-backdrop-filter:opacity(50%);backdrop-filter:opacity(50%);}"
  ];
  [@css
    ".a-e2b97y{-webkit-backdrop-filter:sepia(50%);backdrop-filter:sepia(50%);}"
  ];
  [@css
    ".a-x1ltqs{-webkit-backdrop-filter:saturate(150%);backdrop-filter:saturate(150%);}"
  ];
  [@css
    ".a-1t5aokm{-webkit-backdrop-filter:grayscale(100%) sepia(100%);backdrop-filter:grayscale(100%) sepia(100%);}"
  ];
  let color = CSS.hex("333");
  
  CSS.make("a-lcnm6u", []);
  CSS.make("a-1ifcuuo", []);
  CSS.make("a-wzp7li", []);
  CSS.make("a-enxr2q", []);
  CSS.make("a-ckxntt", []);
  CSS.make("a-1o440fd", []);
  
  CSS.make("a-1xj4bqh", []);
  
  CSS.make("a-1arlta4", []);
  CSS.make("a-10pv1a9", []);
  CSS.make("a-dycrc5", []);
  CSS.make("a-1vaakyf", []);
  CSS.make("a-nhtt82", []);
  CSS.make("a-nwh2v6", []);
  CSS.make("a-1e0jie", []);
  CSS.make("a-vc13v6", []);
  CSS.make("a-1twvds4", []);
  CSS.make(
    "in-sjla48",
    [
      ("--color-qfwu7a_1", CSS.Types.Color.toString(color)),
      ("--color-qfwu7a_2", CSS.Types.Color.toString(color)),
      ("--color-qfwu7a_3", CSS.Types.Color.toString(color)),
    ],
  );
  
  CSS.make("a-47q0hq", []);
  CSS.make("a-dj9q1s", []);
  CSS.make("a-fhczb9", []);
  CSS.make("a-cdpdax", []);
  CSS.make("a-134smr4", []);
  CSS.make("a-ii5lod", []);
  CSS.make("a-byn3bb", []);
  CSS.make("a-14pjicj", []);
  CSS.make("a-15xjduf", []);
  CSS.make("a-1xysmnx", []);
  CSS.make("a-bfwhax", []);
  CSS.make("a-e2b97y", []);
  CSS.make("a-x1ltqs", []);
  CSS.make("a-1t5aokm", []);
