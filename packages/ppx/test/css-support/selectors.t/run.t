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
  let _chart =
    CssJs.style([|
      CssJs.label("_chart"),
      CssJs.userSelect(`none),
      CssJs.selector(
        {js|.recharts-cartesian-grid-horizontal|js},
        [|
          CSS.selector(
            {js|line|js},
            [|
              CSS.selector(
                {js|:nth-last-child(1), :nth-last-child(2)|js},
                [|CSS.SVG.strokeOpacity(`num(0.))|],
              ),
            |],
          ),
        |],
      ),
      CSS.selector(
        {js|.recharts-scatter .recharts-scatter-symbol .recharts-symbols|js},
        [|
          CSS.opacity(0.8),
          CSS.selector({js|:hover|js}, [|CSS.opacity(1.)|]),
        |],
      ),
    |]);

  $ dune build
