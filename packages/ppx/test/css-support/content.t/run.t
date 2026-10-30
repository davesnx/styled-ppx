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
    ("._a_9uidje{quotes:auto;}", "_a_9uidje", "0,1,0 own", "354", 1, false)
  ];
  [@css
    (
      "._a_4wf2ur{content:\"►\" / \"\";}",
      "_a_4wf2ur",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    ("._a_4wsdc1{content:\"\";}", "_a_4wsdc1", "0,1,0 own", "176", 1, false)
  ];
  [@css
    (
      "._a_4wdhko{content:counter(ol);}",
      "_a_4wdhko",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wzbnh{content:counter(count, decimal);}",
      "_a_4wzbnh",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4w56qq{content:counter(count, decimal) \") \";}",
      "_a_4w56qq",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    ("._a_4wd7tk{content:unset;}", "_a_4wd7tk", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4wordy{content:normal;}", "_a_4wordy", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4wzcbh{content:none;}", "_a_4wzcbh", "0,1,0 own", "176", 1, false)
  ];
  [@css
    (
      "._a_4w1wxf{content:url(\"http://www.example.com/test.png\");}",
      "_a_4w1wxf",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4weiwy{content:linear-gradient(#e66465, #9198e5);}",
      "_a_4weiwy",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wnydd{content:image-set(\"image1x.png\" 1x, \"image2x.png\" 2x);}",
      "_a_4wnydd",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wu5b0{content:url(\"../img/test.png\") / \"This is the alt text\";}",
      "_a_4wu5b0",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4w6790{content:\"unparsed text\";}",
      "_a_4w6790",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wr3ui{content:counter(chapter_counter);}",
      "_a_4wr3ui",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wxuxw{content:counter(chapter_counter, upper-roman);}",
      "_a_4wxuxw",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wwggo{content:counters(section_counter, \".\");}",
      "_a_4wwggo",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4w14i9{content:counters(section_counter, \".\", decimal-leading-zero);}",
      "_a_4w14i9",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wn5wz{content:attr(href);}",
      "_a_4wn5wz",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4w2bce{content:attr(data-width px);}",
      "_a_4w2bce",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wenc9{content:open-quote;}",
      "_a_4wenc9",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4w0d5m{content:close-quote;}",
      "_a_4w0d5m",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4woxre{content:no-open-quote;}",
      "_a_4woxre",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wyzsz{content:no-close-quote;}",
      "_a_4wyzsz",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wq46n{content:\"prefix\" url(\"http://www.example.com/test.png\");}",
      "_a_4wq46n",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wt6w1{content:\"prefix\" url(\"/img/test.png\") \"suffix\" / \"Alt text\";}",
      "_a_4wt6w1",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wwmef{content:open-quote counter(chapter_counter);}",
      "_a_4wwmef",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    ("._a_4w1hfk{content:inherit;}", "_a_4w1hfk", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4wslsq{content:initial;}", "_a_4wslsq", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4wltxf{content:revert;}", "_a_4wltxf", "0,1,0 own", "176", 1, false)
  ];
  [@css
    (
      "._a_4wtvgg{content:revert-layer;}",
      "_a_4wtvgg",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    ("._a_4wks2k{content:\"点\";}", "_a_4wks2k", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4wf07t{content:\"lola\";}", "_a_4wf07t", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4wvtt9{content:\" \";}", "_a_4wvtt9", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4w6l48{content:\"'\";}", "_a_4w6l48", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4wu917{content:\"\\\"\";}", "_a_4wu917", "0,1,0 own", "176", 1, false)
  ];
  [@css
    (
      "._a_4wwufj{content:attr(data-value);}",
      "_a_4wwufj",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wn7nw{content:attr(data-value raw-string);}",
      "_a_4wn7nw",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wtxzt{content:attr(data-value em);}",
      "_a_4wtxzt",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4webvu{content:attr(data-value px);}",
      "_a_4webvu",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    ("._a_4w3vis{content:\"→\";}", "_a_4w3vis", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4w8i71{content:\"←\";}", "_a_4w8i71", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4wjm9f{content:\"↑\";}", "_a_4wjm9f", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4w8ulk{content:\"↓\";}", "_a_4w8ulk", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4wi5s9{content:\"“\";}", "_a_4wi5s9", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4wb13f{content:\"‘\";}", "_a_4wb13f", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4wn7fj{content:\"’\";}", "_a_4wn7fj", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4wwxr5{content:\"•\";}", "_a_4wwxr5", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4w5ir8{content:\"—\";}", "_a_4w5ir8", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4w17ng{content:\"…\";}", "_a_4w17ng", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4w8arn{content:\"♥\";}", "_a_4w8arn", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4wgzna{content:\"✓\";}", "_a_4wgzna", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4wy3yn{content:\"✗\";}", "_a_4wy3yn", "0,1,0 own", "176", 1, false)
  ];
  [@css
    (
      "._a_4wvyh0{content:\"\" attr(data-title) \"”\";}",
      "_a_4wvyh0",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4wnazq{content:\"→\" \" Click here\";}",
      "_a_4wnazq",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4w520c{content:\"Step \" counter(step, decimal) \": \";}",
      "_a_4w520c",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    ("._a_4we5sp{content:\"💡\";}", "_a_4we5sp", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4w561c{content:\"👍\";}", "_a_4w561c", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4wvc81{content:\"»\";}", "_a_4wvc81", "0,1,0 own", "176", 1, false)
  ];
  [@css
    ("._a_4w3v3e{content:\"§\";}", "_a_4w3v3e", "0,1,0 own", "176", 1, false)
  ];
  [@css
    (
      "._a_4wfv9f{content:\"→ \" attr(href);}",
      "_a_4wfv9f",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4w4efr{content:\"• \" counter(item, decimal) \" \";}",
      "_a_4w4efr",
      "0,1,0 own",
      "176",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (2, "", [0]),
      (4, "", [1]),
      (6, "", [2]),
      (8, "", [3]),
      (9, "", [4]),
      (10, "", [5]),
      (11, "", [6]),
      (14, "", [7]),
      (15, "", [8]),
      (18, "", [9]),
      (19, "", [10]),
      (20, "", [11]),
      (23, "", [12]),
      (26, "", [13]),
      (29, "", [14]),
      (30, "", [15]),
      (32, "", [16]),
      (33, "", [17]),
      (36, "", [18]),
      (37, "", [19]),
      (42, "", [20]),
      (43, "", [21]),
      (44, "", [22]),
      (45, "", [23]),
      (49, "", [24]),
      (50, "", [25]),
      (52, "", [26]),
      (55, "", [27]),
      (56, "", [28]),
      (57, "", [29]),
      (58, "", [30]),
      (59, "", [6]),
      (61, "", [31]),
      (62, "", [31]),
      (63, "", [31]),
      (64, "", [32]),
      (65, "", [32]),
      (66, "", [2]),
      (67, "", [33]),
      (68, "", [33]),
      (69, "", [2]),
      (70, "", [34]),
      (71, "", [35]),
      (74, "", [18]),
      (75, "", [36]),
      (85, "", [37]),
      (86, "", [38]),
      (87, "", [39]),
      (93, "", [40]),
      (94, "", [41]),
      (95, "", [42]),
      (96, "", [43]),
      (99, "", [44]),
      (102, "", [45]),
      (103, "", [46]),
      (106, "", [47]),
      (107, "", [48]),
      (108, "", [49]),
      (109, "", [50]),
      (110, "", [51]),
      (111, "", [52]),
      (112, "", [49]),
      (115, "", [53]),
      (116, "", [54]),
      (117, "", [55]),
      (120, "", [56]),
      (121, "", [57]),
      (124, "", [58]),
      (125, "", [59]),
      (128, "", [40]),
      (129, "", [33]),
      (132, "", [40]),
      (133, "", [47]),
      (134, "", [48]),
      (135, "", [49]),
      (136, "", [35]),
      (137, "", [35]),
      (138, "", [51]),
      (139, "", [50]),
      (140, "", [60]),
      (141, "", [61]),
    ]
  ];
  
  CSS.make("_a_9uidje", []);
  
  CSS.make("_a_4wf2ur", []);
  
  CSS.make("_a_4wsdc1", []);
  
  CSS.make("_a_4wdhko", []);
  CSS.make("_a_4wzbnh", []);
  CSS.make("_a_4w56qq", []);
  CSS.make("_a_4wd7tk", []);
  
  CSS.make("_a_4wordy", []);
  CSS.make("_a_4wzcbh", []);
  
  CSS.make("_a_4w1wxf", []);
  CSS.make("_a_4weiwy", []);
  CSS.make("_a_4wnydd", []);
  
  CSS.make("_a_4wu5b0", []);
  
  CSS.make("_a_4w6790", []);
  
  CSS.make("_a_4wr3ui", []);
  CSS.make("_a_4wxuxw", []);
  
  CSS.make("_a_4wwggo", []);
  CSS.make("_a_4w14i9", []);
  
  CSS.make("_a_4wn5wz", []);
  CSS.make("_a_4w2bce", []);
  
  CSS.make("_a_4wenc9", []);
  CSS.make("_a_4w0d5m", []);
  CSS.make("_a_4woxre", []);
  CSS.make("_a_4wyzsz", []);
  
  CSS.make("_a_4wq46n", []);
  CSS.make("_a_4wt6w1", []);
  
  CSS.make("_a_4wwmef", []);
  
  CSS.make("_a_4w1hfk", []);
  CSS.make("_a_4wslsq", []);
  CSS.make("_a_4wltxf", []);
  CSS.make("_a_4wtvgg", []);
  CSS.make("_a_4wd7tk", []);
  
  CSS.make("_a_4wks2k", []);
  CSS.make("_a_4wks2k", []);
  CSS.make("_a_4wks2k", []);
  CSS.make("_a_4wf07t", []);
  CSS.make("_a_4wf07t", []);
  CSS.make("_a_4wsdc1", []);
  CSS.make("_a_4wvtt9", []);
  CSS.make("_a_4wvtt9", []);
  CSS.make("_a_4wsdc1", []);
  CSS.make("_a_4w6l48", []);
  CSS.make("_a_4wu917", []);
  
  CSS.make("_a_4wn5wz", []);
  CSS.make("_a_4wwufj", []);
  
  CSS.make("_a_4wn7nw", []);
  CSS.make("_a_4wtxzt", []);
  CSS.make("_a_4webvu", []);
  
  CSS.make("_a_4w3vis", []);
  CSS.make("_a_4w8i71", []);
  CSS.make("_a_4wjm9f", []);
  CSS.make("_a_4w8ulk", []);
  
  CSS.make("_a_4wi5s9", []);
  
  CSS.make("_a_4wb13f", []);
  CSS.make("_a_4wn7fj", []);
  
  CSS.make("_a_4wwxr5", []);
  CSS.make("_a_4w5ir8", []);
  CSS.make("_a_4w17ng", []);
  CSS.make("_a_4w8arn", []);
  CSS.make("_a_4wgzna", []);
  CSS.make("_a_4wy3yn", []);
  CSS.make("_a_4w17ng", []);
  
  CSS.make("_a_4wvyh0", []);
  CSS.make("_a_4wnazq", []);
  CSS.make("_a_4w520c", []);
  
  CSS.make("_a_4we5sp", []);
  CSS.make("_a_4w561c", []);
  
  CSS.make("_a_4wvc81", []);
  CSS.make("_a_4w3v3e", []);
  
  CSS.make("_a_4w3vis", []);
  CSS.make("_a_4wvtt9", []);
  
  CSS.make("_a_4w3vis", []);
  CSS.make("_a_4wwxr5", []);
  CSS.make("_a_4w5ir8", []);
  CSS.make("_a_4w17ng", []);
  CSS.make("_a_4wu917", []);
  CSS.make("_a_4wu917", []);
  CSS.make("_a_4wgzna", []);
  CSS.make("_a_4w8arn", []);
  CSS.make("_a_4wfv9f", []);
  CSS.make("_a_4w4efr", []);
