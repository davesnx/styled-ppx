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
  [@@@css "._a_4ekvmb{color:red;}"]
  [@@@css "._a_qyw7u4enfjo:hover{color:blue;}"]
  [@@@css "._a_7t7p64wzudz:focus-visible::after{content:\"\";}"]
  [@@@css "._a_rv9hg4ef6vm:hover:focus{color:green;}"]
  [@@@css "._a_xltrd4emvqw:hover .child:focus{color:green;}"]
  [@@@css "._a_d3qow4ebkm2:hover .child{color:blue;}"]
  [@@@css.bindings
    [("Input.single", "_id_1yrphqe", "_a_4ekvmb _a_qyw7u4enfjo");
    ("Input.twoLevel", "_id_q8a7f9", "_a_4ekvmb _a_7t7p64wzudz");
    ("Input.twoLevelPseudoClass", "_id_11uiqsi", "_a_4ekvmb _a_rv9hg4ef6vm");
    ("Input.threeLevel", "_id_1c0m8s9", "_a_4ekvmb _a_xltrd4emvqw");
    ("Input.descendantUnderPseudo", "_id_1ejj839", "_a_4ekvmb _a_d3qow4ebkm2")]]
  [@@@css.blocks
    [(9, "_id_1yrphqe _a_4ekvmb _a_qyw7u4enfjo");
    (19, "_id_q8a7f9 _a_4ekvmb _a_7t7p64wzudz");
    (31, "_id_11uiqsi _a_4ekvmb _a_rv9hg4ef6vm");
    (43, "_id_1c0m8s9 _a_4ekvmb _a_xltrd4emvqw");
    (57, "_id_1ejj839 _a_4ekvmb _a_d3qow4ebkm2")]]
  let single = CSS.make "label:single _id_1yrphqe _a_4ekvmb _a_qyw7u4enfjo" []
  let twoLevel =
    CSS.make "label:twoLevel _id_q8a7f9 _a_4ekvmb _a_7t7p64wzudz" []
  let twoLevelPseudoClass =
    CSS.make "label:twoLevelPseudoClass _id_11uiqsi _a_4ekvmb _a_rv9hg4ef6vm"
      []
  let threeLevel =
    CSS.make "label:threeLevel _id_1c0m8s9 _a_4ekvmb _a_xltrd4emvqw" []
  let descendantUnderPseudo =
    CSS.make "label:descendantUnderPseudo _id_1ejj839 _a_4ekvmb _a_d3qow4ebkm2"
      []
