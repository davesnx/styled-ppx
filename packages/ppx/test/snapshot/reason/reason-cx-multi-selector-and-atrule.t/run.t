Selector lists and nested at-rules in a block.

A selector list in a nested rule expands to one rule per selector at every
depth (CSS-nesting Cartesian semantics). A nested at-rule carries the parent
selector chain into its contents instead of dropping it.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".css-3ovpo5 .a{color:red;}.css-3ovpo5 .b{color:red;}"]
  [@@@css
    ".css-e3cfct .parent .a{color:blue;}.css-e3cfct .parent .b{color:blue;}"]
  [@@@css
    ".css-1x1gs0d .a .c{color:green;}.css-1x1gs0d .a .d{color:green;}.css-1x1gs0d .b .c{color:green;}.css-1x1gs0d .b .d{color:green;}"]
  [@@@css
    ".css-1cfk6lx .a{color:red;}.css-1cfk6lx .a:hover{color:blue;}.css-1cfk6lx .b{color:red;}.css-1cfk6lx .b:hover{color:blue;}"]
  [@@@css "@media (min-width: 768px) {.css-p14ia4 .a{color:red;}}"]
  [@@@css "@media (max-width: 600px) {.css-1kioole .a .b{color:red;}}"]
  [@@@css
    ".css-1t0xo06 .a{color:black;}@media (max-width: 600px) {.css-1t0xo06 .a{color:red;}.css-1t0xo06 .a:hover{color:blue;}}"]
  [@@@css.classes
    [("css-3ovpo5", 0, "Input.multiTop", "input.ml", 13, 2, 16, 0);
    ("css-e3cfct", 1, "Input.multiNested", "input.ml", 21, 2, 26, 0);
    ("css-1x1gs0d", 2, "Input.cartesian", "input.ml", 32, 2, 37, 0);
    ("css-1cfk6lx", 3, "Input.multiMixed", "input.ml", 44, 2, 50, 0);
    ("css-p14ia4", 4, "Input.mediaUnderSelector", "input.ml", 57, 2, 62, 0);
    ("css-1kioole", 5, "Input.mediaDeep", "input.ml", 68, 2, 75, 0);
    ("css-1t0xo06", 6, "Input.mediaWithNested", "input.ml", 82, 2, 91, 0)]]
  [@@@css.bindings
    [("Input.multiTop", "css-3ovpo5");
    ("Input.multiNested", "css-e3cfct");
    ("Input.cartesian", "css-1x1gs0d");
    ("Input.multiMixed", "css-1cfk6lx");
    ("Input.mediaUnderSelector", "css-p14ia4");
    ("Input.mediaDeep", "css-1kioole");
    ("Input.mediaWithNested", "css-1t0xo06")]]
  let multiTop = CSS.make "css-3ovpo5" []
  let multiNested = CSS.make "css-e3cfct" []
  let cartesian = CSS.make "css-1x1gs0d" []
  let multiMixed = CSS.make "css-1cfk6lx" []
  let mediaUnderSelector = CSS.make "css-p14ia4" []
  let mediaDeep = CSS.make "css-1kioole" []
  let mediaWithNested = CSS.make "css-1t0xo06" []
