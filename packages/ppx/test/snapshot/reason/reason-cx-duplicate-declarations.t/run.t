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
  [@@@css "@property --c-wkadkb{syntax:\"*\";inherits:false;}"]
  [@@@css.atoms
    [("_a7fzCweZ2", ["._a7fzCweZ2{color:blue;color:red;color:blue;}"], 1, 0, 1,
       [("value", "zCweZ2",
          "val\\07f\\0& | \\0color:blue\\0color:red\\0color:blue")]);
    ("_a9fl_QS6E", ["._a9fl_QS6E{display:-webkit-box;display:flex;}"], 1, 0, 1,
      [("value", "l_QS6E",
         "val\\09f\\0& | \\0display:-webkit-box\\0display:flex")]);
    ("_act0587xC", ["._act0587xC{margin:0;}"], 1, 0, 4,
      [("value", "0587xC", "val\\0ct\\0& | \\0margin:0")]);
    ("_a7fcJI9pi", ["._a7fcJI9pi{color:blue;color:red;}"], 1, 0, 1,
      [("value", "cJI9pi", "val\\07f\\0& | \\0color:blue\\0color:red")]);
    ("_c7fKKj5llIC6EpC",
      ["@media (min-width:600px){._c7fKKj5llIC6EpC{color:green;}}"], 2, 1, 1,
      [("ctx", "KKj5ll", "ctx\\0& | @media (min-width:600px) | ");
      ("value", "IC6EpC",
        "val\\07f\\0& | @media (min-width:600px) | \\0color:green")]);
    ("_actv-aKtM", ["._actv-aKtM{margin:0;margin:10px;}"], 1, 0, 4,
      [("value", "v-aKtM", "val\\0ct\\0& | \\0margin:0\\0margin:10px")]);
    ("_c7f1Tl5-wtK2hGb", ["._c7f1Tl5-wtK2hGb:hover{color:blue;color:red;}"], 2,
      1, 1,
      [("ctx", "1Tl5-w", "ctx\\0&:hover | ");
      ("value", "tK2hGb", "val\\07f\\0&:hover | \\0color:blue\\0color:red")]);
    ("_c7f1Tl5-wYHzGtI", ["._c7f1Tl5-wYHzGtI:hover{color:red;color:red;}"], 2,
      1, 1,
      [("ctx", "1Tl5-w", "ctx\\0&:hover | ");
      ("value", "YHzGtI", "val\\07f\\0&:hover | \\0color:red\\0color:red")]);
    ("_xfZfQvj000000sf0UFK", ["._xfZfQvj000000sf0UFK{--Foo:1px;}"], 1, 0, 1,
      [("name", "fZfQvj", "name\\0--Foo");
      ("value", "sf0UFK", "val\\0--Foo\\0& | \\0--Foo:1px")]);
    ("_x3UklqK000000032KBx", ["._x3UklqK000000032KBx{--foo:2px;}"], 1, 0, 1,
      [("name", "3UklqK", "name\\0--foo");
      ("value", "032KBx", "val\\0--foo\\0& | \\0--foo:2px")]);
    ("_a7fadbhEW", ["._a7fadbhEW{color:red;}"], 1, 0, 1,
      [("value", "adbhEW", "val\\07f\\0& | \\0color:red")]);
    ("_actyjfOIO", ["._actyjfOIO{margin:0;margin:var(--c-wkadkb);}"], 1, 0, 4,
      [("value", "yjfOIO", "val\\0ct\\0& | \\0margin:0\\0margin:$(c)")]);
    ("_iHnNlY0lS", [], 1, 0, 0,
      [("id", "_iHnNlY0lS", "bind\\0\\0Input\\0\\0dup\\00")]);
    ("_iDtzh2QAN", [], 1, 0, 0,
      [("id", "_iDtzh2QAN", "bind\\0\\0Input\\0\\0fallback\\00")]);
    ("_i5QGR5ymo", [], 1, 0, 0,
      [("id", "_i5QGR5ymo", "bind\\0\\0Input\\0\\0interleaved\\00")]);
    ("_iBdbqPt2h", [], 1, 0, 0,
      [("id", "_iBdbqPt2h", "bind\\0\\0Input\\0\\0mediaInterleaved\\00")]);
    ("_iFpTSV0S0", [], 1, 0, 0,
      [("id", "_iFpTSV0S0", "bind\\0\\0Input\\0\\0shorthandReset\\00")]);
    ("_iQIM0ep0T", [], 1, 0, 0,
      [("id", "_iQIM0ep0T", "bind\\0\\0Input\\0\\0nested\\00")]);
    ("_iPEA4CIFa", [], 1, 0, 0,
      [("id", "_iPEA4CIFa", "bind\\0\\0Input\\0\\0twice\\00")]);
    ("_iY2nFpXfe", [], 1, 0, 0,
      [("id", "_iY2nFpXfe", "bind\\0\\0Input\\0\\0custom\\00")]);
    ("_iEUd5l_jH", [], 1, 0, 0,
      [("id", "_iEUd5l_jH", "bind\\0\\0Input\\0A\\0x\\00")]);
    ("_i-Sf41BYb", [], 1, 0, 0,
      [("id", "_i-Sf41BYb", "bind\\0\\0Input\\0B\\0x\\00")]);
    ("_i2T0kedpj", [], 1, 0, 0,
      [("id", "_i2T0kedpj", "bind\\0\\0Input\\0\\0vars\\00")])]]
  [@@@css.bindings
    [("Input.dup", "_iHnNlY0lS _a7fzCweZ2", "_iHnNlY0lS");
    ("Input.fallback", "_iDtzh2QAN _a9fl_QS6E", "_iDtzh2QAN");
    ("Input.interleaved", "_i5QGR5ymo _act0587xC _a7fcJI9pi", "_i5QGR5ymo");
    ("Input.mediaInterleaved", "_iBdbqPt2h _a7fcJI9pi _c7fKKj5llIC6EpC",
      "_iBdbqPt2h");
    ("Input.shorthandReset", "_iFpTSV0S0 _actv-aKtM", "_iFpTSV0S0");
    ("Input.nested", "_iQIM0ep0T _c7f1Tl5-wtK2hGb", "_iQIM0ep0T");
    ("Input.twice", "_iPEA4CIFa _c7f1Tl5-wYHzGtI", "_iPEA4CIFa");
    ("Input.custom", "_iY2nFpXfe _xfZfQvj000000sf0UFK _x3UklqK000000032KBx",
      "_iY2nFpXfe");
    ("Input.A.x", "_iEUd5l_jH _a7fadbhEW", "_iEUd5l_jH");
    ("Input.B.x", "_i-Sf41BYb _a7fcJI9pi", "_i-Sf41BYb");
    ("Input.vars", "_i2T0kedpj _actyjfOIO", "_i2T0kedpj")]]
  let dup = CSS.make "_iHnNlY0lS _a7fzCweZ2" []
  let fallback = CSS.make "_iDtzh2QAN _a9fl_QS6E" []
  let interleaved = CSS.make "_i5QGR5ymo _act0587xC _a7fcJI9pi" []
  let mediaInterleaved = CSS.make "_iBdbqPt2h _a7fcJI9pi _c7fKKj5llIC6EpC" []
  let shorthandReset = CSS.make "_iFpTSV0S0 _actv-aKtM" []
  let nested = CSS.make "_iQIM0ep0T _c7f1Tl5-wtK2hGb" []
  let twice = CSS.make "_iPEA4CIFa _c7f1Tl5-wYHzGtI" []
  let custom =
    CSS.make "_iY2nFpXfe _xfZfQvj000000sf0UFK _x3UklqK000000032KBx" []
  module A = struct let x = CSS.make "_iEUd5l_jH _a7fadbhEW" [] end
  module B = struct let x = CSS.make "_i-Sf41BYb _a7fcJI9pi" [] end
  let c = "10px"
  let vars =
    CSS.make "_i2T0kedpj _actyjfOIO"
      [("--c-wkadkb", (CSS.Types.Margin.toString c))]
