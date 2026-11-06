This test ensures CSS Nesting's relative-selector shorthand (a nested rule's
prelude starting with a bare combinator, `> .child`/`+ .sib`/`~ .sib`) parses
and resolves `&` identically to writing the combinator after an explicit `&`.
Each pair below must render and hash to the same atom.

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
        "_c7fK5UU6pGjKFKW",
        ["._c7fK5UU6pGjKFKW .parent > .child{color:red;}"],
        0,
        1,
        1,
        [
          ("ctx", "K5UU6p", "ctx\\0& .parent > .child | "),
          ("value", "GjKFKW", "val\\07f\\0& .parent > .child | \\0color:red"),
        ],
      ),
      (
        "_c7f2baum7W15Ra5",
        ["._c7f2baum7W15Ra5 .parent + .sibling{color:red;}"],
        0,
        1,
        1,
        [
          ("ctx", "2baum7", "ctx\\0& .parent + .sibling | "),
          ("value", "W15Ra5", "val\\07f\\0& .parent + .sibling | \\0color:red"),
        ],
      ),
      (
        "_c7fxiZYpZBVjmMS",
        ["._c7fxiZYpZBVjmMS .parent ~ .sibling{color:red;}"],
        0,
        1,
        1,
        [
          ("ctx", "xiZYpZ", "ctx\\0& .parent ~ .sibling | "),
          ("value", "BVjmMS", "val\\07f\\0& .parent ~ .sibling | \\0color:red"),
        ],
      ),
      (
        "_c7f33PnDY6tHDTD",
        ["._c7f33PnDY6tHDTD .parent > .a.b:hover{color:red;}"],
        0,
        1,
        1,
        [
          ("ctx", "33PnDY", "ctx\\0& .parent > .a.b:hover | "),
          (
            "value",
            "6tHDTD",
            "val\\07f\\0& .parent > .a.b:hover | \\0color:red",
          ),
        ],
      ),
      (
        "_bAC7fWSO6UY7f7Zxw_YvPhMLx",
        [
          "._bAC7fWSO6UY7f7Zxw_YvPhMLx .parent > .a{color:red;}",
          "._bAC7fWSO6UY7f7Zxw_YvPhMLx .parent + .b{color:red;}",
        ],
        0,
        1,
        2,
        [
          ("ctx", "WSO6UY", "ctx\\0& .parent > .a | "),
          ("ctx", "7Zxw_Y", "ctx\\0& .parent + .b | "),
          (
            "value",
            "vPhMLx",
            "bval\\0& .parent > .a | \\07f\\0color:red\\0& .parent + .b | \\07f\\0color:red",
          ),
        ],
      ),
      (
        "_c7fHGihBSjznH_s",
        [
          "@media (min-width: 1px) {._c7fHGihBSjznH_s .parent > .child{color:red;}}",
        ],
        0,
        2,
        1,
        [
          (
            "ctx",
            "HGihBS",
            "ctx\\0& .parent > .child | @media(min-width:1px) | ",
          ),
          (
            "value",
            "jznH_s",
            "val\\07f\\0& .parent > .child | @media(min-width:1px) | \\0color:red",
          ),
        ],
      ),
    ]
  ];
  
  CSS.make("_c7fK5UU6pGjKFKW", []);
  CSS.make("_c7fK5UU6pGjKFKW", []);
  
  CSS.make("_c7f2baum7W15Ra5", []);
  CSS.make("_c7f2baum7W15Ra5", []);
  
  CSS.make("_c7fxiZYpZBVjmMS", []);
  CSS.make("_c7fxiZYpZBVjmMS", []);
  
  CSS.make("_c7f33PnDY6tHDTD", []);
  CSS.make("_c7f33PnDY6tHDTD", []);
  
  CSS.make("_bAC7fWSO6UY7f7Zxw_YvPhMLx", []);
  CSS.make("_bAC7fWSO6UY7f7Zxw_YvPhMLx", []);
  
  CSS.make("_c7fHGihBSjznH_s", []);
  CSS.make("_c7fHGihBSjznH_s", []);
