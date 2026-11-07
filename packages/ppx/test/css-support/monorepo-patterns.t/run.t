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
  [@css "@property --lineAlpha-1sh9rrm{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1n4cbat{syntax:\"*\";inherits:false;}"];
  [@css "@property --selectedMuted-1eqw3q8{syntax:\"*\";inherits:false;}"];
  [@css "@property --flag-r83zad{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation1-3ve4h5{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation1Bottom-1c9od9y{syntax:\"*\";inherits:false;}"];
  [@css "@property --border-g1fxhl{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation2-1yo29p{syntax:\"*\";inherits:false;}"];
  [@css "@property --border-1xmg9oz{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation3-r3xv18{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1om7wni_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1om7wni_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1om7wni_3{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1jzm6m3_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1jzm6m3_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation1-1jvm9pw{syntax:\"*\";inherits:false;}"];
  [@css "@property --elevation3-1cut2k7{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-ew7dcu{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1qlpppm{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-139iwo4{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1duigd{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-sczbf{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-3a0cs2{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-3rcwgn{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-22gjm6{syntax:\"*\";inherits:false;}"];
  [@css "@property --accent-o8d88n{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-dykbaq_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-dykbaq_2{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_amad6u9qq",
        ["._amad6u9qq{transition:all 200ms ease 0ms;}"],
        1,
        0,
        5,
        [
          ("value", "d6u9qq", "val\\0ma\\0& | \\0transition:all 200ms ease 0ms"),
        ],
      ),
      (
        "_amavwXQ9V",
        ["._amavwXQ9V{transition:all 300ms ease-in-out 0ms;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "vwXQ9V",
            "val\\0ma\\0& | \\0transition:all 300ms ease-in-out 0ms",
          ),
        ],
      ),
      (
        "_amanWVcMB",
        ["._amanWVcMB{transition:opacity 300ms ease-in-out 0ms;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "nWVcMB",
            "val\\0ma\\0& | \\0transition:opacity 300ms ease-in-out 0ms",
          ),
        ],
      ),
      (
        "_amazqDB_Y",
        ["._amazqDB_Y{transition:left 0.15s;}"],
        1,
        0,
        5,
        [("value", "zqDB_Y", "val\\0ma\\0& | \\0transition:left 0.15s")],
      ),
      (
        "_amaWlTCY1",
        ["._amaWlTCY1{transition:opacity 0.5s ease-in-out;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "WlTCY1",
            "val\\0ma\\0& | \\0transition:opacity 0.5s ease-in-out",
          ),
        ],
      ),
      (
        "_amapvYp_U",
        [
          "._amapvYp_U{transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "pvYp_U",
            "val\\0ma\\0& | \\0transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out",
          ),
        ],
      ),
      (
        "_amaP6F_Bx",
        [
          "._amaP6F_Bx{transition:width 200ms ease, height 200ms ease, background-color 200ms ease;}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "P6F_Bx",
            "val\\0ma\\0& | \\0transition:width 200ms ease, height 200ms ease, background-color 200ms ease",
          ),
        ],
      ),
      (
        "_amaQKiA5_",
        ["._amaQKiA5_{transition:transform 0.3s;}"],
        1,
        0,
        5,
        [("value", "QKiA5_", "val\\0ma\\0& | \\0transition:transform 0.3s")],
      ),
      (
        "_a70RP59tF",
        ["._a70RP59tF{box-shadow:inset 0 -1px 0 0 var(--lineAlpha-1sh9rrm);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "RP59tF",
            "val\\070\\0& | \\0box-shadow:inset 0 -1px 0 0 $(Color.Border.lineAlpha)",
          ),
        ],
      ),
      (
        "_a70ZSPp0s",
        ["._a70ZSPp0s{box-shadow:inset 1px 0 0 0 var(--line-1n4cbat);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ZSPp0s",
            "val\\070\\0& | \\0box-shadow:inset 1px 0 0 0 $(Color.Border.line)",
          ),
        ],
      ),
      (
        "_a70tyrfge",
        [
          "._a70tyrfge{box-shadow:inset 0 0 0 1000px var(--selectedMuted-1eqw3q8);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "tyrfge",
            "val\\070\\0& | \\0box-shadow:inset 0 0 0 1000px $(Color.Background.selectedMuted)",
          ),
        ],
      ),
      (
        "_a70in2rI-",
        ["._a70in2rI-{box-shadow:inset 0 0 0 0.5px var(--flag-r83zad);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "in2rI-",
            "val\\070\\0& | \\0box-shadow:inset 0 0 0 0.5px $(Color.Shadow.flag)",
          ),
        ],
      ),
      (
        "_a70A5U0Qs",
        [
          "._a70A5U0Qs{box-shadow:0 0 0 1px var(--elevation1-3ve4h5), 0 1px 0 0 var(--elevation1Bottom-1c9od9y);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "A5U0Qs",
            "val\\070\\0& | \\0box-shadow:0 0 0 1px $(Color.Shadow.elevation1), 0 1px 0 0 $(Color.Shadow.elevation1Bottom)",
          ),
        ],
      ),
      (
        "_a70xff-MD",
        [
          "._a70xff-MD{box-shadow:0 0 0 1px var(--border-g1fxhl), 0 2px 4px 0 var(--elevation2-1yo29p);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "xff-MD",
            "val\\070\\0& | \\0box-shadow:0 0 0 1px $(Color.Shadow.border), 0 2px 4px 0 $(Color.Shadow.elevation2)",
          ),
        ],
      ),
      (
        "_a70enYDLq",
        [
          "._a70enYDLq{box-shadow:0 0 0 1px var(--border-1xmg9oz), 0 3px 18px 0 var(--elevation3-r3xv18);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "enYDLq",
            "val\\070\\0& | \\0box-shadow:0 0 0 1px $(Color.Shadow.border), 0 3px 18px 0 $(Color.Shadow.elevation3)",
          ),
        ],
      ),
      (
        "_a70k1yhUy",
        [
          "._a70k1yhUy{box-shadow:1px 0 0 0 var(--line-1om7wni_1), inset 1px 0 0 0 var(--line-1om7wni_2), inset 0 -1px 0 0 var(--line-1om7wni_3);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "k1yhUy",
            "val\\070\\0& | \\0box-shadow:1px 0 0 0 $(Color.Border.line), inset 1px 0 0 0 $(Color.Border.line), inset 0 -1px 0 0 $(Color.Border.line)",
          ),
        ],
      ),
      (
        "_a70WUi5-l",
        [
          "._a70WUi5-l{box-shadow:inset 0 1px 0 0 var(--line-1jzm6m3_1), inset 0 -1px 0 0 var(--line-1jzm6m3_2);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "WUi5-l",
            "val\\070\\0& | \\0box-shadow:inset 0 1px 0 0 $(Color.Border.line), inset 0 -1px 0 0 $(Color.Border.line)",
          ),
        ],
      ),
      (
        "_a70NtIKzk",
        ["._a70NtIKzk{box-shadow:0 1px 3px 0 rgba(0, 0, 0, 0.1);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "NtIKzk",
            "val\\070\\0& | \\0box-shadow:0 1px 3px 0 rgba(0, 0, 0, 0.1)",
          ),
        ],
      ),
      (
        "_a70hABGT3",
        ["._a70hABGT3{box-shadow:0px 0px 1px 0 rgba(255, 255, 255, 0.5);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "hABGT3",
            "val\\070\\0& | \\0box-shadow:0px 0px 1px 0 rgba(255, 255, 255, 0.5)",
          ),
        ],
      ),
      (
        "_a709znXGi",
        [
          "._a709znXGi{box-shadow:0px 1px 1px 0px rgba(49, 46, 29, 0.06), 0px 2px 2px 0px rgba(49, 46, 29, 0.04), 0px 4px 3px 0px rgba(49, 46, 29, 0.02);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "9znXGi",
            "val\\070\\0& | \\0box-shadow:0px 1px 1px 0px rgba(49, 46, 29, 0.06), 0px 2px 2px 0px rgba(49, 46, 29, 0.04), 0px 4px 3px 0px rgba(49, 46, 29, 0.02)",
          ),
        ],
      ),
      (
        "_a70q_ynwg",
        [
          "._a70q_ynwg{box-shadow:0 0 0 1px var(--elevation1-1jvm9pw), 0 3px 18px 0 var(--elevation3-1cut2k7);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "q_ynwg",
            "val\\070\\0& | \\0box-shadow:0 0 0 1px $(Color.Shadow.elevation1), 0 3px 18px 0 $(Color.Shadow.elevation3)",
          ),
        ],
      ),
      (
        "_a50EyWzNk",
        ["._a50EyWzNk{border:1px solid var(--line-ew7dcu);}"],
        1,
        0,
        17,
        [
          (
            "value",
            "EyWzNk",
            "val\\050\\0& | \\0border:1px solid $(Color.Border.line)",
          ),
        ],
      ),
      (
        "_a50k257b1",
        ["._a50k257b1{border:0px none transparent;}"],
        1,
        0,
        17,
        [("value", "k257b1", "val\\050\\0& | \\0border:0px none transparent")],
      ),
      (
        "_a6jD48_sq",
        ["._a6jD48_sq{border-top:1px solid var(--line-1qlpppm);}"],
        1,
        0,
        3,
        [
          (
            "value",
            "D48_sq",
            "val\\06j\\0& | \\0border-top:1px solid $(Color.Border.line)",
          ),
        ],
      ),
      (
        "_a5dVajjlm",
        ["._a5dVajjlm{border-bottom:1px solid var(--line-139iwo4);}"],
        1,
        0,
        3,
        [
          (
            "value",
            "Vajjlm",
            "val\\05d\\0& | \\0border-bottom:1px solid $(Color.Border.line)",
          ),
        ],
      ),
      (
        "_a65SdHngU",
        ["._a65SdHngU{border-left:1px solid var(--line-1duigd);}"],
        1,
        0,
        3,
        [
          (
            "value",
            "SdHngU",
            "val\\065\\0& | \\0border-left:1px solid $(Color.Border.line)",
          ),
        ],
      ),
      (
        "_a6aNpEUCG",
        ["._a6aNpEUCG{border-right:1px solid var(--line-sczbf);}"],
        1,
        0,
        3,
        [
          (
            "value",
            "NpEUCG",
            "val\\06a\\0& | \\0border-right:1px solid $(Color.Border.line)",
          ),
        ],
      ),
      (
        "_a500F2Ik4",
        ["._a500F2Ik4{border:1px dashed var(--line-3a0cs2);}"],
        1,
        0,
        17,
        [
          (
            "value",
            "0F2Ik4",
            "val\\050\\0& | \\0border:1px dashed $(Color.Border.line)",
          ),
        ],
      ),
      (
        "_a50gee1SF",
        ["._a50gee1SF{border:1px none var(--line-3rcwgn);}"],
        1,
        0,
        17,
        [
          (
            "value",
            "gee1SF",
            "val\\050\\0& | \\0border:1px none $(Color.Border.line)",
          ),
        ],
      ),
      (
        "_afc38Shrb",
        ["._afc38Shrb{outline:1px solid var(--line-22gjm6);}"],
        1,
        0,
        3,
        [
          (
            "value",
            "38Shrb",
            "val\\0fc\\0& | \\0outline:1px solid $(Color.Border.line)",
          ),
        ],
      ),
      (
        "_afcvh-07F",
        ["._afcvh-07F{outline:2px solid var(--accent-o8d88n);}"],
        1,
        0,
        3,
        [
          (
            "value",
            "vh-07F",
            "val\\0fc\\0& | \\0outline:2px solid $(Color.Border.accent)",
          ),
        ],
      ),
      (
        "_a3siyGp-g",
        [
          "._a3siyGp-g{-webkit-animation:helpMenuFadeIn 0.18s ease-in-out forwards;animation:helpMenuFadeIn 0.18s ease-in-out forwards;}",
        ],
        1,
        0,
        11,
        [
          (
            "value",
            "iyGp-g",
            "val\\03s\\0& | \\0animation:helpMenuFadeIn 0.18s ease-in-out forwards",
          ),
        ],
      ),
      (
        "_a3sc2N2qd",
        [
          "._a3sc2N2qd{-webkit-animation:helpMenuFadeOut 0.08s ease-out forwards;animation:helpMenuFadeOut 0.08s ease-out forwards;}",
        ],
        1,
        0,
        11,
        [
          (
            "value",
            "c2N2qd",
            "val\\03s\\0& | \\0animation:helpMenuFadeOut 0.08s ease-out forwards",
          ),
        ],
      ),
      (
        "_amaVB_mR5",
        [
          "._amaVB_mR5{transition:height 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94), opacity 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "VB_mR5",
            "val\\0ma\\0& | \\0transition:height 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94), opacity 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94)",
          ),
        ],
      ),
      (
        "_amaKqv3P5",
        [
          "._amaKqv3P5{transition:height 0.6s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.6s cubic-bezier(0.4, 0, 0.2, 1);}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "Kqv3P5",
            "val\\0ma\\0& | \\0transition:height 0.6s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.6s cubic-bezier(0.4, 0, 0.2, 1)",
          ),
        ],
      ),
      (
        "_c70-ypkeDD-tUh9",
        [
          "._c70-ypkeDD-tUh9{box-shadow:inset 1px 0 0 0 transparent !important;}",
        ],
        1,
        0,
        1,
        [
          ("ctx", "-ypkeD", "ctx\\0& | !important"),
          (
            "value",
            "D-tUh9",
            "val\\070\\0& | !important\\0box-shadow:inset 1px 0 0 0 transparent !important",
          ),
        ],
      ),
      (
        "_c70-ypkeDUmBRd1",
        ["._c70-ypkeDUmBRd1{box-shadow:1px 0 0 0 black !important;}"],
        1,
        0,
        1,
        [
          ("ctx", "-ypkeD", "ctx\\0& | !important"),
          (
            "value",
            "UmBRd1",
            "val\\070\\0& | !important\\0box-shadow:1px 0 0 0 black !important",
          ),
        ],
      ),
      (
        "_c70-ypkeDyJ8YYx",
        [
          "._c70-ypkeDyJ8YYx{box-shadow:1px 0 0 0 var(--line-dykbaq_1), inset 0 -1px 0 0 var(--line-dykbaq_2) !important;}",
        ],
        1,
        0,
        1,
        [
          ("ctx", "-ypkeD", "ctx\\0& | !important"),
          (
            "value",
            "yJ8YYx",
            "val\\070\\0& | !important\\0box-shadow:1px 0 0 0 $(Color.Border.line), inset 0 -1px 0 0 $(Color.Border.line) !important",
          ),
        ],
      ),
      (
        "_cma-ypkeDhtGUDm",
        ["._cma-ypkeDhtGUDm{transition:transform 0.3s !important;}"],
        1,
        0,
        5,
        [
          ("ctx", "-ypkeD", "ctx\\0& | !important"),
          (
            "value",
            "htGUDm",
            "val\\0ma\\0& | !important\\0transition:transform 0.3s !important",
          ),
        ],
      ),
    ]
  ];
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
  
  CSS.make("_amad6u9qq", []);
  CSS.make("_amavwXQ9V", []);
  CSS.make("_amanWVcMB", []);
  
  CSS.make("_amazqDB_Y", []);
  CSS.make("_amaWlTCY1", []);
  CSS.make("_amapvYp_U", []);
  CSS.make("_amaP6F_Bx", []);
  CSS.make("_amaQKiA5_", []);
  
  CSS.make(
    "_a70RP59tF",
    [
      ("--lineAlpha-1sh9rrm", CSS.Types.Color.toString(Color.Border.lineAlpha)),
    ],
  );
  CSS.make(
    "_a70ZSPp0s",
    [("--line-1n4cbat", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "_a70tyrfge",
    [
      (
        "--selectedMuted-1eqw3q8",
        CSS.Types.Color.toString(Color.Background.selectedMuted),
      ),
    ],
  );
  CSS.make(
    "_a70in2rI-",
    [("--flag-r83zad", CSS.Types.Color.toString(Color.Shadow.flag))],
  );
  
  CSS.make(
    "_a70A5U0Qs",
    [
      (
        "--elevation1-3ve4h5",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
      (
        "--elevation1Bottom-1c9od9y",
        CSS.Types.Color.toString(Color.Shadow.elevation1Bottom),
      ),
    ],
  );
  CSS.make(
    "_a70xff-MD",
    [
      ("--border-g1fxhl", CSS.Types.Color.toString(Color.Shadow.border)),
      (
        "--elevation2-1yo29p",
        CSS.Types.Color.toString(Color.Shadow.elevation2),
      ),
    ],
  );
  CSS.make(
    "_a70enYDLq",
    [
      ("--border-1xmg9oz", CSS.Types.Color.toString(Color.Shadow.border)),
      (
        "--elevation3-r3xv18",
        CSS.Types.Color.toString(Color.Shadow.elevation3),
      ),
    ],
  );
  
  CSS.make(
    "_a70k1yhUy",
    [
      ("--line-1om7wni_1", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-1om7wni_2", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-1om7wni_3", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  CSS.make(
    "_a70WUi5-l",
    [
      ("--line-1jzm6m3_1", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-1jzm6m3_2", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  
  CSS.make("_a70NtIKzk", []);
  CSS.make("_a70hABGT3", []);
  CSS.make("_a709znXGi", []);
  CSS.make(
    "_a70q_ynwg",
    [
      (
        "--elevation1-1jvm9pw",
        CSS.Types.Color.toString(Color.Shadow.elevation1),
      ),
      (
        "--elevation3-1cut2k7",
        CSS.Types.Color.toString(Color.Shadow.elevation3),
      ),
    ],
  );
  
  CSS.make(
    "_a50EyWzNk",
    [("--line-ew7dcu", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make("_a50k257b1", []);
  CSS.make(
    "_a6jD48_sq",
    [("--line-1qlpppm", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "_a5dVajjlm",
    [("--line-139iwo4", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "_a65SdHngU",
    [("--line-1duigd", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "_a6aNpEUCG",
    [("--line-sczbf", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "_a500F2Ik4",
    [("--line-3a0cs2", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "_a50gee1SF",
    [("--line-3rcwgn", CSS.Types.Color.toString(Color.Border.line))],
  );
  
  CSS.make(
    "_afc38Shrb",
    [("--line-22gjm6", CSS.Types.Color.toString(Color.Border.line))],
  );
  CSS.make(
    "_afcvh-07F",
    [("--accent-o8d88n", CSS.Types.Color.toString(Color.Border.accent))],
  );
  
  CSS.make("_a3siyGp-g", []);
  CSS.make("_a3sc2N2qd", []);
  
  CSS.make("_amaVB_mR5", []);
  CSS.make("_amaKqv3P5", []);
  
  CSS.make("_c70-ypkeDD-tUh9", []);
  CSS.make("_c70-ypkeDUmBRd1", []);
  CSS.make(
    "_c70-ypkeDyJ8YYx",
    [
      ("--line-dykbaq_1", CSS.Types.Color.toString(Color.Border.line)),
      ("--line-dykbaq_2", CSS.Types.Color.toString(Color.Border.line)),
    ],
  );
  
  CSS.make("_cma-ypkeDhtGUDm", []);
  
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
