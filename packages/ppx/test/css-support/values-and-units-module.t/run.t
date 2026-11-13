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
  [@css ".css-p3v7tn{width:5rem;}"];
  [@css ".css-ytagd7{width:5ch;}"];
  [@css ".css-96ij00{width:5vw;}"];
  [@css ".css-110kz18{width:5vh;}"];
  [@css ".css-9ebtj1{width:5vmin;}"];
  [@css ".css-1pn5snb{width:5vmax;}"];
  [@css ".css-1ljodas{width:calc(1px + 2px);}"];
  [@css ".css-1icsieg{width:calc(5px * 2);}"];
  [@css ".css-giukcg{width:calc(5px - 10px);}"];
  [@css ".css-l3o3m7{width:calc(1vw - 1px);}"];
  [@css ".css-1i0tg4{width:100%;}"];
  [@css ".css-1vlzyga{padding:5rem;}"];
  [@css ".css-1oi9mju{padding:5ch;}"];
  [@css ".css-bd7715{padding:5vw;}"];
  [@css ".css-1mhmr47{padding:5vh;}"];
  [@css ".css-rcl8zg{padding:5vmin;}"];
  [@css ".css-18fsr9f{padding:5vmax;}"];
  [@css.classes
    [
      ("css-p3v7tn", 0, "", "input.re", 2, 8, 2, 19),
      ("css-ytagd7", 1, "", "input.re", 3, 8, 3, 18),
      ("css-96ij00", 2, "", "input.re", 4, 8, 4, 18),
      ("css-110kz18", 3, "", "input.re", 5, 8, 5, 18),
      ("css-9ebtj1", 4, "", "input.re", 6, 8, 6, 20),
      ("css-1pn5snb", 5, "", "input.re", 7, 8, 7, 20),
      ("css-1ljodas", 6, "", "input.re", 8, 8, 8, 30),
      ("css-1icsieg", 7, "", "input.re", 9, 8, 9, 28),
      ("css-giukcg", 8, "", "input.re", 11, 8, 11, 31),
      ("css-l3o3m7", 9, "", "input.re", 12, 8, 12, 30),
      ("css-1i0tg4", 10, "", "input.re", 13, 8, 13, 19),
      ("css-1vlzyga", 11, "", "input.re", 14, 8, 14, 21),
      ("css-1oi9mju", 12, "", "input.re", 15, 8, 15, 20),
      ("css-bd7715", 13, "", "input.re", 16, 8, 16, 20),
      ("css-1mhmr47", 14, "", "input.re", 17, 8, 17, 20),
      ("css-rcl8zg", 15, "", "input.re", 18, 8, 18, 22),
      ("css-18fsr9f", 16, "", "input.re", 19, 8, 19, 22),
    ]
  ];
  
  CSS.make("css-p3v7tn", []);
  CSS.make("css-ytagd7", []);
  CSS.make("css-96ij00", []);
  CSS.make("css-110kz18", []);
  CSS.make("css-9ebtj1", []);
  CSS.make("css-1pn5snb", []);
  CSS.make("css-1ljodas", []);
  CSS.make("css-1icsieg", []);
  CSS.make("css-1icsieg", []);
  CSS.make("css-giukcg", []);
  CSS.make("css-l3o3m7", []);
  CSS.make("css-1i0tg4", []);
  CSS.make("css-1vlzyga", []);
  CSS.make("css-1oi9mju", []);
  CSS.make("css-bd7715", []);
  CSS.make("css-1mhmr47", []);
  CSS.make("css-rcl8zg", []);
  CSS.make("css-18fsr9f", []);

