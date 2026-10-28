CSS Borders and Box Decorations L4 (https://drafts.csswg.org/css-borders-4/):
per-side border radius/clip shorthands, border-limit, and the box-shadow-*
longhands (not yet wired as box-shadow's own reset set). input.re carries
valid declarations (accepted silently); invalid.re carries an out-of-grammar
keyword, whose error names the property.

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
  File "invalid.re", line 1, characters 22-30:
  1 | [%css {|border-limit: diagonal|}];
                            ^^^^^^^^
  Error: Property 'border-limit' has an invalid value: 'diagonal',
         Expected 'all', 'bottom', 'corners', 'left', 'right', 'sides', or
         'top'.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    (
      "._a_3n000cl1tb{border-top-radius:10px;}",
      "_a_3n000cl1tb",
      "0,1,0 own",
      "131",
      12,
      false,
    )
  ];
  [@css
    (
      "._a_3n000c0ay0{border-top-radius:10px 5px / 2px 1px;}",
      "_a_3n000c0ay0",
      "0,1,0 own",
      "131",
      12,
      false,
    )
  ];
  [@css
    (
      "._a_3n000avogz{border-right-radius:4px;}",
      "_a_3n000avogz",
      "0,1,0 own",
      "131",
      10,
      false,
    )
  ];
  [@css
    (
      "._a_3n00033qjb{border-bottom-radius:4px;}",
      "_a_3n00033qjb",
      "0,1,0 own",
      "131",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_3n0005n019{border-left-radius:4px;}",
      "_a_3n0005n019",
      "0,1,0 own",
      "131",
      5,
      false,
    )
  ];
  [@css
    (
      "._a_h1g86n{border-block-start-radius:4px;}",
      "_a_h1g86n",
      "0,1,0 own",
      "613",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_f7b3em{border-block-end-radius:4px;}",
      "_a_f7b3em",
      "0,1,0 own",
      "547",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_h3hyd2{border-inline-start-radius:4px;}",
      "_a_h3hyd2",
      "0,1,0 own",
      "615",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_h2dz7t{border-inline-end-radius:4px;}",
      "_a_h2dz7t",
      "0,1,0 own",
      "614",
      1,
      false,
    )
  ];
  [@css
    ("._a_fbpvas{border-limit:all;}", "_a_fbpvas", "0,1,0 own", "551", 1, false)
  ];
  [@css
    (
      "._a_fbqqxc{border-limit:sides 50%;}",
      "_a_fbqqxc",
      "0,1,0 own",
      "551",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fbjp28{border-limit:corners;}",
      "_a_fbjp28",
      "0,1,0 own",
      "551",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fbue5t{border-limit:corners 10px;}",
      "_a_fbue5t",
      "0,1,0 own",
      "551",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fbbzmt{border-limit:left 4em;}",
      "_a_fbbzmt",
      "0,1,0 own",
      "551",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_f90008az3q{border-top-clip:10px 1fr 10px;}",
      "_a_f90008az3q",
      "0,1,0 own",
      "549",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_f90004yn5u{border-right-clip:none;}",
      "_a_f90004yn5u",
      "0,1,0 own",
      "549",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_f900019q3s{border-bottom-clip:0 10px 1fr 10px;}",
      "_a_f900019q3s",
      "0,1,0 own",
      "549",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_f90002emob{border-left-clip:5px;}",
      "_a_f90002emob",
      "0,1,0 own",
      "549",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_f600021ui5{border-block-start-clip:10px;}",
      "_a_f600021ui5",
      "0,1,0 own",
      "546",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_f60001l7yx{border-block-end-clip:10px;}",
      "_a_f60001l7yx",
      "0,1,0 own",
      "546",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fa0002ufja{border-inline-start-clip:10px;}",
      "_a_fa0002ufja",
      "0,1,0 own",
      "550",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_fa0001u3cc{border-inline-end-clip:10px;}",
      "_a_fa0001u3cc",
      "0,1,0 own",
      "550",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_f6ysgj{border-block-clip:10px 1fr;}",
      "_a_f6ysgj",
      "0,1,0 own",
      "546",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_favz6k{border-inline-clip:10px 1fr;}",
      "_a_favz6k",
      "0,1,0 own",
      "550",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_f9e3gi{border-clip:0 1fr;}",
      "_a_f9e3gi",
      "0,1,0 own",
      "549",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_fduw20{box-shadow-color:red;}",
      "_a_fduw20",
      "0,1,0 own",
      "553",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fd3mmo{box-shadow-color:red, blue;}",
      "_a_fd3mmo",
      "0,1,0 own",
      "553",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fejo2u{box-shadow-offset:4px 4px;}",
      "_a_fejo2u",
      "0,1,0 own",
      "554",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fetafk{box-shadow-offset:none, 4px 4px;}",
      "_a_fetafk",
      "0,1,0 own",
      "554",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fcxgmz{box-shadow-blur:12px;}",
      "_a_fcxgmz",
      "0,1,0 own",
      "552",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fgpgkn{box-shadow-spread:40px;}",
      "_a_fgpgkn",
      "0,1,0 own",
      "556",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ffw7at{box-shadow-position:inset;}",
      "_a_ffw7at",
      "0,1,0 own",
      "555",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ffp1t5{box-shadow-position:outset, inset;}",
      "_a_ffp1t5",
      "0,1,0 own",
      "555",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (4, "", [0]),
      (5, "", [1]),
      (6, "", [2]),
      (7, "", [3]),
      (8, "", [4]),
      (9, "", [5]),
      (10, "", [6]),
      (11, "", [7]),
      (12, "", [8]),
      (15, "", [9]),
      (16, "", [10]),
      (17, "", [11]),
      (18, "", [12]),
      (19, "", [13]),
      (22, "", [14]),
      (23, "", [15]),
      (24, "", [16]),
      (25, "", [17]),
      (26, "", [18]),
      (27, "", [19]),
      (28, "", [20]),
      (29, "", [21]),
      (30, "", [22]),
      (31, "", [23]),
      (32, "", [24]),
      (35, "", [25]),
      (36, "", [26]),
      (37, "", [27]),
      (38, "", [28]),
      (39, "", [29]),
      (40, "", [30]),
      (41, "", [31]),
      (42, "", [32]),
    ]
  ];
  
  CSS.make("_a_3n000cl1tb", []);
  CSS.make("_a_3n000c0ay0", []);
  CSS.make("_a_3n000avogz", []);
  CSS.make("_a_3n00033qjb", []);
  CSS.make("_a_3n0005n019", []);
  CSS.make("_a_h1g86n", []);
  CSS.make("_a_f7b3em", []);
  CSS.make("_a_h3hyd2", []);
  CSS.make("_a_h2dz7t", []);
  
  CSS.make("_a_fbpvas", []);
  CSS.make("_a_fbqqxc", []);
  CSS.make("_a_fbjp28", []);
  CSS.make("_a_fbue5t", []);
  CSS.make("_a_fbbzmt", []);
  
  CSS.make("_a_f90008az3q", []);
  CSS.make("_a_f90004yn5u", []);
  CSS.make("_a_f900019q3s", []);
  CSS.make("_a_f90002emob", []);
  CSS.make("_a_f600021ui5", []);
  CSS.make("_a_f60001l7yx", []);
  CSS.make("_a_fa0002ufja", []);
  CSS.make("_a_fa0001u3cc", []);
  CSS.make("_a_f6ysgj", []);
  CSS.make("_a_favz6k", []);
  CSS.make("_a_f9e3gi", []);
  
  CSS.make("_a_fduw20", []);
  CSS.make("_a_fd3mmo", []);
  CSS.make("_a_fejo2u", []);
  CSS.make("_a_fetafk", []);
  CSS.make("_a_fcxgmz", []);
  CSS.make("_a_fgpgkn", []);
  CSS.make("_a_ffw7at", []);
  CSS.make("_a_ffp1t5", []);
