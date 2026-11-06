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
        "_aeteqeUz0",
        ["._aeteqeUz0{mix-blend-mode:normal;}"],
        1,
        0,
        1,
        [("value", "eqeUz0", "val\\0et\\0& | \\0mix-blend-mode:normal")],
      ),
      (
        "_aetQPc0NP",
        ["._aetQPc0NP{mix-blend-mode:multiply;}"],
        1,
        0,
        1,
        [("value", "QPc0NP", "val\\0et\\0& | \\0mix-blend-mode:multiply")],
      ),
      (
        "_aetXZdEOL",
        ["._aetXZdEOL{mix-blend-mode:screen;}"],
        1,
        0,
        1,
        [("value", "XZdEOL", "val\\0et\\0& | \\0mix-blend-mode:screen")],
      ),
      (
        "_aetvjUBPf",
        ["._aetvjUBPf{mix-blend-mode:overlay;}"],
        1,
        0,
        1,
        [("value", "vjUBPf", "val\\0et\\0& | \\0mix-blend-mode:overlay")],
      ),
      (
        "_aetM4fBao",
        ["._aetM4fBao{mix-blend-mode:darken;}"],
        1,
        0,
        1,
        [("value", "M4fBao", "val\\0et\\0& | \\0mix-blend-mode:darken")],
      ),
      (
        "_aet6KNhTt",
        ["._aet6KNhTt{mix-blend-mode:lighten;}"],
        1,
        0,
        1,
        [("value", "6KNhTt", "val\\0et\\0& | \\0mix-blend-mode:lighten")],
      ),
      (
        "_aetI3H05b",
        ["._aetI3H05b{mix-blend-mode:color-dodge;}"],
        1,
        0,
        1,
        [("value", "I3H05b", "val\\0et\\0& | \\0mix-blend-mode:color-dodge")],
      ),
      (
        "_aetZM93Dr",
        ["._aetZM93Dr{mix-blend-mode:color-burn;}"],
        1,
        0,
        1,
        [("value", "ZM93Dr", "val\\0et\\0& | \\0mix-blend-mode:color-burn")],
      ),
      (
        "_aetJBIqsM",
        ["._aetJBIqsM{mix-blend-mode:hard-light;}"],
        1,
        0,
        1,
        [("value", "JBIqsM", "val\\0et\\0& | \\0mix-blend-mode:hard-light")],
      ),
      (
        "_aet5hGv7l",
        ["._aet5hGv7l{mix-blend-mode:soft-light;}"],
        1,
        0,
        1,
        [("value", "5hGv7l", "val\\0et\\0& | \\0mix-blend-mode:soft-light")],
      ),
      (
        "_aetn4MHje",
        ["._aetn4MHje{mix-blend-mode:difference;}"],
        1,
        0,
        1,
        [("value", "n4MHje", "val\\0et\\0& | \\0mix-blend-mode:difference")],
      ),
      (
        "_aetqagnnP",
        ["._aetqagnnP{mix-blend-mode:exclusion;}"],
        1,
        0,
        1,
        [("value", "qagnnP", "val\\0et\\0& | \\0mix-blend-mode:exclusion")],
      ),
      (
        "_aetZUtM0B",
        ["._aetZUtM0B{mix-blend-mode:hue;}"],
        1,
        0,
        1,
        [("value", "ZUtM0B", "val\\0et\\0& | \\0mix-blend-mode:hue")],
      ),
      (
        "_aetLjw0WG",
        ["._aetLjw0WG{mix-blend-mode:saturation;}"],
        1,
        0,
        1,
        [("value", "Ljw0WG", "val\\0et\\0& | \\0mix-blend-mode:saturation")],
      ),
      (
        "_aetF0nNYJ",
        ["._aetF0nNYJ{mix-blend-mode:color;}"],
        1,
        0,
        1,
        [("value", "F0nNYJ", "val\\0et\\0& | \\0mix-blend-mode:color")],
      ),
      (
        "_aetg2Sjcm",
        ["._aetg2Sjcm{mix-blend-mode:luminosity;}"],
        1,
        0,
        1,
        [("value", "g2Sjcm", "val\\0et\\0& | \\0mix-blend-mode:luminosity")],
      ),
      (
        "_ac6Tw-ysp",
        ["._ac6Tw-ysp{isolation:auto;}"],
        1,
        0,
        1,
        [("value", "Tw-ysp", "val\\0c6\\0& | \\0isolation:auto")],
      ),
      (
        "_ac6Sc-4_I",
        ["._ac6Sc-4_I{isolation:isolate;}"],
        1,
        0,
        1,
        [("value", "Sc-4_I", "val\\0c6\\0& | \\0isolation:isolate")],
      ),
      (
        "_a4jsfXRnO",
        ["._a4jsfXRnO{background-blend-mode:normal;}"],
        1,
        0,
        1,
        [
          ("value", "sfXRnO", "val\\04j\\0& | \\0background-blend-mode:normal"),
        ],
      ),
      (
        "_a4jo7JHmi",
        ["._a4jo7JHmi{background-blend-mode:multiply;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "o7JHmi",
            "val\\04j\\0& | \\0background-blend-mode:multiply",
          ),
        ],
      ),
      (
        "_a4jEPTu-u",
        ["._a4jEPTu-u{background-blend-mode:screen;}"],
        1,
        0,
        1,
        [
          ("value", "EPTu-u", "val\\04j\\0& | \\0background-blend-mode:screen"),
        ],
      ),
      (
        "_a4j0PNSB8",
        ["._a4j0PNSB8{background-blend-mode:overlay;}"],
        1,
        0,
        1,
        [
          ("value", "0PNSB8", "val\\04j\\0& | \\0background-blend-mode:overlay"),
        ],
      ),
      (
        "_a4jlnGVlq",
        ["._a4jlnGVlq{background-blend-mode:darken;}"],
        1,
        0,
        1,
        [
          ("value", "lnGVlq", "val\\04j\\0& | \\0background-blend-mode:darken"),
        ],
      ),
      (
        "_a4j-QbNgV",
        ["._a4j-QbNgV{background-blend-mode:lighten;}"],
        1,
        0,
        1,
        [
          ("value", "-QbNgV", "val\\04j\\0& | \\0background-blend-mode:lighten"),
        ],
      ),
      (
        "_a4jb0xiRH",
        ["._a4jb0xiRH{background-blend-mode:color-dodge;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "b0xiRH",
            "val\\04j\\0& | \\0background-blend-mode:color-dodge",
          ),
        ],
      ),
      (
        "_a4j0DXzDG",
        ["._a4j0DXzDG{background-blend-mode:color-burn;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "0DXzDG",
            "val\\04j\\0& | \\0background-blend-mode:color-burn",
          ),
        ],
      ),
      (
        "_a4jP0slMf",
        ["._a4jP0slMf{background-blend-mode:hard-light;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "P0slMf",
            "val\\04j\\0& | \\0background-blend-mode:hard-light",
          ),
        ],
      ),
      (
        "_a4joDmhw7",
        ["._a4joDmhw7{background-blend-mode:soft-light;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "oDmhw7",
            "val\\04j\\0& | \\0background-blend-mode:soft-light",
          ),
        ],
      ),
      (
        "_a4j-CLKEU",
        ["._a4j-CLKEU{background-blend-mode:difference;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "-CLKEU",
            "val\\04j\\0& | \\0background-blend-mode:difference",
          ),
        ],
      ),
      (
        "_a4j6RG8OZ",
        ["._a4j6RG8OZ{background-blend-mode:exclusion;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "6RG8OZ",
            "val\\04j\\0& | \\0background-blend-mode:exclusion",
          ),
        ],
      ),
      (
        "_a4jJYBzZT",
        ["._a4jJYBzZT{background-blend-mode:hue;}"],
        1,
        0,
        1,
        [("value", "JYBzZT", "val\\04j\\0& | \\0background-blend-mode:hue")],
      ),
      (
        "_a4jF64ckX",
        ["._a4jF64ckX{background-blend-mode:saturation;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "F64ckX",
            "val\\04j\\0& | \\0background-blend-mode:saturation",
          ),
        ],
      ),
      (
        "_a4jlFh0PY",
        ["._a4jlFh0PY{background-blend-mode:color;}"],
        1,
        0,
        1,
        [("value", "lFh0PY", "val\\04j\\0& | \\0background-blend-mode:color")],
      ),
      (
        "_a4jSZsr0j",
        ["._a4jSZsr0j{background-blend-mode:luminosity;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "SZsr0j",
            "val\\04j\\0& | \\0background-blend-mode:luminosity",
          ),
        ],
      ),
      (
        "_a4j1pAAe3",
        ["._a4j1pAAe3{background-blend-mode:normal, multiply;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "1pAAe3",
            "val\\04j\\0& | \\0background-blend-mode:normal, multiply",
          ),
        ],
      ),
    ]
  ];
  
  CSS.make("_aeteqeUz0", []);
  CSS.make("_aetQPc0NP", []);
  CSS.make("_aetXZdEOL", []);
  CSS.make("_aetvjUBPf", []);
  CSS.make("_aetM4fBao", []);
  CSS.make("_aet6KNhTt", []);
  CSS.make("_aetI3H05b", []);
  CSS.make("_aetZM93Dr", []);
  CSS.make("_aetJBIqsM", []);
  CSS.make("_aet5hGv7l", []);
  CSS.make("_aetn4MHje", []);
  CSS.make("_aetqagnnP", []);
  CSS.make("_aetZUtM0B", []);
  CSS.make("_aetLjw0WG", []);
  CSS.make("_aetF0nNYJ", []);
  CSS.make("_aetg2Sjcm", []);
  CSS.make("_ac6Tw-ysp", []);
  CSS.make("_ac6Sc-4_I", []);
  CSS.make("_a4jsfXRnO", []);
  CSS.make("_a4jo7JHmi", []);
  CSS.make("_a4jEPTu-u", []);
  CSS.make("_a4j0PNSB8", []);
  CSS.make("_a4jlnGVlq", []);
  CSS.make("_a4j-QbNgV", []);
  CSS.make("_a4jb0xiRH", []);
  CSS.make("_a4j0DXzDG", []);
  CSS.make("_a4jP0slMf", []);
  CSS.make("_a4joDmhw7", []);
  CSS.make("_a4j-CLKEU", []);
  CSS.make("_a4j6RG8OZ", []);
  CSS.make("_a4jJYBzZT", []);
  CSS.make("_a4jF64ckX", []);
  CSS.make("_a4jlFh0PY", []);
  CSS.make("_a4jSZsr0j", []);
  CSS.make("_a4j1pAAe3", []);
