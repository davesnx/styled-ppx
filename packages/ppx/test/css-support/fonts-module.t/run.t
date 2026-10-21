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
  [@css "._a_650001838t{font-family:\"Inter Semi Bold\";}"];
  [@css "._a_650001ww9k{font-family:var(--fonts-qhzb1y);}"];
  [@css "._a_6500018hy8{font-family:Inter;}"];
  [@css "._a_650001j23c{font-family:var(--fontStack-q2u8nj);}"];
  [@css "._a_650001zhkv{font-family:Inter, Sans;}"];
  [@css "._a_650001l4c9{font-family:Inter, var(--font-165jgna);}"];
  [@css "._a_650001vvt7{font-family:\"Gill Sans Extrabold\", sans-serif;}"];
  [@css "._a_6dh51u{font-synthesis-weight:none;}"];
  [@css "._a_6co3g2{font-synthesis-style:auto;}"];
  [@css "._a_6buzmx{font-synthesis-small-caps:none;}"];
  [@css "._a_6aqsbz{font-synthesis-position:auto;}"];
  [@css "._a_65000wq8d0{font-size:xxx-large;}"];
  [@css "._a_6500e8tzp2{font-variant:none;}"];
  [@css "._a_6500e8lpwk{font-variant:normal;}"];
  [@css "._a_6500e8hi6x{font-variant:all-petite-caps;}"];
  [@css "._a_6500e8n7po{font-variant:historical-forms;}"];
  [@css "._a_6500e8srpk{font-variant:super;}"];
  [@css "._a_6500e8gmww{font-variant:sub lining-nums contextual ruby;}"];
  [@css "._a_6500e8lj9l{font-variant:annotation(circled);}"];
  [@css
    "._a_6500e8c25g{font-variant:discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U);}"
  ];
  [@css "._a_6500sg7x05{font-variant-alternates:normal;}"];
  [@css "._a_6500sgpxzw{font-variant-alternates:historical-forms;}"];
  [@css "._a_6500sghjze{font-variant-alternates:styleset(ss01);}"];
  [@css
    "._a_6500sgkqdt{font-variant-alternates:styleset(stacked-g, geometric-m);}"
  ];
  [@css "._a_6500sg90vj{font-variant-alternates:character-variant(cv02);}"];
  [@css
    "._a_6500sg2zxs{font-variant-alternates:character-variant(beta-3, gamma);}"
  ];
  [@css "._a_6500sgcfjl{font-variant-alternates:swash(flowing);}"];
  [@css "._a_6500sgb0td{font-variant-alternates:ornaments(leaves);}"];
  [@css "._a_6500sgtt93{font-variant-alternates:annotation(blocky);}"];
  [@css "._a_650002ml8d{font-feature-settings:normal;}"];
  [@css "._a_650002jzzi{font-feature-settings:\"swsh\" 2;}"];
  [@css "._a_650008vtlx{font-language-override:normal;}"];
  [@css "._a_650008bfe6{font-language-override:\"SRB\";}"];
  [@css "._a_655m9sihfq{font-weight:1;}"];
  [@css "._a_655m9sg2wc{font-weight:90;}"];
  [@css "._a_655m9szzf7{font-weight:750;}"];
  [@css "._a_655m9s946z{font-weight:1000;}"];
  [@css "._a_650074finr{font-style:oblique 15deg;}"];
  [@css "._a_650074h9ap{font-style:oblique -15deg;}"];
  [@css "._a_6500744bxt{font-style:oblique 0deg;}"];
  [@css "._a_65000gno1j{font-optical-sizing:none;}"];
  [@css "._a_65000gz9v1{font-optical-sizing:auto;}"];
  [@css "._a_6729j8{font-palette:normal;}"];
  [@css "._a_67mxeq{font-palette:light;}"];
  [@css "._a_67fxax{font-palette:dark;}"];
  [@css "._a_6506bk2ijg{font-variant-emoji:normal;}"];
  [@css "._a_6506bkdp3m{font-variant-emoji:text;}"];
  [@css "._a_6506bkoi24{font-variant-emoji:emoji;}"];
  [@css "._a_6506bkmq5j{font-variant-emoji:unicode;}"];
  [@css "._a_65003kh4h6{font-stretch:normal;}"];
  [@css "._a_65003k8aej{font-stretch:ultra-condensed;}"];
  [@css "._a_65003kh6uj{font-stretch:extra-condensed;}"];
  [@css "._a_65003k726d{font-stretch:condensed;}"];
  [@css "._a_65003kypsq{font-stretch:semi-condensed;}"];
  [@css "._a_65003kryki{font-stretch:semi-expanded;}"];
  [@css "._a_65003k1ay3{font-stretch:expanded;}"];
  [@css "._a_65003katbv{font-stretch:extra-expanded;}"];
  [@css "._a_65003knsma{font-stretch:ultra-expanded;}"];
  [@css "._a_65001suc3c{font-size-adjust:none;}"];
  [@css "._a_65001smswb{font-size-adjust:0.5;}"];
  [@css "._a_69h0bs{font-synthesis:none;}"];
  [@css "._a_69xz73{font-synthesis:weight;}"];
  [@css "._a_69mipp{font-synthesis:style;}"];
  [@css "._a_69nabk{font-synthesis:weight style;}"];
  [@css "._a_69e0hd{font-synthesis:style weight;}"];
  [@css "._a_650004lltu{font-kerning:auto;}"];
  [@css "._a_650004ygkk{font-kerning:normal;}"];
  [@css "._a_650004d4ye{font-kerning:none;}"];
  [@css "._a_651ekg6yro{font-variant-position:normal;}"];
  [@css "._a_651ekgp6w0{font-variant-position:sub;}"];
  [@css "._a_651ekgsgdl{font-variant-position:super;}"];
  [@css "._a_650cn4ncv3{font-variant-ligatures:normal;}"];
  [@css "._a_650cn4mnc1{font-variant-ligatures:none;}"];
  [@css "._a_650cn4l9n8{font-variant-ligatures:common-ligatures;}"];
  [@css "._a_650cn4tjmp{font-variant-ligatures:no-common-ligatures;}"];
  [@css "._a_650cn4rq81{font-variant-ligatures:discretionary-ligatures;}"];
  [@css "._a_650cn4v26z{font-variant-ligatures:no-discretionary-ligatures;}"];
  [@css "._a_650cn4em3q{font-variant-ligatures:historical-ligatures;}"];
  [@css "._a_650cn461tv{font-variant-ligatures:no-historical-ligatures;}"];
  [@css "._a_650cn4p3ik{font-variant-ligatures:contextual;}"];
  [@css "._a_650cn4adwq{font-variant-ligatures:no-contextual;}"];
  [@css
    "._a_650cn4pu2q{font-variant-ligatures:common-ligatures discretionary-ligatures historical-ligatures contextual;}"
  ];
  [@css "._a_6501kwdg8c{font-variant-caps:normal;}"];
  [@css "._a_6501kwczn6{font-variant-caps:small-caps;}"];
  [@css "._a_6501kw67x8{font-variant-caps:all-small-caps;}"];
  [@css "._a_6501kwy53c{font-variant-caps:petite-caps;}"];
  [@css "._a_6501kwigep{font-variant-caps:all-petite-caps;}"];
  [@css "._a_6501kw5fsu{font-variant-caps:titling-caps;}"];
  [@css "._a_6501kw0uxy{font-variant-caps:unicase;}"];
  [@css "._a_650pa8uao3{font-variant-numeric:normal;}"];
  [@css "._a_650pa8peun{font-variant-numeric:lining-nums;}"];
  [@css "._a_650pa87maz{font-variant-numeric:oldstyle-nums;}"];
  [@css "._a_650pa8sgo0{font-variant-numeric:proportional-nums;}"];
  [@css "._a_650pa8umeb{font-variant-numeric:tabular-nums;}"];
  [@css "._a_650pa8y4ib{font-variant-numeric:diagonal-fractions;}"];
  [@css "._a_650pa809vx{font-variant-numeric:stacked-fractions;}"];
  [@css "._a_650pa880vn{font-variant-numeric:ordinal;}"];
  [@css "._a_650pa8u4g7{font-variant-numeric:slashed-zero;}"];
  [@css
    "._a_650pa8eltn{font-variant-numeric:lining-nums proportional-nums diagonal-fractions;}"
  ];
  [@css
    "._a_650pa8gh45{font-variant-numeric:oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero;}"
  ];
  [@css
    "._a_650pa8ogoi{font-variant-numeric:slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums;}"
  ];
  [@css "._a_65035s9p3j{font-variant-east-asian:normal;}"];
  [@css "._a_65035sgmiy{font-variant-east-asian:jis78;}"];
  [@css "._a_65035s0lxz{font-variant-east-asian:jis83;}"];
  [@css "._a_65035swqjo{font-variant-east-asian:jis90;}"];
  [@css "._a_65035smffc{font-variant-east-asian:jis04;}"];
  [@css "._a_65035s95a9{font-variant-east-asian:simplified;}"];
  [@css "._a_65035schv1{font-variant-east-asian:traditional;}"];
  [@css "._a_65035s5bhw{font-variant-east-asian:full-width;}"];
  [@css "._a_65035sw7p8{font-variant-east-asian:proportional-width;}"];
  [@css "._a_65035sc1ts{font-variant-east-asian:ruby;}"];
  [@css "._a_65035stn8m{font-variant-east-asian:simplified full-width ruby;}"];
  [@css "._a_650002yne0{font-feature-settings:\"c2sc\";}"];
  [@css "._a_650002rtd8{font-feature-settings:\"smcp\" on;}"];
  [@css "._a_650002pmmf{font-feature-settings:\"liga\" off;}"];
  [@css "._a_650002vt2s{font-feature-settings:\"smcp\", \"swsh\" 2;}"];
  [@css.blocks
    [
      (13, "_a_650001838t"),
      (14, "_a_650001ww9k"),
      (15, "_a_6500018hy8"),
      (16, "_a_650001j23c"),
      (17, "_a_650001zhkv"),
      (18, "_a_650001l4c9"),
      (19, "_a_650001vvt7"),
      (22, "_a_6dh51u"),
      (23, "_a_6co3g2"),
      (24, "_a_6buzmx"),
      (25, "_a_6aqsbz"),
      (26, "_a_65000wq8d0"),
      (27, "_a_6500e8tzp2"),
      (28, "_a_6500e8lpwk"),
      (29, "_a_6500e8hi6x"),
      (30, "_a_6500e8n7po"),
      (31, "_a_6500e8srpk"),
      (32, "_a_6500e8gmww"),
      (33, "_a_6500e8lj9l"),
      (35, "_a_6500e8c25g"),
      (37, "_a_6500sg7x05"),
      (38, "_a_6500sgpxzw"),
      (39, "_a_6500sghjze"),
      (40, "_a_6500sgkqdt"),
      (41, "_a_6500sg90vj"),
      (42, "_a_6500sg2zxs"),
      (43, "_a_6500sgcfjl"),
      (44, "_a_6500sgb0td"),
      (45, "_a_6500sgtt93"),
      (46, "_a_650002ml8d"),
      (47, "_a_650002jzzi"),
      (48, "_a_650008vtlx"),
      (49, "_a_650008bfe6"),
      (50, "_a_655m9sihfq"),
      (51, "_a_655m9sg2wc"),
      (52, "_a_655m9szzf7"),
      (53, "_a_655m9s946z"),
      (54, "_a_650074finr"),
      (55, "_a_650074h9ap"),
      (56, "_a_6500744bxt"),
      (57, "_a_65000gno1j"),
      (58, "_a_65000gz9v1"),
      (59, "_a_6729j8"),
      (60, "_a_67mxeq"),
      (61, "_a_67fxax"),
      (62, "_a_6506bk2ijg"),
      (63, "_a_6506bkdp3m"),
      (64, "_a_6506bkoi24"),
      (65, "_a_6506bkmq5j"),
      (68, "_a_65003kh4h6"),
      (69, "_a_65003k8aej"),
      (70, "_a_65003kh6uj"),
      (71, "_a_65003k726d"),
      (72, "_a_65003kypsq"),
      (73, "_a_65003kryki"),
      (74, "_a_65003k1ay3"),
      (75, "_a_65003katbv"),
      (76, "_a_65003knsma"),
      (77, "_a_65001suc3c"),
      (78, "_a_65001smswb"),
      (79, "_a_69h0bs"),
      (80, "_a_69xz73"),
      (81, "_a_69mipp"),
      (82, "_a_69nabk"),
      (83, "_a_69e0hd"),
      (84, "_a_650004lltu"),
      (85, "_a_650004ygkk"),
      (86, "_a_650004d4ye"),
      (87, "_a_651ekg6yro"),
      (88, "_a_651ekgp6w0"),
      (89, "_a_651ekgsgdl"),
      (90, "_a_650cn4ncv3"),
      (91, "_a_650cn4mnc1"),
      (92, "_a_650cn4l9n8"),
      (93, "_a_650cn4tjmp"),
      (94, "_a_650cn4rq81"),
      (95, "_a_650cn4v26z"),
      (96, "_a_650cn4em3q"),
      (97, "_a_650cn461tv"),
      (98, "_a_650cn4p3ik"),
      (99, "_a_650cn4adwq"),
      (101, "_a_650cn4pu2q"),
      (103, "_a_6501kwdg8c"),
      (104, "_a_6501kwczn6"),
      (105, "_a_6501kw67x8"),
      (106, "_a_6501kwy53c"),
      (107, "_a_6501kwigep"),
      (108, "_a_6501kw5fsu"),
      (109, "_a_6501kw0uxy"),
      (110, "_a_650pa8uao3"),
      (111, "_a_650pa8peun"),
      (112, "_a_650pa87maz"),
      (113, "_a_650pa8sgo0"),
      (114, "_a_650pa8umeb"),
      (115, "_a_650pa8y4ib"),
      (116, "_a_650pa809vx"),
      (117, "_a_650pa880vn"),
      (118, "_a_650pa8u4g7"),
      (120, "_a_650pa8eltn"),
      (123, "_a_650pa8gh45"),
      (126, "_a_650pa8ogoi"),
      (128, "_a_65035s9p3j"),
      (129, "_a_65035sgmiy"),
      (130, "_a_65035s0lxz"),
      (131, "_a_65035swqjo"),
      (132, "_a_65035smffc"),
      (133, "_a_65035s95a9"),
      (134, "_a_65035schv1"),
      (135, "_a_65035s5bhw"),
      (136, "_a_65035sw7p8"),
      (137, "_a_65035sc1ts"),
      (138, "_a_65035stn8m"),
      (139, "_a_650002ml8d"),
      (140, "_a_650002yne0"),
      (141, "_a_650002rtd8"),
      (142, "_a_650002pmmf"),
      (143, "_a_650002vt2s"),
    ]
  ];
  
  let fonts: array(CSS.Types.FontFamilyName.t) = [|
    `quoted("Inter"),
    `quoted("Sans"),
  |];
  let fontStack: array(CSS.Types.FontFamilyName.t) = [|`quoted("Inter")|];
  let font: CSS.Types.FontFamily.t = `quoted("Inter");
  
  CSS.make("_a_650001838t", []);
  CSS.make(
    "_a_650001ww9k",
    [("--fonts-qhzb1y", CSS.Types.FontFamilies.toString(fonts))],
  );
  CSS.make("_a_6500018hy8", []);
  CSS.make(
    "_a_650001j23c",
    [("--fontStack-q2u8nj", CSS.Types.FontFamilies.toString(fontStack))],
  );
  CSS.make("_a_650001zhkv", []);
  CSS.make(
    "_a_650001l4c9",
    [("--font-165jgna", CSS.Types.FontFamily.toString(font))],
  );
  CSS.make("_a_650001vvt7", []);
  
  CSS.make("_a_6dh51u", []);
  CSS.make("_a_6co3g2", []);
  CSS.make("_a_6buzmx", []);
  CSS.make("_a_6aqsbz", []);
  CSS.make("_a_65000wq8d0", []);
  CSS.make("_a_6500e8tzp2", []);
  CSS.make("_a_6500e8lpwk", []);
  CSS.make("_a_6500e8hi6x", []);
  CSS.make("_a_6500e8n7po", []);
  CSS.make("_a_6500e8srpk", []);
  CSS.make("_a_6500e8gmww", []);
  CSS.make("_a_6500e8lj9l", []);
  CSS.make("_a_6500e8c25g", []);
  CSS.make("_a_6500sg7x05", []);
  CSS.make("_a_6500sgpxzw", []);
  CSS.make("_a_6500sghjze", []);
  CSS.make("_a_6500sgkqdt", []);
  CSS.make("_a_6500sg90vj", []);
  CSS.make("_a_6500sg2zxs", []);
  CSS.make("_a_6500sgcfjl", []);
  CSS.make("_a_6500sgb0td", []);
  CSS.make("_a_6500sgtt93", []);
  CSS.make("_a_650002ml8d", []);
  CSS.make("_a_650002jzzi", []);
  CSS.make("_a_650008vtlx", []);
  CSS.make("_a_650008bfe6", []);
  CSS.make("_a_655m9sihfq", []);
  CSS.make("_a_655m9sg2wc", []);
  CSS.make("_a_655m9szzf7", []);
  CSS.make("_a_655m9s946z", []);
  CSS.make("_a_650074finr", []);
  CSS.make("_a_650074h9ap", []);
  CSS.make("_a_6500744bxt", []);
  CSS.make("_a_65000gno1j", []);
  CSS.make("_a_65000gz9v1", []);
  CSS.make("_a_6729j8", []);
  CSS.make("_a_67mxeq", []);
  CSS.make("_a_67fxax", []);
  CSS.make("_a_6506bk2ijg", []);
  CSS.make("_a_6506bkdp3m", []);
  CSS.make("_a_6506bkoi24", []);
  CSS.make("_a_6506bkmq5j", []);
  
  CSS.make("_a_65003kh4h6", []);
  CSS.make("_a_65003k8aej", []);
  CSS.make("_a_65003kh6uj", []);
  CSS.make("_a_65003k726d", []);
  CSS.make("_a_65003kypsq", []);
  CSS.make("_a_65003kryki", []);
  CSS.make("_a_65003k1ay3", []);
  CSS.make("_a_65003katbv", []);
  CSS.make("_a_65003knsma", []);
  CSS.make("_a_65001suc3c", []);
  CSS.make("_a_65001smswb", []);
  CSS.make("_a_69h0bs", []);
  CSS.make("_a_69xz73", []);
  CSS.make("_a_69mipp", []);
  CSS.make("_a_69nabk", []);
  CSS.make("_a_69e0hd", []);
  CSS.make("_a_650004lltu", []);
  CSS.make("_a_650004ygkk", []);
  CSS.make("_a_650004d4ye", []);
  CSS.make("_a_651ekg6yro", []);
  CSS.make("_a_651ekgp6w0", []);
  CSS.make("_a_651ekgsgdl", []);
  CSS.make("_a_650cn4ncv3", []);
  CSS.make("_a_650cn4mnc1", []);
  CSS.make("_a_650cn4l9n8", []);
  CSS.make("_a_650cn4tjmp", []);
  CSS.make("_a_650cn4rq81", []);
  CSS.make("_a_650cn4v26z", []);
  CSS.make("_a_650cn4em3q", []);
  CSS.make("_a_650cn461tv", []);
  CSS.make("_a_650cn4p3ik", []);
  CSS.make("_a_650cn4adwq", []);
  CSS.make("_a_650cn4pu2q", []);
  CSS.make("_a_6501kwdg8c", []);
  CSS.make("_a_6501kwczn6", []);
  CSS.make("_a_6501kw67x8", []);
  CSS.make("_a_6501kwy53c", []);
  CSS.make("_a_6501kwigep", []);
  CSS.make("_a_6501kw5fsu", []);
  CSS.make("_a_6501kw0uxy", []);
  CSS.make("_a_650pa8uao3", []);
  CSS.make("_a_650pa8peun", []);
  CSS.make("_a_650pa87maz", []);
  CSS.make("_a_650pa8sgo0", []);
  CSS.make("_a_650pa8umeb", []);
  CSS.make("_a_650pa8y4ib", []);
  CSS.make("_a_650pa809vx", []);
  CSS.make("_a_650pa880vn", []);
  CSS.make("_a_650pa8u4g7", []);
  CSS.make("_a_650pa8eltn", []);
  CSS.make("_a_650pa8gh45", []);
  CSS.make("_a_650pa8ogoi", []);
  CSS.make("_a_65035s9p3j", []);
  CSS.make("_a_65035sgmiy", []);
  CSS.make("_a_65035s0lxz", []);
  CSS.make("_a_65035swqjo", []);
  CSS.make("_a_65035smffc", []);
  CSS.make("_a_65035s95a9", []);
  CSS.make("_a_65035schv1", []);
  CSS.make("_a_65035s5bhw", []);
  CSS.make("_a_65035sw7p8", []);
  CSS.make("_a_65035sc1ts", []);
  CSS.make("_a_65035stn8m", []);
  CSS.make("_a_650002ml8d", []);
  CSS.make("_a_650002yne0", []);
  CSS.make("_a_650002rtd8", []);
  CSS.make("_a_650002pmmf", []);
  CSS.make("_a_650002vt2s", []);
