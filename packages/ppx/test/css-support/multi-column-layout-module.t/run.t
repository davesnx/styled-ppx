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
  CssJs.columnWidth(`em(10.));
  CssJs.columnWidth(`auto);
  CssJs.unsafe({|columnCount|}, {|2|});
  CssJs.unsafe({|columnCount|}, {|auto|});
  CssJs.unsafe({|columns|}, {|100px|});
  CssJs.unsafe({|columns|}, {|3|});
  CssJs.unsafe({|columns|}, {|10em 2|});
  CssJs.unsafe({|columns|}, {|auto auto|});
  CssJs.unsafe({|columns|}, {|2 10em|});
  CssJs.unsafe({|columns|}, {|auto 10em|});
  CssJs.unsafe({|columns|}, {|2 auto|});
  CssJs.unsafe({|columnRuleColor|}, {|red|});
  CssJs.unsafe({|columnRuleStyle|}, {|none|});
  CssJs.unsafe({|columnRuleStyle|}, {|solid|});
  CssJs.unsafe({|columnRuleStyle|}, {|dotted|});
  CssJs.unsafe({|columnRuleWidth|}, {|1px|});
  CssJs.unsafe({|columnRule|}, {|transparent|});
  CssJs.unsafe({|columnRule|}, {|1px solid black|});
  CssJs.unsafe({|columnSpan|}, {|none|});
  CssJs.unsafe({|columnSpan|}, {|all|});
  CssJs.unsafe({|columnFill|}, {|auto|});
  CssJs.unsafe({|columnFill|}, {|balance|});
  CssJs.unsafe({|columnFill|}, {|balance-all|});
