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
  [@css
    ("._a_5r08qs{display:flex;}", "_a_5r08qs", "0,1,0 own", "207", 1, false)
  ];
  [@css
    (
      "._a_7rw2m8a3txl > *{min-height:0;}",
      "_a_7rw2m8a3txl",
      "0,1,0 & > *",
      "298",
      1,
      true,
    )
  ];
  [@css
    (
      "@media (min-width: 100px) {._a_6pdot5r5e8m{display:flex;}}",
      "_a_6pdot5r5e8m",
      "0,1,0 own",
      "207",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5lba41{cursor:-webkit-grab;cursor:grab;}",
      "_a_5lba41",
      "0,1,0 own",
      "201",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (3, "", [0]),
      (7, "", [0]),
      (11, "", [1]),
      (12, "", [1]),
      (15, "", [2]),
      (16, "", [2]),
      (20, "", [3]),
      (21, "", [3]),
    ]
  ];
  
  CSS.make("_a_5r08qs", []);
  
  CSS.make("_a_5r08qs", []);
  
  CSS.make("_a_7rw2m8a3txl", []);
  CSS.make("_a_7rw2m8a3txl", []);
  
  CSS.make("_a_6pdot5r5e8m", []);
  CSS.make("_a_6pdot5r5e8m", []);
  
  CSS.make("_a_5lba41", []);
  CSS.make("_a_5lba41", []);
