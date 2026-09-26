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
  [@css "._a_65001838t{font-family:\"Inter Semi Bold\";}"];
  [@css "._a_65001ww9k{font-family:var(--fonts-qhzb1y);}"];
  [@css "._a_650018hy8{font-family:Inter;}"];
  [@css "._a_65001j23c{font-family:var(--fontStack-q2u8nj);}"];
  [@css "._a_65001zhkv{font-family:Inter, Sans;}"];
  [@css "._a_65001l4c9{font-family:Inter, var(--font-165jgna);}"];
  [@css "._a_65001vvt7{font-family:\"Gill Sans Extrabold\", sans-serif;}"];
  [@css "._a_6dh51u{font-synthesis-weight:none;}"];
  [@css "._a_6co3g2{font-synthesis-style:auto;}"];
  [@css "._a_6buzmx{font-synthesis-small-caps:none;}"];
  [@css "._a_6aqsbz{font-synthesis-position:auto;}"];
  [@css "._a_6500wq8d0{font-size:xxx-large;}"];
  [@css "._a_650e8tzp2{font-variant:none;}"];
  [@css "._a_650e8lpwk{font-variant:normal;}"];
  [@css "._a_650e8hi6x{font-variant:all-petite-caps;}"];
  [@css "._a_650e8n7po{font-variant:historical-forms;}"];
  [@css "._a_650e8srpk{font-variant:super;}"];
  [@css "._a_650e8gmww{font-variant:sub lining-nums contextual ruby;}"];
  [@css "._a_650e8lj9l{font-variant:annotation(circled);}"];
  [@css
    "._a_650e8c25g{font-variant:discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U);}"
  ];
  [@css "._a_650sg7x05{font-variant-alternates:normal;}"];
  [@css "._a_650sgpxzw{font-variant-alternates:historical-forms;}"];
  [@css "._a_650sghjze{font-variant-alternates:styleset(ss01);}"];
  [@css
    "._a_650sgkqdt{font-variant-alternates:styleset(stacked-g, geometric-m);}"
  ];
  [@css "._a_650sg90vj{font-variant-alternates:character-variant(cv02);}"];
  [@css
    "._a_650sg2zxs{font-variant-alternates:character-variant(beta-3, gamma);}"
  ];
  [@css "._a_650sgcfjl{font-variant-alternates:swash(flowing);}"];
  [@css "._a_650sgb0td{font-variant-alternates:ornaments(leaves);}"];
  [@css "._a_650sgtt93{font-variant-alternates:annotation(blocky);}"];
  [@css "._a_65002ml8d{font-feature-settings:normal;}"];
  [@css "._a_65002jzzi{font-feature-settings:\"swsh\" 2;}"];
  [@css "._a_65008vtlx{font-language-override:normal;}"];
  [@css "._a_65008bfe6{font-language-override:\"SRB\";}"];
  [@css "._a_65m9sihfq{font-weight:1;}"];
  [@css "._a_65m9sg2wc{font-weight:90;}"];
  [@css "._a_65m9szzf7{font-weight:750;}"];
  [@css "._a_65m9s946z{font-weight:1000;}"];
  [@css "._a_65074finr{font-style:oblique 15deg;}"];
  [@css "._a_65074h9ap{font-style:oblique -15deg;}"];
  [@css "._a_650744bxt{font-style:oblique 0deg;}"];
  [@css "._a_6500gno1j{font-optical-sizing:none;}"];
  [@css "._a_6500gz9v1{font-optical-sizing:auto;}"];
  [@css "._a_6729j8{font-palette:normal;}"];
  [@css "._a_67mxeq{font-palette:light;}"];
  [@css "._a_67fxax{font-palette:dark;}"];
  [@css "._a_656bk2ijg{font-variant-emoji:normal;}"];
  [@css "._a_656bkdp3m{font-variant-emoji:text;}"];
  [@css "._a_656bkoi24{font-variant-emoji:emoji;}"];
  [@css "._a_656bkmq5j{font-variant-emoji:unicode;}"];
  [@css "._a_6503kh4h6{font-stretch:normal;}"];
  [@css "._a_6503k8aej{font-stretch:ultra-condensed;}"];
  [@css "._a_6503kh6uj{font-stretch:extra-condensed;}"];
  [@css "._a_6503k726d{font-stretch:condensed;}"];
  [@css "._a_6503kypsq{font-stretch:semi-condensed;}"];
  [@css "._a_6503kryki{font-stretch:semi-expanded;}"];
  [@css "._a_6503k1ay3{font-stretch:expanded;}"];
  [@css "._a_6503katbv{font-stretch:extra-expanded;}"];
  [@css "._a_6503knsma{font-stretch:ultra-expanded;}"];
  [@css "._a_6501suc3c{font-size-adjust:none;}"];
  [@css "._a_6501smswb{font-size-adjust:0.5;}"];
  [@css "._a_69h0bs{font-synthesis:none;}"];
  [@css "._a_69xz73{font-synthesis:weight;}"];
  [@css "._a_69mipp{font-synthesis:style;}"];
  [@css "._a_69nabk{font-synthesis:weight style;}"];
  [@css "._a_69e0hd{font-synthesis:style weight;}"];
  [@css "._a_65004lltu{font-kerning:auto;}"];
  [@css "._a_65004ygkk{font-kerning:normal;}"];
  [@css "._a_65004d4ye{font-kerning:none;}"];
  [@css "._a_65ekg6yro{font-variant-position:normal;}"];
  [@css "._a_65ekgp6w0{font-variant-position:sub;}"];
  [@css "._a_65ekgsgdl{font-variant-position:super;}"];
  [@css "._a_65cn4ncv3{font-variant-ligatures:normal;}"];
  [@css "._a_65cn4mnc1{font-variant-ligatures:none;}"];
  [@css "._a_65cn4l9n8{font-variant-ligatures:common-ligatures;}"];
  [@css "._a_65cn4tjmp{font-variant-ligatures:no-common-ligatures;}"];
  [@css "._a_65cn4rq81{font-variant-ligatures:discretionary-ligatures;}"];
  [@css "._a_65cn4v26z{font-variant-ligatures:no-discretionary-ligatures;}"];
  [@css "._a_65cn4em3q{font-variant-ligatures:historical-ligatures;}"];
  [@css "._a_65cn461tv{font-variant-ligatures:no-historical-ligatures;}"];
  [@css "._a_65cn4p3ik{font-variant-ligatures:contextual;}"];
  [@css "._a_65cn4adwq{font-variant-ligatures:no-contextual;}"];
  [@css
    "._a_65cn4pu2q{font-variant-ligatures:common-ligatures discretionary-ligatures historical-ligatures contextual;}"
  ];
  [@css "._a_651kwdg8c{font-variant-caps:normal;}"];
  [@css "._a_651kwczn6{font-variant-caps:small-caps;}"];
  [@css "._a_651kw67x8{font-variant-caps:all-small-caps;}"];
  [@css "._a_651kwy53c{font-variant-caps:petite-caps;}"];
  [@css "._a_651kwigep{font-variant-caps:all-petite-caps;}"];
  [@css "._a_651kw5fsu{font-variant-caps:titling-caps;}"];
  [@css "._a_651kw0uxy{font-variant-caps:unicase;}"];
  [@css "._a_65pa8uao3{font-variant-numeric:normal;}"];
  [@css "._a_65pa8peun{font-variant-numeric:lining-nums;}"];
  [@css "._a_65pa87maz{font-variant-numeric:oldstyle-nums;}"];
  [@css "._a_65pa8sgo0{font-variant-numeric:proportional-nums;}"];
  [@css "._a_65pa8umeb{font-variant-numeric:tabular-nums;}"];
  [@css "._a_65pa8y4ib{font-variant-numeric:diagonal-fractions;}"];
  [@css "._a_65pa809vx{font-variant-numeric:stacked-fractions;}"];
  [@css "._a_65pa880vn{font-variant-numeric:ordinal;}"];
  [@css "._a_65pa8u4g7{font-variant-numeric:slashed-zero;}"];
  [@css
    "._a_65pa8eltn{font-variant-numeric:lining-nums proportional-nums diagonal-fractions;}"
  ];
  [@css
    "._a_65pa8gh45{font-variant-numeric:oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero;}"
  ];
  [@css
    "._a_65pa8ogoi{font-variant-numeric:slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums;}"
  ];
  [@css "._a_6535s9p3j{font-variant-east-asian:normal;}"];
  [@css "._a_6535sgmiy{font-variant-east-asian:jis78;}"];
  [@css "._a_6535s0lxz{font-variant-east-asian:jis83;}"];
  [@css "._a_6535swqjo{font-variant-east-asian:jis90;}"];
  [@css "._a_6535smffc{font-variant-east-asian:jis04;}"];
  [@css "._a_6535s95a9{font-variant-east-asian:simplified;}"];
  [@css "._a_6535schv1{font-variant-east-asian:traditional;}"];
  [@css "._a_6535s5bhw{font-variant-east-asian:full-width;}"];
  [@css "._a_6535sw7p8{font-variant-east-asian:proportional-width;}"];
  [@css "._a_6535sc1ts{font-variant-east-asian:ruby;}"];
  [@css "._a_6535stn8m{font-variant-east-asian:simplified full-width ruby;}"];
  [@css "._a_65002yne0{font-feature-settings:\"c2sc\";}"];
  [@css "._a_65002rtd8{font-feature-settings:\"smcp\" on;}"];
  [@css "._a_65002pmmf{font-feature-settings:\"liga\" off;}"];
  [@css "._a_65002vt2s{font-feature-settings:\"smcp\", \"swsh\" 2;}"];
  
  let fonts: array(CSS.Types.FontFamilyName.t) = [|
    `quoted("Inter"),
    `quoted("Sans"),
  |];
  let fontStack: array(CSS.Types.FontFamilyName.t) = [|`quoted("Inter")|];
  let font: CSS.Types.FontFamily.t = `quoted("Inter");
  
  CSS.make("_a_65001838t", []);
  CSS.make(
    "_a_65001ww9k",
    [("--fonts-qhzb1y", CSS.Types.FontFamilies.toString(fonts))],
  );
  CSS.make("_a_650018hy8", []);
  CSS.make(
    "_a_65001j23c",
    [("--fontStack-q2u8nj", CSS.Types.FontFamilies.toString(fontStack))],
  );
  CSS.make("_a_65001zhkv", []);
  CSS.make(
    "_a_65001l4c9",
    [("--font-165jgna", CSS.Types.FontFamily.toString(font))],
  );
  CSS.make("_a_65001vvt7", []);
  
  CSS.make("_a_6dh51u", []);
  CSS.make("_a_6co3g2", []);
  CSS.make("_a_6buzmx", []);
  CSS.make("_a_6aqsbz", []);
  CSS.make("_a_6500wq8d0", []);
  CSS.make("_a_650e8tzp2", []);
  CSS.make("_a_650e8lpwk", []);
  CSS.make("_a_650e8hi6x", []);
  CSS.make("_a_650e8n7po", []);
  CSS.make("_a_650e8srpk", []);
  CSS.make("_a_650e8gmww", []);
  CSS.make("_a_650e8lj9l", []);
  CSS.make("_a_650e8c25g", []);
  CSS.make("_a_650sg7x05", []);
  CSS.make("_a_650sgpxzw", []);
  CSS.make("_a_650sghjze", []);
  CSS.make("_a_650sgkqdt", []);
  CSS.make("_a_650sg90vj", []);
  CSS.make("_a_650sg2zxs", []);
  CSS.make("_a_650sgcfjl", []);
  CSS.make("_a_650sgb0td", []);
  CSS.make("_a_650sgtt93", []);
  CSS.make("_a_65002ml8d", []);
  CSS.make("_a_65002jzzi", []);
  CSS.make("_a_65008vtlx", []);
  CSS.make("_a_65008bfe6", []);
  CSS.make("_a_65m9sihfq", []);
  CSS.make("_a_65m9sg2wc", []);
  CSS.make("_a_65m9szzf7", []);
  CSS.make("_a_65m9s946z", []);
  CSS.make("_a_65074finr", []);
  CSS.make("_a_65074h9ap", []);
  CSS.make("_a_650744bxt", []);
  CSS.make("_a_6500gno1j", []);
  CSS.make("_a_6500gz9v1", []);
  CSS.make("_a_6729j8", []);
  CSS.make("_a_67mxeq", []);
  CSS.make("_a_67fxax", []);
  CSS.make("_a_656bk2ijg", []);
  CSS.make("_a_656bkdp3m", []);
  CSS.make("_a_656bkoi24", []);
  CSS.make("_a_656bkmq5j", []);
  
  CSS.make("_a_6503kh4h6", []);
  CSS.make("_a_6503k8aej", []);
  CSS.make("_a_6503kh6uj", []);
  CSS.make("_a_6503k726d", []);
  CSS.make("_a_6503kypsq", []);
  CSS.make("_a_6503kryki", []);
  CSS.make("_a_6503k1ay3", []);
  CSS.make("_a_6503katbv", []);
  CSS.make("_a_6503knsma", []);
  CSS.make("_a_6501suc3c", []);
  CSS.make("_a_6501smswb", []);
  CSS.make("_a_69h0bs", []);
  CSS.make("_a_69xz73", []);
  CSS.make("_a_69mipp", []);
  CSS.make("_a_69nabk", []);
  CSS.make("_a_69e0hd", []);
  CSS.make("_a_65004lltu", []);
  CSS.make("_a_65004ygkk", []);
  CSS.make("_a_65004d4ye", []);
  CSS.make("_a_65ekg6yro", []);
  CSS.make("_a_65ekgp6w0", []);
  CSS.make("_a_65ekgsgdl", []);
  CSS.make("_a_65cn4ncv3", []);
  CSS.make("_a_65cn4mnc1", []);
  CSS.make("_a_65cn4l9n8", []);
  CSS.make("_a_65cn4tjmp", []);
  CSS.make("_a_65cn4rq81", []);
  CSS.make("_a_65cn4v26z", []);
  CSS.make("_a_65cn4em3q", []);
  CSS.make("_a_65cn461tv", []);
  CSS.make("_a_65cn4p3ik", []);
  CSS.make("_a_65cn4adwq", []);
  CSS.make("_a_65cn4pu2q", []);
  CSS.make("_a_651kwdg8c", []);
  CSS.make("_a_651kwczn6", []);
  CSS.make("_a_651kw67x8", []);
  CSS.make("_a_651kwy53c", []);
  CSS.make("_a_651kwigep", []);
  CSS.make("_a_651kw5fsu", []);
  CSS.make("_a_651kw0uxy", []);
  CSS.make("_a_65pa8uao3", []);
  CSS.make("_a_65pa8peun", []);
  CSS.make("_a_65pa87maz", []);
  CSS.make("_a_65pa8sgo0", []);
  CSS.make("_a_65pa8umeb", []);
  CSS.make("_a_65pa8y4ib", []);
  CSS.make("_a_65pa809vx", []);
  CSS.make("_a_65pa880vn", []);
  CSS.make("_a_65pa8u4g7", []);
  CSS.make("_a_65pa8eltn", []);
  CSS.make("_a_65pa8gh45", []);
  CSS.make("_a_65pa8ogoi", []);
  CSS.make("_a_6535s9p3j", []);
  CSS.make("_a_6535sgmiy", []);
  CSS.make("_a_6535s0lxz", []);
  CSS.make("_a_6535swqjo", []);
  CSS.make("_a_6535smffc", []);
  CSS.make("_a_6535s95a9", []);
  CSS.make("_a_6535schv1", []);
  CSS.make("_a_6535s5bhw", []);
  CSS.make("_a_6535sw7p8", []);
  CSS.make("_a_6535sc1ts", []);
  CSS.make("_a_6535stn8m", []);
  CSS.make("_a_65002ml8d", []);
  CSS.make("_a_65002yne0", []);
  CSS.make("_a_65002rtd8", []);
  CSS.make("_a_65002pmmf", []);
  CSS.make("_a_65002vt2s", []);
