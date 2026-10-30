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
  [@@@css
    ("._a_4epkbn{color:blue;color:red;color:blue;}", "_a_4epkbn", "0,1,0 own",
      "158", 1, false)]
  [@@@css
    ("._a_5rx8u2{display:-webkit-box;display:flex;}", "_a_5rx8u2", "0,1,0 own",
      "207", 1, false)]
  [@@@css
    ("._a_7p1gs8{margin:0;}", "_a_7p1gs8", "0,1,0 own", "277", 15, false)]
  [@@@css
    ("._a_4eb7kq{color:blue;color:red;}", "_a_4eb7kq", "0,1,0 own", "158", 1,
      false)]
  [@@@css
    ("@media (min-width: 600px) {._a_izob04ep0x6{color:green;}}",
      "_a_izob04ep0x6", "0,1,0 own", "158", 1, false)]
  [@@@css
    ("._a_7pjper{margin:0;margin-top:5px;margin:10px;}", "_a_7pjper",
      "0,1,0 own", "277", 15, false)]
  [@@@css
    ("._a_qyw7u4ebukr:hover{color:blue;color:red;}", "_a_qyw7u4ebukr",
      "0,2,0 own", "158", 1, false)]
  [@@@css
    ("._a_qyw7u4ego80:hover{color:red;}", "_a_qyw7u4ego80", "0,2,0 own", "158",
      1, false)]
  [@@@css
    ("._a_zygl8yfjbrel{--Foo:1px;}", "_a_zygl8yfjbrel", "0,1,0 own",
      "-c1003148623", 1, false)]
  [@@@css
    ("._a_zy803csp5vyo{--foo:2px;}", "_a_zy803csp5vyo", "0,1,0 own",
      "-c483885961", 1, false)]
  [@@@css
    ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)]
  [@@@css
    ("._a_7pzjs7{margin:0;margin:var(--c-kv4uq2);}", "_a_7pzjs7", "0,1,0 own",
      "277", 15, false)]
  [@@@css.bindings
    [("Input.dup", "_id_2frt8o", "_a_4epkbn");
    ("Input.fallback", "_id_nhm3i7", "_a_5rx8u2");
    ("Input.interleaved", "_id_uz1g5q", "_a_7p1gs8 _a_4eb7kq");
    ("Input.mediaInterleaved", "_id_hqmvut", "_a_4eb7kq _a_izob04ep0x6");
    ("Input.shorthandReset", "_id_10g1958", "_a_7pjper");
    ("Input.nested", "_id_12efak4", "_a_qyw7u4ebukr");
    ("Input.twice", "_id_cxak1z", "_a_qyw7u4ego80");
    ("Input.custom", "_id_z7kpur", "_a_zygl8yfjbrel _a_zy803csp5vyo");
    ("Input.A.x", "_id_611hw4", "_a_4ekvmb");
    ("Input.B.x", "_id_afgty5", "_a_4eb7kq");
    ("Input.vars", "_id_815umz", "_a_7pzjs7")]]
  [@@@css.blocks
    [(11, "_id_2frt8o", [1]);
    (15, "_id_nhm3i7", [2]);
    (19, "_id_uz1g5q", [3; 4]);
    (25, "_id_hqmvut", [4; 5]);
    (33, "_id_10g1958", [6]);
    (36, "_id_12efak4", [7]);
    (40, "_id_cxak1z", [8; 8]);
    (43, "_id_z7kpur", [9; 10]);
    (49, "_id_611hw4", [11]);
    (53, "_id_afgty5", [4]);
    (58, "_id_815umz", [12])]]
  let dup = CSS.make "label:dup _id_2frt8o _a_4epkbn" []
  let fallback = CSS.make "label:fallback _id_nhm3i7 _a_5rx8u2" []
  let interleaved =
    CSS.make "label:interleaved _id_uz1g5q _a_7p1gs8 _a_4eb7kq" []
  let mediaInterleaved =
    CSS.make "label:mediaInterleaved _id_hqmvut _a_4eb7kq _a_izob04ep0x6" []
  let shorthandReset = CSS.make "label:shorthandReset _id_10g1958 _a_7pjper" []
  let nested = CSS.make "label:nested _id_12efak4 _a_qyw7u4ebukr" []
  let twice = CSS.make "label:twice _id_cxak1z _a_qyw7u4ego80" []
  let custom =
    CSS.make "label:custom _id_z7kpur _a_zygl8yfjbrel _a_zy803csp5vyo" []
  module A = struct let x = CSS.make "label:x _id_611hw4 _a_4ekvmb" [] end
  module B = struct let x = CSS.make "label:x _id_afgty5 _a_4eb7kq" [] end
  let c = "10px"
  let vars =
    CSS.make "label:vars _id_815umz _a_7pzjs7"
      [("--c-kv4uq2", (CSS.Types.Margin.toString c))]
