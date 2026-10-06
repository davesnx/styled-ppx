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
  [@@@css "._a_4ekvmb{color:red;}"]
  [@@@css "._a_7peacs{margin:10px;}"]
  [@@@css "._a_94xp1v{padding:20px;}"]
  [@@@css "._a_4esm7b{color:blue;}"]
  [@@@css "._a_4e3tth{color:black;}"]
  [@@@css "._a_qyw7u4ex7to:hover{color:white;}"]
  [@@@css "._a_2sekz4e0myy .a{color:green;}"]
  [@@@css "._a_bcuim4eb45t .b{color:green;}"]
  [@@@css "@media (min-width: 768px) {._a_a1ok24ei921 .a{color:red;}}"]
  [@@@css "._a_ecpweu{width:1.5rem;}"]
  [@@@css "._a_8meee1{opacity:0.5;}"]
  [@@@css "._a_4e744k{color:var(--theme, blue);}"]
  [@@@css.bindings
    [("Input.solid", "_id_ejsl7w", "_a_4ekvmb");
    ("Input.multi", "_id_7orjvh", "_a_7peacs _a_94xp1v _a_4esm7b");
    ("Input.hovered", "_id_18t9scx", "_a_4e3tth _a_qyw7u4ex7to");
    ("Input.multiSel", "_id_j5w3l0", "_a_2sekz4e0myy _a_bcuim4eb45t");
    ("Input.withMedia", "_id_1wbvjdi", "_a_a1ok24ei921");
    ("Input.units", "_id_4x7ffc", "_a_ecpweu _a_8meee1");
    ("Input.withFallback", "_id_asai3x", "_a_4e744k")]]
  let solid = CSS.make "label:solid _id_ejsl7w _a_4ekvmb" []
  let multi =
    CSS.make "label:multi _id_7orjvh _a_7peacs _a_94xp1v _a_4esm7b" []
  let hovered =
    CSS.make "label:hovered _id_18t9scx _a_4e3tth _a_qyw7u4ex7to" []
  let multiSel =
    CSS.make "label:multiSel _id_j5w3l0 _a_2sekz4e0myy _a_bcuim4eb45t" []
  let withMedia = CSS.make "label:withMedia _id_1wbvjdi _a_a1ok24ei921" []
  let units = CSS.make "label:units _id_4x7ffc _a_ecpweu _a_8meee1" []
  let withFallback = CSS.make "label:withFallback _id_asai3x _a_4e744k" []
