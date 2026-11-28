Selector lists and nested at-rules in a block.

A selector list in a nested rule expands to one rule per selector at every
depth (CSS-nesting Cartesian semantics). A nested at-rule carries the parent
selector chain into its contents instead of dropping it.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".css-ivpcpo5 .a{color:red;}.css-ivpcpo5 .b{color:red;}"]
  [@@@css
    ".css-ivpcfct .parent .a{color:blue;}.css-ivpcfct .parent .b{color:blue;}"]
  [@@@css
    ".css-ivpcs0d .a .c{color:green;}.css-ivpcs0d .a .d{color:green;}.css-ivpcs0d .b .c{color:green;}.css-ivpcs0d .b .d{color:green;}"]
  [@@@css
    ".css-ivpc6lx .a{color:red;}.css-ivpc6lx .a:hover{color:blue;}.css-ivpc6lx .b{color:red;}.css-ivpc6lx .b:hover{color:blue;}"]
  [@@@css "@media (min-width: 768px) {.css-ivpcia4 .a{color:red;}}"]
  [@@@css "@media (max-width: 600px) {.css-ivpcole .a .b{color:red;}}"]
  [@@@css
    ".css-ivpco06 .a{color:black;}@media (max-width: 600px) {.css-ivpco06 .a{color:red;}.css-ivpco06 .a:hover{color:blue;}}"]
  [@@@css.classes
    [("css-ivpcpo5", 0, "Input.multiTop", "input.ml", 13, 2, 16, 0);
    ("css-ivpcfct", 1, "Input.multiNested", "input.ml", 21, 2, 26, 0);
    ("css-ivpcs0d", 2, "Input.cartesian", "input.ml", 32, 2, 37, 0);
    ("css-ivpc6lx", 3, "Input.multiMixed", "input.ml", 44, 2, 50, 0);
    ("css-ivpcia4", 4, "Input.mediaUnderSelector", "input.ml", 57, 2, 62, 0);
    ("css-ivpcole", 5, "Input.mediaDeep", "input.ml", 68, 2, 75, 0);
    ("css-ivpco06", 6, "Input.mediaWithNested", "input.ml", 82, 2, 91, 0)]]
  [@@@css.bindings
    [("Input.multiTop", "css-ivpcpo5");
    ("Input.multiNested", "css-ivpcfct");
    ("Input.cartesian", "css-ivpcs0d");
    ("Input.multiMixed", "css-ivpc6lx");
    ("Input.mediaUnderSelector", "css-ivpcia4");
    ("Input.mediaDeep", "css-ivpcole");
    ("Input.mediaWithNested", "css-ivpco06")]]
  let multiTop = CSS.make "css-ivpcpo5" []
  let multiNested = CSS.make "css-ivpcfct" []
  let cartesian = CSS.make "css-ivpcs0d" []
  let multiMixed = CSS.make "css-ivpc6lx" []
  let mediaUnderSelector = CSS.make "css-ivpcia4" []
  let mediaDeep = CSS.make "css-ivpcole" []
  let mediaWithNested = CSS.make "css-ivpco06" []
