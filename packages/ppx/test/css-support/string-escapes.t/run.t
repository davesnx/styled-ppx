String escape round-trip tests. Verifies that characters requiring
backslash escaping inside CSS <string-token>s are correctly re-encoded
when the AST is rendered back to a CSS string. See
documents/string-escape-bug.md for context.

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
    ("._a_4wu917{content:\"\\\"\";}", "_a_4wu917", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4w1y2p{content:\"\\\\\";}", "_a_4w1y2p", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4w6l48{content:\"'\";}", "_a_4w6l48", "0,1,0 own", "176", 1, false)
  ];
  [@css
    (
      "._a_4wucdh{content:\"a\\\"b\";}",
      "_a_4wucdh",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wugqq{content:\"before\\\\after\";}",
      "_a_4wugqq",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wew8m{content:\"line\\A one\";}",
      "_a_4wew8m",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    ("._a_4w5ir8{content:\"—\";}", "_a_4w5ir8", "0,1,0 own", "176", 1, false)
  ];
  [@css
    (
      "._a_g49s14ek38d [data-name=\"O\\\"Brien\"]{color:red;}",
      "_a_g49s14ek38d",
      "0,2,0 & [data-name=\"O\\\"Brien\"]",
      "158",
      1,
      true,
    )
  ];
  [@css
    (
      "._a_39000808vt{background-image:url(\"path/with\\\"quote.png\");}",
      "_a_39000808vt",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_390008wlhr{background-image:url(\"path\\\\to\\\\file.png\");}",
      "_a_390008wlhr",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    ("._a_4wqqv9{content:\"\\9 \";}", "_a_4wqqv9", "0,1,0 own", "176", 1, false)
  ];
  [@css
    (
      "._a_4wy7g7{content:\"\\7F \";}",
      "_a_4wy7g7",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (12, "", [0]),
      (16, "", [1]),
      (19, "", [2]),
      (22, "", [3]),
      (25, "", [4]),
      (30, "", [5]),
      (34, "", [6]),
      (39, "", [2]),
      (43, "", [7]),
      (47, "", [8]),
      (50, "", [9]),
      (55, "", [10]),
      (59, "", [11]),
    ]
  ];
  
  CSS.make("_a_4wu917", []);
  
  CSS.make("_a_4w1y2p", []);
  
  CSS.make("_a_4w6l48", []);
  
  CSS.make("_a_4wucdh", []);
  
  CSS.make("_a_4wugqq", []);
  
  CSS.make("_a_4wew8m", []);
  
  CSS.make("_a_4w5ir8", []);
  
  CSS.make("_a_4w6l48", []);
  
  CSS.make("_a_g49s14ek38d", []);
  
  CSS.make("_a_39000808vt", []);
  
  CSS.make("_a_390008wlhr", []);
  
  CSS.make("_a_4wqqv9", []);
  
  CSS.make("_a_4wy7g7", []);
