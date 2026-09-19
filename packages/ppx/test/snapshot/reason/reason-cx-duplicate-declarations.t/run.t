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
  [@@@css ".css-ztpkbn-dup{color:blue;color:red;color:blue;}"]
  [@@@css ".css-17ax8u2-fallback{display:-webkit-box;display:flex;}"]
  [@@@css ".css-1uk1gs8-interleaved{margin:0;}"]
  [@@@css ".css-dhb7kq-interleaved{color:blue;color:red;}"]
  [@@@css
    "@media (min-width: 600px) {.css-1g5p0x6-mediaInterleaved{color:green;}}"]
  [@@@css ".css-dhb7kq-mediaInterleaved{color:blue;color:red;}"]
  [@@@css ".css-odz94x-shorthandReset{margin-top:5px;}"]
  [@@@css ".css-19xrixt-shorthandReset{margin:0;margin:10px;}"]
  [@@@css ".css-1e7bukr-nested:hover{color:blue;color:red;}"]
  [@@@css ".css-mngo80-twice:hover{color:red;}"]
  [@@@css ".css-zkbrel-custom{--Foo:1px;}"]
  [@@@css ".css-1r75vyo-custom{--foo:2px;}"]
  [@@@css ".css-tokvmb-x{color:red;}"]
  [@@@css ".css-dhb7kq-x{color:blue;color:red;}"]
  [@@@css ".css-zwzjs7-vars{margin:0;margin:var(--c-kv4uq2);}"]
  [@@@css.bindings
    [("Input.dup", "cid-1rqoi1k", "css-ztpkbn-dup");
    ("Input.fallback", "cid-1t6se51", "css-17ax8u2-fallback");
    ("Input.interleaved", "cid-8z5ze6",
      "css-1uk1gs8-interleaved css-dhb7kq-interleaved");
    ("Input.mediaInterleaved", "cid-17s8jfs",
      "css-1g5p0x6-mediaInterleaved css-dhb7kq-mediaInterleaved");
    ("Input.shorthandReset", "cid-18j0etq",
      "css-odz94x-shorthandReset css-19xrixt-shorthandReset");
    ("Input.nested", "cid-swo4az", "css-1e7bukr-nested");
    ("Input.twice", "cid-bxfxu3", "css-mngo80-twice");
    ("Input.custom", "cid-216v6m", "css-zkbrel-custom css-1r75vyo-custom");
    ("Input.A.x", "cid-hplgo2", "css-tokvmb-x");
    ("Input.B.x", "cid-i6ik4z", "css-dhb7kq-x");
    ("Input.vars", "cid-10jlpap", "css-zwzjs7-vars")]]
  let dup = CSS.make "cid-1rqoi1k css-ztpkbn-dup" []
  let fallback = CSS.make "cid-1t6se51 css-17ax8u2-fallback" []
  let interleaved =
    CSS.make "cid-8z5ze6 css-1uk1gs8-interleaved css-dhb7kq-interleaved" []
  let mediaInterleaved =
    CSS.make
      "cid-17s8jfs css-1g5p0x6-mediaInterleaved css-dhb7kq-mediaInterleaved" []
  let shorthandReset =
    CSS.make "cid-18j0etq css-odz94x-shorthandReset css-19xrixt-shorthandReset"
      []
  let nested = CSS.make "cid-swo4az css-1e7bukr-nested" []
  let twice = CSS.make "cid-bxfxu3 css-mngo80-twice" []
  let custom = CSS.make "cid-216v6m css-zkbrel-custom css-1r75vyo-custom" []
  module A = struct let x = CSS.make "cid-hplgo2 css-tokvmb-x" [] end
  module B = struct let x = CSS.make "cid-i6ik4z css-dhb7kq-x" [] end
  let c = "10px"
  let vars =
    CSS.make "cid-10jlpap css-zwzjs7-vars"
      [("--c-kv4uq2", (CSS.Types.Margin.toString c))]
