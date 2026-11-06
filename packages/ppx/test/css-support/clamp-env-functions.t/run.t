This test ensures clamp() and env() are reachable from length and percentage
properties, not just registered as standalone functions.

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
        "_an8quELsT",
        ["._an8quELsT{width:clamp(10px, 5vw, 100px);}"],
        1,
        0,
        1,
        [
          ("value", "quELsT", "val\\0n8\\0& | \\0width:clamp(10px, 5vw, 100px)"),
        ],
      ),
      (
        "_ag8J2b66W",
        ["._ag8J2b66W{padding-top:env(safe-area-inset-top);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "J2b66W",
            "val\\0g8\\0& | \\0padding-top:env(safe-area-inset-top)",
          ),
        ],
      ),
      (
        "_ag8B8_y0k",
        ["._ag8B8_y0k{padding-top:env(safe-area-inset-top, 8px);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "B8_y0k",
            "val\\0g8\\0& | \\0padding-top:env(safe-area-inset-top, 8px)",
          ),
        ],
      ),
      (
        "_aa8OsoW_l",
        ["._aa8OsoW_l{font-size:clamp(1rem, 2.5vw, 2rem);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "OsoW_l",
            "val\\0a8\\0& | \\0font-size:clamp(1rem, 2.5vw, 2rem)",
          ),
        ],
      ),
      (
        "_adzg53ZRB",
        ["._adzg53ZRB{max-width:clamp(20%, 50vw, 80%);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "g53ZRB",
            "val\\0dz\\0& | \\0max-width:clamp(20%, 50vw, 80%)",
          ),
        ],
      ),
      (
        "_an8YzzrS9",
        ["._an8YzzrS9{width:calc(clamp(1px, 2vw, 3px) + 1px);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "YzzrS9",
            "val\\0n8\\0& | \\0width:calc(clamp(1px, 2vw, 3px) + 1px)",
          ),
        ],
      ),
    ]
  ];
  CSS.make("_an8quELsT", []);
  CSS.make("_ag8J2b66W", []);
  CSS.make("_ag8B8_y0k", []);
  CSS.make("_aa8OsoW_l", []);
  CSS.make("_adzg53ZRB", []);
  CSS.make("_an8YzzrS9", []);

  $ dune build
