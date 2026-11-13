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
  [@css "@property --yfdgzk-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1wy8o9m-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1t7o8q-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1t7o8q-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --1t7o8q-2{syntax:\"*\";inherits:false;}"];
  [@css "@property --1t7o8q-3{syntax:\"*\";inherits:false;}"];
  [@css "@property --1t7o8q-4{syntax:\"*\";inherits:false;}"];
  [@css "@property --1rlc4e0-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1rlc4e0-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --1rlc4e0-2{syntax:\"*\";inherits:false;}"];
  [@css "@property --1rlc4e0-3{syntax:\"*\";inherits:false;}"];
  [@css "@property --1rlc4e0-4{syntax:\"*\";inherits:false;}"];
  [@css "@property --1g40n6f-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1f8tgzj-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1f8tgzj-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --1tkjlf-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1tkjlf-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --1tkjlf-2{syntax:\"*\";inherits:false;}"];
  [@css "@property --3t413g-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --3t413g-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --m07o4c-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --m07o4c-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --m07o4c-2{syntax:\"*\";inherits:false;}"];
  [@css "@property --18zibj6-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --ahaytm-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --ob669s-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1cxlwh4-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1cxlwh4-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --vzr4ju-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --lq6u97-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --lq6u97-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --8c2ja6-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1srb40f-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1s8r75k-0{syntax:\"*\";inherits:false;}"];
  [@css ".css-1xk3mkx{transition-property:none;}"];
  [@css ".css-1wzt3d1{transition-property:all;}"];
  [@css ".css-rkye0x{transition-property:width;}"];
  [@css ".css-1aqpm6q{transition-property:width, height;}"];
  [@css ".css-2qm73u{transition-duration:0s;}"];
  [@css ".css-16l1swj{transition-duration:1s;}"];
  [@css ".css-o7dbcj{transition-duration:100ms;}"];
  [@css ".css-1lko0t1{transition-duration:10s, 30s, 230ms;}"];
  [@css ".css-7wqxoc{transition-timing-function:ease;}"];
  [@css ".css-102k40k{transition-timing-function:linear;}"];
  [@css ".css-zfivww{transition-timing-function:ease-in;}"];
  [@css ".css-n81gfb{transition-timing-function:ease-out;}"];
  [@css ".css-xb03zc{transition-timing-function:ease-in-out;}"];
  [@css
    ".css-yk8ord{transition-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}"
  ];
  [@css
    ".css-d0mado{transition-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}"
  ];
  [@css ".css-1jjf0uo{transition-timing-function:step-start;}"];
  [@css ".css-1gr8c1e{transition-timing-function:step-end;}"];
  [@css ".css-22yjvj{transition-timing-function:steps(3, start);}"];
  [@css ".css-1gdi0oh{transition-timing-function:steps(5, end);}"];
  [@css
    ".css-yguw0h{transition-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);}"
  ];
  [@css ".css-1syt4u9{transition-delay:1s;}"];
  [@css ".css-78yl5j{transition-delay:-1s;}"];
  [@css ".css-awr2zo{transition-delay:2s, 4ms;}"];
  [@css ".css-2yfgiy{transition-behavior:normal;}"];
  [@css ".css-1lldk2f{transition-behavior:allow-discrete;}"];
  [@css ".css-bq514h{transition-behavior:allow-discrete, normal;}"];
  [@css ".css-1gs4v4v{transition:margin-right 2s, opacity 0.5s;}"];
  [@css ".css-guwbhc{transition:1s 2s width linear;}"];
  [@css ".css-lxhqwp{transition:none;}"];
  [@css ".css-1sa056l{transition:margin-right;}"];
  [@css ".css-1j634ux{transition:margin-right ease-in;}"];
  [@css ".css-921xcf{transition:0.5s;}"];
  [@css ".css-vm06k7{transition:200ms 0.5s;}"];
  [@css ".css-1i9brc9{transition:linear;}"];
  [@css ".css-kknbyb{transition:1s 0.5s linear margin-right;}"];
  [@css ".css-3sna37{transition:display 4s allow-discrete;}"];
  [@css ".css-1dsebku{transition:all 0.5s ease-out allow-discrete;}"];
  [@css ".css-yfdgzk{transition:var(--yfdgzk-0);}"];
  [@css ".css-1wy8o9m{transition:var(--1wy8o9m-0);}"];
  [@css
    ".css-1t7o8q{transition:var(--1t7o8q-0) var(--1t7o8q-1) var(--1t7o8q-2) var(--1t7o8q-3) var(--1t7o8q-4);}"
  ];
  [@css
    ".css-1rlc4e0{transition:var(--1rlc4e0-0) var(--1rlc4e0-1) var(--1rlc4e0-2) var(--1rlc4e0-3), var(--1rlc4e0-4) 0s;}"
  ];
  [@css ".css-1g40n6f{transition:var(--1g40n6f-0) 0.2s ease-out 3s;}"];
  [@css ".css-1f8tgzj{transition:var(--1f8tgzj-0) 0.2s var(--1f8tgzj-1) 3s;}"];
  [@css
    ".css-1tkjlf{transition:var(--1tkjlf-0) var(--1tkjlf-1) var(--1tkjlf-2) 3s;}"
  ];
  [@css
    ".css-3t413g{transition:margin-right var(--3t413g-0) ease-out var(--3t413g-1);}"
  ];
  [@css
    ".css-m07o4c{transition:var(--m07o4c-0) var(--m07o4c-1) ease-out var(--m07o4c-2);}"
  ];
  [@css ".css-18zibj6{transition:margin-right 0.2s var(--18zibj6-0) 3s;}"];
  [@css ".css-ahaytm{transition:margin-right 0.2s ease-out var(--ahaytm-0);}"];
  [@css ".css-ob669s{transition:var(--ob669s-0) 0.2s ease-in;}"];
  [@css ".css-1cxlwh4{transition:var(--1cxlwh4-0) 0.2s var(--1cxlwh4-1);}"];
  [@css ".css-vzr4ju{transition:margin-right var(--vzr4ju-0) ease-in;}"];
  [@css ".css-lq6u97{transition:var(--lq6u97-0) var(--lq6u97-1) ease-in;}"];
  [@css ".css-8c2ja6{transition:margin-right 0.2s var(--8c2ja6-0);}"];
  [@css ".css-1srb40f{transition:var(--1srb40f-0) 0.2s;}"];
  [@css ".css-1s8r75k{transition:margin-right var(--1s8r75k-0);}"];
  [@css.classes
    [
      ("css-1xk3mkx", 34, "", "input.re", 2, 8, 2, 33),
      ("css-1wzt3d1", 35, "", "input.re", 3, 8, 3, 32),
      ("css-rkye0x", 36, "", "input.re", 4, 8, 4, 34),
      ("css-1aqpm6q", 37, "", "input.re", 5, 8, 5, 42),
      ("css-2qm73u", 38, "", "input.re", 6, 8, 6, 31),
      ("css-16l1swj", 39, "", "input.re", 7, 8, 7, 31),
      ("css-o7dbcj", 40, "", "input.re", 8, 8, 8, 34),
      ("css-1lko0t1", 41, "", "input.re", 9, 8, 9, 44),
      ("css-7wqxoc", 42, "", "input.re", 10, 8, 10, 40),
      ("css-102k40k", 43, "", "input.re", 11, 8, 11, 42),
      ("css-zfivww", 44, "", "input.re", 12, 8, 12, 43),
      ("css-n81gfb", 45, "", "input.re", 13, 8, 13, 44),
      ("css-xb03zc", 46, "", "input.re", 14, 8, 14, 47),
      ("css-yk8ord", 47, "", "input.re", 15, 8, 15, 64),
      ("css-d0mado", 48, "", "input.re", 16, 8, 16, 67),
      ("css-1jjf0uo", 49, "", "input.re", 17, 8, 17, 46),
      ("css-1gr8c1e", 50, "", "input.re", 18, 8, 18, 44),
      ("css-22yjvj", 51, "", "input.re", 19, 8, 19, 51),
      ("css-1gdi0oh", 52, "", "input.re", 20, 8, 20, 49),
      ("css-yguw0h", 53, "", "input.re", 22, 4, 22, 80),
      ("css-1syt4u9", 54, "", "input.re", 24, 8, 24, 28),
      ("css-78yl5j", 55, "", "input.re", 25, 8, 25, 29),
      ("css-awr2zo", 56, "", "input.re", 26, 8, 26, 33),
      ("css-2yfgiy", 57, "", "input.re", 27, 8, 27, 35),
      ("css-1lldk2f", 58, "", "input.re", 28, 8, 28, 43),
      ("css-bq514h", 59, "", "input.re", 29, 8, 29, 51),
      ("css-1gs4v4v", 60, "", "input.re", 30, 8, 30, 49),
      ("css-guwbhc", 61, "", "input.re", 31, 8, 31, 38),
      ("css-lxhqwp", 62, "", "input.re", 32, 8, 32, 24),
      ("css-1sa056l", 63, "", "input.re", 33, 8, 33, 32),
      ("css-1j634ux", 64, "", "input.re", 34, 8, 34, 40),
      ("css-921xcf", 65, "", "input.re", 35, 8, 35, 23),
      ("css-vm06k7", 66, "", "input.re", 36, 8, 36, 29),
      ("css-1i9brc9", 67, "", "input.re", 37, 8, 37, 26),
      ("css-kknbyb", 68, "", "input.re", 38, 8, 38, 46),
      ("css-3sna37", 69, "", "input.re", 39, 8, 39, 45),
      ("css-1dsebku", 70, "", "input.re", 40, 8, 40, 52),
      ("css-yfdgzk", 71, "", "input.re", 58, 8, 58, 37),
      ("css-1wy8o9m", 72, "", "input.re", 65, 8, 65, 38),
      ("css-1t7o8q", 73, "", "input.re", 69, 4, 69, 78),
      ("css-1rlc4e0", 74, "", "input.re", 72, 4, 72, 83),
      ("css-1g40n6f", 75, "", "input.re", 74, 8, 74, 48),
      ("css-1f8tgzj", 76, "", "input.re", 75, 8, 75, 57),
      ("css-1tkjlf", 77, "", "input.re", 76, 8, 76, 64),
      ("css-3t413g", 78, "", "input.re", 77, 8, 77, 62),
      ("css-m07o4c", 79, "", "input.re", 78, 8, 78, 61),
      ("css-18zibj6", 80, "", "input.re", 79, 8, 79, 58),
      ("css-ahaytm", 81, "", "input.re", 80, 8, 80, 55),
      ("css-ob669s", 82, "", "input.re", 81, 8, 81, 44),
      ("css-1cxlwh4", 83, "", "input.re", 82, 8, 82, 54),
      ("css-vzr4ju", 84, "", "input.re", 83, 8, 83, 52),
      ("css-lq6u97", 85, "", "input.re", 84, 8, 84, 51),
      ("css-8c2ja6", 86, "", "input.re", 85, 8, 85, 55),
      ("css-1srb40f", 87, "", "input.re", 89, 8, 89, 36),
      ("css-1s8r75k", 88, "", "input.re", 90, 8, 90, 44),
    ]
  ];
  
  CSS.make("css-1xk3mkx", []);
  CSS.make("css-1wzt3d1", []);
  CSS.make("css-rkye0x", []);
  CSS.make("css-1aqpm6q", []);
  CSS.make("css-2qm73u", []);
  CSS.make("css-16l1swj", []);
  CSS.make("css-o7dbcj", []);
  CSS.make("css-1lko0t1", []);
  CSS.make("css-7wqxoc", []);
  CSS.make("css-102k40k", []);
  CSS.make("css-zfivww", []);
  CSS.make("css-n81gfb", []);
  CSS.make("css-xb03zc", []);
  CSS.make("css-yk8ord", []);
  CSS.make("css-d0mado", []);
  CSS.make("css-1jjf0uo", []);
  CSS.make("css-1gr8c1e", []);
  CSS.make("css-22yjvj", []);
  CSS.make("css-1gdi0oh", []);
  CSS.make("css-yguw0h", []);
  CSS.make("css-1syt4u9", []);
  CSS.make("css-78yl5j", []);
  CSS.make("css-awr2zo", []);
  CSS.make("css-2yfgiy", []);
  CSS.make("css-1lldk2f", []);
  CSS.make("css-bq514h", []);
  CSS.make("css-1gs4v4v", []);
  CSS.make("css-guwbhc", []);
  CSS.make("css-lxhqwp", []);
  CSS.make("css-1sa056l", []);
  CSS.make("css-1j634ux", []);
  CSS.make("css-921xcf", []);
  CSS.make("css-vm06k7", []);
  CSS.make("css-1i9brc9", []);
  CSS.make("css-kknbyb", []);
  CSS.make("css-3sna37", []);
  CSS.make("css-1dsebku", []);
  
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
    "css-yfdgzk",
    [("--yfdgzk-0", CSS.Types.Transition.toString(fullTransition))],
  );
  
  let fullTransition2 =
    CSS.Types.Transition.Value.make(
      ~property=CSS.Types.TransitionProperty.all,
      (),
    );
  CSS.make(
    "css-1wy8o9m",
    [("--1wy8o9m-0", CSS.Types.Transition.toString(fullTransition2))],
  );
  
  CSS.make(
    "css-1t7o8q",
    [
      ("--1t7o8q-0", CSS.Types.TransitionProperty.toString(property)),
      ("--1t7o8q-1", CSS.Types.Time.toString(duration)),
      (
        "--1t7o8q-2",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
      ("--1t7o8q-3", CSS.Types.Time.toString(delay)),
      ("--1t7o8q-4", CSS.Types.TransitionBehavior.toString(behavior)),
    ],
  );
  CSS.make(
    "css-1rlc4e0",
    [
      ("--1rlc4e0-0", CSS.Types.TransitionProperty.toString(property)),
      ("--1rlc4e0-1", CSS.Types.Time.toString(duration)),
      (
        "--1rlc4e0-2",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
      ("--1rlc4e0-3", CSS.Types.Time.toString(delay)),
      ("--1rlc4e0-4", CSS.Types.TransitionProperty.toString(property3)),
    ],
  );
  CSS.make(
    "css-1g40n6f",
    [("--1g40n6f-0", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-1f8tgzj",
    [
      ("--1f8tgzj-0", CSS.Types.TransitionProperty.toString(property)),
      (
        "--1f8tgzj-1",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-1tkjlf",
    [
      ("--1tkjlf-0", CSS.Types.TransitionProperty.toString(property)),
      ("--1tkjlf-1", CSS.Types.Time.toString(duration)),
      (
        "--1tkjlf-2",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-3t413g",
    [
      ("--3t413g-0", CSS.Types.Time.toString(duration)),
      ("--3t413g-1", CSS.Types.Time.toString(delay)),
    ],
  );
  CSS.make(
    "css-m07o4c",
    [
      ("--m07o4c-0", CSS.Types.TransitionProperty.toString(property)),
      ("--m07o4c-1", CSS.Types.Time.toString(duration)),
      ("--m07o4c-2", CSS.Types.Time.toString(delay)),
    ],
  );
  CSS.make(
    "css-18zibj6",
    [
      (
        "--18zibj6-0",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make("css-ahaytm", [("--ahaytm-0", CSS.Types.Time.toString(delay))]);
  CSS.make(
    "css-ob669s",
    [("--ob669s-0", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-1cxlwh4",
    [
      ("--1cxlwh4-0", CSS.Types.TransitionProperty.toString(property)),
      (
        "--1cxlwh4-1",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-vzr4ju",
    [("--vzr4ju-0", CSS.Types.Time.toString(duration))],
  );
  CSS.make(
    "css-lq6u97",
    [
      ("--lq6u97-0", CSS.Types.TransitionProperty.toString(property)),
      ("--lq6u97-1", CSS.Types.Time.toString(duration)),
    ],
  );
  CSS.make(
    "css-8c2ja6",
    [
      (
        "--8c2ja6-0",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-ob669s",
    [("--ob669s-0", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-vzr4ju",
    [("--vzr4ju-0", CSS.Types.Time.toString(duration))],
  );
  CSS.make(
    "css-8c2ja6",
    [
      (
        "--8c2ja6-0",
        CSS.Types.TransitionTimingFunction.toString(timingFunction),
      ),
    ],
  );
  CSS.make(
    "css-1srb40f",
    [("--1srb40f-0", CSS.Types.TransitionProperty.toString(property))],
  );
  CSS.make(
    "css-1s8r75k",
    [("--1s8r75k-0", CSS.Types.Time.toString(duration))],
  );
