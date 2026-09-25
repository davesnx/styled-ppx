Functional pseudo-elements (`::part()`, `::slotted()`) and the Selectors
Level 4 "of S" form of `:nth-child()`/`:nth-last-child()` were both
unparseable (.workplace/docs/parser-audit-defects.md #7, #8): the lexer only
special-cases `nth-*` names for An+B payloads, so no other identifier
followed by `(` ever reached a pseudo-element parser, and `parse_nth_payload`
had no branch for the `of` keyword.

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
  [@css ".a-1scn809::part(foo){color:red;}"];
  [@css ".a-upe6d9::slotted(.bar){color:blue;}"];
  [@css ".a-1uy51rt:nth-child(2n+1 of .x){color:green;}"];
  [@css ".a-1qws5ty:nth-last-child(odd of .a,.b){color:yellow;}"];
  [@css.bindings
    [
      ("Input._part", "id-3hanao", "a-1scn809"),
      ("Input._slotted", "id-n06isq", "a-upe6d9"),
      ("Input._nth_child_of", "id-1k5qaw3", "a-1uy51rt"),
      ("Input._nth_last_child_of_list", "id-1vkw39v", "a-1qws5ty"),
    ]
  ];
  
  let _part = CSS.make("label:_part id-3hanao a-1scn809", []);
  
  let _slotted = CSS.make("label:_slotted id-n06isq a-upe6d9", []);
  
  let _nth_child_of = CSS.make("label:_nth_child_of id-1k5qaw3 a-1uy51rt", []);
  
  let _nth_last_child_of_list =
    CSS.make("label:_nth_last_child_of_list id-1vkw39v a-1qws5ty", []);

  $ dune build
