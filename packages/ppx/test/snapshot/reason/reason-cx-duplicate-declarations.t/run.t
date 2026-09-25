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
  [@@@css ".a-ztpkbn{color:blue;color:red;color:blue;}"]
  [@@@css ".a-17ax8u2{display:-webkit-box;display:flex;}"]
  [@@@css ".a-1uk1gs8{margin:0;}"]
  [@@@css ".a-dhb7kq{color:blue;color:red;}"]
  [@@@css "@media (min-width: 600px) {.a-1g5p0x6{color:green;}}"]
  [@@@css ".a-odz94x{margin-top:5px;}"]
  [@@@css ".a-19xrixt{margin:0;margin:10px;}"]
  [@@@css ".a-1e7bukr:hover{color:blue;color:red;}"]
  [@@@css ".a-mngo80:hover{color:red;}"]
  [@@@css ".a-zkbrel{--Foo:1px;}"]
  [@@@css ".a-1r75vyo{--foo:2px;}"]
  [@@@css ".a-tokvmb{color:red;}"]
  [@@@css ".a-zwzjs7{margin:0;margin:var(--c-kv4uq2);}"]
  [@@@css.bindings
    [("Input.dup", "id-1rqoi1k", "a-ztpkbn");
    ("Input.fallback", "id-1t6se51", "a-17ax8u2");
    ("Input.interleaved", "id-8z5ze6", "a-1uk1gs8 a-dhb7kq");
    ("Input.mediaInterleaved", "id-17s8jfs", "a-1g5p0x6 a-dhb7kq");
    ("Input.shorthandReset", "id-18j0etq", "a-odz94x a-19xrixt");
    ("Input.nested", "id-swo4az", "a-1e7bukr");
    ("Input.twice", "id-bxfxu3", "a-mngo80");
    ("Input.custom", "id-216v6m", "a-zkbrel a-1r75vyo");
    ("Input.A.x", "id-hplgo2", "a-tokvmb");
    ("Input.B.x", "id-i6ik4z", "a-dhb7kq");
    ("Input.vars", "id-10jlpap", "a-zwzjs7")]]
  let dup = CSS.make "label:dup id-1rqoi1k a-ztpkbn" []
  let fallback = CSS.make "label:fallback id-1t6se51 a-17ax8u2" []
  let interleaved =
    CSS.make "label:interleaved id-8z5ze6 a-1uk1gs8 a-dhb7kq" []
  let mediaInterleaved =
    CSS.make "label:mediaInterleaved id-17s8jfs a-1g5p0x6 a-dhb7kq" []
  let shorthandReset =
    CSS.make "label:shorthandReset id-18j0etq a-odz94x a-19xrixt" []
  let nested = CSS.make "label:nested id-swo4az a-1e7bukr" []
  let twice = CSS.make "label:twice id-bxfxu3 a-mngo80" []
  let custom = CSS.make "label:custom id-216v6m a-zkbrel a-1r75vyo" []
  module A = struct let x = CSS.make "label:x id-hplgo2 a-tokvmb" [] end
  module B = struct let x = CSS.make "label:x id-i6ik4z a-dhb7kq" [] end
  let c = "10px"
  let vars =
    CSS.make "label:vars id-10jlpap a-zwzjs7"
      [("--c-kv4uq2", (CSS.Types.Margin.toString c))]
