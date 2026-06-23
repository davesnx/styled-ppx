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

  $ standalone --impl input.ml -o output.ml
  $ cat output.ml
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
    [("Input.dup", "css-ztpkbn-dup");
    ("Input.fallback", "css-17ax8u2-fallback");
    ("Input.interleaved", "css-1uk1gs8-interleaved css-dhb7kq-interleaved");
    ("Input.mediaInterleaved",
      "css-1g5p0x6-mediaInterleaved css-dhb7kq-mediaInterleaved");
    ("Input.shorthandReset",
      "css-odz94x-shorthandReset css-19xrixt-shorthandReset");
    ("Input.nested", "css-1e7bukr-nested");
    ("Input.twice", "css-mngo80-twice");
    ("Input.custom", "css-zkbrel-custom css-1r75vyo-custom");
    ("Input.A.x", "css-tokvmb-x");
    ("Input.B.x", "css-dhb7kq-x");
    ("Input.vars", "css-zwzjs7-vars")]]
  let dup = CSS.make "css-ztpkbn-dup" []
  let fallback = CSS.make "css-17ax8u2-fallback" []
  let interleaved =
    CSS.make "css-1uk1gs8-interleaved css-dhb7kq-interleaved" []
  let mediaInterleaved =
    CSS.make "css-1g5p0x6-mediaInterleaved css-dhb7kq-mediaInterleaved" []
  let shorthandReset =
    CSS.make "css-odz94x-shorthandReset css-19xrixt-shorthandReset" []
  let nested = CSS.make "css-1e7bukr-nested" []
  let twice = CSS.make "css-mngo80-twice" []
  let custom = CSS.make "css-zkbrel-custom css-1r75vyo-custom" []
  module A = struct let x = CSS.make "css-tokvmb-x" [] end
  module B = struct let x = CSS.make "css-dhb7kq-x" [] end
  let c = "10px"
  let vars =
    CSS.make "css-zwzjs7-vars" [("--c-kv4uq2", (CSS.Types.Margin.toString c))]
