Same-property declaration grouping under [%css] extraction.

Atomic extraction hashes each declaration into its own class and dedups
identical classes keeping the first stylesheet position. Duplicate
declarations of the same property (last-wins overrides, vendor fallback
pairs like `display: -webkit-box; display: flex`) therefore used to
resolve by stylesheet position instead of source order — silently
diverging from the emotion runtime, which serializes the whole block
verbatim. Grouping every same-property declaration of a block into one
atom makes the winner an intra-atom decision, immune to position, dedup,
and cross-binding hash sharing. Single declarations keep the historical
atom shape and hash.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --c-kv4uq2{syntax:\"*\";inherits:false;}"]
  [@@@css ".css-ztpkbn{color:blue;color:red;color:blue;}"]
  [@@@css ".css-17ax8u2{display:-webkit-box;display:flex;}"]
  [@@@css ".css-1uk1gs8{margin:0;}"]
  [@@@css ".css-dhb7kq{color:blue;color:red;}"]
  [@@@css "@media (min-width: 600px) {.css-1g5p0x6{color:green;}}"]
  [@@@css ".css-odz94x{margin-top:5px;}"]
  [@@@css ".css-19xrixt{margin:0;margin:10px;}"]
  [@@@css ".css-1e7bukr:hover{color:blue;color:red;}"]
  [@@@css ".css-mngo80:hover{color:red;}"]
  [@@@css ".css-zkbrel{--Foo:1px;}"]
  [@@@css ".css-1r75vyo{--foo:2px;}"]
  [@@@css ".css-tokvmb{color:red;}"]
  [@@@css ".css-zwzjs7{margin:0;margin:var(--c-kv4uq2);}"]
  [@@@css.bindings
    [("Input.dup", "cid-1rqoi1k", "css-ztpkbn");
    ("Input.fallback", "cid-1t6se51", "css-17ax8u2");
    ("Input.interleaved", "cid-8z5ze6", "css-1uk1gs8 css-dhb7kq");
    ("Input.mediaInterleaved", "cid-17s8jfs", "css-1g5p0x6 css-dhb7kq");
    ("Input.shorthandReset", "cid-18j0etq", "css-odz94x css-19xrixt");
    ("Input.nested", "cid-swo4az", "css-1e7bukr");
    ("Input.twice", "cid-bxfxu3", "css-mngo80");
    ("Input.custom", "cid-216v6m", "css-zkbrel css-1r75vyo");
    ("Input.A.x", "cid-hplgo2", "css-tokvmb");
    ("Input.B.x", "cid-i6ik4z", "css-dhb7kq");
    ("Input.vars", "cid-10jlpap", "css-zwzjs7")]]
  let dup = CSS.make "label:dup cid-1rqoi1k css-ztpkbn" []
  let fallback = CSS.make "label:fallback cid-1t6se51 css-17ax8u2" []
  let interleaved =
    CSS.make "label:interleaved cid-8z5ze6 css-1uk1gs8 css-dhb7kq" []
  let mediaInterleaved =
    CSS.make "label:mediaInterleaved cid-17s8jfs css-1g5p0x6 css-dhb7kq" []
  let shorthandReset =
    CSS.make "label:shorthandReset cid-18j0etq css-odz94x css-19xrixt" []
  let nested = CSS.make "label:nested cid-swo4az css-1e7bukr" []
  let twice = CSS.make "label:twice cid-bxfxu3 css-mngo80" []
  let custom = CSS.make "label:custom cid-216v6m css-zkbrel css-1r75vyo" []
  module A = struct let x = CSS.make "label:x cid-hplgo2 css-tokvmb" [] end
  module B = struct let x = CSS.make "label:x cid-i6ik4z css-dhb7kq" [] end
  let c = "10px"
  let vars =
    CSS.make "label:vars cid-10jlpap css-zwzjs7"
      [("--c-kv4uq2", (CSS.Types.Margin.toString c))]
