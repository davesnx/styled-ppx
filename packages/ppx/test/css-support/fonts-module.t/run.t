This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat >dune-project <<EOF
  > (lang dune 3.10)
  > EOF

  $ cat >dune <<EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
  >  (preprocess (pps styled-ppx.lib)))
  > EOF

  $ dune build
  File "input.re", line 1, characters 12-21:
  Error: Unbound value fonts
  [1]

  $ dune describe pp input.re
  /* CSS Fonts Module Level 2 */
  [%css {|font-family: "Inter Semi Bold";|}];
  [%css {|font-family: $(fonts);|}];
  [%css {|font-family: Inter;|}];
  [%css {|font-family: $(font);|}];
  [%css {|font-family: Inter, Sans;|}];
  [%css {|font-family: Inter, $(font);|}];
  [%css {|font-family: "Gill Sans Extrabold", sans-serif;|}];
  
  /* CSS Fonts Module Level 4 */
  [%css {|font-synthesis-weight: none|}];
  [%css {|font-synthesis-style: auto|}];
  [%css {|font-synthesis-small-caps: none|}];
  [%css {|font-synthesis-position: auto|}];
  [%css {|font-size: xxx-large|}];
  [%css {|font-variant: none|}];
  [%css {|font-variant: normal|}];
  [%css {|font-variant: all-petite-caps|}];
  [%css {|font-variant: historical-forms|}];
  [%css {|font-variant: super|}];
  [%css {|font-variant: sub lining-nums contextual ruby|}];
  [%css {|font-variant: annotation(circled)|}];
  [%css
    {|font-variant: discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U)|}
  ];
  [%css {|font-variant-alternates: normal|}];
  [%css {|font-variant-alternates: historical-forms|}];
  [%css {|font-variant-alternates: styleset(ss01)|}];
  [%css {|font-variant-alternates: styleset(stacked-g, geometric-m)|}];
  [%css {|font-variant-alternates: character-variant(cv02)|}];
  [%css {|font-variant-alternates: character-variant(beta-3, gamma)|}];
  [%css {|font-variant-alternates: swash(flowing)|}];
  [%css {|font-variant-alternates: ornaments(leaves)|}];
  [%css {|font-variant-alternates: annotation(blocky)|}];
  [%css {|font-feature-settings: normal|}];
  [%css {|font-feature-settings: 'swsh' 2|}];
  [%css {|font-language-override: normal|}];
  [%css {|font-language-override: 'SRB'|}];
  [%css {|font-weight: 1|}];
  [%css {|font-weight: 90|}];
  [%css {|font-weight: 750|}];
  [%css {|font-weight: 1000|}];
  [%css {|font-style: oblique 15deg|}];
  [%css {|font-style: oblique -15deg|}];
  [%css {|font-style: oblique 0deg|}];
  [%css {|font-optical-sizing: none|}];
  [%css {|font-optical-sizing: auto|}];
  [%css {|font-palette: normal|}];
  [%css {|font-palette: light|}];
  [%css {|font-palette: dark|}];
  [%css {|font-variant-emoji: normal|}];
  [%css {|font-variant-emoji: text|}];
  [%css {|font-variant-emoji: emoji|}];
  [%css {|font-variant-emoji: unicode|}];
  
  /* CSS Fonts Module Level 3 */
  [%css {|font-stretch: normal|}];
  [%css {|font-stretch: ultra-condensed|}];
  [%css {|font-stretch: extra-condensed|}];
  [%css {|font-stretch: condensed|}];
  [%css {|font-stretch: semi-condensed|}];
  [%css {|font-stretch: semi-expanded|}];
  [%css {|font-stretch: expanded|}];
  [%css {|font-stretch: extra-expanded|}];
  [%css {|font-stretch: ultra-expanded|}];
  [%css {|font-size-adjust: none|}];
  [%css {|font-size-adjust: .5|}];
  [%css {|font-synthesis: none|}];
  [%css {|font-synthesis: weight|}];
  [%css {|font-synthesis: style|}];
  [%css {|font-synthesis: weight style|}];
  [%css {|font-synthesis: style weight|}];
  [%css {|font-kerning: auto|}];
  [%css {|font-kerning: normal|}];
  [%css {|font-kerning: none|}];
  [%css {|font-variant-position: normal|}];
  [%css {|font-variant-position: sub|}];
  [%css {|font-variant-position: super|}];
  [%css {|font-variant-ligatures: normal|}];
  [%css {|font-variant-ligatures: none|}];
  [%css {|font-variant-ligatures: common-ligatures|}];
  [%css {|font-variant-ligatures: no-common-ligatures|}];
  [%css {|font-variant-ligatures: discretionary-ligatures|}];
  [%css {|font-variant-ligatures: no-discretionary-ligatures|}];
  [%css {|font-variant-ligatures: historical-ligatures|}];
  [%css {|font-variant-ligatures: no-historical-ligatures|}];
  [%css {|font-variant-ligatures: contextual|}];
  [%css {|font-variant-ligatures: no-contextual|}];
  [%css
    {|font-variant-ligatures: common-ligatures discretionary-ligatures historical-ligatures contextual|}
  ];
  [%css {|font-variant-caps: normal|}];
  [%css {|font-variant-caps: small-caps|}];
  [%css {|font-variant-caps: all-small-caps|}];
  [%css {|font-variant-caps: petite-caps|}];
  [%css {|font-variant-caps: all-petite-caps|}];
  [%css {|font-variant-caps: titling-caps|}];
  [%css {|font-variant-caps: unicase|}];
  [%css {|font-variant-numeric: normal|}];
  [%css {|font-variant-numeric: lining-nums|}];
  [%css {|font-variant-numeric: oldstyle-nums|}];
  [%css {|font-variant-numeric: proportional-nums|}];
  [%css {|font-variant-numeric: tabular-nums|}];
  [%css {|font-variant-numeric: diagonal-fractions|}];
  [%css {|font-variant-numeric: stacked-fractions|}];
  [%css {|font-variant-numeric: ordinal|}];
  [%css {|font-variant-numeric: slashed-zero|}];
  [%css
    {|font-variant-numeric: lining-nums proportional-nums diagonal-fractions|}
  ];
  [%css
    {|font-variant-numeric: oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero|}
  ];
  [%css
    {|font-variant-numeric: slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums|}
  ];
  [%css {|font-variant-east-asian: normal|}];
  [%css {|font-variant-east-asian: jis78|}];
  [%css {|font-variant-east-asian: jis83|}];
  [%css {|font-variant-east-asian: jis90|}];
  [%css {|font-variant-east-asian: jis04|}];
  [%css {|font-variant-east-asian: simplified|}];
  [%css {|font-variant-east-asian: traditional|}];
  [%css {|font-variant-east-asian: full-width|}];
  [%css {|font-variant-east-asian: proportional-width|}];
  [%css {|font-variant-east-asian: ruby|}];
  [%css {|font-variant-east-asian: simplified full-width ruby|}];
  [%css {|font-feature-settings: normal|}];
  [%css {|font-feature-settings: 'c2sc'|}];
  [%css {|font-feature-settings: 'smcp' on|}];
  [%css {|font-feature-settings: 'liga' off|}];
  [%css {|font-feature-settings: 'smcp', 'swsh' 2|}];
