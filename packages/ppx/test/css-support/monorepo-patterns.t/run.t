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
  [@css ".css-tjsoaq{transition:all 200ms ease 0ms;}"];
  [@css ".css-9an52v{transition:all 300ms ease-in-out 0ms;}"];
  [@css ".css-9gb0kb{transition:opacity 300ms ease-in-out 0ms;}"];
  [@css ".css-1d2ga4{transition:left 0.15s;}"];
  [@css ".css-9lk53a{transition:opacity 0.5s ease-in-out;}"];
  [@css
    ".css-1hwm8mm{transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;}"
  ];
  [@css
    ".css-1dfmtix{transition:width 200ms ease, height 200ms ease, background-color 200ms ease;}"
  ];
  [@css ".css-2jhocq{transition:transform 0.3s;}"];
  [@css ".css-z1xaab{box-shadow:inset 0 -1px 0 0 var(--lineAlpha-14x2350);}"];
  [@css ".css-k42oj0{box-shadow:inset 1px 0 0 0 var(--line-16iaxxw);}"];
  [@css
    ".css-jfxwmt{box-shadow:inset 0 0 0 1000px var(--selectedMuted-coapl4);}"
  ];
  [@css ".css-lirt76{box-shadow:inset 0 0 0 0.5px var(--flag-r97mq);}"];
  [@css
    ".css-1iayzvr{box-shadow:0 0 0 1px var(--elevation1-10w4q1l), 0 1px 0 0 var(--elevation1Bottom-1jgyvpw);}"
  ];
  [@css
    ".css-13ydyrw{box-shadow:0 0 0 1px var(--border-16e6nb4), 0 2px 4px 0 var(--elevation2-a9z6ve);}"
  ];
  [@css
    ".css-1ga3v0v{box-shadow:0 0 0 1px var(--border-1pvcfai), 0 3px 18px 0 var(--elevation3-u89uz4);}"
  ];
  [@css
    ".css-w2f2bw{box-shadow:1px 0 0 0 var(--line-1fm6v6v_1), inset 1px 0 0 0 var(--line-1fm6v6v_2), inset 0 -1px 0 0 var(--line-1fm6v6v_3);}"
  ];
  [@css
    ".css-uatfq{box-shadow:inset 0 1px 0 0 var(--line-110y8m6_1), inset 0 -1px 0 0 var(--line-110y8m6_2);}"
  ];
  [@css ".css-k4sr4i{box-shadow:0 1px 3px 0 rgba(0, 0, 0, 0.1);}"];
  [@css ".css-2ptrw{box-shadow:0px 0px 1px 0 rgba(255, 255, 255, 0.5);}"];
  [@css
    ".css-itknjr{box-shadow:0px 1px 1px 0px rgba(49, 46, 29, 0.06), 0px 2px 2px 0px rgba(49, 46, 29, 0.04), 0px 4px 3px 0px rgba(49, 46, 29, 0.02);}"
  ];
  [@css
    ".css-x09jpc{box-shadow:0 0 0 1px var(--elevation1-s7j1om), 0 3px 18px 0 var(--elevation3-1tt1uog);}"
  ];
  [@css ".css-1q2o3yi{border:1px solid var(--line-10u4hbk);}"];
  [@css ".css-192yc9x{border:0px none transparent;}"];
  [@css ".css-11h9vd4{border-top:1px solid var(--line-17j5in5);}"];
  [@css ".css-pkcjyn{border-bottom:1px solid var(--line-jfym6t);}"];
  [@css ".css-1ry65jw{border-left:1px solid var(--line-2dnuub);}"];
  [@css ".css-ypjvaq{border-right:1px solid var(--line-doha9t);}"];
  [@css ".css-1ismcmj{border:1px dashed var(--line-uf1ggy);}"];
  [@css ".css-150towz{border:1px none var(--line-1i61so0);}"];
  [@css ".css-188ct1l{outline:1px solid var(--line-18cgk19);}"];
  [@css ".css-1xnyi32{outline:2px solid var(--accent-1w0inj7);}"];
  [@css
    ".css-w1ep28{-webkit-animation:helpMenuFadeIn 0.18s ease-in-out forwards;animation:helpMenuFadeIn 0.18s ease-in-out forwards;}"
  ];
  [@css
    ".css-d9hwlt{-webkit-animation:helpMenuFadeOut 0.08s ease-out forwards;animation:helpMenuFadeOut 0.08s ease-out forwards;}"
  ];
  [@css
    ".css-1ir9788{transition:height 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94), opacity 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);}"
  ];
  [@css
    ".css-fwdrfx{transition:height 0.6s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.6s cubic-bezier(0.4, 0, 0.2, 1);}"
  ];
  [@css ".css-qg0an3{box-shadow:inset 1px 0 0 0 transparent  !important;}"];
  [@css ".css-etybat{box-shadow:1px 0 0 0 black  !important;}"];
  [@css
    ".css-96uk0n{box-shadow:1px 0 0 0 var(--line-p27yoa_1), inset 0 -1px 0 0 var(--line-p27yoa_2)  !important;}"
  ];
  [@css ".css-1vsc0qv{transition:transform 0.3s  !important;}"];
  module Color = {
    module Border = {
      let line = `rgba((0, 0, 0, `num(0.1)));
      let lineAlpha = `rgba((0, 0, 0, `num(0.05)));
      let accent = `rgba((0, 0, 255, `num(0.5)));
    };
    module Shadow = {
      let elevation1 = `rgba((0, 0, 0, `num(0.03)));
      let elevation1Bottom = `rgba((0, 0, 0, `num(0.06)));
      let elevation2 = `rgba((0, 0, 0, `num(0.1)));
      let border = `rgba((0, 0, 0, `num(0.08)));
      let elevation3 = `rgba((0, 0, 0, `num(0.15)));
      let flag = `rgba((0, 0, 0, `num(0.2)));
    };
    module Background = {
      let selectedMuted = `hex("f5f5f5");
    };
  };
  
  CSS.make("css-tjsoaq", []);
  CSS.make("css-9an52v", []);
  CSS.make("css-9gb0kb", []);
  
  CSS.make("css-1d2ga4", []);
  CSS.make("css-9lk53a", []);
  CSS.make("css-1hwm8mm", []);
  CSS.make("css-1dfmtix", []);
  CSS.make("css-2jhocq", []);
  
  CSS.make(
    "css-z1xaab",
    [
      ("--lineAlpha-14x2350", CSS.Types.Color.toString(Color.Border.lineAlpha)),
    ],
  );
  CSS.make(
    "css-k42oj0",
    [("--line-16iaxxw", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-jfxwmt",
    [
      (
        "--selectedMuted-coapl4",
        CSS.Types.Color.toString(Color.Background.selectedMuted),
      ),
    ],
  );
  CSS.make(
    "css-lirt76",
    [("--flag-r97mq", CSS.Types.Color.toString(Color.Shadow.flag))],
  );
  
  CSS.make(
    "css-1iayzvr",
    [
      (
        "--elevation1-10w4q1l",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
      (
        "--elevation1Bottom-1jgyvpw",
        CSS.Types.Color.toString(Color.Shadow.elevation1Bottom),
      ),
    ],
  );
  CSS.make(
    "css-13ydyrw",
    [
      ("--border-16e6nb4", CSS.Types.Color.toString(Color.Shadow.border)),
      (
        "--elevation2-a9z6ve",
        CSS.Types.Color.toString(Color.Shadow.elevation2),
      ),
    ],
  );
  CSS.make(
    "css-1ga3v0v",
    [
      ("--border-1pvcfai", CSS.Types.Color.toString(Color.Shadow.border)),
      (
        "--elevation3-u89uz4",
        CSS.Types.Color.toString(Color.Shadow.elevation3),
      ),
    ],
  );
  
  CSS.make(
    "css-w2f2bw",
    [
      ("--line-1fm6v6v_1", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-1fm6v6v_2", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-1fm6v6v_3", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  CSS.make(
    "css-uatfq",
    [
      ("--line-110y8m6_1", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-110y8m6_2", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  
  CSS.make("css-k4sr4i", []);
  CSS.make("css-2ptrw", []);
  CSS.make("css-itknjr", []);
  CSS.make(
    "css-x09jpc",
    [
      (
        "--elevation1-s7j1om",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
      (
        "--elevation3-1tt1uog",
        CSS.Types.Color.toString(Color.Shadow.elevation3),
      ),
    ],
  );
  
  CSS.make(
    "css-1q2o3yi",
    [("--line-10u4hbk", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make("css-192yc9x", []);
  CSS.make(
    "css-11h9vd4",
    [("--line-17j5in5", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-pkcjyn",
    [("--line-jfym6t", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-1ry65jw",
    [("--line-2dnuub", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-ypjvaq",
    [("--line-doha9t", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-1ismcmj",
    [("--line-uf1ggy", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-150towz",
    [("--line-1i61so0", CSS.Types.Color.toString(Color.Border.line))],
  );
  
  CSS.make(
    "css-188ct1l",
    [("--line-18cgk19", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-1xnyi32",
    [("--accent-1w0inj7", CSS.Types.Color.toString(Color.Border.accent))],
  );
  
  CSS.make("css-w1ep28", []);
  CSS.make("css-d9hwlt", []);
  
  CSS.make("css-1ir9788", []);
  CSS.make("css-fwdrfx", []);
  
  CSS.make("css-qg0an3", []);
  CSS.make("css-etybat", []);
  CSS.make(
    "css-96uk0n",
    [
      ("--line-p27yoa_1", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-p27yoa_2", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  
  CSS.make("css-1vsc0qv", []);
  
  let _shadow1: CSS.Shadow.box =
    CSS.Shadow.box(~blur=`px(100), `hex("000000"), ~inset=true);
  let _shadow2: array(CSS.Shadow.box) = [|
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`zero,
      ~blur=`px(4),
      `rgba((0, 0, 0, `num(0.1))),
    ),
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`px(6),
      ~blur=`px(15),
      `rgba((0, 0, 0, `num(0.2))),
    ),
  |];
