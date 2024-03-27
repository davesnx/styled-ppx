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
  >  (preprocess (pps styled-ppx.lib)))
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
  CssJs.unsafe({js|listStyleType|js}, {js|disclosure-closed|js});
  CssJs.unsafe({js|listStyleType|js}, {js|disclosure-open|js});
  CssJs.unsafe({js|listStyleType|js}, {js|hebrew|js});
  CssJs.unsafe({js|listStyleType|js}, {js|cjk-decimal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|cjk-ideographic|js});
  CssJs.unsafe({js|listStyleType|js}, {js|hiragana|js});
  CssJs.unsafe({js|listStyleType|js}, {js|katakana|js});
  CssJs.unsafe({js|listStyleType|js}, {js|hiragana-iroha|js});
  CssJs.unsafe({js|listStyleType|js}, {js|katakana-iroha|js});
  CssJs.unsafe({js|listStyleType|js}, {js|japanese-informal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|japanese-formal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|korean-hangul-formal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|korean-hanja-informal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|korean-hanja-formal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|simp-chinese-informal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|simp-chinese-formal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|trad-chinese-informal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|trad-chinese-formal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|cjk-heavenly-stem|js});
  CssJs.unsafe({js|listStyleType|js}, {js|cjk-earthly-branch|js});
  CssJs.unsafe({js|listStyleType|js}, {js|trad-chinese-informal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|trad-chinese-formal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|simp-chinese-informal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|simp-chinese-formal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|japanese-informal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|japanese-formal|js});
  CssJs.unsafe({js|listStyleType|js}, {js|arabic-indic|js});
  CssJs.unsafe({js|listStyleType|js}, {js|persian|js});
  CssJs.unsafe({js|listStyleType|js}, {js|urdu|js});
  CssJs.unsafe({js|listStyleType|js}, {js|devanagari|js});
  CssJs.unsafe({js|listStyleType|js}, {js|gurmukhi|js});
  CssJs.unsafe({js|listStyleType|js}, {js|gujarati|js});
  CssJs.unsafe({js|listStyleType|js}, {js|oriya|js});
  CssJs.unsafe({js|listStyleType|js}, {js|kannada|js});
  CssJs.unsafe({js|listStyleType|js}, {js|malayalam|js});
  CssJs.unsafe({js|listStyleType|js}, {js|bengali|js});
  CssJs.unsafe({js|listStyleType|js}, {js|tamil|js});
  CssJs.unsafe({js|listStyleType|js}, {js|telugu|js});
  CssJs.unsafe({js|listStyleType|js}, {js|thai|js});
  CssJs.unsafe({js|listStyleType|js}, {js|lao|js});
  CssJs.unsafe({js|listStyleType|js}, {js|myanmar|js});
  CssJs.unsafe({js|listStyleType|js}, {js|khmer|js});
  CssJs.unsafe({js|listStyleType|js}, {js|hangul|js});
  CssJs.unsafe({js|listStyleType|js}, {js|hangul-consonant|js});
  CssJs.unsafe({js|listStyleType|js}, {js|ethiopic-halehame|js});
  CssJs.unsafe({js|listStyleType|js}, {js|ethiopic-numeric|js});
  CssJs.unsafe({js|listStyleType|js}, {js|ethiopic-halehame-am|js});
  CssJs.unsafe({js|listStyleType|js}, {js|ethiopic-halehame-ti-er|js});
  CssJs.unsafe({js|listStyleType|js}, {js|ethiopic-halehame-ti-et|js});
  CssJs.unsafe({js|listStyleType|js}, {js|other-style|js});
  CssJs.unsafe({js|listStyleType|js}, {js|inside|js});
  CssJs.unsafe({js|listStyleType|js}, {js|outside|js});
  CssJs.unsafe({js|listStyleType|js}, {js|\32 style|js});
  CssJs.unsafe({js|listStyleType|js}, {js|"-"|js});
  CssJs.unsafe({js|listStyleType|js}, {js|'-'|js});
  CssJs.unsafe({js|counterReset|js}, {js|foo|js});
  CssJs.unsafe({js|counterReset|js}, {js|foo 1|js});
  CssJs.unsafe({js|counterReset|js}, {js|foo 1 bar|js});
  CssJs.unsafe({js|counterReset|js}, {js|foo 1 bar 2|js});
  CssJs.unsafe({js|counterReset|js}, {js|none|js});
  CssJs.unsafe({js|counterSet|js}, {js|foo|js});
  CssJs.unsafe({js|counterSet|js}, {js|foo 1|js});
  CssJs.unsafe({js|counterSet|js}, {js|foo 1 bar|js});
  CssJs.unsafe({js|counterSet|js}, {js|foo 1 bar 2|js});
  CssJs.unsafe({js|counterSet|js}, {js|none|js});
  CssJs.unsafe({js|counterIncrement|js}, {js|foo|js});
  CssJs.unsafe({js|counterIncrement|js}, {js|foo 1|js});
  CssJs.unsafe({js|counterIncrement|js}, {js|foo 1 bar|js});
  CssJs.unsafe({js|counterIncrement|js}, {js|foo 1 bar 2|js});
  CssJs.unsafe({js|counterIncrement|js}, {js|none|js});
