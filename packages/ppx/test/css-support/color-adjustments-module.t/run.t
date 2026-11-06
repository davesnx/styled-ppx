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
        "_a7gnVB3NS",
        [
          "._a7gnVB3NS{-webkit-print-color-adjust:economy;color-adjust:economy;}",
        ],
        1,
        0,
        1,
        [("value", "nVB3NS", "val\\07g\\0& | \\0color-adjust:economy")],
      ),
      (
        "_a7gCmPFv_",
        ["._a7gCmPFv_{-webkit-print-color-adjust:exact;color-adjust:exact;}"],
        1,
        0,
        1,
        [("value", "CmPFv_", "val\\07g\\0& | \\0color-adjust:exact")],
      ),
      (
        "_aatu-6VC6",
        ["._aatu-6VC6{forced-color-adjust:auto;}"],
        1,
        0,
        1,
        [("value", "u-6VC6", "val\\0at\\0& | \\0forced-color-adjust:auto")],
      ),
      (
        "_aatnrFneW",
        ["._aatnrFneW{forced-color-adjust:none;}"],
        1,
        0,
        1,
        [("value", "nrFneW", "val\\0at\\0& | \\0forced-color-adjust:none")],
      ),
      (
        "_aat1GKaXl",
        ["._aat1GKaXl{forced-color-adjust:preserve-parent-color;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "1GKaXl",
            "val\\0at\\0& | \\0forced-color-adjust:preserve-parent-color",
          ),
        ],
      ),
      (
        "_a7kNTwnBP",
        ["._a7kNTwnBP{color-scheme:normal;}"],
        1,
        0,
        1,
        [("value", "NTwnBP", "val\\07k\\0& | \\0color-scheme:normal")],
      ),
      (
        "_a7kNsUED3",
        ["._a7kNsUED3{color-scheme:light;}"],
        1,
        0,
        1,
        [("value", "NsUED3", "val\\07k\\0& | \\0color-scheme:light")],
      ),
      (
        "_a7k5yJD6D",
        ["._a7k5yJD6D{color-scheme:dark;}"],
        1,
        0,
        1,
        [("value", "5yJD6D", "val\\07k\\0& | \\0color-scheme:dark")],
      ),
      (
        "_a7kIzApB2",
        ["._a7kIzApB2{color-scheme:light dark;}"],
        1,
        0,
        1,
        [("value", "IzApB2", "val\\07k\\0& | \\0color-scheme:light dark")],
      ),
      (
        "_a7klEHDFc",
        ["._a7klEHDFc{color-scheme:dark light;}"],
        1,
        0,
        1,
        [("value", "lEHDFc", "val\\07k\\0& | \\0color-scheme:dark light")],
      ),
      (
        "_a7k3KNH65",
        ["._a7k3KNH65{color-scheme:only light;}"],
        1,
        0,
        1,
        [("value", "3KNH65", "val\\07k\\0& | \\0color-scheme:only light")],
      ),
      (
        "_a7kGdJ-4C",
        ["._a7kGdJ-4C{color-scheme:light only;}"],
        1,
        0,
        1,
        [("value", "GdJ-4C", "val\\07k\\0& | \\0color-scheme:light only")],
      ),
      (
        "_a7kR6RscG",
        ["._a7kR6RscG{color-scheme:light light;}"],
        1,
        0,
        1,
        [("value", "R6RscG", "val\\07k\\0& | \\0color-scheme:light light")],
      ),
      (
        "_a7kEG_H78",
        ["._a7kEG_H78{color-scheme:dark dark;}"],
        1,
        0,
        1,
        [("value", "EG_H78", "val\\07k\\0& | \\0color-scheme:dark dark")],
      ),
      (
        "_a7kikn4ws",
        ["._a7kikn4ws{color-scheme:light purple;}"],
        1,
        0,
        1,
        [("value", "ikn4ws", "val\\07k\\0& | \\0color-scheme:light purple")],
      ),
      (
        "_a7kk3_QBu",
        ["._a7kk3_QBu{color-scheme:purple dark interesting;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "k3_QBu",
            "val\\07k\\0& | \\0color-scheme:purple dark interesting",
          ),
        ],
      ),
      (
        "_a7k-PlzrE",
        ["._a7k-PlzrE{color-scheme:none;}"],
        1,
        0,
        1,
        [("value", "-PlzrE", "val\\07k\\0& | \\0color-scheme:none")],
      ),
      (
        "_a7kdWFRRs",
        ["._a7kdWFRRs{color-scheme:light none;}"],
        1,
        0,
        1,
        [("value", "dWFRRs", "val\\07k\\0& | \\0color-scheme:light none")],
      ),
    ]
  ];
  
  CSS.make("_a7gnVB3NS", []);
  CSS.make("_a7gCmPFv_", []);
  CSS.make("_aatu-6VC6", []);
  CSS.make("_aatnrFneW", []);
  CSS.make("_aat1GKaXl", []);
  CSS.make("_a7kNTwnBP", []);
  CSS.make("_a7kNsUED3", []);
  CSS.make("_a7k5yJD6D", []);
  CSS.make("_a7kIzApB2", []);
  CSS.make("_a7klEHDFc", []);
  CSS.make("_a7k3KNH65", []);
  CSS.make("_a7kGdJ-4C", []);
  CSS.make("_a7kR6RscG", []);
  CSS.make("_a7kEG_H78", []);
  CSS.make("_a7kikn4ws", []);
  CSS.make("_a7kk3_QBu", []);
  CSS.make("_a7k-PlzrE", []);
  CSS.make("_a7kdWFRRs", []);
