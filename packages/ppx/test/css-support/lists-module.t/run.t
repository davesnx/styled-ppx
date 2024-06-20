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
  CssJs.unsafe({|listStyleType|}, {|disclosure-closed|});
  CssJs.unsafe({|listStyleType|}, {|disclosure-open|});
  CssJs.unsafe({|listStyleType|}, {|hebrew|});
  CssJs.unsafe({|listStyleType|}, {|cjk-decimal|});
  CssJs.unsafe({|listStyleType|}, {|cjk-ideographic|});
  CssJs.unsafe({|listStyleType|}, {|hiragana|});
  CssJs.unsafe({|listStyleType|}, {|katakana|});
  CssJs.unsafe({|listStyleType|}, {|hiragana-iroha|});
  CssJs.unsafe({|listStyleType|}, {|katakana-iroha|});
  CssJs.unsafe({|listStyleType|}, {|japanese-informal|});
  CssJs.unsafe({|listStyleType|}, {|japanese-formal|});
  CssJs.unsafe({|listStyleType|}, {|korean-hangul-formal|});
  CssJs.unsafe({|listStyleType|}, {|korean-hanja-informal|});
  CssJs.unsafe({|listStyleType|}, {|korean-hanja-formal|});
  CssJs.unsafe({|listStyleType|}, {|simp-chinese-informal|});
  CssJs.unsafe({|listStyleType|}, {|simp-chinese-formal|});
  CssJs.unsafe({|listStyleType|}, {|trad-chinese-informal|});
  CssJs.unsafe({|listStyleType|}, {|trad-chinese-formal|});
  CssJs.unsafe({|listStyleType|}, {|cjk-heavenly-stem|});
  CssJs.unsafe({|listStyleType|}, {|cjk-earthly-branch|});
  CssJs.unsafe({|listStyleType|}, {|trad-chinese-informal|});
  CssJs.unsafe({|listStyleType|}, {|trad-chinese-formal|});
  CssJs.unsafe({|listStyleType|}, {|simp-chinese-informal|});
  CssJs.unsafe({|listStyleType|}, {|simp-chinese-formal|});
  CssJs.unsafe({|listStyleType|}, {|japanese-informal|});
  CssJs.unsafe({|listStyleType|}, {|japanese-formal|});
  CssJs.unsafe({|listStyleType|}, {|arabic-indic|});
  CssJs.unsafe({|listStyleType|}, {|persian|});
  CssJs.unsafe({|listStyleType|}, {|urdu|});
  CssJs.unsafe({|listStyleType|}, {|devanagari|});
  CssJs.unsafe({|listStyleType|}, {|gurmukhi|});
  CssJs.unsafe({|listStyleType|}, {|gujarati|});
  CssJs.unsafe({|listStyleType|}, {|oriya|});
  CssJs.unsafe({|listStyleType|}, {|kannada|});
  CssJs.unsafe({|listStyleType|}, {|malayalam|});
  CssJs.unsafe({|listStyleType|}, {|bengali|});
  CssJs.unsafe({|listStyleType|}, {|tamil|});
  CssJs.unsafe({|listStyleType|}, {|telugu|});
  CssJs.unsafe({|listStyleType|}, {|thai|});
  CssJs.unsafe({|listStyleType|}, {|lao|});
  CssJs.unsafe({|listStyleType|}, {|myanmar|});
  CssJs.unsafe({|listStyleType|}, {|khmer|});
  CssJs.unsafe({|listStyleType|}, {|hangul|});
  CssJs.unsafe({|listStyleType|}, {|hangul-consonant|});
  CssJs.unsafe({|listStyleType|}, {|ethiopic-halehame|});
  CssJs.unsafe({|listStyleType|}, {|ethiopic-numeric|});
  CssJs.unsafe({|listStyleType|}, {|ethiopic-halehame-am|});
  CssJs.unsafe({|listStyleType|}, {|ethiopic-halehame-ti-er|});
  CssJs.unsafe({|listStyleType|}, {|ethiopic-halehame-ti-et|});
  CssJs.unsafe({|listStyleType|}, {|other-style|});
  CssJs.unsafe({|listStyleType|}, {|inside|});
  CssJs.unsafe({|listStyleType|}, {|outside|});
  CssJs.unsafe({|listStyleType|}, {|\32 style|});
  CssJs.unsafe({|listStyleType|}, {|"-"|});
  CssJs.unsafe({|listStyleType|}, {|'-'|});
  CssJs.unsafe({|counterReset|}, {|foo|});
  CssJs.unsafe({|counterReset|}, {|foo 1|});
  CssJs.unsafe({|counterReset|}, {|foo 1 bar|});
  CssJs.unsafe({|counterReset|}, {|foo 1 bar 2|});
  CssJs.unsafe({|counterReset|}, {|none|});
  CssJs.unsafe({|counterSet|}, {|foo|});
  CssJs.unsafe({|counterSet|}, {|foo 1|});
  CssJs.unsafe({|counterSet|}, {|foo 1 bar|});
  CssJs.unsafe({|counterSet|}, {|foo 1 bar 2|});
  CssJs.unsafe({|counterSet|}, {|none|});
  CssJs.unsafe({|counterIncrement|}, {|foo|});
  CssJs.unsafe({|counterIncrement|}, {|foo 1|});
  CssJs.unsafe({|counterIncrement|}, {|foo 1 bar|});
  CssJs.unsafe({|counterIncrement|}, {|foo 1 bar 2|});
  CssJs.unsafe({|counterIncrement|}, {|none|});
