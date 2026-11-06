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
        "_acloPgxdk",
        ["._acloPgxdk{line-clamp:none;}"],
        1,
        0,
        1,
        [("value", "oPgxdk", "val\\0cl\\0& | \\0line-clamp:none")],
      ),
      (
        "_acl_uqHKR",
        ["._acl_uqHKR{line-clamp:1;}"],
        1,
        0,
        1,
        [("value", "_uqHKR", "val\\0cl\\0& | \\0line-clamp:1")],
      ),
      (
        "_adyPpKu28",
        ["._adyPpKu28{max-lines:none;}"],
        1,
        0,
        1,
        [("value", "PpKu28", "val\\0dy\\0& | \\0max-lines:none")],
      ),
      (
        "_adyuUWN2_",
        ["._adyuUWN2_{max-lines:1;}"],
        1,
        0,
        1,
        [("value", "uUWN2_", "val\\0dy\\0& | \\0max-lines:1")],
      ),
      (
        "_afoWFHKmM",
        ["._afoWFHKmM{overflow-x:visible;}"],
        1,
        0,
        1,
        [("value", "WFHKmM", "val\\0fo\\0& | \\0overflow-x:visible")],
      ),
      (
        "_afoL3rz1S",
        ["._afoL3rz1S{overflow-x:hidden;}"],
        1,
        0,
        1,
        [("value", "L3rz1S", "val\\0fo\\0& | \\0overflow-x:hidden")],
      ),
      (
        "_afoVMHK7u",
        ["._afoVMHK7u{overflow-x:clip;}"],
        1,
        0,
        1,
        [("value", "VMHK7u", "val\\0fo\\0& | \\0overflow-x:clip")],
      ),
      (
        "_afohUKmvv",
        ["._afohUKmvv{overflow-x:scroll;}"],
        1,
        0,
        1,
        [("value", "hUKmvv", "val\\0fo\\0& | \\0overflow-x:scroll")],
      ),
      (
        "_afoi70nem",
        ["._afoi70nem{overflow-x:auto;}"],
        1,
        0,
        1,
        [("value", "i70nem", "val\\0fo\\0& | \\0overflow-x:auto")],
      ),
      (
        "_afp9dxJME",
        ["._afp9dxJME{overflow-y:visible;}"],
        1,
        0,
        1,
        [("value", "9dxJME", "val\\0fp\\0& | \\0overflow-y:visible")],
      ),
      (
        "_afpXbWJo4",
        ["._afpXbWJo4{overflow-y:hidden;}"],
        1,
        0,
        1,
        [("value", "XbWJo4", "val\\0fp\\0& | \\0overflow-y:hidden")],
      ),
      (
        "_afpOyeHvF",
        ["._afpOyeHvF{overflow-y:clip;}"],
        1,
        0,
        1,
        [("value", "OyeHvF", "val\\0fp\\0& | \\0overflow-y:clip")],
      ),
      (
        "_afpKHMBWe",
        ["._afpKHMBWe{overflow-y:scroll;}"],
        1,
        0,
        1,
        [("value", "KHMBWe", "val\\0fp\\0& | \\0overflow-y:scroll")],
      ),
      (
        "_afptJfutg",
        ["._afptJfutg{overflow-y:auto;}"],
        1,
        0,
        1,
        [("value", "tJfutg", "val\\0fp\\0& | \\0overflow-y:auto")],
      ),
      (
        "_afmv4Dz6r",
        ["._afmv4Dz6r{overflow-inline:visible;}"],
        1,
        0,
        1,
        [("value", "v4Dz6r", "val\\0fm\\0& | \\0overflow-inline:visible")],
      ),
      (
        "_afm3HOQiN",
        ["._afm3HOQiN{overflow-inline:hidden;}"],
        1,
        0,
        1,
        [("value", "3HOQiN", "val\\0fm\\0& | \\0overflow-inline:hidden")],
      ),
      (
        "_afmoysJac",
        ["._afmoysJac{overflow-inline:clip;}"],
        1,
        0,
        1,
        [("value", "oysJac", "val\\0fm\\0& | \\0overflow-inline:clip")],
      ),
      (
        "_afmB0O7tu",
        ["._afmB0O7tu{overflow-inline:scroll;}"],
        1,
        0,
        1,
        [("value", "B0O7tu", "val\\0fm\\0& | \\0overflow-inline:scroll")],
      ),
      (
        "_afmBmNr6W",
        ["._afmBmNr6W{overflow-inline:auto;}"],
        1,
        0,
        1,
        [("value", "BmNr6W", "val\\0fm\\0& | \\0overflow-inline:auto")],
      ),
      (
        "_afjZlfKaH",
        ["._afjZlfKaH{overflow-block:visible;}"],
        1,
        0,
        1,
        [("value", "ZlfKaH", "val\\0fj\\0& | \\0overflow-block:visible")],
      ),
      (
        "_afjwDCg5p",
        ["._afjwDCg5p{overflow-block:hidden;}"],
        1,
        0,
        1,
        [("value", "wDCg5p", "val\\0fj\\0& | \\0overflow-block:hidden")],
      ),
      (
        "_afjc17ESv",
        ["._afjc17ESv{overflow-block:clip;}"],
        1,
        0,
        1,
        [("value", "c17ESv", "val\\0fj\\0& | \\0overflow-block:clip")],
      ),
      (
        "_afjNzJAO1",
        ["._afjNzJAO1{overflow-block:scroll;}"],
        1,
        0,
        1,
        [("value", "NzJAO1", "val\\0fj\\0& | \\0overflow-block:scroll")],
      ),
      (
        "_afjtyemM5",
        ["._afjtyemM5{overflow-block:auto;}"],
        1,
        0,
        1,
        [("value", "tyemM5", "val\\0fj\\0& | \\0overflow-block:auto")],
      ),
      (
        "_ajq-7MfW_",
        ["._ajq-7MfW_{scrollbar-gutter:auto;}"],
        1,
        0,
        1,
        [("value", "-7MfW_", "val\\0jq\\0& | \\0scrollbar-gutter:auto")],
      ),
      (
        "_ajqpi6M8S",
        ["._ajqpi6M8S{scrollbar-gutter:stable;}"],
        1,
        0,
        1,
        [("value", "pi6M8S", "val\\0jq\\0& | \\0scrollbar-gutter:stable")],
      ),
      (
        "_ajq9sMT8U",
        ["._ajq9sMT8U{scrollbar-gutter:both-edges stable;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "9sMT8U",
            "val\\0jq\\0& | \\0scrollbar-gutter:both-edges stable",
          ),
        ],
      ),
      (
        "_ajqV1aYmZ",
        ["._ajqV1aYmZ{scrollbar-gutter:stable both-edges;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "V1aYmZ",
            "val\\0jq\\0& | \\0scrollbar-gutter:stable both-edges",
          ),
        ],
      ),
      (
        "_aflnhRIiB",
        ["._aflnhRIiB{overflow-clip-margin:content-box;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "nhRIiB",
            "val\\0fl\\0& | \\0overflow-clip-margin:content-box",
          ),
        ],
      ),
      (
        "_aflmssBC4",
        ["._aflmssBC4{overflow-clip-margin:padding-box;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "mssBC4",
            "val\\0fl\\0& | \\0overflow-clip-margin:padding-box",
          ),
        ],
      ),
      (
        "_aflb0EheV",
        ["._aflb0EheV{overflow-clip-margin:border-box;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "b0EheV",
            "val\\0fl\\0& | \\0overflow-clip-margin:border-box",
          ),
        ],
      ),
      (
        "_afl-k9xjW",
        ["._afl-k9xjW{overflow-clip-margin:20px;}"],
        1,
        0,
        1,
        [("value", "-k9xjW", "val\\0fl\\0& | \\0overflow-clip-margin:20px")],
      ),
      (
        "_aflw2Q-d4",
        ["._aflw2Q-d4{overflow-clip-margin:1em;}"],
        1,
        0,
        1,
        [("value", "w2Q-d4", "val\\0fl\\0& | \\0overflow-clip-margin:1em")],
      ),
      (
        "_aflsDK3gP",
        ["._aflsDK3gP{overflow-clip-margin:content-box 5px;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "sDK3gP",
            "val\\0fl\\0& | \\0overflow-clip-margin:content-box 5px",
          ),
        ],
      ),
      (
        "_aflZKrtx7",
        ["._aflZKrtx7{overflow-clip-margin:5px content-box;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ZKrtx7",
            "val\\0fl\\0& | \\0overflow-clip-margin:5px content-box",
          ),
        ],
      ),
    ]
  ];
  
  CSS.make("_acloPgxdk", []);
  CSS.make("_acl_uqHKR", []);
  
  CSS.make("_adyPpKu28", []);
  CSS.make("_adyuUWN2_", []);
  CSS.make("_afoWFHKmM", []);
  CSS.make("_afoL3rz1S", []);
  CSS.make("_afoVMHK7u", []);
  CSS.make("_afohUKmvv", []);
  CSS.make("_afoi70nem", []);
  CSS.make("_afp9dxJME", []);
  CSS.make("_afpXbWJo4", []);
  CSS.make("_afpOyeHvF", []);
  CSS.make("_afpKHMBWe", []);
  CSS.make("_afptJfutg", []);
  CSS.make("_afmv4Dz6r", []);
  CSS.make("_afm3HOQiN", []);
  CSS.make("_afmoysJac", []);
  CSS.make("_afmB0O7tu", []);
  CSS.make("_afmBmNr6W", []);
  CSS.make("_afjZlfKaH", []);
  CSS.make("_afjwDCg5p", []);
  CSS.make("_afjc17ESv", []);
  CSS.make("_afjNzJAO1", []);
  CSS.make("_afjtyemM5", []);
  CSS.make("_ajq-7MfW_", []);
  CSS.make("_ajqpi6M8S", []);
  CSS.make("_ajq9sMT8U", []);
  CSS.make("_ajqV1aYmZ", []);
  CSS.make("_aflnhRIiB", []);
  CSS.make("_aflmssBC4", []);
  CSS.make("_aflb0EheV", []);
  CSS.make("_afl-k9xjW", []);
  CSS.make("_aflw2Q-d4", []);
  CSS.make("_aflsDK3gP", []);
  CSS.make("_aflZKrtx7", []);
