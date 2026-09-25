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
  [@css ".a-1l2838t{font-family:\"Inter Semi Bold\";}"];
  [@css ".in-1wpww9k{font-family:var(--fonts-qhzb1y);}"];
  [@css ".a-13c8hy8{font-family:Inter;}"];
  [@css ".in-1sbj23c{font-family:var(--fontStack-q2u8nj);}"];
  [@css ".a-38zhkv{font-family:Inter, Sans;}"];
  [@css ".in-e4l4c9{font-family:Inter, var(--font-165jgna);}"];
  [@css ".a-zpvvt7{font-family:\"Gill Sans Extrabold\", sans-serif;}"];
  [@css ".a-1nch51u{font-synthesis-weight:none;}"];
  [@css ".a-4qo3g2{font-synthesis-style:auto;}"];
  [@css ".a-g2uzmx{font-synthesis-small-caps:none;}"];
  [@css ".a-1c2qsbz{font-synthesis-position:auto;}"];
  [@css ".a-1nhq8d0{font-size:xxx-large;}"];
  [@css ".a-o8tzp2{font-variant:none;}"];
  [@css ".a-rrlpwk{font-variant:normal;}"];
  [@css ".a-1ekhi6x{font-variant:all-petite-caps;}"];
  [@css ".a-crn7po{font-variant:historical-forms;}"];
  [@css ".a-48srpk{font-variant:super;}"];
  [@css ".a-e1gmww{font-variant:sub lining-nums contextual ruby;}"];
  [@css ".a-1uqlj9l{font-variant:annotation(circled);}"];
  [@css
    ".a-1jjc25g{font-variant:discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U);}"
  ];
  [@css ".a-ax7x05{font-variant-alternates:normal;}"];
  [@css ".a-1n0pxzw{font-variant-alternates:historical-forms;}"];
  [@css ".a-xphjze{font-variant-alternates:styleset(ss01);}"];
  [@css ".a-eqkqdt{font-variant-alternates:styleset(stacked-g, geometric-m);}"];
  [@css ".a-1a990vj{font-variant-alternates:character-variant(cv02);}"];
  [@css ".a-15w2zxs{font-variant-alternates:character-variant(beta-3, gamma);}"];
  [@css ".a-1aecfjl{font-variant-alternates:swash(flowing);}"];
  [@css ".a-1wxb0td{font-variant-alternates:ornaments(leaves);}"];
  [@css ".a-31tt93{font-variant-alternates:annotation(blocky);}"];
  [@css ".a-13mml8d{font-feature-settings:normal;}"];
  [@css ".a-i5jzzi{font-feature-settings:\"swsh\" 2;}"];
  [@css ".a-qlvtlx{font-language-override:normal;}"];
  [@css ".a-p3bfe6{font-language-override:\"SRB\";}"];
  [@css ".a-3eihfq{font-weight:1;}"];
  [@css ".a-20g2wc{font-weight:90;}"];
  [@css ".a-1pmzzf7{font-weight:750;}"];
  [@css ".a-1gl946z{font-weight:1000;}"];
  [@css ".a-o4finr{font-style:oblique 15deg;}"];
  [@css ".a-i7h9ap{font-style:oblique -15deg;}"];
  [@css ".a-gg4bxt{font-style:oblique 0deg;}"];
  [@css ".a-1erno1j{font-optical-sizing:none;}"];
  [@css ".a-pfz9v1{font-optical-sizing:auto;}"];
  [@css ".a-nz29j8{font-palette:normal;}"];
  [@css ".a-1rrmxeq{font-palette:light;}"];
  [@css ".a-14pfxax{font-palette:dark;}"];
  [@css ".a-d22ijg{font-variant-emoji:normal;}"];
  [@css ".a-n5dp3m{font-variant-emoji:text;}"];
  [@css ".a-p5oi24{font-variant-emoji:emoji;}"];
  [@css ".a-16smq5j{font-variant-emoji:unicode;}"];
  [@css ".a-d4h4h6{font-stretch:normal;}"];
  [@css ".a-1998aej{font-stretch:ultra-condensed;}"];
  [@css ".a-1bfh6uj{font-stretch:extra-condensed;}"];
  [@css ".a-lp726d{font-stretch:condensed;}"];
  [@css ".a-107ypsq{font-stretch:semi-condensed;}"];
  [@css ".a-niryki{font-stretch:semi-expanded;}"];
  [@css ".a-nb1ay3{font-stretch:expanded;}"];
  [@css ".a-17uatbv{font-stretch:extra-expanded;}"];
  [@css ".a-v1nsma{font-stretch:ultra-expanded;}"];
  [@css ".a-yuuc3c{font-size-adjust:none;}"];
  [@css ".a-1cymswb{font-size-adjust:0.5;}"];
  [@css ".a-ych0bs{font-synthesis:none;}"];
  [@css ".a-chxz73{font-synthesis:weight;}"];
  [@css ".a-19umipp{font-synthesis:style;}"];
  [@css ".a-wrnabk{font-synthesis:weight style;}"];
  [@css ".a-1n2e0hd{font-synthesis:style weight;}"];
  [@css ".a-3llltu{font-kerning:auto;}"];
  [@css ".a-hlygkk{font-kerning:normal;}"];
  [@css ".a-rgd4ye{font-kerning:none;}"];
  [@css ".a-d6yro{font-variant-position:normal;}"];
  [@css ".a-13ip6w0{font-variant-position:sub;}"];
  [@css ".a-f4sgdl{font-variant-position:super;}"];
  [@css ".a-1elncv3{font-variant-ligatures:normal;}"];
  [@css ".a-rimnc1{font-variant-ligatures:none;}"];
  [@css ".a-1oyl9n8{font-variant-ligatures:common-ligatures;}"];
  [@css ".a-d5tjmp{font-variant-ligatures:no-common-ligatures;}"];
  [@css ".a-1i4rq81{font-variant-ligatures:discretionary-ligatures;}"];
  [@css ".a-1i5v26z{font-variant-ligatures:no-discretionary-ligatures;}"];
  [@css ".a-1wiem3q{font-variant-ligatures:historical-ligatures;}"];
  [@css ".a-1va61tv{font-variant-ligatures:no-historical-ligatures;}"];
  [@css ".a-1vtp3ik{font-variant-ligatures:contextual;}"];
  [@css ".a-ueadwq{font-variant-ligatures:no-contextual;}"];
  [@css
    ".a-chpu2q{font-variant-ligatures:common-ligatures discretionary-ligatures historical-ligatures contextual;}"
  ];
  [@css ".a-s6dg8c{font-variant-caps:normal;}"];
  [@css ".a-1sfczn6{font-variant-caps:small-caps;}"];
  [@css ".a-wf67x8{font-variant-caps:all-small-caps;}"];
  [@css ".a-t6y53c{font-variant-caps:petite-caps;}"];
  [@css ".a-j3igep{font-variant-caps:all-petite-caps;}"];
  [@css ".a-1st5fsu{font-variant-caps:titling-caps;}"];
  [@css ".a-d70uxy{font-variant-caps:unicase;}"];
  [@css ".a-16quao3{font-variant-numeric:normal;}"];
  [@css ".a-qspeun{font-variant-numeric:lining-nums;}"];
  [@css ".a-1iy7maz{font-variant-numeric:oldstyle-nums;}"];
  [@css ".a-12asgo0{font-variant-numeric:proportional-nums;}"];
  [@css ".a-1ovumeb{font-variant-numeric:tabular-nums;}"];
  [@css ".a-14ay4ib{font-variant-numeric:diagonal-fractions;}"];
  [@css ".a-1a909vx{font-variant-numeric:stacked-fractions;}"];
  [@css ".a-9j80vn{font-variant-numeric:ordinal;}"];
  [@css ".a-rwu4g7{font-variant-numeric:slashed-zero;}"];
  [@css
    ".a-1e1eltn{font-variant-numeric:lining-nums proportional-nums diagonal-fractions;}"
  ];
  [@css
    ".a-1w7gh45{font-variant-numeric:oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero;}"
  ];
  [@css
    ".a-26ogoi{font-variant-numeric:slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums;}"
  ];
  [@css ".a-c09p3j{font-variant-east-asian:normal;}"];
  [@css ".a-1t7gmiy{font-variant-east-asian:jis78;}"];
  [@css ".a-11j0lxz{font-variant-east-asian:jis83;}"];
  [@css ".a-1tjwqjo{font-variant-east-asian:jis90;}"];
  [@css ".a-12fmffc{font-variant-east-asian:jis04;}"];
  [@css ".a-sp95a9{font-variant-east-asian:simplified;}"];
  [@css ".a-vechv1{font-variant-east-asian:traditional;}"];
  [@css ".a-i35bhw{font-variant-east-asian:full-width;}"];
  [@css ".a-ghw7p8{font-variant-east-asian:proportional-width;}"];
  [@css ".a-2nc1ts{font-variant-east-asian:ruby;}"];
  [@css ".a-1p5tn8m{font-variant-east-asian:simplified full-width ruby;}"];
  [@css ".a-jhyne0{font-feature-settings:\"c2sc\";}"];
  [@css ".a-1jurtd8{font-feature-settings:\"smcp\" on;}"];
  [@css ".a-1ucpmmf{font-feature-settings:\"liga\" off;}"];
  [@css ".a-180vt2s{font-feature-settings:\"smcp\", \"swsh\" 2;}"];
  
  let fonts: array(CSS.Types.FontFamilyName.t) = [|
    `quoted("Inter"),
    `quoted("Sans"),
  |];
  let fontStack: array(CSS.Types.FontFamilyName.t) = [|`quoted("Inter")|];
  let font: CSS.Types.FontFamily.t = `quoted("Inter");
  
  CSS.make("a-1l2838t", []);
  CSS.make(
    "in-1wpww9k",
    [("--fonts-qhzb1y", CSS.Types.FontFamilies.toString(fonts))],
  );
  CSS.make("a-13c8hy8", []);
  CSS.make(
    "in-1sbj23c",
    [("--fontStack-q2u8nj", CSS.Types.FontFamilies.toString(fontStack))],
  );
  CSS.make("a-38zhkv", []);
  CSS.make(
    "in-e4l4c9",
    [("--font-165jgna", CSS.Types.FontFamily.toString(font))],
  );
  CSS.make("a-zpvvt7", []);
  
  CSS.make("a-1nch51u", []);
  CSS.make("a-4qo3g2", []);
  CSS.make("a-g2uzmx", []);
  CSS.make("a-1c2qsbz", []);
  CSS.make("a-1nhq8d0", []);
  CSS.make("a-o8tzp2", []);
  CSS.make("a-rrlpwk", []);
  CSS.make("a-1ekhi6x", []);
  CSS.make("a-crn7po", []);
  CSS.make("a-48srpk", []);
  CSS.make("a-e1gmww", []);
  CSS.make("a-1uqlj9l", []);
  CSS.make("a-1jjc25g", []);
  CSS.make("a-ax7x05", []);
  CSS.make("a-1n0pxzw", []);
  CSS.make("a-xphjze", []);
  CSS.make("a-eqkqdt", []);
  CSS.make("a-1a990vj", []);
  CSS.make("a-15w2zxs", []);
  CSS.make("a-1aecfjl", []);
  CSS.make("a-1wxb0td", []);
  CSS.make("a-31tt93", []);
  CSS.make("a-13mml8d", []);
  CSS.make("a-i5jzzi", []);
  CSS.make("a-qlvtlx", []);
  CSS.make("a-p3bfe6", []);
  CSS.make("a-3eihfq", []);
  CSS.make("a-20g2wc", []);
  CSS.make("a-1pmzzf7", []);
  CSS.make("a-1gl946z", []);
  CSS.make("a-o4finr", []);
  CSS.make("a-i7h9ap", []);
  CSS.make("a-gg4bxt", []);
  CSS.make("a-1erno1j", []);
  CSS.make("a-pfz9v1", []);
  CSS.make("a-nz29j8", []);
  CSS.make("a-1rrmxeq", []);
  CSS.make("a-14pfxax", []);
  CSS.make("a-d22ijg", []);
  CSS.make("a-n5dp3m", []);
  CSS.make("a-p5oi24", []);
  CSS.make("a-16smq5j", []);
  
  CSS.make("a-d4h4h6", []);
  CSS.make("a-1998aej", []);
  CSS.make("a-1bfh6uj", []);
  CSS.make("a-lp726d", []);
  CSS.make("a-107ypsq", []);
  CSS.make("a-niryki", []);
  CSS.make("a-nb1ay3", []);
  CSS.make("a-17uatbv", []);
  CSS.make("a-v1nsma", []);
  CSS.make("a-yuuc3c", []);
  CSS.make("a-1cymswb", []);
  CSS.make("a-ych0bs", []);
  CSS.make("a-chxz73", []);
  CSS.make("a-19umipp", []);
  CSS.make("a-wrnabk", []);
  CSS.make("a-1n2e0hd", []);
  CSS.make("a-3llltu", []);
  CSS.make("a-hlygkk", []);
  CSS.make("a-rgd4ye", []);
  CSS.make("a-d6yro", []);
  CSS.make("a-13ip6w0", []);
  CSS.make("a-f4sgdl", []);
  CSS.make("a-1elncv3", []);
  CSS.make("a-rimnc1", []);
  CSS.make("a-1oyl9n8", []);
  CSS.make("a-d5tjmp", []);
  CSS.make("a-1i4rq81", []);
  CSS.make("a-1i5v26z", []);
  CSS.make("a-1wiem3q", []);
  CSS.make("a-1va61tv", []);
  CSS.make("a-1vtp3ik", []);
  CSS.make("a-ueadwq", []);
  CSS.make("a-chpu2q", []);
  CSS.make("a-s6dg8c", []);
  CSS.make("a-1sfczn6", []);
  CSS.make("a-wf67x8", []);
  CSS.make("a-t6y53c", []);
  CSS.make("a-j3igep", []);
  CSS.make("a-1st5fsu", []);
  CSS.make("a-d70uxy", []);
  CSS.make("a-16quao3", []);
  CSS.make("a-qspeun", []);
  CSS.make("a-1iy7maz", []);
  CSS.make("a-12asgo0", []);
  CSS.make("a-1ovumeb", []);
  CSS.make("a-14ay4ib", []);
  CSS.make("a-1a909vx", []);
  CSS.make("a-9j80vn", []);
  CSS.make("a-rwu4g7", []);
  CSS.make("a-1e1eltn", []);
  CSS.make("a-1w7gh45", []);
  CSS.make("a-26ogoi", []);
  CSS.make("a-c09p3j", []);
  CSS.make("a-1t7gmiy", []);
  CSS.make("a-11j0lxz", []);
  CSS.make("a-1tjwqjo", []);
  CSS.make("a-12fmffc", []);
  CSS.make("a-sp95a9", []);
  CSS.make("a-vechv1", []);
  CSS.make("a-i35bhw", []);
  CSS.make("a-ghw7p8", []);
  CSS.make("a-2nc1ts", []);
  CSS.make("a-1p5tn8m", []);
  CSS.make("a-13mml8d", []);
  CSS.make("a-jhyne0", []);
  CSS.make("a-1jurtd8", []);
  CSS.make("a-1ucpmmf", []);
  CSS.make("a-180vt2s", []);
