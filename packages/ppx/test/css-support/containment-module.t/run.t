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
  >  (preprocess (pps styled-ppx)))
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
  CssJs.unsafe({js|contain|js}, {js|none|js});
  CssJs.unsafe({js|contain|js}, {js|strict|js});
  CssJs.unsafe({js|contain|js}, {js|content|js});
  CssJs.unsafe({js|contain|js}, {js|size|js});
  CssJs.unsafe({js|contain|js}, {js|layout|js});
  CssJs.unsafe({js|contain|js}, {js|paint|js});
  CssJs.unsafe({js|contain|js}, {js|size layout|js});
  CssJs.unsafe({js|contain|js}, {js|size paint|js});
  CssJs.unsafe({js|contain|js}, {js|size layout paint|js});
  CssJs.style([|CssJs.width(`cqw(5.))|]);
  CssJs.style([|CssJs.width(`cqh(5.))|]);
  CssJs.style([|CssJs.width(`cqi(5.))|]);
  CssJs.style([|CssJs.width(`cqb(5.))|]);
  CssJs.style([|CssJs.width(`cqmin(5.))|]);
  CssJs.style([|CssJs.width(`cqmax(5.))|]);
  CssJs.style([|CssJs.unsafe({js|containerType|js}, {js|normal|js})|]);
  CssJs.style([|CssJs.unsafe({js|containerType|js}, {js|size|js})|]);
  CssJs.style([|CssJs.unsafe({js|containerType|js}, {js|inline-size|js})|]);
  CssJs.style([|CssJs.unsafe({js|containerName|js}, {js|none|js})|]);
  CssJs.style([|CssJs.unsafe({js|containerName|js}, {js|x|js})|]);
  CssJs.style([|CssJs.unsafe({js|containerName|js}, {js|x y|js})|]);
  CssJs.style([|CssJs.unsafe({js|container|js}, {js|none|js})|]);
  CssJs.style([|CssJs.unsafe({js|container|js}, {js|x / normal|js})|]);
  CssJs.style([|CssJs.unsafe({js|container|js}, {js|x / size|js})|]);
  CssJs.style([|CssJs.unsafe({js|container|js}, {js|x / inline-size|js})|]);
  CssJs.style([|CssJs.unsafe({js|container|js}, {js|x y / size|js})|]);
