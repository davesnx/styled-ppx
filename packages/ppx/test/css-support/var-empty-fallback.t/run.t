This test ensures var() accepts an explicitly empty fallback (`var(--x,)`),
per css-variables-1 where the fallback is `<declaration-value>?` (may be
empty), while still accepting a non-empty multi-token fallback and still
rejecting nothing where a comma isn't present at all.

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
    ("._a_4e8w5r{color:var(--x);}", "_a_4e8w5r", "0,1,0 own", "158", 1, false)
  ];
  [@css
    ("._a_4e0bz1{color:var(--x,);}", "_a_4e0bz1", "0,1,0 own", "158", 1, false)
  ];
  [@css
    ("._a_4exf5k{color:var(--x, );}", "_a_4exf5k", "0,1,0 own", "158", 1, false)
  ];
  [@css
    (
      "._a_7pcyrh{margin:var(--m, 1px 2px);}",
      "_a_7pcyrh",
      "0,1,0 own",
      "277",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_4eens4{color:var(--x, var(--y,));}",
      "_a_4eens4",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (3, "", [0]),
      (4, "", [1]),
      (5, "", [2]),
      (6, "", [3]),
      (7, "", [4]),
    ]
  ];
  
  CSS.make("_a_4e8w5r", []);
  CSS.make("_a_4e0bz1", []);
  CSS.make("_a_4exf5k", []);
  CSS.make("_a_7pcyrh", []);
  CSS.make("_a_4eens4", []);
