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
  [@css ".css-lcnm6u{-webkit-filter:none;filter:none;}"];
  [@css ".css-1ifcuuo{-webkit-filter:url(\"#id\");filter:url(\"#id\");}"];
  [@css ".css-wzp7li{-webkit-filter:url(\"image.svg#id\");filter:url(\"image.svg#id\");}"];
  [@css ".css-enxr2q{-webkit-filter:blur(5px);filter:blur(5px);}"];
  [@css ".css-ckxntt{-webkit-filter:brightness(0.5);filter:brightness(0.5);}"];
  [@css ".css-1o440fd{-webkit-filter:contrast(150%);filter:contrast(150%);}"];
  [@css ".css-1xj4bqh{-webkit-filter:drop-shadow(5px 5px 10px);filter:drop-shadow(5px 5px 10px);}"];
  [@css ".css-1arlta4{-webkit-filter:drop-shadow(15px 15px 15px #123);filter:drop-shadow(15px 15px 15px #123);}"];
  [@css ".css-10pv1a9{-webkit-filter:grayscale(50%);filter:grayscale(50%);}"];
  [@css ".css-dycrc5{-webkit-filter:hue-rotate(50deg);filter:hue-rotate(50deg);}"];
  [@css ".css-1vaakyf{-webkit-filter:invert(50%);filter:invert(50%);}"];
  [@css ".css-nhtt82{-webkit-filter:opacity(50%);filter:opacity(50%);}"];
  [@css ".css-nwh2v6{-webkit-filter:sepia(50%);filter:sepia(50%);}"];
  [@css ".css-1e0jie{-webkit-filter:saturate(150%);filter:saturate(150%);}"];
  [@css ".css-vc13v6{-webkit-filter:grayscale(100%) sepia(100%);filter:grayscale(100%) sepia(100%);}"];
  [@css ".css-1twvds4{-webkit-filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}"];
  [@css ".css-47q0hq{-webkit-backdrop-filter:none;backdrop-filter:none;}"];
  [@css ".css-dj9q1s{-webkit-backdrop-filter:url(\"#id\");backdrop-filter:url(\"#id\");}"];
  [@css ".css-fhczb9{-webkit-backdrop-filter:url(\"image.svg#id\");backdrop-filter:url(\"image.svg#id\");}"];
  [@css ".css-cdpdax{-webkit-backdrop-filter:blur(5px);backdrop-filter:blur(5px);}"];
  [@css ".css-134smr4{-webkit-backdrop-filter:brightness(0.5);backdrop-filter:brightness(0.5);}"];
  [@css ".css-ii5lod{-webkit-backdrop-filter:contrast(150%);backdrop-filter:contrast(150%);}"];
  [@css
    ".css-byn3bb{-webkit-backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));}"
  ];
  [@css ".css-14pjicj{-webkit-backdrop-filter:grayscale(50%);backdrop-filter:grayscale(50%);}"];
  [@css ".css-15xjduf{-webkit-backdrop-filter:hue-rotate(50deg);backdrop-filter:hue-rotate(50deg);}"];
  [@css ".css-1xysmnx{-webkit-backdrop-filter:invert(50%);backdrop-filter:invert(50%);}"];
  [@css ".css-bfwhax{-webkit-backdrop-filter:opacity(50%);backdrop-filter:opacity(50%);}"];
  [@css ".css-e2b97y{-webkit-backdrop-filter:sepia(50%);backdrop-filter:sepia(50%);}"];
  [@css ".css-x1ltqs{-webkit-backdrop-filter:saturate(150%);backdrop-filter:saturate(150%);}"];
  [@css ".css-1t5aokm{-webkit-backdrop-filter:grayscale(100%) sepia(100%);backdrop-filter:grayscale(100%) sepia(100%);}"];
  let color = CSS.hex("333");
  
  CSS.make("css-lcnm6u", []);
  CSS.make("css-1ifcuuo", []);
  CSS.make("css-wzp7li", []);
  CSS.make("css-enxr2q", []);
  CSS.make("css-ckxntt", []);
  CSS.make("css-1o440fd", []);
  
  CSS.make("css-1xj4bqh", []);
  
  CSS.make("css-1arlta4", []);
  CSS.make("css-10pv1a9", []);
  CSS.make("css-dycrc5", []);
  CSS.make("css-1vaakyf", []);
  CSS.make("css-nhtt82", []);
  CSS.make("css-nwh2v6", []);
  CSS.make("css-1e0jie", []);
  CSS.make("css-vc13v6", []);
  CSS.make("css-1twvds4", []);
  CSS.filter([|
    `dropShadow((`zero, `pxFloat(1.), `zero, color)),
    `dropShadow((`zero, `pxFloat(1.), `zero, color)),
    `dropShadow((`zero, `pxFloat(1.), `zero, color)),
    `dropShadow((
      `zero,
      `pxFloat(32.),
      `pxFloat(48.),
      `rgba((0, 0, 0, `num(0.075))),
    )),
    `dropShadow((
      `zero,
      `pxFloat(8.),
      `pxFloat(32.),
      `rgba((0, 0, 0, `num(0.03))),
    )),
  |]);
  
  CSS.make("css-47q0hq", []);
  CSS.make("css-dj9q1s", []);
  CSS.make("css-fhczb9", []);
  CSS.make("css-cdpdax", []);
  CSS.make("css-134smr4", []);
  CSS.make("css-ii5lod", []);
  CSS.make("css-byn3bb", []);
  CSS.make("css-14pjicj", []);
  CSS.make("css-15xjduf", []);
  CSS.make("css-1xysmnx", []);
  CSS.make("css-bfwhax", []);
  CSS.make("css-e2b97y", []);
  CSS.make("css-x1ltqs", []);
  CSS.make("css-1t5aokm", []);
