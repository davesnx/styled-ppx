Family atoms: two declarations in one context share an atom only when
their covered leaf properties overlap (taken transitively), declarations
in author order. Sharing a family is not enough on its own -
`padding-left`/`padding-right` share the "padding" family but cover
disjoint leaves, so they still get separate atoms.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    (
      "._a_7pow79{margin:10px;margin-top:0;}",
      "_a_7pow79",
      "0,1,0 own",
      "277",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_7p8lih{margin-top:0;margin:10px;}",
      "_a_7p8lih",
      "0,1,0 own",
      "277",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_7pp6yp{margin:10px;margin-top:0;margin-left:5px;}",
      "_a_7pp6yp",
      "0,1,0 own",
      "277",
      15,
      false,
    )
  ];
  [@css ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)];
  [@css
    (
      "._a_7p0008n4zf{margin-top:0;}",
      "_a_7p0008n4zf",
      "0,1,0 own",
      "277",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_940008cand{padding-top:0;}",
      "_a_940008cand",
      "0,1,0 own",
      "328",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_qyw7u7po9vs:hover{margin:10px;margin-top:0;}",
      "_a_qyw7u7po9vs",
      "0,2,0 own",
      "277",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_940002yq1t{padding-left:0;}",
      "_a_940002yq1t",
      "0,1,0 own",
      "328",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9400048fgp{padding-right:0;}",
      "_a_9400048fgp",
      "0,1,0 own",
      "328",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_3h2ghsmzmu{border-top:1px solid red;}",
      "_a_3h2ghsmzmu",
      "0,1,0 own",
      "125",
      114688,
      false,
    )
  ];
  [@css
    (
      "._a_3h00sgpy0o{border-left-width:2px;}",
      "_a_3h00sgpy0o",
      "0,1,0 own",
      "125",
      1024,
      false,
    )
  ];
  [@css
    (
      "._a_3hu7ex{border:1px solid blue;border-left-width:2px;}",
      "_a_3hu7ex",
      "0,1,0 own",
      "125",
      131071,
      false,
    )
  ];
  [@css
    (
      "._a_3htdra{border-top:1px solid red;border:2px dashed blue;border-left-width:3px;}",
      "_a_3htdra",
      "0,1,0 own",
      "125",
      131071,
      false,
    )
  ];
  [@css.bindings
    [
      ("Output.shorthandThenLonghand", "_id_1qpv0jm", "_a_7pow79"),
      ("Output.longhandThenShorthand", "_id_uil9rv", "_a_7p8lih"),
      ("Output.threeMembers", "_id_5lj0i7", "_a_7pp6yp"),
      ("Output.unrelatedProperties", "_id_6fb8it", "_a_4ekvmb _a_7p0008n4zf"),
      (
        "Output.crossFamilyIndependence",
        "_id_4irwce",
        "_a_7p0008n4zf _a_940008cand",
      ),
      ("Output.underSelector", "_id_t76kqk", "_a_qyw7u7po9vs"),
      (
        "Output.sameFamilyDisjointLeaves",
        "_id_1jum1rn",
        "_a_940002yq1t _a_9400048fgp",
      ),
      (
        "Output.sameFamilyNoOverlap",
        "_id_1vbhcey",
        "_a_3h2ghsmzmu _a_3h00sgpy0o",
      ),
      ("Output.sameFamilyOverlapViaShorthand", "_id_3jg85a", "_a_3hu7ex"),
      ("Output.transitiveBridge", "_id_bhbjc9", "_a_3htdra"),
    ]
  ];
  [@css.blocks
    [
      (1, "_id_1qpv0jm", [0]),
      (5, "_id_uil9rv", [1]),
      (10, "_id_5lj0i7", [2]),
      (15, "_id_6fb8it", [3, 4]),
      (19, "_id_4irwce", [4, 5]),
      (24, "_id_t76kqk", [6]),
      (31, "_id_1jum1rn", [7, 8]),
      (36, "_id_1vbhcey", [9, 10]),
      (41, "_id_3jg85a", [11]),
      (47, "_id_bhbjc9", [12]),
    ]
  ];
  let shorthandThenLonghand =
    CSS.make("label:shorthandThenLonghand _id_1qpv0jm _a_7pow79", []);
  let longhandThenShorthand =
    CSS.make("label:longhandThenShorthand _id_uil9rv _a_7p8lih", []);
  let threeMembers = CSS.make("label:threeMembers _id_5lj0i7 _a_7pp6yp", []);
  let unrelatedProperties =
    CSS.make(
      "label:unrelatedProperties _id_6fb8it _a_4ekvmb _a_7p0008n4zf",
      [],
    );
  let crossFamilyIndependence =
    CSS.make(
      "label:crossFamilyIndependence _id_4irwce _a_7p0008n4zf _a_940008cand",
      [],
    );
  let underSelector =
    CSS.make("label:underSelector _id_t76kqk _a_qyw7u7po9vs", []);
  let sameFamilyDisjointLeaves =
    CSS.make(
      "label:sameFamilyDisjointLeaves _id_1jum1rn _a_940002yq1t _a_9400048fgp",
      [],
    );
  let sameFamilyNoOverlap =
    CSS.make(
      "label:sameFamilyNoOverlap _id_1vbhcey _a_3h2ghsmzmu _a_3h00sgpy0o",
      [],
    );
  let sameFamilyOverlapViaShorthand =
    CSS.make("label:sameFamilyOverlapViaShorthand _id_3jg85a _a_3hu7ex", []);
  let transitiveBridge =
    CSS.make("label:transitiveBridge _id_bhbjc9 _a_3htdra", []);
