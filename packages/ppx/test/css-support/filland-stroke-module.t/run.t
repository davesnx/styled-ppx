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
  [@css ".css-ivpcpq9{fill-rule:nonzero;}"];
  [@css ".css-ivpce3n{fill-rule:evenodd;}"];
  [@css ".css-ivpcs5m{fill-opacity:0.5;}"];
  [@css ".css-ivpcey1{fill-opacity:45%;}"];
  [@css ".css-ivpcmcb{stroke-width:0;}"];
  [@css ".css-ivpcp71{stroke-width:1px;}"];
  [@css ".css-ivpcfqh{stroke-width:25%;}"];
  [@css ".css-ivpcp7u{stroke-linecap:butt;}"];
  [@css ".css-ivpc8o9{stroke-linecap:round;}"];
  [@css ".css-ivpc6l5{stroke-linecap:square;}"];
  [@css ".css-ivpc0bg{stroke-linejoin:miter;}"];
  [@css ".css-ivpctpx{stroke-linejoin:bevel;}"];
  [@css ".css-ivpch2z{stroke-linejoin:round;}"];
  [@css ".css-ivpc6qe{stroke-miterlimit:4;}"];
  [@css.classes
    [
      ("css-ivpcpq9", 0, "", "input.re", 7, 8, 7, 26),
      ("css-ivpce3n", 1, "", "input.re", 8, 8, 8, 26),
      ("css-ivpcs5m", 2, "", "input.re", 62, 8, 62, 25),
      ("css-ivpcey1", 3, "", "input.re", 63, 8, 63, 25),
      ("css-ivpcmcb", 4, "", "input.re", 69, 8, 69, 23),
      ("css-ivpcp71", 5, "", "input.re", 70, 8, 70, 25),
      ("css-ivpcfqh", 6, "", "input.re", 71, 8, 71, 25),
      ("css-ivpcp7u", 7, "", "input.re", 75, 8, 75, 28),
      ("css-ivpc8o9", 8, "", "input.re", 76, 8, 76, 29),
      ("css-ivpc6l5", 9, "", "input.re", 77, 8, 77, 31),
      ("css-ivpc0bg", 10, "", "input.re", 80, 8, 80, 30),
      ("css-ivpctpx", 11, "", "input.re", 81, 8, 81, 30),
      ("css-ivpch2z", 12, "", "input.re", 82, 8, 82, 30),
      ("css-ivpc6qe", 13, "", "input.re", 87, 8, 87, 28),
    ]
  ];
  
  CSS.make("css-ivpcpq9", []);
  CSS.make("css-ivpce3n", []);
  
  CSS.make("css-ivpcs5m", []);
  CSS.make("css-ivpcey1", []);
  
  CSS.make("css-ivpcmcb", []);
  CSS.make("css-ivpcp71", []);
  CSS.make("css-ivpcfqh", []);
  
  CSS.make("css-ivpcp7u", []);
  CSS.make("css-ivpc8o9", []);
  CSS.make("css-ivpc6l5", []);
  
  CSS.make("css-ivpc0bg", []);
  CSS.make("css-ivpctpx", []);
  CSS.make("css-ivpch2z", []);
  
  CSS.make("css-ivpc6qe", []);
