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
  [@css ".css-1ycmu5d{display:flex;}"];
  [@css ".css-ur0zkv > *{min-height:0;}"];
  [@css "@media (min-width: 100px) {.css-124b8tz{display:flex;}}"];
  [@css ".css-15qfupi{cursor:-webkit-grab;cursor:grab;}"];
  [@css.classes
    [
      ("css-1ycmu5d", 0, "", "input.re", 3, 9, 3, 24),
      ("css-ur0zkv", 1, "", "input.re", 11, 9, 11, 34),
      ("css-124b8tz", 2, "", "input.re", 15, 9, 15, 54),
      ("css-15qfupi", 3, "", "input.re", 20, 9, 20, 23),
    ]
  ];
  
  CSS.make("css-1ycmu5d", []);
  
  CSS.make("css-1ycmu5d", []);
  
  CSS.make("css-ur0zkv", []);
  CSS.make("css-ur0zkv", []);
  
  CSS.make("css-124b8tz", []);
  CSS.make("css-124b8tz", []);
  
  CSS.make("css-15qfupi", []);
  CSS.make("css-15qfupi", []);
