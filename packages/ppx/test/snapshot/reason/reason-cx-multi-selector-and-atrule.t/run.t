Coverage for cx2 atomization edge cases.

Multi-selector preludes must split into one atom per selector at every depth
(CSS-nesting Cartesian semantics). Nested at-rules must carry the parent
selector chain into the at-rule's contents instead of dropping it.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".css-rmy2q8 .a{color:red;}"]
  [@@@css ".css-alyv6j .b{color:red;}"]
  [@@@css ".css-xuam0t .parent .a{color:blue;}"]
  [@@@css ".css-1400cim .parent .b{color:blue;}"]
  [@@@css ".css-1v5vtx3 .a .c{color:green;}"]
  [@@@css ".css-1hhu78w .a .d{color:green;}"]
  [@@@css ".css-1ehtzuk .b .c{color:green;}"]
  [@@@css ".css-1nvjsnn .b .d{color:green;}"]
  [@@@css ".css-bij269 .a:hover{color:blue;}"]
  [@@@css ".css-1k1r9ux .b:hover{color:blue;}"]
  [@@@css "@media (min-width: 768px) {.css-14bi921 .a{color:red;}}"]
  [@@@css "@media (max-width: 600px) {.css-godogz .a .b{color:red;}}"]
  [@@@css ".css-1c0hjb1 .a{color:black;}"]
  [@@@css "@media (max-width: 600px) {.css-1x7bng1 .a{color:red;}}"]
  [@@@css "@media (max-width: 600px) {.css-pjtxwe .a:hover{color:blue;}}"]
  [@@@css.bindings
    [("Input.multiTop", "cid-za05oi", "css-rmy2q8 css-alyv6j");
    ("Input.multiNested", "cid-gymm1w", "css-xuam0t css-1400cim");
    ("Input.cartesian", "cid-18oo9dc",
      "css-1v5vtx3 css-1hhu78w css-1ehtzuk css-1nvjsnn");
    ("Input.multiMixed", "cid-kzpsx9",
      "css-rmy2q8 css-alyv6j css-bij269 css-1k1r9ux");
    ("Input.mediaUnderSelector", "cid-jnaeeh", "css-14bi921");
    ("Input.mediaDeep", "cid-1xp2ctx", "css-godogz");
    ("Input.mediaWithNested", "cid-sseoij",
      "css-1c0hjb1 css-1x7bng1 css-pjtxwe")]]
  let multiTop = CSS.make "label:multiTop cid-za05oi css-rmy2q8 css-alyv6j" []
  let multiNested =
    CSS.make "label:multiNested cid-gymm1w css-xuam0t css-1400cim" []
  let cartesian =
    CSS.make
      "label:cartesian cid-18oo9dc css-1v5vtx3 css-1hhu78w css-1ehtzuk css-1nvjsnn"
      []
  let multiMixed =
    CSS.make
      "label:multiMixed cid-kzpsx9 css-rmy2q8 css-alyv6j css-bij269 css-1k1r9ux"
      []
  let mediaUnderSelector =
    CSS.make "label:mediaUnderSelector cid-jnaeeh css-14bi921" []
  let mediaDeep = CSS.make "label:mediaDeep cid-1xp2ctx css-godogz" []
  let mediaWithNested =
    CSS.make
      "label:mediaWithNested cid-sseoij css-1c0hjb1 css-1x7bng1 css-pjtxwe" []
