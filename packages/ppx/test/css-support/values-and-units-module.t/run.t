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
  [@css ".css-ivpc7tn{width:5rem;}"];
  [@css ".css-ivpcgd7{width:5ch;}"];
  [@css ".css-ivpcj00{width:5vw;}"];
  [@css ".css-ivpcz18{width:5vh;}"];
  [@css ".css-ivpctj1{width:5vmin;}"];
  [@css ".css-ivpcsnb{width:5vmax;}"];
  [@css ".css-ivpcdas{width:calc(1px + 2px);}"];
  [@css ".css-ivpcieg{width:calc(5px * 2);}"];
  [@css ".css-ivpckcg{width:calc(5px - 10px);}"];
  [@css ".css-ivpc3m7{width:calc(1vw - 1px);}"];
  [@css ".css-ivpctg4{width:100%;}"];
  [@css ".css-ivpcyga{padding:5rem;}"];
  [@css ".css-ivpcmju{padding:5ch;}"];
  [@css ".css-ivpc715{padding:5vw;}"];
  [@css ".css-ivpcr47{padding:5vh;}"];
  [@css ".css-ivpc8zg{padding:5vmin;}"];
  [@css ".css-ivpcr9f{padding:5vmax;}"];
  [@css.classes
    [
      ("css-ivpc7tn", 0, "", "input.re", 2, 8, 2, 19),
      ("css-ivpcgd7", 1, "", "input.re", 3, 8, 3, 18),
      ("css-ivpcj00", 2, "", "input.re", 4, 8, 4, 18),
      ("css-ivpcz18", 3, "", "input.re", 5, 8, 5, 18),
      ("css-ivpctj1", 4, "", "input.re", 6, 8, 6, 20),
      ("css-ivpcsnb", 5, "", "input.re", 7, 8, 7, 20),
      ("css-ivpcdas", 6, "", "input.re", 8, 8, 8, 30),
      ("css-ivpcieg", 7, "", "input.re", 9, 8, 9, 28),
      ("css-ivpckcg", 8, "", "input.re", 11, 8, 11, 31),
      ("css-ivpc3m7", 9, "", "input.re", 12, 8, 12, 30),
      ("css-ivpctg4", 10, "", "input.re", 13, 8, 13, 19),
      ("css-ivpcyga", 11, "", "input.re", 14, 8, 14, 21),
      ("css-ivpcmju", 12, "", "input.re", 15, 8, 15, 20),
      ("css-ivpc715", 13, "", "input.re", 16, 8, 16, 20),
      ("css-ivpcr47", 14, "", "input.re", 17, 8, 17, 20),
      ("css-ivpc8zg", 15, "", "input.re", 18, 8, 18, 22),
      ("css-ivpcr9f", 16, "", "input.re", 19, 8, 19, 22),
    ]
  ];
  
  CSS.make("css-ivpc7tn", []);
  CSS.make("css-ivpcgd7", []);
  CSS.make("css-ivpcj00", []);
  CSS.make("css-ivpcz18", []);
  CSS.make("css-ivpctj1", []);
  CSS.make("css-ivpcsnb", []);
  CSS.make("css-ivpcdas", []);
  CSS.make("css-ivpcieg", []);
  CSS.make("css-ivpcieg", []);
  CSS.make("css-ivpckcg", []);
  CSS.make("css-ivpc3m7", []);
  CSS.make("css-ivpctg4", []);
  CSS.make("css-ivpcyga", []);
  CSS.make("css-ivpcmju", []);
  CSS.make("css-ivpc715", []);
  CSS.make("css-ivpcr47", []);
  CSS.make("css-ivpc8zg", []);
  CSS.make("css-ivpcr9f", []);

