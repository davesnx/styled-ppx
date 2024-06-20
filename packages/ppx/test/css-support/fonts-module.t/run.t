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
  CssJs.fontFamilies([|`custom({|Inter Semi Bold|})|]);
  CssJs.fontFamilies(fonts: array(Css_AtomicTypes.FontFamilyName.t));
  CssJs.fontFamilies([|`custom({|Inter|})|]);
  CssJs.fontFamilies(font: array(Css_AtomicTypes.FontFamilyName.t));
  CssJs.fontFamilies([|`custom({|Inter|}), `custom({|Sans|})|]);
  CssJs.fontFamilies([|`custom({|Inter|}), font|]);
  CssJs.fontFamilies([|`custom({|Gill Sans Extrabold|}), `sansSerif|]);
  CssJs.fontSynthesisWeight(`none);
  CssJs.fontSynthesisStyle(`auto);
  CssJs.fontSynthesisSmallCaps(`none);
  CssJs.fontSynthesisPosition(`auto);
  CssJs.fontSize(`xxx_large);
  CssJs.unsafe("fontVariant", "none");
  CssJs.fontVariant(`normal);
  CssJs.unsafe({|fontVariant|}, {|all-petite-caps|});
  CssJs.unsafe({|fontVariant|}, {|historical-forms|});
  CssJs.unsafe({|fontVariant|}, {|super|});
  CssJs.unsafe({|fontVariant|}, {|sub lining-nums contextual ruby|});
  CssJs.unsafe({|fontVariant|}, {|annotation(circled)|});
  CssJs.unsafe(
    {|fontVariant|},
    {|discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U)|},
  );
  CssJs.unsafe({|fontVariantAlternates|}, {|normal|});
  CssJs.unsafe({|fontVariantAlternates|}, {|historical-forms|});
  CssJs.unsafe({|fontVariantAlternates|}, {|styleset(ss01)|});
  CssJs.unsafe({|fontVariantAlternates|}, {|styleset(stacked-g, geometric-m)|});
  CssJs.unsafe({|fontVariantAlternates|}, {|character-variant(cv02)|});
  CssJs.unsafe({|fontVariantAlternates|}, {|character-variant(beta-3, gamma)|});
  CssJs.unsafe({|fontVariantAlternates|}, {|swash(flowing)|});
  CssJs.unsafe({|fontVariantAlternates|}, {|ornaments(leaves)|});
  CssJs.unsafe({|fontVariantAlternates|}, {|annotation(blocky)|});
  CssJs.unsafe({|fontFeatureSettings|}, {|normal|});
  CssJs.unsafe({|fontFeatureSettings|}, {|'swsh' 2|});
  CssJs.unsafe({|fontLanguageOverride|}, {|normal|});
  CssJs.unsafe({|fontLanguageOverride|}, {|'SRB'|});
  CssJs.fontWeight(`num(1));
  CssJs.fontWeight(`num(90));
  CssJs.fontWeight(`num(750));
  CssJs.fontWeight(`num(1000));
  CssJs.unsafe({|fontStyle|}, {|oblique 15deg|});
  CssJs.unsafe({|fontStyle|}, {|oblique -15deg|});
  CssJs.unsafe({|fontStyle|}, {|oblique 0deg|});
  CssJs.fontOpticalSizing(`none);
  CssJs.fontOpticalSizing(`auto);
  CssJs.unsafe({|fontPalette|}, {|normal|});
  CssJs.unsafe({|fontPalette|}, {|light|});
  CssJs.unsafe({|fontPalette|}, {|dark|});
  CssJs.fontVariantEmoji(`normal);
  CssJs.fontVariantEmoji(`text);
  CssJs.fontVariantEmoji(`emoji);
  CssJs.fontVariantEmoji(`unicode);
  CssJs.unsafe({|fontStretch|}, {|normal|});
  CssJs.unsafe({|fontStretch|}, {|ultra-condensed|});
  CssJs.unsafe({|fontStretch|}, {|extra-condensed|});
  CssJs.unsafe({|fontStretch|}, {|condensed|});
  CssJs.unsafe({|fontStretch|}, {|semi-condensed|});
  CssJs.unsafe({|fontStretch|}, {|semi-expanded|});
  CssJs.unsafe({|fontStretch|}, {|expanded|});
  CssJs.unsafe({|fontStretch|}, {|extra-expanded|});
  CssJs.unsafe({|fontStretch|}, {|ultra-expanded|});
  CssJs.unsafe({|fontSizeAdjust|}, {|none|});
  CssJs.unsafe({|fontSizeAdjust|}, {|.5|});
  CssJs.unsafe({|fontSynthesis|}, {|none|});
  CssJs.unsafe({|fontSynthesis|}, {|weight|});
  CssJs.unsafe({|fontSynthesis|}, {|style|});
  CssJs.unsafe({|fontSynthesis|}, {|weight style|});
  CssJs.unsafe({|fontSynthesis|}, {|style weight|});
  CssJs.fontKerning(`auto);
  CssJs.fontKerning(`normal);
  CssJs.fontKerning(`none);
  CssJs.fontVariantPosition(`normal);
  CssJs.fontVariantPosition(`sub);
  CssJs.fontVariantPosition(`super);
  CssJs.unsafe({|fontVariantLigatures|}, {|normal|});
  CssJs.unsafe({|fontVariantLigatures|}, {|none|});
  CssJs.unsafe({|fontVariantLigatures|}, {|common-ligatures|});
  CssJs.unsafe({|fontVariantLigatures|}, {|no-common-ligatures|});
  CssJs.unsafe({|fontVariantLigatures|}, {|discretionary-ligatures|});
  CssJs.unsafe({|fontVariantLigatures|}, {|no-discretionary-ligatures|});
  CssJs.unsafe({|fontVariantLigatures|}, {|historical-ligatures|});
  CssJs.unsafe({|fontVariantLigatures|}, {|no-historical-ligatures|});
  CssJs.unsafe({|fontVariantLigatures|}, {|contextual|});
  CssJs.unsafe({|fontVariantLigatures|}, {|no-contextual|});
  CssJs.unsafe(
    {|fontVariantLigatures|},
    {|common-ligatures discretionary-ligatures historical-ligatures contextual|},
  );
  CssJs.fontVariantCaps(`normal);
  CssJs.fontVariantCaps(`smallCaps);
  CssJs.fontVariantCaps(`allSmallCaps);
  CssJs.fontVariantCaps(`petiteCaps);
  CssJs.fontVariantCaps(`allPetiteCaps);
  CssJs.fontVariantCaps(`titlingCaps);
  CssJs.fontVariantCaps(`unicase);
  CssJs.unsafe({|fontVariantNumeric|}, {|normal|});
  CssJs.unsafe({|fontVariantNumeric|}, {|lining-nums|});
  CssJs.unsafe({|fontVariantNumeric|}, {|oldstyle-nums|});
  CssJs.unsafe({|fontVariantNumeric|}, {|proportional-nums|});
  CssJs.unsafe({|fontVariantNumeric|}, {|tabular-nums|});
  CssJs.unsafe({|fontVariantNumeric|}, {|diagonal-fractions|});
  CssJs.unsafe({|fontVariantNumeric|}, {|stacked-fractions|});
  CssJs.unsafe({|fontVariantNumeric|}, {|ordinal|});
  CssJs.unsafe({|fontVariantNumeric|}, {|slashed-zero|});
  CssJs.unsafe(
    {|fontVariantNumeric|},
    {|lining-nums proportional-nums diagonal-fractions|},
  );
  CssJs.unsafe(
    {|fontVariantNumeric|},
    {|oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero|},
  );
  CssJs.unsafe(
    {|fontVariantNumeric|},
    {|slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums|},
  );
  CssJs.unsafe({|fontVariantEastAsian|}, {|normal|});
  CssJs.unsafe({|fontVariantEastAsian|}, {|jis78|});
  CssJs.unsafe({|fontVariantEastAsian|}, {|jis83|});
  CssJs.unsafe({|fontVariantEastAsian|}, {|jis90|});
  CssJs.unsafe({|fontVariantEastAsian|}, {|jis04|});
  CssJs.unsafe({|fontVariantEastAsian|}, {|simplified|});
  CssJs.unsafe({|fontVariantEastAsian|}, {|traditional|});
  CssJs.unsafe({|fontVariantEastAsian|}, {|full-width|});
  CssJs.unsafe({|fontVariantEastAsian|}, {|proportional-width|});
  CssJs.unsafe({|fontVariantEastAsian|}, {|ruby|});
  CssJs.unsafe({|fontVariantEastAsian|}, {|simplified full-width ruby|});
  CssJs.unsafe({|fontFeatureSettings|}, {|normal|});
  CssJs.unsafe({|fontFeatureSettings|}, {|'c2sc'|});
  CssJs.unsafe({|fontFeatureSettings|}, {|'smcp' on|});
  CssJs.unsafe({|fontFeatureSettings|}, {|'liga' off|});
  CssJs.unsafe({|fontFeatureSettings|}, {|'smcp', 'swsh' 2|});
