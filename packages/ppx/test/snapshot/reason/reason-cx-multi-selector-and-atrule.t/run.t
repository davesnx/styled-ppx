Coverage for cx2 atomization edge cases.

Multi-selector preludes must split into one atom per selector at every depth
(CSS-nesting Cartesian semantics). Nested at-rules must carry the parent
selector chain into the at-rule's contents instead of dropping it.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "._a_2sekz4ey2q8 .a{color:red;}"]
  [@@@css "._a_bcuim4eyv6j .b{color:red;}"]
  [@@@css "._a_aofs04eam0t .parent .a{color:blue;}"]
  [@@@css "._a_gdpy14e0cim .parent .b{color:blue;}"]
  [@@@css "._a_eu1gr4evtx3 .a .c{color:green;}"]
  [@@@css "._a_rbso84eu78w .a .d{color:green;}"]
  [@@@css "._a_d7tqn4etzuk .b .c{color:green;}"]
  [@@@css "._a_mmzne4ejsnn .b .d{color:green;}"]
  [@@@css "._a_y066w4ej269 .a:hover{color:blue;}"]
  [@@@css "._a_mrd5q4er9ux .b:hover{color:blue;}"]
  [@@@css "@media (min-width: 768px) {._a_a1ok24ei921 .a{color:red;}}"]
  [@@@css "@media (max-width: 600px) {._a_o95t84edogz .a .b{color:red;}}"]
  [@@@css "._a_2sekz4ehjb1 .a{color:black;}"]
  [@@@css "@media (max-width: 600px) {._a_dft6c4ebng1 .a{color:red;}}"]
  [@@@css "@media (max-width: 600px) {._a_yea404etxwe .a:hover{color:blue;}}"]
  [@@@css.bindings
    [("Input.multiTop", "_id_za05oi", "_a_2sekz4ey2q8 _a_bcuim4eyv6j");
    ("Input.multiNested", "_id_gymm1w", "_a_aofs04eam0t _a_gdpy14e0cim");
    ("Input.cartesian", "_id_18oo9dc",
      "_a_eu1gr4evtx3 _a_rbso84eu78w _a_d7tqn4etzuk _a_mmzne4ejsnn");
    ("Input.multiMixed", "_id_kzpsx9",
      "_a_2sekz4ey2q8 _a_bcuim4eyv6j _a_y066w4ej269 _a_mrd5q4er9ux");
    ("Input.mediaUnderSelector", "_id_jnaeeh", "_a_a1ok24ei921");
    ("Input.mediaDeep", "_id_1xp2ctx", "_a_o95t84edogz");
    ("Input.mediaWithNested", "_id_sseoij",
      "_a_2sekz4ehjb1 _a_dft6c4ebng1 _a_yea404etxwe")]]
  let multiTop =
    CSS.make "label:multiTop _id_za05oi _a_2sekz4ey2q8 _a_bcuim4eyv6j" []
  let multiNested =
    CSS.make "label:multiNested _id_gymm1w _a_aofs04eam0t _a_gdpy14e0cim" []
  let cartesian =
    CSS.make
      "label:cartesian _id_18oo9dc _a_eu1gr4evtx3 _a_rbso84eu78w _a_d7tqn4etzuk _a_mmzne4ejsnn"
      []
  let multiMixed =
    CSS.make
      "label:multiMixed _id_kzpsx9 _a_2sekz4ey2q8 _a_bcuim4eyv6j _a_y066w4ej269 _a_mrd5q4er9ux"
      []
  let mediaUnderSelector =
    CSS.make "label:mediaUnderSelector _id_jnaeeh _a_a1ok24ei921" []
  let mediaDeep = CSS.make "label:mediaDeep _id_1xp2ctx _a_o95t84edogz" []
  let mediaWithNested =
    CSS.make
      "label:mediaWithNested _id_sseoij _a_2sekz4ehjb1 _a_dft6c4ebng1 _a_yea404etxwe"
      []
