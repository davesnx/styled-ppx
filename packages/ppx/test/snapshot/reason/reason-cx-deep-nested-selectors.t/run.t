Regression test for deep-nested selectors in a [%css] block.

When a [%css ...] block contains a Style_rule nested inside another
Style_rule (depth >= 2 of selector nesting), every parent prelude must
be merged into the inner selector of the extracted rule.

Each child selector is merged into the accumulated parent prelude via
`Selector_nesting.compute_new_prefix`, so `&`, `::pseudo-element`, and
descendant combinators all resolve correctly at any depth.

Selectors covered here:
- single                -> :hover                 (control, single-level)
- twoLevel              -> :focus-visible::after  (pseudo-element under pseudo-class)
- twoLevelPseudoClass   -> :hover:focus           (pseudo-class under pseudo-class)
- threeLevel            -> :hover .child:focus    (three levels with descendant)
- descendantUnderPseudo -> :hover .child          (descendant under pseudo-class)

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".css-ivpcvmo{color:red;}.css-ivpcvmo:hover{color:blue;}"]
  [@@@css
    ".css-ivpc80y{color:red;}.css-ivpc80y:focus-visible::after{content:\"\";}"]
  [@@@css ".css-ivpcvcf{color:red;}.css-ivpcvcf:hover:focus{color:green;}"]
  [@@@css
    ".css-ivpc4e5{color:red;}.css-ivpc4e5:hover .child:focus{color:green;}"]
  [@@@css ".css-ivpcnb0{color:red;}.css-ivpcnb0:hover .child{color:blue;}"]
  [@@@css.classes
    [("css-ivpcvmo", 0, "Input.single", "input.ml", 10, 2, 14, 0);
    ("css-ivpc80y", 1, "Input.twoLevel", "input.ml", 20, 2, 26, 0);
    ("css-ivpcvcf", 2, "Input.twoLevelPseudoClass", "input.ml", 32, 2, 38, 0);
    ("css-ivpc4e5", 3, "Input.threeLevel", "input.ml", 44, 2, 52, 0);
    ("css-ivpcnb0", 4, "Input.descendantUnderPseudo", "input.ml", 58, 2, 64, 0)]]
  [@@@css.bindings
    [("Input.single", "css-ivpcvmo");
    ("Input.twoLevel", "css-ivpc80y");
    ("Input.twoLevelPseudoClass", "css-ivpcvcf");
    ("Input.threeLevel", "css-ivpc4e5");
    ("Input.descendantUnderPseudo", "css-ivpcnb0")]]
  let single = CSS.make "css-ivpcvmo" []
  let twoLevel = CSS.make "css-ivpc80y" []
  let twoLevelPseudoClass = CSS.make "css-ivpcvcf" []
  let threeLevel = CSS.make "css-ivpc4e5" []
  let descendantUnderPseudo = CSS.make "css-ivpcnb0" []
