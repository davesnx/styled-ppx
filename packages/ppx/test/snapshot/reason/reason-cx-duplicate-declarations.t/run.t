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
  [@@@css ".a-4epkbn{color:blue;color:red;color:blue;}"]
  [@@@css ".a-5rx8u2{display:-webkit-box;display:flex;}"]
  [@@@css ".a-7p1gs8{margin:0;}"]
  [@@@css ".a-4eb7kq{color:blue;color:red;}"]
  [@@@css "@media (min-width: 600px) {.a-izob04ep0x6{color:green;}}"]
  [@@@css ".a-7pjper{margin:0;margin-top:5px;margin:10px;}"]
  [@@@css ".a-qyw7u4ebukr:hover{color:blue;color:red;}"]
  [@@@css ".a-qyw7u4ego80:hover{color:red;}"]
  [@@@css ".a-zygl8yfjbrel{--Foo:1px;}"]
  [@@@css ".a-zy803csp5vyo{--foo:2px;}"]
  [@@@css ".a-4ekvmb{color:red;}"]
  [@@@css ".a-zwzjs7{margin:0;margin:var(--c-kv4uq2);}"]
  [@@@css.bindings
    [("Input.dup", "id-1rqoi1k", "a-4epkbn");
    ("Input.fallback", "id-1t6se51", "a-5rx8u2");
    ("Input.interleaved", "id-8z5ze6", "a-7p1gs8 a-4eb7kq");
    ("Input.mediaInterleaved", "id-17s8jfs", "a-izob04ep0x6 a-4eb7kq");
    ("Input.shorthandReset", "id-18j0etq", "a-7pjper");
    ("Input.nested", "id-swo4az", "a-qyw7u4ebukr");
    ("Input.twice", "id-bxfxu3", "a-qyw7u4ego80");
    ("Input.custom", "id-216v6m", "a-zygl8yfjbrel a-zy803csp5vyo");
    ("Input.A.x", "id-hplgo2", "a-4ekvmb");
    ("Input.B.x", "id-i6ik4z", "a-4eb7kq");
    ("Input.vars", "id-10jlpap", "a-zwzjs7")]]
  let dup = CSS.make "label:dup id-1rqoi1k a-4epkbn" []
  let fallback = CSS.make "label:fallback id-1t6se51 a-5rx8u2" []
  let interleaved = CSS.make "label:interleaved id-8z5ze6 a-7p1gs8 a-4eb7kq" []
  let mediaInterleaved =
    CSS.make "label:mediaInterleaved id-17s8jfs a-izob04ep0x6 a-4eb7kq" []
  let shorthandReset = CSS.make "label:shorthandReset id-18j0etq a-7pjper" []
  let nested = CSS.make "label:nested id-swo4az a-qyw7u4ebukr" []
  let twice = CSS.make "label:twice id-bxfxu3 a-qyw7u4ego80" []
  let custom =
    CSS.make "label:custom id-216v6m a-zygl8yfjbrel a-zy803csp5vyo" []
  module A = struct let x = CSS.make "label:x id-hplgo2 a-4ekvmb" [] end
  module B = struct let x = CSS.make "label:x id-i6ik4z a-4eb7kq" [] end
  let c = "10px"
  let vars =
    CSS.make "label:vars id-10jlpap a-zwzjs7"
      [("--c-kv4uq2", (CSS.Types.Margin.toString c))]
