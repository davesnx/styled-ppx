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
  [@css.atoms
    [
      (
        "_c7fckIxoSO1-tGH",
        ["._c7fckIxoSO1-tGH::part(foo){color:red;}"],
        2,
        1,
        1,
        [
          ("ctx", "ckIxoS", "ctx\\0&::part(foo) | "),
          ("value", "O1-tGH", "val\\07f\\0&::part(foo) | \\0color:red"),
        ],
      ),
      (
        "_c7fu9c8y49wzGc4",
        ["._c7fu9c8y49wzGc4::slotted(.bar){color:blue;}"],
        2,
        1,
        1,
        [
          ("ctx", "u9c8y4", "ctx\\0&::slotted(.bar) | "),
          ("value", "9wzGc4", "val\\07f\\0&::slotted(.bar) | \\0color:blue"),
        ],
      ),
      (
        "_c7f1ytCvrGdR7dA",
        ["._c7f1ytCvrGdR7dA:nth-child(2n+1 of .x){color:green;}"],
        2,
        1,
        1,
        [
          ("ctx", "1ytCvr", "ctx\\0&:nth-child(2n+1 of .x) | "),
          (
            "value",
            "GdR7dA",
            "val\\07f\\0&:nth-child(2n+1 of .x) | \\0color:green",
          ),
        ],
      ),
      (
        "_c7fw_ooS0E1jBDy",
        ["._c7fw_ooS0E1jBDy:nth-last-child(odd of .a,.b){color:yellow;}"],
        2,
        1,
        1,
        [
          ("ctx", "w_ooS0", "ctx\\0&:nth-last-child(odd of .a,.b) | "),
          (
            "value",
            "E1jBDy",
            "val\\07f\\0&:nth-last-child(odd of .a,.b) | \\0color:yellow",
          ),
        ],
      ),
      (
        "_iO07H2Z4_",
        [],
        1,
        0,
        0,
        [("id", "_iO07H2Z4_", "bind\\0\\0Input\\0\\0_part\\00")],
      ),
      (
        "_ibt8CpdH8",
        [],
        1,
        0,
        0,
        [("id", "_ibt8CpdH8", "bind\\0\\0Input\\0\\0_slotted\\00")],
      ),
      (
        "_iPJCmT2NO",
        [],
        1,
        0,
        0,
        [("id", "_iPJCmT2NO", "bind\\0\\0Input\\0\\0_nth_child_of\\00")],
      ),
      (
        "_iGhag597M",
        [],
        1,
        0,
        0,
        [
          (
            "id",
            "_iGhag597M",
            "bind\\0\\0Input\\0\\0_nth_last_child_of_list\\00",
          ),
        ],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input._part", "_iO07H2Z4_ _c7fckIxoSO1-tGH", "_iO07H2Z4_"),
      ("Input._slotted", "_ibt8CpdH8 _c7fu9c8y49wzGc4", "_ibt8CpdH8"),
      ("Input._nth_child_of", "_iPJCmT2NO _c7f1ytCvrGdR7dA", "_iPJCmT2NO"),
      (
        "Input._nth_last_child_of_list",
        "_iGhag597M _c7fw_ooS0E1jBDy",
        "_iGhag597M",
      ),
    ]
  ];
  
  let _part = CSS.make("_iO07H2Z4_ _c7fckIxoSO1-tGH", []);
  
  let _slotted = CSS.make("_ibt8CpdH8 _c7fu9c8y49wzGc4", []);
  
  let _nth_child_of = CSS.make("_iPJCmT2NO _c7f1ytCvrGdR7dA", []);
  
  let _nth_last_child_of_list = CSS.make("_iGhag597M _c7fw_ooS0E1jBDy", []);

  $ dune build
