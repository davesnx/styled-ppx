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

  $ dune describe pp ./input.re
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
  
  CSS.unsafe({js|textTransform|js}, {js|full-width|js});
  CSS.unsafe({js|textTransform|js}, {js|full-size-kana|js});
  
  CSS.tabSize(`num(4.));
  CSS.tabSize(`em(1.));
  CSS.lineBreak(`auto);
  CSS.lineBreak(`loose);
  CSS.lineBreak(`normal);
  CSS.lineBreak(`strict);
  CSS.lineBreak(`anywhere);
  CSS.wordBreak(`normal);
  CSS.wordBreak(`keepAll);
  CSS.wordBreak(`breakAll);
  CSS.whiteSpace(`breakSpaces);
  CSS.hyphens(`auto);
  CSS.hyphens(`manual);
  CSS.hyphens(`none);
  CSS.overflowWrap(`normal);
  CSS.unsafe({js|overflowWrap|js}, {js|break-word|js});
  CSS.overflowWrap(`anywhere);
  CSS.wordWrap(`normal);
  CSS.unsafe({js|wordWrap|js}, {js|break-word|js});
  CSS.wordWrap(`anywhere);
  CSS.textAlign(`start);
  CSS.textAlign(`end_);
  CSS.textAlign(`left);
  CSS.textAlign(`right);
  CSS.textAlign(`center);
  CSS.textAlign(`justify);
  CSS.textAlign(`matchParent);
  CSS.textAlign(`justifyAll);
  CSS.textAlignAll(`start);
  CSS.textAlignAll(`end_);
  CSS.textAlignAll(`left);
  CSS.textAlignAll(`right);
  CSS.textAlignAll(`center);
  CSS.textAlignAll(`justify);
  CSS.textAlignAll(`matchParent);
  CSS.textAlignLast(`auto);
  CSS.textAlignLast(`start);
  CSS.textAlignLast(`end_);
  CSS.textAlignLast(`left);
  CSS.textAlignLast(`right);
  CSS.textAlignLast(`center);
  CSS.textAlignLast(`justify);
  CSS.textAlignLast(`matchParent);
  CSS.textJustify(`auto);
  CSS.textJustify(`none);
  CSS.textJustify(`interWord);
  CSS.textJustify(`interCharacter);
  CSS.wordSpacing(`percent(50.));
  CSS.unsafe({js|textIndent|js}, {js|1em hanging|js});
  CSS.unsafe({js|textIndent|js}, {js|1em each-line|js});
  CSS.unsafe({js|textIndent|js}, {js|1em hanging each-line|js});
  CSS.unsafe({js|hangingPunctuation|js}, {js|none|js});
  CSS.unsafe({js|hangingPunctuation|js}, {js|first|js});
  CSS.unsafe({js|hangingPunctuation|js}, {js|last|js});
  CSS.unsafe({js|hangingPunctuation|js}, {js|force-end|js});
  CSS.unsafe({js|hangingPunctuation|js}, {js|allow-end|js});
  CSS.unsafe({js|hangingPunctuation|js}, {js|first last|js});
  CSS.unsafe({js|hangingPunctuation|js}, {js|first force-end|js});
  CSS.unsafe({js|hangingPunctuation|js}, {js|first force-end last|js});
  CSS.unsafe({js|hangingPunctuation|js}, {js|first allow-end last|js});
