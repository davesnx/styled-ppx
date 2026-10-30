Interpolation native PPX transformations are checked as a cram snapshot.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx -- -no-merge)))
  > EOF

  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "@property --mono100-mn2jt5{syntax:\"*\";inherits:false;}"];
  [@css "@property --big-1c1caa8{syntax:\"*\";inherits:false;}"];
  [@css "@property --small-1tsw5sh{syntax:\"*\";inherits:false;}"];
  [@css "@property --small-1d5k27v{syntax:\"*\";inherits:false;}"];
  [@css "@property --alpha-vlpuld{syntax:\"*\";inherits:false;}"];
  [@css "@property --alpha-1ftvcb4{syntax:\"*\";inherits:false;}"];
  [@css "@property --alpha-1y5ijmp{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-18c1xss{syntax:\"*\";inherits:false;}"];
  [@css "@property --max-1yrxnfd{syntax:\"*\";inherits:false;}"];
  [@css "@property --height-1n9troi{syntax:\"*\";inherits:false;}"];
  [@css "@property --border-8yt3ey{syntax:\"*\";inherits:false;}"];
  [@css "@property --font-10lt5gt{syntax:\"*\";inherits:false;}"];
  [@css "@property --mono-e5legw{syntax:\"*\";inherits:false;}"];
  [@css "@property --lh-uai7u3{syntax:\"*\";inherits:false;}"];
  [@css "@property --zLevel-vut76j{syntax:\"*\";inherits:false;}"];
  [@css "@property --left-1s2hr3z{syntax:\"*\";inherits:false;}"];
  [@css "@property --decorationColor-seqvqc{syntax:\"*\";inherits:false;}"];
  [@css "@property --wat-tevp0f{syntax:\"*\";inherits:false;}"];
  [@css "@property --externalImageUrl-75mq6y{syntax:\"*\";inherits:false;}"];
  [@css "@property --h-ulszyz{syntax:\"*\";inherits:false;}"];
  [@css "@property --v-1rucg2y{syntax:\"*\";inherits:false;}"];
  [@css "@property --blur-n5ddfa{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1jwocqc{syntax:\"*\";inherits:false;}"];
  [@css "@property --blue-uz6p3q{syntax:\"*\";inherits:false;}"];
  [@css "@property --h-1cxj5q6{syntax:\"*\";inherits:false;}"];
  [@css "@property --v-1p9ysn0{syntax:\"*\";inherits:false;}"];
  [@css "@property --blur-1rsz8mu{syntax:\"*\";inherits:false;}"];
  [@css "@property --spread-1icix4c{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1eos5hw{syntax:\"*\";inherits:false;}"];
  [@css "@property --spread-wd13u2{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-3xubcm{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation-jhhehb{syntax:\"*\";inherits:false;}"];
  [@css "@property --clip-1go0jdu{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-i5tvzn{syntax:\"*\";inherits:false;}"];
  [@css "@property --state-1yj1w6c{syntax:\"*\";inherits:false;}"];
  [@css "@property --px30-cc29mn{syntax:\"*\";inherits:false;}"];
  [@css "@property --red-w69rb9{syntax:\"*\";inherits:false;}"];
  [@css
    (
      "._a_4enh4f{color:var(--mono100-mn2jt5);}",
      "_a_4enh4f",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7pitjj{margin:var(--big-1c1caa8) var(--small-1tsw5sh);}",
      "_a_7pitjj",
      "0,1,0 own",
      "277",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_94pp3j{padding:var(--small-1d5k27v) 0px;}",
      "_a_94pp3j",
      "0,1,0 own",
      "328",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_3h97be{border:1px solid var(--alpha-vlpuld);}",
      "_a_3h97be",
      "0,1,0 own",
      "125",
      131071,
      false,
    )
  ];
  [@css
    (
      "._a_8pyj1z{outline:1px solid var(--alpha-1ftvcb4);}",
      "_a_8pyj1z",
      "0,1,0 own",
      "313",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_3h0007w55u{border-bottom:0px solid var(--alpha-1y5ijmp);}",
      "_a_3h0007w55u",
      "0,1,0 own",
      "125",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_eckyy8{width:var(--width-18c1xss);}",
      "_a_eckyy8",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_88nebp{max-width:var(--max-1yrxnfd);}",
      "_a_88nebp",
      "0,1,0 own",
      "296",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6lvooa{height:var(--height-1n9troi);}",
      "_a_6lvooa",
      "0,1,0 own",
      "237",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3nd0d4{border-radius:var(--border-8yt3ey);}",
      "_a_3nd0d4",
      "0,1,0 own",
      "131",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_65000wu0qi{font-size:var(--font-10lt5gt);}",
      "_a_65000wu0qi",
      "0,1,0 own",
      "221",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_650001szir{font-family:var(--mono-e5legw);}",
      "_a_650001szir",
      "0,1,0 own",
      "221",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_65b8jkfd7x{line-height:var(--lh-uai7u3);}",
      "_a_65b8jkfd7x",
      "0,1,0 own",
      "221",
      524288,
      false,
    )
  ];
  [@css
    (
      "._a_ekfgx3{z-index:var(--zLevel-vut76j);}",
      "_a_ekfgx3",
      "0,1,0 own",
      "524",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_710002egw0{left:var(--left-1s2hr3z);}",
      "_a_710002egw0",
      "0,1,0 own",
      "253",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_cf00018kmj{text-decoration-color:var(--decorationColor-seqvqc);}",
      "_a_cf00018kmj",
      "0,1,0 own",
      "447",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_390008o5gx{background-image:var(--wat-tevp0f);}",
      "_a_390008o5gx",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_7y0074nm6u{-webkit-mask-image:var(--externalImageUrl-75mq6y);mask-image:var(--externalImageUrl-75mq6y);}",
      "_a_7y0074nm6u",
      "0,1,0 own",
      "286",
      256,
      false,
    )
  ];
  [@css
    (
      "._a_cy50p4{text-shadow:var(--h-ulszyz) var(--v-1rucg2y) var(--blur-n5ddfa) var(--color-1jwocqc);}",
      "_a_cy50p4",
      "0,1,0 own",
      "466",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4e2giy{color:var(--blue-uz6p3q);}",
      "_a_4e2giy",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_40ihb6{box-shadow:var(--h-1cxj5q6) var(--v-1p9ysn0) var(--blur-1rsz8mu) var(--spread-1icix4c) var(--color-1eos5hw);}",
      "_a_40ihb6",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_40s4zv{box-shadow:10px 10px 0px var(--spread-wd13u2) var(--color-3xubcm);}",
      "_a_40s4zv",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_40l5g5{box-shadow:var(--elevation-jhhehb);}",
      "_a_40l5g5",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    ("._a_40keqi{box-shadow:none;}", "_a_40keqi", "0,1,0 own", "144", 1, false)
  ];
  [@css
    (
      "._a_cwbaal{text-overflow:var(--clip-1go0jdu);}",
      "_a_cwbaal",
      "0,1,0 own",
      "464",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dm00048edy{transition-duration:500ms;}",
      "_a_dm00048edy",
      "0,1,0 own",
      "490",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_dm00046hu1{transition-duration:var(--duration-i5tvzn);}",
      "_a_dm00046hu1",
      "0,1,0 own",
      "490",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_2z003ken0s{-webkit-animation-play-state:var(--state-1yj1w6c);animation-play-state:var(--state-1yj1w6c);}",
      "_a_2z003ken0s",
      "0,1,0 own",
      "107",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_2z003kbnre{-webkit-animation-play-state:paused;animation-play-state:paused;}",
      "_a_2z003kbnre",
      "0,1,0 own",
      "107",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_6f0001nyl9{-webkit-column-gap:var(--px30-cc29mn);column-gap:var(--px30-cc29mn);}",
      "_a_6f0001nyl9",
      "0,1,0 own",
      "231",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_2k9yln{-webkit-text-fill-color:var(--red-w69rb9);}",
      "_a_2k9yln",
      "0,1,0 own",
      "92",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (52, "", [37]),
      (53, "", [38]),
      (54, "", [37]),
      (55, "", [39]),
      (56, "", [40]),
      (57, "", [41]),
      (58, "", [42]),
      (59, "", [43]),
      (60, "", [44]),
      (61, "", [45]),
      (62, "", [46]),
      (63, "", [47]),
      (64, "", [48]),
      (65, "", [49]),
      (66, "", [50]),
      (67, "", [51]),
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
    ]
  ];
  module Size = {
    let big = `px(24);
    let small = `px(8);
    let px30 = `px(30);
  };
  
  module Color = {
    module Border = {
      let alpha = CSS.rgba(0, 0, 0, `num(0.4));
    };
  
    let red = "red";
  };
  
  module Theme = {
    let blue = CSS.hex("00f");
  };
  
  module BoxShadow = {
    let elevation = [|
      CSS.Shadow.box(~x=`px(1), ~y=`px(2), ~blur=`px(3), CSS.hex("000")),
    |];
  };
  
  let mono100 = CSS.hex("fefefe");
  let width = `px(100);
  let max = `px(200);
  let height = `px(80);
  let border = `px(4);
  let font = `px(16);
  let mono: array(CSS.Types.FontFamilyName.t) = [|`quoted("Mono")|];
  let lh = `abs(1.5);
  let zLevel = `num(10);
  let left = `px(12);
  let decorationColor = CSS.hex("ccc");
  let wat = `url("background.png");
  let externalImageUrl = `url("mask.svg");
  let h = `px(1);
  let v = `px(2);
  let blur = `px(3);
  let spread = `px(4);
  let color = CSS.hex("000");
  let clip = `clip;
  let duration = `ms(200);
  let state = `running;
  
  let _ =
    CSS.make(
      "_a_4enh4f",
      [("--mono100-mn2jt5", CSS.Types.Color.toString(mono100))],
    );
  let _ =
    CSS.make(
      "_a_7pitjj",
      [
        ("--big-1c1caa8", CSS.Types.Margin.toString(Size.big)),
        ("--small-1tsw5sh", CSS.Types.Margin.toString(Size.small)),
      ],
    );
  let _ =
    CSS.make(
      "_a_4enh4f",
      [("--mono100-mn2jt5", CSS.Types.Color.toString(mono100))],
    );
  let _ =
    CSS.make(
      "_a_94pp3j",
      [("--small-1d5k27v", CSS.Types.Padding.toString(Size.small))],
    );
  let _ =
    CSS.make(
      "_a_3h97be",
      [("--alpha-vlpuld", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "_a_8pyj1z",
      [("--alpha-1ftvcb4", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "_a_3h0007w55u",
      [("--alpha-1y5ijmp", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "_a_eckyy8",
      [("--width-18c1xss", CSS.Types.Width.toString(width))],
    );
  let _ =
    CSS.make(
      "_a_88nebp",
      [("--max-1yrxnfd", CSS.Types.MaxWidth.toString(max))],
    );
  let _ =
    CSS.make(
      "_a_6lvooa",
      [("--height-1n9troi", CSS.Types.Height.toString(height))],
    );
  let _ =
    CSS.make(
      "_a_3nd0d4",
      [("--border-8yt3ey", CSS.Types.BorderRadius.toString(border))],
    );
  let _ =
    CSS.make(
      "_a_65000wu0qi",
      [("--font-10lt5gt", CSS.Types.FontSize.toString(font))],
    );
  let _ =
    CSS.make(
      "_a_650001szir",
      [("--mono-e5legw", CSS.Types.FontFamilies.toString(mono))],
    );
  let _ =
    CSS.make(
      "_a_65b8jkfd7x",
      [("--lh-uai7u3", CSS.Types.LineHeight.toString(lh))],
    );
  let _ =
    CSS.make(
      "_a_ekfgx3",
      [("--zLevel-vut76j", CSS.Types.ZIndex.toString(zLevel))],
    );
  let _ =
    CSS.make(
      "_a_710002egw0",
      [("--left-1s2hr3z", CSS.Types.Left.toString(left))],
    );
  let _ =
    CSS.make(
      "_a_cf00018kmj",
      [
        ("--decorationColor-seqvqc", CSS.Types.Color.toString(decorationColor)),
      ],
    );
  let _ =
    CSS.make(
      "_a_390008o5gx",
      [("--wat-tevp0f", CSS.Types.BackgroundImage.toString(wat))],
    );
  let _ =
    CSS.make(
      "_a_7y0074nm6u",
      [
        (
          "--externalImageUrl-75mq6y",
          CSS.Types.MaskImage.toString(externalImageUrl),
        ),
      ],
    );
  let _ =
    CSS.make(
      "_a_cy50p4",
      [
        ("--h-ulszyz", CSS.Types.Length.toString(h)),
        ("--v-1rucg2y", CSS.Types.Length.toString(v)),
        ("--blur-n5ddfa", CSS.Types.Length.toString(blur)),
        ("--color-1jwocqc", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "_a_4e2giy",
      [("--blue-uz6p3q", CSS.Types.Color.toString(Theme.blue))],
    );
  let _ =
    CSS.make(
      "_a_40ihb6",
      [
        ("--h-1cxj5q6", CSS.Types.Length.toString(h)),
        ("--v-1p9ysn0", CSS.Types.Length.toString(v)),
        ("--blur-1rsz8mu", CSS.Types.Length.toString(blur)),
        ("--spread-1icix4c", CSS.Types.Length.toString(spread)),
        ("--color-1eos5hw", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "_a_40s4zv",
      [
        ("--spread-wd13u2", CSS.Types.Length.toString(spread)),
        ("--color-3xubcm", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "_a_40l5g5",
      [
        (
          "--elevation-jhhehb",
          CSS.Types.BoxShadows.toString(BoxShadow.elevation),
        ),
      ],
    );
  let _ = CSS.make("_a_40keqi", []);
  let _ =
    CSS.make(
      "_a_cwbaal",
      [("--clip-1go0jdu", CSS.Types.TextOverflow.toString(clip))],
    );
  let _ = CSS.make("_a_dm00048edy", []);
  let _ =
    CSS.make(
      "_a_dm00046hu1",
      [
        ("--duration-i5tvzn", CSS.Types.TransitionDuration.toString(duration)),
      ],
    );
  let _ =
    CSS.make(
      "_a_2z003ken0s",
      [("--state-1yj1w6c", CSS.Types.AnimationPlayState.toString(state))],
    );
  let _ = CSS.make("_a_2z003kbnre", []);
  let _ =
    CSS.make(
      "_a_6f0001nyl9",
      [("--px30-cc29mn", CSS.Types.Gap.toString(Size.px30))],
    );
  let _ =
    CSS.make(
      "_a_2k9yln",
      [("--red-w69rb9", CSS.Types.WebkitTextFillColor.toString(Color.red))],
    );
