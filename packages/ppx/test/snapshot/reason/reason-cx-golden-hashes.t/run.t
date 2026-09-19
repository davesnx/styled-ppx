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
  [@@@css ".css-tokvmb-solid{color:red;}"]
  [@@@css ".css-eaeacs-multi{margin:10px;}"]
  [@@@css ".css-1ruxp1v-multi{padding:20px;}"]
  [@@@css ".css-14ksm7b-multi{color:blue;}"]
  [@@@css ".css-1xu3tth-hovered{color:black;}"]
  [@@@css ".css-1rwx7to-hovered:hover{color:white;}"]
  [@@@css ".css-1r10myy-multiSel .a{color:green;}"]
  [@@@css ".css-ltb45t-multiSel .b{color:green;}"]
  [@@@css "@media (min-width: 768px) {.css-14bi921-withMedia .a{color:red;}}"]
  [@@@css ".css-137pweu-units{width:1.5rem;}"]
  [@@@css ".css-1tzeee1-units{opacity:0.5;}"]
  [@@@css ".css-1j744k-withFallback{color:var(--theme, blue);}"]
  [@@@css.bindings
    [("Input.solid", "cid-ejsl7w", "css-tokvmb-solid");
    ("Input.multi", "cid-7orjvh",
      "css-eaeacs-multi css-1ruxp1v-multi css-14ksm7b-multi");
    ("Input.hovered", "cid-18t9scx", "css-1xu3tth-hovered css-1rwx7to-hovered");
    ("Input.multiSel", "cid-j5w3l0",
      "css-1r10myy-multiSel css-ltb45t-multiSel");
    ("Input.withMedia", "cid-1wbvjdi", "css-14bi921-withMedia");
    ("Input.units", "cid-4x7ffc", "css-137pweu-units css-1tzeee1-units");
    ("Input.withFallback", "cid-asai3x", "css-1j744k-withFallback")]]
  let solid = CSS.make "cid-ejsl7w css-tokvmb-solid" []
  let multi =
    CSS.make "cid-7orjvh css-eaeacs-multi css-1ruxp1v-multi css-14ksm7b-multi"
      []
  let hovered =
    CSS.make "cid-18t9scx css-1xu3tth-hovered css-1rwx7to-hovered" []
  let multiSel =
    CSS.make "cid-j5w3l0 css-1r10myy-multiSel css-ltb45t-multiSel" []
  let withMedia = CSS.make "cid-1wbvjdi css-14bi921-withMedia" []
  let units = CSS.make "cid-4x7ffc css-137pweu-units css-1tzeee1-units" []
  let withFallback = CSS.make "cid-asai3x css-1j744k-withFallback" []
