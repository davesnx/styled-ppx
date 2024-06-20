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
  CssJs.unsafe({|textTransform|}, {|full-width|});
  CssJs.unsafe({|textTransform|}, {|full-size-kana|});
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
  CssJs.unsafe({|overflowWrap|}, {|break-word|});
  CssJs.overflowWrap(`anywhere);
  CssJs.wordWrap(`normal);
  CssJs.unsafe({|wordWrap|}, {|break-word|});
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
  CssJs.unsafe({|textIndent|}, {|1em hanging|});
  CssJs.unsafe({|textIndent|}, {|1em each-line|});
  CssJs.unsafe({|textIndent|}, {|1em hanging each-line|});
  CssJs.unsafe({|hangingPunctuation|}, {|none|});
  CssJs.unsafe({|hangingPunctuation|}, {|first|});
  CssJs.unsafe({|hangingPunctuation|}, {|last|});
  CssJs.unsafe({|hangingPunctuation|}, {|force-end|});
  CssJs.unsafe({|hangingPunctuation|}, {|allow-end|});
  CssJs.unsafe({|hangingPunctuation|}, {|first last|});
  CssJs.unsafe({|hangingPunctuation|}, {|first force-end|});
  CssJs.unsafe({|hangingPunctuation|}, {|first force-end last|});
  CssJs.unsafe({|hangingPunctuation|}, {|first allow-end last|});
