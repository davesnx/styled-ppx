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
        "_agi4ILQml",
        ["._agi4ILQml{place-content:center;}"],
        1,
        0,
        2,
        [("value", "4ILQml", "val\\0gi\\0& | \\0place-content:center")],
      ),
      (
        "_agiBcsYk-",
        ["._agiBcsYk-{place-content:start;}"],
        1,
        0,
        2,
        [("value", "BcsYk-", "val\\0gi\\0& | \\0place-content:start")],
      ),
      (
        "_agiZKddwC",
        ["._agiZKddwC{place-content:end;}"],
        1,
        0,
        2,
        [("value", "ZKddwC", "val\\0gi\\0& | \\0place-content:end")],
      ),
      (
        "_agi-BL_Oa",
        ["._agi-BL_Oa{place-content:space-between;}"],
        1,
        0,
        2,
        [("value", "-BL_Oa", "val\\0gi\\0& | \\0place-content:space-between")],
      ),
      (
        "_agi-WURy7",
        ["._agi-WURy7{place-content:space-around;}"],
        1,
        0,
        2,
        [("value", "-WURy7", "val\\0gi\\0& | \\0place-content:space-around")],
      ),
      (
        "_agi0PQk4e",
        ["._agi0PQk4e{place-content:space-evenly;}"],
        1,
        0,
        2,
        [("value", "0PQk4e", "val\\0gi\\0& | \\0place-content:space-evenly")],
      ),
      (
        "_agiVfbBRc",
        ["._agiVfbBRc{place-content:stretch;}"],
        1,
        0,
        2,
        [("value", "VfbBRc", "val\\0gi\\0& | \\0place-content:stretch")],
      ),
      (
        "_agirZh4Gx",
        ["._agirZh4Gx{place-content:center start;}"],
        1,
        0,
        2,
        [("value", "rZh4Gx", "val\\0gi\\0& | \\0place-content:center start")],
      ),
      (
        "_agiiHW1-9",
        ["._agiiHW1-9{place-content:start end;}"],
        1,
        0,
        2,
        [("value", "iHW1-9", "val\\0gi\\0& | \\0place-content:start end")],
      ),
      (
        "_agiHkJJw9",
        ["._agiHkJJw9{place-content:space-between center;}"],
        1,
        0,
        2,
        [
          (
            "value",
            "HkJJw9",
            "val\\0gi\\0& | \\0place-content:space-between center",
          ),
        ],
      ),
      (
        "_agjM_Wdyr",
        ["._agjM_Wdyr{place-items:center;}"],
        1,
        0,
        2,
        [("value", "M_Wdyr", "val\\0gj\\0& | \\0place-items:center")],
      ),
      (
        "_agj8zk78t",
        ["._agj8zk78t{place-items:start;}"],
        1,
        0,
        2,
        [("value", "8zk78t", "val\\0gj\\0& | \\0place-items:start")],
      ),
      (
        "_agj9ofBXN",
        ["._agj9ofBXN{place-items:end;}"],
        1,
        0,
        2,
        [("value", "9ofBXN", "val\\0gj\\0& | \\0place-items:end")],
      ),
      (
        "_agjFAbkvC",
        ["._agjFAbkvC{place-items:stretch;}"],
        1,
        0,
        2,
        [("value", "FAbkvC", "val\\0gj\\0& | \\0place-items:stretch")],
      ),
      (
        "_agjZFaxJp",
        ["._agjZFaxJp{place-items:baseline;}"],
        1,
        0,
        2,
        [("value", "ZFaxJp", "val\\0gj\\0& | \\0place-items:baseline")],
      ),
      (
        "_agj6TLKmv",
        ["._agj6TLKmv{place-items:center start;}"],
        1,
        0,
        2,
        [("value", "6TLKmv", "val\\0gj\\0& | \\0place-items:center start")],
      ),
      (
        "_agjOttjT0",
        ["._agjOttjT0{place-items:start end;}"],
        1,
        0,
        2,
        [("value", "OttjT0", "val\\0gj\\0& | \\0place-items:start end")],
      ),
      (
        "_agkrA0F2-",
        ["._agkrA0F2-{place-self:auto;}"],
        1,
        0,
        2,
        [("value", "rA0F2-", "val\\0gk\\0& | \\0place-self:auto")],
      ),
      (
        "_agk0WLxZ_",
        ["._agk0WLxZ_{place-self:center;}"],
        1,
        0,
        2,
        [("value", "0WLxZ_", "val\\0gk\\0& | \\0place-self:center")],
      ),
      (
        "_agk7Cuvhe",
        ["._agk7Cuvhe{place-self:start;}"],
        1,
        0,
        2,
        [("value", "7Cuvhe", "val\\0gk\\0& | \\0place-self:start")],
      ),
      (
        "_agkatXjKV",
        ["._agkatXjKV{place-self:end;}"],
        1,
        0,
        2,
        [("value", "atXjKV", "val\\0gk\\0& | \\0place-self:end")],
      ),
      (
        "_agkZbj9PD",
        ["._agkZbj9PD{place-self:stretch;}"],
        1,
        0,
        2,
        [("value", "Zbj9PD", "val\\0gk\\0& | \\0place-self:stretch")],
      ),
      (
        "_agkGasVbN",
        ["._agkGasVbN{place-self:center start;}"],
        1,
        0,
        2,
        [("value", "GasVbN", "val\\0gk\\0& | \\0place-self:center start")],
      ),
      (
        "_agkOgIb5O",
        ["._agkOgIb5O{place-self:start end;}"],
        1,
        0,
        2,
        [("value", "OgIb5O", "val\\0gk\\0& | \\0place-self:start end")],
      ),
      (
        "_a3iDlTxzF",
        ["._a3iDlTxzF{accent-color:auto;}"],
        1,
        0,
        1,
        [("value", "DlTxzF", "val\\03i\\0& | \\0accent-color:auto")],
      ),
      (
        "_a3igK1Nrj",
        ["._a3igK1Nrj{accent-color:red;}"],
        1,
        0,
        1,
        [("value", "gK1Nrj", "val\\03i\\0& | \\0accent-color:red")],
      ),
      (
        "_a3iBx09Pj",
        ["._a3iBx09Pj{accent-color:#ff0000;}"],
        1,
        0,
        1,
        [("value", "Bx09Pj", "val\\03i\\0& | \\0accent-color:#ff0000")],
      ),
      (
        "_a3iDNcfkB",
        ["._a3iDNcfkB{accent-color:rgb(255, 0, 0);}"],
        1,
        0,
        1,
        [("value", "DNcfkB", "val\\03i\\0& | \\0accent-color:rgb(255, 0, 0)")],
      ),
      (
        "_am5Fg8Aw_",
        ["._am5Fg8Aw_{touch-action:auto;}"],
        1,
        0,
        1,
        [("value", "Fg8Aw_", "val\\0m5\\0& | \\0touch-action:auto")],
      ),
      (
        "_am5K3jON5",
        ["._am5K3jON5{touch-action:none;}"],
        1,
        0,
        1,
        [("value", "K3jON5", "val\\0m5\\0& | \\0touch-action:none")],
      ),
      (
        "_am5pWEZtY",
        ["._am5pWEZtY{touch-action:pan-x;}"],
        1,
        0,
        1,
        [("value", "pWEZtY", "val\\0m5\\0& | \\0touch-action:pan-x")],
      ),
      (
        "_am5_-CsbI",
        ["._am5_-CsbI{touch-action:pan-y;}"],
        1,
        0,
        1,
        [("value", "_-CsbI", "val\\0m5\\0& | \\0touch-action:pan-y")],
      ),
      (
        "_am5KcQaSc",
        ["._am5KcQaSc{touch-action:manipulation;}"],
        1,
        0,
        1,
        [("value", "KcQaSc", "val\\0m5\\0& | \\0touch-action:manipulation")],
      ),
      (
        "_am5vWL2hF",
        ["._am5vWL2hF{touch-action:pan-x pan-y;}"],
        1,
        0,
        1,
        [("value", "vWL2hF", "val\\0m5\\0& | \\0touch-action:pan-x pan-y")],
      ),
      (
        "_a4co4-uwh",
        ["._a4co4-uwh{aspect-ratio:auto;}"],
        1,
        0,
        1,
        [("value", "o4-uwh", "val\\04c\\0& | \\0aspect-ratio:auto")],
      ),
      (
        "_a4cmBTaih",
        ["._a4cmBTaih{aspect-ratio:1 / 1;}"],
        1,
        0,
        1,
        [("value", "mBTaih", "val\\04c\\0& | \\0aspect-ratio:1 / 1")],
      ),
      (
        "_a4c6pCvf8",
        ["._a4c6pCvf8{aspect-ratio:16 / 9;}"],
        1,
        0,
        1,
        [("value", "6pCvf8", "val\\04c\\0& | \\0aspect-ratio:16 / 9")],
      ),
      (
        "_a4cUjC8Da",
        ["._a4cUjC8Da{aspect-ratio:0.5;}"],
        1,
        0,
        1,
        [("value", "UjC8Da", "val\\04c\\0& | \\0aspect-ratio:0.5")],
      ),
    ]
  ];
  
  CSS.make("_agi4ILQml", []);
  CSS.make("_agiBcsYk-", []);
  CSS.make("_agiZKddwC", []);
  CSS.make("_agi-BL_Oa", []);
  CSS.make("_agi-WURy7", []);
  CSS.make("_agi0PQk4e", []);
  CSS.make("_agiVfbBRc", []);
  CSS.make("_agirZh4Gx", []);
  CSS.make("_agiiHW1-9", []);
  CSS.make("_agiHkJJw9", []);
  
  CSS.make("_agjM_Wdyr", []);
  CSS.make("_agj8zk78t", []);
  CSS.make("_agj9ofBXN", []);
  CSS.make("_agjFAbkvC", []);
  CSS.make("_agjZFaxJp", []);
  CSS.make("_agj6TLKmv", []);
  CSS.make("_agjOttjT0", []);
  
  CSS.make("_agkrA0F2-", []);
  CSS.make("_agk0WLxZ_", []);
  CSS.make("_agk7Cuvhe", []);
  CSS.make("_agkatXjKV", []);
  CSS.make("_agkZbj9PD", []);
  CSS.make("_agkGasVbN", []);
  CSS.make("_agkOgIb5O", []);
  
  CSS.make("_a3iDlTxzF", []);
  CSS.make("_a3igK1Nrj", []);
  CSS.make("_a3iBx09Pj", []);
  CSS.make("_a3iDNcfkB", []);
  
  CSS.make("_am5Fg8Aw_", []);
  CSS.make("_am5K3jON5", []);
  CSS.make("_am5pWEZtY", []);
  CSS.make("_am5_-CsbI", []);
  CSS.make("_am5KcQaSc", []);
  CSS.make("_am5vWL2hF", []);
  
  CSS.make("_a4co4-uwh", []);
  CSS.make("_a4cmBTaih", []);
  CSS.make("_a4c6pCvf8", []);
  CSS.make("_a4cUjC8Da", []);
