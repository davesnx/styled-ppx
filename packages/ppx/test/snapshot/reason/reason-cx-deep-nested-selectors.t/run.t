Regression test for cx2 deep-nested selector atomization.

When a [%css ...] block contains a Style_rule nested inside another
Style_rule (depth >= 2 of selector nesting), every parent prelude must
be merged into the inner selector when atomizing for static extraction.

`extract_atomic_rules` (packages/ppx/src/Css_file.re) threads the
accumulated parent prelude through its recursion and merges each child
selector into it via `Selector_nesting.compute_new_prefix`, so `&`,
`::pseudo-element`, and descendant combinators all resolve correctly at
any depth. See styled-ppx-bug-report-4.md.

Selectors covered here:
- single                -> :hover                 (control, single-level)
- twoLevel              -> :focus-visible::after  (pseudo-element under pseudo-class)
- twoLevelPseudoClass   -> :hover:focus           (pseudo-class under pseudo-class)
- threeLevel            -> :hover .child:focus    (three levels with descendant)
- descendantUnderPseudo -> :hover .child          (descendant under pseudo-class)

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css.atoms
    [("_a7fadbhEW", ["._a7fadbhEW{color:red;}"], 1, 0, 1,
       [("value", "adbhEW", "val\\07f\\0& | \\0color:red")]);
    ("_c7f1Tl5-wTx08Fk", ["._c7f1Tl5-wTx08Fk:hover{color:blue;}"], 2, 1, 1,
      [("ctx", "1Tl5-w", "ctx\\0&:hover | ");
      ("value", "Tx08Fk", "val\\07f\\0&:hover | \\0color:blue")]);
    ("_c8iLNkI0LdcQTpA",
      ["._c8iLNkI0LdcQTpA:focus-visible::after{content:\"\";}"], 2, 1, 1,
      [("ctx", "LNkI0L", "ctx\\0&:focus-visible::after | ");
      ("value", "dcQTpA",
        "val\\08i\\0&:focus-visible::after | \\0content:\"\"")]);
    ("_c7f-QfSkEHxRRZG", ["._c7f-QfSkEHxRRZG:focus:hover{color:green;}"], 2, 1,
      1,
      [("ctx", "-QfSkE", "ctx\\0&:focus:hover | ");
      ("value", "HxRRZG", "val\\07f\\0&:focus:hover | \\0color:green")]);
    ("_c7fz5n-fRzvtuQ3",
      ["._c7fz5n-fRzvtuQ3:hover .child:focus{color:green;}"], 0, 1, 1,
      [("ctx", "z5n-fR", "ctx\\0&:hover .child:focus | ");
      ("value", "zvtuQ3", "val\\07f\\0&:hover .child:focus | \\0color:green")]);
    ("_c7fl8GzBulCWW8C", ["._c7fl8GzBulCWW8C:hover .child{color:blue;}"], 0, 1,
      1,
      [("ctx", "l8GzBu", "ctx\\0&:hover .child | ");
      ("value", "lCWW8C", "val\\07f\\0&:hover .child | \\0color:blue")]);
    ("_ie9RbboSj", [], 1, 0, 0,
      [("id", "_ie9RbboSj", "bind\\0\\0Input\\0\\0single\\00")]);
    ("_iSmXTMget", [], 1, 0, 0,
      [("id", "_iSmXTMget", "bind\\0\\0Input\\0\\0twoLevel\\00")]);
    ("_ip2bQTQsd", [], 1, 0, 0,
      [("id", "_ip2bQTQsd", "bind\\0\\0Input\\0\\0twoLevelPseudoClass\\00")]);
    ("_iIIgqnqA0", [], 1, 0, 0,
      [("id", "_iIIgqnqA0", "bind\\0\\0Input\\0\\0threeLevel\\00")]);
    ("_iDZPPGpMq", [], 1, 0, 0,
      [("id", "_iDZPPGpMq", "bind\\0\\0Input\\0\\0descendantUnderPseudo\\00")])]]
  [@@@css.bindings
    [("Input.single", "_ie9RbboSj _a7fadbhEW _c7f1Tl5-wTx08Fk", "_ie9RbboSj");
    ("Input.twoLevel", "_iSmXTMget _a7fadbhEW _c8iLNkI0LdcQTpA", "_iSmXTMget");
    ("Input.twoLevelPseudoClass", "_ip2bQTQsd _a7fadbhEW _c7f-QfSkEHxRRZG",
      "_ip2bQTQsd");
    ("Input.threeLevel", "_iIIgqnqA0 _a7fadbhEW _c7fz5n-fRzvtuQ3",
      "_iIIgqnqA0");
    ("Input.descendantUnderPseudo", "_iDZPPGpMq _a7fadbhEW _c7fl8GzBulCWW8C",
      "_iDZPPGpMq")]]
  let single = CSS.make "_ie9RbboSj _a7fadbhEW _c7f1Tl5-wTx08Fk" []
  let twoLevel = CSS.make "_iSmXTMget _a7fadbhEW _c8iLNkI0LdcQTpA" []
  let twoLevelPseudoClass =
    CSS.make "_ip2bQTQsd _a7fadbhEW _c7f-QfSkEHxRRZG" []
  let threeLevel = CSS.make "_iIIgqnqA0 _a7fadbhEW _c7fz5n-fRzvtuQ3" []
  let descendantUnderPseudo =
    CSS.make "_iDZPPGpMq _a7fadbhEW _c7fl8GzBulCWW8C" []
