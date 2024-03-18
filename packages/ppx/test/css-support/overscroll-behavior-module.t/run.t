This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat >dune-project <<EOF
  > (lang dune 3.10)
  > EOF

  $ cat >dune <<EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
  >  (preprocess (pps styled-ppx.lib)))
  > EOF

  $ dune build

  $ dune_describe_pp _build/default/input.re.pp.ml | refmt --parse ml --print re
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
  CssJs.unsafe({js|overscrollBehavior|js}, {js|contain|js});
  CssJs.unsafe({js|overscrollBehavior|js}, {js|none|js});
  CssJs.unsafe({js|overscrollBehavior|js}, {js|auto|js});
  CssJs.unsafe({js|overscrollBehavior|js}, {js|contain contain|js});
  CssJs.unsafe({js|overscrollBehavior|js}, {js|none contain|js});
  CssJs.unsafe({js|overscrollBehavior|js}, {js|auto contain|js});
  CssJs.unsafe({js|overscrollBehavior|js}, {js|contain none|js});
  CssJs.unsafe({js|overscrollBehavior|js}, {js|none none|js});
  CssJs.unsafe({js|overscrollBehavior|js}, {js|auto none|js});
  CssJs.unsafe({js|overscrollBehavior|js}, {js|contain auto|js});
  CssJs.unsafe({js|overscrollBehavior|js}, {js|none auto|js});
  CssJs.unsafe({js|overscrollBehavior|js}, {js|auto auto|js});
  CssJs.unsafe({js|overscrollBehaviorX|js}, {js|contain|js});
  CssJs.unsafe({js|overscrollBehaviorX|js}, {js|none|js});
  CssJs.unsafe({js|overscrollBehaviorX|js}, {js|auto|js});
  CssJs.unsafe({js|overscrollBehaviorY|js}, {js|contain|js});
  CssJs.unsafe({js|overscrollBehaviorY|js}, {js|none|js});
  CssJs.unsafe({js|overscrollBehaviorY|js}, {js|auto|js});
  CssJs.unsafe({js|overscrollBehaviorInline|js}, {js|contain|js});
  CssJs.unsafe({js|overscrollBehaviorInline|js}, {js|none|js});
  CssJs.unsafe({js|overscrollBehaviorInline|js}, {js|auto|js});
  CssJs.unsafe({js|overscrollBehaviorBlock|js}, {js|contain|js});
  CssJs.unsafe({js|overscrollBehaviorBlock|js}, {js|none|js});
  CssJs.unsafe({js|overscrollBehaviorBlock|js}, {js|auto|js});
