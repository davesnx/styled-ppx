Golden hashes: a stable pin on the classNames produced for representative
[%css] shapes. Hashes are derived from the rendered rule text via Murmur2,
so any change to `Render` (whitespace, escaping, numeric formatting),
to atomization, or to Murmur2 cascades into every emitted className.

Without this pin, a no-op-intended refactor silently busts every cached
className downstream — browser caches, CDN caches, persisted DOM
identifiers all break. Update this test only when the change is intended;
the diff IS the blast radius.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".css-tokvmb{color:red;}"]
  [@@@css ".css-eaeacs{margin:10px;}"]
  [@@@css ".css-1ruxp1v{padding:20px;}"]
  [@@@css ".css-14ksm7b{color:blue;}"]
  [@@@css ".css-1xu3tth{color:black;}"]
  [@@@css ".css-1rwx7to:hover{color:white;}"]
  [@@@css ".css-1r10myy .a{color:green;}"]
  [@@@css ".css-ltb45t .b{color:green;}"]
  [@@@css "@media (min-width: 768px) {.css-14bi921 .a{color:red;}}"]
  [@@@css ".css-137pweu{width:1.5rem;}"]
  [@@@css ".css-1tzeee1{opacity:0.5;}"]
  [@@@css ".css-1j744k{color:var(--theme, blue);}"]
  [@@@css.bindings
    [("Input.solid", "cid-ejsl7w", "css-tokvmb");
    ("Input.multi", "cid-7orjvh", "css-eaeacs css-1ruxp1v css-14ksm7b");
    ("Input.hovered", "cid-18t9scx", "css-1xu3tth css-1rwx7to");
    ("Input.multiSel", "cid-j5w3l0", "css-1r10myy css-ltb45t");
    ("Input.withMedia", "cid-1wbvjdi", "css-14bi921");
    ("Input.units", "cid-4x7ffc", "css-137pweu css-1tzeee1");
    ("Input.withFallback", "cid-asai3x", "css-1j744k")]]
  let solid = CSS.make ~label:"solid" "cid-ejsl7w css-tokvmb" []
  let multi =
    CSS.make ~label:"multi" "cid-7orjvh css-eaeacs css-1ruxp1v css-14ksm7b" []
  let hovered =
    CSS.make ~label:"hovered" "cid-18t9scx css-1xu3tth css-1rwx7to" []
  let multiSel =
    CSS.make ~label:"multiSel" "cid-j5w3l0 css-1r10myy css-ltb45t" []
  let withMedia = CSS.make ~label:"withMedia" "cid-1wbvjdi css-14bi921" []
  let units = CSS.make ~label:"units" "cid-4x7ffc css-137pweu css-1tzeee1" []
  let withFallback = CSS.make ~label:"withFallback" "cid-asai3x css-1j744k" []
