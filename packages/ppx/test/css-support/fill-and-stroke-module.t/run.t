CSS Fill and Stroke Module Level 3 (https://drafts.csswg.org/fill-stroke/):
the 16 fill- and stroke- properties this pass added. input.re carries valid
declarations for all of them (accepted silently); invalid.re carries
fill-origin's grammar (no view-box, unlike <geometry-box>), whose error
names the property.

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
  File "invalid.re", line 1, characters 21-29:
  1 | [%css {|fill-origin: view-box|}];
                           ^^^^^^^^
  Error: Property 'fill-origin' has an invalid value: 'view-box',
         Expected 'border-box', 'content-box', 'fill-box', 'match-parent',
         'padding-box', or 'stroke-box'. Did you mean 'fill-box'?
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ("._a_fj56cl{fill-break:slice;}", "_a_fj56cl", "0,1,0 own", "559", 1, false)
  ];
  [@css
    ("._a_fjev2u{fill-break:clone;}", "_a_fjev2u", "0,1,0 own", "559", 1, false)
  ];
  [@css
    ("._a_fke35e{fill-color:red;}", "_a_fke35e", "0,1,0 own", "560", 1, false)
  ];
  [@css
    ("._a_fll8sq{fill-image:none;}", "_a_fll8sq", "0,1,0 own", "561", 1, false)
  ];
  [@css
    (
      "._a_flgv4m{fill-image:none, none;}",
      "_a_flgv4m",
      "0,1,0 own",
      "561",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fmya6b{fill-origin:match-parent;}",
      "_a_fmya6b",
      "0,1,0 own",
      "562",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fm29sd{fill-origin:fill-box;}",
      "_a_fm29sd",
      "0,1,0 own",
      "562",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fnlyrj{fill-position:center;}",
      "_a_fnlyrj",
      "0,1,0 own",
      "563",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fnkrpk{fill-position:center, top left;}",
      "_a_fnkrpk",
      "0,1,0 own",
      "563",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fov7hi{fill-repeat:repeat-x;}",
      "_a_fov7hi",
      "0,1,0 own",
      "564",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fo6jli{fill-repeat:repeat-x, space;}",
      "_a_fo6jli",
      "0,1,0 own",
      "564",
      1,
      false,
    )
  ];
  [@css
    ("._a_fp0opq{fill-size:cover;}", "_a_fp0opq", "0,1,0 own", "565", 1, false)
  ];
  [@css
    (
      "._a_fpgmie{fill-size:cover, 10px 20px;}",
      "_a_fpgmie",
      "0,1,0 own",
      "565",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gkxdk3{stroke-align:inset;}",
      "_a_gkxdk3",
      "0,1,0 own",
      "596",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gl0rrf{stroke-break:bounding-box;}",
      "_a_gl0rrf",
      "0,1,0 own",
      "597",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gmvg6s{stroke-dash-corner:none;}",
      "_a_gmvg6s",
      "0,1,0 own",
      "598",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gmty9s{stroke-dash-corner:5px;}",
      "_a_gmty9s",
      "0,1,0 own",
      "598",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gnokf8{stroke-dash-justify:none;}",
      "_a_gnokf8",
      "0,1,0 own",
      "599",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gn7mdb{stroke-dash-justify:stretch dashes;}",
      "_a_gn7mdb",
      "0,1,0 own",
      "599",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gomj20{stroke-image:none;}",
      "_a_gomj20",
      "0,1,0 own",
      "600",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gpym2d{stroke-origin:stroke-box;}",
      "_a_gpym2d",
      "0,1,0 own",
      "601",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gqpijn{stroke-position:50% 50%;}",
      "_a_gqpijn",
      "0,1,0 own",
      "602",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_grl4q4{stroke-repeat:round;}",
      "_a_grl4q4",
      "0,1,0 own",
      "603",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gsg9ov{stroke-size:contain;}",
      "_a_gsg9ov",
      "0,1,0 own",
      "604",
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
      (23, "", [18]),
      (24, "", [19]),
      (25, "", [20]),
      (26, "", [21]),
      (27, "", [22]),
      (28, "", [23]),
    ]
  ];
  
  CSS.make("_a_fj56cl", []);
  CSS.make("_a_fjev2u", []);
  CSS.make("_a_fke35e", []);
  CSS.make("_a_fll8sq", []);
  CSS.make("_a_flgv4m", []);
  CSS.make("_a_fmya6b", []);
  CSS.make("_a_fm29sd", []);
  CSS.make("_a_fnlyrj", []);
  CSS.make("_a_fnkrpk", []);
  CSS.make("_a_fov7hi", []);
  CSS.make("_a_fo6jli", []);
  CSS.make("_a_fp0opq", []);
  CSS.make("_a_fpgmie", []);
  CSS.make("_a_gkxdk3", []);
  CSS.make("_a_gl0rrf", []);
  CSS.make("_a_gmvg6s", []);
  CSS.make("_a_gmty9s", []);
  CSS.make("_a_gnokf8", []);
  CSS.make("_a_gn7mdb", []);
  CSS.make("_a_gomj20", []);
  CSS.make("_a_gpym2d", []);
  CSS.make("_a_gqpijn", []);
  CSS.make("_a_grl4q4", []);
  CSS.make("_a_gsg9ov", []);
