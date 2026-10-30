CSS Backgrounds Module Level 4 and CSS Overflow Module Level 4 draft
properties (https://drafts.csswg.org/css-backgrounds-4/,
https://drafts.csswg.org/css-overflow-4/). input.re carries valid
declarations for every property this slice added (accepted silently);
invalid.re carries an out-of-grammar value, whose error names the property.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executables
  >  (names input invalid)
  >  (libraries styled-ppx.native)
  >  (flags (:standard -w -32))
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build
  File "invalid.re", line 1, characters 34-39:
  1 | [%css {|overflow-clip-margin-top: solid|}];
                                        ^^^^^
  Error: Property 'overflow-clip-margin-top' has an invalid value:
         'solid',
         Expected a valid value.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    (
      "._a_ex97cq{background-position-block:center;}",
      "_a_ex97cq",
      "0,1,0 own",
      "537",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_exfkc3{background-position-block:start 10px;}",
      "_a_exfkc3",
      "0,1,0 own",
      "537",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_exkn1d{background-position-block:end 10%, center;}",
      "_a_exkn1d",
      "0,1,0 own",
      "537",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_eyx7rh{background-position-inline:start;}",
      "_a_eyx7rh",
      "0,1,0 own",
      "538",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ezg63m{background-repeat-block:repeat;}",
      "_a_ezg63m",
      "0,1,0 own",
      "539",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ezm66o{background-repeat-block:space, round;}",
      "_a_ezm66o",
      "0,1,0 own",
      "539",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_f0mlxf{background-repeat-inline:no-repeat;}",
      "_a_f0mlxf",
      "0,1,0 own",
      "540",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8vfpxw{overflow-clip-margin:5px;}",
      "_a_8vfpxw",
      "0,1,0 own",
      "319",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_8vc69b{overflow-clip-margin:padding-box;}",
      "_a_8vc69b",
      "0,1,0 own",
      "319",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_8vup3k{overflow-clip-margin:content-box 10px;}",
      "_a_8vup3k",
      "0,1,0 own",
      "319",
      15,
      false,
    )
  ];
  [@css
    (
      "._a_8v0008dgxj{overflow-clip-margin-top:5px;}",
      "_a_8v0008dgxj",
      "0,1,0 own",
      "319",
      8,
      false,
    )
  ];
  [@css
    (
      "._a_8v0004wyzd{overflow-clip-margin-right:border-box 2px;}",
      "_a_8v0004wyzd",
      "0,1,0 own",
      "319",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_8v00010ibw{overflow-clip-margin-bottom:0px;}",
      "_a_8v00010ibw",
      "0,1,0 own",
      "319",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8v000240bh{overflow-clip-margin-left:padding-box;}",
      "_a_8v000240bh",
      "0,1,0 own",
      "319",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_ga00025an2{overflow-clip-margin-block-start:5px;}",
      "_a_ga00025an2",
      "0,1,0 own",
      "586",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_ga00012eib{overflow-clip-margin-block-end:5px;}",
      "_a_ga00012eib",
      "0,1,0 own",
      "586",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gb00021f55{overflow-clip-margin-inline-start:5px;}",
      "_a_gb00021f55",
      "0,1,0 own",
      "587",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_gb00013esx{overflow-clip-margin-inline-end:5px;}",
      "_a_gb00013esx",
      "0,1,0 own",
      "587",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gavvhs{overflow-clip-margin-block:5px;}",
      "_a_gavvhs",
      "0,1,0 own",
      "586",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_gbd98n{overflow-clip-margin-inline:border-box;}",
      "_a_gbd98n",
      "0,1,0 own",
      "587",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_f1l93q{block-ellipsis:auto;}",
      "_a_f1l93q",
      "0,1,0 own",
      "541",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_f16sd1{block-ellipsis:no-ellipsis;}",
      "_a_f16sd1",
      "0,1,0 own",
      "541",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_f1c6p5{block-ellipsis:\"...\";}",
      "_a_f1c6p5",
      "0,1,0 own",
      "541",
      1,
      false,
    )
  ];
  [@css
    ("._a_fiwojc{continue:auto;}", "_a_fiwojc", "0,1,0 own", "558", 1, false)
  ];
  [@css
    ("._a_fiqcek{continue:discard;}", "_a_fiqcek", "0,1,0 own", "558", 1, false)
  ];
  [@css
    (
      "._a_fi7h91{continue:collapse;}",
      "_a_fi7h91",
      "0,1,0 own",
      "558",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (10, "", [0]),
      (11, "", [1]),
      (12, "", [2]),
      (13, "", [3]),
      (14, "", [4]),
      (15, "", [5]),
      (16, "", [6]),
      (22, "", [7]),
      (23, "", [8]),
      (24, "", [9]),
      (25, "", [10]),
      (26, "", [11]),
      (27, "", [12]),
      (28, "", [13]),
      (29, "", [14]),
      (30, "", [15]),
      (31, "", [16]),
      (32, "", [17]),
      (33, "", [18]),
      (34, "", [19]),
      (35, "", [20]),
      (36, "", [21]),
      (37, "", [22]),
      (38, "", [23]),
      (39, "", [24]),
      (40, "", [25]),
    ]
  ];
  
  CSS.make("_a_ex97cq", []);
  CSS.make("_a_exfkc3", []);
  CSS.make("_a_exkn1d", []);
  CSS.make("_a_eyx7rh", []);
  CSS.make("_a_ezg63m", []);
  CSS.make("_a_ezm66o", []);
  CSS.make("_a_f0mlxf", []);
  
  CSS.make("_a_8vfpxw", []);
  CSS.make("_a_8vc69b", []);
  CSS.make("_a_8vup3k", []);
  CSS.make("_a_8v0008dgxj", []);
  CSS.make("_a_8v0004wyzd", []);
  CSS.make("_a_8v00010ibw", []);
  CSS.make("_a_8v000240bh", []);
  CSS.make("_a_ga00025an2", []);
  CSS.make("_a_ga00012eib", []);
  CSS.make("_a_gb00021f55", []);
  CSS.make("_a_gb00013esx", []);
  CSS.make("_a_gavvhs", []);
  CSS.make("_a_gbd98n", []);
  CSS.make("_a_f1l93q", []);
  CSS.make("_a_f16sd1", []);
  CSS.make("_a_f1c6p5", []);
  CSS.make("_a_fiwojc", []);
  CSS.make("_a_fiqcek", []);
  CSS.make("_a_fi7h91", []);
