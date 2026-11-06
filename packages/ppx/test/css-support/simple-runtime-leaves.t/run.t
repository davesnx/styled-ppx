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
  [@css.atoms
    [
      (
        "_a9ivfV7Wf",
        ["._a9ivfV7Wf{empty-cells:show;}"],
        1,
        0,
        1,
        [("value", "vfV7Wf", "val\\09i\\0& | \\0empty-cells:show")],
      ),
      (
        "_a9iLAoXA3",
        ["._a9iLAoXA3{empty-cells:hide;}"],
        1,
        0,
        1,
        [("value", "LAoXA3", "val\\09i\\0& | \\0empty-cells:hide")],
      ),
      (
        "_a9kWfzMKt",
        ["._a9kWfzMKt{field-sizing:content;}"],
        1,
        0,
        1,
        [("value", "WfzMKt", "val\\09k\\0& | \\0field-sizing:content")],
      ),
      (
        "_a9kNUT4qd",
        ["._a9kNUT4qd{field-sizing:fixed;}"],
        1,
        0,
        1,
        [("value", "NUT4qd", "val\\09k\\0& | \\0field-sizing:fixed")],
      ),
      (
        "_ac5-oiy8A",
        ["._ac5-oiy8A{interpolate-size:numeric-only;}"],
        1,
        0,
        1,
        [
          ("value", "-oiy8A", "val\\0c5\\0& | \\0interpolate-size:numeric-only"),
        ],
      ),
      (
        "_ac5ClH0Uk",
        ["._ac5ClH0Uk{interpolate-size:allow-keywords;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ClH0Uk",
            "val\\0c5\\0& | \\0interpolate-size:allow-keywords",
          ),
        ],
      ),
      (
        "_abp0q3bl8",
        ["._abp0q3bl8{initial-letter:normal;}"],
        1,
        0,
        1,
        [("value", "0q3bl8", "val\\0bp\\0& | \\0initial-letter:normal")],
      ),
      (
        "_abpNedyd6",
        ["._abpNedyd6{initial-letter:1.5;}"],
        1,
        0,
        1,
        [("value", "Nedyd6", "val\\0bp\\0& | \\0initial-letter:1.5")],
      ),
      (
        "_abpMqaluW",
        ["._abpMqaluW{initial-letter:1.5 2;}"],
        1,
        0,
        1,
        [("value", "MqaluW", "val\\0bp\\0& | \\0initial-letter:1.5 2")],
      ),
      (
        "_abqiSzq2R",
        ["._abqiSzq2R{initial-letter-align:auto;}"],
        1,
        0,
        1,
        [("value", "iSzq2R", "val\\0bq\\0& | \\0initial-letter-align:auto")],
      ),
      (
        "_abqag6T0d",
        ["._abqag6T0d{initial-letter-align:alphabetic;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ag6T0d",
            "val\\0bq\\0& | \\0initial-letter-align:alphabetic",
          ),
        ],
      ),
      (
        "_abqaAUXCr",
        ["._abqaAUXCr{initial-letter-align:hanging;}"],
        1,
        0,
        1,
        [
          ("value", "aAUXCr", "val\\0bq\\0& | \\0initial-letter-align:hanging"),
        ],
      ),
      (
        "_abqWJhzUf",
        ["._abqWJhzUf{initial-letter-align:ideographic;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "WJhzUf",
            "val\\0bq\\0& | \\0initial-letter-align:ideographic",
          ),
        ],
      ),
      (
        "_abmnXNPJZ",
        ["._abmnXNPJZ{image-resolution:from-image;}"],
        1,
        0,
        1,
        [("value", "nXNPJZ", "val\\0bm\\0& | \\0image-resolution:from-image")],
      ),
      (
        "_abmulmCLe",
        ["._abmulmCLe{image-resolution:96dpi;}"],
        1,
        0,
        1,
        [("value", "ulmCLe", "val\\0bm\\0& | \\0image-resolution:96dpi")],
      ),
      (
        "_abmJzRCu8",
        ["._abmJzRCu8{image-resolution:2dppx;}"],
        1,
        0,
        1,
        [("value", "JzRCu8", "val\\0bm\\0& | \\0image-resolution:2dppx")],
      ),
      (
        "_abmJ3Ag9b",
        ["._abmJ3Ag9b{image-resolution:from-image snap;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "J3Ag9b",
            "val\\0bm\\0& | \\0image-resolution:from-image snap",
          ),
        ],
      ),
      (
        "_abmGiQLc9",
        ["._abmGiQLc9{image-resolution:96dpi snap;}"],
        1,
        0,
        1,
        [("value", "GiQLc9", "val\\0bm\\0& | \\0image-resolution:96dpi snap")],
      ),
    ]
  ];
  
  CSS.make("_a9ivfV7Wf", []);
  CSS.make("_a9iLAoXA3", []);
  CSS.make("_a9kWfzMKt", []);
  CSS.make("_a9kNUT4qd", []);
  CSS.make("_ac5-oiy8A", []);
  CSS.make("_ac5ClH0Uk", []);
  CSS.make("_abp0q3bl8", []);
  CSS.make("_abpNedyd6", []);
  CSS.make("_abpMqaluW", []);
  CSS.make("_abqiSzq2R", []);
  CSS.make("_abqag6T0d", []);
  CSS.make("_abqaAUXCr", []);
  CSS.make("_abqWJhzUf", []);
  CSS.make("_abmnXNPJZ", []);
  CSS.make("_abmulmCLe", []);
  CSS.make("_abmJzRCu8", []);
  CSS.make("_abmJ3Ag9b", []);
  CSS.make("_abmGiQLc9", []);
