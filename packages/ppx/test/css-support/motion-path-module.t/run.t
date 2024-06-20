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
  CssJs.unsafe({|offset|}, {|none|});
  CssJs.unsafe({|offset|}, {|auto|});
  CssJs.unsafe({|offset|}, {|center|});
  CssJs.unsafe({|offset|}, {|200px 100px|});
  CssJs.unsafe({|offset|}, {|margin-box|});
  CssJs.unsafe({|offset|}, {|border-box|});
  CssJs.unsafe({|offset|}, {|padding-box|});
  CssJs.unsafe({|offset|}, {|content-box|});
  CssJs.unsafe({|offset|}, {|fill-box|});
  CssJs.unsafe({|offset|}, {|stroke-box|});
  CssJs.unsafe({|offset|}, {|view-box|});
  CssJs.unsafe({|offset|}, {|path('M 20 20 H 80 V 30')|});
  CssJs.unsafe({|offset|}, {|url(image.png)|});
  CssJs.unsafe({|offset|}, {|ray(45deg closest-side)|});
  CssJs.unsafe({|offset|}, {|ray(45deg closest-side) 10%|});
  CssJs.unsafe({|offset|}, {|ray(45deg closest-side) 10% reverse|});
  CssJs.unsafe({|offset|}, {|ray(45deg closest-side) reverse 10%|});
  CssJs.unsafe({|offset|}, {|auto / center|});
  CssJs.unsafe({|offset|}, {|center / 200px 100px|});
  CssJs.unsafe({|offset|}, {|ray(45deg closest-side) / 200px 100px|});
  CssJs.unsafe({|offsetPath|}, {|none|});
  CssJs.unsafe({|offsetPath|}, {|ray(45deg closest-side)|});
  CssJs.unsafe({|offsetPath|}, {|ray(45deg farthest-side)|});
  CssJs.unsafe({|offsetPath|}, {|ray(45deg closest-corner)|});
  CssJs.unsafe({|offsetPath|}, {|ray(45deg farthest-corner)|});
  CssJs.unsafe({|offsetPath|}, {|ray(100grad closest-side contain)|});
  CssJs.unsafe({|offsetPath|}, {|margin-box|});
  CssJs.unsafe({|offsetPath|}, {|border-box|});
  CssJs.unsafe({|offsetPath|}, {|padding-box|});
  CssJs.unsafe({|offsetPath|}, {|content-box|});
  CssJs.unsafe({|offsetPath|}, {|fill-box|});
  CssJs.unsafe({|offsetPath|}, {|stroke-box|});
  CssJs.unsafe({|offsetPath|}, {|view-box|});
  CssJs.unsafe({|offsetPath|}, {|circle(60%) margin-box|});
  CssJs.unsafe({|offsetDistance|}, {|10%|});
  CssJs.unsafe({|offsetPosition|}, {|auto|});
  CssJs.unsafe({|offsetPosition|}, {|200px|});
  CssJs.unsafe({|offsetPosition|}, {|200px 100px|});
  CssJs.unsafe({|offsetPosition|}, {|center|});
  CssJs.unsafe({|offsetAnchor|}, {|auto|});
  CssJs.unsafe({|offsetAnchor|}, {|200px|});
  CssJs.unsafe({|offsetAnchor|}, {|200px 100px|});
  CssJs.unsafe({|offsetAnchor|}, {|center|});
  CssJs.unsafe({|offsetRotate|}, {|auto|});
  CssJs.unsafe({|offsetRotate|}, {|0deg|});
  CssJs.unsafe({|offsetRotate|}, {|reverse|});
  CssJs.unsafe({|offsetRotate|}, {|-45deg|});
  CssJs.unsafe({|offsetRotate|}, {|auto 180deg|});
  CssJs.unsafe({|offsetRotate|}, {|reverse 45deg|});
  CssJs.unsafe({|offsetRotate|}, {|2turn reverse|});
