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
  [@css "@property --fonts-qhzb1y{syntax:\"*\";inherits:false;}"];
  [@css "@property --fontStack-q2u8nj{syntax:\"*\";inherits:false;}"];
  [@css "@property --font-165jgna{syntax:\"*\";inherits:false;}"];
  [@css ".a-65001838t{font-family:\"Inter Semi Bold\";}"];
  [@css ".a-65001ww9k{font-family:var(--fonts-qhzb1y);}"];
  [@css ".a-650018hy8{font-family:Inter;}"];
  [@css ".a-65001j23c{font-family:var(--fontStack-q2u8nj);}"];
  [@css ".a-65001zhkv{font-family:Inter, Sans;}"];
  [@css ".a-65001l4c9{font-family:Inter, var(--font-165jgna);}"];
  [@css ".a-65001vvt7{font-family:\"Gill Sans Extrabold\", sans-serif;}"];
  [@css ".a-6dh51u{font-synthesis-weight:none;}"];
  [@css ".a-6co3g2{font-synthesis-style:auto;}"];
  [@css ".a-6buzmx{font-synthesis-small-caps:none;}"];
  [@css ".a-6aqsbz{font-synthesis-position:auto;}"];
  [@css ".a-6500wq8d0{font-size:xxx-large;}"];
  [@css ".a-650e8tzp2{font-variant:none;}"];
  [@css ".a-650e8lpwk{font-variant:normal;}"];
  [@css ".a-650e8hi6x{font-variant:all-petite-caps;}"];
  [@css ".a-650e8n7po{font-variant:historical-forms;}"];
  [@css ".a-650e8srpk{font-variant:super;}"];
  [@css ".a-650e8gmww{font-variant:sub lining-nums contextual ruby;}"];
  [@css ".a-650e8lj9l{font-variant:annotation(circled);}"];
  [@css
    ".a-650e8c25g{font-variant:discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U);}"
  ];
  [@css ".a-650sg7x05{font-variant-alternates:normal;}"];
  [@css ".a-650sgpxzw{font-variant-alternates:historical-forms;}"];
  [@css ".a-650sghjze{font-variant-alternates:styleset(ss01);}"];
  [@css
    ".a-650sgkqdt{font-variant-alternates:styleset(stacked-g, geometric-m);}"
  ];
  [@css ".a-650sg90vj{font-variant-alternates:character-variant(cv02);}"];
  [@css
    ".a-650sg2zxs{font-variant-alternates:character-variant(beta-3, gamma);}"
  ];
  [@css ".a-650sgcfjl{font-variant-alternates:swash(flowing);}"];
  [@css ".a-650sgb0td{font-variant-alternates:ornaments(leaves);}"];
  [@css ".a-650sgtt93{font-variant-alternates:annotation(blocky);}"];
  [@css ".a-65002ml8d{font-feature-settings:normal;}"];
  [@css ".a-65002jzzi{font-feature-settings:\"swsh\" 2;}"];
  [@css ".a-65008vtlx{font-language-override:normal;}"];
  [@css ".a-65008bfe6{font-language-override:\"SRB\";}"];
  [@css ".a-65m9sihfq{font-weight:1;}"];
  [@css ".a-65m9sg2wc{font-weight:90;}"];
  [@css ".a-65m9szzf7{font-weight:750;}"];
  [@css ".a-65m9s946z{font-weight:1000;}"];
  [@css ".a-65074finr{font-style:oblique 15deg;}"];
  [@css ".a-65074h9ap{font-style:oblique -15deg;}"];
  [@css ".a-650744bxt{font-style:oblique 0deg;}"];
  [@css ".a-6500gno1j{font-optical-sizing:none;}"];
  [@css ".a-6500gz9v1{font-optical-sizing:auto;}"];
  [@css ".a-6729j8{font-palette:normal;}"];
  [@css ".a-67mxeq{font-palette:light;}"];
  [@css ".a-67fxax{font-palette:dark;}"];
  [@css ".a-656bk2ijg{font-variant-emoji:normal;}"];
  [@css ".a-656bkdp3m{font-variant-emoji:text;}"];
  [@css ".a-656bkoi24{font-variant-emoji:emoji;}"];
  [@css ".a-656bkmq5j{font-variant-emoji:unicode;}"];
  [@css ".a-6503kh4h6{font-stretch:normal;}"];
  [@css ".a-6503k8aej{font-stretch:ultra-condensed;}"];
  [@css ".a-6503kh6uj{font-stretch:extra-condensed;}"];
  [@css ".a-6503k726d{font-stretch:condensed;}"];
  [@css ".a-6503kypsq{font-stretch:semi-condensed;}"];
  [@css ".a-6503kryki{font-stretch:semi-expanded;}"];
  [@css ".a-6503k1ay3{font-stretch:expanded;}"];
  [@css ".a-6503katbv{font-stretch:extra-expanded;}"];
  [@css ".a-6503knsma{font-stretch:ultra-expanded;}"];
  [@css ".a-6501suc3c{font-size-adjust:none;}"];
  [@css ".a-6501smswb{font-size-adjust:0.5;}"];
  [@css ".a-69h0bs{font-synthesis:none;}"];
  [@css ".a-69xz73{font-synthesis:weight;}"];
  [@css ".a-69mipp{font-synthesis:style;}"];
  [@css ".a-69nabk{font-synthesis:weight style;}"];
  [@css ".a-69e0hd{font-synthesis:style weight;}"];
  [@css ".a-65004lltu{font-kerning:auto;}"];
  [@css ".a-65004ygkk{font-kerning:normal;}"];
  [@css ".a-65004d4ye{font-kerning:none;}"];
  [@css ".a-65ekg6yro{font-variant-position:normal;}"];
  [@css ".a-65ekgp6w0{font-variant-position:sub;}"];
  [@css ".a-65ekgsgdl{font-variant-position:super;}"];
  [@css ".a-65cn4ncv3{font-variant-ligatures:normal;}"];
  [@css ".a-65cn4mnc1{font-variant-ligatures:none;}"];
  [@css ".a-65cn4l9n8{font-variant-ligatures:common-ligatures;}"];
  [@css ".a-65cn4tjmp{font-variant-ligatures:no-common-ligatures;}"];
  [@css ".a-65cn4rq81{font-variant-ligatures:discretionary-ligatures;}"];
  [@css ".a-65cn4v26z{font-variant-ligatures:no-discretionary-ligatures;}"];
  [@css ".a-65cn4em3q{font-variant-ligatures:historical-ligatures;}"];
  [@css ".a-65cn461tv{font-variant-ligatures:no-historical-ligatures;}"];
  [@css ".a-65cn4p3ik{font-variant-ligatures:contextual;}"];
  [@css ".a-65cn4adwq{font-variant-ligatures:no-contextual;}"];
  [@css
    ".a-65cn4pu2q{font-variant-ligatures:common-ligatures discretionary-ligatures historical-ligatures contextual;}"
  ];
  [@css ".a-651kwdg8c{font-variant-caps:normal;}"];
  [@css ".a-651kwczn6{font-variant-caps:small-caps;}"];
  [@css ".a-651kw67x8{font-variant-caps:all-small-caps;}"];
  [@css ".a-651kwy53c{font-variant-caps:petite-caps;}"];
  [@css ".a-651kwigep{font-variant-caps:all-petite-caps;}"];
  [@css ".a-651kw5fsu{font-variant-caps:titling-caps;}"];
  [@css ".a-651kw0uxy{font-variant-caps:unicase;}"];
  [@css ".a-65pa8uao3{font-variant-numeric:normal;}"];
  [@css ".a-65pa8peun{font-variant-numeric:lining-nums;}"];
  [@css ".a-65pa87maz{font-variant-numeric:oldstyle-nums;}"];
  [@css ".a-65pa8sgo0{font-variant-numeric:proportional-nums;}"];
  [@css ".a-65pa8umeb{font-variant-numeric:tabular-nums;}"];
  [@css ".a-65pa8y4ib{font-variant-numeric:diagonal-fractions;}"];
  [@css ".a-65pa809vx{font-variant-numeric:stacked-fractions;}"];
  [@css ".a-65pa880vn{font-variant-numeric:ordinal;}"];
  [@css ".a-65pa8u4g7{font-variant-numeric:slashed-zero;}"];
  [@css
    ".a-65pa8eltn{font-variant-numeric:lining-nums proportional-nums diagonal-fractions;}"
  ];
  [@css
    ".a-65pa8gh45{font-variant-numeric:oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero;}"
  ];
  [@css
    ".a-65pa8ogoi{font-variant-numeric:slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums;}"
  ];
  [@css ".a-6535s9p3j{font-variant-east-asian:normal;}"];
  [@css ".a-6535sgmiy{font-variant-east-asian:jis78;}"];
  [@css ".a-6535s0lxz{font-variant-east-asian:jis83;}"];
  [@css ".a-6535swqjo{font-variant-east-asian:jis90;}"];
  [@css ".a-6535smffc{font-variant-east-asian:jis04;}"];
  [@css ".a-6535s95a9{font-variant-east-asian:simplified;}"];
  [@css ".a-6535schv1{font-variant-east-asian:traditional;}"];
  [@css ".a-6535s5bhw{font-variant-east-asian:full-width;}"];
  [@css ".a-6535sw7p8{font-variant-east-asian:proportional-width;}"];
  [@css ".a-6535sc1ts{font-variant-east-asian:ruby;}"];
  [@css ".a-6535stn8m{font-variant-east-asian:simplified full-width ruby;}"];
  [@css ".a-65002yne0{font-feature-settings:\"c2sc\";}"];
  [@css ".a-65002rtd8{font-feature-settings:\"smcp\" on;}"];
  [@css ".a-65002pmmf{font-feature-settings:\"liga\" off;}"];
  [@css ".a-65002vt2s{font-feature-settings:\"smcp\", \"swsh\" 2;}"];
  
  let fonts: array(CSS.Types.FontFamilyName.t) = [|
    `quoted("Inter"),
    `quoted("Sans"),
  |];
  let fontStack: array(CSS.Types.FontFamilyName.t) = [|`quoted("Inter")|];
  let font: CSS.Types.FontFamily.t = `quoted("Inter");
  
  CSS.make("a-65001838t", []);
  CSS.make(
    "a-65001ww9k",
    [("--fonts-qhzb1y", CSS.Types.FontFamilies.toString(fonts))],
  );
  CSS.make("a-650018hy8", []);
  CSS.make(
    "a-65001j23c",
    [("--fontStack-q2u8nj", CSS.Types.FontFamilies.toString(fontStack))],
  );
  CSS.make("a-65001zhkv", []);
  CSS.make(
    "a-65001l4c9",
    [("--font-165jgna", CSS.Types.FontFamily.toString(font))],
  );
  CSS.make("a-65001vvt7", []);
  
  CSS.make("a-6dh51u", []);
  CSS.make("a-6co3g2", []);
  CSS.make("a-6buzmx", []);
  CSS.make("a-6aqsbz", []);
  CSS.make("a-6500wq8d0", []);
  CSS.make("a-650e8tzp2", []);
  CSS.make("a-650e8lpwk", []);
  CSS.make("a-650e8hi6x", []);
  CSS.make("a-650e8n7po", []);
  CSS.make("a-650e8srpk", []);
  CSS.make("a-650e8gmww", []);
  CSS.make("a-650e8lj9l", []);
  CSS.make("a-650e8c25g", []);
  CSS.make("a-650sg7x05", []);
  CSS.make("a-650sgpxzw", []);
  CSS.make("a-650sghjze", []);
  CSS.make("a-650sgkqdt", []);
  CSS.make("a-650sg90vj", []);
  CSS.make("a-650sg2zxs", []);
  CSS.make("a-650sgcfjl", []);
  CSS.make("a-650sgb0td", []);
  CSS.make("a-650sgtt93", []);
  CSS.make("a-65002ml8d", []);
  CSS.make("a-65002jzzi", []);
  CSS.make("a-65008vtlx", []);
  CSS.make("a-65008bfe6", []);
  CSS.make("a-65m9sihfq", []);
  CSS.make("a-65m9sg2wc", []);
  CSS.make("a-65m9szzf7", []);
  CSS.make("a-65m9s946z", []);
  CSS.make("a-65074finr", []);
  CSS.make("a-65074h9ap", []);
  CSS.make("a-650744bxt", []);
  CSS.make("a-6500gno1j", []);
  CSS.make("a-6500gz9v1", []);
  CSS.make("a-6729j8", []);
  CSS.make("a-67mxeq", []);
  CSS.make("a-67fxax", []);
  CSS.make("a-656bk2ijg", []);
  CSS.make("a-656bkdp3m", []);
  CSS.make("a-656bkoi24", []);
  CSS.make("a-656bkmq5j", []);
  
  CSS.make("a-6503kh4h6", []);
  CSS.make("a-6503k8aej", []);
  CSS.make("a-6503kh6uj", []);
  CSS.make("a-6503k726d", []);
  CSS.make("a-6503kypsq", []);
  CSS.make("a-6503kryki", []);
  CSS.make("a-6503k1ay3", []);
  CSS.make("a-6503katbv", []);
  CSS.make("a-6503knsma", []);
  CSS.make("a-6501suc3c", []);
  CSS.make("a-6501smswb", []);
  CSS.make("a-69h0bs", []);
  CSS.make("a-69xz73", []);
  CSS.make("a-69mipp", []);
  CSS.make("a-69nabk", []);
  CSS.make("a-69e0hd", []);
  CSS.make("a-65004lltu", []);
  CSS.make("a-65004ygkk", []);
  CSS.make("a-65004d4ye", []);
  CSS.make("a-65ekg6yro", []);
  CSS.make("a-65ekgp6w0", []);
  CSS.make("a-65ekgsgdl", []);
  CSS.make("a-65cn4ncv3", []);
  CSS.make("a-65cn4mnc1", []);
  CSS.make("a-65cn4l9n8", []);
  CSS.make("a-65cn4tjmp", []);
  CSS.make("a-65cn4rq81", []);
  CSS.make("a-65cn4v26z", []);
  CSS.make("a-65cn4em3q", []);
  CSS.make("a-65cn461tv", []);
  CSS.make("a-65cn4p3ik", []);
  CSS.make("a-65cn4adwq", []);
  CSS.make("a-65cn4pu2q", []);
  CSS.make("a-651kwdg8c", []);
  CSS.make("a-651kwczn6", []);
  CSS.make("a-651kw67x8", []);
  CSS.make("a-651kwy53c", []);
  CSS.make("a-651kwigep", []);
  CSS.make("a-651kw5fsu", []);
  CSS.make("a-651kw0uxy", []);
  CSS.make("a-65pa8uao3", []);
  CSS.make("a-65pa8peun", []);
  CSS.make("a-65pa87maz", []);
  CSS.make("a-65pa8sgo0", []);
  CSS.make("a-65pa8umeb", []);
  CSS.make("a-65pa8y4ib", []);
  CSS.make("a-65pa809vx", []);
  CSS.make("a-65pa880vn", []);
  CSS.make("a-65pa8u4g7", []);
  CSS.make("a-65pa8eltn", []);
  CSS.make("a-65pa8gh45", []);
  CSS.make("a-65pa8ogoi", []);
  CSS.make("a-6535s9p3j", []);
  CSS.make("a-6535sgmiy", []);
  CSS.make("a-6535s0lxz", []);
  CSS.make("a-6535swqjo", []);
  CSS.make("a-6535smffc", []);
  CSS.make("a-6535s95a9", []);
  CSS.make("a-6535schv1", []);
  CSS.make("a-6535s5bhw", []);
  CSS.make("a-6535sw7p8", []);
  CSS.make("a-6535sc1ts", []);
  CSS.make("a-6535stn8m", []);
  CSS.make("a-65002ml8d", []);
  CSS.make("a-65002yne0", []);
  CSS.make("a-65002rtd8", []);
  CSS.make("a-65002pmmf", []);
  CSS.make("a-65002vt2s", []);
