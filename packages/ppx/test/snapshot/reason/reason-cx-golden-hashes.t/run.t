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
    [("Input.solid", "css-tokvmb-solid");
    ("Input.multi", "css-eaeacs-multi css-1ruxp1v-multi css-14ksm7b-multi");
    ("Input.hovered", "css-1xu3tth-hovered css-1rwx7to-hovered");
    ("Input.multiSel", "css-1r10myy-multiSel css-ltb45t-multiSel");
    ("Input.withMedia", "css-14bi921-withMedia");
    ("Input.units", "css-137pweu-units css-1tzeee1-units");
    ("Input.withFallback", "css-1j744k-withFallback")]]
  let solid = CSS.make "css-tokvmb-solid" []
  let multi =
    CSS.make "css-eaeacs-multi css-1ruxp1v-multi css-14ksm7b-multi" []
  let hovered = CSS.make "css-1xu3tth-hovered css-1rwx7to-hovered" []
  let multiSel = CSS.make "css-1r10myy-multiSel css-ltb45t-multiSel" []
  let withMedia = CSS.make "css-14bi921-withMedia" []
  let units = CSS.make "css-137pweu-units css-1tzeee1-units" []
  let withFallback = CSS.make "css-1j744k-withFallback" []
