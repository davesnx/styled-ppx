This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build

  $ dune describe pp ./input.re
  [@ocaml.ppx.context
    {
      tool_name: "ppx_driver",
      include_dirs: [],
      hidden_include_dirs: [],
      load_path: ([], []),
      open_modules: [],
      for_package: None,
      debug: false,
      use_threads: false,
      use_vmthreads: false,
      recursive_types: false,
      principal: false,
      no_alias_deps: false,
      unboxed_types: false,
      unsafe_string: false,
      cookies: [],
    }
  ];
  [@css "@property --value-97csfh{syntax:\"*\";inherits:false;}"];
  [@css "@property --area-9owtnd{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_a9fDR52Mo",
        ["._a9fDR52Mo{display:grid;}"],
        1,
        0,
        1,
        [("value", "DR52Mo", "val\\09f\\0& | \\0display:grid")],
      ),
      (
        "_a9fqjWCi3",
        ["._a9fqjWCi3{display:inline-grid;}"],
        1,
        0,
        1,
        [("value", "qjWCi3", "val\\09f\\0& | \\0display:inline-grid")],
      ),
      (
        "_abaO44VC9",
        ["._abaO44VC9{grid-template-columns:none;}"],
        1,
        0,
        1,
        [("value", "O44VC9", "val\\0ba\\0& | \\0grid-template-columns:none")],
      ),
      (
        "_abaG9aghl",
        ["._abaG9aghl{grid-template-columns:auto;}"],
        1,
        0,
        1,
        [("value", "G9aghl", "val\\0ba\\0& | \\0grid-template-columns:auto")],
      ),
      (
        "_abao2QnbJ",
        ["._abao2QnbJ{grid-template-columns:100px;}"],
        1,
        0,
        1,
        [("value", "o2QnbJ", "val\\0ba\\0& | \\0grid-template-columns:100px")],
      ),
      (
        "_abaouX8uo",
        ["._abaouX8uo{grid-template-columns:1fr;}"],
        1,
        0,
        1,
        [("value", "ouX8uo", "val\\0ba\\0& | \\0grid-template-columns:1fr")],
      ),
      (
        "_abasInBnJ",
        ["._abasInBnJ{grid-template-columns:100px 1fr auto;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "sInBnJ",
            "val\\0ba\\0& | \\0grid-template-columns:100px 1fr auto",
          ),
        ],
      ),
      (
        "_abafJnnMp",
        ["._abafJnnMp{grid-template-columns:repeat(2, 100px 1fr);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "fJnnMp",
            "val\\0ba\\0& | \\0grid-template-columns:repeat(2, 100px 1fr)",
          ),
        ],
      ),
      (
        "_abafyySQA",
        [
          "._abafyySQA{grid-template-columns:repeat(4, 10px [col-start] 250px [col-end]) 10px;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "fyySQA",
            "val\\0ba\\0& | \\0grid-template-columns:repeat(4, 10px [col-start] 250px [col-end]) 10px",
          ),
        ],
      ),
      (
        "_abambGLMx",
        [
          "._abambGLMx{grid-template-columns:100px 1fr max-content minmax(min-content, 1fr);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "mbGLMx",
            "val\\0ba\\0& | \\0grid-template-columns:100px 1fr max-content minmax(min-content, 1fr)",
          ),
        ],
      ),
      (
        "_abaOmBL5y",
        [
          "._abaOmBL5y{grid-template-columns:repeat(auto-fill, minmax(25ch, 1fr));}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "OmBL5y",
            "val\\0ba\\0& | \\0grid-template-columns:repeat(auto-fill, minmax(25ch, 1fr))",
          ),
        ],
      ),
      (
        "_abaT76gzk",
        [
          "._abaT76gzk{grid-template-columns:10px [col-start] 250px [col-end];}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "T76gzk",
            "val\\0ba\\0& | \\0grid-template-columns:10px [col-start] 250px [col-end]",
          ),
        ],
      ),
      (
        "_abarJxARq",
        [
          "._abarJxARq{grid-template-columns:[first nav-start] 150px [main-start] 1fr [last];}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "rJxARq",
            "val\\0ba\\0& | \\0grid-template-columns:[first nav-start] 150px [main-start] 1fr [last]",
          ),
        ],
      ),
      (
        "_abarkotWx",
        [
          "._abarkotWx{grid-template-columns:10px [col-start] 250px [col-end] 10px [col-start] 250px [col-end] 10px;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "rkotWx",
            "val\\0ba\\0& | \\0grid-template-columns:10px [col-start] 250px [col-end] 10px [col-start] 250px [col-end] 10px",
          ),
        ],
      ),
      (
        "_abauTJ_z3",
        [
          "._abauTJ_z3{grid-template-columns:[a] auto [b] minmax(min-content, 1fr) [b c d] repeat(2, [e] 40px) repeat(5, auto);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "uTJ_z3",
            "val\\0ba\\0& | \\0grid-template-columns:[a] auto [b] minmax(min-content, 1fr) [b c d] repeat(2, [e] 40px) repeat(5, auto)",
          ),
        ],
      ),
      (
        "_abatNXhki",
        [
          "._abatNXhki{grid-template-columns:200px repeat(auto-fill, 100px) 300px;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "tNXhki",
            "val\\0ba\\0& | \\0grid-template-columns:200px repeat(auto-fill, 100px) 300px",
          ),
        ],
      ),
      (
        "_abauNCOpf",
        [
          "._abauNCOpf{grid-template-columns:minmax(100px, max-content) repeat(auto-fill, 200px) 20%;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "uNCOpf",
            "val\\0ba\\0& | \\0grid-template-columns:minmax(100px, max-content) repeat(auto-fill, 200px) 20%",
          ),
        ],
      ),
      (
        "_abazMANkv",
        [
          "._abazMANkv{grid-template-columns:[linename1] 100px [linename2] repeat(auto-fit, [linename3 linename4] 300px) 100px;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "zMANkv",
            "val\\0ba\\0& | \\0grid-template-columns:[linename1] 100px [linename2] repeat(auto-fit, [linename3 linename4] 300px) 100px",
          ),
        ],
      ),
      (
        "_abaArMjdj",
        [
          "._abaArMjdj{grid-template-columns:[linename1 linename2] 100px repeat(auto-fit, [linename1] 300px) [linename3];}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "ArMjdj",
            "val\\0ba\\0& | \\0grid-template-columns:[linename1 linename2] 100px repeat(auto-fit, [linename1] 300px) [linename3]",
          ),
        ],
      ),
      (
        "_abaUPAffp",
        ["._abaUPAffp{grid-template-columns:var(--value-97csfh);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "UPAffp",
            "val\\0ba\\0& | \\0grid-template-columns:$(value)",
          ),
        ],
      ),
      (
        "_abbaCkPKZ",
        ["._abbaCkPKZ{grid-template-rows:none;}"],
        1,
        0,
        1,
        [("value", "aCkPKZ", "val\\0bb\\0& | \\0grid-template-rows:none")],
      ),
      (
        "_abbcLizeV",
        ["._abbcLizeV{grid-template-rows:auto;}"],
        1,
        0,
        1,
        [("value", "cLizeV", "val\\0bb\\0& | \\0grid-template-rows:auto")],
      ),
      (
        "_abbbXzsGe",
        ["._abbbXzsGe{grid-template-rows:100px;}"],
        1,
        0,
        1,
        [("value", "bXzsGe", "val\\0bb\\0& | \\0grid-template-rows:100px")],
      ),
      (
        "_abbD-M7pD",
        ["._abbD-M7pD{grid-template-rows:1fr;}"],
        1,
        0,
        1,
        [("value", "D-M7pD", "val\\0bb\\0& | \\0grid-template-rows:1fr")],
      ),
      (
        "_abbyZ5X2V",
        ["._abbyZ5X2V{grid-template-rows:100px 1fr auto;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "yZ5X2V",
            "val\\0bb\\0& | \\0grid-template-rows:100px 1fr auto",
          ),
        ],
      ),
      (
        "_abbXYIIRD",
        ["._abbXYIIRD{grid-template-rows:repeat(2, 100px 1fr);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "XYIIRD",
            "val\\0bb\\0& | \\0grid-template-rows:repeat(2, 100px 1fr)",
          ),
        ],
      ),
      (
        "_abbEkl-LL",
        [
          "._abbEkl-LL{grid-template-rows:100px 1fr max-content minmax(min-content, 1fr);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "Ekl-LL",
            "val\\0bb\\0& | \\0grid-template-rows:100px 1fr max-content minmax(min-content, 1fr)",
          ),
        ],
      ),
      (
        "_abb1MVPEb",
        ["._abb1MVPEb{grid-template-rows:10px [row-start] 250px [row-end];}"],
        1,
        0,
        1,
        [
          (
            "value",
            "1MVPEb",
            "val\\0bb\\0& | \\0grid-template-rows:10px [row-start] 250px [row-end]",
          ),
        ],
      ),
      (
        "_abbL5Gios",
        [
          "._abbL5Gios{grid-template-rows:[first header-start] 50px [main-start] 1fr [footer-start] 50px [last];}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "L5Gios",
            "val\\0bb\\0& | \\0grid-template-rows:[first header-start] 50px [main-start] 1fr [footer-start] 50px [last]",
          ),
        ],
      ),
      (
        "_ab9kSP2kh",
        ["._ab9kSP2kh{grid-template-areas:none;}"],
        1,
        0,
        1,
        [("value", "kSP2kh", "val\\0b9\\0& | \\0grid-template-areas:none")],
      ),
      (
        "_ab9nhgVF3",
        ["._ab9nhgVF3{grid-template-areas:\"articles\";}"],
        1,
        0,
        1,
        [
          (
            "value",
            "nhgVF3",
            "val\\0b9\\0& | \\0grid-template-areas:\"articles\"",
          ),
        ],
      ),
      (
        "_ab9ju7D3F",
        ["._ab9ju7D3F{grid-template-areas:\"head head\";}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ju7D3F",
            "val\\0b9\\0& | \\0grid-template-areas:\"head head\"",
          ),
        ],
      ),
      (
        "_ab9BNSifR",
        [
          "._ab9BNSifR{grid-template-areas:\"head head\" \"nav main\" \"foot ....\";}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "BNSifR",
            "val\\0b9\\0& | \\0grid-template-areas:\"head head\" \"nav main\" \"foot ....\"",
          ),
        ],
      ),
      (
        "_ab8b8mmBI",
        ["._ab8b8mmBI{grid-template:none;}"],
        1,
        0,
        3,
        [("value", "b8mmBI", "val\\0b8\\0& | \\0grid-template:none")],
      ),
      (
        "_ab8jMme63",
        ["._ab8jMme63{grid-template:auto 1fr auto / auto 1fr;}"],
        1,
        0,
        3,
        [
          (
            "value",
            "jMme63",
            "val\\0b8\\0& | \\0grid-template:auto 1fr auto / auto 1fr",
          ),
        ],
      ),
      (
        "_ab8kWUpac",
        [
          "._ab8kWUpac{grid-template:[header-top] \"a   a   a\" [header-bottom] [main-top] \"b   b   b\" 1fr [main-bottom] / auto 1fr auto;}",
        ],
        1,
        0,
        3,
        [
          (
            "value",
            "kWUpac",
            "val\\0b8\\0& | \\0grid-template:[header-top] \"a   a   a\" [header-bottom] [main-top] \"b   b   b\" 1fr [main-bottom] / auto 1fr auto",
          ),
        ],
      ),
      (
        "_aazdvgkP8",
        ["._aazdvgkP8{grid-auto-columns:auto;}"],
        1,
        0,
        1,
        [("value", "dvgkP8", "val\\0az\\0& | \\0grid-auto-columns:auto")],
      ),
      (
        "_aazZjSFxU",
        ["._aazZjSFxU{grid-auto-columns:1fr;}"],
        1,
        0,
        1,
        [("value", "ZjSFxU", "val\\0az\\0& | \\0grid-auto-columns:1fr")],
      ),
      (
        "_aazjmWC9g",
        ["._aazjmWC9g{grid-auto-columns:100px;}"],
        1,
        0,
        1,
        [("value", "jmWC9g", "val\\0az\\0& | \\0grid-auto-columns:100px")],
      ),
      (
        "_aazNo1PHo",
        ["._aazNo1PHo{grid-auto-columns:max-content;}"],
        1,
        0,
        1,
        [
          ("value", "No1PHo", "val\\0az\\0& | \\0grid-auto-columns:max-content"),
        ],
      ),
      (
        "_aazoGPuaf",
        ["._aazoGPuaf{grid-auto-columns:minmax(min-content, 1fr);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "oGPuaf",
            "val\\0az\\0& | \\0grid-auto-columns:minmax(min-content, 1fr)",
          ),
        ],
      ),
      (
        "_aazbW9SuF",
        ["._aazbW9SuF{grid-auto-columns:min-content max-content auto;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "bW9SuF",
            "val\\0az\\0& | \\0grid-auto-columns:min-content max-content auto",
          ),
        ],
      ),
      (
        "_aaz9To53Z",
        ["._aaz9To53Z{grid-auto-columns:100px 150px 390px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "9To53Z",
            "val\\0az\\0& | \\0grid-auto-columns:100px 150px 390px",
          ),
        ],
      ),
      (
        "_aazoW85Rq",
        [
          "._aazoW85Rq{grid-auto-columns:100px minmax(100px, auto) 10% 0.5fr fit-content(400px);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "oW85Rq",
            "val\\0az\\0& | \\0grid-auto-columns:100px minmax(100px, auto) 10% 0.5fr fit-content(400px)",
          ),
        ],
      ),
      (
        "_ab18vdwcj",
        ["._ab18vdwcj{grid-auto-rows:auto;}"],
        1,
        0,
        1,
        [("value", "8vdwcj", "val\\0b1\\0& | \\0grid-auto-rows:auto")],
      ),
      (
        "_ab1D-X9Fe",
        ["._ab1D-X9Fe{grid-auto-rows:1fr;}"],
        1,
        0,
        1,
        [("value", "D-X9Fe", "val\\0b1\\0& | \\0grid-auto-rows:1fr")],
      ),
      (
        "_ab1mp3RGU",
        ["._ab1mp3RGU{grid-auto-rows:100px;}"],
        1,
        0,
        1,
        [("value", "mp3RGU", "val\\0b1\\0& | \\0grid-auto-rows:100px")],
      ),
      (
        "_ab1iSz4Z8",
        ["._ab1iSz4Z8{grid-auto-rows:100px 30%;}"],
        1,
        0,
        1,
        [("value", "iSz4Z8", "val\\0b1\\0& | \\0grid-auto-rows:100px 30%")],
      ),
      (
        "_ab1NhJ62U",
        ["._ab1NhJ62U{grid-auto-rows:100px 30% 1em;}"],
        1,
        0,
        1,
        [
          ("value", "NhJ62U", "val\\0b1\\0& | \\0grid-auto-rows:100px 30% 1em"),
        ],
      ),
      (
        "_ab1F3bCFE",
        ["._ab1F3bCFE{grid-auto-rows:min-content;}"],
        1,
        0,
        1,
        [("value", "F3bCFE", "val\\0b1\\0& | \\0grid-auto-rows:min-content")],
      ),
      (
        "_ab18HOT3U",
        ["._ab18HOT3U{grid-auto-rows:minmax(min-content, 1fr);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "8HOT3U",
            "val\\0b1\\0& | \\0grid-auto-rows:minmax(min-content, 1fr)",
          ),
        ],
      ),
      (
        "_ab1EGP5pN",
        ["._ab1EGP5pN{grid-auto-rows:min-content max-content auto;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "EGP5pN",
            "val\\0b1\\0& | \\0grid-auto-rows:min-content max-content auto",
          ),
        ],
      ),
      (
        "_ab1FEcLEf",
        [
          "._ab1FEcLEf{grid-auto-rows:100px minmax(100px, auto) 10% 0.5fr fit-content(400px);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "FEcLEf",
            "val\\0b1\\0& | \\0grid-auto-rows:100px minmax(100px, auto) 10% 0.5fr fit-content(400px)",
          ),
        ],
      ),
      (
        "_ab0kCWt_W",
        ["._ab0kCWt_W{grid-auto-flow:row;}"],
        1,
        0,
        1,
        [("value", "kCWt_W", "val\\0b0\\0& | \\0grid-auto-flow:row")],
      ),
      (
        "_ab0kYrWw4",
        ["._ab0kYrWw4{grid-auto-flow:column;}"],
        1,
        0,
        1,
        [("value", "kYrWw4", "val\\0b0\\0& | \\0grid-auto-flow:column")],
      ),
      (
        "_ab02MJSYV",
        ["._ab02MJSYV{grid-auto-flow:row dense;}"],
        1,
        0,
        1,
        [("value", "2MJSYV", "val\\0b0\\0& | \\0grid-auto-flow:row dense")],
      ),
      (
        "_ab0daaJEm",
        ["._ab0daaJEm{grid-auto-flow:column dense;}"],
        1,
        0,
        1,
        [("value", "daaJEm", "val\\0b0\\0& | \\0grid-auto-flow:column dense")],
      ),
      (
        "_aaxLpK8uK",
        ["._aaxLpK8uK{grid:auto-flow 1fr / 100px;}"],
        1,
        0,
        6,
        [("value", "LpK8uK", "val\\0ax\\0& | \\0grid:auto-flow 1fr / 100px")],
      ),
      (
        "_aax79ZB1D",
        ["._aax79ZB1D{grid:none / auto-flow 1fr;}"],
        1,
        0,
        6,
        [("value", "79ZB1D", "val\\0ax\\0& | \\0grid:none / auto-flow 1fr")],
      ),
      (
        "_aaxLu22Y3",
        ["._aaxLu22Y3{grid:auto-flow / auto 1fr;}"],
        1,
        0,
        6,
        [("value", "Lu22Y3", "val\\0ax\\0& | \\0grid:auto-flow / auto 1fr")],
      ),
      (
        "_aaxV0_0pz",
        ["._aaxV0_0pz{grid:repeat(auto-fill, 5em) / auto-flow 1fr;}"],
        1,
        0,
        6,
        [
          (
            "value",
            "V0_0pz",
            "val\\0ax\\0& | \\0grid:repeat(auto-fill, 5em) / auto-flow 1fr",
          ),
        ],
      ),
      (
        "_aaxvMACgR",
        ["._aaxvMACgR{grid:auto-flow 1fr / repeat(auto-fill, 5em);}"],
        1,
        0,
        6,
        [
          (
            "value",
            "vMACgR",
            "val\\0ax\\0& | \\0grid:auto-flow 1fr / repeat(auto-fill, 5em)",
          ),
        ],
      ),
      (
        "_aaxenbpuD",
        [
          "._aaxenbpuD{grid:\"H    H \" \"A    B \" \"F    F \" 30px / auto 1fr;}",
        ],
        1,
        0,
        6,
        [
          (
            "value",
            "enbpuD",
            "val\\0ax\\0& | \\0grid:\"H    H \" \"A    B \" \"F    F \" 30px / auto 1fr",
          ),
        ],
      ),
      (
        "_ab72MDNxC",
        ["._ab72MDNxC{grid-row-start:auto;}"],
        1,
        0,
        1,
        [("value", "2MDNxC", "val\\0b7\\0& | \\0grid-row-start:auto")],
      ),
      (
        "_ab75OY6lk",
        ["._ab75OY6lk{grid-row-start:4;}"],
        1,
        0,
        1,
        [("value", "5OY6lk", "val\\0b7\\0& | \\0grid-row-start:4")],
      ),
      (
        "_ab7CHCCzL",
        ["._ab7CHCCzL{grid-row-start:C;}"],
        1,
        0,
        1,
        [("value", "CHCCzL", "val\\0b7\\0& | \\0grid-row-start:C")],
      ),
      (
        "_ab76ZejpB",
        ["._ab76ZejpB{grid-row-start:C 2;}"],
        1,
        0,
        1,
        [("value", "6ZejpB", "val\\0b7\\0& | \\0grid-row-start:C 2")],
      ),
      (
        "_ab74ZvGrC",
        ["._ab74ZvGrC{grid-row-start:span C;}"],
        1,
        0,
        1,
        [("value", "4ZvGrC", "val\\0b7\\0& | \\0grid-row-start:span C")],
      ),
      (
        "_ab7KigTZm",
        ["._ab7KigTZm{grid-row-start:span 1;}"],
        1,
        0,
        1,
        [("value", "KigTZm", "val\\0b7\\0& | \\0grid-row-start:span 1")],
      ),
      (
        "_ab4g5IuZ2",
        ["._ab4g5IuZ2{grid-column-start:auto;}"],
        1,
        0,
        1,
        [("value", "g5IuZ2", "val\\0b4\\0& | \\0grid-column-start:auto")],
      ),
      (
        "_ab4HtXFAm",
        ["._ab4HtXFAm{grid-column-start:4;}"],
        1,
        0,
        1,
        [("value", "HtXFAm", "val\\0b4\\0& | \\0grid-column-start:4")],
      ),
      (
        "_ab4WUIZWR",
        ["._ab4WUIZWR{grid-column-start:C;}"],
        1,
        0,
        1,
        [("value", "WUIZWR", "val\\0b4\\0& | \\0grid-column-start:C")],
      ),
      (
        "_ab4nnxpcg",
        ["._ab4nnxpcg{grid-column-start:C 2;}"],
        1,
        0,
        1,
        [("value", "nnxpcg", "val\\0b4\\0& | \\0grid-column-start:C 2")],
      ),
      (
        "_ab4lIyH5h",
        ["._ab4lIyH5h{grid-column-start:span C;}"],
        1,
        0,
        1,
        [("value", "lIyH5h", "val\\0b4\\0& | \\0grid-column-start:span C")],
      ),
      (
        "_ab4FWWDvp",
        ["._ab4FWWDvp{grid-column-start:span 1;}"],
        1,
        0,
        1,
        [("value", "FWWDvp", "val\\0b4\\0& | \\0grid-column-start:span 1")],
      ),
      (
        "_ab6M_eL-2",
        ["._ab6M_eL-2{grid-row-end:auto;}"],
        1,
        0,
        1,
        [("value", "M_eL-2", "val\\0b6\\0& | \\0grid-row-end:auto")],
      ),
      (
        "_ab6DmTzos",
        ["._ab6DmTzos{grid-row-end:4;}"],
        1,
        0,
        1,
        [("value", "DmTzos", "val\\0b6\\0& | \\0grid-row-end:4")],
      ),
      (
        "_ab61g4a_v",
        ["._ab61g4a_v{grid-row-end:C;}"],
        1,
        0,
        1,
        [("value", "1g4a_v", "val\\0b6\\0& | \\0grid-row-end:C")],
      ),
      (
        "_ab6vmbkuF",
        ["._ab6vmbkuF{grid-row-end:C 2;}"],
        1,
        0,
        1,
        [("value", "vmbkuF", "val\\0b6\\0& | \\0grid-row-end:C 2")],
      ),
      (
        "_ab6kNCQr8",
        ["._ab6kNCQr8{grid-row-end:span C;}"],
        1,
        0,
        1,
        [("value", "kNCQr8", "val\\0b6\\0& | \\0grid-row-end:span C")],
      ),
      (
        "_ab6BXn_l0",
        ["._ab6BXn_l0{grid-row-end:span 1;}"],
        1,
        0,
        1,
        [("value", "BXn_l0", "val\\0b6\\0& | \\0grid-row-end:span 1")],
      ),
      (
        "_ab3t0EffG",
        ["._ab3t0EffG{grid-column-end:auto;}"],
        1,
        0,
        1,
        [("value", "t0EffG", "val\\0b3\\0& | \\0grid-column-end:auto")],
      ),
      (
        "_ab3tTmROP",
        ["._ab3tTmROP{grid-column-end:4;}"],
        1,
        0,
        1,
        [("value", "tTmROP", "val\\0b3\\0& | \\0grid-column-end:4")],
      ),
      (
        "_ab3IFnqS1",
        ["._ab3IFnqS1{grid-column-end:C;}"],
        1,
        0,
        1,
        [("value", "IFnqS1", "val\\0b3\\0& | \\0grid-column-end:C")],
      ),
      (
        "_ab3dL19o8",
        ["._ab3dL19o8{grid-column-end:C 2;}"],
        1,
        0,
        1,
        [("value", "dL19o8", "val\\0b3\\0& | \\0grid-column-end:C 2")],
      ),
      (
        "_ab3Hb0mEX",
        ["._ab3Hb0mEX{grid-column-end:span C;}"],
        1,
        0,
        1,
        [("value", "Hb0mEX", "val\\0b3\\0& | \\0grid-column-end:span C")],
      ),
      (
        "_ab3aKPcDI",
        ["._ab3aKPcDI{grid-column-end:span 1;}"],
        1,
        0,
        1,
        [("value", "aKPcDI", "val\\0b3\\0& | \\0grid-column-end:span 1")],
      ),
      (
        "_ab2U6Dv8S",
        ["._ab2U6Dv8S{-ms-grid-column:auto;grid-column:auto;}"],
        1,
        0,
        2,
        [("value", "U6Dv8S", "val\\0b2\\0& | \\0grid-column:auto")],
      ),
      (
        "_ab2TjBmxg",
        ["._ab2TjBmxg{-ms-grid-column:1;grid-column:1;}"],
        1,
        0,
        2,
        [("value", "TjBmxg", "val\\0b2\\0& | \\0grid-column:1")],
      ),
      (
        "_ab2TahFIr",
        ["._ab2TahFIr{-ms-grid-column:-1;grid-column:-1;}"],
        1,
        0,
        2,
        [("value", "TahFIr", "val\\0b2\\0& | \\0grid-column:-1")],
      ),
      (
        "_ab2hDaQ_Y",
        ["._ab2hDaQ_Y{-ms-grid-column:1 / 1;grid-column:1 / 1;}"],
        1,
        0,
        2,
        [("value", "hDaQ_Y", "val\\0b2\\0& | \\0grid-column:1 / 1")],
      ),
      (
        "_ab2B27ObW",
        ["._ab2B27ObW{-ms-grid-column:1 / -1;grid-column:1 / -1;}"],
        1,
        0,
        2,
        [("value", "B27ObW", "val\\0b2\\0& | \\0grid-column:1 / -1")],
      ),
      (
        "_ab2nFEbAh",
        ["._ab2nFEbAh{-ms-grid-column:auto / auto;grid-column:auto / auto;}"],
        1,
        0,
        2,
        [("value", "nFEbAh", "val\\0b2\\0& | \\0grid-column:auto / auto")],
      ),
      (
        "_ab2bdizXI",
        ["._ab2bdizXI{-ms-grid-column:2 / span 2;grid-column:2 / span 2;}"],
        1,
        0,
        2,
        [("value", "bdizXI", "val\\0b2\\0& | \\0grid-column:2 / span 2")],
      ),
      (
        "_ab58GCpE8",
        ["._ab58GCpE8{-ms-grid-row:auto;grid-row:auto;}"],
        1,
        0,
        2,
        [("value", "8GCpE8", "val\\0b5\\0& | \\0grid-row:auto")],
      ),
      (
        "_ab5AImMf_",
        ["._ab5AImMf_{-ms-grid-row:1;grid-row:1;}"],
        1,
        0,
        2,
        [("value", "AImMf_", "val\\0b5\\0& | \\0grid-row:1")],
      ),
      (
        "_ab5XVWGfa",
        ["._ab5XVWGfa{-ms-grid-row:-1;grid-row:-1;}"],
        1,
        0,
        2,
        [("value", "XVWGfa", "val\\0b5\\0& | \\0grid-row:-1")],
      ),
      (
        "_ab5s80Zm6",
        ["._ab5s80Zm6{-ms-grid-row:1 / 1;grid-row:1 / 1;}"],
        1,
        0,
        2,
        [("value", "s80Zm6", "val\\0b5\\0& | \\0grid-row:1 / 1")],
      ),
      (
        "_ab5csbfDJ",
        ["._ab5csbfDJ{-ms-grid-row:1 / -1;grid-row:1 / -1;}"],
        1,
        0,
        2,
        [("value", "csbfDJ", "val\\0b5\\0& | \\0grid-row:1 / -1")],
      ),
      (
        "_ab5oKOgAr",
        ["._ab5oKOgAr{-ms-grid-row:auto / auto;grid-row:auto / auto;}"],
        1,
        0,
        2,
        [("value", "oKOgAr", "val\\0b5\\0& | \\0grid-row:auto / auto")],
      ),
      (
        "_ab5PGAgKP",
        ["._ab5PGAgKP{-ms-grid-row:2 / span 2;grid-row:2 / span 2;}"],
        1,
        0,
        2,
        [("value", "PGAgKP", "val\\0b5\\0& | \\0grid-row:2 / span 2")],
      ),
      (
        "_aay7IEstv",
        ["._aay7IEstv{grid-area:1 / 1;}"],
        1,
        0,
        4,
        [("value", "7IEstv", "val\\0ay\\0& | \\0grid-area:1 / 1")],
      ),
      (
        "_aayBWwN5u",
        ["._aayBWwN5u{grid-area:var(--area-9owtnd);}"],
        1,
        0,
        4,
        [("value", "BWwN5u", "val\\0ay\\0& | \\0grid-area:$(area)")],
      ),
      (
        "_aaypoizH4",
        ["._aaypoizH4{grid-area:1 / span 1;}"],
        1,
        0,
        4,
        [("value", "poizH4", "val\\0ay\\0& | \\0grid-area:1 / span 1")],
      ),
      (
        "_aayL_h_Fx",
        ["._aayL_h_Fx{grid-area:span 1 / 10 / -1;}"],
        1,
        0,
        4,
        [("value", "L_h_Fx", "val\\0ay\\0& | \\0grid-area:span 1 / 10 / -1")],
      ),
      (
        "_a7nC_V2uj",
        ["._a7nC_V2uj{grid-column-gap:0;}"],
        1,
        0,
        1,
        [("value", "C_V2uj", "val\\07n\\0& | \\0grid-column-gap:0")],
      ),
      (
        "_a7n-SOkZS",
        ["._a7n-SOkZS{grid-column-gap:1em;}"],
        1,
        0,
        1,
        [("value", "-SOkZS", "val\\07n\\0& | \\0grid-column-gap:1em")],
      ),
      (
        "_ah8FkFegP",
        ["._ah8FkFegP{grid-row-gap:0;}"],
        1,
        0,
        1,
        [("value", "FkFegP", "val\\0h8\\0& | \\0grid-row-gap:0")],
      ),
      (
        "_ah8_wKmsh",
        ["._ah8_wKmsh{grid-row-gap:1em;}"],
        1,
        0,
        1,
        [("value", "_wKmsh", "val\\0h8\\0& | \\0grid-row-gap:1em")],
      ),
      (
        "_aauLz_va6",
        ["._aauLz_va6{grid-gap:0 0;}"],
        1,
        0,
        2,
        [("value", "Lz_va6", "val\\0au\\0& | \\0grid-gap:0 0")],
      ),
      (
        "_aaupzMUXT",
        ["._aaupzMUXT{grid-gap:0 1em;}"],
        1,
        0,
        2,
        [("value", "pzMUXT", "val\\0au\\0& | \\0grid-gap:0 1em")],
      ),
      (
        "_aauQurZrF",
        ["._aauQurZrF{grid-gap:1em;}"],
        1,
        0,
        2,
        [("value", "QurZrF", "val\\0au\\0& | \\0grid-gap:1em")],
      ),
      (
        "_aauByO9hG",
        ["._aauByO9hG{grid-gap:1em 1em;}"],
        1,
        0,
        2,
        [("value", "ByO9hG", "val\\0au\\0& | \\0grid-gap:1em 1em")],
      ),
      (
        "_aba1G71Il",
        ["._aba1G71Il{grid-template-columns:subgrid;}"],
        1,
        0,
        1,
        [
          ("value", "1G71Il", "val\\0ba\\0& | \\0grid-template-columns:subgrid"),
        ],
      ),
      (
        "_abaxCtXFE",
        ["._abaxCtXFE{grid-template-columns:subgrid [sub-a];}"],
        1,
        0,
        1,
        [
          (
            "value",
            "xCtXFE",
            "val\\0ba\\0& | \\0grid-template-columns:subgrid [sub-a]",
          ),
        ],
      ),
      (
        "_abaIuL-YE",
        ["._abaIuL-YE{grid-template-columns:subgrid [sub-a] [sub-b];}"],
        1,
        0,
        1,
        [
          (
            "value",
            "IuL-YE",
            "val\\0ba\\0& | \\0grid-template-columns:subgrid [sub-a] [sub-b]",
          ),
        ],
      ),
      (
        "_abaGvInGq",
        ["._abaGvInGq{grid-template-columns:subgrid repeat(1, [sub-a]);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "GvInGq",
            "val\\0ba\\0& | \\0grid-template-columns:subgrid repeat(1, [sub-a])",
          ),
        ],
      ),
      (
        "_abaZRU5X-",
        [
          "._abaZRU5X-{grid-template-columns:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "ZRU5X-",
            "val\\0ba\\0& | \\0grid-template-columns:subgrid repeat(2, [sub-a] [sub-b]) [sub-c]",
          ),
        ],
      ),
      (
        "_aba4PnKd1",
        [
          "._aba4PnKd1{grid-template-columns:subgrid repeat(auto-fill, [sub-a] [sub-b]);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "4PnKd1",
            "val\\0ba\\0& | \\0grid-template-columns:subgrid repeat(auto-fill, [sub-a] [sub-b])",
          ),
        ],
      ),
      (
        "_aba0Jk0uu",
        [
          "._aba0Jk0uu{grid-template-columns:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g]);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "0Jk0uu",
            "val\\0ba\\0& | \\0grid-template-columns:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g])",
          ),
        ],
      ),
      (
        "_abbS9U4IO",
        ["._abbS9U4IO{grid-template-rows:subgrid;}"],
        1,
        0,
        1,
        [("value", "S9U4IO", "val\\0bb\\0& | \\0grid-template-rows:subgrid")],
      ),
      (
        "_abbP4PncB",
        ["._abbP4PncB{grid-template-rows:subgrid [sub-a];}"],
        1,
        0,
        1,
        [
          (
            "value",
            "P4PncB",
            "val\\0bb\\0& | \\0grid-template-rows:subgrid [sub-a]",
          ),
        ],
      ),
      (
        "_abb0kzN-H",
        ["._abb0kzN-H{grid-template-rows:subgrid [sub-a] [sub-b];}"],
        1,
        0,
        1,
        [
          (
            "value",
            "0kzN-H",
            "val\\0bb\\0& | \\0grid-template-rows:subgrid [sub-a] [sub-b]",
          ),
        ],
      ),
      (
        "_abb7WQCER",
        ["._abb7WQCER{grid-template-rows:subgrid repeat(1, [sub-a]);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "7WQCER",
            "val\\0bb\\0& | \\0grid-template-rows:subgrid repeat(1, [sub-a])",
          ),
        ],
      ),
      (
        "_abbqdfJaj",
        [
          "._abbqdfJaj{grid-template-rows:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "qdfJaj",
            "val\\0bb\\0& | \\0grid-template-rows:subgrid repeat(2, [sub-a] [sub-b]) [sub-c]",
          ),
        ],
      ),
      (
        "_abbrVT8EH",
        [
          "._abbrVT8EH{grid-template-rows:subgrid repeat(auto-fill, [sub-a] [sub-b]);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "rVT8EH",
            "val\\0bb\\0& | \\0grid-template-rows:subgrid repeat(auto-fill, [sub-a] [sub-b])",
          ),
        ],
      ),
      (
        "_abb8ZybJF",
        [
          "._abb8ZybJF{grid-template-rows:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g]);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "8ZybJF",
            "val\\0bb\\0& | \\0grid-template-rows:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g])",
          ),
        ],
      ),
      (
        "_abaQUU6u2",
        ["._abaQUU6u2{grid-template-columns:masonry;}"],
        1,
        0,
        1,
        [
          ("value", "QUU6u2", "val\\0ba\\0& | \\0grid-template-columns:masonry"),
        ],
      ),
      (
        "_abb4EaZS6",
        ["._abb4EaZS6{grid-template-rows:masonry;}"],
        1,
        0,
        1,
        [("value", "4EaZS6", "val\\0bb\\0& | \\0grid-template-rows:masonry")],
      ),
      (
        "_adrtBFMNu",
        ["._adrtBFMNu{masonry-auto-flow:pack;}"],
        1,
        0,
        1,
        [("value", "tBFMNu", "val\\0dr\\0& | \\0masonry-auto-flow:pack")],
      ),
      (
        "_adrX5r4ev",
        ["._adrX5r4ev{masonry-auto-flow:next;}"],
        1,
        0,
        1,
        [("value", "X5r4ev", "val\\0dr\\0& | \\0masonry-auto-flow:next")],
      ),
      (
        "_adr1WqsID",
        ["._adr1WqsID{masonry-auto-flow:definite-first;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "1WqsID",
            "val\\0dr\\0& | \\0masonry-auto-flow:definite-first",
          ),
        ],
      ),
      (
        "_adrQnPjF1",
        ["._adrQnPjF1{masonry-auto-flow:ordered;}"],
        1,
        0,
        1,
        [("value", "QnPjF1", "val\\0dr\\0& | \\0masonry-auto-flow:ordered")],
      ),
      (
        "_adrTqbMaM",
        ["._adrTqbMaM{masonry-auto-flow:pack definite-first;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "TqbMaM",
            "val\\0dr\\0& | \\0masonry-auto-flow:pack definite-first",
          ),
        ],
      ),
      (
        "_adr63F7MX",
        ["._adr63F7MX{masonry-auto-flow:pack ordered;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "63F7MX",
            "val\\0dr\\0& | \\0masonry-auto-flow:pack ordered",
          ),
        ],
      ),
      (
        "_adrDTUsZP",
        ["._adrDTUsZP{masonry-auto-flow:next definite-first;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "DTUsZP",
            "val\\0dr\\0& | \\0masonry-auto-flow:next definite-first",
          ),
        ],
      ),
      (
        "_adru9-BbM",
        ["._adru9-BbM{masonry-auto-flow:next ordered;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "u9-BbM",
            "val\\0dr\\0& | \\0masonry-auto-flow:next ordered",
          ),
        ],
      ),
      (
        "_adrFybqSx",
        ["._adrFybqSx{masonry-auto-flow:ordered pack;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "FybqSx",
            "val\\0dr\\0& | \\0masonry-auto-flow:ordered pack",
          ),
        ],
      ),
    ]
  ];
  
  CSS.make("_a9fDR52Mo", []);
  CSS.make("_a9fqjWCi3", []);
  CSS.make("_abaO44VC9", []);
  CSS.make("_abaG9aghl", []);
  CSS.make("_abao2QnbJ", []);
  CSS.make("_abaouX8uo", []);
  CSS.make("_abasInBnJ", []);
  CSS.make("_abafJnnMp", []);
  CSS.make("_abafyySQA", []);
  CSS.make("_abambGLMx", []);
  CSS.make("_abaOmBL5y", []);
  CSS.make("_abaT76gzk", []);
  CSS.make("_abarJxARq", []);
  CSS.make("_abarkotWx", []);
  CSS.make("_abauTJ_z3", []);
  CSS.make("_abatNXhki", []);
  CSS.make("_abauNCOpf", []);
  CSS.make("_abazMANkv", []);
  
  CSS.make("_abaArMjdj", []);
  let value =
    CSS.tracks([|
      CSS.repeatFn(
        CSS.numInt(4),
        [|
          CSS.pxFloat(10.),
          CSS.lineNames({js|[col-start]|js}),
          CSS.pxFloat(250.),
          CSS.lineNames({js|[col-end]|js}),
        |],
      ),
      CSS.pxFloat(10.),
    |]);
  CSS.make(
    "_abaUPAffp",
    [("--value-97csfh", CSS.Types.GridTemplateColumns.toString(value))],
  );
  CSS.make("_abbaCkPKZ", []);
  CSS.make("_abbcLizeV", []);
  CSS.make("_abbbXzsGe", []);
  CSS.make("_abbD-M7pD", []);
  CSS.make("_abbyZ5X2V", []);
  CSS.make("_abbXYIIRD", []);
  CSS.make("_abbEkl-LL", []);
  CSS.make("_abb1MVPEb", []);
  CSS.make("_abbL5Gios", []);
  CSS.make("_ab9kSP2kh", []);
  CSS.make("_ab9nhgVF3", []);
  CSS.make("_ab9ju7D3F", []);
  CSS.make("_ab9BNSifR", []);
  CSS.make("_ab8b8mmBI", []);
  CSS.make("_ab8jMme63", []);
  CSS.make("_ab8kWUpac", []);
  CSS.make("_aazdvgkP8", []);
  CSS.make("_aazZjSFxU", []);
  CSS.make("_aazjmWC9g", []);
  CSS.make("_aazNo1PHo", []);
  CSS.make("_aazoGPuaf", []);
  CSS.make("_aazbW9SuF", []);
  CSS.make("_aaz9To53Z", []);
  CSS.make("_aazoW85Rq", []);
  CSS.make("_ab18vdwcj", []);
  CSS.make("_ab1D-X9Fe", []);
  CSS.make("_ab1mp3RGU", []);
  CSS.make("_ab1iSz4Z8", []);
  CSS.make("_ab1NhJ62U", []);
  CSS.make("_ab1F3bCFE", []);
  CSS.make("_ab18HOT3U", []);
  CSS.make("_ab1EGP5pN", []);
  CSS.make("_ab1FEcLEf", []);
  CSS.make("_ab0kCWt_W", []);
  CSS.make("_ab0kYrWw4", []);
  CSS.make("_ab02MJSYV", []);
  CSS.make("_ab0daaJEm", []);
  CSS.make("_aaxLpK8uK", []);
  CSS.make("_aax79ZB1D", []);
  CSS.make("_aaxLu22Y3", []);
  CSS.make("_aaxV0_0pz", []);
  CSS.make("_aaxvMACgR", []);
  CSS.make("_aaxenbpuD", []);
  CSS.make("_ab72MDNxC", []);
  CSS.make("_ab75OY6lk", []);
  CSS.make("_ab7CHCCzL", []);
  CSS.make("_ab76ZejpB", []);
  CSS.make("_ab74ZvGrC", []);
  CSS.make("_ab7KigTZm", []);
  CSS.make("_ab4g5IuZ2", []);
  CSS.make("_ab4HtXFAm", []);
  CSS.make("_ab4WUIZWR", []);
  CSS.make("_ab4nnxpcg", []);
  CSS.make("_ab4lIyH5h", []);
  CSS.make("_ab4FWWDvp", []);
  CSS.make("_ab6M_eL-2", []);
  CSS.make("_ab6DmTzos", []);
  CSS.make("_ab61g4a_v", []);
  CSS.make("_ab6vmbkuF", []);
  CSS.make("_ab6kNCQr8", []);
  CSS.make("_ab6BXn_l0", []);
  CSS.make("_ab3t0EffG", []);
  CSS.make("_ab3tTmROP", []);
  CSS.make("_ab3IFnqS1", []);
  CSS.make("_ab3dL19o8", []);
  CSS.make("_ab3Hb0mEX", []);
  CSS.make("_ab3aKPcDI", []);
  CSS.make("_ab2U6Dv8S", []);
  CSS.make("_ab2TjBmxg", []);
  CSS.make("_ab2TahFIr", []);
  CSS.make("_ab2hDaQ_Y", []);
  CSS.make("_ab2B27ObW", []);
  CSS.make("_ab2nFEbAh", []);
  CSS.make("_ab2bdizXI", []);
  CSS.make("_ab58GCpE8", []);
  CSS.make("_ab5AImMf_", []);
  CSS.make("_ab5XVWGfa", []);
  CSS.make("_ab5s80Zm6", []);
  CSS.make("_ab5csbfDJ", []);
  CSS.make("_ab5oKOgAr", []);
  CSS.make("_ab5PGAgKP", []);
  CSS.make("_aay7IEstv", []);
  let area = `num(33);
  CSS.make(
    "_aayBWwN5u",
    [("--area-9owtnd", CSS.Types.GridArea.toString(area))],
  );
  CSS.make("_aaypoizH4", []);
  CSS.make("_aayL_h_Fx", []);
  CSS.make("_a7nC_V2uj", []);
  CSS.make("_a7n-SOkZS", []);
  CSS.make("_ah8FkFegP", []);
  CSS.make("_ah8_wKmsh", []);
  CSS.make("_aauLz_va6", []);
  CSS.make("_aaupzMUXT", []);
  CSS.make("_aauQurZrF", []);
  CSS.make("_aauByO9hG", []);
  
  CSS.make("_aba1G71Il", []);
  CSS.make("_abaxCtXFE", []);
  CSS.make("_abaIuL-YE", []);
  CSS.make("_abaGvInGq", []);
  CSS.make("_abaZRU5X-", []);
  CSS.make("_aba4PnKd1", []);
  CSS.make("_aba0Jk0uu", []);
  CSS.make("_abbS9U4IO", []);
  CSS.make("_abbP4PncB", []);
  CSS.make("_abb0kzN-H", []);
  CSS.make("_abb7WQCER", []);
  CSS.make("_abbqdfJaj", []);
  CSS.make("_abbrVT8EH", []);
  CSS.make("_abb8ZybJF", []);
  
  CSS.make("_abaQUU6u2", []);
  CSS.make("_abb4EaZS6", []);
  CSS.make("_adrtBFMNu", []);
  CSS.make("_adrX5r4ev", []);
  CSS.make("_adr1WqsID", []);
  CSS.make("_adrQnPjF1", []);
  CSS.make("_adrTqbMaM", []);
  CSS.make("_adr63F7MX", []);
  CSS.make("_adrDTUsZP", []);
  CSS.make("_adru9-BbM", []);
  CSS.make("_adrFybqSx", []);
