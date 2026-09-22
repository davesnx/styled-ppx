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
  [@css ".css-k008qs{display:flex;}"];
  [@css ".css-1d33txl > *{min-height:0;}"];
  [@css "@media (min-width: 100px) {.css-oi5e8m{display:flex;}}"];
  [@css ".css-ehba41{cursor:-webkit-grab;cursor:grab;}"];
  
  CSS.make("css-k008qs", []);
  
  CSS.make("css-k008qs", []);
  
  CSS.make("css-1d33txl", []);
  CSS.make("css-1d33txl", []);
  
  CSS.make("css-oi5e8m", []);
  CSS.make("css-oi5e8m", []);
  
  CSS.make("css-ehba41", []);
  CSS.make("css-ehba41", []);
