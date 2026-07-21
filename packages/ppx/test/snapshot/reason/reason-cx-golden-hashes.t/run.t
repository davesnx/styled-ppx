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
  [@@@css ".css-tokvmb-solid{color:red}"]
  [@@@css ".css-eaeacs-multi{margin:10px}"]
  [@@@css ".css-1ruxp1v-multi{padding:20px}"]
  [@@@css ".css-14ksm7b-multi{color:blue}"]
  [@@@css ".css-1xu3tth-hovered{color:black}"]
  [@@@css ".css-1tvkge7-hovered:hover{color:white}"]
  [@@@css ".css-ptl2y2-multiSel .a{color:green}"]
  [@@@css ".css-vexvoj-multiSel .b{color:green}"]
  [@@@css "@media (min-width:768px){.css-1l52930-withMedia .a{color:red}}"]
  [@@@css ".css-137pweu-units{width:1.5rem}"]
  [@@@css ".css-1tzeee1-units{opacity:0.5}"]
  [@@@css ".css-1b8lbrn-withFallback{color:var(--theme,blue)}"]
  [@@@css.bindings
    [("Input.solid", "css-tokvmb-solid");
    ("Input.multi", "css-eaeacs-multi css-1ruxp1v-multi css-14ksm7b-multi");
    ("Input.hovered", "css-1xu3tth-hovered css-1tvkge7-hovered");
    ("Input.multiSel", "css-ptl2y2-multiSel css-vexvoj-multiSel");
    ("Input.withMedia", "css-1l52930-withMedia");
    ("Input.units", "css-137pweu-units css-1tzeee1-units");
    ("Input.withFallback", "css-1b8lbrn-withFallback")]]
  let solid = CSS.make "css-tokvmb-solid" []
  let multi =
    CSS.make "css-eaeacs-multi css-1ruxp1v-multi css-14ksm7b-multi" []
  let hovered = CSS.make "css-1xu3tth-hovered css-1tvkge7-hovered" []
  let multiSel = CSS.make "css-ptl2y2-multiSel css-vexvoj-multiSel" []
  let withMedia = CSS.make "css-1l52930-withMedia" []
  let units = CSS.make "css-137pweu-units css-1tzeee1-units" []
  let withFallback = CSS.make "css-1b8lbrn-withFallback" []
