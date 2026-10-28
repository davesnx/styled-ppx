Layout/sizing slice of 140 standards-track/preview properties, across
7 small specs (CSS Box Sizing L4, CSS Exclusions L1, CSS Fragmentation L4,
CSS Rhythmic Sizing L1, CSS Inline Layout L3, CSS Line Grid L1, CSS Round
Display L1). input.re carries valid declarations for every property added
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
  File "invalid.re", line 1, characters 30-36:
  1 | [%css {|min-intrinsic-sizing: always|}];
                                    ^^^^^^
  Error: Property 'min-intrinsic-sizing' has an invalid value:
         'always',
         Expected 'legacy'.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ("._a_g72k91{max-size:100px;}", "_a_g72k91", "0,1,0 own", "583", 1, false)
  ];
  [@css
    (
      "._a_g7o8qx{max-size:100px 50px;}",
      "_a_g7o8qx",
      "0,1,0 own",
      "583",
      1,
      false,
    )
  ];
  [@css
    ("._a_g9z1wa{min-size:auto;}", "_a_g9z1wa", "0,1,0 own", "585", 1, false)
  ];
  [@css
    (
      "._a_g92f9q{min-size:10px 20px;}",
      "_a_g92f9q",
      "0,1,0 own",
      "585",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_g8tgfk{min-intrinsic-sizing:legacy;}",
      "_a_g8tgfk",
      "0,1,0 own",
      "584",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_g86fqb{min-intrinsic-sizing:zero-if-scroll;}",
      "_a_g86fqb",
      "0,1,0 own",
      "584",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_g8jrij{min-intrinsic-sizing:zero-if-scroll zero-if-extrinsic;}",
      "_a_g8jrij",
      "0,1,0 own",
      "584",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gyjxpg{wrap-flow:minimum;}",
      "_a_gyjxpg",
      "0,1,0 own",
      "610",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_h0ahj7{wrap-through:none;}",
      "_a_h0ahj7",
      "0,1,0 own",
      "612",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_g5n5yv{margin-break:keep;}",
      "_a_g5n5yv",
      "0,1,0 own",
      "581",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_f20008myq3{block-step-size:none;}",
      "_a_f20008myq3",
      "0,1,0 own",
      "542",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_f20002gz9k{block-step-insert:content-box;}",
      "_a_f20002gz9k",
      "0,1,0 own",
      "542",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_f20001kywn{block-step-align:center;}",
      "_a_f20001kywn",
      "0,1,0 own",
      "542",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_f20004jjp9{block-step-round:nearest;}",
      "_a_f20004jjp9",
      "0,1,0 own",
      "542",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_f2stl1{block-step:10px content-box center up;}",
      "_a_f2stl1",
      "0,1,0 own",
      "542",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_fy64xq{initial-letter-wrap:grid;}",
      "_a_fy64xq",
      "0,1,0 own",
      "574",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fzl4el{inline-sizing:stretch;}",
      "_a_fzl4el",
      "0,1,0 own",
      "575",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_g1x0ci{line-fit-edge:cap alphabetic;}",
      "_a_g1x0ci",
      "0,1,0 own",
      "577",
      1,
      false,
    )
  ];
  [@css
    ("._a_g2v01o{line-grid:create;}", "_a_g2v01o", "0,1,0 own", "578", 1, false)
  ];
  [@css
    (
      "._a_g4l7fm{line-snap:contain;}",
      "_a_g4l7fm",
      "0,1,0 own",
      "580",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fh23yj{box-snap:last-baseline;}",
      "_a_fh23yj",
      "0,1,0 own",
      "557",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_f8c3iu{border-boundary:parent;}",
      "_a_f8c3iu",
      "0,1,0 own",
      "548",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_geq7gh{shape-inside:circle() border-box;}",
      "_a_geq7gh",
      "0,1,0 own",
      "590",
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
      (14, "", [7]),
      (15, "", [8]),
      (18, "", [9]),
      (21, "", [10]),
      (22, "", [11]),
      (23, "", [12]),
      (24, "", [13]),
      (25, "", [14]),
      (28, "", [15]),
      (29, "", [16]),
      (30, "", [17]),
      (33, "", [18]),
      (34, "", [19]),
      (35, "", [20]),
      (38, "", [21]),
      (39, "", [22]),
    ]
  ];
  
  CSS.make("_a_g72k91", []);
  CSS.make("_a_g7o8qx", []);
  CSS.make("_a_g9z1wa", []);
  CSS.make("_a_g92f9q", []);
  CSS.make("_a_g8tgfk", []);
  CSS.make("_a_g86fqb", []);
  CSS.make("_a_g8jrij", []);
  
  CSS.make("_a_gyjxpg", []);
  CSS.make("_a_h0ahj7", []);
  
  CSS.make("_a_g5n5yv", []);
  
  CSS.make("_a_f20008myq3", []);
  CSS.make("_a_f20002gz9k", []);
  CSS.make("_a_f20001kywn", []);
  CSS.make("_a_f20004jjp9", []);
  CSS.make("_a_f2stl1", []);
  
  CSS.make("_a_fy64xq", []);
  CSS.make("_a_fzl4el", []);
  CSS.make("_a_g1x0ci", []);
  
  CSS.make("_a_g2v01o", []);
  CSS.make("_a_g4l7fm", []);
  CSS.make("_a_fh23yj", []);
  
  CSS.make("_a_f8c3iu", []);
  CSS.make("_a_geq7gh", []);
