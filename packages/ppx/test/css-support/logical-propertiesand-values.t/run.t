This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
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
  CssJs.unsafe({js|captionSide|js}, {js|inline-start|js});
  CssJs.unsafe({js|captionSide|js}, {js|inline-end|js});
  CssJs.unsafe({js|float|js}, {js|inline-start|js});
  CssJs.unsafe({js|float|js}, {js|inline-end|js});
  CssJs.unsafe({js|clear|js}, {js|inline-start|js});
  CssJs.unsafe({js|clear|js}, {js|inline-end|js});
  CssJs.unsafe({js|resize|js}, {js|block|js});
  CssJs.unsafe({js|resize|js}, {js|inline|js});
  CssJs.unsafe({js|blockSize|js}, {js|100px|js});
  CssJs.unsafe({js|inlineSize|js}, {js|100px|js});
  CssJs.unsafe({js|minBlockSize|js}, {js|100px|js});
  CssJs.unsafe({js|minInlineSize|js}, {js|100px|js});
  CssJs.unsafe({js|maxBlockSize|js}, {js|100px|js});
  CssJs.unsafe({js|maxInlineSize|js}, {js|100px|js});
  CssJs.unsafe({js|marginBlock|js}, {js|10px|js});
  CssJs.unsafe({js|marginBlock|js}, {js|10px 10px|js});
  CssJs.unsafe({js|marginBlockStart|js}, {js|10px|js});
  CssJs.unsafe({js|marginBlockEnd|js}, {js|10px|js});
  CssJs.unsafe({js|marginInline|js}, {js|10px|js});
  CssJs.unsafe({js|marginInline|js}, {js|10px 10px|js});
  CssJs.unsafe({js|marginInlineStart|js}, {js|10px|js});
  CssJs.unsafe({js|marginInlineEnd|js}, {js|10px|js});
  CssJs.unsafe({js|inset|js}, {js|10px|js});
  CssJs.unsafe({js|inset|js}, {js|10px 10px|js});
  CssJs.unsafe({js|inset|js}, {js|10px 10px 10px|js});
  CssJs.unsafe({js|inset|js}, {js|10px 10px 10px 10px|js});
  CssJs.unsafe({js|insetBlock|js}, {js|10px|js});
  CssJs.unsafe({js|insetBlock|js}, {js|10px 10px|js});
  CssJs.unsafe({js|insetBlockStart|js}, {js|10px|js});
  CssJs.unsafe({js|insetBlockEnd|js}, {js|10px|js});
  CssJs.unsafe({js|insetInline|js}, {js|10px|js});
  CssJs.unsafe({js|insetInline|js}, {js|10px 10px|js});
  CssJs.unsafe({js|insetInlineStart|js}, {js|10px|js});
  CssJs.unsafe({js|insetInlineEnd|js}, {js|10px|js});
  CssJs.unsafe({js|paddingBlock|js}, {js|10px|js});
  CssJs.unsafe({js|paddingBlock|js}, {js|10px 10px|js});
  CssJs.unsafe({js|paddingBlockStart|js}, {js|10px|js});
  CssJs.unsafe({js|paddingBlockEnd|js}, {js|10px|js});
  CssJs.unsafe({js|paddingInline|js}, {js|10px|js});
  CssJs.unsafe({js|paddingInline|js}, {js|10px 10px|js});
  CssJs.unsafe({js|paddingInlineStart|js}, {js|10px|js});
  CssJs.unsafe({js|paddingInlineEnd|js}, {js|10px|js});
  CssJs.unsafe({js|borderBlock|js}, {js|1px|js});
  CssJs.unsafe({js|borderBlock|js}, {js|2px dotted|js});
  CssJs.unsafe({js|borderBlock|js}, {js|medium dashed green|js});
  CssJs.unsafe({js|borderBlockStart|js}, {js|1px|js});
  CssJs.unsafe({js|borderBlockStart|js}, {js|2px dotted|js});
  CssJs.unsafe({js|borderBlockStart|js}, {js|medium dashed green|js});
  CssJs.unsafe({js|borderBlockStartWidth|js}, {js|thin|js});
  CssJs.unsafe({js|borderBlockStartStyle|js}, {js|dotted|js});
  CssJs.unsafe({js|borderBlockStartColor|js}, {js|navy|js});
  CssJs.unsafe({js|borderBlockEnd|js}, {js|1px|js});
  CssJs.unsafe({js|borderBlockEnd|js}, {js|2px dotted|js});
  CssJs.unsafe({js|borderBlockEnd|js}, {js|medium dashed green|js});
  CssJs.unsafe({js|borderBlockEndWidth|js}, {js|thin|js});
  CssJs.unsafe({js|borderBlockEndStyle|js}, {js|dotted|js});
  CssJs.unsafe({js|borderBlockEndColor|js}, {js|navy|js});
  CssJs.unsafe({js|borderBlockColor|js}, {js|navy blue|js});
  CssJs.unsafe({js|borderInline|js}, {js|1px|js});
  CssJs.unsafe({js|borderInline|js}, {js|2px dotted|js});
  CssJs.unsafe({js|borderInline|js}, {js|medium dashed green|js});
  CssJs.unsafe({js|borderInlineStart|js}, {js|1px|js});
  CssJs.unsafe({js|borderInlineStart|js}, {js|2px dotted|js});
  CssJs.unsafe({js|borderInlineStart|js}, {js|medium dashed green|js});
  CssJs.unsafe({js|borderInlineStartWidth|js}, {js|thin|js});
  CssJs.unsafe({js|borderInlineStartStyle|js}, {js|dotted|js});
  CssJs.unsafe({js|borderInlineStartColor|js}, {js|navy|js});
  CssJs.unsafe({js|borderInlineEnd|js}, {js|1px|js});
  CssJs.unsafe({js|borderInlineEnd|js}, {js|2px dotted|js});
  CssJs.unsafe({js|borderInlineEnd|js}, {js|medium dashed green|js});
  CssJs.unsafe({js|borderInlineEndWidth|js}, {js|thin|js});
  CssJs.unsafe({js|borderInlineEndStyle|js}, {js|dotted|js});
  CssJs.unsafe({js|borderInlineEndColor|js}, {js|navy|js});
  CssJs.unsafe({js|borderInlineColor|js}, {js|navy blue|js});
  CssJs.unsafe({js|borderStartStartRadius|js}, {js|0|js});
  CssJs.unsafe({js|borderStartStartRadius|js}, {js|50%|js});
  CssJs.unsafe({js|borderStartStartRadius|js}, {js|250px 100px|js});
  CssJs.unsafe({js|borderStartEndRadius|js}, {js|0|js});
  CssJs.unsafe({js|borderStartEndRadius|js}, {js|50%|js});
  CssJs.unsafe({js|borderStartEndRadius|js}, {js|250px 100px|js});
  CssJs.unsafe({js|borderEndStartRadius|js}, {js|0|js});
  CssJs.unsafe({js|borderEndStartRadius|js}, {js|50%|js});
  CssJs.unsafe({js|borderEndStartRadius|js}, {js|250px 100px|js});
  CssJs.unsafe({js|borderEndEndRadius|js}, {js|0|js});
  CssJs.unsafe({js|borderEndEndRadius|js}, {js|50%|js});
  CssJs.unsafe({js|borderEndEndRadius|js}, {js|250px 100px|js});
