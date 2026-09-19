This test ensures a declaration renders identically regardless of what
terminates it in source: an explicit `;`, the end of a block (`}`), or the
end of input. A declaration whose value is followed by a source-level space
before its terminator must not keep that space in the rendered CSS, and must
therefore hash to the same atom as the equivalent declaration with no
trailing space.

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

Each pair below is the same declaration once terminated by `;` (no source
space before it) and once terminated by the end of a block or of input
(with a source space before it). Both members of a pair must render and
hash identically.

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css ".css-k008qs{display:flex;}"];
  [@css ".css-1d33txl > *{min-height:0;}"];
  [@css "@media (min-width: 100px) {.css-oi5e8m{display:flex;}}"];
  
  CSS.make("css-k008qs", []);
  
  CSS.make("css-k008qs", []);
  
  CSS.make("css-1d33txl", []);
  CSS.make("css-1d33txl", []);
  
  CSS.make("css-oi5e8m", []);
  CSS.make("css-oi5e8m", []);
