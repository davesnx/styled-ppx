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
    (
      "._a_9hdqw8{place-content:center;}",
      "_a_9hdqw8",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9h5dhv{place-content:start;}",
      "_a_9h5dhv",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hnyc7{place-content:end;}",
      "_a_9hnyc7",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hg07y{place-content:space-between;}",
      "_a_9hg07y",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hn9tt{place-content:space-around;}",
      "_a_9hn9tt",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9h8p3p{place-content:space-evenly;}",
      "_a_9h8p3p",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hwium{place-content:stretch;}",
      "_a_9hwium",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hgpzp{place-content:center start;}",
      "_a_9hgpzp",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hvq2g{place-content:start end;}",
      "_a_9hvq2g",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9h4mkx{place-content:space-between center;}",
      "_a_9h4mkx",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9iym04{place-items:center;}",
      "_a_9iym04",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9icea0{place-items:start;}",
      "_a_9icea0",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    ("._a_9iqbga{place-items:end;}", "_a_9iqbga", "0,1,0 own", "342", 3, false)
  ];
  [@css
    (
      "._a_9iwgtc{place-items:stretch;}",
      "_a_9iwgtc",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9ip3r0{place-items:baseline;}",
      "_a_9ip3r0",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9ikxp5{place-items:center start;}",
      "_a_9ikxp5",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9ie9sr{place-items:start end;}",
      "_a_9ie9sr",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    ("._a_9jrl8b{place-self:auto;}", "_a_9jrl8b", "0,1,0 own", "343", 3, false)
  ];
  [@css
    (
      "._a_9je2kp{place-self:center;}",
      "_a_9je2kp",
      "0,1,0 own",
      "343",
      3,
      false,
    )
  ];
  [@css
    ("._a_9j5pw6{place-self:start;}", "_a_9j5pw6", "0,1,0 own", "343", 3, false)
  ];
  [@css
    ("._a_9jzgxw{place-self:end;}", "_a_9jzgxw", "0,1,0 own", "343", 3, false)
  ];
  [@css
    (
      "._a_9jxvva{place-self:stretch;}",
      "_a_9jxvva",
      "0,1,0 own",
      "343",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9jr5sl{place-self:center start;}",
      "_a_9jr5sl",
      "0,1,0 own",
      "343",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9j3gqb{place-self:start end;}",
      "_a_9j3gqb",
      "0,1,0 own",
      "343",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_2t8d29{accent-color:auto;}",
      "_a_2t8d29",
      "0,1,0 own",
      "101",
      1,
      false,
    )
  ];
  [@css
    ("._a_2tjc5t{accent-color:red;}", "_a_2tjc5t", "0,1,0 own", "101", 1, false)
  ];
  [@css
    (
      "._a_2t2rnk{accent-color:#ff0000;}",
      "_a_2t2rnk",
      "0,1,0 own",
      "101",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_2tauhw{accent-color:rgb(255, 0, 0);}",
      "_a_2tauhw",
      "0,1,0 own",
      "101",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dh2far{touch-action:auto;}",
      "_a_dh2far",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhsbrd{touch-action:none;}",
      "_a_dhsbrd",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhsu0a{touch-action:pan-x;}",
      "_a_dhsu0a",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhcb00{touch-action:pan-y;}",
      "_a_dhcb00",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dh4v8x{touch-action:manipulation;}",
      "_a_dh4v8x",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhee94{touch-action:pan-x pan-y;}",
      "_a_dhee94",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_35cmp3{aspect-ratio:auto;}",
      "_a_35cmp3",
      "0,1,0 own",
      "113",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_35ebk2{aspect-ratio:1 / 1;}",
      "_a_35ebk2",
      "0,1,0 own",
      "113",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_35vr3s{aspect-ratio:16 / 9;}",
      "_a_35vr3s",
      "0,1,0 own",
      "113",
      1,
      false,
    )
  ];
  [@css
    ("._a_35vip7{aspect-ratio:0.5;}", "_a_35vip7", "0,1,0 own", "113", 1, false)
  ];
  [@css.blocks
    [
      (4, "", [0]),
      (5, "", [1]),
      (6, "", [2]),
      (7, "", [3]),
      (8, "", [4]),
      (9, "", [5]),
      (10, "", [6]),
      (11, "", [7]),
      (12, "", [8]),
      (13, "", [9]),
      (16, "", [10]),
      (17, "", [11]),
      (18, "", [12]),
      (19, "", [13]),
      (20, "", [14]),
      (21, "", [15]),
      (22, "", [16]),
      (25, "", [17]),
      (26, "", [18]),
      (27, "", [19]),
      (28, "", [20]),
      (29, "", [21]),
      (30, "", [22]),
      (31, "", [23]),
      (34, "", [24]),
      (35, "", [25]),
      (36, "", [26]),
      (37, "", [27]),
      (40, "", [28]),
      (41, "", [29]),
      (42, "", [30]),
      (43, "", [31]),
      (44, "", [32]),
      (45, "", [33]),
      (48, "", [34]),
      (49, "", [35]),
      (50, "", [36]),
      (51, "", [37]),
    ]
  ];
  
  CSS.make("_a_9hdqw8", []);
  CSS.make("_a_9h5dhv", []);
  CSS.make("_a_9hnyc7", []);
  CSS.make("_a_9hg07y", []);
  CSS.make("_a_9hn9tt", []);
  CSS.make("_a_9h8p3p", []);
  CSS.make("_a_9hwium", []);
  CSS.make("_a_9hgpzp", []);
  CSS.make("_a_9hvq2g", []);
  CSS.make("_a_9h4mkx", []);
  
  CSS.make("_a_9iym04", []);
  CSS.make("_a_9icea0", []);
  CSS.make("_a_9iqbga", []);
  CSS.make("_a_9iwgtc", []);
  CSS.make("_a_9ip3r0", []);
  CSS.make("_a_9ikxp5", []);
  CSS.make("_a_9ie9sr", []);
  
  CSS.make("_a_9jrl8b", []);
  CSS.make("_a_9je2kp", []);
  CSS.make("_a_9j5pw6", []);
  CSS.make("_a_9jzgxw", []);
  CSS.make("_a_9jxvva", []);
  CSS.make("_a_9jr5sl", []);
  CSS.make("_a_9j3gqb", []);
  
  CSS.make("_a_2t8d29", []);
  CSS.make("_a_2tjc5t", []);
  CSS.make("_a_2t2rnk", []);
  CSS.make("_a_2tauhw", []);
  
  CSS.make("_a_dh2far", []);
  CSS.make("_a_dhsbrd", []);
  CSS.make("_a_dhsu0a", []);
  CSS.make("_a_dhcb00", []);
  CSS.make("_a_dh4v8x", []);
  CSS.make("_a_dhee94", []);
  
  CSS.make("_a_35cmp3", []);
  CSS.make("_a_35ebk2", []);
  CSS.make("_a_35vr3s", []);
  CSS.make("_a_35vip7", []);
