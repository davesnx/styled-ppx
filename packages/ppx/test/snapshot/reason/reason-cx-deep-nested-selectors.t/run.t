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
  [@@@css ".css-tokvmb-single{color:red}"]
  [@@@css ".css-k2yaf8-single:hover{color:blue}"]
  [@@@css ".css-tokvmb-twoLevel{color:red}"]
  [@@@css ".css-1ueespv-twoLevel:focus-visible::after{content:\"\"}"]
  [@@@css ".css-tokvmb-twoLevelPseudoClass{color:red}"]
  [@@@css ".css-13xk8fv-twoLevelPseudoClass:hover:focus{color:green}"]
  [@@@css ".css-tokvmb-threeLevel{color:red}"]
  [@@@css ".css-jdr47x-threeLevel:hover .child:focus{color:green}"]
  [@@@css ".css-tokvmb-descendantUnderPseudo{color:red}"]
  [@@@css ".css-f3fdep-descendantUnderPseudo:hover .child{color:blue}"]
  [@@@css.bindings
    [("Input.single", "css-tokvmb-single css-k2yaf8-single");
    ("Input.twoLevel", "css-tokvmb-twoLevel css-1ueespv-twoLevel");
    ("Input.twoLevelPseudoClass",
      "css-tokvmb-twoLevelPseudoClass css-13xk8fv-twoLevelPseudoClass");
    ("Input.threeLevel", "css-tokvmb-threeLevel css-jdr47x-threeLevel");
    ("Input.descendantUnderPseudo",
      "css-tokvmb-descendantUnderPseudo css-f3fdep-descendantUnderPseudo")]]
  let single = CSS.make "css-tokvmb-single css-k2yaf8-single" []
  let twoLevel = CSS.make "css-tokvmb-twoLevel css-1ueespv-twoLevel" []
  let twoLevelPseudoClass =
    CSS.make "css-tokvmb-twoLevelPseudoClass css-13xk8fv-twoLevelPseudoClass"
      []
  let threeLevel = CSS.make "css-tokvmb-threeLevel css-jdr47x-threeLevel" []
  let descendantUnderPseudo =
    CSS.make
      "css-tokvmb-descendantUnderPseudo css-f3fdep-descendantUnderPseudo" []
