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
  [@@@css
    ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)]
  [@@@css
    ("._a_7peacs{margin:10px;}", "_a_7peacs", "0,1,0 own", "277", 15, false)]
  [@@@css
    ("._a_94xp1v{padding:20px;}", "_a_94xp1v", "0,1,0 own", "328", 15, false)]
  [@@@css
    ("._a_4esm7b{color:blue;}", "_a_4esm7b", "0,1,0 own", "158", 1, false)]
  [@@@css
    ("._a_4e3tth{color:black;}", "_a_4e3tth", "0,1,0 own", "158", 1, false)]
  [@@@css
    ("._a_qyw7u4ex7to:hover{color:white;}", "_a_qyw7u4ex7to", "0,2,0 own",
      "158", 1, false)]
  [@@@css
    ("._a_2sekz4e0myy .a{color:green;}", "_a_2sekz4e0myy", "0,2,0 & .a", "158",
      1, false)]
  [@@@css
    ("._a_bcuim4eb45t .b{color:green;}", "_a_bcuim4eb45t", "0,2,0 & .b", "158",
      1, false)]
  [@@@css
    ("@media (min-width: 768px) {._a_a1ok24ei921 .a{color:red;}}",
      "_a_a1ok24ei921", "0,2,0 & .a", "158", 1, false)]
  [@@@css
    ("._a_ecpweu{width:1.5rem;}", "_a_ecpweu", "0,1,0 own", "516", 1, false)]
  [@@@css
    ("._a_8meee1{opacity:0.5;}", "_a_8meee1", "0,1,0 own", "310", 1, false)]
  [@@@css
    ("._a_4e744k{color:var(--theme, blue);}", "_a_4e744k", "0,1,0 own", "158",
      1, false)]
  [@@@css.bindings
    [("Input.solid", "_id_1ba4rip", "_a_4ekvmb");
    ("Input.multi", "_id_1nhlj5e", "_a_7peacs _a_94xp1v _a_4esm7b");
    ("Input.hovered", "_id_16rh7sm", "_a_4e3tth _a_qyw7u4ex7to");
    ("Input.multiSel", "_id_11sz1d3", "_a_2sekz4e0myy _a_bcuim4eb45t");
    ("Input.withMedia", "_id_abgzoq", "_a_a1ok24ei921");
    ("Input.units", "_id_ns8d6", "_a_ecpweu _a_8meee1");
    ("Input.withFallback", "_id_15mdavp", "_a_4e744k")]]
  [@@@css.blocks
    [(12, "_id_1ba4rip", [0]);
    (15, "_id_1nhlj5e", [1; 2; 3]);
    (22, "_id_16rh7sm", [4; 5]);
    (30, "_id_11sz1d3", [6; 7]);
    (39, "_id_abgzoq", [8]);
    (48, "_id_ns8d6", [9; 10]);
    (54, "_id_15mdavp", [11])]]
  let solid = CSS.make "label:solid _id_1ba4rip _a_4ekvmb" []
  let multi =
    CSS.make "label:multi _id_1nhlj5e _a_7peacs _a_94xp1v _a_4esm7b" []
  let hovered =
    CSS.make "label:hovered _id_16rh7sm _a_4e3tth _a_qyw7u4ex7to" []
  let multiSel =
    CSS.make "label:multiSel _id_11sz1d3 _a_2sekz4e0myy _a_bcuim4eb45t" []
  let withMedia = CSS.make "label:withMedia _id_abgzoq _a_a1ok24ei921" []
  let units = CSS.make "label:units _id_ns8d6 _a_ecpweu _a_8meee1" []
  let withFallback = CSS.make "label:withFallback _id_15mdavp _a_4e744k" []
