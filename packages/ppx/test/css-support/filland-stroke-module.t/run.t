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
  [@css ".css-10cxpq9{fill-rule:nonzero;}"];
  [@css ".css-1nl5e3n{fill-rule:evenodd;}"];
  [@css ".css-163ds5m{fill-opacity:0.5;}"];
  [@css ".css-cg7ey1{fill-opacity:45%;}"];
  [@css ".css-1j4fmcb{stroke-width:0;}"];
  [@css ".css-1c8tp71{stroke-width:1px;}"];
  [@css ".css-p9hfqh{stroke-width:25%;}"];
  [@css ".css-lhap7u{stroke-linecap:butt;}"];
  [@css ".css-nfo8o9{stroke-linecap:round;}"];
  [@css ".css-1jfv6l5{stroke-linecap:square;}"];
  [@css ".css-ken0bg{stroke-linejoin:miter;}"];
  [@css ".css-o87tpx{stroke-linejoin:bevel;}"];
  [@css ".css-st8h2z{stroke-linejoin:round;}"];
  [@css ".css-1e496qe{stroke-miterlimit:4;}"];
  [@css.classes
    [
      ("css-10cxpq9", 0, "", "input.re", 7, 8, 7, 26),
      ("css-1nl5e3n", 1, "", "input.re", 8, 8, 8, 26),
      ("css-163ds5m", 2, "", "input.re", 62, 8, 62, 25),
      ("css-cg7ey1", 3, "", "input.re", 63, 8, 63, 25),
      ("css-1j4fmcb", 4, "", "input.re", 69, 8, 69, 23),
      ("css-1c8tp71", 5, "", "input.re", 70, 8, 70, 25),
      ("css-p9hfqh", 6, "", "input.re", 71, 8, 71, 25),
      ("css-lhap7u", 7, "", "input.re", 75, 8, 75, 28),
      ("css-nfo8o9", 8, "", "input.re", 76, 8, 76, 29),
      ("css-1jfv6l5", 9, "", "input.re", 77, 8, 77, 31),
      ("css-ken0bg", 10, "", "input.re", 80, 8, 80, 30),
      ("css-o87tpx", 11, "", "input.re", 81, 8, 81, 30),
      ("css-st8h2z", 12, "", "input.re", 82, 8, 82, 30),
      ("css-1e496qe", 13, "", "input.re", 87, 8, 87, 28),
    ]
  ];
  
  CSS.make("css-10cxpq9", []);
  CSS.make("css-1nl5e3n", []);
  
  CSS.make("css-163ds5m", []);
  CSS.make("css-cg7ey1", []);
  
  CSS.make("css-1j4fmcb", []);
  CSS.make("css-1c8tp71", []);
  CSS.make("css-p9hfqh", []);
  
  CSS.make("css-lhap7u", []);
  CSS.make("css-nfo8o9", []);
  CSS.make("css-1jfv6l5", []);
  
  CSS.make("css-ken0bg", []);
  CSS.make("css-o87tpx", []);
  CSS.make("css-st8h2z", []);
  
  CSS.make("css-1e496qe", []);
