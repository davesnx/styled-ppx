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
  [@@@css ".css-tokvmb-single{color:red;}"]
  [@@@css ".css-12qnfjo-single:hover{color:blue;}"]
  [@@@css ".css-tokvmb-twoLevel{color:red;}"]
  [@@@css ".css-11jzudz-twoLevel:focus-visible::after{content:\"\";}"]
  [@@@css ".css-tokvmb-twoLevelPseudoClass{color:red;}"]
  [@@@css ".css-1srf6vm-twoLevelPseudoClass:hover:focus{color:green;}"]
  [@@@css ".css-tokvmb-threeLevel{color:red;}"]
  [@@@css ".css-1tfmvqw-threeLevel:hover .child:focus{color:green;}"]
  [@@@css ".css-tokvmb-descendantUnderPseudo{color:red;}"]
  [@@@css ".css-nqbkm2-descendantUnderPseudo:hover .child{color:blue;}"]
  [@@@css.bindings
    [("Input.single", "cid-1e50cws", "css-tokvmb-single css-12qnfjo-single");
    ("Input.twoLevel", "cid-8l8452",
      "css-tokvmb-twoLevel css-11jzudz-twoLevel");
    ("Input.twoLevelPseudoClass", "cid-1p6ev21",
      "css-tokvmb-twoLevelPseudoClass css-1srf6vm-twoLevelPseudoClass");
    ("Input.threeLevel", "cid-16hizhg",
      "css-tokvmb-threeLevel css-1tfmvqw-threeLevel");
    ("Input.descendantUnderPseudo", "cid-d9y20h",
      "css-tokvmb-descendantUnderPseudo css-nqbkm2-descendantUnderPseudo")]]
  let single = CSS.make "cid-1e50cws css-tokvmb-single css-12qnfjo-single" []
  let twoLevel =
    CSS.make "cid-8l8452 css-tokvmb-twoLevel css-11jzudz-twoLevel" []
  let twoLevelPseudoClass =
    CSS.make
      "cid-1p6ev21 css-tokvmb-twoLevelPseudoClass css-1srf6vm-twoLevelPseudoClass"
      []
  let threeLevel =
    CSS.make "cid-16hizhg css-tokvmb-threeLevel css-1tfmvqw-threeLevel" []
  let descendantUnderPseudo =
    CSS.make
      "cid-d9y20h css-tokvmb-descendantUnderPseudo css-nqbkm2-descendantUnderPseudo"
      []
