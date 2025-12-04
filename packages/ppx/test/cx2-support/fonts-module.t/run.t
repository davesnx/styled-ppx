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
  [@css
    ".css-1yh8y83 { font-family: \"Inter Semi Bold\"; }\n.css-rvdc3c { font-family: var(--var-rwkopp); }\n.css-1tld6m7 { font-family: Inter; }\n.css-1tzlrlf { font-family: var(--var-1kuyir6); }\n.css-s6qja { font-family: Inter, Sans; }\n.css-vunoql { font-family: Inter, var(--var-1kuyir6); }\n.css-z3hct { font-family: \"Gill Sans Extrabold\", sans-serif; }\n.css-1bploa9 { font-synthesis-weight: none; }\n.css-1drr8gt { font-synthesis-style: auto; }\n.css-1ddj7zx { font-synthesis-small-caps: none; }\n.css-1xoj5m { font-synthesis-position: auto; }\n.css-1a513m3 { font-size: xxx-large; }\n.css-1ehf6f9 { font-variant: none; }\n.css-ryafo1 { font-variant: normal; }\n.css-8367pr { font-variant: all-petite-caps; }\n.css-1iogdr4 { font-variant: historical-forms; }\n.css-2ot6pl { font-variant: super; }\n.css-yvhkli { font-variant: sub lining-nums contextual ruby; }\n.css-1lowew4 { font-variant: annotation(circled); }\n.css-itm0ox { font-variant-alternates: normal; }\n.css-28gbru { font-variant-alternates: historical-forms; }\n.css-og11tz { font-variant-alternates: styleset(ss01); }\n.css-1w9besq { font-variant-alternates: styleset(stacked-g, geometric-m); }\n.css-tb2ume { font-variant-alternates: character-variant(cv02); }\n.css-e0jtrj { font-variant-alternates: character-variant(beta-3, gamma); }\n.css-b0o5kj { font-variant-alternates: swash(flowing); }\n.css-1m7l8wa { font-variant-alternates: ornaments(leaves); }\n.css-1j29x7d { font-variant-alternates: annotation(blocky); }\n.css-137kjuu { font-feature-settings: normal; }\n.css-zn5kmf { font-feature-settings: \"swsh\" 2; }\n.css-g7kogz { font-language-override: normal; }\n.css-1kf2ysw { font-language-override: \"SRB\"; }\n.css-tv9ff2 { font-weight: 1; }\n.css-ksqve7 { font-weight: 90; }\n.css-1nclupy { font-weight: 750; }\n.css-l4ntow { font-weight: 1000; }\n.css-17lpqfq { font-style: oblique 15deg; }\n.css-sx5izd { font-style: oblique -15deg; }\n.css-ul7sch { font-style: oblique 0deg; }\n.css-1vdkd3j { font-optical-sizing: none; }\n.css-1hqgfbb { font-optical-sizing: auto; }\n.css-1cqn90a { font-palette: normal; }\n.css-cvlbx2 { font-palette: light; }\n.css-1lejbrv { font-palette: dark; }\n.css-1dwkccs { font-variant-emoji: normal; }\n.css-1m9xw39 { font-variant-emoji: text; }\n.css-18tpl5w { font-variant-emoji: emoji; }\n.css-15i7vv { font-variant-emoji: unicode; }\n.css-1c1z0ud { font-stretch: normal; }\n.css-1crb9in { font-stretch: ultra-condensed; }\n.css-utrg6t { font-stretch: extra-condensed; }\n.css-1d5u08g { font-stretch: condensed; }\n.css-1dwebyp { font-stretch: semi-condensed; }\n.css-zye7ex { font-stretch: semi-expanded; }\n.css-yky96y { font-stretch: expanded; }\n.css-y083o9 { font-stretch: extra-expanded; }\n.css-1okihu7 { font-stretch: ultra-expanded; }\n.css-1ije61b { font-size-adjust: none; }\n.css-11xhw3b { font-size-adjust: .5; }\n.css-gwfmg5 { font-synthesis: none; }\n.css-1sbz8pm { font-synthesis: weight; }\n.css-1dxqvwj { font-synthesis: style; }\n.css-17s6u94 { font-synthesis: weight style; }\n.css-k5nh87 { font-synthesis: style weight; }\n.css-o3j7vf { font-kerning: auto; }\n.css-13dbqc3 { font-kerning: normal; }\n.css-1tcc3vd { font-kerning: none; }\n.css-1g8q3bv { font-variant-position: normal; }\n.css-1vup242 { font-variant-position: sub; }\n.css-1ueii6c { font-variant-position: super; }\n.css-9zpf9w { font-variant-ligatures: normal; }\n.css-e8joc3 { font-variant-ligatures: none; }\n.css-oo3x1i { font-variant-ligatures: common-ligatures; }\n.css-1nle3aa { font-variant-ligatures: no-common-ligatures; }\n.css-1hgzznd { font-variant-ligatures: discretionary-ligatures; }\n.css-mz8m0l { font-variant-ligatures: no-discretionary-ligatures; }\n.css-1n989jy { font-variant-ligatures: historical-ligatures; }\n.css-qdsl52 { font-variant-ligatures: no-historical-ligatures; }\n.css-1ne90m3 { font-variant-ligatures: contextual; }\n.css-1ci2pga { font-variant-ligatures: no-contextual; }\n.css-sdxocj { font-variant-caps: normal; }\n.css-dtbd2k { font-variant-caps: small-caps; }\n.css-11j2o1e { font-variant-caps: all-small-caps; }\n.css-c0cicn { font-variant-caps: petite-caps; }\n.css-124j6h5 { font-variant-caps: all-petite-caps; }\n.css-2alhl6 { font-variant-caps: titling-caps; }\n.css-ecojxv { font-variant-caps: unicase; }\n.css-1nqai0a { font-variant-numeric: normal; }\n.css-5kgkgw { font-variant-numeric: lining-nums; }\n.css-d7prr8 { font-variant-numeric: oldstyle-nums; }\n.css-1iwgbx1 { font-variant-numeric: proportional-nums; }\n.css-bu561y { font-variant-numeric: tabular-nums; }\n.css-joxrp { font-variant-numeric: diagonal-fractions; }\n.css-pfig6m { font-variant-numeric: stacked-fractions; }\n.css-sl616j { font-variant-numeric: ordinal; }\n.css-1kf3ug7 { font-variant-numeric: slashed-zero; }\n.css-1aotijl { font-variant-east-asian: normal; }\n.css-emdxvy { font-variant-east-asian: jis78; }\n.css-10yfuvu { font-variant-east-asian: jis83; }\n.css-1mul5yf { font-variant-east-asian: jis90; }\n.css-1bbwd0g { font-variant-east-asian: jis04; }\n.css-43tqy1 { font-variant-east-asian: simplified; }\n.css-1pf4j65 { font-variant-east-asian: traditional; }\n.css-utgdl0 { font-variant-east-asian: full-width; }\n.css-4xrcqn { font-variant-east-asian: proportional-width; }\n.css-1v1n8to { font-variant-east-asian: ruby; }\n.css-1rh9xqk { font-variant-east-asian: simplified full-width ruby; }\n.css-if81cw { font-feature-settings: \"c2sc\"; }\n.css-v2950b { font-feature-settings: \"smcp\" on; }\n.css-cz83zy { font-feature-settings: \"liga\" off; }\n.css-d9a5zs { font-feature-settings: \"smcp\", \"swsh\" 2; }\n"
  ];
  CSS.make("css-1yh8y83", []);
  CSS.make(
    "css-rvdc3c",
    [("--var-rwkopp", CSS.Types.FontFamily.toString(fonts))],
  );
  CSS.make("css-1tld6m7", []);
  CSS.make(
    "css-1tzlrlf",
    [("--var-1kuyir6", CSS.Types.FontFamily.toString(font))],
  );
  CSS.make("css-s6qja", []);
  CSS.make(
    "css-vunoql",
    [("--var-1kuyir6", CSS.Types.FontFamily.toString(font))],
  );
  CSS.make("css-z3hct", []);
  
  CSS.make("css-1bploa9", []);
  CSS.make("css-1drr8gt", []);
  CSS.make("css-1ddj7zx", []);
  CSS.make("css-1xoj5m", []);
  CSS.make("css-1a513m3", []);
  CSS.make("css-1ehf6f9", []);
  CSS.make("css-ryafo1", []);
  CSS.make("css-8367pr", []);
  CSS.make("css-1iogdr4", []);
  CSS.make("css-2ot6pl", []);
  CSS.make("css-yvhkli", []);
  CSS.make("css-1lowew4", []);
  CSS.unsafe(
    {js|fontVariant|js},
    {js|discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U)|js},
  );
  CSS.make("css-itm0ox", []);
  CSS.make("css-28gbru", []);
  CSS.make("css-og11tz", []);
  CSS.make("css-1w9besq", []);
  CSS.make("css-tb2ume", []);
  CSS.make("css-e0jtrj", []);
  CSS.make("css-b0o5kj", []);
  CSS.make("css-1m7l8wa", []);
  CSS.make("css-1j29x7d", []);
  CSS.make("css-137kjuu", []);
  CSS.make("css-zn5kmf", []);
  CSS.make("css-g7kogz", []);
  CSS.make("css-1kf2ysw", []);
  CSS.make("css-tv9ff2", []);
  CSS.make("css-ksqve7", []);
  CSS.make("css-1nclupy", []);
  CSS.make("css-l4ntow", []);
  CSS.make("css-17lpqfq", []);
  CSS.make("css-sx5izd", []);
  CSS.make("css-ul7sch", []);
  CSS.make("css-1vdkd3j", []);
  CSS.make("css-1hqgfbb", []);
  CSS.make("css-1cqn90a", []);
  CSS.make("css-cvlbx2", []);
  CSS.make("css-1lejbrv", []);
  CSS.make("css-1dwkccs", []);
  CSS.make("css-1m9xw39", []);
  CSS.make("css-18tpl5w", []);
  CSS.make("css-15i7vv", []);
  
  CSS.make("css-1c1z0ud", []);
  CSS.make("css-1crb9in", []);
  CSS.make("css-utrg6t", []);
  CSS.make("css-1d5u08g", []);
  CSS.make("css-1dwebyp", []);
  CSS.make("css-zye7ex", []);
  CSS.make("css-yky96y", []);
  CSS.make("css-y083o9", []);
  CSS.make("css-1okihu7", []);
  CSS.make("css-1ije61b", []);
  CSS.make("css-11xhw3b", []);
  CSS.make("css-gwfmg5", []);
  CSS.make("css-1sbz8pm", []);
  CSS.make("css-1dxqvwj", []);
  CSS.make("css-17s6u94", []);
  CSS.make("css-k5nh87", []);
  CSS.make("css-o3j7vf", []);
  CSS.make("css-13dbqc3", []);
  CSS.make("css-1tcc3vd", []);
  CSS.make("css-1g8q3bv", []);
  CSS.make("css-1vup242", []);
  CSS.make("css-1ueii6c", []);
  CSS.make("css-9zpf9w", []);
  CSS.make("css-e8joc3", []);
  CSS.make("css-oo3x1i", []);
  CSS.make("css-1nle3aa", []);
  CSS.make("css-1hgzznd", []);
  CSS.make("css-mz8m0l", []);
  CSS.make("css-1n989jy", []);
  CSS.make("css-qdsl52", []);
  CSS.make("css-1ne90m3", []);
  CSS.make("css-1ci2pga", []);
  CSS.unsafe(
    {js|fontVariantLigatures|js},
    {js|common-ligatures discretionary-ligatures historical-ligatures contextual|js},
  );
  CSS.make("css-sdxocj", []);
  CSS.make("css-dtbd2k", []);
  CSS.make("css-11j2o1e", []);
  CSS.make("css-c0cicn", []);
  CSS.make("css-124j6h5", []);
  CSS.make("css-2alhl6", []);
  CSS.make("css-ecojxv", []);
  CSS.make("css-1nqai0a", []);
  CSS.make("css-5kgkgw", []);
  CSS.make("css-d7prr8", []);
  CSS.make("css-1iwgbx1", []);
  CSS.make("css-bu561y", []);
  CSS.make("css-joxrp", []);
  CSS.make("css-pfig6m", []);
  CSS.make("css-sl616j", []);
  CSS.make("css-1kf3ug7", []);
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
  CSS.make("css-1aotijl", []);
  CSS.make("css-emdxvy", []);
  CSS.make("css-10yfuvu", []);
  CSS.make("css-1mul5yf", []);
  CSS.make("css-1bbwd0g", []);
  CSS.make("css-43tqy1", []);
  CSS.make("css-1pf4j65", []);
  CSS.make("css-utgdl0", []);
  CSS.make("css-4xrcqn", []);
  CSS.make("css-1v1n8to", []);
  CSS.make("css-1rh9xqk", []);
  CSS.make("css-137kjuu", []);
  CSS.make("css-if81cw", []);
  CSS.make("css-v2950b", []);
  CSS.make("css-cz83zy", []);
  CSS.make("css-d9a5zs", []);
