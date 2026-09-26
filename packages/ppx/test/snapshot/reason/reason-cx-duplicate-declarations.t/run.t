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

The same grouping mechanism is keyed by property FAMILY, not literal
property name, so a shorthand mixed with its own longhand groups the
same way (`shorthandReset` below) - see `reason-family-atoms.t` for that
as the main subject, across properties that never repeat.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --c-kv4uq2{syntax:\"*\";inherits:false;}"]
  [@@@css "._a_4epkbn{color:blue;color:red;color:blue;}"]
  [@@@css "._a_5rx8u2{display:-webkit-box;display:flex;}"]
  [@@@css "._a_7p1gs8{margin:0;}"]
  [@@@css "._a_4eb7kq{color:blue;color:red;}"]
  [@@@css "@media (min-width: 600px) {._a_izob04ep0x6{color:green;}}"]
  [@@@css "._a_7pjper{margin:0;margin-top:5px;margin:10px;}"]
  [@@@css "._a_qyw7u4ebukr:hover{color:blue;color:red;}"]
  [@@@css "._a_qyw7u4ego80:hover{color:red;}"]
  [@@@css "._a_zygl8yfjbrel{--Foo:1px;}"]
  [@@@css "._a_zy803csp5vyo{--foo:2px;}"]
  [@@@css "._a_4ekvmb{color:red;}"]
  [@@@css "._a_7pzjs7{margin:0;margin:var(--c-kv4uq2);}"]
  [@@@css.bindings
    [("Input.dup", "_id_1rqoi1k", "_a_4epkbn");
    ("Input.fallback", "_id_1t6se51", "_a_5rx8u2");
    ("Input.interleaved", "_id_8z5ze6", "_a_7p1gs8 _a_4eb7kq");
    ("Input.mediaInterleaved", "_id_17s8jfs", "_a_izob04ep0x6 _a_4eb7kq");
    ("Input.shorthandReset", "_id_18j0etq", "_a_7pjper");
    ("Input.nested", "_id_swo4az", "_a_qyw7u4ebukr");
    ("Input.twice", "_id_bxfxu3", "_a_qyw7u4ego80");
    ("Input.custom", "_id_216v6m", "_a_zygl8yfjbrel _a_zy803csp5vyo");
    ("Input.A.x", "_id_hplgo2", "_a_4ekvmb");
    ("Input.B.x", "_id_i6ik4z", "_a_4eb7kq");
    ("Input.vars", "_id_10jlpap", "_a_7pzjs7")]]
  let dup = CSS.make "label:dup _id_1rqoi1k _a_4epkbn" []
  let fallback = CSS.make "label:fallback _id_1t6se51 _a_5rx8u2" []
  let interleaved =
    CSS.make "label:interleaved _id_8z5ze6 _a_7p1gs8 _a_4eb7kq" []
  let mediaInterleaved =
    CSS.make "label:mediaInterleaved _id_17s8jfs _a_izob04ep0x6 _a_4eb7kq" []
  let shorthandReset = CSS.make "label:shorthandReset _id_18j0etq _a_7pjper" []
  let nested = CSS.make "label:nested _id_swo4az _a_qyw7u4ebukr" []
  let twice = CSS.make "label:twice _id_bxfxu3 _a_qyw7u4ego80" []
  let custom =
    CSS.make "label:custom _id_216v6m _a_zygl8yfjbrel _a_zy803csp5vyo" []
  module A = struct let x = CSS.make "label:x _id_hplgo2 _a_4ekvmb" [] end
  module B = struct let x = CSS.make "label:x _id_i6ik4z _a_4eb7kq" [] end
  let c = "10px"
  let vars =
    CSS.make "label:vars _id_10jlpap _a_7pzjs7"
      [("--c-kv4uq2", (CSS.Types.Margin.toString c))]
