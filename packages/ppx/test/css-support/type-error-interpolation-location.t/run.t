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
  File "input.re", line 11, characters 23-28:
  11 |     text-decoration: $(cosas);
                              ^^^^^
  Error: The value cosas has type [> `bold ]
         but an expression was expected of type
           [< `inherit_
            | `initial
            | `none
            | `revert
            | `revertLayer
            | `unset
            | `value of Css_types.TextDecoration.value
            | `var of string
            | `varDefault of string * string ]
         The second variant type does not allow tag(s) `bold
  [1]

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
  [@css "@property --cosas-1xbmf3s{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_an8GbUK3p",
        [
          "._an8GbUK3p{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}",
        ],
        1,
        0,
        1,
        [("value", "GbUK3p", "val\\0n8\\0& | \\0width:fit-content")],
      ),
      (
        "_abaDSLzSu",
        [
          "._abaDSLzSu{grid-template-columns:fit-content(20px) fit-content(10%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "DSLzSu",
            "val\\0ba\\0& | \\0grid-template-columns:fit-content(20px) fit-content(10%)",
          ),
        ],
      ),
      (
        "_akv-0mK0f",
        [
          "._akv-0mK0f{-webkit-text-decoration:var(--cosas-1xbmf3s);text-decoration:var(--cosas-1xbmf3s);}",
        ],
        1,
        0,
        4,
        [("value", "-0mK0f", "val\\0kv\\0& | \\0text-decoration:$(cosas)")],
      ),
    ]
  ];
  let cosas = `bold;
  
  CSS.make("_an8GbUK3p _abaDSLzSu", []);
  
  CSS.make(
    "_akv-0mK0f",
    [("--cosas-1xbmf3s", CSS.Types.TextDecoration.toString(cosas))],
  );
