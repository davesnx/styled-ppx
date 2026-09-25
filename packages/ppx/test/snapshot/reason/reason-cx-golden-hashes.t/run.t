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
  [@@@css ".a-tokvmb{color:red;}"]
  [@@@css ".a-eaeacs{margin:10px;}"]
  [@@@css ".a-1ruxp1v{padding:20px;}"]
  [@@@css ".a-14ksm7b{color:blue;}"]
  [@@@css ".a-1xu3tth{color:black;}"]
  [@@@css ".a-1rwx7to:hover{color:white;}"]
  [@@@css ".a-1r10myy .a{color:green;}"]
  [@@@css ".a-ltb45t .b{color:green;}"]
  [@@@css "@media (min-width: 768px) {.a-14bi921 .a{color:red;}}"]
  [@@@css ".a-137pweu{width:1.5rem;}"]
  [@@@css ".a-1tzeee1{opacity:0.5;}"]
  [@@@css ".a-1j744k{color:var(--theme, blue);}"]
  [@@@css.bindings
    [("Input.solid", "id-ejsl7w", "a-tokvmb");
    ("Input.multi", "id-7orjvh", "a-eaeacs a-1ruxp1v a-14ksm7b");
    ("Input.hovered", "id-18t9scx", "a-1xu3tth a-1rwx7to");
    ("Input.multiSel", "id-j5w3l0", "a-1r10myy a-ltb45t");
    ("Input.withMedia", "id-1wbvjdi", "a-14bi921");
    ("Input.units", "id-4x7ffc", "a-137pweu a-1tzeee1");
    ("Input.withFallback", "id-asai3x", "a-1j744k")]]
  let solid = CSS.make "label:solid id-ejsl7w a-tokvmb" []
  let multi = CSS.make "label:multi id-7orjvh a-eaeacs a-1ruxp1v a-14ksm7b" []
  let hovered = CSS.make "label:hovered id-18t9scx a-1xu3tth a-1rwx7to" []
  let multiSel = CSS.make "label:multiSel id-j5w3l0 a-1r10myy a-ltb45t" []
  let withMedia = CSS.make "label:withMedia id-1wbvjdi a-14bi921" []
  let units = CSS.make "label:units id-4x7ffc a-137pweu a-1tzeee1" []
  let withFallback = CSS.make "label:withFallback id-asai3x a-1j744k" []
