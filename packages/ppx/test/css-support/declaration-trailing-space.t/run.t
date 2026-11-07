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
  [@css.atoms
    [
      (
        "_a9fMU0SCS",
        ["._a9fMU0SCS{display:flex;}"],
        1,
        0,
        1,
        [("value", "MU0SCS", "val\\09f\\0& | \\0display:flex")],
      ),
      (
        "_ceqkDsyxkl3zePh",
        ["._ceqkDsyxkl3zePh > *{min-height:0;}"],
        0,
        1,
        1,
        [
          ("ctx", "kDsyxk", "ctx\\0& > * | "),
          ("value", "l3zePh", "val\\0eq\\0& > * | \\0min-height:0"),
        ],
      ),
      (
        "_c9fzDjCmYLDw3ng",
        ["@media (min-width:100px){._c9fzDjCmYLDw3ng{display:flex;}}"],
        2,
        1,
        1,
        [
          ("ctx", "zDjCmY", "ctx\\0& | @media (min-width:100px) | "),
          (
            "value",
            "LDw3ng",
            "val\\09f\\0& | @media (min-width:100px) | \\0display:flex",
          ),
        ],
      ),
      (
        "_a99o8062j",
        ["._a99o8062j{cursor:-webkit-grab;cursor:grab;}"],
        1,
        0,
        1,
        [("value", "o8062j", "val\\099\\0& | \\0cursor:grab")],
      ),
    ]
  ];
  
  CSS.make("_a9fMU0SCS", []);
  
  CSS.make("_a9fMU0SCS", []);
  
  CSS.make("_ceqkDsyxkl3zePh", []);
  CSS.make("_ceqkDsyxkl3zePh", []);
  
  CSS.make("_c9fzDjCmYLDw3ng", []);
  CSS.make("_c9fzDjCmYLDw3ng", []);
  
  CSS.make("_a99o8062j", []);
  CSS.make("_a99o8062j", []);
