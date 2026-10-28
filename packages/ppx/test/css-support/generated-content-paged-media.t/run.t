CSS Generated Content L3 (bookmark-label, bookmark-level, bookmark-state,
string-set) and CSS Generated Content for Paged Media (running,
footnote-display, footnote-policy). input.re carries valid declarations
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
  File "invalid.re", line 1, characters 24-30:
  1 | [%css {|bookmark-state: hidden|}];
                              ^^^^^^
  Error: Property 'bookmark-state' has an invalid value: 'hidden',
         Expected 'closed' or 'open'.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    (
      "._a_f3iw93{bookmark-label:\"Chapter\";}",
      "_a_f3iw93",
      "0,1,0 own",
      "543",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_f31cv3{bookmark-label:counter(chapter);}",
      "_a_f31cv3",
      "0,1,0 own",
      "543",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_f4gtar{bookmark-level:none;}",
      "_a_f4gtar",
      "0,1,0 own",
      "544",
      1,
      false,
    )
  ];
  [@css
    ("._a_f43uz1{bookmark-level:2;}", "_a_f43uz1", "0,1,0 own", "544", 1, false)
  ];
  [@css
    (
      "._a_f5gcl2{bookmark-state:open;}",
      "_a_f5gcl2",
      "0,1,0 own",
      "545",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_f5tdnk{bookmark-state:closed;}",
      "_a_f5tdnk",
      "0,1,0 own",
      "545",
      1,
      false,
    )
  ];
  [@css
    ("._a_gjnekd{string-set:none;}", "_a_gjnekd", "0,1,0 own", "595", 1, false)
  ];
  [@css
    (
      "._a_gjkcpd{string-set:header \"Chapter One\";}",
      "_a_gjkcpd",
      "0,1,0 own",
      "595",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gj4i6x{string-set:header \"Chapter One\", footer \"Page\";}",
      "_a_gj4i6x",
      "0,1,0 own",
      "595",
      1,
      false,
    )
  ];
  [@css
    ("._a_gd5t9y{running:none;}", "_a_gd5t9y", "0,1,0 own", "589", 1, false)
  ];
  [@css
    ("._a_gdmemd{running:myHeader;}", "_a_gdmemd", "0,1,0 own", "589", 1, false)
  ];
  [@css
    (
      "._a_fvhh3d{footnote-display:block;}",
      "_a_fvhh3d",
      "0,1,0 own",
      "571",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fvt121{footnote-display:inline;}",
      "_a_fvt121",
      "0,1,0 own",
      "571",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fvqnac{footnote-display:compact;}",
      "_a_fvqnac",
      "0,1,0 own",
      "571",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fwgn0m{footnote-policy:auto;}",
      "_a_fwgn0m",
      "0,1,0 own",
      "572",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fwpoa2{footnote-policy:line;}",
      "_a_fwpoa2",
      "0,1,0 own",
      "572",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fw06l6{footnote-policy:block;}",
      "_a_fw06l6",
      "0,1,0 own",
      "572",
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
      (13, "", [9]),
      (14, "", [10]),
      (15, "", [11]),
      (16, "", [12]),
      (17, "", [13]),
      (18, "", [14]),
      (19, "", [15]),
      (20, "", [16]),
    ]
  ];
  
  CSS.make("_a_f3iw93", []);
  CSS.make("_a_f31cv3", []);
  CSS.make("_a_f4gtar", []);
  CSS.make("_a_f43uz1", []);
  CSS.make("_a_f5gcl2", []);
  CSS.make("_a_f5tdnk", []);
  CSS.make("_a_gjnekd", []);
  CSS.make("_a_gjkcpd", []);
  CSS.make("_a_gj4i6x", []);
  CSS.make("_a_gd5t9y", []);
  CSS.make("_a_gdmemd", []);
  CSS.make("_a_fvhh3d", []);
  CSS.make("_a_fvt121", []);
  CSS.make("_a_fvqnac", []);
  CSS.make("_a_fwgn0m", []);
  CSS.make("_a_fwpoa2", []);
  CSS.make("_a_fw06l6", []);
