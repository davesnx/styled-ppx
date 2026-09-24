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
  [@css ".css-9e8w5r{color:var(--x);}"];
  [@css ".css-dy0bz1{color:var(--x,);}"];
  [@css ".css-13rxf5k{color:var(--x, );}"];
  [@css ".css-1lvcyrh{margin:var(--m, 1px 2px);}"];
  [@css ".css-fjens4{color:var(--x, var(--y,));}"];
  
  CSS.make("css-9e8w5r", []);
  CSS.make("css-dy0bz1", []);
  CSS.make("css-13rxf5k", []);
  CSS.make("css-1lvcyrh", []);
  CSS.make("css-fjens4", []);
