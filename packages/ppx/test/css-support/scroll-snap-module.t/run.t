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
  CssJs.unsafe({|scrollMargin|}, {|0px|});
  CssJs.unsafe({|scrollMargin|}, {|6px 5px|});
  CssJs.unsafe({|scrollMargin|}, {|10px 20px 30px|});
  CssJs.unsafe({|scrollMargin|}, {|10px 20px 30px 40px|});
  CssJs.unsafe({|scrollMargin|}, {|20px 3em 1in 5rem|});
  CssJs.unsafe({|scrollMargin|}, {|calc(2px)|});
  CssJs.unsafe({|scrollMargin|}, {|calc(3 * 25px)|});
  CssJs.unsafe({|scrollMargin|}, {|calc(3 * 25px) 5px 10em calc(1vw - 5px)|});
  CssJs.unsafe({|scrollMarginBlock|}, {|10px|});
  CssJs.unsafe({|scrollMarginBlock|}, {|10px 10px|});
  CssJs.unsafe({|scrollMarginBlockEnd|}, {|10px|});
  CssJs.unsafe({|scrollMarginBlockStart|}, {|10px|});
  CssJs.unsafe({|scrollMarginBottom|}, {|10px|});
  CssJs.unsafe({|scrollMarginInline|}, {|10px|});
  CssJs.unsafe({|scrollMarginInline|}, {|10px 10px|});
  CssJs.unsafe({|scrollMarginInlineStart|}, {|10px|});
  CssJs.unsafe({|scrollMarginInlineEnd|}, {|10px|});
  CssJs.unsafe({|scrollMarginLeft|}, {|10px|});
  CssJs.unsafe({|scrollMarginRight|}, {|10px|});
  CssJs.unsafe({|scrollMarginTop|}, {|10px|});
  CssJs.unsafe({|scrollPadding|}, {|auto|});
  CssJs.unsafe({|scrollPadding|}, {|0px|});
  CssJs.unsafe({|scrollPadding|}, {|6px 5px|});
  CssJs.unsafe({|scrollPadding|}, {|10px 20px 30px|});
  CssJs.unsafe({|scrollPadding|}, {|10px 20px 30px 40px|});
  CssJs.unsafe({|scrollPadding|}, {|10px auto 30px auto|});
  CssJs.unsafe({|scrollPadding|}, {|10%|});
  CssJs.unsafe({|scrollPadding|}, {|20% 3em 1in 5rem|});
  CssJs.unsafe({|scrollPadding|}, {|calc(2px)|});
  CssJs.unsafe({|scrollPadding|}, {|calc(50%)|});
  CssJs.unsafe({|scrollPadding|}, {|calc(3 * 25px)|});
  CssJs.unsafe({|scrollPadding|}, {|calc(3 * 25px) 5px 10% calc(10% - 5px)|});
  CssJs.unsafe({|scrollPaddingBlock|}, {|10px|});
  CssJs.unsafe({|scrollPaddingBlock|}, {|50%|});
  CssJs.unsafe({|scrollPaddingBlock|}, {|10px 50%|});
  CssJs.unsafe({|scrollPaddingBlock|}, {|50% 50%|});
  CssJs.unsafe({|scrollPaddingBlockEnd|}, {|10px|});
  CssJs.unsafe({|scrollPaddingBlockEnd|}, {|50%|});
  CssJs.unsafe({|scrollPaddingBlockStart|}, {|10px|});
  CssJs.unsafe({|scrollPaddingBlockStart|}, {|50%|});
  CssJs.unsafe({|scrollPaddingBottom|}, {|10px|});
  CssJs.unsafe({|scrollPaddingBottom|}, {|50%|});
  CssJs.unsafe({|scrollPaddingInline|}, {|10px|});
  CssJs.unsafe({|scrollPaddingInline|}, {|50%|});
  CssJs.unsafe({|scrollPaddingInline|}, {|10px 50%|});
  CssJs.unsafe({|scrollPaddingInline|}, {|50% 50%|});
  CssJs.unsafe({|scrollPaddingInlineEnd|}, {|10px|});
  CssJs.unsafe({|scrollPaddingInlineEnd|}, {|50%|});
  CssJs.unsafe({|scrollPaddingInlineStart|}, {|10px|});
  CssJs.unsafe({|scrollPaddingInlineStart|}, {|50%|});
  CssJs.unsafe({|scrollPaddingLeft|}, {|10px|});
  CssJs.unsafe({|scrollPaddingLeft|}, {|50%|});
  CssJs.unsafe({|scrollPaddingRight|}, {|10px|});
  CssJs.unsafe({|scrollPaddingRight|}, {|50%|});
  CssJs.unsafe({|scrollPaddingTop|}, {|10px|});
  CssJs.unsafe({|scrollPaddingTop|}, {|50%|});
  CssJs.unsafe({|scrollSnapAlign|}, {|none|});
  CssJs.unsafe({|scrollSnapAlign|}, {|start|});
  CssJs.unsafe({|scrollSnapAlign|}, {|end|});
  CssJs.unsafe({|scrollSnapAlign|}, {|center|});
  CssJs.unsafe({|scrollSnapAlign|}, {|none start|});
  CssJs.unsafe({|scrollSnapAlign|}, {|end center|});
  CssJs.unsafe({|scrollSnapAlign|}, {|center start|});
  CssJs.unsafe({|scrollSnapAlign|}, {|end none|});
  CssJs.unsafe({|scrollSnapAlign|}, {|center center|});
  CssJs.unsafe({|scrollSnapStop|}, {|normal|});
  CssJs.unsafe({|scrollSnapStop|}, {|always|});
  CssJs.unsafe({|scrollSnapType|}, {|none|});
  CssJs.unsafe({|scrollSnapType|}, {|x mandatory|});
  CssJs.unsafe({|scrollSnapType|}, {|y mandatory|});
  CssJs.unsafe({|scrollSnapType|}, {|block mandatory|});
  CssJs.unsafe({|scrollSnapType|}, {|inline mandatory|});
  CssJs.unsafe({|scrollSnapType|}, {|both mandatory|});
  CssJs.unsafe({|scrollSnapType|}, {|x proximity|});
  CssJs.unsafe({|scrollSnapType|}, {|y proximity|});
  CssJs.unsafe({|scrollSnapType|}, {|block proximity|});
  CssJs.unsafe({|scrollSnapType|}, {|inline proximity|});
  CssJs.unsafe({|scrollSnapType|}, {|both proximity|});
