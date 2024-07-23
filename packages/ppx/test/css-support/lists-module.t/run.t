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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  
  CSS.unsafe({js|listStyleType|js}, {js|disclosure-closed|js});
  CSS.unsafe({js|listStyleType|js}, {js|disclosure-open|js});
  CSS.unsafe({js|listStyleType|js}, {js|hebrew|js});
  CSS.unsafe({js|listStyleType|js}, {js|cjk-decimal|js});
  CSS.unsafe({js|listStyleType|js}, {js|cjk-ideographic|js});
  CSS.unsafe({js|listStyleType|js}, {js|hiragana|js});
  CSS.unsafe({js|listStyleType|js}, {js|katakana|js});
  CSS.unsafe({js|listStyleType|js}, {js|hiragana-iroha|js});
  CSS.unsafe({js|listStyleType|js}, {js|katakana-iroha|js});
  CSS.unsafe({js|listStyleType|js}, {js|japanese-informal|js});
  CSS.unsafe({js|listStyleType|js}, {js|japanese-formal|js});
  CSS.unsafe({js|listStyleType|js}, {js|korean-hangul-formal|js});
  CSS.unsafe({js|listStyleType|js}, {js|korean-hanja-informal|js});
  CSS.unsafe({js|listStyleType|js}, {js|korean-hanja-formal|js});
  CSS.unsafe({js|listStyleType|js}, {js|simp-chinese-informal|js});
  CSS.unsafe({js|listStyleType|js}, {js|simp-chinese-formal|js});
  CSS.unsafe({js|listStyleType|js}, {js|trad-chinese-informal|js});
  CSS.unsafe({js|listStyleType|js}, {js|trad-chinese-formal|js});
  CSS.unsafe({js|listStyleType|js}, {js|cjk-heavenly-stem|js});
  CSS.unsafe({js|listStyleType|js}, {js|cjk-earthly-branch|js});
  CSS.unsafe({js|listStyleType|js}, {js|trad-chinese-informal|js});
  CSS.unsafe({js|listStyleType|js}, {js|trad-chinese-formal|js});
  CSS.unsafe({js|listStyleType|js}, {js|simp-chinese-informal|js});
  CSS.unsafe({js|listStyleType|js}, {js|simp-chinese-formal|js});
  CSS.unsafe({js|listStyleType|js}, {js|japanese-informal|js});
  CSS.unsafe({js|listStyleType|js}, {js|japanese-formal|js});
  CSS.unsafe({js|listStyleType|js}, {js|arabic-indic|js});
  CSS.unsafe({js|listStyleType|js}, {js|persian|js});
  CSS.unsafe({js|listStyleType|js}, {js|urdu|js});
  CSS.unsafe({js|listStyleType|js}, {js|devanagari|js});
  CSS.unsafe({js|listStyleType|js}, {js|gurmukhi|js});
  CSS.unsafe({js|listStyleType|js}, {js|gujarati|js});
  CSS.unsafe({js|listStyleType|js}, {js|oriya|js});
  CSS.unsafe({js|listStyleType|js}, {js|kannada|js});
  CSS.unsafe({js|listStyleType|js}, {js|malayalam|js});
  CSS.unsafe({js|listStyleType|js}, {js|bengali|js});
  CSS.unsafe({js|listStyleType|js}, {js|tamil|js});
  CSS.unsafe({js|listStyleType|js}, {js|telugu|js});
  CSS.unsafe({js|listStyleType|js}, {js|thai|js});
  CSS.unsafe({js|listStyleType|js}, {js|lao|js});
  CSS.unsafe({js|listStyleType|js}, {js|myanmar|js});
  CSS.unsafe({js|listStyleType|js}, {js|khmer|js});
  CSS.unsafe({js|listStyleType|js}, {js|hangul|js});
  CSS.unsafe({js|listStyleType|js}, {js|hangul-consonant|js});
  CSS.unsafe({js|listStyleType|js}, {js|ethiopic-halehame|js});
  CSS.unsafe({js|listStyleType|js}, {js|ethiopic-numeric|js});
  CSS.unsafe({js|listStyleType|js}, {js|ethiopic-halehame-am|js});
  CSS.unsafe({js|listStyleType|js}, {js|ethiopic-halehame-ti-er|js});
  CSS.unsafe({js|listStyleType|js}, {js|ethiopic-halehame-ti-et|js});
  CSS.unsafe({js|listStyleType|js}, {js|other-style|js});
  CSS.unsafe({js|listStyleType|js}, {js|inside|js});
  CSS.unsafe({js|listStyleType|js}, {js|outside|js});
  CSS.unsafe({js|listStyleType|js}, {js|\32 style|js});
  CSS.unsafe({js|listStyleType|js}, {js|"-"|js});
  CSS.unsafe({js|listStyleType|js}, {js|'-'|js});
  
  CSS.unsafe({js|counterReset|js}, {js|foo|js});
  CSS.unsafe({js|counterReset|js}, {js|foo 1|js});
  CSS.unsafe({js|counterReset|js}, {js|foo 1 bar|js});
  CSS.unsafe({js|counterReset|js}, {js|foo 1 bar 2|js});
  CSS.unsafe({js|counterReset|js}, {js|none|js});
  CSS.unsafe({js|counterSet|js}, {js|foo|js});
  CSS.unsafe({js|counterSet|js}, {js|foo 1|js});
  CSS.unsafe({js|counterSet|js}, {js|foo 1 bar|js});
  CSS.unsafe({js|counterSet|js}, {js|foo 1 bar 2|js});
  CSS.unsafe({js|counterSet|js}, {js|none|js});
  CSS.unsafe({js|counterIncrement|js}, {js|foo|js});
  CSS.unsafe({js|counterIncrement|js}, {js|foo 1|js});
  CSS.unsafe({js|counterIncrement|js}, {js|foo 1 bar|js});
  CSS.unsafe({js|counterIncrement|js}, {js|foo 1 bar 2|js});
  CSS.unsafe({js|counterIncrement|js}, {js|none|js});
