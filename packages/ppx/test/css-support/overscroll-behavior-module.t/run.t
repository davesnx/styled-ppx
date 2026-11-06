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
        "_afs3HGsVm",
        ["._afs3HGsVm{overscroll-behavior:contain;}"],
        1,
        0,
        2,
        [("value", "3HGsVm", "val\\0fs\\0& | \\0overscroll-behavior:contain")],
      ),
      (
        "_afsgqgRJu",
        ["._afsgqgRJu{overscroll-behavior:none;}"],
        1,
        0,
        2,
        [("value", "gqgRJu", "val\\0fs\\0& | \\0overscroll-behavior:none")],
      ),
      (
        "_afsvYdnIe",
        ["._afsvYdnIe{overscroll-behavior:auto;}"],
        1,
        0,
        2,
        [("value", "vYdnIe", "val\\0fs\\0& | \\0overscroll-behavior:auto")],
      ),
      (
        "_afs2uiAGj",
        ["._afs2uiAGj{overscroll-behavior:contain contain;}"],
        1,
        0,
        2,
        [
          (
            "value",
            "2uiAGj",
            "val\\0fs\\0& | \\0overscroll-behavior:contain contain",
          ),
        ],
      ),
      (
        "_afsKZxNq4",
        ["._afsKZxNq4{overscroll-behavior:none contain;}"],
        1,
        0,
        2,
        [
          (
            "value",
            "KZxNq4",
            "val\\0fs\\0& | \\0overscroll-behavior:none contain",
          ),
        ],
      ),
      (
        "_afsWpHKRn",
        ["._afsWpHKRn{overscroll-behavior:auto contain;}"],
        1,
        0,
        2,
        [
          (
            "value",
            "WpHKRn",
            "val\\0fs\\0& | \\0overscroll-behavior:auto contain",
          ),
        ],
      ),
      (
        "_afsEoyFfb",
        ["._afsEoyFfb{overscroll-behavior:contain none;}"],
        1,
        0,
        2,
        [
          (
            "value",
            "EoyFfb",
            "val\\0fs\\0& | \\0overscroll-behavior:contain none",
          ),
        ],
      ),
      (
        "_afsJ6N5wV",
        ["._afsJ6N5wV{overscroll-behavior:none none;}"],
        1,
        0,
        2,
        [
          ("value", "J6N5wV", "val\\0fs\\0& | \\0overscroll-behavior:none none"),
        ],
      ),
      (
        "_afs3A6tZS",
        ["._afs3A6tZS{overscroll-behavior:auto none;}"],
        1,
        0,
        2,
        [
          ("value", "3A6tZS", "val\\0fs\\0& | \\0overscroll-behavior:auto none"),
        ],
      ),
      (
        "_afsXFuZKv",
        ["._afsXFuZKv{overscroll-behavior:contain auto;}"],
        1,
        0,
        2,
        [
          (
            "value",
            "XFuZKv",
            "val\\0fs\\0& | \\0overscroll-behavior:contain auto",
          ),
        ],
      ),
      (
        "_afs9lpDPx",
        ["._afs9lpDPx{overscroll-behavior:none auto;}"],
        1,
        0,
        2,
        [
          ("value", "9lpDPx", "val\\0fs\\0& | \\0overscroll-behavior:none auto"),
        ],
      ),
      (
        "_afs28oIJ3",
        ["._afs28oIJ3{overscroll-behavior:auto auto;}"],
        1,
        0,
        2,
        [
          ("value", "28oIJ3", "val\\0fs\\0& | \\0overscroll-behavior:auto auto"),
        ],
      ),
      (
        "_afv1Bovlx",
        ["._afv1Bovlx{overscroll-behavior-x:contain;}"],
        1,
        0,
        1,
        [
          ("value", "1Bovlx", "val\\0fv\\0& | \\0overscroll-behavior-x:contain"),
        ],
      ),
      (
        "_afvrsVaMx",
        ["._afvrsVaMx{overscroll-behavior-x:none;}"],
        1,
        0,
        1,
        [("value", "rsVaMx", "val\\0fv\\0& | \\0overscroll-behavior-x:none")],
      ),
      (
        "_afvAygEEm",
        ["._afvAygEEm{overscroll-behavior-x:auto;}"],
        1,
        0,
        1,
        [("value", "AygEEm", "val\\0fv\\0& | \\0overscroll-behavior-x:auto")],
      ),
      (
        "_afwq7a-l-",
        ["._afwq7a-l-{overscroll-behavior-y:contain;}"],
        1,
        0,
        1,
        [
          ("value", "q7a-l-", "val\\0fw\\0& | \\0overscroll-behavior-y:contain"),
        ],
      ),
      (
        "_afw6ec9iI",
        ["._afw6ec9iI{overscroll-behavior-y:none;}"],
        1,
        0,
        1,
        [("value", "6ec9iI", "val\\0fw\\0& | \\0overscroll-behavior-y:none")],
      ),
      (
        "_afwDqp9xq",
        ["._afwDqp9xq{overscroll-behavior-y:auto;}"],
        1,
        0,
        1,
        [("value", "Dqp9xq", "val\\0fw\\0& | \\0overscroll-behavior-y:auto")],
      ),
      (
        "_afugrDCVn",
        ["._afugrDCVn{overscroll-behavior-inline:contain;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "grDCVn",
            "val\\0fu\\0& | \\0overscroll-behavior-inline:contain",
          ),
        ],
      ),
      (
        "_afu0QkTTm",
        ["._afu0QkTTm{overscroll-behavior-inline:none;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "0QkTTm",
            "val\\0fu\\0& | \\0overscroll-behavior-inline:none",
          ),
        ],
      ),
      (
        "_afuhLDahx",
        ["._afuhLDahx{overscroll-behavior-inline:auto;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "hLDahx",
            "val\\0fu\\0& | \\0overscroll-behavior-inline:auto",
          ),
        ],
      ),
      (
        "_aft_zHR-t",
        ["._aft_zHR-t{overscroll-behavior-block:contain;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "_zHR-t",
            "val\\0ft\\0& | \\0overscroll-behavior-block:contain",
          ),
        ],
      ),
      (
        "_aftCD9stT",
        ["._aftCD9stT{overscroll-behavior-block:none;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "CD9stT",
            "val\\0ft\\0& | \\0overscroll-behavior-block:none",
          ),
        ],
      ),
      (
        "_aftcncaaM",
        ["._aftcncaaM{overscroll-behavior-block:auto;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "cncaaM",
            "val\\0ft\\0& | \\0overscroll-behavior-block:auto",
          ),
        ],
      ),
    ]
  ];
  
  CSS.make("_afs3HGsVm", []);
  CSS.make("_afsgqgRJu", []);
  CSS.make("_afsvYdnIe", []);
  CSS.make("_afs2uiAGj", []);
  CSS.make("_afsKZxNq4", []);
  CSS.make("_afsWpHKRn", []);
  CSS.make("_afsEoyFfb", []);
  CSS.make("_afsJ6N5wV", []);
  CSS.make("_afs3A6tZS", []);
  CSS.make("_afsXFuZKv", []);
  CSS.make("_afs9lpDPx", []);
  CSS.make("_afs28oIJ3", []);
  CSS.make("_afv1Bovlx", []);
  CSS.make("_afvrsVaMx", []);
  CSS.make("_afvAygEEm", []);
  CSS.make("_afwq7a-l-", []);
  CSS.make("_afw6ec9iI", []);
  CSS.make("_afwDqp9xq", []);
  CSS.make("_afugrDCVn", []);
  CSS.make("_afu0QkTTm", []);
  CSS.make("_afuhLDahx", []);
  CSS.make("_aft_zHR-t", []);
  CSS.make("_aftCD9stT", []);
  CSS.make("_aftcncaaM", []);
