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
  CssJs.transitionProperty({js|none|js});
  CssJs.transitionProperty({js|all|js});
  CssJs.transitionProperty({js|width|js});
  CssJs.unsafe({js|transitionProperty|js}, {js|width, height|js});
  CssJs.transitionDuration(`s(0));
  CssJs.transitionDuration(`s(1));
  CssJs.transitionDuration(`ms(100));
  CssJs.transitionTimingFunction(`ease);
  CssJs.transitionTimingFunction(`linear);
  CssJs.transitionTimingFunction(`easeIn);
  CssJs.transitionTimingFunction(`easeOut);
  CssJs.transitionTimingFunction(`easeInOut);
  CssJs.transitionTimingFunction(`cubicBezier((0.5, 0.5, 0.5, 0.5)));
  CssJs.transitionTimingFunction(`cubicBezier((0.5, 1.5, 0.5, (-2.5))));
  CssJs.transitionTimingFunction(`stepStart);
  CssJs.transitionTimingFunction(`stepEnd);
  CssJs.transitionTimingFunction(`steps((3, `start)));
  CssJs.transitionTimingFunction(`steps((5, `end_)));
  CssJs.transitionDelay(`s(1));
  CssJs.transitionDelay(`s(-1));
  CssJs.unsafe({js|transition|js}, {js|1s 2s width linear|js});
