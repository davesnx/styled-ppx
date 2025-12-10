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
    ".css-16d3trq { filter: none; }\n.css-godgr8 { filter: url(\"#id\"); }\n.css-xqvzb5 { filter: url(\"image.svg#id\"); }\n.css-4ehfzg { filter: blur(5px); }\n.css-huyz1z { filter: brightness(0.5); }\n.css-1cn4gn6 { filter: contrast(150%); }\n.css-b50m4i { filter: drop-shadow(5px 5px 10px); }\n.css-19z35vy { filter: drop-shadow(15px 15px 15px #123); }\n.css-fulcc1 { filter: grayscale(50%); }\n.css-bpt3fe { filter: hue-rotate(50deg); }\n.css-134jjsx { filter: invert(50%); }\n.css-16whus3 { filter: opacity(50%); }\n.css-z8jagj { filter: sepia(50%); }\n.css-1gespym { filter: saturate(150%); }\n.css-18e7r3e { filter: grayscale(100%) sepia(100%); }\n.css-10n1xyo { filter: drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03)); }\n.css-xfaeuo { backdrop-filter: none; }\n.css-8bxha2 { backdrop-filter: url(\"#id\"); }\n.css-1sqcyf0 { backdrop-filter: url(\"image.svg#id\"); }\n.css-1xqwm41 { backdrop-filter: blur(5px); }\n.css-1fbee7k { backdrop-filter: brightness(0.5); }\n.css-tgwouh { backdrop-filter: contrast(150%); }\n.css-erdf0y { backdrop-filter: drop-shadow(15px 15px 15px rgba(0, 0, 0, 1)); }\n.css-1vrdwtn { backdrop-filter: grayscale(50%); }\n.css-72idam { backdrop-filter: hue-rotate(50deg); }\n.css-5nfqvq { backdrop-filter: invert(50%); }\n.css-1dtu7zj { backdrop-filter: opacity(50%); }\n.css-1h153wa { backdrop-filter: sepia(50%); }\n.css-1pqaiyw { backdrop-filter: saturate(150%); }\n.css-1424y70 { backdrop-filter: grayscale(100%) sepia(100%); }\n"
  ];
  let color = CSS.hex("333");
  
  CSS.make("css-16d3trq", []);
  CSS.make("css-godgr8", []);
  CSS.make("css-xqvzb5", []);
  CSS.make("css-4ehfzg", []);
  CSS.make("css-huyz1z", []);
  CSS.make("css-1cn4gn6", []);
  
  CSS.make("css-b50m4i", []);
  
  CSS.make("css-19z35vy", []);
  CSS.make("css-fulcc1", []);
  CSS.make("css-bpt3fe", []);
  CSS.make("css-134jjsx", []);
  CSS.make("css-16whus3", []);
  CSS.make("css-z8jagj", []);
  CSS.make("css-1gespym", []);
  CSS.make("css-18e7r3e", []);
  CSS.make("css-10n1xyo", []);
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
  
  CSS.make("css-xfaeuo", []);
  CSS.make("css-8bxha2", []);
  CSS.make("css-1sqcyf0", []);
  CSS.make("css-1xqwm41", []);
  CSS.make("css-1fbee7k", []);
  CSS.make("css-tgwouh", []);
  CSS.make("css-erdf0y", []);
  CSS.make("css-1vrdwtn", []);
  CSS.make("css-72idam", []);
  CSS.make("css-5nfqvq", []);
  CSS.make("css-1dtu7zj", []);
  CSS.make("css-1h153wa", []);
  CSS.make("css-1pqaiyw", []);
  CSS.make("css-1424y70", []);
