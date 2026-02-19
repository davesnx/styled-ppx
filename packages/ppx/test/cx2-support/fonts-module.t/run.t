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
    ".css-1l2838t{font-family:\"Inter Semi Bold\";}\n.css-1wpww9k{font-family:var(--var-rwkopp);}\n.css-13c8hy8{font-family:Inter;}\n.css-1rli4v6{font-family:var(--var-1kuyir6);}\n.css-38zhkv{font-family:Inter, Sans;}\n.css-e4l4c9{font-family:Inter, var(--var-1kuyir6);}\n.css-zpvvt7{font-family:\"Gill Sans Extrabold\", sans-serif;}\n.css-1nch51u{font-synthesis-weight:none;}\n.css-4qo3g2{font-synthesis-style:auto;}\n.css-g2uzmx{font-synthesis-small-caps:none;}\n.css-1c2qsbz{font-synthesis-position:auto;}\n.css-1nhq8d0{font-size:xxx-large;}\n.css-o8tzp2{font-variant:none;}\n.css-rrlpwk{font-variant:normal;}\n.css-1ekhi6x{font-variant:all-petite-caps;}\n.css-crn7po{font-variant:historical-forms;}\n.css-48srpk{font-variant:super;}\n.css-e1gmww{font-variant:sub lining-nums contextual ruby;}\n.css-1uqlj9l{font-variant:annotation(circled);}\n.css-ax7x05{font-variant-alternates:normal;}\n.css-1n0pxzw{font-variant-alternates:historical-forms;}\n.css-xphjze{font-variant-alternates:styleset(ss01);}\n.css-eqkqdt{font-variant-alternates:styleset(stacked-g, geometric-m);}\n.css-1a990vj{font-variant-alternates:character-variant(cv02);}\n.css-15w2zxs{font-variant-alternates:character-variant(beta-3, gamma);}\n.css-1aecfjl{font-variant-alternates:swash(flowing);}\n.css-1wxb0td{font-variant-alternates:ornaments(leaves);}\n.css-31tt93{font-variant-alternates:annotation(blocky);}\n.css-13mml8d{font-feature-settings:normal;}\n.css-i5jzzi{font-feature-settings:\"swsh\" 2;}\n.css-qlvtlx{font-language-override:normal;}\n.css-p3bfe6{font-language-override:\"SRB\";}\n.css-3eihfq{font-weight:1;}\n.css-20g2wc{font-weight:90;}\n.css-1pmzzf7{font-weight:750;}\n.css-1gl946z{font-weight:1000;}\n.css-o4finr{font-style:oblique 15deg;}\n.css-i7h9ap{font-style:oblique -15deg;}\n.css-gg4bxt{font-style:oblique 0deg;}\n.css-1erno1j{font-optical-sizing:none;}\n.css-pfz9v1{font-optical-sizing:auto;}\n.css-nz29j8{font-palette:normal;}\n.css-1rrmxeq{font-palette:light;}\n.css-14pfxax{font-palette:dark;}\n.css-d22ijg{font-variant-emoji:normal;}\n.css-n5dp3m{font-variant-emoji:text;}\n.css-p5oi24{font-variant-emoji:emoji;}\n.css-16smq5j{font-variant-emoji:unicode;}\n.css-d4h4h6{font-stretch:normal;}\n.css-1998aej{font-stretch:ultra-condensed;}\n.css-1bfh6uj{font-stretch:extra-condensed;}\n.css-lp726d{font-stretch:condensed;}\n.css-107ypsq{font-stretch:semi-condensed;}\n.css-niryki{font-stretch:semi-expanded;}\n.css-nb1ay3{font-stretch:expanded;}\n.css-17uatbv{font-stretch:extra-expanded;}\n.css-v1nsma{font-stretch:ultra-expanded;}\n.css-yuuc3c{font-size-adjust:none;}\n.css-1cymswb{font-size-adjust:0.5;}\n.css-ych0bs{font-synthesis:none;}\n.css-chxz73{font-synthesis:weight;}\n.css-19umipp{font-synthesis:style;}\n.css-wrnabk{font-synthesis:weight style;}\n.css-1n2e0hd{font-synthesis:style weight;}\n.css-3llltu{font-kerning:auto;}\n.css-hlygkk{font-kerning:normal;}\n.css-rgd4ye{font-kerning:none;}\n.css-d6yro{font-variant-position:normal;}\n.css-13ip6w0{font-variant-position:sub;}\n.css-f4sgdl{font-variant-position:super;}\n.css-1elncv3{font-variant-ligatures:normal;}\n.css-rimnc1{font-variant-ligatures:none;}\n.css-1oyl9n8{font-variant-ligatures:common-ligatures;}\n.css-d5tjmp{font-variant-ligatures:no-common-ligatures;}\n.css-1i4rq81{font-variant-ligatures:discretionary-ligatures;}\n.css-1i5v26z{font-variant-ligatures:no-discretionary-ligatures;}\n.css-1wiem3q{font-variant-ligatures:historical-ligatures;}\n.css-1va61tv{font-variant-ligatures:no-historical-ligatures;}\n.css-1vtp3ik{font-variant-ligatures:contextual;}\n.css-ueadwq{font-variant-ligatures:no-contextual;}\n.css-s6dg8c{font-variant-caps:normal;}\n.css-1sfczn6{font-variant-caps:small-caps;}\n.css-wf67x8{font-variant-caps:all-small-caps;}\n.css-t6y53c{font-variant-caps:petite-caps;}\n.css-j3igep{font-variant-caps:all-petite-caps;}\n.css-1st5fsu{font-variant-caps:titling-caps;}\n.css-d70uxy{font-variant-caps:unicase;}\n.css-16quao3{font-variant-numeric:normal;}\n.css-qspeun{font-variant-numeric:lining-nums;}\n.css-1iy7maz{font-variant-numeric:oldstyle-nums;}\n.css-12asgo0{font-variant-numeric:proportional-nums;}\n.css-1ovumeb{font-variant-numeric:tabular-nums;}\n.css-14ay4ib{font-variant-numeric:diagonal-fractions;}\n.css-1a909vx{font-variant-numeric:stacked-fractions;}\n.css-9j80vn{font-variant-numeric:ordinal;}\n.css-rwu4g7{font-variant-numeric:slashed-zero;}\n.css-c09p3j{font-variant-east-asian:normal;}\n.css-1t7gmiy{font-variant-east-asian:jis78;}\n.css-11j0lxz{font-variant-east-asian:jis83;}\n.css-1tjwqjo{font-variant-east-asian:jis90;}\n.css-12fmffc{font-variant-east-asian:jis04;}\n.css-sp95a9{font-variant-east-asian:simplified;}\n.css-vechv1{font-variant-east-asian:traditional;}\n.css-i35bhw{font-variant-east-asian:full-width;}\n.css-ghw7p8{font-variant-east-asian:proportional-width;}\n.css-2nc1ts{font-variant-east-asian:ruby;}\n.css-1p5tn8m{font-variant-east-asian:simplified full-width ruby;}\n.css-jhyne0{font-feature-settings:\"c2sc\";}\n.css-1jurtd8{font-feature-settings:\"smcp\" on;}\n.css-1ucpmmf{font-feature-settings:\"liga\" off;}\n.css-180vt2s{font-feature-settings:\"smcp\", \"swsh\" 2;}\n"
  ];
  
  CSS.make("css-1l2838t", []);
  CSS.make(
    "css-1wpww9k",
    [("--var-rwkopp", CSS.Types.FontFamily.toString(fonts))],
  );
  CSS.make("css-13c8hy8", []);
  CSS.make(
    "css-1rli4v6",
    [("--var-1kuyir6", CSS.Types.FontFamily.toString(font))],
  );
  CSS.make("css-38zhkv", []);
  CSS.make(
    "css-e4l4c9",
    [("--var-1kuyir6", CSS.Types.FontFamily.toString(font))],
  );
  CSS.make("css-zpvvt7", []);
  
  CSS.make("css-1nch51u", []);
  CSS.make("css-4qo3g2", []);
  CSS.make("css-g2uzmx", []);
  CSS.make("css-1c2qsbz", []);
  CSS.make("css-1nhq8d0", []);
  CSS.make("css-o8tzp2", []);
  CSS.make("css-rrlpwk", []);
  CSS.make("css-1ekhi6x", []);
  CSS.make("css-crn7po", []);
  CSS.make("css-48srpk", []);
  CSS.make("css-e1gmww", []);
  CSS.make("css-1uqlj9l", []);
  CSS.unsafe(
    {js|fontVariant|js},
    {js|discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U)|js},
  );
  CSS.make("css-ax7x05", []);
  CSS.make("css-1n0pxzw", []);
  CSS.make("css-xphjze", []);
  CSS.make("css-eqkqdt", []);
  CSS.make("css-1a990vj", []);
  CSS.make("css-15w2zxs", []);
  CSS.make("css-1aecfjl", []);
  CSS.make("css-1wxb0td", []);
  CSS.make("css-31tt93", []);
  CSS.make("css-13mml8d", []);
  CSS.make("css-i5jzzi", []);
  CSS.make("css-qlvtlx", []);
  CSS.make("css-p3bfe6", []);
  CSS.make("css-3eihfq", []);
  CSS.make("css-20g2wc", []);
  CSS.make("css-1pmzzf7", []);
  CSS.make("css-1gl946z", []);
  CSS.make("css-o4finr", []);
  CSS.make("css-i7h9ap", []);
  CSS.make("css-gg4bxt", []);
  CSS.make("css-1erno1j", []);
  CSS.make("css-pfz9v1", []);
  CSS.make("css-nz29j8", []);
  CSS.make("css-1rrmxeq", []);
  CSS.make("css-14pfxax", []);
  CSS.make("css-d22ijg", []);
  CSS.make("css-n5dp3m", []);
  CSS.make("css-p5oi24", []);
  CSS.make("css-16smq5j", []);
  
  CSS.make("css-d4h4h6", []);
  CSS.make("css-1998aej", []);
  CSS.make("css-1bfh6uj", []);
  CSS.make("css-lp726d", []);
  CSS.make("css-107ypsq", []);
  CSS.make("css-niryki", []);
  CSS.make("css-nb1ay3", []);
  CSS.make("css-17uatbv", []);
  CSS.make("css-v1nsma", []);
  CSS.make("css-yuuc3c", []);
  CSS.make("css-1cymswb", []);
  CSS.make("css-ych0bs", []);
  CSS.make("css-chxz73", []);
  CSS.make("css-19umipp", []);
  CSS.make("css-wrnabk", []);
  CSS.make("css-1n2e0hd", []);
  CSS.make("css-3llltu", []);
  CSS.make("css-hlygkk", []);
  CSS.make("css-rgd4ye", []);
  CSS.make("css-d6yro", []);
  CSS.make("css-13ip6w0", []);
  CSS.make("css-f4sgdl", []);
  CSS.make("css-1elncv3", []);
  CSS.make("css-rimnc1", []);
  CSS.make("css-1oyl9n8", []);
  CSS.make("css-d5tjmp", []);
  CSS.make("css-1i4rq81", []);
  CSS.make("css-1i5v26z", []);
  CSS.make("css-1wiem3q", []);
  CSS.make("css-1va61tv", []);
  CSS.make("css-1vtp3ik", []);
  CSS.make("css-ueadwq", []);
  CSS.unsafe(
    {js|fontVariantLigatures|js},
    {js|common-ligatures discretionary-ligatures historical-ligatures contextual|js},
  );
  CSS.make("css-s6dg8c", []);
  CSS.make("css-1sfczn6", []);
  CSS.make("css-wf67x8", []);
  CSS.make("css-t6y53c", []);
  CSS.make("css-j3igep", []);
  CSS.make("css-1st5fsu", []);
  CSS.make("css-d70uxy", []);
  CSS.make("css-16quao3", []);
  CSS.make("css-qspeun", []);
  CSS.make("css-1iy7maz", []);
  CSS.make("css-12asgo0", []);
  CSS.make("css-1ovumeb", []);
  CSS.make("css-14ay4ib", []);
  CSS.make("css-1a909vx", []);
  CSS.make("css-9j80vn", []);
  CSS.make("css-rwu4g7", []);
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
  CSS.make("css-c09p3j", []);
  CSS.make("css-1t7gmiy", []);
  CSS.make("css-11j0lxz", []);
  CSS.make("css-1tjwqjo", []);
  CSS.make("css-12fmffc", []);
  CSS.make("css-sp95a9", []);
  CSS.make("css-vechv1", []);
  CSS.make("css-i35bhw", []);
  CSS.make("css-ghw7p8", []);
  CSS.make("css-2nc1ts", []);
  CSS.make("css-1p5tn8m", []);
  CSS.make("css-13mml8d", []);
  CSS.make("css-jhyne0", []);
  CSS.make("css-1jurtd8", []);
  CSS.make("css-1ucpmmf", []);
  CSS.make("css-180vt2s", []);
