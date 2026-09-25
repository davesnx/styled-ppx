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
  [@@@css ".a-tokvmb{color:red;}"]
  [@@@css ".a-12qnfjo:hover{color:blue;}"]
  [@@@css ".a-11jzudz:focus-visible::after{content:\"\";}"]
  [@@@css ".a-1srf6vm:hover:focus{color:green;}"]
  [@@@css ".a-1tfmvqw:hover .child:focus{color:green;}"]
  [@@@css ".a-nqbkm2:hover .child{color:blue;}"]
  [@@@css.bindings
    [("Input.single", "id-1e50cws", "a-tokvmb a-12qnfjo");
    ("Input.twoLevel", "id-8l8452", "a-tokvmb a-11jzudz");
    ("Input.twoLevelPseudoClass", "id-1p6ev21", "a-tokvmb a-1srf6vm");
    ("Input.threeLevel", "id-16hizhg", "a-tokvmb a-1tfmvqw");
    ("Input.descendantUnderPseudo", "id-d9y20h", "a-tokvmb a-nqbkm2")]]
  let single = CSS.make "label:single id-1e50cws a-tokvmb a-12qnfjo" []
  let twoLevel = CSS.make "label:twoLevel id-8l8452 a-tokvmb a-11jzudz" []
  let twoLevelPseudoClass =
    CSS.make "label:twoLevelPseudoClass id-1p6ev21 a-tokvmb a-1srf6vm" []
  let threeLevel = CSS.make "label:threeLevel id-16hizhg a-tokvmb a-1tfmvqw" []
  let descendantUnderPseudo =
    CSS.make "label:descendantUnderPseudo id-d9y20h a-tokvmb a-nqbkm2" []
