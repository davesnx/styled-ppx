This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.css_native styled-ppx.emotion_native)
  >  (preprocess (pps styled-ppx.lib)))
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
      CssJs.unsafe({js|userSelect|js}, {js|none|js}),
      CssJs.selector(
        {js|.recharts-cartesian-grid-horizontal|js},
        [|
          CssJs.selector(
            {js|line|js},
            [|
              CssJs.selector(
                {js|:nth-last-child(1), :nth-last-child(2)|js},
                [|CssJs.SVG.strokeOpacity(`num(0.))|],
              ),
            |],
          ),
        |],
      ),
      CssJs.selector(
        {js|.recharts-scatter .recharts-scatter-symbol .recharts-symbols|js},
        [|
          CssJs.opacity(0.8),
          CssJs.selector({js|:hover|js}, [|CssJs.opacity(1.)|]),
        |],
      ),
    |]);

  $ dune build
