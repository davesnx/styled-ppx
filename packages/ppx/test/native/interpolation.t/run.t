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
  [@css "@property --mono100-upx5mq{syntax:\"*\";inherits:false;}"];
  [@css "@property --big-oiraf{syntax:\"*\";inherits:false;}"];
  [@css "@property --small-wdqrui{syntax:\"*\";inherits:false;}"];
  [@css "@property --small-dan5x5{syntax:\"*\";inherits:false;}"];
  [@css "@property --alpha-ccwe99{syntax:\"*\";inherits:false;}"];
  [@css "@property --alpha-16rnb3j{syntax:\"*\";inherits:false;}"];
  [@css "@property --alpha-17vrbe{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-s4afn7{syntax:\"*\";inherits:false;}"];
  [@css "@property --max-xtyrm2{syntax:\"*\";inherits:false;}"];
  [@css "@property --height-1341xf4{syntax:\"*\";inherits:false;}"];
  [@css "@property --border-nbxjzt{syntax:\"*\";inherits:false;}"];
  [@css "@property --font-unf0lu{syntax:\"*\";inherits:false;}"];
  [@css "@property --mono-skkken{syntax:\"*\";inherits:false;}"];
  [@css "@property --lh-g214qm{syntax:\"*\";inherits:false;}"];
  [@css "@property --zLevel-teomb8{syntax:\"*\";inherits:false;}"];
  [@css "@property --left-1gwxz84{syntax:\"*\";inherits:false;}"];
  [@css "@property --decorationColor-12uubjw{syntax:\"*\";inherits:false;}"];
  [@css "@property --wat-118oy8r{syntax:\"*\";inherits:false;}"];
  [@css "@property --externalImageUrl-10jrnnq{syntax:\"*\";inherits:false;}"];
  [@css "@property --h-2qyvos{syntax:\"*\";inherits:false;}"];
  [@css "@property --v-544rwq{syntax:\"*\";inherits:false;}"];
  [@css "@property --blur-y62541{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1f0urcz{syntax:\"*\";inherits:false;}"];
  [@css "@property --blue-1m768d4{syntax:\"*\";inherits:false;}"];
  [@css "@property --h-fg9gkh{syntax:\"*\";inherits:false;}"];
  [@css "@property --v-16vw98j{syntax:\"*\";inherits:false;}"];
  [@css "@property --blur-1yzs36n{syntax:\"*\";inherits:false;}"];
  [@css "@property --spread-2oasqo{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-f96azg{syntax:\"*\";inherits:false;}"];
  [@css "@property --spread-1abttt8{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-d09mb5{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation-19ylivs{syntax:\"*\";inherits:false;}"];
  [@css "@property --clip-1k0oi5{syntax:\"*\";inherits:false;}"];
  [@css "@property --duration-13emtmx{syntax:\"*\";inherits:false;}"];
  [@css "@property --state-74f0u5{syntax:\"*\";inherits:false;}"];
  [@css "@property --px30-l4073o{syntax:\"*\";inherits:false;}"];
  [@css "@property --red-ys42y2{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_a7faVZOMq",
        ["._a7faVZOMq{color:var(--mono100-upx5mq);}"],
        1,
        0,
        1,
        [("value", "aVZOMq", "val\\07f\\0& | \\0color:$(mono100)")],
      ),
      (
        "_act-2rk18",
        ["._act-2rk18{margin:var(--big-oiraf) var(--small-wdqrui);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "-2rk18",
            "val\\0ct\\0& | \\0margin:$(Size.big) $(Size.small)",
          ),
        ],
      ),
      (
        "_afyacq8un",
        ["._afyacq8un{padding:var(--small-dan5x5) 0px;}"],
        1,
        0,
        4,
        [("value", "acq8un", "val\\0fy\\0& | \\0padding:$(Size.small) 0px")],
      ),
      (
        "_a50EPSRKB",
        ["._a50EPSRKB{border:1px solid var(--alpha-ccwe99);}"],
        1,
        0,
        17,
        [
          (
            "value",
            "EPSRKB",
            "val\\050\\0& | \\0border:1px solid $(Color.Border.alpha)",
          ),
        ],
      ),
      (
        "_afcFSQOMX",
        ["._afcFSQOMX{outline:1px solid var(--alpha-16rnb3j);}"],
        1,
        0,
        3,
        [
          (
            "value",
            "FSQOMX",
            "val\\0fc\\0& | \\0outline:1px solid $(Color.Border.alpha)",
          ),
        ],
      ),
      (
        "_a5dGe2sRk",
        ["._a5dGe2sRk{border-bottom:0px solid var(--alpha-17vrbe);}"],
        1,
        0,
        3,
        [
          (
            "value",
            "Ge2sRk",
            "val\\05d\\0& | \\0border-bottom:0px solid $(Color.Border.alpha)",
          ),
        ],
      ),
      (
        "_an8FHTy9P",
        ["._an8FHTy9P{width:var(--width-s4afn7);}"],
        1,
        0,
        1,
        [("value", "FHTy9P", "val\\0n8\\0& | \\0width:$(width)")],
      ),
      (
        "_adzTwjWdT",
        ["._adzTwjWdT{max-width:var(--max-xtyrm2);}"],
        1,
        0,
        1,
        [("value", "TwjWdT", "val\\0dz\\0& | \\0max-width:$(max)")],
      ),
      (
        "_abdPJ3ipR",
        ["._abdPJ3ipR{height:var(--height-1341xf4);}"],
        1,
        0,
        1,
        [("value", "PJ3ipR", "val\\0bd\\0& | \\0height:$(height)")],
      ),
      (
        "_a69O6rDBO",
        ["._a69O6rDBO{border-radius:var(--border-nbxjzt);}"],
        1,
        0,
        4,
        [("value", "O6rDBO", "val\\069\\0& | \\0border-radius:$(border)")],
      ),
      (
        "_aa8pdZyit",
        ["._aa8pdZyit{font-size:var(--font-unf0lu);}"],
        1,
        0,
        1,
        [("value", "pdZyit", "val\\0a8\\0& | \\0font-size:$(font)")],
      ),
      (
        "_aa27Jv2r8",
        ["._aa27Jv2r8{font-family:var(--mono-skkken);}"],
        1,
        0,
        1,
        [("value", "7Jv2r8", "val\\0a2\\0& | \\0font-family:$(mono)")],
      ),
      (
        "_acnJv9cHp",
        ["._acnJv9cHp{line-height:var(--lh-g214qm);}"],
        1,
        0,
        1,
        [("value", "Jv9cHp", "val\\0cn\\0& | \\0line-height:$(lh)")],
      ),
      (
        "_angdqE-9z",
        ["._angdqE-9z{z-index:var(--zLevel-teomb8);}"],
        1,
        0,
        1,
        [("value", "dqE-9z", "val\\0ng\\0& | \\0z-index:$(zLevel)")],
      ),
      (
        "_achFZQtf1",
        ["._achFZQtf1{left:var(--left-1gwxz84);}"],
        1,
        0,
        1,
        [("value", "FZQtf1", "val\\0ch\\0& | \\0left:$(left)")],
      ),
      (
        "_akwXeFIj4",
        ["._akwXeFIj4{text-decoration-color:var(--decorationColor-12uubjw);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "XeFIj4",
            "val\\0kw\\0& | \\0text-decoration-color:$(decorationColor)",
          ),
        ],
      ),
      (
        "_a4mKZX7rY",
        ["._a4mKZX7rY{background-image:var(--wat-118oy8r);}"],
        1,
        0,
        1,
        [("value", "KZX7rY", "val\\04m\\0& | \\0background-image:$(wat)")],
      ),
      (
        "_adku1OoAf",
        [
          "._adku1OoAf{-webkit-mask-image:var(--externalImageUrl-10jrnnq);mask-image:var(--externalImageUrl-10jrnnq);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "u1OoAf",
            "val\\0dk\\0& | \\0mask-image:$(externalImageUrl)",
          ),
        ],
      ),
      (
        "_all3MN4ES",
        [
          "._all3MN4ES{text-shadow:var(--h-2qyvos) var(--v-544rwq) var(--blur-y62541) var(--color-1f0urcz);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "3MN4ES",
            "val\\0ll\\0& | \\0text-shadow:$(h) $(v) $(blur) $(color)",
          ),
        ],
      ),
      (
        "_a7fmXe2d3",
        ["._a7fmXe2d3{color:var(--blue-1m768d4);}"],
        1,
        0,
        1,
        [("value", "mXe2d3", "val\\07f\\0& | \\0color:$(Theme.blue)")],
      ),
      (
        "_a70w5W3D_",
        [
          "._a70w5W3D_{box-shadow:var(--h-fg9gkh) var(--v-16vw98j) var(--blur-1yzs36n) var(--spread-2oasqo) var(--color-f96azg);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "w5W3D_",
            "val\\070\\0& | \\0box-shadow:$(h) $(v) $(blur) $(spread) $(color)",
          ),
        ],
      ),
      (
        "_a70NDT94H",
        [
          "._a70NDT94H{box-shadow:10px 10px 0px var(--spread-1abttt8) var(--color-d09mb5);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "NDT94H",
            "val\\070\\0& | \\0box-shadow:10px 10px 0px $(spread) $(color)",
          ),
        ],
      ),
      (
        "_a70DpnXNG",
        ["._a70DpnXNG{box-shadow:var(--elevation-19ylivs);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "DpnXNG",
            "val\\070\\0& | \\0box-shadow:$(BoxShadow.elevation)",
          ),
        ],
      ),
      (
        "_a70rDIiHK",
        ["._a70rDIiHK{box-shadow:none;}"],
        1,
        0,
        1,
        [("value", "rDIiHK", "val\\070\\0& | \\0box-shadow:none")],
      ),
      (
        "_aljyptZVj",
        ["._aljyptZVj{text-overflow:var(--clip-1k0oi5);}"],
        1,
        0,
        1,
        [("value", "yptZVj", "val\\0lj\\0& | \\0text-overflow:$(clip)")],
      ),
      (
        "_amdCHItCH",
        ["._amdCHItCH{transition-duration:500ms;}"],
        1,
        0,
        1,
        [("value", "CHItCH", "val\\0md\\0& | \\0transition-duration:500ms")],
      ),
      (
        "_amdv4vhwZ",
        ["._amdv4vhwZ{transition-duration:var(--duration-13emtmx);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "v4vhwZ",
            "val\\0md\\0& | \\0transition-duration:$(duration)",
          ),
        ],
      ),
      (
        "_a42HspJB_",
        [
          "._a42HspJB_{-webkit-animation-play-state:var(--state-74f0u5);animation-play-state:var(--state-74f0u5);}",
        ],
        1,
        0,
        1,
        [
          ("value", "HspJB_", "val\\042\\0& | \\0animation-play-state:$(state)"),
        ],
      ),
      (
        "_a42ZDROVB",
        [
          "._a42ZDROVB{-webkit-animation-play-state:paused;animation-play-state:paused;}",
        ],
        1,
        0,
        1,
        [("value", "ZDROVB", "val\\042\\0& | \\0animation-play-state:paused")],
      ),
      (
        "_a7ndMMBGX",
        [
          "._a7ndMMBGX{-webkit-column-gap:var(--px30-l4073o);column-gap:var(--px30-l4073o);}",
        ],
        1,
        0,
        1,
        [("value", "dMMBGX", "val\\07n\\0& | \\0column-gap:$(Size.px30)")],
      ),
      (
        "_a354smw0d",
        ["._a354smw0d{-webkit-text-fill-color:var(--red-ys42y2);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "4smw0d",
            "val\\035\\0& | \\0-webkit-text-fill-color:$(Color.red)",
          ),
        ],
      ),
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
      "_a7faVZOMq",
      [("--mono100-upx5mq", CSS.Types.Color.toString(mono100))],
    );
  let _ =
    CSS.make(
      "_act-2rk18",
      [
        ("--big-oiraf", CSS.Types.Margin.toString(Size.big)),
        ("--small-wdqrui", CSS.Types.Margin.toString(Size.small)),
      ],
    );
  let _ =
    CSS.make(
      "_a7faVZOMq",
      [("--mono100-upx5mq", CSS.Types.Color.toString(mono100))],
    );
  let _ =
    CSS.make(
      "_afyacq8un",
      [("--small-dan5x5", CSS.Types.Padding.toString(Size.small))],
    );
  let _ =
    CSS.make(
      "_a50EPSRKB",
      [("--alpha-ccwe99", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "_afcFSQOMX",
      [("--alpha-16rnb3j", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "_a5dGe2sRk",
      [("--alpha-17vrbe", CSS.Types.Color.toString(Color.Border.alpha))],
    );
  let _ =
    CSS.make(
      "_an8FHTy9P",
      [("--width-s4afn7", CSS.Types.Width.toString(width))],
    );
  let _ =
    CSS.make(
      "_adzTwjWdT",
      [("--max-xtyrm2", CSS.Types.MaxWidth.toString(max))],
    );
  let _ =
    CSS.make(
      "_abdPJ3ipR",
      [("--height-1341xf4", CSS.Types.Height.toString(height))],
    );
  let _ =
    CSS.make(
      "_a69O6rDBO",
      [("--border-nbxjzt", CSS.Types.BorderRadius.toString(border))],
    );
  let _ =
    CSS.make(
      "_aa8pdZyit",
      [("--font-unf0lu", CSS.Types.FontSize.toString(font))],
    );
  let _ =
    CSS.make(
      "_aa27Jv2r8",
      [("--mono-skkken", CSS.Types.FontFamilies.toString(mono))],
    );
  let _ =
    CSS.make(
      "_acnJv9cHp",
      [("--lh-g214qm", CSS.Types.LineHeight.toString(lh))],
    );
  let _ =
    CSS.make(
      "_angdqE-9z",
      [("--zLevel-teomb8", CSS.Types.ZIndex.toString(zLevel))],
    );
  let _ =
    CSS.make(
      "_achFZQtf1",
      [("--left-1gwxz84", CSS.Types.Left.toString(left))],
    );
  let _ =
    CSS.make(
      "_akwXeFIj4",
      [
        (
          "--decorationColor-12uubjw",
          CSS.Types.Color.toString(decorationColor),
        ),
      ],
    );
  let _ =
    CSS.make(
      "_a4mKZX7rY",
      [("--wat-118oy8r", CSS.Types.BackgroundImage.toString(wat))],
    );
  let _ =
    CSS.make(
      "_adku1OoAf",
      [
        (
          "--externalImageUrl-10jrnnq",
          CSS.Types.MaskImage.toString(externalImageUrl),
        ),
      ],
    );
  let _ =
    CSS.make(
      "_all3MN4ES",
      [
        ("--h-2qyvos", CSS.Types.Length.toString(h)),
        ("--v-544rwq", CSS.Types.Length.toString(v)),
        ("--blur-y62541", CSS.Types.Length.toString(blur)),
        ("--color-1f0urcz", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "_a7fmXe2d3",
      [("--blue-1m768d4", CSS.Types.Color.toString(Theme.blue))],
    );
  let _ =
    CSS.make(
      "_a70w5W3D_",
      [
        ("--h-fg9gkh", CSS.Types.Length.toString(h)),
        ("--v-16vw98j", CSS.Types.Length.toString(v)),
        ("--blur-1yzs36n", CSS.Types.Length.toString(blur)),
        ("--spread-2oasqo", CSS.Types.Length.toString(spread)),
        ("--color-f96azg", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "_a70NDT94H",
      [
        ("--spread-1abttt8", CSS.Types.Length.toString(spread)),
        ("--color-d09mb5", CSS.Types.Color.toString(color)),
      ],
    );
  let _ =
    CSS.make(
      "_a70DpnXNG",
      [
        (
          "--elevation-19ylivs",
          CSS.Types.BoxShadows.toString(BoxShadow.elevation),
        ),
      ],
    );
  let _ = CSS.make("_a70rDIiHK", []);
  let _ =
    CSS.make(
      "_aljyptZVj",
      [("--clip-1k0oi5", CSS.Types.TextOverflow.toString(clip))],
    );
  let _ = CSS.make("_amdCHItCH", []);
  let _ =
    CSS.make(
      "_amdv4vhwZ",
      [
        ("--duration-13emtmx", CSS.Types.TransitionDuration.toString(duration)),
      ],
    );
  let _ =
    CSS.make(
      "_a42HspJB_",
      [("--state-74f0u5", CSS.Types.AnimationPlayState.toString(state))],
    );
  let _ = CSS.make("_a42ZDROVB", []);
  let _ =
    CSS.make(
      "_a7ndMMBGX",
      [("--px30-l4073o", CSS.Types.Gap.toString(Size.px30))],
    );
  let _ =
    CSS.make(
      "_a354smw0d",
      [("--red-ys42y2", CSS.Types.WebkitTextFillColor.toString(Color.red))],
    );
