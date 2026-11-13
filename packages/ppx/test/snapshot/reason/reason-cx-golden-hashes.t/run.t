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
  [@@@css ".css-o2ldqx{color:red;}"]
  [@@@css ".css-1fqqxmb{margin:10px;padding:20px;color:blue;}"]
  [@@@css ".css-g5l6hg{color:black;}.css-g5l6hg:hover{color:white;}"]
  [@@@css ".css-x2sn43 .a{color:green;}.css-x2sn43 .b{color:green;}"]
  [@@@css "@media (min-width: 768px) {.css-jolv8h .a{color:red;}}"]
  [@@@css ".css-nzzjgr{width:1.5rem;opacity:0.5;}"]
  [@@@css ".css-7riuym{color:var(--theme, blue);}"]
  [@@@css.classes
    [("css-o2ldqx", 0, "Input.solid", "input.ml", 12, 21, 12, 33);
    ("css-1fqqxmb", 1, "Input.multi", "input.ml", 16, 2, 19, 0);
    ("css-g5l6hg", 2, "Input.hovered", "input.ml", 23, 2, 27, 0);
    ("css-x2sn43", 3, "Input.multiSel", "input.ml", 31, 2, 34, 0);
    ("css-jolv8h", 4, "Input.withMedia", "input.ml", 40, 2, 45, 0);
    ("css-nzzjgr", 5, "Input.units", "input.ml", 49, 2, 51, 0);
    ("css-7riuym", 6, "Input.withFallback", "input.ml", 55, 2, 56, 0)]]
  [@@@css.bindings
    [("Input.solid", "css-o2ldqx");
    ("Input.multi", "css-1fqqxmb");
    ("Input.hovered", "css-g5l6hg");
    ("Input.multiSel", "css-x2sn43");
    ("Input.withMedia", "css-jolv8h");
    ("Input.units", "css-nzzjgr");
    ("Input.withFallback", "css-7riuym")]]
  let solid = CSS.make "css-o2ldqx" []
  let multi = CSS.make "css-1fqqxmb" []
  let hovered = CSS.make "css-g5l6hg" []
  let multiSel = CSS.make "css-x2sn43" []
  let withMedia = CSS.make "css-jolv8h" []
  let units = CSS.make "css-nzzjgr" []
  let withFallback = CSS.make "css-7riuym" []
