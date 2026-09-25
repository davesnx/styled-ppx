Coverage for cx2 atomization edge cases.

Multi-selector preludes must split into one atom per selector at every depth
(CSS-nesting Cartesian semantics). Nested at-rules must carry the parent
selector chain into the at-rule's contents instead of dropping it.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".a-2sekz4ey2q8 .a{color:red;}"]
  [@@@css ".a-bcuim4eyv6j .b{color:red;}"]
  [@@@css ".a-aofs04eam0t .parent .a{color:blue;}"]
  [@@@css ".a-gdpy14e0cim .parent .b{color:blue;}"]
  [@@@css ".a-eu1gr4evtx3 .a .c{color:green;}"]
  [@@@css ".a-rbso84eu78w .a .d{color:green;}"]
  [@@@css ".a-d7tqn4etzuk .b .c{color:green;}"]
  [@@@css ".a-mmzne4ejsnn .b .d{color:green;}"]
  [@@@css ".a-y066w4ej269 .a:hover{color:blue;}"]
  [@@@css ".a-mrd5q4er9ux .b:hover{color:blue;}"]
  [@@@css "@media (min-width: 768px) {.a-a1ok24ei921 .a{color:red;}}"]
  [@@@css "@media (max-width: 600px) {.a-o95t84edogz .a .b{color:red;}}"]
  [@@@css ".a-2sekz4ehjb1 .a{color:black;}"]
  [@@@css "@media (max-width: 600px) {.a-dft6c4ebng1 .a{color:red;}}"]
  [@@@css "@media (max-width: 600px) {.a-yea404etxwe .a:hover{color:blue;}}"]
  [@@@css.bindings
    [("Input.multiTop", "id-za05oi", "a-2sekz4ey2q8 a-bcuim4eyv6j");
    ("Input.multiNested", "id-gymm1w", "a-aofs04eam0t a-gdpy14e0cim");
    ("Input.cartesian", "id-18oo9dc",
      "a-eu1gr4evtx3 a-rbso84eu78w a-d7tqn4etzuk a-mmzne4ejsnn");
    ("Input.multiMixed", "id-kzpsx9",
      "a-2sekz4ey2q8 a-bcuim4eyv6j a-y066w4ej269 a-mrd5q4er9ux");
    ("Input.mediaUnderSelector", "id-jnaeeh", "a-a1ok24ei921");
    ("Input.mediaDeep", "id-1xp2ctx", "a-o95t84edogz");
    ("Input.mediaWithNested", "id-sseoij",
      "a-2sekz4ehjb1 a-dft6c4ebng1 a-yea404etxwe")]]
  let multiTop =
    CSS.make "label:multiTop id-za05oi a-2sekz4ey2q8 a-bcuim4eyv6j" []
  let multiNested =
    CSS.make "label:multiNested id-gymm1w a-aofs04eam0t a-gdpy14e0cim" []
  let cartesian =
    CSS.make
      "label:cartesian id-18oo9dc a-eu1gr4evtx3 a-rbso84eu78w a-d7tqn4etzuk a-mmzne4ejsnn"
      []
  let multiMixed =
    CSS.make
      "label:multiMixed id-kzpsx9 a-2sekz4ey2q8 a-bcuim4eyv6j a-y066w4ej269 a-mrd5q4er9ux"
      []
  let mediaUnderSelector =
    CSS.make "label:mediaUnderSelector id-jnaeeh a-a1ok24ei921" []
  let mediaDeep = CSS.make "label:mediaDeep id-1xp2ctx a-o95t84edogz" []
  let mediaWithNested =
    CSS.make
      "label:mediaWithNested id-sseoij a-2sekz4ehjb1 a-dft6c4ebng1 a-yea404etxwe"
      []
