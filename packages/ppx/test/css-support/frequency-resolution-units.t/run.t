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
      "._a_6tobub{image-rendering:auto;}",
      "_a_6tobub",
      "0,1,0 own",
      "245",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6tm01f{image-rendering:crisp-edges;}",
      "_a_6tm01f",
      "0,1,0 own",
      "245",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6thmlf{image-rendering:pixelated;}",
      "_a_6thmlf",
      "0,1,0 own",
      "245",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_390008toi3{background-image:image-set(\"cat.png\" 1x, \"cat-2x.png\" 2x);}",
      "_a_390008toi3",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008sfyn{background-image:image-set(\"cat.png\" 1dppx, \"cat-2x.png\" 2dppx);}",
      "_a_390008sfyn",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_3900080k4n{background-image:image-set(\"cat.png\" 96dpi, \"cat-2x.png\" 192dpi);}",
      "_a_3900080k4n",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008fchh{background-image:image-set(\"cat.png\" 37dpcm);}",
      "_a_390008fchh",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css.blocks
    [
      (5, "", [0]),
      (6, "", [1]),
      (7, "", [2]),
      (10, "", [3]),
      (11, "", [4]),
      (12, "", [5]),
      (13, "", [6]),
    ]
  ];
  
  CSS.make("_a_6tobub", []);
  CSS.make("_a_6tm01f", []);
  CSS.make("_a_6thmlf", []);
  
  CSS.make("_a_390008toi3", []);
  CSS.make("_a_390008sfyn", []);
  CSS.make("_a_3900080k4n", []);
  CSS.make("_a_390008fchh", []);
