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
  File "input.re", line 6, characters 10-18:
  Error: Property 'color' has an invalid value: 'cositas'
  [1]

  $ dune describe pp ./input.re.ml | refmt --parse ml --print re
  [@ocaml.ppx.context
    {
      tool_name: "ppx_driver",
      include_dirs: [],
      load_path: [],
      open_modules: [],
      for_package: None,
      debug: false,
      use_threads: false,
      use_vmthreads: false,
      recursive_types: false,
      principal: false,
      transparent_modules: false,
      unboxed_types: false,
      unsafe_string: false,
      cookies: [],
    }
  ];
  let selectors =
    CSS.style([|
      CSS.label("selectors"),
      CSS.color(CSS.white),
      CSS.selector(
        {js|&:hover|js},
        [|[%ocaml.error "Property 'color' has an invalid value: 'cositas'"]|],
      ),
    |]);

[%cx {js|display: blocki;              width: 10px; |js}];
