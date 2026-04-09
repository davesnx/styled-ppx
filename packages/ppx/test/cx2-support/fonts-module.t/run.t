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
  File "input.re", line 3, characters 6-32:
  3 | [%cx2 {|font-family: $(fonts);|}];
            ^^^^^^^^^^^^^^^^^^^^^^^^^^
  Error: Unbound value fonts
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css ".css-1l2838t{font-family:\"Inter Semi Bold\";}"];
  [@css ".css-1wpww9k{font-family:var(--var-rwkopp);}"];
  [@css ".css-13c8hy8{font-family:Inter;}"];
  [@css ".css-1rli4v6{font-family:var(--var-1kuyir6);}"];
  [@css ".css-38zhkv{font-family:Inter, Sans;}"];
  [@css ".css-e4l4c9{font-family:Inter, var(--var-1kuyir6);}"];
  [@css ".css-zpvvt7{font-family:\"Gill Sans Extrabold\", sans-serif;}"];
  [@css ".css-1nch51u{font-synthesis-weight:none;}"];
  [@css ".css-4qo3g2{font-synthesis-style:auto;}"];
  [@css ".css-g2uzmx{font-synthesis-small-caps:none;}"];
  [@css ".css-1c2qsbz{font-synthesis-position:auto;}"];
  [@css ".css-1nhq8d0{font-size:xxx-large;}"];
  [@css ".css-o8tzp2{font-variant:none;}"];
  [@css ".css-rrlpwk{font-variant:normal;}"];
  [@css ".css-1ekhi6x{font-variant:all-petite-caps;}"];
  [@css ".css-crn7po{font-variant:historical-forms;}"];
  [@css ".css-48srpk{font-variant:super;}"];
  [@css ".css-e1gmww{font-variant:sub lining-nums contextual ruby;}"];
  [@css ".css-1uqlj9l{font-variant:annotation(circled);}"];
  [@css ".css-ax7x05{font-variant-alternates:normal;}"];
  [@css ".css-1n0pxzw{font-variant-alternates:historical-forms;}"];
  [@css ".css-xphjze{font-variant-alternates:styleset(ss01);}"];
  [@css
    ".css-eqkqdt{font-variant-alternates:styleset(stacked-g, geometric-m);}"
  ];
  [@css ".css-1a990vj{font-variant-alternates:character-variant(cv02);}"];
  [@css
    ".css-15w2zxs{font-variant-alternates:character-variant(beta-3, gamma);}"
  ];
  [@css ".css-1aecfjl{font-variant-alternates:swash(flowing);}"];
  [@css ".css-1wxb0td{font-variant-alternates:ornaments(leaves);}"];
  [@css ".css-31tt93{font-variant-alternates:annotation(blocky);}"];
  [@css ".css-13mml8d{font-feature-settings:normal;}"];
  [@css ".css-i5jzzi{font-feature-settings:\"swsh\" 2;}"];
  [@css ".css-qlvtlx{font-language-override:normal;}"];
  [@css ".css-p3bfe6{font-language-override:\"SRB\";}"];
  [@css ".css-3eihfq{font-weight:1;}"];
  [@css ".css-20g2wc{font-weight:90;}"];
  [@css ".css-1pmzzf7{font-weight:750;}"];
  [@css ".css-1gl946z{font-weight:1000;}"];
  [@css ".css-o4finr{font-style:oblique 15deg;}"];
  [@css ".css-i7h9ap{font-style:oblique -15deg;}"];
  [@css ".css-gg4bxt{font-style:oblique 0deg;}"];
  [@css ".css-1erno1j{font-optical-sizing:none;}"];
  [@css ".css-pfz9v1{font-optical-sizing:auto;}"];
  [@css ".css-nz29j8{font-palette:normal;}"];
  [@css ".css-1rrmxeq{font-palette:light;}"];
  [@css ".css-14pfxax{font-palette:dark;}"];
  [@css ".css-d22ijg{font-variant-emoji:normal;}"];
  [@css ".css-n5dp3m{font-variant-emoji:text;}"];
  [@css ".css-p5oi24{font-variant-emoji:emoji;}"];
  [@css ".css-16smq5j{font-variant-emoji:unicode;}"];
  [@css ".css-d4h4h6{font-stretch:normal;}"];
  [@css ".css-1998aej{font-stretch:ultra-condensed;}"];
  [@css ".css-1bfh6uj{font-stretch:extra-condensed;}"];
  [@css ".css-lp726d{font-stretch:condensed;}"];
  [@css ".css-107ypsq{font-stretch:semi-condensed;}"];
  [@css ".css-niryki{font-stretch:semi-expanded;}"];
  [@css ".css-nb1ay3{font-stretch:expanded;}"];
  [@css ".css-17uatbv{font-stretch:extra-expanded;}"];
  [@css ".css-v1nsma{font-stretch:ultra-expanded;}"];
  [@css ".css-yuuc3c{font-size-adjust:none;}"];
  [@css ".css-1cymswb{font-size-adjust:0.5;}"];
  [@css ".css-ych0bs{font-synthesis:none;}"];
  [@css ".css-chxz73{font-synthesis:weight;}"];
  [@css ".css-19umipp{font-synthesis:style;}"];
  [@css ".css-wrnabk{font-synthesis:weight style;}"];
  [@css ".css-1n2e0hd{font-synthesis:style weight;}"];
  [@css ".css-3llltu{font-kerning:auto;}"];
  [@css ".css-hlygkk{font-kerning:normal;}"];
  [@css ".css-rgd4ye{font-kerning:none;}"];
  [@css ".css-d6yro{font-variant-position:normal;}"];
  [@css ".css-13ip6w0{font-variant-position:sub;}"];
  [@css ".css-f4sgdl{font-variant-position:super;}"];
  [@css ".css-1elncv3{font-variant-ligatures:normal;}"];
  [@css ".css-rimnc1{font-variant-ligatures:none;}"];
  [@css ".css-1oyl9n8{font-variant-ligatures:common-ligatures;}"];
  [@css ".css-d5tjmp{font-variant-ligatures:no-common-ligatures;}"];
  [@css ".css-1i4rq81{font-variant-ligatures:discretionary-ligatures;}"];
  [@css ".css-1i5v26z{font-variant-ligatures:no-discretionary-ligatures;}"];
  [@css ".css-1wiem3q{font-variant-ligatures:historical-ligatures;}"];
  [@css ".css-1va61tv{font-variant-ligatures:no-historical-ligatures;}"];
  [@css ".css-1vtp3ik{font-variant-ligatures:contextual;}"];
  [@css ".css-ueadwq{font-variant-ligatures:no-contextual;}"];
  [@css ".css-s6dg8c{font-variant-caps:normal;}"];
  [@css ".css-1sfczn6{font-variant-caps:small-caps;}"];
  [@css ".css-wf67x8{font-variant-caps:all-small-caps;}"];
  [@css ".css-t6y53c{font-variant-caps:petite-caps;}"];
  [@css ".css-j3igep{font-variant-caps:all-petite-caps;}"];
  [@css ".css-1st5fsu{font-variant-caps:titling-caps;}"];
  [@css ".css-d70uxy{font-variant-caps:unicase;}"];
  [@css ".css-16quao3{font-variant-numeric:normal;}"];
  [@css ".css-qspeun{font-variant-numeric:lining-nums;}"];
  [@css ".css-1iy7maz{font-variant-numeric:oldstyle-nums;}"];
  [@css ".css-12asgo0{font-variant-numeric:proportional-nums;}"];
  [@css ".css-1ovumeb{font-variant-numeric:tabular-nums;}"];
  [@css ".css-14ay4ib{font-variant-numeric:diagonal-fractions;}"];
  [@css ".css-1a909vx{font-variant-numeric:stacked-fractions;}"];
  [@css ".css-9j80vn{font-variant-numeric:ordinal;}"];
  [@css ".css-rwu4g7{font-variant-numeric:slashed-zero;}"];
  [@css ".css-c09p3j{font-variant-east-asian:normal;}"];
  [@css ".css-1t7gmiy{font-variant-east-asian:jis78;}"];
  [@css ".css-11j0lxz{font-variant-east-asian:jis83;}"];
  [@css ".css-1tjwqjo{font-variant-east-asian:jis90;}"];
  [@css ".css-12fmffc{font-variant-east-asian:jis04;}"];
  [@css ".css-sp95a9{font-variant-east-asian:simplified;}"];
  [@css ".css-vechv1{font-variant-east-asian:traditional;}"];
  [@css ".css-i35bhw{font-variant-east-asian:full-width;}"];
  [@css ".css-ghw7p8{font-variant-east-asian:proportional-width;}"];
  [@css ".css-2nc1ts{font-variant-east-asian:ruby;}"];
  [@css ".css-1p5tn8m{font-variant-east-asian:simplified full-width ruby;}"];
  [@css ".css-jhyne0{font-feature-settings:\"c2sc\";}"];
  [@css ".css-1jurtd8{font-feature-settings:\"smcp\" on;}"];
  [@css ".css-1ucpmmf{font-feature-settings:\"liga\" off;}"];
  [@css ".css-180vt2s{font-feature-settings:\"smcp\", \"swsh\" 2;}"];
  
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
