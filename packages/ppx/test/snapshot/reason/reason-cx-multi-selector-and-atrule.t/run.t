Coverage for cx2 atomization edge cases.

Multi-selector preludes must split into one atom per selector at every depth
(CSS-nesting Cartesian semantics). Nested at-rules must carry the parent
selector chain into the at-rule's contents instead of dropping it.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".css-rmy2q8-multiTop .a{color:red;}"]
  [@@@css ".css-alyv6j-multiTop .b{color:red;}"]
  [@@@css ".css-xuam0t-multiNested .parent .a{color:blue;}"]
  [@@@css ".css-1400cim-multiNested .parent .b{color:blue;}"]
  [@@@css ".css-1v5vtx3-cartesian .a .c{color:green;}"]
  [@@@css ".css-1hhu78w-cartesian .a .d{color:green;}"]
  [@@@css ".css-1ehtzuk-cartesian .b .c{color:green;}"]
  [@@@css ".css-1nvjsnn-cartesian .b .d{color:green;}"]
  [@@@css ".css-rmy2q8-multiMixed .a{color:red;}"]
  [@@@css ".css-alyv6j-multiMixed .b{color:red;}"]
  [@@@css ".css-bij269-multiMixed .a:hover{color:blue;}"]
  [@@@css ".css-1k1r9ux-multiMixed .b:hover{color:blue;}"]
  [@@@css
    "@media (min-width: 768px) {.css-14bi921-mediaUnderSelector .a{color:red;}}"]
  [@@@css
    "@media (max-width: 600px) {.css-godogz-mediaDeep .a .b{color:red;}}"]
  [@@@css ".css-1c0hjb1-mediaWithNested .a{color:black;}"]
  [@@@css
    "@media (max-width: 600px) {.css-1x7bng1-mediaWithNested .a{color:red;}}"]
  [@@@css
    "@media (max-width: 600px) {.css-pjtxwe-mediaWithNested .a:hover{color:blue;}}"]
  [@@@css.bindings
    [("Input.multiTop", "css-rmy2q8-multiTop css-alyv6j-multiTop");
    ("Input.multiNested", "css-xuam0t-multiNested css-1400cim-multiNested");
    ("Input.cartesian",
      "css-1v5vtx3-cartesian css-1hhu78w-cartesian css-1ehtzuk-cartesian css-1nvjsnn-cartesian");
    ("Input.multiMixed",
      "css-rmy2q8-multiMixed css-alyv6j-multiMixed css-bij269-multiMixed css-1k1r9ux-multiMixed");
    ("Input.mediaUnderSelector", "css-14bi921-mediaUnderSelector");
    ("Input.mediaDeep", "css-godogz-mediaDeep");
    ("Input.mediaWithNested",
      "css-1c0hjb1-mediaWithNested css-1x7bng1-mediaWithNested css-pjtxwe-mediaWithNested")]]
  let multiTop =
    CSS.make_labeled "multiTop" "css-rmy2q8-multiTop css-alyv6j-multiTop" []
  let multiNested =
    CSS.make_labeled "multiNested"
      "css-xuam0t-multiNested css-1400cim-multiNested" []
  let cartesian =
    CSS.make_labeled "cartesian"
      "css-1v5vtx3-cartesian css-1hhu78w-cartesian css-1ehtzuk-cartesian css-1nvjsnn-cartesian"
      []
  let multiMixed =
    CSS.make_labeled "multiMixed"
      "css-rmy2q8-multiMixed css-alyv6j-multiMixed css-bij269-multiMixed css-1k1r9ux-multiMixed"
      []
  let mediaUnderSelector =
    CSS.make_labeled "mediaUnderSelector" "css-14bi921-mediaUnderSelector" []
  let mediaDeep = CSS.make_labeled "mediaDeep" "css-godogz-mediaDeep" []
  let mediaWithNested =
    CSS.make_labeled "mediaWithNested"
      "css-1c0hjb1-mediaWithNested css-1x7bng1-mediaWithNested css-pjtxwe-mediaWithNested"
      []
