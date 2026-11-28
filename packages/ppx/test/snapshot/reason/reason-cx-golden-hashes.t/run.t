Golden hashes: a stable pin on the classNames produced for representative
[%css] shapes. A class is a Murmur2 hash of the module name, the scope, the
binding name and the block's rendered rules, so any change to `Render`
(whitespace, escaping, numeric formatting), to these inputs, or to Murmur2
cascades into every emitted className.

Without this pin, a no-op-intended refactor silently busts every cached
className downstream — browser caches, CDN caches, persisted DOM
identifiers all break. Update this test only when the change is intended;
the diff IS the blast radius.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".css-ivpcdqx{color:red;}"]
  [@@@css ".css-ivpcxmb{margin:10px;padding:20px;color:blue;}"]
  [@@@css ".css-ivpc6hg{color:black;}.css-ivpc6hg:hover{color:white;}"]
  [@@@css ".css-ivpcn43 .a{color:green;}.css-ivpcn43 .b{color:green;}"]
  [@@@css "@media (min-width: 768px) {.css-ivpcv8h .a{color:red;}}"]
  [@@@css ".css-ivpcjgr{width:1.5rem;opacity:0.5;}"]
  [@@@css ".css-ivpcuym{color:var(--theme, blue);}"]
  [@@@css.classes
    [("css-ivpcdqx", 0, "Input.solid", "input.ml", 12, 21, 12, 33);
    ("css-ivpcxmb", 1, "Input.multi", "input.ml", 16, 2, 19, 0);
    ("css-ivpc6hg", 2, "Input.hovered", "input.ml", 23, 2, 27, 0);
    ("css-ivpcn43", 3, "Input.multiSel", "input.ml", 31, 2, 34, 0);
    ("css-ivpcv8h", 4, "Input.withMedia", "input.ml", 40, 2, 45, 0);
    ("css-ivpcjgr", 5, "Input.units", "input.ml", 49, 2, 51, 0);
    ("css-ivpcuym", 6, "Input.withFallback", "input.ml", 55, 2, 56, 0)]]
  [@@@css.bindings
    [("Input.solid", "css-ivpcdqx");
    ("Input.multi", "css-ivpcxmb");
    ("Input.hovered", "css-ivpc6hg");
    ("Input.multiSel", "css-ivpcn43");
    ("Input.withMedia", "css-ivpcv8h");
    ("Input.units", "css-ivpcjgr");
    ("Input.withFallback", "css-ivpcuym")]]
  let solid = CSS.make "css-ivpcdqx" []
  let multi = CSS.make "css-ivpcxmb" []
  let hovered = CSS.make "css-ivpc6hg" []
  let multiSel = CSS.make "css-ivpcn43" []
  let withMedia = CSS.make "css-ivpcv8h" []
  let units = CSS.make "css-ivpcjgr" []
  let withFallback = CSS.make "css-ivpcuym" []
