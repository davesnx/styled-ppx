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
  [@css
    ".css-mq7ij7 { overscroll-behavior: contain; }\n.css-1nn3wk1 { overscroll-behavior: none; }\n.css-ny1iev { overscroll-behavior: auto; }\n.css-iy87e8 { overscroll-behavior: contain contain; }\n.css-3ykc1z { overscroll-behavior: none contain; }\n.css-4egx2b { overscroll-behavior: auto contain; }\n.css-7i3fjl { overscroll-behavior: contain none; }\n.css-ng5id3 { overscroll-behavior: none none; }\n.css-1pxhxzw { overscroll-behavior: auto none; }\n.css-10biuom { overscroll-behavior: contain auto; }\n.css-1n6xoaw { overscroll-behavior: none auto; }\n.css-1g8b8gj { overscroll-behavior: auto auto; }\n.css-1if2oem { overscroll-behavior-x: contain; }\n.css-14i66oj { overscroll-behavior-x: none; }\n.css-14x7fs9 { overscroll-behavior-x: auto; }\n.css-1cihii9 { overscroll-behavior-y: contain; }\n.css-1xropf { overscroll-behavior-y: none; }\n.css-sg7dnt { overscroll-behavior-y: auto; }\n.css-hjuu6v { overscroll-behavior-inline: contain; }\n.css-1ifr9fw { overscroll-behavior-inline: none; }\n.css-18q3kif { overscroll-behavior-inline: auto; }\n.css-m075gt { overscroll-behavior-block: contain; }\n.css-49cj8j { overscroll-behavior-block: none; }\n.css-nskoeh { overscroll-behavior-block: auto; }\n"
  ];
  CSS.make("css-mq7ij7", []);
  CSS.make("css-1nn3wk1", []);
  CSS.make("css-ny1iev", []);
  CSS.make("css-iy87e8", []);
  CSS.make("css-3ykc1z", []);
  CSS.make("css-4egx2b", []);
  CSS.make("css-7i3fjl", []);
  CSS.make("css-ng5id3", []);
  CSS.make("css-1pxhxzw", []);
  CSS.make("css-10biuom", []);
  CSS.make("css-1n6xoaw", []);
  CSS.make("css-1g8b8gj", []);
  CSS.make("css-1if2oem", []);
  CSS.make("css-14i66oj", []);
  CSS.make("css-14x7fs9", []);
  CSS.make("css-1cihii9", []);
  CSS.make("css-1xropf", []);
  CSS.make("css-sg7dnt", []);
  CSS.make("css-hjuu6v", []);
  CSS.make("css-1ifr9fw", []);
  CSS.make("css-18q3kif", []);
  CSS.make("css-m075gt", []);
  CSS.make("css-49cj8j", []);
  CSS.make("css-nskoeh", []);
