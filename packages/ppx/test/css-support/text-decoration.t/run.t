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
        "_akyaLQ7au",
        ["._akyaLQ7au{text-decoration-line:none;}"],
        1,
        0,
        1,
        [("value", "aLQ7au", "val\\0ky\\0& | \\0text-decoration-line:none")],
      ),
      (
        "_akyeHSCLY",
        ["._akyeHSCLY{text-decoration-line:underline;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "eHSCLY",
            "val\\0ky\\0& | \\0text-decoration-line:underline",
          ),
        ],
      ),
      (
        "_akysCIRX7",
        ["._akysCIRX7{text-decoration-line:overline;}"],
        1,
        0,
        1,
        [
          ("value", "sCIRX7", "val\\0ky\\0& | \\0text-decoration-line:overline"),
        ],
      ),
      (
        "_aky-f-tFb",
        ["._aky-f-tFb{text-decoration-line:line-through;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "-f-tFb",
            "val\\0ky\\0& | \\0text-decoration-line:line-through",
          ),
        ],
      ),
      (
        "_aky79Nxhg",
        ["._aky79Nxhg{text-decoration-line:underline overline;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "79Nxhg",
            "val\\0ky\\0& | \\0text-decoration-line:underline overline",
          ),
        ],
      ),
      (
        "_akw2yv1uq",
        ["._akw2yv1uq{text-decoration-color:white;}"],
        1,
        0,
        1,
        [("value", "2yv1uq", "val\\0kw\\0& | \\0text-decoration-color:white")],
      ),
      (
        "_al5vMYztk",
        ["._al5vMYztk{text-decoration-style:solid;}"],
        1,
        0,
        1,
        [("value", "vMYztk", "val\\0l5\\0& | \\0text-decoration-style:solid")],
      ),
      (
        "_al526Ch9Y",
        ["._al526Ch9Y{text-decoration-style:double;}"],
        1,
        0,
        1,
        [
          ("value", "26Ch9Y", "val\\0l5\\0& | \\0text-decoration-style:double"),
        ],
      ),
      (
        "_al5U3IYlR",
        ["._al5U3IYlR{text-decoration-style:dotted;}"],
        1,
        0,
        1,
        [
          ("value", "U3IYlR", "val\\0l5\\0& | \\0text-decoration-style:dotted"),
        ],
      ),
      (
        "_al5AMhkHk",
        ["._al5AMhkHk{text-decoration-style:dashed;}"],
        1,
        0,
        1,
        [
          ("value", "AMhkHk", "val\\0l5\\0& | \\0text-decoration-style:dashed"),
        ],
      ),
      (
        "_al5lu0_LK",
        ["._al5lu0_LK{text-decoration-style:wavy;}"],
        1,
        0,
        1,
        [("value", "lu0_LK", "val\\0l5\\0& | \\0text-decoration-style:wavy")],
      ),
      (
        "_alqCcwynj",
        ["._alqCcwynj{text-underline-position:auto;}"],
        1,
        0,
        1,
        [
          ("value", "Ccwynj", "val\\0lq\\0& | \\0text-underline-position:auto"),
        ],
      ),
      (
        "_alqycKz4U",
        ["._alqycKz4U{text-underline-position:under;}"],
        1,
        0,
        1,
        [
          ("value", "ycKz4U", "val\\0lq\\0& | \\0text-underline-position:under"),
        ],
      ),
      (
        "_alq3z6PCu",
        ["._alq3z6PCu{text-underline-position:left;}"],
        1,
        0,
        1,
        [
          ("value", "3z6PCu", "val\\0lq\\0& | \\0text-underline-position:left"),
        ],
      ),
      (
        "_alqHUNHNs",
        ["._alqHUNHNs{text-underline-position:right;}"],
        1,
        0,
        1,
        [
          ("value", "HUNHNs", "val\\0lq\\0& | \\0text-underline-position:right"),
        ],
      ),
      (
        "_alqRT64ac",
        ["._alqRT64ac{text-underline-position:under left;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "RT64ac",
            "val\\0lq\\0& | \\0text-underline-position:under left",
          ),
        ],
      ),
      (
        "_alqYnLOGw",
        ["._alqYnLOGw{text-underline-position:under right;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "YnLOGw",
            "val\\0lq\\0& | \\0text-underline-position:under right",
          ),
        ],
      ),
      (
        "_albzvWYWs",
        ["._albzvWYWs{text-emphasis-style:none;}"],
        1,
        0,
        1,
        [("value", "zvWYWs", "val\\0lb\\0& | \\0text-emphasis-style:none")],
      ),
      (
        "_albzTpOYI",
        ["._albzTpOYI{text-emphasis-style:filled;}"],
        1,
        0,
        1,
        [("value", "zTpOYI", "val\\0lb\\0& | \\0text-emphasis-style:filled")],
      ),
      (
        "_albDp1ir2",
        ["._albDp1ir2{text-emphasis-style:open;}"],
        1,
        0,
        1,
        [("value", "Dp1ir2", "val\\0lb\\0& | \\0text-emphasis-style:open")],
      ),
      (
        "_albWBlrPu",
        ["._albWBlrPu{text-emphasis-style:dot;}"],
        1,
        0,
        1,
        [("value", "WBlrPu", "val\\0lb\\0& | \\0text-emphasis-style:dot")],
      ),
      (
        "_albemjCUz",
        ["._albemjCUz{text-emphasis-style:circle;}"],
        1,
        0,
        1,
        [("value", "emjCUz", "val\\0lb\\0& | \\0text-emphasis-style:circle")],
      ),
      (
        "_albcnJMJa",
        ["._albcnJMJa{text-emphasis-style:double-circle;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "cnJMJa",
            "val\\0lb\\0& | \\0text-emphasis-style:double-circle",
          ),
        ],
      ),
      (
        "_albbcG5VL",
        ["._albbcG5VL{text-emphasis-style:triangle;}"],
        1,
        0,
        1,
        [
          ("value", "bcG5VL", "val\\0lb\\0& | \\0text-emphasis-style:triangle"),
        ],
      ),
      (
        "_alblRJIdH",
        ["._alblRJIdH{text-emphasis-style:sesame;}"],
        1,
        0,
        1,
        [("value", "lRJIdH", "val\\0lb\\0& | \\0text-emphasis-style:sesame")],
      ),
      (
        "_albTEEoQ7",
        ["._albTEEoQ7{text-emphasis-style:open dot;}"],
        1,
        0,
        1,
        [
          ("value", "TEEoQ7", "val\\0lb\\0& | \\0text-emphasis-style:open dot"),
        ],
      ),
      (
        "_albMiHkKl",
        ["._albMiHkKl{text-emphasis-style:\"foo\";}"],
        1,
        0,
        1,
        [("value", "MiHkKl", "val\\0lb\\0& | \\0text-emphasis-style:\"foo\"")],
      ),
      (
        "_al9RHgSZV",
        ["._al9RHgSZV{text-emphasis-color:green;}"],
        1,
        0,
        1,
        [("value", "RHgSZV", "val\\0l9\\0& | \\0text-emphasis-color:green")],
      ),
      (
        "_al8evDQUb",
        ["._al8evDQUb{text-emphasis:open dot green;}"],
        1,
        0,
        2,
        [
          ("value", "evDQUb", "val\\0l8\\0& | \\0text-emphasis:open dot green"),
        ],
      ),
      (
        "_ala3j2jNS",
        ["._ala3j2jNS{text-emphasis-position:over;}"],
        1,
        0,
        1,
        [("value", "3j2jNS", "val\\0la\\0& | \\0text-emphasis-position:over")],
      ),
      (
        "_alaIPDzYr",
        ["._alaIPDzYr{text-emphasis-position:under;}"],
        1,
        0,
        1,
        [
          ("value", "IPDzYr", "val\\0la\\0& | \\0text-emphasis-position:under"),
        ],
      ),
      (
        "_alaYcRBk2",
        ["._alaYcRBk2{text-emphasis-position:over left;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "YcRBk2",
            "val\\0la\\0& | \\0text-emphasis-position:over left",
          ),
        ],
      ),
      (
        "_alaa_k2mO",
        ["._alaa_k2mO{text-emphasis-position:over right;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "a_k2mO",
            "val\\0la\\0& | \\0text-emphasis-position:over right",
          ),
        ],
      ),
      (
        "_alaGc88Fy",
        ["._alaGc88Fy{text-emphasis-position:under left;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Gc88Fy",
            "val\\0la\\0& | \\0text-emphasis-position:under left",
          ),
        ],
      ),
      (
        "_alaSYOaFQ",
        ["._alaSYOaFQ{text-emphasis-position:left under;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "SYOaFQ",
            "val\\0la\\0& | \\0text-emphasis-position:left under",
          ),
        ],
      ),
      (
        "_alahTXuYL",
        ["._alahTXuYL{text-emphasis-position:under right;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "hTXuYL",
            "val\\0la\\0& | \\0text-emphasis-position:under right",
          ),
        ],
      ),
      (
        "_allNcEXal",
        ["._allNcEXal{text-shadow:none;}"],
        1,
        0,
        1,
        [("value", "NcEXal", "val\\0ll\\0& | \\0text-shadow:none")],
      ),
      (
        "_allc7YXAL",
        ["._allc7YXAL{text-shadow:1px 1px;}"],
        1,
        0,
        1,
        [("value", "c7YXAL", "val\\0ll\\0& | \\0text-shadow:1px 1px")],
      ),
      (
        "_allYHNqqk",
        ["._allYHNqqk{text-shadow:0 0 black;}"],
        1,
        0,
        1,
        [("value", "YHNqqk", "val\\0ll\\0& | \\0text-shadow:0 0 black")],
      ),
      (
        "_allRrlgMP",
        ["._allRrlgMP{text-shadow:1px 2px 3px;}"],
        1,
        0,
        1,
        [("value", "RrlgMP", "val\\0ll\\0& | \\0text-shadow:1px 2px 3px")],
      ),
      (
        "_allLF40EO",
        ["._allLF40EO{text-shadow:1px 2px 3px black;}"],
        1,
        0,
        1,
        [
          ("value", "LF40EO", "val\\0ll\\0& | \\0text-shadow:1px 2px 3px black"),
        ],
      ),
      (
        "_allDVNVLt",
        ["._allDVNVLt{text-shadow:1px 1px, 2px 2px red;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "DVNVLt",
            "val\\0ll\\0& | \\0text-shadow:1px 1px, 2px 2px red",
          ),
        ],
      ),
      (
        "_allcMoEFZ",
        ["._allcMoEFZ{text-shadow:1px 2px 3px black, 0 0 5px white;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "cMoEFZ",
            "val\\0ll\\0& | \\0text-shadow:1px 2px 3px black, 0 0 5px white",
          ),
        ],
      ),
      (
        "_akzwRQGTO",
        ["._akzwRQGTO{text-decoration-skip:none;}"],
        1,
        0,
        1,
        [("value", "wRQGTO", "val\\0kz\\0& | \\0text-decoration-skip:none")],
      ),
      (
        "_akzL7pWdV",
        ["._akzL7pWdV{text-decoration-skip:objects;}"],
        1,
        0,
        1,
        [
          ("value", "L7pWdV", "val\\0kz\\0& | \\0text-decoration-skip:objects"),
        ],
      ),
      (
        "_akzxaopfQ",
        ["._akzxaopfQ{text-decoration-skip:objects spaces;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "xaopfQ",
            "val\\0kz\\0& | \\0text-decoration-skip:objects spaces",
          ),
        ],
      ),
      (
        "_akz2CElNw",
        ["._akz2CElNw{text-decoration-skip:objects leading-spaces;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "2CElNw",
            "val\\0kz\\0& | \\0text-decoration-skip:objects leading-spaces",
          ),
        ],
      ),
      (
        "_akzqqoE3r",
        ["._akzqqoE3r{text-decoration-skip:objects trailing-spaces;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "qqoE3r",
            "val\\0kz\\0& | \\0text-decoration-skip:objects trailing-spaces",
          ),
        ],
      ),
      (
        "_akzoMT68D",
        [
          "._akzoMT68D{text-decoration-skip:objects leading-spaces trailing-spaces;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "oMT68D",
            "val\\0kz\\0& | \\0text-decoration-skip:objects leading-spaces trailing-spaces",
          ),
        ],
      ),
      (
        "_akz-_CzFG",
        [
          "._akz-_CzFG{text-decoration-skip:objects leading-spaces trailing-spaces edges;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "-_CzFG",
            "val\\0kz\\0& | \\0text-decoration-skip:objects leading-spaces trailing-spaces edges",
          ),
        ],
      ),
      (
        "_akzC89I0X",
        [
          "._akzC89I0X{text-decoration-skip:objects leading-spaces trailing-spaces edges box-decoration;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "C89I0X",
            "val\\0kz\\0& | \\0text-decoration-skip:objects leading-spaces trailing-spaces edges box-decoration",
          ),
        ],
      ),
      (
        "_akzKqY-Rd",
        ["._akzKqY-Rd{text-decoration-skip:objects edges;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "KqY-Rd",
            "val\\0kz\\0& | \\0text-decoration-skip:objects edges",
          ),
        ],
      ),
      (
        "_akzA5lI4U",
        ["._akzA5lI4U{text-decoration-skip:objects box-decoration;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "A5lI4U",
            "val\\0kz\\0& | \\0text-decoration-skip:objects box-decoration",
          ),
        ],
      ),
      (
        "_akzXgw5vR",
        ["._akzXgw5vR{text-decoration-skip:spaces;}"],
        1,
        0,
        1,
        [("value", "Xgw5vR", "val\\0kz\\0& | \\0text-decoration-skip:spaces")],
      ),
      (
        "_akz6kDnLc",
        ["._akz6kDnLc{text-decoration-skip:spaces edges;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "6kDnLc",
            "val\\0kz\\0& | \\0text-decoration-skip:spaces edges",
          ),
        ],
      ),
      (
        "_akzo59ta5",
        ["._akzo59ta5{text-decoration-skip:spaces edges box-decoration;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "o59ta5",
            "val\\0kz\\0& | \\0text-decoration-skip:spaces edges box-decoration",
          ),
        ],
      ),
      (
        "_akzFqSTLr",
        ["._akzFqSTLr{text-decoration-skip:spaces box-decoration;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "FqSTLr",
            "val\\0kz\\0& | \\0text-decoration-skip:spaces box-decoration",
          ),
        ],
      ),
      (
        "_akzJ7AtLQ",
        ["._akzJ7AtLQ{text-decoration-skip:leading-spaces;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "J7AtLQ",
            "val\\0kz\\0& | \\0text-decoration-skip:leading-spaces",
          ),
        ],
      ),
      (
        "_akznFzDnH",
        [
          "._akznFzDnH{text-decoration-skip:leading-spaces trailing-spaces edges;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "nFzDnH",
            "val\\0kz\\0& | \\0text-decoration-skip:leading-spaces trailing-spaces edges",
          ),
        ],
      ),
      (
        "_akz_VmJ1F",
        [
          "._akz_VmJ1F{text-decoration-skip:leading-spaces trailing-spaces edges box-decoration;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "_VmJ1F",
            "val\\0kz\\0& | \\0text-decoration-skip:leading-spaces trailing-spaces edges box-decoration",
          ),
        ],
      ),
      (
        "_akzZlGFeI",
        ["._akzZlGFeI{text-decoration-skip:edges;}"],
        1,
        0,
        1,
        [("value", "ZlGFeI", "val\\0kz\\0& | \\0text-decoration-skip:edges")],
      ),
      (
        "_akzK4ovZs",
        ["._akzK4ovZs{text-decoration-skip:edges box-decoration;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "K4ovZs",
            "val\\0kz\\0& | \\0text-decoration-skip:edges box-decoration",
          ),
        ],
      ),
      (
        "_akz1LVS9-",
        ["._akz1LVS9-{text-decoration-skip:box-decoration;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "1LVS9-",
            "val\\0kz\\0& | \\0text-decoration-skip:box-decoration",
          ),
        ],
      ),
      (
        "_al1EvD4HI",
        ["._al1EvD4HI{text-decoration-skip-ink:none;}"],
        1,
        0,
        1,
        [
          ("value", "EvD4HI", "val\\0l1\\0& | \\0text-decoration-skip-ink:none"),
        ],
      ),
      (
        "_al1o6FjUt",
        ["._al1o6FjUt{text-decoration-skip-ink:auto;}"],
        1,
        0,
        1,
        [
          ("value", "o6FjUt", "val\\0l1\\0& | \\0text-decoration-skip-ink:auto"),
        ],
      ),
      (
        "_al1NINFTw",
        ["._al1NINFTw{text-decoration-skip-ink:all;}"],
        1,
        0,
        1,
        [
          ("value", "NINFTw", "val\\0l1\\0& | \\0text-decoration-skip-ink:all"),
        ],
      ),
      (
        "_al00tuwQF",
        ["._al00tuwQF{text-decoration-skip-box:none;}"],
        1,
        0,
        1,
        [
          ("value", "0tuwQF", "val\\0l0\\0& | \\0text-decoration-skip-box:none"),
        ],
      ),
      (
        "_al0WdXS4C",
        ["._al0WdXS4C{text-decoration-skip-box:all;}"],
        1,
        0,
        1,
        [
          ("value", "WdXS4C", "val\\0l0\\0& | \\0text-decoration-skip-box:all"),
        ],
      ),
      (
        "_al2ZbOPYc",
        ["._al2ZbOPYc{text-decoration-skip-inset:none;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ZbOPYc",
            "val\\0l2\\0& | \\0text-decoration-skip-inset:none",
          ),
        ],
      ),
      (
        "_al28HZu4-",
        ["._al28HZu4-{text-decoration-skip-inset:auto;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "8HZu4-",
            "val\\0l2\\0& | \\0text-decoration-skip-inset:auto",
          ),
        ],
      ),
      (
        "_alpNgn1xM",
        ["._alpNgn1xM{text-underline-offset:auto;}"],
        1,
        0,
        1,
        [("value", "Ngn1xM", "val\\0lp\\0& | \\0text-underline-offset:auto")],
      ),
      (
        "_alpmvn35p",
        ["._alpmvn35p{text-underline-offset:3px;}"],
        1,
        0,
        1,
        [("value", "mvn35p", "val\\0lp\\0& | \\0text-underline-offset:3px")],
      ),
      (
        "_alp3OeBSt",
        ["._alp3OeBSt{text-underline-offset:10%;}"],
        1,
        0,
        1,
        [("value", "3OeBSt", "val\\0lp\\0& | \\0text-underline-offset:10%")],
      ),
      (
        "_al6RKbQ8d",
        ["._al6RKbQ8d{text-decoration-thickness:auto;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "RKbQ8d",
            "val\\0l6\\0& | \\0text-decoration-thickness:auto",
          ),
        ],
      ),
      (
        "_al66kHzbW",
        ["._al66kHzbW{text-decoration-thickness:from-font;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "6kHzbW",
            "val\\0l6\\0& | \\0text-decoration-thickness:from-font",
          ),
        ],
      ),
      (
        "_al6HDRHSr",
        ["._al6HDRHSr{text-decoration-thickness:3px;}"],
        1,
        0,
        1,
        [
          ("value", "HDRHSr", "val\\0l6\\0& | \\0text-decoration-thickness:3px"),
        ],
      ),
      (
        "_al6vTNUzy",
        ["._al6vTNUzy{text-decoration-thickness:10%;}"],
        1,
        0,
        1,
        [
          ("value", "vTNUzy", "val\\0l6\\0& | \\0text-decoration-thickness:10%"),
        ],
      ),
    ]
  ];
  
  CSS.make("_akyaLQ7au", []);
  CSS.make("_akyeHSCLY", []);
  CSS.make("_akysCIRX7", []);
  CSS.make("_aky-f-tFb", []);
  CSS.make("_aky79Nxhg", []);
  CSS.make("_akw2yv1uq", []);
  CSS.make("_al5vMYztk", []);
  CSS.make("_al526Ch9Y", []);
  CSS.make("_al5U3IYlR", []);
  CSS.make("_al5AMhkHk", []);
  CSS.make("_al5lu0_LK", []);
  CSS.make("_alqCcwynj", []);
  CSS.make("_alqycKz4U", []);
  CSS.make("_alq3z6PCu", []);
  CSS.make("_alqHUNHNs", []);
  CSS.make("_alqRT64ac", []);
  CSS.make("_alqYnLOGw", []);
  CSS.make("_albzvWYWs", []);
  CSS.make("_albzTpOYI", []);
  CSS.make("_albDp1ir2", []);
  CSS.make("_albWBlrPu", []);
  CSS.make("_albemjCUz", []);
  CSS.make("_albcnJMJa", []);
  CSS.make("_albbcG5VL", []);
  CSS.make("_alblRJIdH", []);
  CSS.make("_albTEEoQ7", []);
  CSS.make("_albMiHkKl", []);
  CSS.make("_al9RHgSZV", []);
  CSS.make("_al8evDQUb", []);
  
  CSS.make("_ala3j2jNS", []);
  CSS.make("_alaIPDzYr", []);
  CSS.make("_alaYcRBk2", []);
  CSS.make("_alaa_k2mO", []);
  CSS.make("_alaGc88Fy", []);
  CSS.make("_alaSYOaFQ", []);
  CSS.make("_alahTXuYL", []);
  
  CSS.make("_allNcEXal", []);
  
  CSS.make("_allc7YXAL", []);
  
  CSS.make("_allYHNqqk", []);
  
  CSS.make("_allRrlgMP", []);
  
  CSS.make("_allLF40EO", []);
  
  CSS.make("_allDVNVLt", []);
  CSS.make("_allcMoEFZ", []);
  
  CSS.make("_akzwRQGTO", []);
  CSS.make("_akzL7pWdV", []);
  CSS.make("_akzxaopfQ", []);
  CSS.make("_akz2CElNw", []);
  CSS.make("_akzqqoE3r", []);
  CSS.make("_akzoMT68D", []);
  CSS.make("_akz-_CzFG", []);
  CSS.make("_akzC89I0X", []);
  CSS.make("_akzKqY-Rd", []);
  CSS.make("_akzA5lI4U", []);
  CSS.make("_akzXgw5vR", []);
  CSS.make("_akz6kDnLc", []);
  CSS.make("_akzo59ta5", []);
  CSS.make("_akzFqSTLr", []);
  CSS.make("_akzJ7AtLQ", []);
  CSS.make("_akznFzDnH", []);
  CSS.make("_akz_VmJ1F", []);
  CSS.make("_akzZlGFeI", []);
  CSS.make("_akzK4ovZs", []);
  CSS.make("_akz1LVS9-", []);
  CSS.make("_al1EvD4HI", []);
  CSS.make("_al1o6FjUt", []);
  CSS.make("_al1NINFTw", []);
  CSS.make("_al00tuwQF", []);
  CSS.make("_al0WdXS4C", []);
  CSS.make("_al2ZbOPYc", []);
  CSS.make("_al28HZu4-", []);
  CSS.make("_alpNgn1xM", []);
  CSS.make("_alpmvn35p", []);
  CSS.make("_alp3OeBSt", []);
  CSS.make("_al6RKbQ8d", []);
  CSS.make("_al66kHzbW", []);
  CSS.make("_al6HDRHSr", []);
  CSS.make("_al6vTNUzy", []);
