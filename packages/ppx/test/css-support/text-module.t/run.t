This test ensures the ppx generates the correct output against styled-ppx.emotion_native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native)
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
  CssJs.unsafe({js|textTransform|js}, {js|full-width|js});
  CssJs.unsafe({js|textTransform|js}, {js|full-size-kana|js});
  CssJs.tabSize(`num(4.));
  CssJs.tabSize(`em(1.));
  CssJs.lineBreak(`auto);
  CssJs.lineBreak(`loose);
  CssJs.lineBreak(`normal);
  CssJs.lineBreak(`strict);
  CssJs.lineBreak(`anywhere);
  CssJs.wordBreak(`normal);
  CssJs.wordBreak(`keepAll);
  CssJs.wordBreak(`breakAll);
  CssJs.whiteSpace(`breakSpaces);
  CssJs.hyphens(`auto);
  CssJs.hyphens(`manual);
  CssJs.hyphens(`none);
  CssJs.overflowWrap(`normal);
  CssJs.unsafe({js|overflowWrap|js}, {js|break-word|js});
  CssJs.overflowWrap(`anywhere);
  CssJs.wordWrap(`normal);
  CssJs.unsafe({js|wordWrap|js}, {js|break-word|js});
  CssJs.wordWrap(`anywhere);
  CssJs.textAlign(`start);
  CssJs.textAlign(`end_);
  CssJs.textAlign(`left);
  CssJs.textAlign(`right);
  CssJs.textAlign(`center);
  CssJs.textAlign(`justify);
  CssJs.textAlign(`matchParent);
  CssJs.textAlign(`justifyAll);
  CssJs.textAlignAll(`start);
  CssJs.textAlignAll(`end_);
  CssJs.textAlignAll(`left);
  CssJs.textAlignAll(`right);
  CssJs.textAlignAll(`center);
  CssJs.textAlignAll(`justify);
  CssJs.textAlignAll(`matchParent);
  CssJs.textAlignLast(`auto);
  CssJs.textAlignLast(`start);
  CssJs.textAlignLast(`end_);
  CssJs.textAlignLast(`left);
  CssJs.textAlignLast(`right);
  CssJs.textAlignLast(`center);
  CssJs.textAlignLast(`justify);
  CssJs.textAlignLast(`matchParent);
  CssJs.textJustify(`auto);
  CssJs.textJustify(`none);
  CssJs.textJustify(`interWord);
  CssJs.textJustify(`interCharacter);
  CssJs.wordSpacing(`percent(50.));
  CssJs.unsafe({js|textIndent|js}, {js|1em hanging|js});
  CssJs.unsafe({js|textIndent|js}, {js|1em each-line|js});
  CssJs.unsafe({js|textIndent|js}, {js|1em hanging each-line|js});
  CssJs.unsafe({js|hangingPunctuation|js}, {js|none|js});
  CssJs.unsafe({js|hangingPunctuation|js}, {js|first|js});
  CssJs.unsafe({js|hangingPunctuation|js}, {js|last|js});
  CssJs.unsafe({js|hangingPunctuation|js}, {js|force-end|js});
  CssJs.unsafe({js|hangingPunctuation|js}, {js|allow-end|js});
  CssJs.unsafe({js|hangingPunctuation|js}, {js|first last|js});
  CssJs.unsafe({js|hangingPunctuation|js}, {js|first force-end|js});
  CssJs.unsafe({js|hangingPunctuation|js}, {js|first force-end last|js});
  CssJs.unsafe({js|hangingPunctuation|js}, {js|first allow-end last|js});
