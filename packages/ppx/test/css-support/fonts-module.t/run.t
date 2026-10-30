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
  [@css
    (
      "._a_650001838t{font-family:\"Inter Semi Bold\";}",
      "_a_650001838t",
      "0,1,0 own",
      "221",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_650001ww9k{font-family:var(--fonts-qhzb1y);}",
      "_a_650001ww9k",
      "0,1,0 own",
      "221",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6500018hy8{font-family:Inter;}",
      "_a_6500018hy8",
      "0,1,0 own",
      "221",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_650001j23c{font-family:var(--fontStack-q2u8nj);}",
      "_a_650001j23c",
      "0,1,0 own",
      "221",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_650001zhkv{font-family:Inter, Sans;}",
      "_a_650001zhkv",
      "0,1,0 own",
      "221",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_650001l4c9{font-family:Inter, var(--font-165jgna);}",
      "_a_650001l4c9",
      "0,1,0 own",
      "221",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_650001vvt7{font-family:\"Gill Sans Extrabold\", sans-serif;}",
      "_a_650001vvt7",
      "0,1,0 own",
      "221",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6dh51u{font-synthesis-weight:none;}",
      "_a_6dh51u",
      "0,1,0 own",
      "229",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6co3g2{font-synthesis-style:auto;}",
      "_a_6co3g2",
      "0,1,0 own",
      "228",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6buzmx{font-synthesis-small-caps:none;}",
      "_a_6buzmx",
      "0,1,0 own",
      "227",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6aqsbz{font-synthesis-position:auto;}",
      "_a_6aqsbz",
      "0,1,0 own",
      "226",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_65000wq8d0{font-size:xxx-large;}",
      "_a_65000wq8d0",
      "0,1,0 own",
      "221",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_6500e8tzp2{font-variant:none;}",
      "_a_6500e8tzp2",
      "0,1,0 own",
      "221",
      512,
      false,
    )
  ];
  [@css
    (
      "._a_6500e8lpwk{font-variant:normal;}",
      "_a_6500e8lpwk",
      "0,1,0 own",
      "221",
      512,
      false,
    )
  ];
  [@css
    (
      "._a_6500e8hi6x{font-variant:all-petite-caps;}",
      "_a_6500e8hi6x",
      "0,1,0 own",
      "221",
      512,
      false,
    )
  ];
  [@css
    (
      "._a_6500e8n7po{font-variant:historical-forms;}",
      "_a_6500e8n7po",
      "0,1,0 own",
      "221",
      512,
      false,
    )
  ];
  [@css
    (
      "._a_6500e8srpk{font-variant:super;}",
      "_a_6500e8srpk",
      "0,1,0 own",
      "221",
      512,
      false,
    )
  ];
  [@css
    (
      "._a_6500e8gmww{font-variant:sub lining-nums contextual ruby;}",
      "_a_6500e8gmww",
      "0,1,0 own",
      "221",
      512,
      false,
    )
  ];
  [@css
    (
      "._a_6500e8lj9l{font-variant:annotation(circled);}",
      "_a_6500e8lj9l",
      "0,1,0 own",
      "221",
      512,
      false,
    )
  ];
  [@css
    (
      "._a_6500e8c25g{font-variant:discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U);}",
      "_a_6500e8c25g",
      "0,1,0 own",
      "221",
      512,
      false,
    )
  ];
  [@css
    (
      "._a_6500sg7x05{font-variant-alternates:normal;}",
      "_a_6500sg7x05",
      "0,1,0 own",
      "221",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_6500sgpxzw{font-variant-alternates:historical-forms;}",
      "_a_6500sgpxzw",
      "0,1,0 own",
      "221",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_6500sghjze{font-variant-alternates:styleset(ss01);}",
      "_a_6500sghjze",
      "0,1,0 own",
      "221",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_6500sgkqdt{font-variant-alternates:styleset(stacked-g, geometric-m);}",
      "_a_6500sgkqdt",
      "0,1,0 own",
      "221",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_6500sg90vj{font-variant-alternates:character-variant(cv02);}",
      "_a_6500sg90vj",
      "0,1,0 own",
      "221",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_6500sg2zxs{font-variant-alternates:character-variant(beta-3, gamma);}",
      "_a_6500sg2zxs",
      "0,1,0 own",
      "221",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_6500sgcfjl{font-variant-alternates:swash(flowing);}",
      "_a_6500sgcfjl",
      "0,1,0 own",
      "221",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_6500sgb0td{font-variant-alternates:ornaments(leaves);}",
      "_a_6500sgb0td",
      "0,1,0 own",
      "221",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_6500sgtt93{font-variant-alternates:annotation(blocky);}",
      "_a_6500sgtt93",
      "0,1,0 own",
      "221",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_650002ml8d{font-feature-settings:normal;}",
      "_a_650002ml8d",
      "0,1,0 own",
      "221",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_650002jzzi{font-feature-settings:\"swsh\" 2;}",
      "_a_650002jzzi",
      "0,1,0 own",
      "221",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_650008vtlx{font-language-override:normal;}",
      "_a_650008vtlx",
      "0,1,0 own",
      "221",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_650008bfe6{font-language-override:\"SRB\";}",
      "_a_650008bfe6",
      "0,1,0 own",
      "221",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_655m9sihfq{font-weight:1;}",
      "_a_655m9sihfq",
      "0,1,0 own",
      "221",
      262144,
      false,
    )
  ];
  [@css
    (
      "._a_655m9sg2wc{font-weight:90;}",
      "_a_655m9sg2wc",
      "0,1,0 own",
      "221",
      262144,
      false,
    )
  ];
  [@css
    (
      "._a_655m9szzf7{font-weight:750;}",
      "_a_655m9szzf7",
      "0,1,0 own",
      "221",
      262144,
      false,
    )
  ];
  [@css
    (
      "._a_655m9s946z{font-weight:1000;}",
      "_a_655m9s946z",
      "0,1,0 own",
      "221",
      262144,
      false,
    )
  ];
  [@css
    (
      "._a_650074finr{font-style:oblique 15deg;}",
      "_a_650074finr",
      "0,1,0 own",
      "221",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_650074h9ap{font-style:oblique -15deg;}",
      "_a_650074h9ap",
      "0,1,0 own",
      "221",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_6500744bxt{font-style:oblique 0deg;}",
      "_a_6500744bxt",
      "0,1,0 own",
      "221",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_65000gno1j{font-optical-sizing:none;}",
      "_a_65000gno1j",
      "0,1,0 own",
      "221",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_65000gz9v1{font-optical-sizing:auto;}",
      "_a_65000gz9v1",
      "0,1,0 own",
      "221",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_6729j8{font-palette:normal;}",
      "_a_6729j8",
      "0,1,0 own",
      "223",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_67mxeq{font-palette:light;}",
      "_a_67mxeq",
      "0,1,0 own",
      "223",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_67fxax{font-palette:dark;}",
      "_a_67fxax",
      "0,1,0 own",
      "223",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6506bk2ijg{font-variant-emoji:normal;}",
      "_a_6506bk2ijg",
      "0,1,0 own",
      "221",
      8192,
      false,
    )
  ];
  [@css
    (
      "._a_6506bkdp3m{font-variant-emoji:text;}",
      "_a_6506bkdp3m",
      "0,1,0 own",
      "221",
      8192,
      false,
    )
  ];
  [@css
    (
      "._a_6506bkoi24{font-variant-emoji:emoji;}",
      "_a_6506bkoi24",
      "0,1,0 own",
      "221",
      8192,
      false,
    )
  ];
  [@css
    (
      "._a_6506bkmq5j{font-variant-emoji:unicode;}",
      "_a_6506bkmq5j",
      "0,1,0 own",
      "221",
      8192,
      false,
    )
  ];
  [@css
    (
      "._a_65003kh4h6{font-stretch:normal;}",
      "_a_65003kh4h6",
      "0,1,0 own",
      "221",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_65003k8aej{font-stretch:ultra-condensed;}",
      "_a_65003k8aej",
      "0,1,0 own",
      "221",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_65003kh6uj{font-stretch:extra-condensed;}",
      "_a_65003kh6uj",
      "0,1,0 own",
      "221",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_65003k726d{font-stretch:condensed;}",
      "_a_65003k726d",
      "0,1,0 own",
      "221",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_65003kypsq{font-stretch:semi-condensed;}",
      "_a_65003kypsq",
      "0,1,0 own",
      "221",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_65003kryki{font-stretch:semi-expanded;}",
      "_a_65003kryki",
      "0,1,0 own",
      "221",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_65003k1ay3{font-stretch:expanded;}",
      "_a_65003k1ay3",
      "0,1,0 own",
      "221",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_65003katbv{font-stretch:extra-expanded;}",
      "_a_65003katbv",
      "0,1,0 own",
      "221",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_65003knsma{font-stretch:ultra-expanded;}",
      "_a_65003knsma",
      "0,1,0 own",
      "221",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_65001suc3c{font-size-adjust:none;}",
      "_a_65001suc3c",
      "0,1,0 own",
      "221",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_65001smswb{font-size-adjust:0.5;}",
      "_a_65001smswb",
      "0,1,0 own",
      "221",
      64,
      false,
    )
  ];
  [@css
    (
      "._a_69h0bs{font-synthesis:none;}",
      "_a_69h0bs",
      "0,1,0 own",
      "225",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_69xz73{font-synthesis:weight;}",
      "_a_69xz73",
      "0,1,0 own",
      "225",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_69mipp{font-synthesis:style;}",
      "_a_69mipp",
      "0,1,0 own",
      "225",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_69nabk{font-synthesis:weight style;}",
      "_a_69nabk",
      "0,1,0 own",
      "225",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_69e0hd{font-synthesis:style weight;}",
      "_a_69e0hd",
      "0,1,0 own",
      "225",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_650004lltu{font-kerning:auto;}",
      "_a_650004lltu",
      "0,1,0 own",
      "221",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_650004ygkk{font-kerning:normal;}",
      "_a_650004ygkk",
      "0,1,0 own",
      "221",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_650004d4ye{font-kerning:none;}",
      "_a_650004d4ye",
      "0,1,0 own",
      "221",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_651ekg6yro{font-variant-position:normal;}",
      "_a_651ekg6yro",
      "0,1,0 own",
      "221",
      65536,
      false,
    )
  ];
  [@css
    (
      "._a_651ekgp6w0{font-variant-position:sub;}",
      "_a_651ekgp6w0",
      "0,1,0 own",
      "221",
      65536,
      false,
    )
  ];
  [@css
    (
      "._a_651ekgsgdl{font-variant-position:super;}",
      "_a_651ekgsgdl",
      "0,1,0 own",
      "221",
      65536,
      false,
    )
  ];
  [@css
    (
      "._a_650cn4ncv3{font-variant-ligatures:normal;}",
      "_a_650cn4ncv3",
      "0,1,0 own",
      "221",
      16384,
      false,
    )
  ];
  [@css
    (
      "._a_650cn4mnc1{font-variant-ligatures:none;}",
      "_a_650cn4mnc1",
      "0,1,0 own",
      "221",
      16384,
      false,
    )
  ];
  [@css
    (
      "._a_650cn4l9n8{font-variant-ligatures:common-ligatures;}",
      "_a_650cn4l9n8",
      "0,1,0 own",
      "221",
      16384,
      false,
    )
  ];
  [@css
    (
      "._a_650cn4tjmp{font-variant-ligatures:no-common-ligatures;}",
      "_a_650cn4tjmp",
      "0,1,0 own",
      "221",
      16384,
      false,
    )
  ];
  [@css
    (
      "._a_650cn4rq81{font-variant-ligatures:discretionary-ligatures;}",
      "_a_650cn4rq81",
      "0,1,0 own",
      "221",
      16384,
      false,
    )
  ];
  [@css
    (
      "._a_650cn4v26z{font-variant-ligatures:no-discretionary-ligatures;}",
      "_a_650cn4v26z",
      "0,1,0 own",
      "221",
      16384,
      false,
    )
  ];
  [@css
    (
      "._a_650cn4em3q{font-variant-ligatures:historical-ligatures;}",
      "_a_650cn4em3q",
      "0,1,0 own",
      "221",
      16384,
      false,
    )
  ];
  [@css
    (
      "._a_650cn461tv{font-variant-ligatures:no-historical-ligatures;}",
      "_a_650cn461tv",
      "0,1,0 own",
      "221",
      16384,
      false,
    )
  ];
  [@css
    (
      "._a_650cn4p3ik{font-variant-ligatures:contextual;}",
      "_a_650cn4p3ik",
      "0,1,0 own",
      "221",
      16384,
      false,
    )
  ];
  [@css
    (
      "._a_650cn4adwq{font-variant-ligatures:no-contextual;}",
      "_a_650cn4adwq",
      "0,1,0 own",
      "221",
      16384,
      false,
    )
  ];
  [@css
    (
      "._a_650cn4pu2q{font-variant-ligatures:common-ligatures discretionary-ligatures historical-ligatures contextual;}",
      "_a_650cn4pu2q",
      "0,1,0 own",
      "221",
      16384,
      false,
    )
  ];
  [@css
    (
      "._a_6501kwdg8c{font-variant-caps:normal;}",
      "_a_6501kwdg8c",
      "0,1,0 own",
      "221",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_6501kwczn6{font-variant-caps:small-caps;}",
      "_a_6501kwczn6",
      "0,1,0 own",
      "221",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_6501kw67x8{font-variant-caps:all-small-caps;}",
      "_a_6501kw67x8",
      "0,1,0 own",
      "221",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_6501kwy53c{font-variant-caps:petite-caps;}",
      "_a_6501kwy53c",
      "0,1,0 own",
      "221",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_6501kwigep{font-variant-caps:all-petite-caps;}",
      "_a_6501kwigep",
      "0,1,0 own",
      "221",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_6501kw5fsu{font-variant-caps:titling-caps;}",
      "_a_6501kw5fsu",
      "0,1,0 own",
      "221",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_6501kw0uxy{font-variant-caps:unicase;}",
      "_a_6501kw0uxy",
      "0,1,0 own",
      "221",
      2048,
      false,
    )
  ];
  [@css
    (
      "._a_650pa8uao3{font-variant-numeric:normal;}",
      "_a_650pa8uao3",
      "0,1,0 own",
      "221",
      32768,
      false,
    )
  ];
  [@css
    (
      "._a_650pa8peun{font-variant-numeric:lining-nums;}",
      "_a_650pa8peun",
      "0,1,0 own",
      "221",
      32768,
      false,
    )
  ];
  [@css
    (
      "._a_650pa87maz{font-variant-numeric:oldstyle-nums;}",
      "_a_650pa87maz",
      "0,1,0 own",
      "221",
      32768,
      false,
    )
  ];
  [@css
    (
      "._a_650pa8sgo0{font-variant-numeric:proportional-nums;}",
      "_a_650pa8sgo0",
      "0,1,0 own",
      "221",
      32768,
      false,
    )
  ];
  [@css
    (
      "._a_650pa8umeb{font-variant-numeric:tabular-nums;}",
      "_a_650pa8umeb",
      "0,1,0 own",
      "221",
      32768,
      false,
    )
  ];
  [@css
    (
      "._a_650pa8y4ib{font-variant-numeric:diagonal-fractions;}",
      "_a_650pa8y4ib",
      "0,1,0 own",
      "221",
      32768,
      false,
    )
  ];
  [@css
    (
      "._a_650pa809vx{font-variant-numeric:stacked-fractions;}",
      "_a_650pa809vx",
      "0,1,0 own",
      "221",
      32768,
      false,
    )
  ];
  [@css
    (
      "._a_650pa880vn{font-variant-numeric:ordinal;}",
      "_a_650pa880vn",
      "0,1,0 own",
      "221",
      32768,
      false,
    )
  ];
  [@css
    (
      "._a_650pa8u4g7{font-variant-numeric:slashed-zero;}",
      "_a_650pa8u4g7",
      "0,1,0 own",
      "221",
      32768,
      false,
    )
  ];
  [@css
    (
      "._a_650pa8eltn{font-variant-numeric:lining-nums proportional-nums diagonal-fractions;}",
      "_a_650pa8eltn",
      "0,1,0 own",
      "221",
      32768,
      false,
    )
  ];
  [@css
    (
      "._a_650pa8gh45{font-variant-numeric:oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero;}",
      "_a_650pa8gh45",
      "0,1,0 own",
      "221",
      32768,
      false,
    )
  ];
  [@css
    (
      "._a_650pa8ogoi{font-variant-numeric:slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums;}",
      "_a_650pa8ogoi",
      "0,1,0 own",
      "221",
      32768,
      false,
    )
  ];
  [@css
    (
      "._a_65035s9p3j{font-variant-east-asian:normal;}",
      "_a_65035s9p3j",
      "0,1,0 own",
      "221",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_65035sgmiy{font-variant-east-asian:jis78;}",
      "_a_65035sgmiy",
      "0,1,0 own",
      "221",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_65035s0lxz{font-variant-east-asian:jis83;}",
      "_a_65035s0lxz",
      "0,1,0 own",
      "221",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_65035swqjo{font-variant-east-asian:jis90;}",
      "_a_65035swqjo",
      "0,1,0 own",
      "221",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_65035smffc{font-variant-east-asian:jis04;}",
      "_a_65035smffc",
      "0,1,0 own",
      "221",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_65035s95a9{font-variant-east-asian:simplified;}",
      "_a_65035s95a9",
      "0,1,0 own",
      "221",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_65035schv1{font-variant-east-asian:traditional;}",
      "_a_65035schv1",
      "0,1,0 own",
      "221",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_65035s5bhw{font-variant-east-asian:full-width;}",
      "_a_65035s5bhw",
      "0,1,0 own",
      "221",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_65035sw7p8{font-variant-east-asian:proportional-width;}",
      "_a_65035sw7p8",
      "0,1,0 own",
      "221",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_65035sc1ts{font-variant-east-asian:ruby;}",
      "_a_65035sc1ts",
      "0,1,0 own",
      "221",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_65035stn8m{font-variant-east-asian:simplified full-width ruby;}",
      "_a_65035stn8m",
      "0,1,0 own",
      "221",
      4096,
      false,
    )
  ];
  [@css
    (
      "._a_650002yne0{font-feature-settings:\"c2sc\";}",
      "_a_650002yne0",
      "0,1,0 own",
      "221",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_650002rtd8{font-feature-settings:\"smcp\" on;}",
      "_a_650002rtd8",
      "0,1,0 own",
      "221",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_650002pmmf{font-feature-settings:\"liga\" off;}",
      "_a_650002pmmf",
      "0,1,0 own",
      "221",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_650002vt2s{font-feature-settings:\"smcp\", \"swsh\" 2;}",
      "_a_650002vt2s",
      "0,1,0 own",
      "221",
      2,
      false,
    )
  ];
  [@css.blocks
    [
      (13, "", [3]),
      (14, "", [4]),
      (15, "", [5]),
      (16, "", [6]),
      (17, "", [7]),
      (18, "", [8]),
      (19, "", [9]),
      (22, "", [10]),
      (23, "", [11]),
      (24, "", [12]),
      (25, "", [13]),
      (26, "", [14]),
      (27, "", [15]),
      (28, "", [16]),
      (29, "", [17]),
      (30, "", [18]),
      (31, "", [19]),
      (32, "", [20]),
      (33, "", [21]),
      (35, "", [22]),
      (37, "", [23]),
      (38, "", [24]),
      (39, "", [25]),
      (40, "", [26]),
      (41, "", [27]),
      (42, "", [28]),
      (43, "", [29]),
      (44, "", [30]),
      (45, "", [31]),
      (46, "", [32]),
      (47, "", [33]),
      (48, "", [34]),
      (49, "", [35]),
      (50, "", [36]),
      (51, "", [37]),
      (52, "", [38]),
      (53, "", [39]),
      (54, "", [40]),
      (55, "", [41]),
      (56, "", [42]),
      (57, "", [43]),
      (58, "", [44]),
      (59, "", [45]),
      (60, "", [46]),
      (61, "", [47]),
      (62, "", [48]),
      (63, "", [49]),
      (64, "", [50]),
      (65, "", [51]),
      (68, "", [52]),
      (69, "", [53]),
      (70, "", [54]),
      (71, "", [55]),
      (72, "", [56]),
      (73, "", [57]),
      (74, "", [58]),
      (75, "", [59]),
      (76, "", [60]),
      (77, "", [61]),
      (78, "", [62]),
      (79, "", [63]),
      (80, "", [64]),
      (81, "", [65]),
      (82, "", [66]),
      (83, "", [67]),
      (84, "", [68]),
      (85, "", [69]),
      (86, "", [70]),
      (87, "", [71]),
      (88, "", [72]),
      (89, "", [73]),
      (90, "", [74]),
      (91, "", [75]),
      (92, "", [76]),
      (93, "", [77]),
      (94, "", [78]),
      (95, "", [79]),
      (96, "", [80]),
      (97, "", [81]),
      (98, "", [82]),
      (99, "", [83]),
      (101, "", [84]),
      (103, "", [85]),
      (104, "", [86]),
      (105, "", [87]),
      (106, "", [88]),
      (107, "", [89]),
      (108, "", [90]),
      (109, "", [91]),
      (110, "", [92]),
      (111, "", [93]),
      (112, "", [94]),
      (113, "", [95]),
      (114, "", [96]),
      (115, "", [97]),
      (116, "", [98]),
      (117, "", [99]),
      (118, "", [100]),
      (120, "", [101]),
      (123, "", [102]),
      (126, "", [103]),
      (128, "", [104]),
      (129, "", [105]),
      (130, "", [106]),
      (131, "", [107]),
      (132, "", [108]),
      (133, "", [109]),
      (134, "", [110]),
      (135, "", [111]),
      (136, "", [112]),
      (137, "", [113]),
      (138, "", [114]),
      (139, "", [32]),
      (140, "", [115]),
      (141, "", [116]),
      (142, "", [117]),
      (143, "", [118]),
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
