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
  [@css ".css-lcnm6u{filter:none;}"];
  [@css ".css-1ifcuuo{filter:url(\"#id\");}"];
  [@css ".css-wzp7li{filter:url(\"image.svg#id\");}"];
  [@css ".css-enxr2q{filter:blur(5px);}"];
  [@css ".css-ckxntt{filter:brightness(0.5);}"];
  [@css ".css-1o440fd{filter:contrast(150%);}"];
  [@css ".css-1xj4bqh{filter:drop-shadow(5px 5px 10px);}"];
  [@css ".css-1arlta4{filter:drop-shadow(15px 15px 15px #123);}"];
  [@css ".css-10pv1a9{filter:grayscale(50%);}"];
  [@css ".css-dycrc5{filter:hue-rotate(50deg);}"];
  [@css ".css-1vaakyf{filter:invert(50%);}"];
  [@css ".css-nhtt82{filter:opacity(50%);}"];
  [@css ".css-nwh2v6{filter:sepia(50%);}"];
  [@css ".css-1e0jie{filter:saturate(150%);}"];
  [@css ".css-vc13v6{filter:grayscale(100%) sepia(100%);}"];
  [@css ".css-1twvds4{filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}"];
  [@css ".css-47q0hq{backdrop-filter:none;}"];
  [@css ".css-dj9q1s{backdrop-filter:url(\"#id\");}"];
  [@css ".css-fhczb9{backdrop-filter:url(\"image.svg#id\");}"];
  [@css ".css-cdpdax{backdrop-filter:blur(5px);}"];
  [@css ".css-134smr4{backdrop-filter:brightness(0.5);}"];
  [@css ".css-ii5lod{backdrop-filter:contrast(150%);}"];
  [@css
    ".css-byn3bb{backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));}"
  ];
  [@css ".css-14pjicj{backdrop-filter:grayscale(50%);}"];
  [@css ".css-15xjduf{backdrop-filter:hue-rotate(50deg);}"];
  [@css ".css-1xysmnx{backdrop-filter:invert(50%);}"];
  [@css ".css-bfwhax{backdrop-filter:opacity(50%);}"];
  [@css ".css-e2b97y{backdrop-filter:sepia(50%);}"];
  [@css ".css-x1ltqs{backdrop-filter:saturate(150%);}"];
  [@css ".css-1t5aokm{backdrop-filter:grayscale(100%) sepia(100%);}"];
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
