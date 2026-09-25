Coverage for cx2 atomization edge cases.

Multi-selector preludes must split into one atom per selector at every depth
(CSS-nesting Cartesian semantics). Nested at-rules must carry the parent
selector chain into the at-rule's contents instead of dropping it.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".a-rmy2q8 .a{color:red;}"]
  [@@@css ".a-alyv6j .b{color:red;}"]
  [@@@css ".a-xuam0t .parent .a{color:blue;}"]
  [@@@css ".a-1400cim .parent .b{color:blue;}"]
  [@@@css ".a-1v5vtx3 .a .c{color:green;}"]
  [@@@css ".a-1hhu78w .a .d{color:green;}"]
  [@@@css ".a-1ehtzuk .b .c{color:green;}"]
  [@@@css ".a-1nvjsnn .b .d{color:green;}"]
  [@@@css ".a-bij269 .a:hover{color:blue;}"]
  [@@@css ".a-1k1r9ux .b:hover{color:blue;}"]
  [@@@css "@media (min-width: 768px) {.a-14bi921 .a{color:red;}}"]
  [@@@css "@media (max-width: 600px) {.a-godogz .a .b{color:red;}}"]
  [@@@css ".a-1c0hjb1 .a{color:black;}"]
  [@@@css "@media (max-width: 600px) {.a-1x7bng1 .a{color:red;}}"]
  [@@@css "@media (max-width: 600px) {.a-pjtxwe .a:hover{color:blue;}}"]
  [@@@css.bindings
    [("Input.multiTop", "id-za05oi", "a-rmy2q8 a-alyv6j");
    ("Input.multiNested", "id-gymm1w", "a-xuam0t a-1400cim");
    ("Input.cartesian", "id-18oo9dc",
      "a-1v5vtx3 a-1hhu78w a-1ehtzuk a-1nvjsnn");
    ("Input.multiMixed", "id-kzpsx9", "a-rmy2q8 a-alyv6j a-bij269 a-1k1r9ux");
    ("Input.mediaUnderSelector", "id-jnaeeh", "a-14bi921");
    ("Input.mediaDeep", "id-1xp2ctx", "a-godogz");
    ("Input.mediaWithNested", "id-sseoij", "a-1c0hjb1 a-1x7bng1 a-pjtxwe")]]
  let multiTop = CSS.make "label:multiTop id-za05oi a-rmy2q8 a-alyv6j" []
  let multiNested =
    CSS.make "label:multiNested id-gymm1w a-xuam0t a-1400cim" []
  let cartesian =
    CSS.make
      "label:cartesian id-18oo9dc a-1v5vtx3 a-1hhu78w a-1ehtzuk a-1nvjsnn" []
  let multiMixed =
    CSS.make "label:multiMixed id-kzpsx9 a-rmy2q8 a-alyv6j a-bij269 a-1k1r9ux"
      []
  let mediaUnderSelector =
    CSS.make "label:mediaUnderSelector id-jnaeeh a-14bi921" []
  let mediaDeep = CSS.make "label:mediaDeep id-1xp2ctx a-godogz" []
  let mediaWithNested =
    CSS.make "label:mediaWithNested id-sseoij a-1c0hjb1 a-1x7bng1 a-pjtxwe" []
