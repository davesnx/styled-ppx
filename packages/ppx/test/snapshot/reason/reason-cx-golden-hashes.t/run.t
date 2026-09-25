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
  [@@@css ".a-4ekvmb{color:red;}"]
  [@@@css ".a-7peacs{margin:10px;}"]
  [@@@css ".a-94xp1v{padding:20px;}"]
  [@@@css ".a-4esm7b{color:blue;}"]
  [@@@css ".a-4e3tth{color:black;}"]
  [@@@css ".a-qyw7u4ex7to:hover{color:white;}"]
  [@@@css ".a-2sekz4e0myy .a{color:green;}"]
  [@@@css ".a-bcuim4eb45t .b{color:green;}"]
  [@@@css "@media (min-width: 768px) {.a-a1ok24ei921 .a{color:red;}}"]
  [@@@css ".a-ecpweu{width:1.5rem;}"]
  [@@@css ".a-8meee1{opacity:0.5;}"]
  [@@@css ".a-4e744k{color:var(--theme, blue);}"]
  [@@@css.bindings
    [("Input.solid", "id-ejsl7w", "a-4ekvmb");
    ("Input.multi", "id-7orjvh", "a-7peacs a-94xp1v a-4esm7b");
    ("Input.hovered", "id-18t9scx", "a-4e3tth a-qyw7u4ex7to");
    ("Input.multiSel", "id-j5w3l0", "a-2sekz4e0myy a-bcuim4eb45t");
    ("Input.withMedia", "id-1wbvjdi", "a-a1ok24ei921");
    ("Input.units", "id-4x7ffc", "a-ecpweu a-8meee1");
    ("Input.withFallback", "id-asai3x", "a-4e744k")]]
  let solid = CSS.make "label:solid id-ejsl7w a-4ekvmb" []
  let multi = CSS.make "label:multi id-7orjvh a-7peacs a-94xp1v a-4esm7b" []
  let hovered = CSS.make "label:hovered id-18t9scx a-4e3tth a-qyw7u4ex7to" []
  let multiSel =
    CSS.make "label:multiSel id-j5w3l0 a-2sekz4e0myy a-bcuim4eb45t" []
  let withMedia = CSS.make "label:withMedia id-1wbvjdi a-a1ok24ei921" []
  let units = CSS.make "label:units id-4x7ffc a-ecpweu a-8meee1" []
  let withFallback = CSS.make "label:withFallback id-asai3x a-4e744k" []
