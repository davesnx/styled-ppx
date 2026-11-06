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
        "_a73HOvWYJ",
        ["._a73HOvWYJ{break-before:auto;}"],
        1,
        0,
        1,
        [("value", "HOvWYJ", "val\\073\\0& | \\0break-before:auto")],
      ),
      (
        "_a73vjx4VU",
        ["._a73vjx4VU{break-before:avoid;}"],
        1,
        0,
        1,
        [("value", "vjx4VU", "val\\073\\0& | \\0break-before:avoid")],
      ),
      (
        "_a73jRzzRe",
        ["._a73jRzzRe{break-before:avoid-page;}"],
        1,
        0,
        1,
        [("value", "jRzzRe", "val\\073\\0& | \\0break-before:avoid-page")],
      ),
      (
        "_a73gfKGAl",
        ["._a73gfKGAl{break-before:page;}"],
        1,
        0,
        1,
        [("value", "gfKGAl", "val\\073\\0& | \\0break-before:page")],
      ),
      (
        "_a739vv5vz",
        ["._a739vv5vz{break-before:left;}"],
        1,
        0,
        1,
        [("value", "9vv5vz", "val\\073\\0& | \\0break-before:left")],
      ),
      (
        "_a73tpwdar",
        ["._a73tpwdar{break-before:right;}"],
        1,
        0,
        1,
        [("value", "tpwdar", "val\\073\\0& | \\0break-before:right")],
      ),
      (
        "_a730CLlBJ",
        ["._a730CLlBJ{break-before:recto;}"],
        1,
        0,
        1,
        [("value", "0CLlBJ", "val\\073\\0& | \\0break-before:recto")],
      ),
      (
        "_a73iEEu91",
        ["._a73iEEu91{break-before:verso;}"],
        1,
        0,
        1,
        [("value", "iEEu91", "val\\073\\0& | \\0break-before:verso")],
      ),
      (
        "_a7398edJb",
        ["._a7398edJb{break-before:avoid-column;}"],
        1,
        0,
        1,
        [("value", "98edJb", "val\\073\\0& | \\0break-before:avoid-column")],
      ),
      (
        "_a73-WKza7",
        ["._a73-WKza7{break-before:column;}"],
        1,
        0,
        1,
        [("value", "-WKza7", "val\\073\\0& | \\0break-before:column")],
      ),
      (
        "_a73-kYiNE",
        ["._a73-kYiNE{break-before:avoid-region;}"],
        1,
        0,
        1,
        [("value", "-kYiNE", "val\\073\\0& | \\0break-before:avoid-region")],
      ),
      (
        "_a73Zup-Wz",
        ["._a73Zup-Wz{break-before:region;}"],
        1,
        0,
        1,
        [("value", "Zup-Wz", "val\\073\\0& | \\0break-before:region")],
      ),
      (
        "_a72JdITd5",
        ["._a72JdITd5{break-after:auto;}"],
        1,
        0,
        1,
        [("value", "JdITd5", "val\\072\\0& | \\0break-after:auto")],
      ),
      (
        "_a72NyGzty",
        ["._a72NyGzty{break-after:avoid;}"],
        1,
        0,
        1,
        [("value", "NyGzty", "val\\072\\0& | \\0break-after:avoid")],
      ),
      (
        "_a72Q4PW67",
        ["._a72Q4PW67{break-after:avoid-page;}"],
        1,
        0,
        1,
        [("value", "Q4PW67", "val\\072\\0& | \\0break-after:avoid-page")],
      ),
      (
        "_a72HeysI2",
        ["._a72HeysI2{break-after:page;}"],
        1,
        0,
        1,
        [("value", "HeysI2", "val\\072\\0& | \\0break-after:page")],
      ),
      (
        "_a724fxFb7",
        ["._a724fxFb7{break-after:left;}"],
        1,
        0,
        1,
        [("value", "4fxFb7", "val\\072\\0& | \\0break-after:left")],
      ),
      (
        "_a72A31Rz0",
        ["._a72A31Rz0{break-after:right;}"],
        1,
        0,
        1,
        [("value", "A31Rz0", "val\\072\\0& | \\0break-after:right")],
      ),
      (
        "_a72kZwkdl",
        ["._a72kZwkdl{break-after:recto;}"],
        1,
        0,
        1,
        [("value", "kZwkdl", "val\\072\\0& | \\0break-after:recto")],
      ),
      (
        "_a72o1A9nf",
        ["._a72o1A9nf{break-after:verso;}"],
        1,
        0,
        1,
        [("value", "o1A9nf", "val\\072\\0& | \\0break-after:verso")],
      ),
      (
        "_a72Oso53-",
        ["._a72Oso53-{break-after:avoid-column;}"],
        1,
        0,
        1,
        [("value", "Oso53-", "val\\072\\0& | \\0break-after:avoid-column")],
      ),
      (
        "_a72j0EHFQ",
        ["._a72j0EHFQ{break-after:column;}"],
        1,
        0,
        1,
        [("value", "j0EHFQ", "val\\072\\0& | \\0break-after:column")],
      ),
      (
        "_a72GdmiIR",
        ["._a72GdmiIR{break-after:avoid-region;}"],
        1,
        0,
        1,
        [("value", "GdmiIR", "val\\072\\0& | \\0break-after:avoid-region")],
      ),
      (
        "_a72IHzQR8",
        ["._a72IHzQR8{break-after:region;}"],
        1,
        0,
        1,
        [("value", "IHzQR8", "val\\072\\0& | \\0break-after:region")],
      ),
      (
        "_a74tM4loL",
        ["._a74tM4loL{break-inside:auto;}"],
        1,
        0,
        1,
        [("value", "tM4loL", "val\\074\\0& | \\0break-inside:auto")],
      ),
      (
        "_a74-MnpYt",
        ["._a74-MnpYt{break-inside:avoid;}"],
        1,
        0,
        1,
        [("value", "-MnpYt", "val\\074\\0& | \\0break-inside:avoid")],
      ),
      (
        "_a74_vVzP7",
        ["._a74_vVzP7{break-inside:avoid-page;}"],
        1,
        0,
        1,
        [("value", "_vVzP7", "val\\074\\0& | \\0break-inside:avoid-page")],
      ),
      (
        "_a74PYlrq9",
        ["._a74PYlrq9{break-inside:avoid-column;}"],
        1,
        0,
        1,
        [("value", "PYlrq9", "val\\074\\0& | \\0break-inside:avoid-column")],
      ),
      (
        "_a741tGqTO",
        ["._a741tGqTO{break-inside:avoid-region;}"],
        1,
        0,
        1,
        [("value", "1tGqTO", "val\\074\\0& | \\0break-inside:avoid-region")],
      ),
      (
        "_a6s8py_Xi",
        [
          "._a6s8py_Xi{-webkit-box-decoration-break:slice;box-decoration-break:slice;}",
        ],
        1,
        0,
        1,
        [("value", "8py_Xi", "val\\06s\\0& | \\0box-decoration-break:slice")],
      ),
      (
        "_a6swRU0ls",
        [
          "._a6swRU0ls{-webkit-box-decoration-break:clone;box-decoration-break:clone;}",
        ],
        1,
        0,
        1,
        [("value", "wRU0ls", "val\\06s\\0& | \\0box-decoration-break:clone")],
      ),
      (
        "_afbhV2xI5",
        ["._afbhV2xI5{orphans:1;}"],
        1,
        0,
        1,
        [("value", "hV2xI5", "val\\0fb\\0& | \\0orphans:1")],
      ),
      (
        "_afbc1-LVa",
        ["._afbc1-LVa{orphans:2;}"],
        1,
        0,
        1,
        [("value", "c1-LVa", "val\\0fb\\0& | \\0orphans:2")],
      ),
      (
        "_an7I9aBCc",
        ["._an7I9aBCc{widows:1;}"],
        1,
        0,
        1,
        [("value", "I9aBCc", "val\\0n7\\0& | \\0widows:1")],
      ),
      (
        "_an7bKuGpx",
        ["._an7bKuGpx{widows:2;}"],
        1,
        0,
        1,
        [("value", "bKuGpx", "val\\0n7\\0& | \\0widows:2")],
      ),
    ]
  ];
  
  CSS.make("_a73HOvWYJ", []);
  CSS.make("_a73vjx4VU", []);
  CSS.make("_a73jRzzRe", []);
  CSS.make("_a73gfKGAl", []);
  CSS.make("_a739vv5vz", []);
  CSS.make("_a73tpwdar", []);
  CSS.make("_a730CLlBJ", []);
  CSS.make("_a73iEEu91", []);
  CSS.make("_a7398edJb", []);
  CSS.make("_a73-WKza7", []);
  CSS.make("_a73-kYiNE", []);
  CSS.make("_a73Zup-Wz", []);
  CSS.make("_a72JdITd5", []);
  CSS.make("_a72NyGzty", []);
  CSS.make("_a72Q4PW67", []);
  CSS.make("_a72HeysI2", []);
  CSS.make("_a724fxFb7", []);
  CSS.make("_a72A31Rz0", []);
  CSS.make("_a72kZwkdl", []);
  CSS.make("_a72o1A9nf", []);
  CSS.make("_a72Oso53-", []);
  CSS.make("_a72j0EHFQ", []);
  CSS.make("_a72GdmiIR", []);
  CSS.make("_a72IHzQR8", []);
  CSS.make("_a74tM4loL", []);
  CSS.make("_a74-MnpYt", []);
  CSS.make("_a74_vVzP7", []);
  CSS.make("_a74PYlrq9", []);
  CSS.make("_a741tGqTO", []);
  CSS.make("_a6s8py_Xi", []);
  CSS.make("_a6swRU0ls", []);
  CSS.make("_afbhV2xI5", []);
  CSS.make("_afbc1-LVa", []);
  
  CSS.make("_an7I9aBCc", []);
  CSS.make("_an7bKuGpx", []);
