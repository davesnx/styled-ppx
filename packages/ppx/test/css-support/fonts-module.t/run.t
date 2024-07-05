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
  CssJs.fontFamilies([|`custom({js|Inter Semi Bold|js})|]);
  CssJs.fontFamilies(fonts: array(CssJs.Types.FontFamilyName.t));
  CssJs.fontFamilies([|`custom({js|Inter|js})|]);
  CssJs.fontFamilies(font: array(CssJs.Types.FontFamilyName.t));
  CssJs.fontFamilies([|`custom({js|Inter|js}), `custom({js|Sans|js})|]);
  CssJs.fontFamilies([|`custom({js|Inter|js}), font|]);
  CssJs.fontFamilies([|`custom({js|Gill Sans Extrabold|js}), `sansSerif|]);
  CssJs.fontSynthesisWeight(`none);
  CssJs.fontSynthesisStyle(`auto);
  CssJs.fontSynthesisSmallCaps(`none);
  CssJs.fontSynthesisPosition(`auto);
  CssJs.fontSize(`xxx_large);
  CssJs.unsafe({|fontVariant|}, {|none|});
  CssJs.fontVariant(`normal);
  CssJs.unsafe({js|fontVariant|js}, {js|all-petite-caps|js});
  CssJs.unsafe({js|fontVariant|js}, {js|historical-forms|js});
  CssJs.unsafe({js|fontVariant|js}, {js|super|js});
  CssJs.unsafe({js|fontVariant|js}, {js|sub lining-nums contextual ruby|js});
  CssJs.unsafe({js|fontVariant|js}, {js|annotation(circled)|js});
  CssJs.unsafe(
    {js|fontVariant|js},
    {js|discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U)|js},
  );
  CssJs.unsafe({js|fontVariantAlternates|js}, {js|normal|js});
  CssJs.unsafe({js|fontVariantAlternates|js}, {js|historical-forms|js});
  CssJs.unsafe({js|fontVariantAlternates|js}, {js|styleset(ss01)|js});
  CssJs.unsafe(
    {js|fontVariantAlternates|js},
    {js|styleset(stacked-g, geometric-m)|js},
  );
  CssJs.unsafe({js|fontVariantAlternates|js}, {js|character-variant(cv02)|js});
  CssJs.unsafe(
    {js|fontVariantAlternates|js},
    {js|character-variant(beta-3, gamma)|js},
  );
  CssJs.unsafe({js|fontVariantAlternates|js}, {js|swash(flowing)|js});
  CssJs.unsafe({js|fontVariantAlternates|js}, {js|ornaments(leaves)|js});
  CssJs.unsafe({js|fontVariantAlternates|js}, {js|annotation(blocky)|js});
  CssJs.unsafe({js|fontFeatureSettings|js}, {js|normal|js});
  CssJs.unsafe({js|fontFeatureSettings|js}, {js|'swsh' 2|js});
  CssJs.unsafe({js|fontLanguageOverride|js}, {js|normal|js});
  CssJs.unsafe({js|fontLanguageOverride|js}, {js|'SRB'|js});
  CssJs.fontWeight(`num(1));
  CssJs.fontWeight(`num(90));
  CssJs.fontWeight(`num(750));
  CssJs.fontWeight(`num(1000));
  CssJs.unsafe({js|fontStyle|js}, {js|oblique 15deg|js});
  CssJs.unsafe({js|fontStyle|js}, {js|oblique -15deg|js});
  CssJs.unsafe({js|fontStyle|js}, {js|oblique 0deg|js});
  CssJs.fontOpticalSizing(`none);
  CssJs.fontOpticalSizing(`auto);
  CssJs.unsafe({js|fontPalette|js}, {js|normal|js});
  CssJs.unsafe({js|fontPalette|js}, {js|light|js});
  CssJs.unsafe({js|fontPalette|js}, {js|dark|js});
  CssJs.fontVariantEmoji(`normal);
  CssJs.fontVariantEmoji(`text);
  CssJs.fontVariantEmoji(`emoji);
  CssJs.fontVariantEmoji(`unicode);
  CssJs.unsafe({js|fontStretch|js}, {js|normal|js});
  CssJs.unsafe({js|fontStretch|js}, {js|ultra-condensed|js});
  CssJs.unsafe({js|fontStretch|js}, {js|extra-condensed|js});
  CssJs.unsafe({js|fontStretch|js}, {js|condensed|js});
  CssJs.unsafe({js|fontStretch|js}, {js|semi-condensed|js});
  CssJs.unsafe({js|fontStretch|js}, {js|semi-expanded|js});
  CssJs.unsafe({js|fontStretch|js}, {js|expanded|js});
  CssJs.unsafe({js|fontStretch|js}, {js|extra-expanded|js});
  CssJs.unsafe({js|fontStretch|js}, {js|ultra-expanded|js});
  CssJs.unsafe({js|fontSizeAdjust|js}, {js|none|js});
  CssJs.unsafe({js|fontSizeAdjust|js}, {js|.5|js});
  CssJs.unsafe({js|fontSynthesis|js}, {js|none|js});
  CssJs.unsafe({js|fontSynthesis|js}, {js|weight|js});
  CssJs.unsafe({js|fontSynthesis|js}, {js|style|js});
  CssJs.unsafe({js|fontSynthesis|js}, {js|weight style|js});
  CssJs.unsafe({js|fontSynthesis|js}, {js|style weight|js});
  CssJs.fontKerning(`auto);
  CssJs.fontKerning(`normal);
  CssJs.fontKerning(`none);
  CssJs.fontVariantPosition(`normal);
  CssJs.fontVariantPosition(`sub);
  CssJs.fontVariantPosition(`super);
  CssJs.unsafe({js|fontVariantLigatures|js}, {js|normal|js});
  CssJs.unsafe({js|fontVariantLigatures|js}, {js|none|js});
  CssJs.unsafe({js|fontVariantLigatures|js}, {js|common-ligatures|js});
  CssJs.unsafe({js|fontVariantLigatures|js}, {js|no-common-ligatures|js});
  CssJs.unsafe({js|fontVariantLigatures|js}, {js|discretionary-ligatures|js});
  CssJs.unsafe(
    {js|fontVariantLigatures|js},
    {js|no-discretionary-ligatures|js},
  );
  CssJs.unsafe({js|fontVariantLigatures|js}, {js|historical-ligatures|js});
  CssJs.unsafe({js|fontVariantLigatures|js}, {js|no-historical-ligatures|js});
  CssJs.unsafe({js|fontVariantLigatures|js}, {js|contextual|js});
  CssJs.unsafe({js|fontVariantLigatures|js}, {js|no-contextual|js});
  CssJs.unsafe(
    {js|fontVariantLigatures|js},
    {js|common-ligatures discretionary-ligatures historical-ligatures contextual|js},
  );
  CssJs.fontVariantCaps(`normal);
  CssJs.fontVariantCaps(`smallCaps);
  CssJs.fontVariantCaps(`allSmallCaps);
  CssJs.fontVariantCaps(`petiteCaps);
  CssJs.fontVariantCaps(`allPetiteCaps);
  CssJs.fontVariantCaps(`titlingCaps);
  CssJs.fontVariantCaps(`unicase);
  CssJs.unsafe({js|fontVariantNumeric|js}, {js|normal|js});
  CssJs.unsafe({js|fontVariantNumeric|js}, {js|lining-nums|js});
  CssJs.unsafe({js|fontVariantNumeric|js}, {js|oldstyle-nums|js});
  CssJs.unsafe({js|fontVariantNumeric|js}, {js|proportional-nums|js});
  CssJs.unsafe({js|fontVariantNumeric|js}, {js|tabular-nums|js});
  CssJs.unsafe({js|fontVariantNumeric|js}, {js|diagonal-fractions|js});
  CssJs.unsafe({js|fontVariantNumeric|js}, {js|stacked-fractions|js});
  CssJs.unsafe({js|fontVariantNumeric|js}, {js|ordinal|js});
  CssJs.unsafe({js|fontVariantNumeric|js}, {js|slashed-zero|js});
  CssJs.unsafe(
    {js|fontVariantNumeric|js},
    {js|lining-nums proportional-nums diagonal-fractions|js},
  );
  CssJs.unsafe(
    {js|fontVariantNumeric|js},
    {js|oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero|js},
  );
  CssJs.unsafe(
    {js|fontVariantNumeric|js},
    {js|slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums|js},
  );
  CssJs.unsafe({js|fontVariantEastAsian|js}, {js|normal|js});
  CssJs.unsafe({js|fontVariantEastAsian|js}, {js|jis78|js});
  CssJs.unsafe({js|fontVariantEastAsian|js}, {js|jis83|js});
  CssJs.unsafe({js|fontVariantEastAsian|js}, {js|jis90|js});
  CssJs.unsafe({js|fontVariantEastAsian|js}, {js|jis04|js});
  CssJs.unsafe({js|fontVariantEastAsian|js}, {js|simplified|js});
  CssJs.unsafe({js|fontVariantEastAsian|js}, {js|traditional|js});
  CssJs.unsafe({js|fontVariantEastAsian|js}, {js|full-width|js});
  CssJs.unsafe({js|fontVariantEastAsian|js}, {js|proportional-width|js});
  CssJs.unsafe({js|fontVariantEastAsian|js}, {js|ruby|js});
  CssJs.unsafe(
    {js|fontVariantEastAsian|js},
    {js|simplified full-width ruby|js},
  );
  CssJs.unsafe({js|fontFeatureSettings|js}, {js|normal|js});
  CssJs.unsafe({js|fontFeatureSettings|js}, {js|'c2sc'|js});
  CssJs.unsafe({js|fontFeatureSettings|js}, {js|'smcp' on|js});
  CssJs.unsafe({js|fontFeatureSettings|js}, {js|'liga' off|js});
  CssJs.unsafe({js|fontFeatureSettings|js}, {js|'smcp', 'swsh' 2|js});
