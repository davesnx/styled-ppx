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
  
  CSS.listStyleType(`Custom({js|disclosure-closed|js}));
  CSS.listStyleType(`Custom({js|disclosure-open|js}));
  CSS.listStyleType(`Custom({js|hebrew|js}));
  CSS.listStyleType(`Custom({js|cjk-decimal|js}));
  CSS.listStyleType(`Custom({js|cjk-ideographic|js}));
  CSS.listStyleType(`Custom({js|hiragana|js}));
  CSS.listStyleType(`Custom({js|katakana|js}));
  CSS.listStyleType(`Custom({js|hiragana-iroha|js}));
  CSS.listStyleType(`Custom({js|katakana-iroha|js}));
  CSS.listStyleType(`Custom({js|japanese-informal|js}));
  CSS.listStyleType(`Custom({js|japanese-formal|js}));
  CSS.listStyleType(`Custom({js|korean-hangul-formal|js}));
  CSS.listStyleType(`Custom({js|korean-hanja-informal|js}));
  CSS.listStyleType(`Custom({js|korean-hanja-formal|js}));
  CSS.listStyleType(`Custom({js|simp-chinese-informal|js}));
  CSS.listStyleType(`Custom({js|simp-chinese-formal|js}));
  CSS.listStyleType(`Custom({js|trad-chinese-informal|js}));
  CSS.listStyleType(`Custom({js|trad-chinese-formal|js}));
  CSS.listStyleType(`Custom({js|cjk-heavenly-stem|js}));
  CSS.listStyleType(`Custom({js|cjk-earthly-branch|js}));
  CSS.listStyleType(`Custom({js|trad-chinese-informal|js}));
  CSS.listStyleType(`Custom({js|trad-chinese-formal|js}));
  CSS.listStyleType(`Custom({js|simp-chinese-informal|js}));
  CSS.listStyleType(`Custom({js|simp-chinese-formal|js}));
  CSS.listStyleType(`Custom({js|japanese-informal|js}));
  CSS.listStyleType(`Custom({js|japanese-formal|js}));
  CSS.listStyleType(`Custom({js|arabic-indic|js}));
  CSS.listStyleType(`Custom({js|persian|js}));
  CSS.listStyleType(`Custom({js|urdu|js}));
  CSS.listStyleType(`Custom({js|devanagari|js}));
  CSS.listStyleType(`Custom({js|gurmukhi|js}));
  CSS.listStyleType(`Custom({js|gujarati|js}));
  CSS.listStyleType(`Custom({js|oriya|js}));
  CSS.listStyleType(`Custom({js|kannada|js}));
  CSS.listStyleType(`Custom({js|malayalam|js}));
  CSS.listStyleType(`Custom({js|bengali|js}));
  CSS.listStyleType(`Custom({js|tamil|js}));
  CSS.listStyleType(`Custom({js|telugu|js}));
  CSS.listStyleType(`Custom({js|thai|js}));
  CSS.listStyleType(`Custom({js|lao|js}));
  CSS.listStyleType(`Custom({js|myanmar|js}));
  CSS.listStyleType(`Custom({js|khmer|js}));
  CSS.listStyleType(`Custom({js|hangul|js}));
  CSS.listStyleType(`Custom({js|hangul-consonant|js}));
  CSS.listStyleType(`Custom({js|ethiopic-halehame|js}));
  CSS.listStyleType(`Custom({js|ethiopic-numeric|js}));
  CSS.listStyleType(`Custom({js|ethiopic-halehame-am|js}));
  CSS.listStyleType(`Custom({js|ethiopic-halehame-ti-er|js}));
  CSS.listStyleType(`Custom({js|ethiopic-halehame-ti-et|js}));
  CSS.listStyleType(`Custom({js|other-style|js}));
  CSS.listStyleType(`Custom({js|inside|js}));
  CSS.listStyleType(`Custom({js|outside|js}));
  CSS.listStyleType(`Custom({js|2style|js}));
  CSS.listStyleType(`Custom({js|-|js}));
  CSS.listStyleType(`Custom({js|-|js}));
  
  CSS.counterReset(`reset(({js|foo|js}, 0)));
  CSS.counterReset(`reset(({js|foo|js}, 1)));
  CSS.countersReset([|`reset(({js|foo|js}, 1)), `reset(({js|bar|js}, 0))|]);
  CSS.countersReset([|`reset(({js|foo|js}, 1)), `reset(({js|bar|js}, 2))|]);
  CSS.counterReset(`none);
  CSS.counterSet(`set(({js|foo|js}, 0)));
  CSS.counterSet(`set(({js|foo|js}, 1)));
  CSS.countersSet([|`set(({js|foo|js}, 1)), `set(({js|bar|js}, 0))|]);
  CSS.countersSet([|`set(({js|foo|js}, 1)), `set(({js|bar|js}, 2))|]);
  CSS.counterSet(`none);
  CSS.counterIncrement(`increment(({js|foo|js}, 1)));
  CSS.counterIncrement(`increment(({js|foo|js}, 1)));
  CSS.countersIncrement([|
    `increment(({js|foo|js}, 1)),
    `increment(({js|bar|js}, 1)),
  |]);
  CSS.countersIncrement([|
    `increment(({js|foo|js}, 1)),
    `increment(({js|bar|js}, 2)),
  |]);
  CSS.counterIncrement(`none);
