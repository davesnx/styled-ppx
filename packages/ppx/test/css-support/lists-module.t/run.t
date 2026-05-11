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
  
  CSS.listStyleType(`disclosureClosed);
  CSS.listStyleType(`disclosureOpen);
  CSS.listStyleType(`hebrew);
  CSS.listStyleType(`cjkDecimal);
  CSS.listStyleType(`cjkIdeographic);
  CSS.listStyleType(`hiragana);
  CSS.listStyleType(`katakana);
  CSS.listStyleType(`hiraganaIroha);
  CSS.listStyleType(`katakanaIroha);
  CSS.listStyleType(`japaneseInformal);
  CSS.listStyleType(`japaneseFormal);
  CSS.listStyleType(`koreanHangulFormal);
  CSS.listStyleType(`koreanHanjaInformal);
  CSS.listStyleType(`koreanHanjaFormal);
  CSS.listStyleType(`simpChineseInformal);
  CSS.listStyleType(`simpChineseFormal);
  CSS.listStyleType(`tradChineseInformal);
  CSS.listStyleType(`tradChineseFormal);
  CSS.listStyleType(`cjkHeavenlyStem);
  CSS.listStyleType(`cjkEarthlyBranch);
  CSS.listStyleType(`tradChineseInformal);
  CSS.listStyleType(`tradChineseFormal);
  CSS.listStyleType(`simpChineseInformal);
  CSS.listStyleType(`simpChineseFormal);
  CSS.listStyleType(`japaneseInformal);
  CSS.listStyleType(`japaneseFormal);
  CSS.listStyleType(`arabicIndic);
  CSS.listStyleType(`persian);
  CSS.listStyleType(`urdu);
  CSS.listStyleType(`devanagari);
  CSS.listStyleType(`gurmukhi);
  CSS.listStyleType(`gujarati);
  CSS.listStyleType(`oriya);
  CSS.listStyleType(`kannada);
  CSS.listStyleType(`malayalam);
  CSS.listStyleType(`bengali);
  CSS.listStyleType(`tamil);
  CSS.listStyleType(`telugu);
  CSS.listStyleType(`thai);
  CSS.listStyleType(`lao);
  CSS.listStyleType(`myanmar);
  CSS.listStyleType(`khmer);
  CSS.listStyleType(`hangul);
  CSS.listStyleType(`hangulConsonant);
  CSS.listStyleType(`ethiopicHalehame);
  CSS.listStyleType(`ethiopicNumeric);
  CSS.listStyleType(`ethiopicHalehameAm);
  CSS.listStyleType(`ethiopicHalehameTiEr);
  CSS.listStyleType(`ethiopicHalehameTiEt);
  CSS.listStyleType(`Custom({js|other-style|js}));
  CSS.listStyleType(`Custom({js|inside|js}));
  CSS.listStyleType(`Custom({js|outside|js}));
  CSS.listStyleType(`Custom({js|2style|js}));
  CSS.listStyleType(`text({js|-|js}));
  CSS.listStyleType(`text({js|-|js}));
  
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
  CSS.contentsRule(
    [|`counterWithStyle(({js|chno|js}, `upperLatin)), `text({js|. |js})|],
    None,
  );
  CSS.contentsRule(
    [|`counterWithStyle(({js|section|js}, `upperRoman)), `text({js| - |js})|],
    None,
  );
  CSS.contentsRule(
    [|
      `text({js| [|js}),
      `counterWithStyle(({js|bq|js}, `decimal)),
      `text({js|]|js}),
    |],
    None,
  );
  CSS.contentsRule(
    [|`counterWithStyle(({js|notecntr|js}, `disc)), `text({js|" "|js})|],
    None,
  );
  
  CSS.contentsRule(
    [|
      `counterWithStyle(({js|h1|js}, `upperAlpha)),
      `text({js|.|js}),
      `counterWithStyle(({js|h2|js}, `decimal)),
      `text({js|" "|js}),
    |],
    None,
  );
  CSS.contentsRule(
    [|
      `text({js|(|js}),
      `counters(({js|list-item|js}, {js|.|js})),
      `text({js|) |js}),
    |],
    None,
  );
