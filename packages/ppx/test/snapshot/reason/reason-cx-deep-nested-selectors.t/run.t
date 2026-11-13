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
  [@@@css ".css-18ytvmo{color:red;}.css-18ytvmo:hover{color:blue;}"]
  [@@@css
    ".css-1i1u80y{color:red;}.css-1i1u80y:focus-visible::after{content:\"\";}"]
  [@@@css ".css-1ieqvcf{color:red;}.css-1ieqvcf:hover:focus{color:green;}"]
  [@@@css ".css-2i4e5{color:red;}.css-2i4e5:hover .child:focus{color:green;}"]
  [@@@css ".css-1optnb0{color:red;}.css-1optnb0:hover .child{color:blue;}"]
  [@@@css.classes
    [("css-18ytvmo", 0, "Input.single", "input.ml", 10, 2, 14, 0);
    ("css-1i1u80y", 1, "Input.twoLevel", "input.ml", 20, 2, 26, 0);
    ("css-1ieqvcf", 2, "Input.twoLevelPseudoClass", "input.ml", 32, 2, 38, 0);
    ("css-2i4e5", 3, "Input.threeLevel", "input.ml", 44, 2, 52, 0);
    ("css-1optnb0", 4, "Input.descendantUnderPseudo", "input.ml", 58, 2, 64, 0)]]
  [@@@css.bindings
    [("Input.single", "css-18ytvmo");
    ("Input.twoLevel", "css-1i1u80y");
    ("Input.twoLevelPseudoClass", "css-1ieqvcf");
    ("Input.threeLevel", "css-2i4e5");
    ("Input.descendantUnderPseudo", "css-1optnb0")]]
  let single = CSS.make "css-18ytvmo" []
  let twoLevel = CSS.make "css-1i1u80y" []
  let twoLevelPseudoClass = CSS.make "css-1ieqvcf" []
  let threeLevel = CSS.make "css-2i4e5" []
  let descendantUnderPseudo = CSS.make "css-1optnb0" []
