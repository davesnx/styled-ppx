CSS Spatial Navigation L1 (spatial-navigation-contain/-action/-function),
CSS Form Control Styling L1 (input-security, slider-orientation), CSS Image
Animation L1 (image-animation). input.re carries valid declarations
(accepted silently); invalid.re carries an out-of-grammar keyword, whose
error names the property.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executables
  >  (names input invalid)
  >  (libraries styled-ppx.native)
  >  (flags (:standard -w -32))
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build
  File "invalid.re", line 1, characters 28-36:
  1 | [%css {|slider-orientation: vertical|}];
                                  ^^^^^^^^
  Error: Property 'slider-orientation' has an invalid value:
         'vertical',
         Expected 'auto', 'bottom-to-top', 'left-to-right', 'right-to-left', or
         'top-to-bottom'.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    (
      "._a_gh0m8o{spatial-navigation-contain:auto;}",
      "_a_gh0m8o",
      "0,1,0 own",
      "593",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gho0tl{spatial-navigation-contain:contain;}",
      "_a_gho0tl",
      "0,1,0 own",
      "593",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ggylya{spatial-navigation-action:auto;}",
      "_a_ggylya",
      "0,1,0 own",
      "592",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ggcs1f{spatial-navigation-action:focus;}",
      "_a_ggcs1f",
      "0,1,0 own",
      "592",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ggmv9e{spatial-navigation-action:scroll;}",
      "_a_ggmv9e",
      "0,1,0 own",
      "592",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_giw9j7{spatial-navigation-function:normal;}",
      "_a_giw9j7",
      "0,1,0 own",
      "594",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gikhle{spatial-navigation-function:grid;}",
      "_a_gikhle",
      "0,1,0 own",
      "594",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_g0vsvf{input-security:auto;}",
      "_a_g0vsvf",
      "0,1,0 own",
      "576",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_g0xrmz{input-security:none;}",
      "_a_g0xrmz",
      "0,1,0 own",
      "576",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gfbked{slider-orientation:auto;}",
      "_a_gfbked",
      "0,1,0 own",
      "591",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gf592w{slider-orientation:left-to-right;}",
      "_a_gf592w",
      "0,1,0 own",
      "591",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gfedm7{slider-orientation:right-to-left;}",
      "_a_gfedm7",
      "0,1,0 own",
      "591",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gfopqg{slider-orientation:top-to-bottom;}",
      "_a_gfopqg",
      "0,1,0 own",
      "591",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gfp6e5{slider-orientation:bottom-to-top;}",
      "_a_gfp6e5",
      "0,1,0 own",
      "591",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fxz01g{image-animation:normal;}",
      "_a_fxz01g",
      "0,1,0 own",
      "573",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fxruim{image-animation:paused;}",
      "_a_fxruim",
      "0,1,0 own",
      "573",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fxci5z{image-animation:stopped;}",
      "_a_fxci5z",
      "0,1,0 own",
      "573",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fx987c{image-animation:running;}",
      "_a_fx987c",
      "0,1,0 own",
      "573",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (5, "", [0]),
      (6, "", [1]),
      (7, "", [2]),
      (8, "", [3]),
      (9, "", [4]),
      (10, "", [5]),
      (11, "", [6]),
      (12, "", [7]),
      (13, "", [8]),
      (14, "", [9]),
      (15, "", [10]),
      (16, "", [11]),
      (17, "", [12]),
      (18, "", [13]),
      (19, "", [14]),
      (20, "", [15]),
      (21, "", [16]),
      (22, "", [17]),
    ]
  ];
  
  CSS.make("_a_gh0m8o", []);
  CSS.make("_a_gho0tl", []);
  CSS.make("_a_ggylya", []);
  CSS.make("_a_ggcs1f", []);
  CSS.make("_a_ggmv9e", []);
  CSS.make("_a_giw9j7", []);
  CSS.make("_a_gikhle", []);
  CSS.make("_a_g0vsvf", []);
  CSS.make("_a_g0xrmz", []);
  CSS.make("_a_gfbked", []);
  CSS.make("_a_gf592w", []);
  CSS.make("_a_gfedm7", []);
  CSS.make("_a_gfopqg", []);
  CSS.make("_a_gfp6e5", []);
  CSS.make("_a_fxz01g", []);
  CSS.make("_a_fxruim", []);
  CSS.make("_a_fxci5z", []);
  CSS.make("_a_fx987c", []);
