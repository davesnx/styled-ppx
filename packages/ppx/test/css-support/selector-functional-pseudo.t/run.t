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
  [@css "._a_5r7jx4en809::part(foo){color:red;}"];
  [@css "._a_wmvcz4ee6d9::slotted(.bar){color:blue;}"];
  [@css "._a_da0h14e51rt:nth-child(2n+1 of .x){color:green;}"];
  [@css "._a_kj3e34es5ty:nth-last-child(odd of .a,.b){color:yellow;}"];
  [@css.bindings
    [
      ("Input._part", "_id_3hanao", "_a_5r7jx4en809"),
      ("Input._slotted", "_id_n06isq", "_a_wmvcz4ee6d9"),
      ("Input._nth_child_of", "_id_1k5qaw3", "_a_da0h14e51rt"),
      ("Input._nth_last_child_of_list", "_id_1vkw39v", "_a_kj3e34es5ty"),
    ]
  ];
  
  let _part = CSS.make("label:_part _id_3hanao _a_5r7jx4en809", []);
  
  let _slotted = CSS.make("label:_slotted _id_n06isq _a_wmvcz4ee6d9", []);
  
  let _nth_child_of =
    CSS.make("label:_nth_child_of _id_1k5qaw3 _a_da0h14e51rt", []);
  
  let _nth_last_child_of_list =
    CSS.make("label:_nth_last_child_of_list _id_1vkw39v _a_kj3e34es5ty", []);

  $ dune build
