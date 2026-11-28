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
  [@css ".css-ivpcts1{color:var(--x);}"];
  [@css ".css-ivpchya{color:var(--x,);}"];
  [@css ".css-ivpcysg{color:var(--x, );}"];
  [@css ".css-ivpcc3q{margin:var(--m, 1px 2px);}"];
  [@css ".css-ivpc794{color:var(--x, var(--y,));}"];
  [@css.classes
    [
      ("css-ivpcts1", 0, "", "input.re", 3, 8, 3, 23),
      ("css-ivpchya", 1, "", "input.re", 4, 8, 4, 24),
      ("css-ivpcysg", 2, "", "input.re", 5, 8, 5, 25),
      ("css-ivpcc3q", 3, "", "input.re", 6, 8, 6, 33),
      ("css-ivpc794", 4, "", "input.re", 7, 8, 7, 34),
    ]
  ];
  
  CSS.make("css-ivpcts1", []);
  CSS.make("css-ivpchya", []);
  CSS.make("css-ivpcysg", []);
  CSS.make("css-ivpcc3q", []);
  CSS.make("css-ivpc794", []);
