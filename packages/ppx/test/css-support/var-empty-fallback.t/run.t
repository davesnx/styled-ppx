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
  [@css ".a-4e8w5r{color:var(--x);}"];
  [@css ".a-4e0bz1{color:var(--x,);}"];
  [@css ".a-4exf5k{color:var(--x, );}"];
  [@css ".a-7pcyrh{margin:var(--m, 1px 2px);}"];
  [@css ".a-4eens4{color:var(--x, var(--y,));}"];
  
  CSS.make("a-4e8w5r", []);
  CSS.make("a-4e0bz1", []);
  CSS.make("a-4exf5k", []);
  CSS.make("a-7pcyrh", []);
  CSS.make("a-4eens4", []);
