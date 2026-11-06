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
        "_af3sCMNEV",
        ["._af3sCMNEV{offset:none;}"],
        1,
        0,
        5,
        [("value", "sCMNEV", "val\\0f3\\0& | \\0offset:none")],
      ),
      (
        "_af38l_648",
        ["._af38l_648{offset:auto;}"],
        1,
        0,
        5,
        [("value", "8l_648", "val\\0f3\\0& | \\0offset:auto")],
      ),
      (
        "_af3uDbAD3",
        ["._af3uDbAD3{offset:center;}"],
        1,
        0,
        5,
        [("value", "uDbAD3", "val\\0f3\\0& | \\0offset:center")],
      ),
      (
        "_af3rkHVoW",
        ["._af3rkHVoW{offset:200px 100px;}"],
        1,
        0,
        5,
        [("value", "rkHVoW", "val\\0f3\\0& | \\0offset:200px 100px")],
      ),
      (
        "_af38EcxOJ",
        ["._af38EcxOJ{offset:margin-box;}"],
        1,
        0,
        5,
        [("value", "8EcxOJ", "val\\0f3\\0& | \\0offset:margin-box")],
      ),
      (
        "_af3btGVgG",
        ["._af3btGVgG{offset:border-box;}"],
        1,
        0,
        5,
        [("value", "btGVgG", "val\\0f3\\0& | \\0offset:border-box")],
      ),
      (
        "_af3UWHl40",
        ["._af3UWHl40{offset:padding-box;}"],
        1,
        0,
        5,
        [("value", "UWHl40", "val\\0f3\\0& | \\0offset:padding-box")],
      ),
      (
        "_af3Qp0rov",
        ["._af3Qp0rov{offset:content-box;}"],
        1,
        0,
        5,
        [("value", "Qp0rov", "val\\0f3\\0& | \\0offset:content-box")],
      ),
      (
        "_af3MATmM0",
        ["._af3MATmM0{offset:fill-box;}"],
        1,
        0,
        5,
        [("value", "MATmM0", "val\\0f3\\0& | \\0offset:fill-box")],
      ),
      (
        "_af3tIB7HE",
        ["._af3tIB7HE{offset:stroke-box;}"],
        1,
        0,
        5,
        [("value", "tIB7HE", "val\\0f3\\0& | \\0offset:stroke-box")],
      ),
      (
        "_af3dQjzJn",
        ["._af3dQjzJn{offset:view-box;}"],
        1,
        0,
        5,
        [("value", "dQjzJn", "val\\0f3\\0& | \\0offset:view-box")],
      ),
      (
        "_af38fhM8B",
        ["._af38fhM8B{offset:path(\"M 20 20 H 80 V 30\");}"],
        1,
        0,
        5,
        [
          (
            "value",
            "8fhM8B",
            "val\\0f3\\0& | \\0offset:path(\"M 20 20 H 80 V 30\")",
          ),
        ],
      ),
      (
        "_af30_hFOr",
        ["._af30_hFOr{offset:url(\"image.png\");}"],
        1,
        0,
        5,
        [("value", "0_hFOr", "val\\0f3\\0& | \\0offset:url(\"image.png\")")],
      ),
      (
        "_af3rIKGPm",
        ["._af3rIKGPm{offset:ray(45deg closest-side);}"],
        1,
        0,
        5,
        [
          (
            "value",
            "rIKGPm",
            "val\\0f3\\0& | \\0offset:ray(45deg closest-side)",
          ),
        ],
      ),
      (
        "_af3zwEsUg",
        ["._af3zwEsUg{offset:ray(45deg closest-side) 10%;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "zwEsUg",
            "val\\0f3\\0& | \\0offset:ray(45deg closest-side) 10%",
          ),
        ],
      ),
      (
        "_af3flX1lU",
        ["._af3flX1lU{offset:ray(45deg closest-side) 10% reverse;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "flX1lU",
            "val\\0f3\\0& | \\0offset:ray(45deg closest-side) 10% reverse",
          ),
        ],
      ),
      (
        "_af3Mbh-KK",
        ["._af3Mbh-KK{offset:ray(45deg closest-side) reverse 10%;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "Mbh-KK",
            "val\\0f3\\0& | \\0offset:ray(45deg closest-side) reverse 10%",
          ),
        ],
      ),
      (
        "_af3Sv1fnF",
        ["._af3Sv1fnF{offset:auto / center;}"],
        1,
        0,
        5,
        [("value", "Sv1fnF", "val\\0f3\\0& | \\0offset:auto / center")],
      ),
      (
        "_af3Iresue",
        ["._af3Iresue{offset:center / 200px 100px;}"],
        1,
        0,
        5,
        [("value", "Iresue", "val\\0f3\\0& | \\0offset:center / 200px 100px")],
      ),
      (
        "_af3EfVQ6P",
        ["._af3EfVQ6P{offset:ray(45deg closest-side) / 200px 100px;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "EfVQ6P",
            "val\\0f3\\0& | \\0offset:ray(45deg closest-side) / 200px 100px",
          ),
        ],
      ),
      (
        "_af6X1UpMV",
        ["._af6X1UpMV{offset-path:none;}"],
        1,
        0,
        1,
        [("value", "X1UpMV", "val\\0f6\\0& | \\0offset-path:none")],
      ),
      (
        "_af66Fkj02",
        ["._af66Fkj02{offset-path:ray(45deg closest-side);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "6Fkj02",
            "val\\0f6\\0& | \\0offset-path:ray(45deg closest-side)",
          ),
        ],
      ),
      (
        "_af67GFeDK",
        ["._af67GFeDK{offset-path:ray(45deg farthest-side);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "7GFeDK",
            "val\\0f6\\0& | \\0offset-path:ray(45deg farthest-side)",
          ),
        ],
      ),
      (
        "_af6Wq3mzb",
        ["._af6Wq3mzb{offset-path:ray(45deg closest-corner);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Wq3mzb",
            "val\\0f6\\0& | \\0offset-path:ray(45deg closest-corner)",
          ),
        ],
      ),
      (
        "_af6-4Zunn",
        ["._af6-4Zunn{offset-path:ray(45deg farthest-corner);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "-4Zunn",
            "val\\0f6\\0& | \\0offset-path:ray(45deg farthest-corner)",
          ),
        ],
      ),
      (
        "_af66Szxfa",
        ["._af66Szxfa{offset-path:ray(100grad closest-side contain);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "6Szxfa",
            "val\\0f6\\0& | \\0offset-path:ray(100grad closest-side contain)",
          ),
        ],
      ),
      (
        "_af6z4hbeW",
        ["._af6z4hbeW{offset-path:margin-box;}"],
        1,
        0,
        1,
        [("value", "z4hbeW", "val\\0f6\\0& | \\0offset-path:margin-box")],
      ),
      (
        "_af6rDvJ3-",
        ["._af6rDvJ3-{offset-path:border-box;}"],
        1,
        0,
        1,
        [("value", "rDvJ3-", "val\\0f6\\0& | \\0offset-path:border-box")],
      ),
      (
        "_af6BJrCr-",
        ["._af6BJrCr-{offset-path:padding-box;}"],
        1,
        0,
        1,
        [("value", "BJrCr-", "val\\0f6\\0& | \\0offset-path:padding-box")],
      ),
      (
        "_af6qcw3xP",
        ["._af6qcw3xP{offset-path:content-box;}"],
        1,
        0,
        1,
        [("value", "qcw3xP", "val\\0f6\\0& | \\0offset-path:content-box")],
      ),
      (
        "_af6M0VGJM",
        ["._af6M0VGJM{offset-path:fill-box;}"],
        1,
        0,
        1,
        [("value", "M0VGJM", "val\\0f6\\0& | \\0offset-path:fill-box")],
      ),
      (
        "_af6Fbnm6A",
        ["._af6Fbnm6A{offset-path:stroke-box;}"],
        1,
        0,
        1,
        [("value", "Fbnm6A", "val\\0f6\\0& | \\0offset-path:stroke-box")],
      ),
      (
        "_af6ARBIbb",
        ["._af6ARBIbb{offset-path:view-box;}"],
        1,
        0,
        1,
        [("value", "ARBIbb", "val\\0f6\\0& | \\0offset-path:view-box")],
      ),
      (
        "_af69MgPyJ",
        ["._af69MgPyJ{offset-path:circle(60%) margin-box;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "9MgPyJ",
            "val\\0f6\\0& | \\0offset-path:circle(60%) margin-box",
          ),
        ],
      ),
      (
        "_af5_Av2zT",
        ["._af5_Av2zT{offset-distance:10%;}"],
        1,
        0,
        1,
        [("value", "_Av2zT", "val\\0f5\\0& | \\0offset-distance:10%")],
      ),
      (
        "_af7bDGdrw",
        ["._af7bDGdrw{offset-position:auto;}"],
        1,
        0,
        1,
        [("value", "bDGdrw", "val\\0f7\\0& | \\0offset-position:auto")],
      ),
      (
        "_af7xWKzR7",
        ["._af7xWKzR7{offset-position:200px;}"],
        1,
        0,
        1,
        [("value", "xWKzR7", "val\\0f7\\0& | \\0offset-position:200px")],
      ),
      (
        "_af79azA8D",
        ["._af79azA8D{offset-position:200px 100px;}"],
        1,
        0,
        1,
        [("value", "9azA8D", "val\\0f7\\0& | \\0offset-position:200px 100px")],
      ),
      (
        "_af7zuM7aq",
        ["._af7zuM7aq{offset-position:center;}"],
        1,
        0,
        1,
        [("value", "zuM7aq", "val\\0f7\\0& | \\0offset-position:center")],
      ),
      (
        "_af4tkoeUl",
        ["._af4tkoeUl{offset-anchor:auto;}"],
        1,
        0,
        1,
        [("value", "tkoeUl", "val\\0f4\\0& | \\0offset-anchor:auto")],
      ),
      (
        "_af4jHpaj3",
        ["._af4jHpaj3{offset-anchor:200px;}"],
        1,
        0,
        1,
        [("value", "jHpaj3", "val\\0f4\\0& | \\0offset-anchor:200px")],
      ),
      (
        "_af4l0I92K",
        ["._af4l0I92K{offset-anchor:200px 100px;}"],
        1,
        0,
        1,
        [("value", "l0I92K", "val\\0f4\\0& | \\0offset-anchor:200px 100px")],
      ),
      (
        "_af4G653qd",
        ["._af4G653qd{offset-anchor:center;}"],
        1,
        0,
        1,
        [("value", "G653qd", "val\\0f4\\0& | \\0offset-anchor:center")],
      ),
      (
        "_af8I1JP5u",
        ["._af8I1JP5u{offset-rotate:auto;}"],
        1,
        0,
        1,
        [("value", "I1JP5u", "val\\0f8\\0& | \\0offset-rotate:auto")],
      ),
      (
        "_af8OlnGvN",
        ["._af8OlnGvN{offset-rotate:0deg;}"],
        1,
        0,
        1,
        [("value", "OlnGvN", "val\\0f8\\0& | \\0offset-rotate:0deg")],
      ),
      (
        "_af8kYTwVy",
        ["._af8kYTwVy{offset-rotate:reverse;}"],
        1,
        0,
        1,
        [("value", "kYTwVy", "val\\0f8\\0& | \\0offset-rotate:reverse")],
      ),
      (
        "_af8p8wB2s",
        ["._af8p8wB2s{offset-rotate:-45deg;}"],
        1,
        0,
        1,
        [("value", "p8wB2s", "val\\0f8\\0& | \\0offset-rotate:-45deg")],
      ),
      (
        "_af8LE-IDz",
        ["._af8LE-IDz{offset-rotate:auto 180deg;}"],
        1,
        0,
        1,
        [("value", "LE-IDz", "val\\0f8\\0& | \\0offset-rotate:auto 180deg")],
      ),
      (
        "_af8V4VqAL",
        ["._af8V4VqAL{offset-rotate:reverse 45deg;}"],
        1,
        0,
        1,
        [("value", "V4VqAL", "val\\0f8\\0& | \\0offset-rotate:reverse 45deg")],
      ),
      (
        "_af8Vf9kVU",
        ["._af8Vf9kVU{offset-rotate:2turn reverse;}"],
        1,
        0,
        1,
        [("value", "Vf9kVU", "val\\0f8\\0& | \\0offset-rotate:2turn reverse")],
      ),
    ]
  ];
  
  CSS.make("_af3sCMNEV", []);
  CSS.make("_af38l_648", []);
  CSS.make("_af3uDbAD3", []);
  CSS.make("_af3rkHVoW", []);
  
  CSS.make("_af38EcxOJ", []);
  CSS.make("_af3btGVgG", []);
  CSS.make("_af3UWHl40", []);
  CSS.make("_af3Qp0rov", []);
  CSS.make("_af3MATmM0", []);
  CSS.make("_af3tIB7HE", []);
  CSS.make("_af3dQjzJn", []);
  
  CSS.make("_af38fhM8B", []);
  CSS.make("_af30_hFOr", []);
  CSS.make("_af3rIKGPm", []);
  CSS.make("_af3zwEsUg", []);
  CSS.make("_af3flX1lU", []);
  
  CSS.make("_af3Mbh-KK", []);
  
  CSS.make("_af3Sv1fnF", []);
  CSS.make("_af3Iresue", []);
  CSS.make("_af3EfVQ6P", []);
  
  CSS.make("_af6X1UpMV", []);
  CSS.make("_af66Fkj02", []);
  CSS.make("_af67GFeDK", []);
  CSS.make("_af6Wq3mzb", []);
  CSS.make("_af6-4Zunn", []);
  
  CSS.make("_af66Szxfa", []);
  
  CSS.make("_af6z4hbeW", []);
  CSS.make("_af6rDvJ3-", []);
  CSS.make("_af6BJrCr-", []);
  CSS.make("_af6qcw3xP", []);
  CSS.make("_af6M0VGJM", []);
  CSS.make("_af6Fbnm6A", []);
  CSS.make("_af6ARBIbb", []);
  CSS.make("_af69MgPyJ", []);
  
  CSS.make("_af5_Av2zT", []);
  CSS.make("_af7bDGdrw", []);
  CSS.make("_af7xWKzR7", []);
  CSS.make("_af79azA8D", []);
  CSS.make("_af7zuM7aq", []);
  CSS.make("_af4tkoeUl", []);
  CSS.make("_af4jHpaj3", []);
  CSS.make("_af4l0I92K", []);
  CSS.make("_af4G653qd", []);
  CSS.make("_af8I1JP5u", []);
  CSS.make("_af8OlnGvN", []);
  CSS.make("_af8kYTwVy", []);
  CSS.make("_af8p8wB2s", []);
  CSS.make("_af8LE-IDz", []);
  CSS.make("_af8V4VqAL", []);
  CSS.make("_af8Vf9kVU", []);
