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
  [@css ".css-ivpcu5d{display:flex;}"];
  [@css ".css-ivpczkv > *{min-height:0;}"];
  [@css "@media (min-width: 100px) {.css-ivpc8tz{display:flex;}}"];
  [@css ".css-ivpcupi{cursor:-webkit-grab;cursor:grab;}"];
  [@css.classes
    [
      ("css-ivpcu5d", 0, "", "input.re", 3, 9, 3, 24),
      ("css-ivpczkv", 1, "", "input.re", 11, 9, 11, 34),
      ("css-ivpc8tz", 2, "", "input.re", 15, 9, 15, 54),
      ("css-ivpcupi", 3, "", "input.re", 20, 9, 20, 23),
    ]
  ];
  
  CSS.make("css-ivpcu5d", []);
  
  CSS.make("css-ivpcu5d", []);
  
  CSS.make("css-ivpczkv", []);
  CSS.make("css-ivpczkv", []);
  
  CSS.make("css-ivpc8tz", []);
  CSS.make("css-ivpc8tz", []);
  
  CSS.make("css-ivpcupi", []);
  CSS.make("css-ivpcupi", []);
