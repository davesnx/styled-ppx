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
  [@@@css ".css-tokvmb{color:red;}"]
  [@@@css ".css-12qnfjo:hover{color:blue;}"]
  [@@@css ".css-11jzudz:focus-visible::after{content:\"\";}"]
  [@@@css ".css-1srf6vm:hover:focus{color:green;}"]
  [@@@css ".css-1tfmvqw:hover .child:focus{color:green;}"]
  [@@@css ".css-nqbkm2:hover .child{color:blue;}"]
  [@@@css.bindings
    [("Input.single", "cid-1e50cws", "css-tokvmb css-12qnfjo");
    ("Input.twoLevel", "cid-8l8452", "css-tokvmb css-11jzudz");
    ("Input.twoLevelPseudoClass", "cid-1p6ev21", "css-tokvmb css-1srf6vm");
    ("Input.threeLevel", "cid-16hizhg", "css-tokvmb css-1tfmvqw");
    ("Input.descendantUnderPseudo", "cid-d9y20h", "css-tokvmb css-nqbkm2")]]
  let single = CSS.make ~label:"single" "cid-1e50cws css-tokvmb css-12qnfjo" []
  let twoLevel =
    CSS.make ~label:"twoLevel" "cid-8l8452 css-tokvmb css-11jzudz" []
  let twoLevelPseudoClass =
    CSS.make ~label:"twoLevelPseudoClass" "cid-1p6ev21 css-tokvmb css-1srf6vm"
      []
  let threeLevel =
    CSS.make ~label:"threeLevel" "cid-16hizhg css-tokvmb css-1tfmvqw" []
  let descendantUnderPseudo =
    CSS.make ~label:"descendantUnderPseudo" "cid-d9y20h css-tokvmb css-nqbkm2"
      []
