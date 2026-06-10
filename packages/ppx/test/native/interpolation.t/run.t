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
  [@css ".css-vtnh4f{color:var(--var-mn2jt5);}"];
  [@css ".css-j1itjj{margin:var(--var-1c1caa8) var(--var-1tsw5sh);}"];
  [@css ".css-pupp3j{padding:var(--var-1d5k27v) 0px;}"];
  [@css ".css-11f97be{border:1px solid var(--var-vlpuld);}"];
  [@css ".css-upyj1z{outline:1px solid var(--var-1ftvcb4);}"];
  [@css ".css-19ww55u{border-bottom:0px solid var(--var-1y5ijmp);}"];
  [@css ".css-1dfkyy8{width:var(--var-18c1xss);}"];
  [@css ".css-1cgnebp{max-width:var(--var-1yrxnfd);}"];
  [@css ".css-q0vooa{height:var(--var-1n9troi);}"];
  [@css ".css-cd0d4{border-radius:var(--var-8yt3ey);}"];
  [@css ".css-gdu0qi{font-size:var(--var-10lt5gt);}"];
  [@css ".css-16nszir{font-family:var(--var-e5legw);}"];
  [@css ".css-1vyfd7x{line-height:var(--var-uai7u3);}"];
  [@css ".css-53fgx3{z-index:var(--var-vut76j);}"];
  [@css ".css-1jcegw0{left:var(--var-1s2hr3z);}"];
  [@css ".css-1p58kmj{text-decoration-color:var(--var-seqvqc);}"];
  [@css ".css-1t9o5gx{background-image:var(--var-tevp0f);}"];
  [@css
    ".css-15xnm6u{-webkit-mask-image:var(--var-75mq6y);mask-image:var(--var-75mq6y);}"
  ];
  [@css
    ".css-1a150p4{text-shadow:var(--var-ulszyz) var(--var-1rucg2y) var(--var-n5ddfa) var(--var-1jwocqc);}"
  ];
  [@css ".css-pc2giy{color:var(--var-uz6p3q);}"];
  [@css
    ".css-ixihb6{box-shadow:var(--var-1cxj5q6) var(--var-1p9ysn0) var(--var-1rsz8mu) var(--var-1icix4c) var(--var-1eos5hw);}"
  ];
  [@css
    ".css-13ts4zv{box-shadow:10px 10px 0px var(--var-wd13u2) var(--var-3xubcm);}"
  ];
  [@css ".css-lxl5g5{box-shadow:var(--var-jhhehb);}"];
  [@css ".css-gokeqi{box-shadow:none;}"];
  [@css ".css-l3baal{text-overflow:var(--var-1go0jdu);}"];
  [@css ".css-fv8edy{transition-duration:500ms;}"];
  [@css ".css-s36hu1{transition-duration:var(--var-i5tvzn);}"];
  [@css
    ".css-1bien0s{-webkit-animation-play-state:var(--var-1yj1w6c);animation-play-state:var(--var-1yj1w6c);}"
  ];
  [@css
    ".css-1i5bnre{-webkit-animation-play-state:paused;animation-play-state:paused;}"
  ];
  [@css
    ".css-x7nyl9{-webkit-column-gap:var(--var-cc29mn);column-gap:var(--var-cc29mn);}"
  ];
  [@css ".css-829yln{-webkit-text-fill-color:var(--var-w69rb9);}"];
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
      "css-vtnh4f",
      [("--var-mn2jt5", CSS.Types.Color.toString(mono100))],
    );
  let _ =
    CSS.make(
      "css-j1itjj",
      [
        ("--var-1c1caa8", CSS.Types.Margin.toString(Size.big)),
        ("--var-1tsw5sh", CSS.Types.Margin.toString(Size.small)),
      ],
    );
  let _ =
    CSS.make(
      "css-vtnh4f",
      [("--var-mn2jt5", CSS.Types.Color.toString(mono100))],
    );
  let _ =
    CSS.make(
      "css-pupp3j",
      [("--var-1d5k27v", CSS.Types.Padding.toString(Size.small))],
    );
  let _ =
    CSS.make(
      "css-11f97be",
      [("--var-vlpuld", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "css-upyj1z",
      [("--var-1ftvcb4", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "css-19ww55u",
      [("--var-1y5ijmp", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "css-1dfkyy8",
      [("--var-18c1xss", CSS.Types.Width.toString(width))],
    );
  let _ =
    CSS.make(
      "css-1cgnebp",
      [("--var-1yrxnfd", CSS.Types.MaxWidth.toString(max))],
    );
  let _ =
    CSS.make(
      "css-q0vooa",
      [("--var-1n9troi", CSS.Types.Height.toString(height))],
    );
  let _ =
    CSS.make(
      "css-cd0d4",
      [("--var-8yt3ey", CSS.Types.BorderRadius.toString(border))],
    );
  let _ =
    CSS.make(
      "css-gdu0qi",
      [("--var-10lt5gt", CSS.Types.FontSize.toString(font))],
    );
  let _ =
    CSS.make(
      "css-16nszir",
      [("--var-e5legw", CSS.Types.FontFamilies.toString(mono))],
    );
  let _ =
    CSS.make(
      "css-1vyfd7x",
      [("--var-uai7u3", CSS.Types.LineHeight.toString(lh))],
    );
  let _ =
    CSS.make(
      "css-53fgx3",
      [("--var-vut76j", CSS.Types.ZIndex.toString(zLevel))],
    );
  let _ =
    CSS.make(
      "css-1jcegw0",
      [("--var-1s2hr3z", CSS.Types.Left.toString(left))],
    );
  let _ =
    CSS.make(
      "css-1p58kmj",
      [("--var-seqvqc", CSS.Types.Color.toString(decorationColor))],
    );
  let _ =
    CSS.make(
      "css-1t9o5gx",
      [("--var-tevp0f", CSS.Types.BackgroundImage.toString(wat))],
    );
  let _ =
    CSS.make(
      "css-15xnm6u",
      [("--var-75mq6y", CSS.Types.MaskImage.toString(externalImageUrl))],
    );
  let _ =
    CSS.make(
      "css-1a150p4",
      [
        ("--var-ulszyz", CSS.Types.Length.toString(h)),
        ("--var-1rucg2y", CSS.Types.Length.toString(v)),
        ("--var-n5ddfa", CSS.Types.Length.toString(blur)),
        ("--var-1jwocqc", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "css-pc2giy",
      [("--var-uz6p3q", CSS.Types.Color.toString(Theme.blue))],
    );
  let _ =
    CSS.make(
      "css-ixihb6",
      [
        ("--var-1cxj5q6", CSS.Types.Length.toString(h)),
        ("--var-1p9ysn0", CSS.Types.Length.toString(v)),
        ("--var-1rsz8mu", CSS.Types.Length.toString(blur)),
        ("--var-1icix4c", CSS.Types.Length.toString(spread)),
        ("--var-1eos5hw", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "css-13ts4zv",
      [
        ("--var-wd13u2", CSS.Types.Length.toString(spread)),
        ("--var-3xubcm", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "css-lxl5g5",
      [("--var-jhhehb", CSS.Types.BoxShadows.toString(BoxShadow.elevation))],
    );
  let _ = CSS.make("css-gokeqi", []);
  let _ =
    CSS.make(
      "css-l3baal",
      [("--var-1go0jdu", CSS.Types.TextOverflow.toString(clip))],
    );
  let _ = CSS.make("css-fv8edy", []);
  let _ =
    CSS.make(
      "css-s36hu1",
      [("--var-i5tvzn", CSS.Types.TransitionDuration.toString(duration))],
    );
  let _ =
    CSS.make(
      "css-1bien0s",
      [("--var-1yj1w6c", CSS.Types.AnimationPlayState.toString(state))],
    );
  let _ = CSS.make("css-1i5bnre", []);
  let _ =
    CSS.make(
      "css-x7nyl9",
      [("--var-cc29mn", CSS.Types.Gap.toString(Size.px30))],
    );
  let _ =
    CSS.make(
      "css-829yln",
      [("--var-w69rb9", CSS.Types.WebkitTextFillColor.toString(Color.red))],
    );
