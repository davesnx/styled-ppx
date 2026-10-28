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
    (
      "._a_4esyq5{color:hwb(0 0% 0%);}",
      "_a_4esyq5",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4e1qgw{color:hwb(0 0% 0% / 0.5);}",
      "_a_4e1qgw",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4ezea3{color:hwb(120 30% 50%);}",
      "_a_4ezea3",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4e3fh9{color:hwb(120 30% 50% / 0.8);}",
      "_a_4e3fh9",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4e2e9t{color:lab(0% 0 0);}",
      "_a_4e2e9t",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4e3erw{color:lab(0% 0 0 / 0.5);}",
      "_a_4e3erw",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4en9r5{color:lab(50% 20 -30);}",
      "_a_4en9r5",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4e699s{color:lab(50% 20 -30 / 0.8);}",
      "_a_4e699s",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4e2dh3{color:lch(0% 0 0);}",
      "_a_4e2dh3",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4ej1zh{color:lch(0% 0 0 / 0.5);}",
      "_a_4ej1zh",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4eaqt7{color:lch(50% 30 120);}",
      "_a_4eaqt7",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4ezfou{color:lch(50% 30 120 / 0.8);}",
      "_a_4ezfou",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4enil4{color:oklab(0% 0 0);}",
      "_a_4enil4",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4e00n7{color:oklab(0% 0 0 / 0.5);}",
      "_a_4e00n7",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4exkis{color:oklab(50% 0.1 -0.1);}",
      "_a_4exkis",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4em1az{color:oklab(50% 0.1 -0.1 / 0.8);}",
      "_a_4em1az",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4eqt74{color:oklch(0% 0 0);}",
      "_a_4eqt74",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4es7y3{color:oklch(0% 0 0 / 0.5);}",
      "_a_4es7y3",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4ezyac{color:oklch(50% 0.15 120);}",
      "_a_4ezyac",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4ehrqn{color:oklch(50% 0.15 120 / 0.8);}",
      "_a_4ehrqn",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4e9bfd{color:light-dark(white, black);}",
      "_a_4e9bfd",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4exrra{color:light-dark(#fff, #000);}",
      "_a_4exrra",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4ed5hk{color:light-dark(rgb(255, 255, 255), rgb(0, 0, 0));}",
      "_a_4ed5hk",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_39000476db{background-color:light-dark(#f0f0f0, #1a1a1a);}",
      "_a_39000476db",
      "0,1,0 own",
      "117",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_4eq67q{color:color(srgb 1 0.5 0);}",
      "_a_4eq67q",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4evn4u{color:color(srgb 1 0.5 0 / 0.5);}",
      "_a_4evn4u",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4e4vx0{color:color(display-p3 1 0.5 0);}",
      "_a_4e4vx0",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4eh8l1{color:color(display-p3 1 0.5 0 / 0.5);}",
      "_a_4eh8l1",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_390004jf25{background-color:hwb(0 0% 0%);}",
      "_a_390004jf25",
      "0,1,0 own",
      "117",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_3900046psj{background-color:lab(50% 20 -30);}",
      "_a_3900046psj",
      "0,1,0 own",
      "117",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_390004qziw{background-color:lch(50% 30 120);}",
      "_a_390004qziw",
      "0,1,0 own",
      "117",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_390004l9l2{background-color:oklab(50% 0.1 -0.1);}",
      "_a_390004l9l2",
      "0,1,0 own",
      "117",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_390004ibmj{background-color:oklch(50% 0.15 120);}",
      "_a_390004ibmj",
      "0,1,0 own",
      "117",
      4,
      false,
    )
  ];
  [@css.blocks
    [
      (4, "", [0]),
      (5, "", [1]),
      (6, "", [2]),
      (7, "", [3]),
      (10, "", [4]),
      (11, "", [5]),
      (12, "", [6]),
      (13, "", [7]),
      (16, "", [8]),
      (17, "", [9]),
      (18, "", [10]),
      (19, "", [11]),
      (22, "", [12]),
      (23, "", [13]),
      (24, "", [14]),
      (25, "", [15]),
      (28, "", [16]),
      (29, "", [17]),
      (30, "", [18]),
      (31, "", [19]),
      (34, "", [20]),
      (35, "", [21]),
      (36, "", [22]),
      (37, "", [23]),
      (40, "", [24]),
      (41, "", [25]),
      (42, "", [26]),
      (43, "", [27]),
      (46, "", [28]),
      (47, "", [29]),
      (48, "", [30]),
      (49, "", [31]),
      (50, "", [32]),
    ]
  ];
  
  CSS.make("_a_4esyq5", []);
  CSS.make("_a_4e1qgw", []);
  CSS.make("_a_4ezea3", []);
  CSS.make("_a_4e3fh9", []);
  
  CSS.make("_a_4e2e9t", []);
  CSS.make("_a_4e3erw", []);
  CSS.make("_a_4en9r5", []);
  CSS.make("_a_4e699s", []);
  
  CSS.make("_a_4e2dh3", []);
  CSS.make("_a_4ej1zh", []);
  CSS.make("_a_4eaqt7", []);
  CSS.make("_a_4ezfou", []);
  
  CSS.make("_a_4enil4", []);
  CSS.make("_a_4e00n7", []);
  CSS.make("_a_4exkis", []);
  CSS.make("_a_4em1az", []);
  
  CSS.make("_a_4eqt74", []);
  CSS.make("_a_4es7y3", []);
  CSS.make("_a_4ezyac", []);
  CSS.make("_a_4ehrqn", []);
  
  CSS.make("_a_4e9bfd", []);
  CSS.make("_a_4exrra", []);
  CSS.make("_a_4ed5hk", []);
  CSS.make("_a_39000476db", []);
  
  CSS.make("_a_4eq67q", []);
  CSS.make("_a_4evn4u", []);
  CSS.make("_a_4e4vx0", []);
  CSS.make("_a_4eh8l1", []);
  
  CSS.make("_a_390004jf25", []);
  CSS.make("_a_3900046psj", []);
  CSS.make("_a_390004qziw", []);
  CSS.make("_a_390004l9l2", []);
  CSS.make("_a_390004ibmj", []);
