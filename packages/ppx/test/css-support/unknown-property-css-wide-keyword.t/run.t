A css-wide keyword value (`inherit`, `initial`, ...) does not bypass the
property-name check. `colr:inherit;` used to compile silently when no space
followed the colon.

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
  File "input.re", line 2, characters 7-14:
  2 |   colr:inherit;
             ^^^^^^^
  Error: Unknown property 'colr'. Did you mean 'color'?
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
  [%ocaml.error "Unknown property 'colr'. Did you mean 'color'?"];
