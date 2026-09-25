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
  [@@@css ".a-4ekvmb{color:red;}"]
  [@@@css ".a-qyw7u4enfjo:hover{color:blue;}"]
  [@@@css ".a-7t7p64wzudz:focus-visible::after{content:\"\";}"]
  [@@@css ".a-rv9hg4ef6vm:hover:focus{color:green;}"]
  [@@@css ".a-xltrd4emvqw:hover .child:focus{color:green;}"]
  [@@@css ".a-d3qow4ebkm2:hover .child{color:blue;}"]
  [@@@css.bindings
    [("Input.single", "id-1e50cws", "a-4ekvmb a-qyw7u4enfjo");
    ("Input.twoLevel", "id-8l8452", "a-4ekvmb a-7t7p64wzudz");
    ("Input.twoLevelPseudoClass", "id-1p6ev21", "a-4ekvmb a-rv9hg4ef6vm");
    ("Input.threeLevel", "id-16hizhg", "a-4ekvmb a-xltrd4emvqw");
    ("Input.descendantUnderPseudo", "id-d9y20h", "a-4ekvmb a-d3qow4ebkm2")]]
  let single = CSS.make "label:single id-1e50cws a-4ekvmb a-qyw7u4enfjo" []
  let twoLevel = CSS.make "label:twoLevel id-8l8452 a-4ekvmb a-7t7p64wzudz" []
  let twoLevelPseudoClass =
    CSS.make "label:twoLevelPseudoClass id-1p6ev21 a-4ekvmb a-rv9hg4ef6vm" []
  let threeLevel =
    CSS.make "label:threeLevel id-16hizhg a-4ekvmb a-xltrd4emvqw" []
  let descendantUnderPseudo =
    CSS.make "label:descendantUnderPseudo id-d9y20h a-4ekvmb a-d3qow4ebkm2" []
