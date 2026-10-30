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
  [@css
    ("._a_5qjqc9{direction:ltr;}", "_a_5qjqc9", "0,1,0 own", "-206", 1, false)
  ];
  [@css
    ("._a_5q82ql{direction:rtl;}", "_a_5q82ql", "0,1,0 own", "-206", 1, false)
  ];
  [@css
    (
      "._a_dp14px{unicode-bidi:normal;}",
      "_a_dp14px",
      "0,1,0 own",
      "-493",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dptajz{unicode-bidi:embed;}",
      "_a_dptajz",
      "0,1,0 own",
      "-493",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dphxsn{unicode-bidi:isolate;}",
      "_a_dphxsn",
      "0,1,0 own",
      "-493",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dp3xur{unicode-bidi:bidi-override;}",
      "_a_dp3xur",
      "0,1,0 own",
      "-493",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dp30cq{unicode-bidi:isolate-override;}",
      "_a_dp30cq",
      "0,1,0 own",
      "-493",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dp7z6r{unicode-bidi:plaintext;}",
      "_a_dp7z6r",
      "0,1,0 own",
      "-493",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ehni7l{-webkit-writing-mode:horizontal-tb;writing-mode:horizontal-tb;}",
      "_a_ehni7l",
      "0,1,0 own",
      "521",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ehrbdf{-webkit-writing-mode:vertical-rl;writing-mode:vertical-rl;}",
      "_a_ehrbdf",
      "0,1,0 own",
      "521",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ehuv7p{-webkit-writing-mode:vertical-lr;writing-mode:vertical-lr;}",
      "_a_ehuv7p",
      "0,1,0 own",
      "521",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cvc989{text-orientation:mixed;}",
      "_a_cvc989",
      "0,1,0 own",
      "463",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cvjqux{text-orientation:upright;}",
      "_a_cvjqux",
      "0,1,0 own",
      "463",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cvfrh6{text-orientation:sideways;}",
      "_a_cvfrh6",
      "0,1,0 own",
      "463",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ceubm3{text-combine-upright:none;}",
      "_a_ceubm3",
      "0,1,0 own",
      "446",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cejtzu{text-combine-upright:all;}",
      "_a_cejtzu",
      "0,1,0 own",
      "446",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ehcjo4{-webkit-writing-mode:sideways-rl;writing-mode:sideways-rl;}",
      "_a_ehcjo4",
      "0,1,0 own",
      "521",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ehq5f9{-webkit-writing-mode:sideways-lr;writing-mode:sideways-lr;}",
      "_a_ehq5f9",
      "0,1,0 own",
      "521",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cefs5k{text-combine-upright:digits 2;}",
      "_a_cefs5k",
      "0,1,0 own",
      "446",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (2, "", [0]),
      (3, "", [1]),
      (4, "", [2]),
      (5, "", [3]),
      (6, "", [4]),
      (7, "", [5]),
      (8, "", [6]),
      (9, "", [7]),
      (10, "", [8]),
      (11, "", [9]),
      (12, "", [10]),
      (13, "", [11]),
      (14, "", [12]),
      (15, "", [13]),
      (16, "", [14]),
      (17, "", [15]),
      (20, "", [16]),
      (21, "", [17]),
      (22, "", [18]),
    ]
  ];
  
  CSS.make("_a_5qjqc9", []);
  CSS.make("_a_5q82ql", []);
  CSS.make("_a_dp14px", []);
  CSS.make("_a_dptajz", []);
  CSS.make("_a_dphxsn", []);
  CSS.make("_a_dp3xur", []);
  CSS.make("_a_dp30cq", []);
  CSS.make("_a_dp7z6r", []);
  CSS.make("_a_ehni7l", []);
  CSS.make("_a_ehrbdf", []);
  CSS.make("_a_ehuv7p", []);
  CSS.make("_a_cvc989", []);
  CSS.make("_a_cvjqux", []);
  CSS.make("_a_cvfrh6", []);
  CSS.make("_a_ceubm3", []);
  CSS.make("_a_cejtzu", []);
  
  CSS.make("_a_ehcjo4", []);
  CSS.make("_a_ehq5f9", []);
  CSS.make("_a_cefs5k", []);
