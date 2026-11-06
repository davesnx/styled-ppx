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
  [@css "@property --color-1exqilv_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1exqilv_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1exqilv_3{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_a9o-9b0g2",
        ["._a9o-9b0g2{-webkit-filter:none;filter:none;}"],
        1,
        0,
        1,
        [("value", "-9b0g2", "val\\09o\\0& | \\0filter:none")],
      ),
      (
        "_a9oqyDo6U",
        ["._a9oqyDo6U{-webkit-filter:url(\"#id\");filter:url(\"#id\");}"],
        1,
        0,
        1,
        [("value", "qyDo6U", "val\\09o\\0& | \\0filter:url(\"#id\")")],
      ),
      (
        "_a9okDCOp4",
        [
          "._a9okDCOp4{-webkit-filter:url(\"image.svg#id\");filter:url(\"image.svg#id\");}",
        ],
        1,
        0,
        1,
        [
          ("value", "kDCOp4", "val\\09o\\0& | \\0filter:url(\"image.svg#id\")"),
        ],
      ),
      (
        "_a9o90NpA_",
        ["._a9o90NpA_{-webkit-filter:blur(5px);filter:blur(5px);}"],
        1,
        0,
        1,
        [("value", "90NpA_", "val\\09o\\0& | \\0filter:blur(5px)")],
      ),
      (
        "_a9om4fsIi",
        ["._a9om4fsIi{-webkit-filter:brightness(0.5);filter:brightness(0.5);}"],
        1,
        0,
        1,
        [("value", "m4fsIi", "val\\09o\\0& | \\0filter:brightness(0.5)")],
      ),
      (
        "_a9o4icN1i",
        ["._a9o4icN1i{-webkit-filter:contrast(150%);filter:contrast(150%);}"],
        1,
        0,
        1,
        [("value", "4icN1i", "val\\09o\\0& | \\0filter:contrast(150%)")],
      ),
      (
        "_a9olGTs62",
        [
          "._a9olGTs62{-webkit-filter:drop-shadow(5px 5px 10px);filter:drop-shadow(5px 5px 10px);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "lGTs62",
            "val\\09o\\0& | \\0filter:drop-shadow(5px 5px 10px)",
          ),
        ],
      ),
      (
        "_a9ounbW5S",
        [
          "._a9ounbW5S{-webkit-filter:drop-shadow(15px 15px 15px #123);filter:drop-shadow(15px 15px 15px #123);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "unbW5S",
            "val\\09o\\0& | \\0filter:drop-shadow(15px 15px 15px #123)",
          ),
        ],
      ),
      (
        "_a9oSdJhDu",
        ["._a9oSdJhDu{-webkit-filter:grayscale(50%);filter:grayscale(50%);}"],
        1,
        0,
        1,
        [("value", "SdJhDu", "val\\09o\\0& | \\0filter:grayscale(50%)")],
      ),
      (
        "_a9oxCwJ0e",
        [
          "._a9oxCwJ0e{-webkit-filter:hue-rotate(50deg);filter:hue-rotate(50deg);}",
        ],
        1,
        0,
        1,
        [("value", "xCwJ0e", "val\\09o\\0& | \\0filter:hue-rotate(50deg)")],
      ),
      (
        "_a9obB8c-i",
        ["._a9obB8c-i{-webkit-filter:invert(50%);filter:invert(50%);}"],
        1,
        0,
        1,
        [("value", "bB8c-i", "val\\09o\\0& | \\0filter:invert(50%)")],
      ),
      (
        "_a9oHeeH3U",
        ["._a9oHeeH3U{-webkit-filter:opacity(50%);filter:opacity(50%);}"],
        1,
        0,
        1,
        [("value", "HeeH3U", "val\\09o\\0& | \\0filter:opacity(50%)")],
      ),
      (
        "_a9o9OxA2T",
        ["._a9o9OxA2T{-webkit-filter:sepia(50%);filter:sepia(50%);}"],
        1,
        0,
        1,
        [("value", "9OxA2T", "val\\09o\\0& | \\0filter:sepia(50%)")],
      ),
      (
        "_a9o0yzmdr",
        ["._a9o0yzmdr{-webkit-filter:saturate(150%);filter:saturate(150%);}"],
        1,
        0,
        1,
        [("value", "0yzmdr", "val\\09o\\0& | \\0filter:saturate(150%)")],
      ),
      (
        "_a9opoIfTu",
        [
          "._a9opoIfTu{-webkit-filter:grayscale(100%) sepia(100%);filter:grayscale(100%) sepia(100%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "poIfTu",
            "val\\09o\\0& | \\0filter:grayscale(100%) sepia(100%)",
          ),
        ],
      ),
      (
        "_a9o1Y1SEa",
        [
          "._a9o1Y1SEa{-webkit-filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "1Y1SEa",
            "val\\09o\\0& | \\0filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03))",
          ),
        ],
      ),
      (
        "_a9oEmJlxT",
        [
          "._a9oEmJlxT{-webkit-filter:drop-shadow(0 1px 0 var(--color-1exqilv_1)) drop-shadow(0 1px 0 var(--color-1exqilv_2)) drop-shadow(0 1px 0 var(--color-1exqilv_3)) drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075)) drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));filter:drop-shadow(0 1px 0 var(--color-1exqilv_1)) drop-shadow(0 1px 0 var(--color-1exqilv_2)) drop-shadow(0 1px 0 var(--color-1exqilv_3)) drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075)) drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "EmJlxT",
            "val\\09o\\0& | \\0filter:drop-shadow(0 1px 0 $(color)) drop-shadow(0 1px 0 $(color)) drop-shadow(0 1px 0 $(color)) drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075)) drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03))",
          ),
        ],
      ),
      (
        "_a4fdocGAO",
        ["._a4fdocGAO{-webkit-backdrop-filter:none;backdrop-filter:none;}"],
        1,
        0,
        1,
        [("value", "docGAO", "val\\04f\\0& | \\0backdrop-filter:none")],
      ),
      (
        "_a4fgrILIJ",
        [
          "._a4fgrILIJ{-webkit-backdrop-filter:url(\"#id\");backdrop-filter:url(\"#id\");}",
        ],
        1,
        0,
        1,
        [
          ("value", "grILIJ", "val\\04f\\0& | \\0backdrop-filter:url(\"#id\")"),
        ],
      ),
      (
        "_a4fDH6Toa",
        [
          "._a4fDH6Toa{-webkit-backdrop-filter:url(\"image.svg#id\");backdrop-filter:url(\"image.svg#id\");}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "DH6Toa",
            "val\\04f\\0& | \\0backdrop-filter:url(\"image.svg#id\")",
          ),
        ],
      ),
      (
        "_a4fz_JD24",
        [
          "._a4fz_JD24{-webkit-backdrop-filter:blur(5px);backdrop-filter:blur(5px);}",
        ],
        1,
        0,
        1,
        [("value", "z_JD24", "val\\04f\\0& | \\0backdrop-filter:blur(5px)")],
      ),
      (
        "_a4fuwZMDs",
        [
          "._a4fuwZMDs{-webkit-backdrop-filter:brightness(0.5);backdrop-filter:brightness(0.5);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "uwZMDs",
            "val\\04f\\0& | \\0backdrop-filter:brightness(0.5)",
          ),
        ],
      ),
      (
        "_a4fywyvr8",
        [
          "._a4fywyvr8{-webkit-backdrop-filter:contrast(150%);backdrop-filter:contrast(150%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "ywyvr8",
            "val\\04f\\0& | \\0backdrop-filter:contrast(150%)",
          ),
        ],
      ),
      (
        "_a4fTXQKCA",
        [
          "._a4fTXQKCA{-webkit-backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "TXQKCA",
            "val\\04f\\0& | \\0backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1))",
          ),
        ],
      ),
      (
        "_a4fpTWZ0R",
        [
          "._a4fpTWZ0R{-webkit-backdrop-filter:grayscale(50%);backdrop-filter:grayscale(50%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "pTWZ0R",
            "val\\04f\\0& | \\0backdrop-filter:grayscale(50%)",
          ),
        ],
      ),
      (
        "_a4fsM7a2I",
        [
          "._a4fsM7a2I{-webkit-backdrop-filter:hue-rotate(50deg);backdrop-filter:hue-rotate(50deg);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "sM7a2I",
            "val\\04f\\0& | \\0backdrop-filter:hue-rotate(50deg)",
          ),
        ],
      ),
      (
        "_a4fxYKqIb",
        [
          "._a4fxYKqIb{-webkit-backdrop-filter:invert(50%);backdrop-filter:invert(50%);}",
        ],
        1,
        0,
        1,
        [("value", "xYKqIb", "val\\04f\\0& | \\0backdrop-filter:invert(50%)")],
      ),
      (
        "_a4fa1zFM_",
        [
          "._a4fa1zFM_{-webkit-backdrop-filter:opacity(50%);backdrop-filter:opacity(50%);}",
        ],
        1,
        0,
        1,
        [
          ("value", "a1zFM_", "val\\04f\\0& | \\0backdrop-filter:opacity(50%)"),
        ],
      ),
      (
        "_a4f-tbpJU",
        [
          "._a4f-tbpJU{-webkit-backdrop-filter:sepia(50%);backdrop-filter:sepia(50%);}",
        ],
        1,
        0,
        1,
        [("value", "-tbpJU", "val\\04f\\0& | \\0backdrop-filter:sepia(50%)")],
      ),
      (
        "_a4fOBQdEG",
        [
          "._a4fOBQdEG{-webkit-backdrop-filter:saturate(150%);backdrop-filter:saturate(150%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "OBQdEG",
            "val\\04f\\0& | \\0backdrop-filter:saturate(150%)",
          ),
        ],
      ),
      (
        "_a4f3qG8yX",
        [
          "._a4f3qG8yX{-webkit-backdrop-filter:grayscale(100%) sepia(100%);backdrop-filter:grayscale(100%) sepia(100%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "3qG8yX",
            "val\\04f\\0& | \\0backdrop-filter:grayscale(100%) sepia(100%)",
          ),
        ],
      ),
    ]
  ];
  let color = CSS.hex("333");
  
  CSS.make("_a9o-9b0g2", []);
  CSS.make("_a9oqyDo6U", []);
  CSS.make("_a9okDCOp4", []);
  CSS.make("_a9o90NpA_", []);
  CSS.make("_a9om4fsIi", []);
  CSS.make("_a9o4icN1i", []);
  
  CSS.make("_a9olGTs62", []);
  
  CSS.make("_a9ounbW5S", []);
  CSS.make("_a9oSdJhDu", []);
  CSS.make("_a9oxCwJ0e", []);
  CSS.make("_a9obB8c-i", []);
  CSS.make("_a9oHeeH3U", []);
  CSS.make("_a9o9OxA2T", []);
  CSS.make("_a9o0yzmdr", []);
  CSS.make("_a9opoIfTu", []);
  CSS.make("_a9o1Y1SEa", []);
  CSS.make(
    "_a9oEmJlxT",
    [
      ("--color-1exqilv_1", CSS.Types.Color.toString(color)),
      ("--color-1exqilv_2", CSS.Types.Color.toString(color)),
      ("--color-1exqilv_3", CSS.Types.Color.toString(color)),
    ],
  );
  
  CSS.make("_a4fdocGAO", []);
  CSS.make("_a4fgrILIJ", []);
  CSS.make("_a4fDH6Toa", []);
  CSS.make("_a4fz_JD24", []);
  CSS.make("_a4fuwZMDs", []);
  CSS.make("_a4fywyvr8", []);
  CSS.make("_a4fTXQKCA", []);
  CSS.make("_a4fpTWZ0R", []);
  CSS.make("_a4fsM7a2I", []);
  CSS.make("_a4fxYKqIb", []);
  CSS.make("_a4fa1zFM_", []);
  CSS.make("_a4f-tbpJU", []);
  CSS.make("_a4fOBQdEG", []);
  CSS.make("_a4f3qG8yX", []);
