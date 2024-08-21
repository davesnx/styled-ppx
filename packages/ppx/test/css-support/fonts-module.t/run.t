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


  $ dune describe pp ./input.re | sed '1,/^];$/d'
  
  CSS.fontFamilies([|{js|Inter Semi Bold|js}|]);
  CSS.fontFamilies(fonts: array(CSS.Types.FontFamilyName.t));
  CSS.fontFamilies([|{js|Inter|js}|]);
  CSS.fontFamilies(font: array(CSS.Types.FontFamilyName.t));
  CSS.fontFamilies([|{js|Inter|js}, {js|Sans|js}|]);
  CSS.fontFamilies([|{js|Inter|js}, font|]);
  CSS.fontFamilies([|{js|Gill Sans Extrabold|js}, "sans-serif"|]);
  
  CSS.fontSynthesisWeight(`none);
  CSS.fontSynthesisStyle(`auto);
  CSS.fontSynthesisSmallCaps(`none);
  CSS.fontSynthesisPosition(`auto);
  CSS.fontSize(`xxx_large);
  CSS.unsafe({|fontVariant|}, {|none|});
  CSS.fontVariant(`normal);
  CSS.unsafe({js|fontVariant|js}, {js|all-petite-caps|js});
  CSS.unsafe({js|fontVariant|js}, {js|historical-forms|js});
  CSS.unsafe({js|fontVariant|js}, {js|super|js});
  CSS.unsafe({js|fontVariant|js}, {js|sub lining-nums contextual ruby|js});
  CSS.unsafe({js|fontVariant|js}, {js|annotation(circled)|js});
  CSS.unsafe(
    {js|fontVariant|js},
    {js|discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U)|js},
  );
  CSS.unsafe({js|fontVariantAlternates|js}, {js|normal|js});
  CSS.unsafe({js|fontVariantAlternates|js}, {js|historical-forms|js});
  CSS.unsafe({js|fontVariantAlternates|js}, {js|styleset(ss01)|js});
  CSS.unsafe(
    {js|fontVariantAlternates|js},
    {js|styleset(stacked-g, geometric-m)|js},
  );
  CSS.unsafe({js|fontVariantAlternates|js}, {js|character-variant(cv02)|js});
  CSS.unsafe(
    {js|fontVariantAlternates|js},
    {js|character-variant(beta-3, gamma)|js},
  );
  CSS.unsafe({js|fontVariantAlternates|js}, {js|swash(flowing)|js});
  CSS.unsafe({js|fontVariantAlternates|js}, {js|ornaments(leaves)|js});
  CSS.unsafe({js|fontVariantAlternates|js}, {js|annotation(blocky)|js});
  CSS.unsafe({js|fontFeatureSettings|js}, {js|normal|js});
  CSS.unsafe({js|fontFeatureSettings|js}, {js|'swsh' 2|js});
  CSS.unsafe({js|fontLanguageOverride|js}, {js|normal|js});
  CSS.unsafe({js|fontLanguageOverride|js}, {js|'SRB'|js});
  CSS.fontWeight(`numInt(1));
  CSS.fontWeight(`numInt(90));
  CSS.fontWeight(`numInt(750));
  CSS.fontWeight(`numInt(1000));
  CSS.unsafe({js|fontStyle|js}, {js|oblique 15deg|js});
  CSS.unsafe({js|fontStyle|js}, {js|oblique -15deg|js});
  CSS.unsafe({js|fontStyle|js}, {js|oblique 0deg|js});
  CSS.fontOpticalSizing(`none);
  CSS.fontOpticalSizing(`auto);
  CSS.unsafe({js|fontPalette|js}, {js|normal|js});
  CSS.unsafe({js|fontPalette|js}, {js|light|js});
  CSS.unsafe({js|fontPalette|js}, {js|dark|js});
  CSS.fontVariantEmoji(`normal);
  CSS.fontVariantEmoji(`text);
  CSS.fontVariantEmoji(`emoji);
  CSS.fontVariantEmoji(`unicode);
  
  CSS.unsafe({js|fontStretch|js}, {js|normal|js});
  CSS.unsafe({js|fontStretch|js}, {js|ultra-condensed|js});
  CSS.unsafe({js|fontStretch|js}, {js|extra-condensed|js});
  CSS.unsafe({js|fontStretch|js}, {js|condensed|js});
  CSS.unsafe({js|fontStretch|js}, {js|semi-condensed|js});
  CSS.unsafe({js|fontStretch|js}, {js|semi-expanded|js});
  CSS.unsafe({js|fontStretch|js}, {js|expanded|js});
  CSS.unsafe({js|fontStretch|js}, {js|extra-expanded|js});
  CSS.unsafe({js|fontStretch|js}, {js|ultra-expanded|js});
  CSS.unsafe({js|fontSizeAdjust|js}, {js|none|js});
  CSS.unsafe({js|fontSizeAdjust|js}, {js|.5|js});
  CSS.unsafe({js|fontSynthesis|js}, {js|none|js});
  CSS.unsafe({js|fontSynthesis|js}, {js|weight|js});
  CSS.unsafe({js|fontSynthesis|js}, {js|style|js});
  CSS.unsafe({js|fontSynthesis|js}, {js|weight style|js});
  CSS.unsafe({js|fontSynthesis|js}, {js|style weight|js});
  CSS.fontKerning(`auto);
  CSS.fontKerning(`normal);
  CSS.fontKerning(`none);
  CSS.fontVariantPosition(`normal);
  CSS.fontVariantPosition(`sub);
  CSS.fontVariantPosition(`super);
  CSS.unsafe({js|fontVariantLigatures|js}, {js|normal|js});
  CSS.unsafe({js|fontVariantLigatures|js}, {js|none|js});
  CSS.unsafe({js|fontVariantLigatures|js}, {js|common-ligatures|js});
  CSS.unsafe({js|fontVariantLigatures|js}, {js|no-common-ligatures|js});
  CSS.unsafe({js|fontVariantLigatures|js}, {js|discretionary-ligatures|js});
  CSS.unsafe({js|fontVariantLigatures|js}, {js|no-discretionary-ligatures|js});
  CSS.unsafe({js|fontVariantLigatures|js}, {js|historical-ligatures|js});
  CSS.unsafe({js|fontVariantLigatures|js}, {js|no-historical-ligatures|js});
  CSS.unsafe({js|fontVariantLigatures|js}, {js|contextual|js});
  CSS.unsafe({js|fontVariantLigatures|js}, {js|no-contextual|js});
  CSS.unsafe(
    {js|fontVariantLigatures|js},
    {js|common-ligatures discretionary-ligatures historical-ligatures contextual|js},
  );
  CSS.fontVariantCaps(`normal);
  CSS.fontVariantCaps(`smallCaps);
  CSS.fontVariantCaps(`allSmallCaps);
  CSS.fontVariantCaps(`petiteCaps);
  CSS.fontVariantCaps(`allPetiteCaps);
  CSS.fontVariantCaps(`titlingCaps);
  CSS.fontVariantCaps(`unicase);
  CSS.unsafe({js|fontVariantNumeric|js}, {js|normal|js});
  CSS.unsafe({js|fontVariantNumeric|js}, {js|lining-nums|js});
  CSS.unsafe({js|fontVariantNumeric|js}, {js|oldstyle-nums|js});
  CSS.unsafe({js|fontVariantNumeric|js}, {js|proportional-nums|js});
  CSS.unsafe({js|fontVariantNumeric|js}, {js|tabular-nums|js});
  CSS.unsafe({js|fontVariantNumeric|js}, {js|diagonal-fractions|js});
  CSS.unsafe({js|fontVariantNumeric|js}, {js|stacked-fractions|js});
  CSS.unsafe({js|fontVariantNumeric|js}, {js|ordinal|js});
  CSS.unsafe({js|fontVariantNumeric|js}, {js|slashed-zero|js});
  CSS.unsafe(
    {js|fontVariantNumeric|js},
    {js|lining-nums proportional-nums diagonal-fractions|js},
  );
  CSS.unsafe(
    {js|fontVariantNumeric|js},
    {js|oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero|js},
  );
  CSS.unsafe(
    {js|fontVariantNumeric|js},
    {js|slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums|js},
  );
  CSS.unsafe({js|fontVariantEastAsian|js}, {js|normal|js});
  CSS.unsafe({js|fontVariantEastAsian|js}, {js|jis78|js});
  CSS.unsafe({js|fontVariantEastAsian|js}, {js|jis83|js});
  CSS.unsafe({js|fontVariantEastAsian|js}, {js|jis90|js});
  CSS.unsafe({js|fontVariantEastAsian|js}, {js|jis04|js});
  CSS.unsafe({js|fontVariantEastAsian|js}, {js|simplified|js});
  CSS.unsafe({js|fontVariantEastAsian|js}, {js|traditional|js});
  CSS.unsafe({js|fontVariantEastAsian|js}, {js|full-width|js});
  CSS.unsafe({js|fontVariantEastAsian|js}, {js|proportional-width|js});
  CSS.unsafe({js|fontVariantEastAsian|js}, {js|ruby|js});
  CSS.unsafe({js|fontVariantEastAsian|js}, {js|simplified full-width ruby|js});
  CSS.unsafe({js|fontFeatureSettings|js}, {js|normal|js});
  CSS.unsafe({js|fontFeatureSettings|js}, {js|'c2sc'|js});
  CSS.unsafe({js|fontFeatureSettings|js}, {js|'smcp' on|js});
  CSS.unsafe({js|fontFeatureSettings|js}, {js|'liga' off|js});
  CSS.unsafe({js|fontFeatureSettings|js}, {js|'smcp', 'swsh' 2|js});
