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
        "_a7feiyQtc",
        ["._a7feiyQtc{color:hwb(0 0% 0%);}"],
        1,
        0,
        1,
        [("value", "eiyQtc", "val\\07f\\0& | \\0color:hwb(0 0% 0%)")],
      ),
      (
        "_a7fD4VDT2",
        ["._a7fD4VDT2{color:hwb(0 0% 0% / 0.5);}"],
        1,
        0,
        1,
        [("value", "D4VDT2", "val\\07f\\0& | \\0color:hwb(0 0% 0% / 0.5)")],
      ),
      (
        "_a7f3pkmUl",
        ["._a7f3pkmUl{color:hwb(120 30% 50%);}"],
        1,
        0,
        1,
        [("value", "3pkmUl", "val\\07f\\0& | \\0color:hwb(120 30% 50%)")],
      ),
      (
        "_a7fc_SJJi",
        ["._a7fc_SJJi{color:hwb(120 30% 50% / 0.8);}"],
        1,
        0,
        1,
        [
          ("value", "c_SJJi", "val\\07f\\0& | \\0color:hwb(120 30% 50% / 0.8)"),
        ],
      ),
      (
        "_a7frMDmzc",
        ["._a7frMDmzc{color:lab(0% 0 0);}"],
        1,
        0,
        1,
        [("value", "rMDmzc", "val\\07f\\0& | \\0color:lab(0% 0 0)")],
      ),
      (
        "_a7fru6-18",
        ["._a7fru6-18{color:lab(0% 0 0 / 0.5);}"],
        1,
        0,
        1,
        [("value", "ru6-18", "val\\07f\\0& | \\0color:lab(0% 0 0 / 0.5)")],
      ),
      (
        "_a7f9k2629",
        ["._a7f9k2629{color:lab(50% 20 -30);}"],
        1,
        0,
        1,
        [("value", "9k2629", "val\\07f\\0& | \\0color:lab(50% 20 -30)")],
      ),
      (
        "_a7fRgXEnj",
        ["._a7fRgXEnj{color:lab(50% 20 -30 / 0.8);}"],
        1,
        0,
        1,
        [("value", "RgXEnj", "val\\07f\\0& | \\0color:lab(50% 20 -30 / 0.8)")],
      ),
      (
        "_a7fhfE6bd",
        ["._a7fhfE6bd{color:lch(0% 0 0);}"],
        1,
        0,
        1,
        [("value", "hfE6bd", "val\\07f\\0& | \\0color:lch(0% 0 0)")],
      ),
      (
        "_a7f3lWKPV",
        ["._a7f3lWKPV{color:lch(0% 0 0 / 0.5);}"],
        1,
        0,
        1,
        [("value", "3lWKPV", "val\\07f\\0& | \\0color:lch(0% 0 0 / 0.5)")],
      ),
      (
        "_a7fGNMQ4c",
        ["._a7fGNMQ4c{color:lch(50% 30 120);}"],
        1,
        0,
        1,
        [("value", "GNMQ4c", "val\\07f\\0& | \\0color:lch(50% 30 120)")],
      ),
      (
        "_a7fCRd0cn",
        ["._a7fCRd0cn{color:lch(50% 30 120 / 0.8);}"],
        1,
        0,
        1,
        [("value", "CRd0cn", "val\\07f\\0& | \\0color:lch(50% 30 120 / 0.8)")],
      ),
      (
        "_a7fzXtrvk",
        ["._a7fzXtrvk{color:oklab(0% 0 0);}"],
        1,
        0,
        1,
        [("value", "zXtrvk", "val\\07f\\0& | \\0color:oklab(0% 0 0)")],
      ),
      (
        "_a7f6ql1vr",
        ["._a7f6ql1vr{color:oklab(0% 0 0 / 0.5);}"],
        1,
        0,
        1,
        [("value", "6ql1vr", "val\\07f\\0& | \\0color:oklab(0% 0 0 / 0.5)")],
      ),
      (
        "_a7fQb_z2d",
        ["._a7fQb_z2d{color:oklab(50% 0.1 -0.1);}"],
        1,
        0,
        1,
        [("value", "Qb_z2d", "val\\07f\\0& | \\0color:oklab(50% 0.1 -0.1)")],
      ),
      (
        "_a7fyiGIxZ",
        ["._a7fyiGIxZ{color:oklab(50% 0.1 -0.1 / 0.8);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "yiGIxZ",
            "val\\07f\\0& | \\0color:oklab(50% 0.1 -0.1 / 0.8)",
          ),
        ],
      ),
      (
        "_a7fzqjd7P",
        ["._a7fzqjd7P{color:oklch(0% 0 0);}"],
        1,
        0,
        1,
        [("value", "zqjd7P", "val\\07f\\0& | \\0color:oklch(0% 0 0)")],
      ),
      (
        "_a7fdYlX3h",
        ["._a7fdYlX3h{color:oklch(0% 0 0 / 0.5);}"],
        1,
        0,
        1,
        [("value", "dYlX3h", "val\\07f\\0& | \\0color:oklch(0% 0 0 / 0.5)")],
      ),
      (
        "_a7fueZIs8",
        ["._a7fueZIs8{color:oklch(50% 0.15 120);}"],
        1,
        0,
        1,
        [("value", "ueZIs8", "val\\07f\\0& | \\0color:oklch(50% 0.15 120)")],
      ),
      (
        "_a7fIfispg",
        ["._a7fIfispg{color:oklch(50% 0.15 120 / 0.8);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Ifispg",
            "val\\07f\\0& | \\0color:oklch(50% 0.15 120 / 0.8)",
          ),
        ],
      ),
      (
        "_a7f9e4SR3",
        ["._a7f9e4SR3{color:light-dark(white, black);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "9e4SR3",
            "val\\07f\\0& | \\0color:light-dark(white, black)",
          ),
        ],
      ),
      (
        "_a7f_7S24M",
        ["._a7f_7S24M{color:light-dark(#fff, #000);}"],
        1,
        0,
        1,
        [
          ("value", "_7S24M", "val\\07f\\0& | \\0color:light-dark(#fff, #000)"),
        ],
      ),
      (
        "_a7fHZGEeC",
        ["._a7fHZGEeC{color:light-dark(rgb(255, 255, 255), rgb(0, 0, 0));}"],
        1,
        0,
        1,
        [
          (
            "value",
            "HZGEeC",
            "val\\07f\\0& | \\0color:light-dark(rgb(255, 255, 255), rgb(0, 0, 0))",
          ),
        ],
      ),
      (
        "_a4ltMByri",
        ["._a4ltMByri{background-color:light-dark(#f0f0f0, #1a1a1a);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "tMByri",
            "val\\04l\\0& | \\0background-color:light-dark(#f0f0f0, #1a1a1a)",
          ),
        ],
      ),
      (
        "_a7fM6I1Aq",
        ["._a7fM6I1Aq{color:color(srgb 1 0.5 0);}"],
        1,
        0,
        1,
        [("value", "M6I1Aq", "val\\07f\\0& | \\0color:color(srgb 1 0.5 0)")],
      ),
      (
        "_a7fMZzkP2",
        ["._a7fMZzkP2{color:color(srgb 1 0.5 0 / 0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "MZzkP2",
            "val\\07f\\0& | \\0color:color(srgb 1 0.5 0 / 0.5)",
          ),
        ],
      ),
      (
        "_a7fOLdGao",
        ["._a7fOLdGao{color:color(display-p3 1 0.5 0);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "OLdGao",
            "val\\07f\\0& | \\0color:color(display-p3 1 0.5 0)",
          ),
        ],
      ),
      (
        "_a7fQLb3G8",
        ["._a7fQLb3G8{color:color(display-p3 1 0.5 0 / 0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "QLb3G8",
            "val\\07f\\0& | \\0color:color(display-p3 1 0.5 0 / 0.5)",
          ),
        ],
      ),
      (
        "_a4lru5hnA",
        ["._a4lru5hnA{background-color:hwb(0 0% 0%);}"],
        1,
        0,
        1,
        [
          ("value", "ru5hnA", "val\\04l\\0& | \\0background-color:hwb(0 0% 0%)"),
        ],
      ),
      (
        "_a4l8IClTL",
        ["._a4l8IClTL{background-color:lab(50% 20 -30);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "8IClTL",
            "val\\04l\\0& | \\0background-color:lab(50% 20 -30)",
          ),
        ],
      ),
      (
        "_a4l2u5iu6",
        ["._a4l2u5iu6{background-color:lch(50% 30 120);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "2u5iu6",
            "val\\04l\\0& | \\0background-color:lch(50% 30 120)",
          ),
        ],
      ),
      (
        "_a4l8qwUWw",
        ["._a4l8qwUWw{background-color:oklab(50% 0.1 -0.1);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "8qwUWw",
            "val\\04l\\0& | \\0background-color:oklab(50% 0.1 -0.1)",
          ),
        ],
      ),
      (
        "_a4l3xwFE2",
        ["._a4l3xwFE2{background-color:oklch(50% 0.15 120);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "3xwFE2",
            "val\\04l\\0& | \\0background-color:oklch(50% 0.15 120)",
          ),
        ],
      ),
    ]
  ];
  
  CSS.make("_a7feiyQtc", []);
  CSS.make("_a7fD4VDT2", []);
  CSS.make("_a7f3pkmUl", []);
  CSS.make("_a7fc_SJJi", []);
  
  CSS.make("_a7frMDmzc", []);
  CSS.make("_a7fru6-18", []);
  CSS.make("_a7f9k2629", []);
  CSS.make("_a7fRgXEnj", []);
  
  CSS.make("_a7fhfE6bd", []);
  CSS.make("_a7f3lWKPV", []);
  CSS.make("_a7fGNMQ4c", []);
  CSS.make("_a7fCRd0cn", []);
  
  CSS.make("_a7fzXtrvk", []);
  CSS.make("_a7f6ql1vr", []);
  CSS.make("_a7fQb_z2d", []);
  CSS.make("_a7fyiGIxZ", []);
  
  CSS.make("_a7fzqjd7P", []);
  CSS.make("_a7fdYlX3h", []);
  CSS.make("_a7fueZIs8", []);
  CSS.make("_a7fIfispg", []);
  
  CSS.make("_a7f9e4SR3", []);
  CSS.make("_a7f_7S24M", []);
  CSS.make("_a7fHZGEeC", []);
  CSS.make("_a4ltMByri", []);
  
  CSS.make("_a7fM6I1Aq", []);
  CSS.make("_a7fMZzkP2", []);
  CSS.make("_a7fOLdGao", []);
  CSS.make("_a7fQLb3G8", []);
  
  CSS.make("_a4lru5hnA", []);
  CSS.make("_a4l8IClTL", []);
  CSS.make("_a4l2u5iu6", []);
  CSS.make("_a4l8qwUWw", []);
  CSS.make("_a4l3xwFE2", []);
