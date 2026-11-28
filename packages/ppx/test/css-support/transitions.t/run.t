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
  [@css "@property --ivpc0af{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcfpc{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc95i{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcmw1{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcqvt{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpckb3{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcwjw{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpciyr{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcjg4{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpchrb{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc5gu{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc6f2{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcgp0{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpceve{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpctk4{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcmsv{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcjk1{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc5gd{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc9f5{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc2ed{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc4ik{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpca8h{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc6rv{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcy5g{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcrh2{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc0xg{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcth6{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc37h{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpci73{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcv9w{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcxof{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpco21{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc4n2{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcoe5{syntax:\"*\";inherits:false;}"];
  [@css ".css-ivpcmkx{transition-property:none;}"];
  [@css ".css-ivpc3d1{transition-property:all;}"];
  [@css ".css-ivpce0x{transition-property:width;}"];
  [@css ".css-ivpcm6q{transition-property:width, height;}"];
  [@css ".css-ivpc73u{transition-duration:0s;}"];
  [@css ".css-ivpcswj{transition-duration:1s;}"];
  [@css ".css-ivpcbcj{transition-duration:100ms;}"];
  [@css ".css-ivpc0t1{transition-duration:10s, 30s, 230ms;}"];
  [@css ".css-ivpcxoc{transition-timing-function:ease;}"];
  [@css ".css-ivpc40k{transition-timing-function:linear;}"];
  [@css ".css-ivpcvww{transition-timing-function:ease-in;}"];
  [@css ".css-ivpcgfb{transition-timing-function:ease-out;}"];
  [@css ".css-ivpc3zc{transition-timing-function:ease-in-out;}"];
  [@css
    ".css-ivpcord{transition-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}"
  ];
  [@css
    ".css-ivpcado{transition-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}"
  ];
  [@css ".css-ivpc0uo{transition-timing-function:step-start;}"];
  [@css ".css-ivpcc1e{transition-timing-function:step-end;}"];
  [@css ".css-ivpcjvj{transition-timing-function:steps(3, start);}"];
  [@css ".css-ivpc0oh{transition-timing-function:steps(5, end);}"];
  [@css
    ".css-ivpcw0h{transition-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);}"
  ];
  [@css ".css-ivpc4u9{transition-delay:1s;}"];
  [@css ".css-ivpcl5j{transition-delay:-1s;}"];
  [@css ".css-ivpc2zo{transition-delay:2s, 4ms;}"];
  [@css ".css-ivpcgiy{transition-behavior:normal;}"];
  [@css ".css-ivpck2f{transition-behavior:allow-discrete;}"];
  [@css ".css-ivpc14h{transition-behavior:allow-discrete, normal;}"];
  [@css ".css-ivpcv4v{transition:margin-right 2s, opacity 0.5s;}"];
  [@css ".css-ivpcbhc{transition:1s 2s width linear;}"];
  [@css ".css-ivpcqwp{transition:none;}"];
  [@css ".css-ivpc56l{transition:margin-right;}"];
  [@css ".css-ivpc4ux{transition:margin-right ease-in;}"];
  [@css ".css-ivpcxcf{transition:0.5s;}"];
  [@css ".css-ivpc6k7{transition:200ms 0.5s;}"];
  [@css ".css-ivpcrc9{transition:linear;}"];
  [@css ".css-ivpcbyb{transition:1s 0.5s linear margin-right;}"];
  [@css ".css-ivpca37{transition:display 4s allow-discrete;}"];
  [@css ".css-ivpcbku{transition:all 0.5s ease-out allow-discrete;}"];
  [@css ".css-ivpcswl{transition:var(--ivpc0af);}"];
  [@css ".css-ivpcxci{transition:var(--ivpcfpc);}"];
  [@css
    ".css-ivpcco4{transition:var(--ivpc95i) var(--ivpcmw1) var(--ivpcqvt) var(--ivpckb3) var(--ivpcwjw);}"
  ];
  [@css
    ".css-ivpcax1{transition:var(--ivpciyr) var(--ivpcjg4) var(--ivpchrb) var(--ivpc5gu), var(--ivpc6f2) 0s;}"
  ];
  [@css ".css-ivpcr8k{transition:var(--ivpcgp0) 0.2s ease-out 3s;}"];
  [@css ".css-ivpckdr{transition:var(--ivpceve) 0.2s var(--ivpctk4) 3s;}"];
  [@css
    ".css-ivpc9gp{transition:var(--ivpcmsv) var(--ivpcjk1) var(--ivpc5gd) 3s;}"
  ];
  [@css
    ".css-ivpcoyl{transition:margin-right var(--ivpc9f5) ease-out var(--ivpc2ed);}"
  ];
  [@css
    ".css-ivpc6ar{transition:var(--ivpc4ik) var(--ivpca8h) ease-out var(--ivpc6rv);}"
  ];
  [@css ".css-ivpcs51{transition:margin-right 0.2s var(--ivpcy5g) 3s;}"];
  [@css ".css-ivpc5l1{transition:margin-right 0.2s ease-out var(--ivpcrh2);}"];
  [@css ".css-ivpcudu{transition:var(--ivpc0xg) 0.2s ease-in;}"];
  [@css ".css-ivpczll{transition:var(--ivpcth6) 0.2s var(--ivpc37h);}"];
  [@css ".css-ivpcnno{transition:margin-right var(--ivpci73) ease-in;}"];
  [@css ".css-ivpcjgg{transition:var(--ivpcv9w) var(--ivpcxof) ease-in;}"];
  [@css ".css-ivpca2u{transition:margin-right 0.2s var(--ivpco21);}"];
  [@css ".css-ivpc6ib{transition:var(--ivpc4n2) 0.2s;}"];
  [@css ".css-ivpctew{transition:margin-right var(--ivpcoe5);}"];
  [@css.classes
    [
      ("css-ivpcmkx", 34, "", "input.re", 2, 8, 2, 33),
      ("css-ivpc3d1", 35, "", "input.re", 3, 8, 3, 32),
      ("css-ivpce0x", 36, "", "input.re", 4, 8, 4, 34),
      ("css-ivpcm6q", 37, "", "input.re", 5, 8, 5, 42),
      ("css-ivpc73u", 38, "", "input.re", 6, 8, 6, 31),
      ("css-ivpcswj", 39, "", "input.re", 7, 8, 7, 31),
      ("css-ivpcbcj", 40, "", "input.re", 8, 8, 8, 34),
      ("css-ivpc0t1", 41, "", "input.re", 9, 8, 9, 44),
      ("css-ivpcxoc", 42, "", "input.re", 10, 8, 10, 40),
      ("css-ivpc40k", 43, "", "input.re", 11, 8, 11, 42),
      ("css-ivpcvww", 44, "", "input.re", 12, 8, 12, 43),
      ("css-ivpcgfb", 45, "", "input.re", 13, 8, 13, 44),
      ("css-ivpc3zc", 46, "", "input.re", 14, 8, 14, 47),
      ("css-ivpcord", 47, "", "input.re", 15, 8, 15, 64),
      ("css-ivpcado", 48, "", "input.re", 16, 8, 16, 67),
      ("css-ivpc0uo", 49, "", "input.re", 17, 8, 17, 46),
      ("css-ivpcc1e", 50, "", "input.re", 18, 8, 18, 44),
      ("css-ivpcjvj", 51, "", "input.re", 19, 8, 19, 51),
      ("css-ivpc0oh", 52, "", "input.re", 20, 8, 20, 49),
      ("css-ivpcw0h", 53, "", "input.re", 22, 4, 22, 80),
      ("css-ivpc4u9", 54, "", "input.re", 24, 8, 24, 28),
      ("css-ivpcl5j", 55, "", "input.re", 25, 8, 25, 29),
      ("css-ivpc2zo", 56, "", "input.re", 26, 8, 26, 33),
      ("css-ivpcgiy", 57, "", "input.re", 27, 8, 27, 35),
      ("css-ivpck2f", 58, "", "input.re", 28, 8, 28, 43),
      ("css-ivpc14h", 59, "", "input.re", 29, 8, 29, 51),
      ("css-ivpcv4v", 60, "", "input.re", 30, 8, 30, 49),
      ("css-ivpcbhc", 61, "", "input.re", 31, 8, 31, 38),
      ("css-ivpcqwp", 62, "", "input.re", 32, 8, 32, 24),
      ("css-ivpc56l", 63, "", "input.re", 33, 8, 33, 32),
      ("css-ivpc4ux", 64, "", "input.re", 34, 8, 34, 40),
      ("css-ivpcxcf", 65, "", "input.re", 35, 8, 35, 23),
      ("css-ivpc6k7", 66, "", "input.re", 36, 8, 36, 29),
      ("css-ivpcrc9", 67, "", "input.re", 37, 8, 37, 26),
      ("css-ivpcbyb", 68, "", "input.re", 38, 8, 38, 46),
      ("css-ivpca37", 69, "", "input.re", 39, 8, 39, 45),
      ("css-ivpcbku", 70, "", "input.re", 40, 8, 40, 52),
      ("css-ivpcswl", 71, "", "input.re", 58, 8, 58, 37),
      ("css-ivpcxci", 72, "", "input.re", 65, 8, 65, 38),
      ("css-ivpcco4", 73, "", "input.re", 69, 4, 69, 78),
      ("css-ivpcax1", 74, "", "input.re", 72, 4, 72, 83),
      ("css-ivpcr8k", 75, "", "input.re", 74, 8, 74, 48),
      ("css-ivpckdr", 76, "", "input.re", 75, 8, 75, 57),
      ("css-ivpc9gp", 77, "", "input.re", 76, 8, 76, 64),
      ("css-ivpcoyl", 78, "", "input.re", 77, 8, 77, 62),
      ("css-ivpc6ar", 79, "", "input.re", 78, 8, 78, 61),
      ("css-ivpcs51", 80, "", "input.re", 79, 8, 79, 58),
      ("css-ivpc5l1", 81, "", "input.re", 80, 8, 80, 55),
      ("css-ivpcudu", 82, "", "input.re", 81, 8, 81, 44),
      ("css-ivpczll", 83, "", "input.re", 82, 8, 82, 54),
      ("css-ivpcnno", 84, "", "input.re", 83, 8, 83, 52),
      ("css-ivpcjgg", 85, "", "input.re", 84, 8, 84, 51),
      ("css-ivpca2u", 86, "", "input.re", 85, 8, 85, 55),
      ("css-ivpc6ib", 87, "", "input.re", 89, 8, 89, 36),
      ("css-ivpctew", 88, "", "input.re", 90, 8, 90, 44),
    ]
  ];
  
  CSS.make("css-ivpcmkx", []);
  CSS.make("css-ivpc3d1", []);
  CSS.make("css-ivpce0x", []);
  CSS.make("css-ivpcm6q", []);
  CSS.make("css-ivpc73u", []);
  CSS.make("css-ivpcswj", []);
  CSS.make("css-ivpcbcj", []);
  CSS.make("css-ivpc0t1", []);
  CSS.make("css-ivpcxoc", []);
  CSS.make("css-ivpc40k", []);
  CSS.make("css-ivpcvww", []);
  CSS.make("css-ivpcgfb", []);
  CSS.make("css-ivpc3zc", []);
  CSS.make("css-ivpcord", []);
  CSS.make("css-ivpcado", []);
  CSS.make("css-ivpc0uo", []);
  CSS.make("css-ivpcc1e", []);
  CSS.make("css-ivpcjvj", []);
  CSS.make("css-ivpc0oh", []);
  CSS.make("css-ivpcw0h", []);
  CSS.make("css-ivpc4u9", []);
  CSS.make("css-ivpcl5j", []);
  CSS.make("css-ivpc2zo", []);
  CSS.make("css-ivpcgiy", []);
  CSS.make("css-ivpck2f", []);
  CSS.make("css-ivpc14h", []);
  CSS.make("css-ivpcv4v", []);
  CSS.make("css-ivpcbhc", []);
  CSS.make("css-ivpcqwp", []);
  CSS.make("css-ivpc56l", []);
  CSS.make("css-ivpc4ux", []);
  CSS.make("css-ivpcxcf", []);
  CSS.make("css-ivpc6k7", []);
  CSS.make("css-ivpcrc9", []);
  CSS.make("css-ivpcbyb", []);
  CSS.make("css-ivpca37", []);
  CSS.make("css-ivpcbku", []);
  
  let property = CSS.Types.TransitionProperty.make("margin-right");
  let timingFunction = `easeOut;
  let duration = `ms(200);
  let delay = `s(3);
  let property3 = CSS.Types.TransitionProperty.make("opacity");
  let behavior = `allowDiscrete;
  
  let fullTransition =
    CSS.Types.Transition.Value.make(
      ~property=CSS.Types.TransitionProperty.make("margin-right"),
      ~duration=`ms(200),
      (),
    );
  CSS.make(
    "css-ivpcswl",
    [("--ivpc0af", CSS.Types.Transition.toString(fullTransition))],
  );
  
  let fullTransition2 =
    CSS.Types.Transition.Value.make(
      ~property=CSS.Types.TransitionProperty.all,
      (),
    );
  CSS.make(
    "css-ivpcxci",
    [("--ivpcfpc", CSS.Types.Transition.toString(fullTransition2))],
  );
  
  CSS.make(
    "css-ivpcco4",
    [
      ("--ivpc95i", CSS.Types.TransitionProperty.toString(property)),
      ("--ivpcmw1", CSS.Types.Time.toString(duration)),
      (
        "--ivpcqvt",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
      ("--ivpckb3", CSS.Types.Time.toString(delay)),
      ("--ivpcwjw", CSS.Types.TransitionBehavior.toString(behavior)),
    ],
  );
  CSS.make(
    "css-ivpcax1",
    [
      ("--ivpciyr", CSS.Types.TransitionProperty.toString(property)),
      ("--ivpcjg4", CSS.Types.Time.toString(duration)),
      (
        "--ivpchrb",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
      ("--ivpc5gu", CSS.Types.Time.toString(delay)),
      ("--ivpc6f2", CSS.Types.TransitionProperty.toString(property3)),
    ],
  );
  CSS.make(
    "css-ivpcr8k",
    [("--ivpcgp0", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-ivpckdr",
    [
      ("--ivpceve", CSS.Types.TransitionProperty.toString(property)),
      (
        "--ivpctk4",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-ivpc9gp",
    [
      ("--ivpcmsv", CSS.Types.TransitionProperty.toString(property)),
      ("--ivpcjk1", CSS.Types.Time.toString(duration)),
      (
        "--ivpc5gd",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-ivpcoyl",
    [
      ("--ivpc9f5", CSS.Types.Time.toString(duration)),
      ("--ivpc2ed", CSS.Types.Time.toString(delay)),
    ],
  );
  CSS.make(
    "css-ivpc6ar",
    [
      ("--ivpc4ik", CSS.Types.TransitionProperty.toString(property)),
      ("--ivpca8h", CSS.Types.Time.toString(duration)),
      ("--ivpc6rv", CSS.Types.Time.toString(delay)),
    ],
  );
  CSS.make(
    "css-ivpcs51",
    [
      (
        "--ivpcy5g",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make("css-ivpc5l1", [("--ivpcrh2", CSS.Types.Time.toString(delay))]);
  CSS.make(
    "css-ivpcudu",
    [("--ivpc0xg", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-ivpczll",
    [
      ("--ivpcth6", CSS.Types.TransitionProperty.toString(property)),
      (
        "--ivpc37h",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-ivpcnno",
    [("--ivpci73", CSS.Types.Time.toString(duration))],
  );
  CSS.make(
    "css-ivpcjgg",
    [
      ("--ivpcv9w", CSS.Types.TransitionProperty.toString(property)),
      ("--ivpcxof", CSS.Types.Time.toString(duration)),
    ],
  );
  CSS.make(
    "css-ivpca2u",
    [
      (
        "--ivpco21",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-ivpcudu",
    [("--ivpc0xg", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-ivpcnno",
    [("--ivpci73", CSS.Types.Time.toString(duration))],
  );
  CSS.make(
    "css-ivpca2u",
    [
      (
        "--ivpco21",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-ivpc6ib",
    [("--ivpc4n2", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-ivpctew",
    [("--ivpcoe5", CSS.Types.Time.toString(duration))],
  );
