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
  [@css "@property --ivpc2rq{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc5x1{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcz5s{syntax:\"*\";inherits:false;}"];
  [@css ".css-ivpctm7{font-family:\"Inter Semi Bold\";}"];
  [@css ".css-ivpcp4m{font-family:var(--ivpc2rq);}"];
  [@css ".css-ivpclzg{font-family:Inter;}"];
  [@css ".css-ivpckez{font-family:var(--ivpc5x1);}"];
  [@css ".css-ivpc5pj{font-family:Inter, Sans;}"];
  [@css ".css-ivpc3x9{font-family:Inter, var(--ivpcz5s);}"];
  [@css ".css-ivpca2y{font-family:\"Gill Sans Extrabold\", sans-serif;}"];
  [@css ".css-ivpcnst{font-synthesis-weight:none;}"];
  [@css ".css-ivpc49l{font-synthesis-style:auto;}"];
  [@css ".css-ivpcc7i{font-synthesis-small-caps:none;}"];
  [@css ".css-ivpc2a7{font-synthesis-position:auto;}"];
  [@css ".css-ivpck63{font-size:xxx-large;}"];
  [@css ".css-ivpcbuq{font-variant:none;}"];
  [@css ".css-ivpc8g7{font-variant:normal;}"];
  [@css ".css-ivpcciv{font-variant:all-petite-caps;}"];
  [@css ".css-ivpc6y6{font-variant:historical-forms;}"];
  [@css ".css-ivpc0rf{font-variant:super;}"];
  [@css ".css-ivpcx6j{font-variant:sub lining-nums contextual ruby;}"];
  [@css ".css-ivpcv1r{font-variant:annotation(circled);}"];
  [@css
    ".css-ivpclcb{font-variant:discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U);}"
  ];
  [@css ".css-ivpcrbp{font-variant-alternates:normal;}"];
  [@css ".css-ivpc9g9{font-variant-alternates:historical-forms;}"];
  [@css ".css-ivpceo6{font-variant-alternates:styleset(ss01);}"];
  [@css
    ".css-ivpci83{font-variant-alternates:styleset(stacked-g, geometric-m);}"
  ];
  [@css ".css-ivpcoew{font-variant-alternates:character-variant(cv02);}"];
  [@css
    ".css-ivpcbj0{font-variant-alternates:character-variant(beta-3, gamma);}"
  ];
  [@css ".css-ivpc2z7{font-variant-alternates:swash(flowing);}"];
  [@css ".css-ivpcckv{font-variant-alternates:ornaments(leaves);}"];
  [@css ".css-ivpc69x{font-variant-alternates:annotation(blocky);}"];
  [@css ".css-ivpcerl{font-feature-settings:normal;}"];
  [@css ".css-ivpcobg{font-feature-settings:\"swsh\" 2;}"];
  [@css ".css-ivpcy84{font-language-override:normal;}"];
  [@css ".css-ivpch28{font-language-override:\"SRB\";}"];
  [@css ".css-ivpcr2s{font-weight:1;}"];
  [@css ".css-ivpcbzi{font-weight:90;}"];
  [@css ".css-ivpc3m1{font-weight:750;}"];
  [@css ".css-ivpckh8{font-weight:1000;}"];
  [@css ".css-ivpc11e{font-style:oblique 15deg;}"];
  [@css ".css-ivpcddc{font-style:oblique -15deg;}"];
  [@css ".css-ivpcx30{font-style:oblique 0deg;}"];
  [@css ".css-ivpczd2{font-optical-sizing:none;}"];
  [@css ".css-ivpc60q{font-optical-sizing:auto;}"];
  [@css ".css-ivpcyyq{font-palette:normal;}"];
  [@css ".css-ivpcls6{font-palette:light;}"];
  [@css ".css-ivpcq0x{font-palette:dark;}"];
  [@css ".css-ivpc47h{font-variant-emoji:normal;}"];
  [@css ".css-ivpch57{font-variant-emoji:text;}"];
  [@css ".css-ivpc3kx{font-variant-emoji:emoji;}"];
  [@css ".css-ivpc6u0{font-variant-emoji:unicode;}"];
  [@css ".css-ivpchz6{font-stretch:normal;}"];
  [@css ".css-ivpcwru{font-stretch:ultra-condensed;}"];
  [@css ".css-ivpczoy{font-stretch:extra-condensed;}"];
  [@css ".css-ivpc4et{font-stretch:condensed;}"];
  [@css ".css-ivpcay4{font-stretch:semi-condensed;}"];
  [@css ".css-ivpcmk9{font-stretch:semi-expanded;}"];
  [@css ".css-ivpcad6{font-stretch:expanded;}"];
  [@css ".css-ivpcwh9{font-stretch:extra-expanded;}"];
  [@css ".css-ivpc9ke{font-stretch:ultra-expanded;}"];
  [@css ".css-ivpcvvl{font-size-adjust:none;}"];
  [@css ".css-ivpcj61{font-size-adjust:0.5;}"];
  [@css ".css-ivpcwkn{font-synthesis:none;}"];
  [@css ".css-ivpcw3v{font-synthesis:weight;}"];
  [@css ".css-ivpc40q{font-synthesis:style;}"];
  [@css ".css-ivpcbon{font-synthesis:weight style;}"];
  [@css ".css-ivpc9d8{font-synthesis:style weight;}"];
  [@css ".css-ivpcgrz{font-kerning:auto;}"];
  [@css ".css-ivpcrlm{font-kerning:normal;}"];
  [@css ".css-ivpcw1u{font-kerning:none;}"];
  [@css ".css-ivpcfa2{font-variant-position:normal;}"];
  [@css ".css-ivpc9dr{font-variant-position:sub;}"];
  [@css ".css-ivpcmbp{font-variant-position:super;}"];
  [@css ".css-ivpcwgq{font-variant-ligatures:normal;}"];
  [@css ".css-ivpcl2l{font-variant-ligatures:none;}"];
  [@css ".css-ivpcbee{font-variant-ligatures:common-ligatures;}"];
  [@css ".css-ivpck1f{font-variant-ligatures:no-common-ligatures;}"];
  [@css ".css-ivpc8kf{font-variant-ligatures:discretionary-ligatures;}"];
  [@css ".css-ivpcsug{font-variant-ligatures:no-discretionary-ligatures;}"];
  [@css ".css-ivpchbk{font-variant-ligatures:historical-ligatures;}"];
  [@css ".css-ivpcz2z{font-variant-ligatures:no-historical-ligatures;}"];
  [@css ".css-ivpckxs{font-variant-ligatures:contextual;}"];
  [@css ".css-ivpc700{font-variant-ligatures:no-contextual;}"];
  [@css
    ".css-ivpcy4s{font-variant-ligatures:common-ligatures discretionary-ligatures historical-ligatures contextual;}"
  ];
  [@css ".css-ivpculx{font-variant-caps:normal;}"];
  [@css ".css-ivpcfdk{font-variant-caps:small-caps;}"];
  [@css ".css-ivpchvx{font-variant-caps:all-small-caps;}"];
  [@css ".css-ivpc5h6{font-variant-caps:petite-caps;}"];
  [@css ".css-ivpcaxa{font-variant-caps:all-petite-caps;}"];
  [@css ".css-ivpc978{font-variant-caps:titling-caps;}"];
  [@css ".css-ivpcxnj{font-variant-caps:unicase;}"];
  [@css ".css-ivpcexx{font-variant-numeric:normal;}"];
  [@css ".css-ivpc3t2{font-variant-numeric:lining-nums;}"];
  [@css ".css-ivpc7zl{font-variant-numeric:oldstyle-nums;}"];
  [@css ".css-ivpcge9{font-variant-numeric:proportional-nums;}"];
  [@css ".css-ivpc6x1{font-variant-numeric:tabular-nums;}"];
  [@css ".css-ivpc0y9{font-variant-numeric:diagonal-fractions;}"];
  [@css ".css-ivpcruu{font-variant-numeric:stacked-fractions;}"];
  [@css ".css-ivpcabe{font-variant-numeric:ordinal;}"];
  [@css ".css-ivpcuk6{font-variant-numeric:slashed-zero;}"];
  [@css
    ".css-ivpctsk{font-variant-numeric:lining-nums proportional-nums diagonal-fractions;}"
  ];
  [@css
    ".css-ivpczga{font-variant-numeric:oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero;}"
  ];
  [@css
    ".css-ivpc3jh{font-variant-numeric:slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums;}"
  ];
  [@css ".css-ivpc1kxs{font-variant-east-asian:normal;}"];
  [@css ".css-ivpc5el{font-variant-east-asian:jis78;}"];
  [@css ".css-ivpcxbv{font-variant-east-asian:jis83;}"];
  [@css ".css-ivpcmrc{font-variant-east-asian:jis90;}"];
  [@css ".css-ivpc786{font-variant-east-asian:jis04;}"];
  [@css ".css-ivpclr8{font-variant-east-asian:simplified;}"];
  [@css ".css-ivpcv1g{font-variant-east-asian:traditional;}"];
  [@css ".css-ivpcrju{font-variant-east-asian:full-width;}"];
  [@css ".css-ivpcy8l{font-variant-east-asian:proportional-width;}"];
  [@css ".css-ivpc8rm{font-variant-east-asian:ruby;}"];
  [@css ".css-ivpcnpf{font-variant-east-asian:simplified full-width ruby;}"];
  [@css ".css-ivpc3vf{font-feature-settings:\"c2sc\";}"];
  [@css ".css-ivpcxyt{font-feature-settings:\"smcp\" on;}"];
  [@css ".css-ivpca1p{font-feature-settings:\"liga\" off;}"];
  [@css ".css-ivpcujj{font-feature-settings:\"smcp\", \"swsh\" 2;}"];
  [@css.classes
    [
      ("css-ivpctm7", 3, "", "input.re", 13, 8, 13, 39),
      ("css-ivpcp4m", 4, "", "input.re", 14, 8, 14, 30),
      ("css-ivpclzg", 5, "", "input.re", 15, 8, 15, 27),
      ("css-ivpckez", 6, "", "input.re", 16, 8, 16, 34),
      ("css-ivpc5pj", 7, "", "input.re", 17, 8, 17, 33),
      ("css-ivpc3x9", 8, "", "input.re", 18, 8, 18, 36),
      ("css-ivpca2y", 9, "", "input.re", 19, 8, 19, 55),
      ("css-ivpcnst", 10, "", "input.re", 22, 8, 22, 35),
      ("css-ivpc49l", 11, "", "input.re", 23, 8, 23, 34),
      ("css-ivpcc7i", 12, "", "input.re", 24, 8, 24, 39),
      ("css-ivpc2a7", 13, "", "input.re", 25, 8, 25, 37),
      ("css-ivpck63", 14, "", "input.re", 26, 8, 26, 28),
      ("css-ivpcbuq", 15, "", "input.re", 27, 8, 27, 26),
      ("css-ivpc8g7", 16, "", "input.re", 28, 8, 28, 28),
      ("css-ivpcciv", 17, "", "input.re", 29, 8, 29, 37),
      ("css-ivpc6y6", 18, "", "input.re", 30, 8, 30, 38),
      ("css-ivpc0rf", 19, "", "input.re", 31, 8, 31, 27),
      ("css-ivpcx6j", 20, "", "input.re", 32, 8, 32, 53),
      ("css-ivpcv1r", 21, "", "input.re", 33, 8, 33, 41),
      ("css-ivpclcb", 22, "", "input.re", 35, 4, 35, 94),
      ("css-ivpcrbp", 23, "", "input.re", 37, 8, 37, 39),
      ("css-ivpc9g9", 24, "", "input.re", 38, 8, 38, 49),
      ("css-ivpceo6", 25, "", "input.re", 39, 8, 39, 47),
      ("css-ivpci83", 26, "", "input.re", 40, 8, 40, 65),
      ("css-ivpcoew", 27, "", "input.re", 41, 8, 41, 56),
      ("css-ivpcbj0", 28, "", "input.re", 42, 8, 42, 65),
      ("css-ivpc2z7", 29, "", "input.re", 43, 8, 43, 47),
      ("css-ivpcckv", 30, "", "input.re", 44, 8, 44, 50),
      ("css-ivpc69x", 31, "", "input.re", 45, 8, 45, 51),
      ("css-ivpcerl", 32, "", "input.re", 46, 8, 46, 37),
      ("css-ivpcobg", 33, "", "input.re", 47, 8, 47, 39),
      ("css-ivpcy84", 34, "", "input.re", 48, 8, 48, 38),
      ("css-ivpch28", 35, "", "input.re", 49, 8, 49, 37),
      ("css-ivpcr2s", 36, "", "input.re", 50, 8, 50, 22),
      ("css-ivpcbzi", 37, "", "input.re", 51, 8, 51, 23),
      ("css-ivpc3m1", 38, "", "input.re", 52, 8, 52, 24),
      ("css-ivpckh8", 39, "", "input.re", 53, 8, 53, 25),
      ("css-ivpc11e", 40, "", "input.re", 54, 8, 54, 33),
      ("css-ivpcddc", 41, "", "input.re", 55, 8, 55, 34),
      ("css-ivpcx30", 42, "", "input.re", 56, 8, 56, 32),
      ("css-ivpczd2", 43, "", "input.re", 57, 8, 57, 33),
      ("css-ivpc60q", 44, "", "input.re", 58, 8, 58, 33),
      ("css-ivpcyyq", 45, "", "input.re", 59, 8, 59, 28),
      ("css-ivpcls6", 46, "", "input.re", 60, 8, 60, 27),
      ("css-ivpcq0x", 47, "", "input.re", 61, 8, 61, 26),
      ("css-ivpc47h", 48, "", "input.re", 62, 8, 62, 34),
      ("css-ivpch57", 49, "", "input.re", 63, 8, 63, 32),
      ("css-ivpc3kx", 50, "", "input.re", 64, 8, 64, 33),
      ("css-ivpc6u0", 51, "", "input.re", 65, 8, 65, 35),
      ("css-ivpchz6", 52, "", "input.re", 68, 8, 68, 28),
      ("css-ivpcwru", 53, "", "input.re", 69, 8, 69, 37),
      ("css-ivpczoy", 54, "", "input.re", 70, 8, 70, 37),
      ("css-ivpc4et", 55, "", "input.re", 71, 8, 71, 31),
      ("css-ivpcay4", 56, "", "input.re", 72, 8, 72, 36),
      ("css-ivpcmk9", 57, "", "input.re", 73, 8, 73, 35),
      ("css-ivpcad6", 58, "", "input.re", 74, 8, 74, 30),
      ("css-ivpcwh9", 59, "", "input.re", 75, 8, 75, 36),
      ("css-ivpc9ke", 60, "", "input.re", 76, 8, 76, 36),
      ("css-ivpcvvl", 61, "", "input.re", 77, 8, 77, 30),
      ("css-ivpcj61", 62, "", "input.re", 78, 8, 78, 28),
      ("css-ivpcwkn", 63, "", "input.re", 79, 8, 79, 28),
      ("css-ivpcw3v", 64, "", "input.re", 80, 8, 80, 30),
      ("css-ivpc40q", 65, "", "input.re", 81, 8, 81, 29),
      ("css-ivpcbon", 66, "", "input.re", 82, 8, 82, 36),
      ("css-ivpc9d8", 67, "", "input.re", 83, 8, 83, 36),
      ("css-ivpcgrz", 68, "", "input.re", 84, 8, 84, 26),
      ("css-ivpcrlm", 69, "", "input.re", 85, 8, 85, 28),
      ("css-ivpcw1u", 70, "", "input.re", 86, 8, 86, 26),
      ("css-ivpcfa2", 71, "", "input.re", 87, 8, 87, 37),
      ("css-ivpc9dr", 72, "", "input.re", 88, 8, 88, 34),
      ("css-ivpcmbp", 73, "", "input.re", 89, 8, 89, 36),
      ("css-ivpcwgq", 74, "", "input.re", 90, 8, 90, 38),
      ("css-ivpcl2l", 75, "", "input.re", 91, 8, 91, 36),
      ("css-ivpcbee", 76, "", "input.re", 92, 8, 92, 48),
      ("css-ivpck1f", 77, "", "input.re", 93, 8, 93, 51),
      ("css-ivpc8kf", 78, "", "input.re", 94, 8, 94, 55),
      ("css-ivpcsug", 79, "", "input.re", 95, 8, 95, 58),
      ("css-ivpchbk", 80, "", "input.re", 96, 8, 96, 52),
      ("css-ivpcz2z", 81, "", "input.re", 97, 8, 97, 55),
      ("css-ivpckxs", 82, "", "input.re", 98, 8, 98, 42),
      ("css-ivpc700", 83, "", "input.re", 99, 8, 99, 45),
      ("css-ivpcy4s", 84, "", "input.re", 101, 4, 101, 100),
      ("css-ivpculx", 85, "", "input.re", 103, 8, 103, 33),
      ("css-ivpcfdk", 86, "", "input.re", 104, 8, 104, 37),
      ("css-ivpchvx", 87, "", "input.re", 105, 8, 105, 41),
      ("css-ivpc5h6", 88, "", "input.re", 106, 8, 106, 38),
      ("css-ivpcaxa", 89, "", "input.re", 107, 8, 107, 42),
      ("css-ivpc978", 90, "", "input.re", 108, 8, 108, 39),
      ("css-ivpcxnj", 91, "", "input.re", 109, 8, 109, 34),
      ("css-ivpcexx", 92, "", "input.re", 110, 8, 110, 36),
      ("css-ivpc3t2", 93, "", "input.re", 111, 8, 111, 41),
      ("css-ivpc7zl", 94, "", "input.re", 112, 8, 112, 43),
      ("css-ivpcge9", 95, "", "input.re", 113, 8, 113, 47),
      ("css-ivpc6x1", 96, "", "input.re", 114, 8, 114, 42),
      ("css-ivpc0y9", 97, "", "input.re", 115, 8, 115, 48),
      ("css-ivpcruu", 98, "", "input.re", 116, 8, 116, 47),
      ("css-ivpcabe", 99, "", "input.re", 117, 8, 117, 37),
      ("css-ivpcuk6", 100, "", "input.re", 118, 8, 118, 42),
      ("css-ivpctsk", 101, "", "input.re", 120, 4, 120, 74),
      ("css-ivpczga", 102, "", "input.re", 123, 4, 123, 91),
      ("css-ivpc3jh", 103, "", "input.re", 126, 4, 126, 91),
      ("css-ivpc1kxs", 104, "", "input.re", 128, 8, 128, 39),
      ("css-ivpc5el", 105, "", "input.re", 129, 8, 129, 38),
      ("css-ivpcxbv", 106, "", "input.re", 130, 8, 130, 38),
      ("css-ivpcmrc", 107, "", "input.re", 131, 8, 131, 38),
      ("css-ivpc786", 108, "", "input.re", 132, 8, 132, 38),
      ("css-ivpclr8", 109, "", "input.re", 133, 8, 133, 43),
      ("css-ivpcv1g", 110, "", "input.re", 134, 8, 134, 44),
      ("css-ivpcrju", 111, "", "input.re", 135, 8, 135, 43),
      ("css-ivpcy8l", 112, "", "input.re", 136, 8, 136, 51),
      ("css-ivpc8rm", 113, "", "input.re", 137, 8, 137, 37),
      ("css-ivpcnpf", 114, "", "input.re", 138, 8, 138, 59),
      ("css-ivpc3vf", 115, "", "input.re", 140, 8, 140, 37),
      ("css-ivpcxyt", 116, "", "input.re", 141, 8, 141, 40),
      ("css-ivpca1p", 117, "", "input.re", 142, 8, 142, 41),
      ("css-ivpcujj", 118, "", "input.re", 143, 8, 143, 47),
    ]
  ];
  
  let fonts: array(CSS.Types.FontFamilyName.t) = [|
    `quoted("Inter"),
    `quoted("Sans"),
  |];
  let fontStack: array(CSS.Types.FontFamilyName.t) = [|`quoted("Inter")|];
  let font: CSS.Types.FontFamily.t = `quoted("Inter");
  
  CSS.make("css-ivpctm7", []);
  CSS.make(
    "css-ivpcp4m",
    [("--ivpc2rq", CSS.Types.FontFamilies.toString(fonts))],
  );
  CSS.make("css-ivpclzg", []);
  CSS.make(
    "css-ivpckez",
    [("--ivpc5x1", CSS.Types.FontFamilies.toString(fontStack))],
  );
  CSS.make("css-ivpc5pj", []);
  CSS.make(
    "css-ivpc3x9",
    [("--ivpcz5s", CSS.Types.FontFamily.toString(font))],
  );
  CSS.make("css-ivpca2y", []);
  
  CSS.make("css-ivpcnst", []);
  CSS.make("css-ivpc49l", []);
  CSS.make("css-ivpcc7i", []);
  CSS.make("css-ivpc2a7", []);
  CSS.make("css-ivpck63", []);
  CSS.make("css-ivpcbuq", []);
  CSS.make("css-ivpc8g7", []);
  CSS.make("css-ivpcciv", []);
  CSS.make("css-ivpc6y6", []);
  CSS.make("css-ivpc0rf", []);
  CSS.make("css-ivpcx6j", []);
  CSS.make("css-ivpcv1r", []);
  CSS.make("css-ivpclcb", []);
  CSS.make("css-ivpcrbp", []);
  CSS.make("css-ivpc9g9", []);
  CSS.make("css-ivpceo6", []);
  CSS.make("css-ivpci83", []);
  CSS.make("css-ivpcoew", []);
  CSS.make("css-ivpcbj0", []);
  CSS.make("css-ivpc2z7", []);
  CSS.make("css-ivpcckv", []);
  CSS.make("css-ivpc69x", []);
  CSS.make("css-ivpcerl", []);
  CSS.make("css-ivpcobg", []);
  CSS.make("css-ivpcy84", []);
  CSS.make("css-ivpch28", []);
  CSS.make("css-ivpcr2s", []);
  CSS.make("css-ivpcbzi", []);
  CSS.make("css-ivpc3m1", []);
  CSS.make("css-ivpckh8", []);
  CSS.make("css-ivpc11e", []);
  CSS.make("css-ivpcddc", []);
  CSS.make("css-ivpcx30", []);
  CSS.make("css-ivpczd2", []);
  CSS.make("css-ivpc60q", []);
  CSS.make("css-ivpcyyq", []);
  CSS.make("css-ivpcls6", []);
  CSS.make("css-ivpcq0x", []);
  CSS.make("css-ivpc47h", []);
  CSS.make("css-ivpch57", []);
  CSS.make("css-ivpc3kx", []);
  CSS.make("css-ivpc6u0", []);
  
  CSS.make("css-ivpchz6", []);
  CSS.make("css-ivpcwru", []);
  CSS.make("css-ivpczoy", []);
  CSS.make("css-ivpc4et", []);
  CSS.make("css-ivpcay4", []);
  CSS.make("css-ivpcmk9", []);
  CSS.make("css-ivpcad6", []);
  CSS.make("css-ivpcwh9", []);
  CSS.make("css-ivpc9ke", []);
  CSS.make("css-ivpcvvl", []);
  CSS.make("css-ivpcj61", []);
  CSS.make("css-ivpcwkn", []);
  CSS.make("css-ivpcw3v", []);
  CSS.make("css-ivpc40q", []);
  CSS.make("css-ivpcbon", []);
  CSS.make("css-ivpc9d8", []);
  CSS.make("css-ivpcgrz", []);
  CSS.make("css-ivpcrlm", []);
  CSS.make("css-ivpcw1u", []);
  CSS.make("css-ivpcfa2", []);
  CSS.make("css-ivpc9dr", []);
  CSS.make("css-ivpcmbp", []);
  CSS.make("css-ivpcwgq", []);
  CSS.make("css-ivpcl2l", []);
  CSS.make("css-ivpcbee", []);
  CSS.make("css-ivpck1f", []);
  CSS.make("css-ivpc8kf", []);
  CSS.make("css-ivpcsug", []);
  CSS.make("css-ivpchbk", []);
  CSS.make("css-ivpcz2z", []);
  CSS.make("css-ivpckxs", []);
  CSS.make("css-ivpc700", []);
  CSS.make("css-ivpcy4s", []);
  CSS.make("css-ivpculx", []);
  CSS.make("css-ivpcfdk", []);
  CSS.make("css-ivpchvx", []);
  CSS.make("css-ivpc5h6", []);
  CSS.make("css-ivpcaxa", []);
  CSS.make("css-ivpc978", []);
  CSS.make("css-ivpcxnj", []);
  CSS.make("css-ivpcexx", []);
  CSS.make("css-ivpc3t2", []);
  CSS.make("css-ivpc7zl", []);
  CSS.make("css-ivpcge9", []);
  CSS.make("css-ivpc6x1", []);
  CSS.make("css-ivpc0y9", []);
  CSS.make("css-ivpcruu", []);
  CSS.make("css-ivpcabe", []);
  CSS.make("css-ivpcuk6", []);
  CSS.make("css-ivpctsk", []);
  CSS.make("css-ivpczga", []);
  CSS.make("css-ivpc3jh", []);
  CSS.make("css-ivpc1kxs", []);
  CSS.make("css-ivpc5el", []);
  CSS.make("css-ivpcxbv", []);
  CSS.make("css-ivpcmrc", []);
  CSS.make("css-ivpc786", []);
  CSS.make("css-ivpclr8", []);
  CSS.make("css-ivpcv1g", []);
  CSS.make("css-ivpcrju", []);
  CSS.make("css-ivpcy8l", []);
  CSS.make("css-ivpc8rm", []);
  CSS.make("css-ivpcnpf", []);
  CSS.make("css-ivpcerl", []);
  CSS.make("css-ivpc3vf", []);
  CSS.make("css-ivpcxyt", []);
  CSS.make("css-ivpca1p", []);
  CSS.make("css-ivpcujj", []);
