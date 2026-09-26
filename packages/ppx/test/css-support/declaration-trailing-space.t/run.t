This test ensures a declaration renders identically regardless of what
terminates it in source: an explicit `;`, the end of a block (`}`), or the
end of input. The parser drops leading and trailing whitespace from the
value, so the renderer, the autoprefixer and the validator all see the same
value: a declaration followed by a source-level space before its terminator
hashes to the same atom, with the same body, as the equivalent declaration
with no trailing space.

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
  [@css "._a_5r08qs{display:flex;}"];
  [@css "._a_7rw2m8a3txl > *{min-height:0;}"];
  [@css "@media (min-width: 100px) {._a_6pdot5r5e8m{display:flex;}}"];
  [@css "._a_5lba41{cursor:-webkit-grab;cursor:grab;}"];
  
  CSS.make("_a_5r08qs", []);
  
  CSS.make("_a_5r08qs", []);
  
  CSS.make("_a_7rw2m8a3txl", []);
  CSS.make("_a_7rw2m8a3txl", []);
  
  CSS.make("_a_6pdot5r5e8m", []);
  CSS.make("_a_6pdot5r5e8m", []);
  
  CSS.make("_a_5lba41", []);
  CSS.make("_a_5lba41", []);
