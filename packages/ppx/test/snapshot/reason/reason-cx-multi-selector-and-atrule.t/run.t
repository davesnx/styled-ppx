Coverage for cx2 atomization edge cases.

Multi-selector preludes must split into one atom per selector at every depth
(CSS-nesting Cartesian semantics). Nested at-rules must carry the parent
selector chain into the at-rule's contents instead of dropping it.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".css-1e0iv26-multiTop .a{color:red}"]
  [@@@css ".css-12em34c-multiTop .b{color:red}"]
  [@@@css ".css-1iooyqz-multiNested .parent .a{color:blue}"]
  [@@@css ".css-1mmahcs-multiNested .parent .b{color:blue}"]
  [@@@css ".css-oi3pci-cartesian .a .c{color:green}"]
  [@@@css ".css-mvikdc-cartesian .a .d{color:green}"]
  [@@@css ".css-1aw0q1v-cartesian .b .c{color:green}"]
  [@@@css ".css-1rhgphp-cartesian .b .d{color:green}"]
  [@@@css ".css-1e0iv26-multiMixed .a{color:red}"]
  [@@@css ".css-12em34c-multiMixed .b{color:red}"]
  [@@@css ".css-m1r2t5-multiMixed .a:hover{color:blue}"]
  [@@@css ".css-kqrdgs-multiMixed .b:hover{color:blue}"]
  [@@@css
    "@media (min-width:768px){.css-1l52930-mediaUnderSelector .a{color:red}}"]
  [@@@css "@media (max-width:600px){.css-u5a85h-mediaDeep .a .b{color:red}}"]
  [@@@css ".css-18gyhum-mediaWithNested .a{color:black}"]
  [@@@css
    "@media (max-width:600px){.css-1oiugam-mediaWithNested .a{color:red}}"]
  [@@@css
    "@media (max-width:600px){.css-11eg3nr-mediaWithNested .a:hover{color:blue}}"]
  [@@@css.bindings
    [("Input.multiTop", "css-1e0iv26-multiTop css-12em34c-multiTop");
    ("Input.multiNested", "css-1iooyqz-multiNested css-1mmahcs-multiNested");
    ("Input.cartesian",
      "css-oi3pci-cartesian css-mvikdc-cartesian css-1aw0q1v-cartesian css-1rhgphp-cartesian");
    ("Input.multiMixed",
      "css-1e0iv26-multiMixed css-12em34c-multiMixed css-m1r2t5-multiMixed css-kqrdgs-multiMixed");
    ("Input.mediaUnderSelector", "css-1l52930-mediaUnderSelector");
    ("Input.mediaDeep", "css-u5a85h-mediaDeep");
    ("Input.mediaWithNested",
      "css-18gyhum-mediaWithNested css-1oiugam-mediaWithNested css-11eg3nr-mediaWithNested")]]
  let multiTop = CSS.make "css-1e0iv26-multiTop css-12em34c-multiTop" []
  let multiNested =
    CSS.make "css-1iooyqz-multiNested css-1mmahcs-multiNested" []
  let cartesian =
    CSS.make
      "css-oi3pci-cartesian css-mvikdc-cartesian css-1aw0q1v-cartesian css-1rhgphp-cartesian"
      []
  let multiMixed =
    CSS.make
      "css-1e0iv26-multiMixed css-12em34c-multiMixed css-m1r2t5-multiMixed css-kqrdgs-multiMixed"
      []
  let mediaUnderSelector = CSS.make "css-1l52930-mediaUnderSelector" []
  let mediaDeep = CSS.make "css-u5a85h-mediaDeep" []
  let mediaWithNested =
    CSS.make
      "css-18gyhum-mediaWithNested css-1oiugam-mediaWithNested css-11eg3nr-mediaWithNested"
      []
