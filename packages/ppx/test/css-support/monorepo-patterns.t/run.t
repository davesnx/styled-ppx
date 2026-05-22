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
  [@css ".css-z1xaab{box-shadow:inset 0 -1px 0 0 var(--var-7x9dgm);}"];
  [@css ".css-k42oj0{box-shadow:inset 1px 0 0 0 var(--var-4l273w);}"];
  [@css ".css-jfxwmt{box-shadow:inset 0 0 0 1000px var(--var-15yyrku);}"];
  [@css ".css-lirt76{box-shadow:inset 0 0 0 0.5px var(--var-12ajsvb);}"];
  [@css
    ".css-1iayzvr{box-shadow:0 0 0 1px var(--var-p8dwuy), 0 1px 0 0 var(--var-6k6bpa);}"
  ];
  [@css
    ".css-13ydyrw{box-shadow:0 0 0 1px var(--var-1t7nw4v), 0 2px 4px 0 var(--var-d7m6uh);}"
  ];
  [@css
    ".css-1ga3v0v{box-shadow:0 0 0 1px var(--var-1t7nw4v), 0 3px 18px 0 var(--var-w61tw4);}"
  ];
  [@css
    ".css-w2f2bw{box-shadow:1px 0 0 0 var(--var-4l273w_1), inset 1px 0 0 0 var(--var-4l273w_2), inset 0 -1px 0 0 var(--var-4l273w_3);}"
  ];
  [@css
    ".css-uatfq{box-shadow:inset 0 1px 0 0 var(--var-4l273w_1), inset 0 -1px 0 0 var(--var-4l273w_2);}"
  ];
  [@css ".css-k4sr4i{box-shadow:0 1px 3px 0 rgba(0, 0, 0, 0.1);}"];
  [@css ".css-2ptrw{box-shadow:0px 0px 1px 0 rgba(255, 255, 255, 0.5);}"];
  [@css
    ".css-itknjr{box-shadow:0px 1px 1px 0px rgba(49, 46, 29, 0.06), 0px 2px 2px 0px rgba(49, 46, 29, 0.04), 0px 4px 3px 0px rgba(49, 46, 29, 0.02);}"
  ];
  [@css
    ".css-x09jpc{box-shadow:0 0 0 1px var(--var-p8dwuy), 0 3px 18px 0 var(--var-w61tw4);}"
  ];
  [@css ".css-1q2o3yi{border:1px solid var(--var-4l273w);}"];
  [@css ".css-192yc9x{border:0px none transparent;}"];
  [@css ".css-11h9vd4{border-top:1px solid var(--var-4l273w);}"];
  [@css ".css-pkcjyn{border-bottom:1px solid var(--var-4l273w);}"];
  [@css ".css-1ry65jw{border-left:1px solid var(--var-4l273w);}"];
  [@css ".css-ypjvaq{border-right:1px solid var(--var-4l273w);}"];
  [@css ".css-1ismcmj{border:1px dashed var(--var-4l273w);}"];
  [@css ".css-150towz{border:1px none var(--var-4l273w);}"];
  [@css ".css-188ct1l{outline:1px solid var(--var-4l273w);}"];
  [@css ".css-1xnyi32{outline:2px solid var(--var-1i6pwrx);}"];
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
    ".css-96uk0n{box-shadow:1px 0 0 0 var(--var-4l273w_1), inset 0 -1px 0 0 var(--var-4l273w_2)  !important;}"
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
    [("--var-7x9dgm", CSS.Types.Color.toString(Color.Border.lineAlpha))],
  );
  CSS.make(
    "css-k42oj0",
    [("--var-4l273w", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-jfxwmt",
    [
      (
        "--var-15yyrku",
        CSS.Types.Color.toString(Color.Background.selectedMuted),
      ),
    ],
  );
  CSS.make(
    "css-lirt76",
    [("--var-12ajsvb", CSS.Types.Color.toString(Color.Shadow.flag))],
  );
  
  CSS.make(
    "css-1iayzvr",
    [
      ("--var-p8dwuy", CSS.Types.Color.toString(Color.Shadow.elevation1)),
      (
        "--var-6k6bpa",
        CSS.Types.Color.toString(Color.Shadow.elevation1Bottom),
      ),
    ],
  );
  CSS.make(
    "css-13ydyrw",
    [
      ("--var-1t7nw4v", CSS.Types.Color.toString(Color.Shadow.border)),
      ("--var-d7m6uh", CSS.Types.Color.toString(Color.Shadow.elevation2)),
    ],
  );
  CSS.make(
    "css-1ga3v0v",
    [
      ("--var-1t7nw4v", CSS.Types.Color.toString(Color.Shadow.border)),
      ("--var-w61tw4", CSS.Types.Color.toString(Color.Shadow.elevation3)),
    ],
  );
  
  CSS.make(
    "css-w2f2bw",
    [
      ("--var-4l273w_1", CSS.Types.Color.toString(Color.Border.line)),
      ("--var-4l273w_2", CSS.Types.Color.toString(Color.Border.line)),
      ("--var-4l273w_3", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  CSS.make(
    "css-uatfq",
    [
      ("--var-4l273w_1", CSS.Types.Color.toString(Color.Border.line)),
      ("--var-4l273w_2", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  
  CSS.make("css-k4sr4i", []);
  CSS.make("css-2ptrw", []);
  CSS.make("css-itknjr", []);
  CSS.make(
    "css-x09jpc",
    [
      ("--var-p8dwuy", CSS.Types.Color.toString(Color.Shadow.elevation1)),
      ("--var-w61tw4", CSS.Types.Color.toString(Color.Shadow.elevation3)),
    ],
  );
  
  CSS.make(
    "css-1q2o3yi",
    [("--var-4l273w", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make("css-192yc9x", []);
  CSS.make(
    "css-11h9vd4",
    [("--var-4l273w", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-pkcjyn",
    [("--var-4l273w", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-1ry65jw",
    [("--var-4l273w", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-ypjvaq",
    [("--var-4l273w", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-1ismcmj",
    [("--var-4l273w", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-150towz",
    [("--var-4l273w", CSS.Types.Color.toString(Color.Border.line))],
  );
  
  CSS.make(
    "css-188ct1l",
    [("--var-4l273w", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "css-1xnyi32",
    [("--var-1i6pwrx", CSS.Types.Color.toString(Color.Border.accent))],
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
      ("--var-4l273w_1", CSS.Types.Color.toString(Color.Border.line)),
      ("--var-4l273w_2", CSS.Types.Color.toString(Color.Border.line)),
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
