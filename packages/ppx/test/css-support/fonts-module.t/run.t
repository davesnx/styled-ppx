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
  [@css "@property --16mqtb3-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --10aiqz5-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --rt0yzf-0{syntax:\"*\";inherits:false;}"];
  [@css ".css-1fyntm7{font-family:\"Inter Semi Bold\";}"];
  [@css ".css-16mqtb3{font-family:var(--16mqtb3-0);}"];
  [@css ".css-1cmelzg{font-family:Inter;}"];
  [@css ".css-10aiqz5{font-family:var(--10aiqz5-0);}"];
  [@css ".css-1o465pj{font-family:Inter, Sans;}"];
  [@css ".css-rt0yzf{font-family:Inter, var(--rt0yzf-0);}"];
  [@css ".css-kcya2y{font-family:\"Gill Sans Extrabold\", sans-serif;}"];
  [@css ".css-4tpnst{font-synthesis-weight:none;}"];
  [@css ".css-13hg49l{font-synthesis-style:auto;}"];
  [@css ".css-1abkc7i{font-synthesis-small-caps:none;}"];
  [@css ".css-eul2a7{font-synthesis-position:auto;}"];
  [@css ".css-ulgk63{font-size:xxx-large;}"];
  [@css ".css-17qwbuq{font-variant:none;}"];
  [@css ".css-1f228g7{font-variant:normal;}"];
  [@css ".css-1e2civ{font-variant:all-petite-caps;}"];
  [@css ".css-wzt6y6{font-variant:historical-forms;}"];
  [@css ".css-vmh0rf{font-variant:super;}"];
  [@css ".css-gyjx6j{font-variant:sub lining-nums contextual ruby;}"];
  [@css ".css-4rgv1r{font-variant:annotation(circled);}"];
  [@css
    ".css-toylcb{font-variant:discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U);}"
  ];
  [@css ".css-1wnyrbp{font-variant-alternates:normal;}"];
  [@css ".css-a9g9{font-variant-alternates:historical-forms;}"];
  [@css ".css-1dtseo6{font-variant-alternates:styleset(ss01);}"];
  [@css
    ".css-3dri83{font-variant-alternates:styleset(stacked-g, geometric-m);}"
  ];
  [@css ".css-1p26oew{font-variant-alternates:character-variant(cv02);}"];
  [@css
    ".css-1ybbj0{font-variant-alternates:character-variant(beta-3, gamma);}"
  ];
  [@css ".css-ye82z7{font-variant-alternates:swash(flowing);}"];
  [@css ".css-1xjackv{font-variant-alternates:ornaments(leaves);}"];
  [@css ".css-1n5769x{font-variant-alternates:annotation(blocky);}"];
  [@css ".css-13saerl{font-feature-settings:normal;}"];
  [@css ".css-8zrobg{font-feature-settings:\"swsh\" 2;}"];
  [@css ".css-1pkky84{font-language-override:normal;}"];
  [@css ".css-1go7h28{font-language-override:\"SRB\";}"];
  [@css ".css-1tg0r2s{font-weight:1;}"];
  [@css ".css-rbjbzi{font-weight:90;}"];
  [@css ".css-1svy3m1{font-weight:750;}"];
  [@css ".css-v34kh8{font-weight:1000;}"];
  [@css ".css-1l3911e{font-style:oblique 15deg;}"];
  [@css ".css-w1cddc{font-style:oblique -15deg;}"];
  [@css ".css-95x30{font-style:oblique 0deg;}"];
  [@css ".css-n2ezd2{font-optical-sizing:none;}"];
  [@css ".css-51z60q{font-optical-sizing:auto;}"];
  [@css ".css-1ixvyyq{font-palette:normal;}"];
  [@css ".css-qplls6{font-palette:light;}"];
  [@css ".css-12elq0x{font-palette:dark;}"];
  [@css ".css-18147h{font-variant-emoji:normal;}"];
  [@css ".css-1044h57{font-variant-emoji:text;}"];
  [@css ".css-1lm3kx{font-variant-emoji:emoji;}"];
  [@css ".css-1m946u0{font-variant-emoji:unicode;}"];
  [@css ".css-1y64hz6{font-stretch:normal;}"];
  [@css ".css-1ejvwru{font-stretch:ultra-condensed;}"];
  [@css ".css-16nwzoy{font-stretch:extra-condensed;}"];
  [@css ".css-1dy44et{font-stretch:condensed;}"];
  [@css ".css-jpeay4{font-stretch:semi-condensed;}"];
  [@css ".css-120cmk9{font-stretch:semi-expanded;}"];
  [@css ".css-tpgad6{font-stretch:expanded;}"];
  [@css ".css-1gqgwh9{font-stretch:extra-expanded;}"];
  [@css ".css-n4h9ke{font-stretch:ultra-expanded;}"];
  [@css ".css-lghvvl{font-size-adjust:none;}"];
  [@css ".css-1frj61{font-size-adjust:0.5;}"];
  [@css ".css-1c7iwkn{font-synthesis:none;}"];
  [@css ".css-4atw3v{font-synthesis:weight;}"];
  [@css ".css-15pu40q{font-synthesis:style;}"];
  [@css ".css-15c1bon{font-synthesis:weight style;}"];
  [@css ".css-6zc9d8{font-synthesis:style weight;}"];
  [@css ".css-1ngfgrz{font-kerning:auto;}"];
  [@css ".css-1117rlm{font-kerning:normal;}"];
  [@css ".css-1lsew1u{font-kerning:none;}"];
  [@css ".css-1o8cfa2{font-variant-position:normal;}"];
  [@css ".css-wsh9dr{font-variant-position:sub;}"];
  [@css ".css-1kpumbp{font-variant-position:super;}"];
  [@css ".css-voxwgq{font-variant-ligatures:normal;}"];
  [@css ".css-1iefl2l{font-variant-ligatures:none;}"];
  [@css ".css-tszbee{font-variant-ligatures:common-ligatures;}"];
  [@css ".css-1wsok1f{font-variant-ligatures:no-common-ligatures;}"];
  [@css ".css-1vur8kf{font-variant-ligatures:discretionary-ligatures;}"];
  [@css ".css-y5nsug{font-variant-ligatures:no-discretionary-ligatures;}"];
  [@css ".css-1i4whbk{font-variant-ligatures:historical-ligatures;}"];
  [@css ".css-uiwz2z{font-variant-ligatures:no-historical-ligatures;}"];
  [@css ".css-1iztkxs{font-variant-ligatures:contextual;}"];
  [@css ".css-c9c700{font-variant-ligatures:no-contextual;}"];
  [@css
    ".css-1soby4s{font-variant-ligatures:common-ligatures discretionary-ligatures historical-ligatures contextual;}"
  ];
  [@css ".css-13n3ulx{font-variant-caps:normal;}"];
  [@css ".css-1otufdk{font-variant-caps:small-caps;}"];
  [@css ".css-14dthvx{font-variant-caps:all-small-caps;}"];
  [@css ".css-4wc5h6{font-variant-caps:petite-caps;}"];
  [@css ".css-1bt2axa{font-variant-caps:all-petite-caps;}"];
  [@css ".css-czs978{font-variant-caps:titling-caps;}"];
  [@css ".css-1kevxnj{font-variant-caps:unicase;}"];
  [@css ".css-1iuxexx{font-variant-numeric:normal;}"];
  [@css ".css-1w2v3t2{font-variant-numeric:lining-nums;}"];
  [@css ".css-12vs7zl{font-variant-numeric:oldstyle-nums;}"];
  [@css ".css-1u9xge9{font-variant-numeric:proportional-nums;}"];
  [@css ".css-1p4f6x1{font-variant-numeric:tabular-nums;}"];
  [@css ".css-1dtt0y9{font-variant-numeric:diagonal-fractions;}"];
  [@css ".css-1l9iruu{font-variant-numeric:stacked-fractions;}"];
  [@css ".css-10cjabe{font-variant-numeric:ordinal;}"];
  [@css ".css-t0quk6{font-variant-numeric:slashed-zero;}"];
  [@css
    ".css-1fxwtsk{font-variant-numeric:lining-nums proportional-nums diagonal-fractions;}"
  ];
  [@css
    ".css-826zga{font-variant-numeric:oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero;}"
  ];
  [@css
    ".css-1kpt3jh{font-variant-numeric:slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums;}"
  ];
  [@css ".css-1eb1kxs{font-variant-east-asian:normal;}"];
  [@css ".css-1l95el{font-variant-east-asian:jis78;}"];
  [@css ".css-81ixbv{font-variant-east-asian:jis83;}"];
  [@css ".css-m8pmrc{font-variant-east-asian:jis90;}"];
  [@css ".css-6ir786{font-variant-east-asian:jis04;}"];
  [@css ".css-1trzlr8{font-variant-east-asian:simplified;}"];
  [@css ".css-uakv1g{font-variant-east-asian:traditional;}"];
  [@css ".css-hgkrju{font-variant-east-asian:full-width;}"];
  [@css ".css-1i5wy8l{font-variant-east-asian:proportional-width;}"];
  [@css ".css-1imm8rm{font-variant-east-asian:ruby;}"];
  [@css ".css-o9qnpf{font-variant-east-asian:simplified full-width ruby;}"];
  [@css ".css-qxd3vf{font-feature-settings:\"c2sc\";}"];
  [@css ".css-1as2xyt{font-feature-settings:\"smcp\" on;}"];
  [@css ".css-1mjka1p{font-feature-settings:\"liga\" off;}"];
  [@css ".css-1pmwujj{font-feature-settings:\"smcp\", \"swsh\" 2;}"];
  [@css.classes
    [
      ("css-1fyntm7", 3, "", "input.re", 13, 8, 13, 39),
      ("css-16mqtb3", 4, "", "input.re", 14, 8, 14, 30),
      ("css-1cmelzg", 5, "", "input.re", 15, 8, 15, 27),
      ("css-10aiqz5", 6, "", "input.re", 16, 8, 16, 34),
      ("css-1o465pj", 7, "", "input.re", 17, 8, 17, 33),
      ("css-rt0yzf", 8, "", "input.re", 18, 8, 18, 36),
      ("css-kcya2y", 9, "", "input.re", 19, 8, 19, 55),
      ("css-4tpnst", 10, "", "input.re", 22, 8, 22, 35),
      ("css-13hg49l", 11, "", "input.re", 23, 8, 23, 34),
      ("css-1abkc7i", 12, "", "input.re", 24, 8, 24, 39),
      ("css-eul2a7", 13, "", "input.re", 25, 8, 25, 37),
      ("css-ulgk63", 14, "", "input.re", 26, 8, 26, 28),
      ("css-17qwbuq", 15, "", "input.re", 27, 8, 27, 26),
      ("css-1f228g7", 16, "", "input.re", 28, 8, 28, 28),
      ("css-1e2civ", 17, "", "input.re", 29, 8, 29, 37),
      ("css-wzt6y6", 18, "", "input.re", 30, 8, 30, 38),
      ("css-vmh0rf", 19, "", "input.re", 31, 8, 31, 27),
      ("css-gyjx6j", 20, "", "input.re", 32, 8, 32, 53),
      ("css-4rgv1r", 21, "", "input.re", 33, 8, 33, 41),
      ("css-toylcb", 22, "", "input.re", 35, 4, 35, 94),
      ("css-1wnyrbp", 23, "", "input.re", 37, 8, 37, 39),
      ("css-a9g9", 24, "", "input.re", 38, 8, 38, 49),
      ("css-1dtseo6", 25, "", "input.re", 39, 8, 39, 47),
      ("css-3dri83", 26, "", "input.re", 40, 8, 40, 65),
      ("css-1p26oew", 27, "", "input.re", 41, 8, 41, 56),
      ("css-1ybbj0", 28, "", "input.re", 42, 8, 42, 65),
      ("css-ye82z7", 29, "", "input.re", 43, 8, 43, 47),
      ("css-1xjackv", 30, "", "input.re", 44, 8, 44, 50),
      ("css-1n5769x", 31, "", "input.re", 45, 8, 45, 51),
      ("css-13saerl", 32, "", "input.re", 46, 8, 46, 37),
      ("css-8zrobg", 33, "", "input.re", 47, 8, 47, 39),
      ("css-1pkky84", 34, "", "input.re", 48, 8, 48, 38),
      ("css-1go7h28", 35, "", "input.re", 49, 8, 49, 37),
      ("css-1tg0r2s", 36, "", "input.re", 50, 8, 50, 22),
      ("css-rbjbzi", 37, "", "input.re", 51, 8, 51, 23),
      ("css-1svy3m1", 38, "", "input.re", 52, 8, 52, 24),
      ("css-v34kh8", 39, "", "input.re", 53, 8, 53, 25),
      ("css-1l3911e", 40, "", "input.re", 54, 8, 54, 33),
      ("css-w1cddc", 41, "", "input.re", 55, 8, 55, 34),
      ("css-95x30", 42, "", "input.re", 56, 8, 56, 32),
      ("css-n2ezd2", 43, "", "input.re", 57, 8, 57, 33),
      ("css-51z60q", 44, "", "input.re", 58, 8, 58, 33),
      ("css-1ixvyyq", 45, "", "input.re", 59, 8, 59, 28),
      ("css-qplls6", 46, "", "input.re", 60, 8, 60, 27),
      ("css-12elq0x", 47, "", "input.re", 61, 8, 61, 26),
      ("css-18147h", 48, "", "input.re", 62, 8, 62, 34),
      ("css-1044h57", 49, "", "input.re", 63, 8, 63, 32),
      ("css-1lm3kx", 50, "", "input.re", 64, 8, 64, 33),
      ("css-1m946u0", 51, "", "input.re", 65, 8, 65, 35),
      ("css-1y64hz6", 52, "", "input.re", 68, 8, 68, 28),
      ("css-1ejvwru", 53, "", "input.re", 69, 8, 69, 37),
      ("css-16nwzoy", 54, "", "input.re", 70, 8, 70, 37),
      ("css-1dy44et", 55, "", "input.re", 71, 8, 71, 31),
      ("css-jpeay4", 56, "", "input.re", 72, 8, 72, 36),
      ("css-120cmk9", 57, "", "input.re", 73, 8, 73, 35),
      ("css-tpgad6", 58, "", "input.re", 74, 8, 74, 30),
      ("css-1gqgwh9", 59, "", "input.re", 75, 8, 75, 36),
      ("css-n4h9ke", 60, "", "input.re", 76, 8, 76, 36),
      ("css-lghvvl", 61, "", "input.re", 77, 8, 77, 30),
      ("css-1frj61", 62, "", "input.re", 78, 8, 78, 28),
      ("css-1c7iwkn", 63, "", "input.re", 79, 8, 79, 28),
      ("css-4atw3v", 64, "", "input.re", 80, 8, 80, 30),
      ("css-15pu40q", 65, "", "input.re", 81, 8, 81, 29),
      ("css-15c1bon", 66, "", "input.re", 82, 8, 82, 36),
      ("css-6zc9d8", 67, "", "input.re", 83, 8, 83, 36),
      ("css-1ngfgrz", 68, "", "input.re", 84, 8, 84, 26),
      ("css-1117rlm", 69, "", "input.re", 85, 8, 85, 28),
      ("css-1lsew1u", 70, "", "input.re", 86, 8, 86, 26),
      ("css-1o8cfa2", 71, "", "input.re", 87, 8, 87, 37),
      ("css-wsh9dr", 72, "", "input.re", 88, 8, 88, 34),
      ("css-1kpumbp", 73, "", "input.re", 89, 8, 89, 36),
      ("css-voxwgq", 74, "", "input.re", 90, 8, 90, 38),
      ("css-1iefl2l", 75, "", "input.re", 91, 8, 91, 36),
      ("css-tszbee", 76, "", "input.re", 92, 8, 92, 48),
      ("css-1wsok1f", 77, "", "input.re", 93, 8, 93, 51),
      ("css-1vur8kf", 78, "", "input.re", 94, 8, 94, 55),
      ("css-y5nsug", 79, "", "input.re", 95, 8, 95, 58),
      ("css-1i4whbk", 80, "", "input.re", 96, 8, 96, 52),
      ("css-uiwz2z", 81, "", "input.re", 97, 8, 97, 55),
      ("css-1iztkxs", 82, "", "input.re", 98, 8, 98, 42),
      ("css-c9c700", 83, "", "input.re", 99, 8, 99, 45),
      ("css-1soby4s", 84, "", "input.re", 101, 4, 101, 100),
      ("css-13n3ulx", 85, "", "input.re", 103, 8, 103, 33),
      ("css-1otufdk", 86, "", "input.re", 104, 8, 104, 37),
      ("css-14dthvx", 87, "", "input.re", 105, 8, 105, 41),
      ("css-4wc5h6", 88, "", "input.re", 106, 8, 106, 38),
      ("css-1bt2axa", 89, "", "input.re", 107, 8, 107, 42),
      ("css-czs978", 90, "", "input.re", 108, 8, 108, 39),
      ("css-1kevxnj", 91, "", "input.re", 109, 8, 109, 34),
      ("css-1iuxexx", 92, "", "input.re", 110, 8, 110, 36),
      ("css-1w2v3t2", 93, "", "input.re", 111, 8, 111, 41),
      ("css-12vs7zl", 94, "", "input.re", 112, 8, 112, 43),
      ("css-1u9xge9", 95, "", "input.re", 113, 8, 113, 47),
      ("css-1p4f6x1", 96, "", "input.re", 114, 8, 114, 42),
      ("css-1dtt0y9", 97, "", "input.re", 115, 8, 115, 48),
      ("css-1l9iruu", 98, "", "input.re", 116, 8, 116, 47),
      ("css-10cjabe", 99, "", "input.re", 117, 8, 117, 37),
      ("css-t0quk6", 100, "", "input.re", 118, 8, 118, 42),
      ("css-1fxwtsk", 101, "", "input.re", 120, 4, 120, 74),
      ("css-826zga", 102, "", "input.re", 123, 4, 123, 91),
      ("css-1kpt3jh", 103, "", "input.re", 126, 4, 126, 91),
      ("css-1eb1kxs", 104, "", "input.re", 128, 8, 128, 39),
      ("css-1l95el", 105, "", "input.re", 129, 8, 129, 38),
      ("css-81ixbv", 106, "", "input.re", 130, 8, 130, 38),
      ("css-m8pmrc", 107, "", "input.re", 131, 8, 131, 38),
      ("css-6ir786", 108, "", "input.re", 132, 8, 132, 38),
      ("css-1trzlr8", 109, "", "input.re", 133, 8, 133, 43),
      ("css-uakv1g", 110, "", "input.re", 134, 8, 134, 44),
      ("css-hgkrju", 111, "", "input.re", 135, 8, 135, 43),
      ("css-1i5wy8l", 112, "", "input.re", 136, 8, 136, 51),
      ("css-1imm8rm", 113, "", "input.re", 137, 8, 137, 37),
      ("css-o9qnpf", 114, "", "input.re", 138, 8, 138, 59),
      ("css-qxd3vf", 115, "", "input.re", 140, 8, 140, 37),
      ("css-1as2xyt", 116, "", "input.re", 141, 8, 141, 40),
      ("css-1mjka1p", 117, "", "input.re", 142, 8, 142, 41),
      ("css-1pmwujj", 118, "", "input.re", 143, 8, 143, 47),
    ]
  ];
  
  let fonts: array(CSS.Types.FontFamilyName.t) = [|
    `quoted("Inter"),
    `quoted("Sans"),
  |];
  let fontStack: array(CSS.Types.FontFamilyName.t) = [|`quoted("Inter")|];
  let font: CSS.Types.FontFamily.t = `quoted("Inter");
  
  CSS.make("css-1fyntm7", []);
  CSS.make(
    "css-16mqtb3",
    [("--16mqtb3-0", CSS.Types.FontFamilies.toString(fonts))],
  );
  CSS.make("css-1cmelzg", []);
  CSS.make(
    "css-10aiqz5",
    [("--10aiqz5-0", CSS.Types.FontFamilies.toString(fontStack))],
  );
  CSS.make("css-1o465pj", []);
  CSS.make(
    "css-rt0yzf",
    [("--rt0yzf-0", CSS.Types.FontFamily.toString(font))],
  );
  CSS.make("css-kcya2y", []);
  
  CSS.make("css-4tpnst", []);
  CSS.make("css-13hg49l", []);
  CSS.make("css-1abkc7i", []);
  CSS.make("css-eul2a7", []);
  CSS.make("css-ulgk63", []);
  CSS.make("css-17qwbuq", []);
  CSS.make("css-1f228g7", []);
  CSS.make("css-1e2civ", []);
  CSS.make("css-wzt6y6", []);
  CSS.make("css-vmh0rf", []);
  CSS.make("css-gyjx6j", []);
  CSS.make("css-4rgv1r", []);
  CSS.make("css-toylcb", []);
  CSS.make("css-1wnyrbp", []);
  CSS.make("css-a9g9", []);
  CSS.make("css-1dtseo6", []);
  CSS.make("css-3dri83", []);
  CSS.make("css-1p26oew", []);
  CSS.make("css-1ybbj0", []);
  CSS.make("css-ye82z7", []);
  CSS.make("css-1xjackv", []);
  CSS.make("css-1n5769x", []);
  CSS.make("css-13saerl", []);
  CSS.make("css-8zrobg", []);
  CSS.make("css-1pkky84", []);
  CSS.make("css-1go7h28", []);
  CSS.make("css-1tg0r2s", []);
  CSS.make("css-rbjbzi", []);
  CSS.make("css-1svy3m1", []);
  CSS.make("css-v34kh8", []);
  CSS.make("css-1l3911e", []);
  CSS.make("css-w1cddc", []);
  CSS.make("css-95x30", []);
  CSS.make("css-n2ezd2", []);
  CSS.make("css-51z60q", []);
  CSS.make("css-1ixvyyq", []);
  CSS.make("css-qplls6", []);
  CSS.make("css-12elq0x", []);
  CSS.make("css-18147h", []);
  CSS.make("css-1044h57", []);
  CSS.make("css-1lm3kx", []);
  CSS.make("css-1m946u0", []);
  
  CSS.make("css-1y64hz6", []);
  CSS.make("css-1ejvwru", []);
  CSS.make("css-16nwzoy", []);
  CSS.make("css-1dy44et", []);
  CSS.make("css-jpeay4", []);
  CSS.make("css-120cmk9", []);
  CSS.make("css-tpgad6", []);
  CSS.make("css-1gqgwh9", []);
  CSS.make("css-n4h9ke", []);
  CSS.make("css-lghvvl", []);
  CSS.make("css-1frj61", []);
  CSS.make("css-1c7iwkn", []);
  CSS.make("css-4atw3v", []);
  CSS.make("css-15pu40q", []);
  CSS.make("css-15c1bon", []);
  CSS.make("css-6zc9d8", []);
  CSS.make("css-1ngfgrz", []);
  CSS.make("css-1117rlm", []);
  CSS.make("css-1lsew1u", []);
  CSS.make("css-1o8cfa2", []);
  CSS.make("css-wsh9dr", []);
  CSS.make("css-1kpumbp", []);
  CSS.make("css-voxwgq", []);
  CSS.make("css-1iefl2l", []);
  CSS.make("css-tszbee", []);
  CSS.make("css-1wsok1f", []);
  CSS.make("css-1vur8kf", []);
  CSS.make("css-y5nsug", []);
  CSS.make("css-1i4whbk", []);
  CSS.make("css-uiwz2z", []);
  CSS.make("css-1iztkxs", []);
  CSS.make("css-c9c700", []);
  CSS.make("css-1soby4s", []);
  CSS.make("css-13n3ulx", []);
  CSS.make("css-1otufdk", []);
  CSS.make("css-14dthvx", []);
  CSS.make("css-4wc5h6", []);
  CSS.make("css-1bt2axa", []);
  CSS.make("css-czs978", []);
  CSS.make("css-1kevxnj", []);
  CSS.make("css-1iuxexx", []);
  CSS.make("css-1w2v3t2", []);
  CSS.make("css-12vs7zl", []);
  CSS.make("css-1u9xge9", []);
  CSS.make("css-1p4f6x1", []);
  CSS.make("css-1dtt0y9", []);
  CSS.make("css-1l9iruu", []);
  CSS.make("css-10cjabe", []);
  CSS.make("css-t0quk6", []);
  CSS.make("css-1fxwtsk", []);
  CSS.make("css-826zga", []);
  CSS.make("css-1kpt3jh", []);
  CSS.make("css-1eb1kxs", []);
  CSS.make("css-1l95el", []);
  CSS.make("css-81ixbv", []);
  CSS.make("css-m8pmrc", []);
  CSS.make("css-6ir786", []);
  CSS.make("css-1trzlr8", []);
  CSS.make("css-uakv1g", []);
  CSS.make("css-hgkrju", []);
  CSS.make("css-1i5wy8l", []);
  CSS.make("css-1imm8rm", []);
  CSS.make("css-o9qnpf", []);
  CSS.make("css-13saerl", []);
  CSS.make("css-qxd3vf", []);
  CSS.make("css-1as2xyt", []);
  CSS.make("css-1mjka1p", []);
  CSS.make("css-1pmwujj", []);
