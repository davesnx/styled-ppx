This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
  >  (preprocess (pps styled-ppx.lib)))
  > EOF

  $ dune build

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
  CssJs.unsafe({js|lineClamp|js}, {js|none|js});
  CssJs.unsafe({js|lineClamp|js}, {js|1|js});
  CssJs.unsafe({js|maxLines|js}, {js|none|js});
  CssJs.unsafe({js|maxLines|js}, {js|1|js});
  CssJs.overflowX(`visible);
  CssJs.overflowX(`hidden);
  CssJs.overflowX(`clip);
  CssJs.overflowX(`scroll);
  CssJs.overflowX(`auto);
  CssJs.overflowY(`visible);
  CssJs.overflowY(`hidden);
  CssJs.overflowY(`clip);
  CssJs.overflowY(`scroll);
  CssJs.overflowY(`auto);
  CssJs.overflowInline(`visible);
  CssJs.overflowInline(`hidden);
  CssJs.overflowInline(`clip);
  CssJs.overflowInline(`scroll);
  CssJs.overflowInline(`auto);
  CssJs.overflowBlock(`visible);
  CssJs.overflowBlock(`hidden);
  CssJs.overflowBlock(`clip);
  CssJs.overflowBlock(`scroll);
  CssJs.overflowBlock(`auto);
