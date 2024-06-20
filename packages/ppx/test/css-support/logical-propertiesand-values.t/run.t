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
  CssJs.unsafe({|captionSide|}, {|inline-start|});
  CssJs.unsafe({|captionSide|}, {|inline-end|});
  CssJs.unsafe({|float|}, {|inline-start|});
  CssJs.unsafe({|float|}, {|inline-end|});
  CssJs.unsafe({|clear|}, {|inline-start|});
  CssJs.unsafe({|clear|}, {|inline-end|});
  CssJs.unsafe({|resize|}, {|block|});
  CssJs.unsafe({|resize|}, {|inline|});
  CssJs.unsafe({|blockSize|}, {|100px|});
  CssJs.unsafe({|inlineSize|}, {|100px|});
  CssJs.unsafe({|minBlockSize|}, {|100px|});
  CssJs.unsafe({|minInlineSize|}, {|100px|});
  CssJs.unsafe({|maxBlockSize|}, {|100px|});
  CssJs.unsafe({|maxInlineSize|}, {|100px|});
  CssJs.unsafe({|marginBlock|}, {|10px|});
  CssJs.unsafe({|marginBlock|}, {|10px 10px|});
  CssJs.unsafe({|marginBlockStart|}, {|10px|});
  CssJs.unsafe({|marginBlockEnd|}, {|10px|});
  CssJs.unsafe({|marginInline|}, {|10px|});
  CssJs.unsafe({|marginInline|}, {|10px 10px|});
  CssJs.unsafe({|marginInlineStart|}, {|10px|});
  CssJs.unsafe({|marginInlineEnd|}, {|10px|});
  CssJs.unsafe({|inset|}, {|10px|});
  CssJs.unsafe({|inset|}, {|10px 10px|});
  CssJs.unsafe({|inset|}, {|10px 10px 10px|});
  CssJs.unsafe({|inset|}, {|10px 10px 10px 10px|});
  CssJs.unsafe({|insetBlock|}, {|10px|});
  CssJs.unsafe({|insetBlock|}, {|10px 10px|});
  CssJs.unsafe({|insetBlockStart|}, {|10px|});
  CssJs.unsafe({|insetBlockEnd|}, {|10px|});
  CssJs.unsafe({|insetInline|}, {|10px|});
  CssJs.unsafe({|insetInline|}, {|10px 10px|});
  CssJs.unsafe({|insetInlineStart|}, {|10px|});
  CssJs.unsafe({|insetInlineEnd|}, {|10px|});
  CssJs.unsafe({|paddingBlock|}, {|10px|});
  CssJs.unsafe({|paddingBlock|}, {|10px 10px|});
  CssJs.unsafe({|paddingBlockStart|}, {|10px|});
  CssJs.unsafe({|paddingBlockEnd|}, {|10px|});
  CssJs.unsafe({|paddingInline|}, {|10px|});
  CssJs.unsafe({|paddingInline|}, {|10px 10px|});
  CssJs.unsafe({|paddingInlineStart|}, {|10px|});
  CssJs.unsafe({|paddingInlineEnd|}, {|10px|});
  CssJs.unsafe({|borderBlock|}, {|1px|});
  CssJs.unsafe({|borderBlock|}, {|2px dotted|});
  CssJs.unsafe({|borderBlock|}, {|medium dashed green|});
  CssJs.unsafe({|borderBlockStart|}, {|1px|});
  CssJs.unsafe({|borderBlockStart|}, {|2px dotted|});
  CssJs.unsafe({|borderBlockStart|}, {|medium dashed green|});
  CssJs.unsafe({|borderBlockStartWidth|}, {|thin|});
  CssJs.unsafe({|borderBlockStartStyle|}, {|dotted|});
  CssJs.unsafe({|borderBlockStartColor|}, {|navy|});
  CssJs.unsafe({|borderBlockEnd|}, {|1px|});
  CssJs.unsafe({|borderBlockEnd|}, {|2px dotted|});
  CssJs.unsafe({|borderBlockEnd|}, {|medium dashed green|});
  CssJs.unsafe({|borderBlockEndWidth|}, {|thin|});
  CssJs.unsafe({|borderBlockEndStyle|}, {|dotted|});
  CssJs.unsafe({|borderBlockEndColor|}, {|navy|});
  CssJs.unsafe({|borderBlockColor|}, {|navy blue|});
  CssJs.unsafe({|borderInline|}, {|1px|});
  CssJs.unsafe({|borderInline|}, {|2px dotted|});
  CssJs.unsafe({|borderInline|}, {|medium dashed green|});
  CssJs.unsafe({|borderInlineStart|}, {|1px|});
  CssJs.unsafe({|borderInlineStart|}, {|2px dotted|});
  CssJs.unsafe({|borderInlineStart|}, {|medium dashed green|});
  CssJs.unsafe({|borderInlineStartWidth|}, {|thin|});
  CssJs.unsafe({|borderInlineStartStyle|}, {|dotted|});
  CssJs.unsafe({|borderInlineStartColor|}, {|navy|});
  CssJs.unsafe({|borderInlineEnd|}, {|1px|});
  CssJs.unsafe({|borderInlineEnd|}, {|2px dotted|});
  CssJs.unsafe({|borderInlineEnd|}, {|medium dashed green|});
  CssJs.unsafe({|borderInlineEndWidth|}, {|thin|});
  CssJs.unsafe({|borderInlineEndStyle|}, {|dotted|});
  CssJs.unsafe({|borderInlineEndColor|}, {|navy|});
  CssJs.unsafe({|borderInlineColor|}, {|navy blue|});
  CssJs.unsafe({|borderStartStartRadius|}, {|0|});
  CssJs.unsafe({|borderStartStartRadius|}, {|50%|});
  CssJs.unsafe({|borderStartStartRadius|}, {|250px 100px|});
  CssJs.unsafe({|borderStartEndRadius|}, {|0|});
  CssJs.unsafe({|borderStartEndRadius|}, {|50%|});
  CssJs.unsafe({|borderStartEndRadius|}, {|250px 100px|});
  CssJs.unsafe({|borderEndStartRadius|}, {|0|});
  CssJs.unsafe({|borderEndStartRadius|}, {|50%|});
  CssJs.unsafe({|borderEndStartRadius|}, {|250px 100px|});
  CssJs.unsafe({|borderEndEndRadius|}, {|0|});
  CssJs.unsafe({|borderEndEndRadius|}, {|50%|});
  CssJs.unsafe({|borderEndEndRadius|}, {|250px 100px|});
