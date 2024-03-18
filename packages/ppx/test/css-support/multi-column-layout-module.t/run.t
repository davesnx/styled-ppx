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
  CssJs.columnWidth(`em(10.));
  CssJs.columnWidth(`auto);
  CssJs.unsafe({js|columnCount|js}, {js|2|js});
  CssJs.unsafe({js|columnCount|js}, {js|auto|js});
  CssJs.unsafe({js|columns|js}, {js|100px|js});
  CssJs.unsafe({js|columns|js}, {js|3|js});
  CssJs.unsafe({js|columns|js}, {js|10em 2|js});
  CssJs.unsafe({js|columns|js}, {js|auto auto|js});
  CssJs.unsafe({js|columns|js}, {js|2 10em|js});
  CssJs.unsafe({js|columns|js}, {js|auto 10em|js});
  CssJs.unsafe({js|columns|js}, {js|2 auto|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|red|js});
  CssJs.unsafe({js|columnRuleStyle|js}, {js|none|js});
  CssJs.unsafe({js|columnRuleStyle|js}, {js|solid|js});
  CssJs.unsafe({js|columnRuleStyle|js}, {js|dotted|js});
  CssJs.unsafe({js|columnRuleWidth|js}, {js|1px|js});
  CssJs.unsafe({js|columnRule|js}, {js|transparent|js});
  CssJs.unsafe({js|columnRule|js}, {js|1px solid black|js});
  CssJs.unsafe({js|columnSpan|js}, {js|none|js});
  CssJs.unsafe({js|columnSpan|js}, {js|all|js});
  CssJs.unsafe({js|columnFill|js}, {js|auto|js});
  CssJs.unsafe({js|columnFill|js}, {js|balance|js});
  CssJs.unsafe({js|columnFill|js}, {js|balance-all|js});
