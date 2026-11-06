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
        "_an8g1IGAH",
        ["._an8g1IGAH{width:1cap;}"],
        1,
        0,
        1,
        [("value", "g1IGAH", "val\\0n8\\0& | \\0width:1cap")],
      ),
      (
        "_an8dp4cyT",
        ["._an8dp4cyT{width:2.5cap;}"],
        1,
        0,
        1,
        [("value", "dp4cyT", "val\\0n8\\0& | \\0width:2.5cap")],
      ),
      (
        "_an8Iv55jg",
        ["._an8Iv55jg{width:1ic;}"],
        1,
        0,
        1,
        [("value", "Iv55jg", "val\\0n8\\0& | \\0width:1ic")],
      ),
      (
        "_an8bM9yRS",
        ["._an8bM9yRS{width:3.5ic;}"],
        1,
        0,
        1,
        [("value", "bM9yRS", "val\\0n8\\0& | \\0width:3.5ic")],
      ),
      (
        "_an8nuPWuY",
        ["._an8nuPWuY{width:1lh;}"],
        1,
        0,
        1,
        [("value", "nuPWuY", "val\\0n8\\0& | \\0width:1lh")],
      ),
      (
        "_an8TZVgJC",
        ["._an8TZVgJC{width:2lh;}"],
        1,
        0,
        1,
        [("value", "TZVgJC", "val\\0n8\\0& | \\0width:2lh")],
      ),
      (
        "_an8uzJqzX",
        ["._an8uzJqzX{width:1rcap;}"],
        1,
        0,
        1,
        [("value", "uzJqzX", "val\\0n8\\0& | \\0width:1rcap")],
      ),
      (
        "_an8d6BrUQ",
        ["._an8d6BrUQ{width:1rch;}"],
        1,
        0,
        1,
        [("value", "d6BrUQ", "val\\0n8\\0& | \\0width:1rch")],
      ),
      (
        "_an8ymPdOF",
        ["._an8ymPdOF{width:1rex;}"],
        1,
        0,
        1,
        [("value", "ymPdOF", "val\\0n8\\0& | \\0width:1rex")],
      ),
      (
        "_an8JMe1rz",
        ["._an8JMe1rz{width:1ric;}"],
        1,
        0,
        1,
        [("value", "JMe1rz", "val\\0n8\\0& | \\0width:1ric")],
      ),
      (
        "_an8-S4Vzf",
        ["._an8-S4Vzf{width:1rlh;}"],
        1,
        0,
        1,
        [("value", "-S4Vzf", "val\\0n8\\0& | \\0width:1rlh")],
      ),
      (
        "_an8yHTZeY",
        ["._an8yHTZeY{width:50vb;}"],
        1,
        0,
        1,
        [("value", "yHTZeY", "val\\0n8\\0& | \\0width:50vb")],
      ),
      (
        "_an8eU_Snw",
        ["._an8eU_Snw{width:50vi;}"],
        1,
        0,
        1,
        [("value", "eU_Snw", "val\\0n8\\0& | \\0width:50vi")],
      ),
      (
        "_an8k5eD4f",
        ["._an8k5eD4f{width:40Q;}"],
        1,
        0,
        1,
        [("value", "k5eD4f", "val\\0n8\\0& | \\0width:40Q")],
      ),
      (
        "_abdZvleXw",
        ["._abdZvleXw{height:10lh;}"],
        1,
        0,
        1,
        [("value", "ZvleXw", "val\\0bd\\0& | \\0height:10lh")],
      ),
      (
        "_actHI_81b",
        ["._actHI_81b{margin:2cap;}"],
        1,
        0,
        4,
        [("value", "HI_81b", "val\\0ct\\0& | \\0margin:2cap")],
      ),
      (
        "_afyQL4bsG",
        ["._afyQL4bsG{padding:5ic;}"],
        1,
        0,
        4,
        [("value", "QL4bsG", "val\\0fy\\0& | \\0padding:5ic")],
      ),
      (
        "_aa8WVnqGo",
        ["._aa8WVnqGo{font-size:1.5lh;}"],
        1,
        0,
        1,
        [("value", "WVnqGo", "val\\0a8\\0& | \\0font-size:1.5lh")],
      ),
      (
        "_acnlfrka-",
        ["._acnlfrka-{line-height:2rlh;}"],
        1,
        0,
        1,
        [("value", "lfrka-", "val\\0cn\\0& | \\0line-height:2rlh")],
      ),
    ]
  ];
  
  CSS.make("_an8g1IGAH", []);
  CSS.make("_an8dp4cyT", []);
  
  CSS.make("_an8Iv55jg", []);
  CSS.make("_an8bM9yRS", []);
  
  CSS.make("_an8nuPWuY", []);
  CSS.make("_an8TZVgJC", []);
  
  CSS.make("_an8uzJqzX", []);
  
  CSS.make("_an8d6BrUQ", []);
  
  CSS.make("_an8ymPdOF", []);
  
  CSS.make("_an8JMe1rz", []);
  
  CSS.make("_an8-S4Vzf", []);
  
  CSS.make("_an8yHTZeY", []);
  
  CSS.make("_an8eU_Snw", []);
  
  CSS.make("_an8k5eD4f", []);
  
  CSS.make("_abdZvleXw", []);
  CSS.make("_actHI_81b", []);
  CSS.make("_afyQL4bsG", []);
  CSS.make("_aa8WVnqGo", []);
  CSS.make("_acnlfrka-", []);
