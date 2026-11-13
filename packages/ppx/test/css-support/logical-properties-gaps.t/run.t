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
  [@css ".css-1rfuvyf{margin-block-start:auto;}"];
  [@css ".css-1rxp8to{margin-block-start:0;}"];
  [@css ".css-1r3hxok{margin-block-start:10%;}"];
  [@css ".css-d3l202{margin-block-start:calc(10px + 5%);}"];
  [@css ".css-rx9dbe{margin-block-end:auto;}"];
  [@css ".css-kginty{margin-block-end:0;}"];
  [@css ".css-18tum75{margin-block-end:10%;}"];
  [@css ".css-90jj7n{margin-block-end:calc(10px + 5%);}"];
  [@css
    ".css-cbuwcp{-webkit-margin-inline-start:auto;margin-inline-start:auto;}"
  ];
  [@css ".css-v6y1wi{-webkit-margin-inline-start:0;margin-inline-start:0;}"];
  [@css ".css-9uhllh{-webkit-margin-inline-start:10%;margin-inline-start:10%;}"];
  [@css
    ".css-17oe2og{-webkit-margin-inline-start:calc(10px + 5%);margin-inline-start:calc(10px + 5%);}"
  ];
  [@css ".css-1cuw3hj{-webkit-margin-inline-end:auto;margin-inline-end:auto;}"];
  [@css ".css-1mtqh6l{-webkit-margin-inline-end:0;margin-inline-end:0;}"];
  [@css ".css-5oi10q{-webkit-margin-inline-end:10%;margin-inline-end:10%;}"];
  [@css
    ".css-6a8wrs{-webkit-margin-inline-end:calc(10px + 5%);margin-inline-end:calc(10px + 5%);}"
  ];
  [@css ".css-25zgaa{padding-block-start:0;}"];
  [@css ".css-1h0i19l{padding-block-start:10%;}"];
  [@css ".css-18scq09{padding-block-start:calc(10px + 5%);}"];
  [@css ".css-9wlf1o{padding-block-end:0;}"];
  [@css ".css-1bemre8{padding-block-end:10%;}"];
  [@css ".css-1rbxk5g{padding-block-end:calc(10px + 5%);}"];
  [@css ".css-12syewt{-webkit-padding-inline-start:0;padding-inline-start:0;}"];
  [@css
    ".css-14o2vyd{-webkit-padding-inline-start:10%;padding-inline-start:10%;}"
  ];
  [@css
    ".css-119v36v{-webkit-padding-inline-start:calc(10px + 5%);padding-inline-start:calc(10px + 5%);}"
  ];
  [@css ".css-1iqoihg{-webkit-padding-inline-end:0;padding-inline-end:0;}"];
  [@css ".css-197frnt{-webkit-padding-inline-end:10%;padding-inline-end:10%;}"];
  [@css
    ".css-133xqun{-webkit-padding-inline-end:calc(10px + 5%);padding-inline-end:calc(10px + 5%);}"
  ];
  [@css ".css-tuvv7u{margin-block:auto auto;}"];
  [@css ".css-6gv15{margin-block:10px 20px;}"];
  [@css ".css-4ri6c6{margin-block:10% 20%;}"];
  [@css ".css-y21ccd{margin-inline:auto auto;}"];
  [@css ".css-ji0mni{margin-inline:10px 20px;}"];
  [@css ".css-18clsq3{margin-inline:10% 20%;}"];
  [@css ".css-uibpem{padding-block:10px 20px;}"];
  [@css ".css-q6mpzl{padding-block:10% 20%;}"];
  [@css ".css-34rdol{padding-inline:10px 20px;}"];
  [@css ".css-cdmsyx{padding-inline:10% 20%;}"];
  [@css ".css-6enj32{border-block-width:thin;}"];
  [@css ".css-1vqmv2{border-block-width:medium;}"];
  [@css ".css-1klfea4{border-block-width:thick;}"];
  [@css ".css-42tkty{border-block-width:2px;}"];
  [@css ".css-1cn4751{border-inline-width:thin;}"];
  [@css ".css-18oog6n{border-inline-width:medium;}"];
  [@css ".css-1wwh3xc{border-inline-width:thick;}"];
  [@css ".css-cg7k25{border-inline-width:2px;}"];
  [@css ".css-1e9bokm{border-block-style:none;}"];
  [@css ".css-15b8kih{border-block-style:solid;}"];
  [@css ".css-oei7uw{border-block-style:dashed;}"];
  [@css ".css-jicoyv{border-inline-style:none;}"];
  [@css ".css-1apoofy{border-inline-style:solid;}"];
  [@css ".css-1uvj0mf{border-inline-style:dashed;}"];
  [@css.classes
    [
      ("css-1rfuvyf", 0, "", "input.re", 4, 8, 4, 32),
      ("css-1rxp8to", 1, "", "input.re", 5, 8, 5, 29),
      ("css-1r3hxok", 2, "", "input.re", 6, 8, 6, 31),
      ("css-d3l202", 3, "", "input.re", 7, 8, 7, 43),
      ("css-rx9dbe", 4, "", "input.re", 8, 8, 8, 30),
      ("css-kginty", 5, "", "input.re", 9, 8, 9, 27),
      ("css-18tum75", 6, "", "input.re", 10, 8, 10, 29),
      ("css-90jj7n", 7, "", "input.re", 11, 8, 11, 41),
      ("css-cbuwcp", 8, "", "input.re", 14, 8, 14, 33),
      ("css-v6y1wi", 9, "", "input.re", 15, 8, 15, 30),
      ("css-9uhllh", 10, "", "input.re", 16, 8, 16, 32),
      ("css-17oe2og", 11, "", "input.re", 17, 8, 17, 44),
      ("css-1cuw3hj", 12, "", "input.re", 18, 8, 18, 31),
      ("css-1mtqh6l", 13, "", "input.re", 19, 8, 19, 28),
      ("css-5oi10q", 14, "", "input.re", 20, 8, 20, 30),
      ("css-6a8wrs", 15, "", "input.re", 21, 8, 21, 42),
      ("css-25zgaa", 16, "", "input.re", 24, 8, 24, 30),
      ("css-1h0i19l", 17, "", "input.re", 25, 8, 25, 32),
      ("css-18scq09", 18, "", "input.re", 26, 8, 26, 44),
      ("css-9wlf1o", 19, "", "input.re", 27, 8, 27, 28),
      ("css-1bemre8", 20, "", "input.re", 28, 8, 28, 30),
      ("css-1rbxk5g", 21, "", "input.re", 29, 8, 29, 42),
      ("css-12syewt", 22, "", "input.re", 32, 8, 32, 31),
      ("css-14o2vyd", 23, "", "input.re", 33, 8, 33, 33),
      ("css-119v36v", 24, "", "input.re", 34, 8, 34, 45),
      ("css-1iqoihg", 25, "", "input.re", 35, 8, 35, 29),
      ("css-197frnt", 26, "", "input.re", 36, 8, 36, 31),
      ("css-133xqun", 27, "", "input.re", 37, 8, 37, 43),
      ("css-tuvv7u", 28, "", "input.re", 40, 8, 40, 31),
      ("css-6gv15", 29, "", "input.re", 41, 8, 41, 31),
      ("css-4ri6c6", 30, "", "input.re", 42, 8, 42, 29),
      ("css-y21ccd", 31, "", "input.re", 43, 8, 43, 32),
      ("css-ji0mni", 32, "", "input.re", 44, 8, 44, 32),
      ("css-18clsq3", 33, "", "input.re", 45, 8, 45, 30),
      ("css-uibpem", 34, "", "input.re", 48, 8, 48, 32),
      ("css-q6mpzl", 35, "", "input.re", 49, 8, 49, 30),
      ("css-34rdol", 36, "", "input.re", 50, 8, 50, 33),
      ("css-cdmsyx", 37, "", "input.re", 51, 8, 51, 31),
      ("css-6enj32", 38, "", "input.re", 54, 8, 54, 32),
      ("css-1vqmv2", 39, "", "input.re", 55, 8, 55, 34),
      ("css-1klfea4", 40, "", "input.re", 56, 8, 56, 33),
      ("css-42tkty", 41, "", "input.re", 57, 8, 57, 31),
      ("css-1cn4751", 42, "", "input.re", 58, 8, 58, 33),
      ("css-18oog6n", 43, "", "input.re", 59, 8, 59, 35),
      ("css-1wwh3xc", 44, "", "input.re", 60, 8, 60, 34),
      ("css-cg7k25", 45, "", "input.re", 61, 8, 61, 32),
      ("css-1e9bokm", 46, "", "input.re", 64, 8, 64, 32),
      ("css-15b8kih", 47, "", "input.re", 65, 8, 65, 33),
      ("css-oei7uw", 48, "", "input.re", 66, 8, 66, 34),
      ("css-jicoyv", 49, "", "input.re", 67, 8, 67, 33),
      ("css-1apoofy", 50, "", "input.re", 68, 8, 68, 34),
      ("css-1uvj0mf", 51, "", "input.re", 69, 8, 69, 35),
    ]
  ];
  
  CSS.make("css-1rfuvyf", []);
  CSS.make("css-1rxp8to", []);
  CSS.make("css-1r3hxok", []);
  CSS.make("css-d3l202", []);
  CSS.make("css-rx9dbe", []);
  CSS.make("css-kginty", []);
  CSS.make("css-18tum75", []);
  CSS.make("css-90jj7n", []);
  
  CSS.make("css-cbuwcp", []);
  CSS.make("css-v6y1wi", []);
  CSS.make("css-9uhllh", []);
  CSS.make("css-17oe2og", []);
  CSS.make("css-1cuw3hj", []);
  CSS.make("css-1mtqh6l", []);
  CSS.make("css-5oi10q", []);
  CSS.make("css-6a8wrs", []);
  
  CSS.make("css-25zgaa", []);
  CSS.make("css-1h0i19l", []);
  CSS.make("css-18scq09", []);
  CSS.make("css-9wlf1o", []);
  CSS.make("css-1bemre8", []);
  CSS.make("css-1rbxk5g", []);
  
  CSS.make("css-12syewt", []);
  CSS.make("css-14o2vyd", []);
  CSS.make("css-119v36v", []);
  CSS.make("css-1iqoihg", []);
  CSS.make("css-197frnt", []);
  CSS.make("css-133xqun", []);
  
  CSS.make("css-tuvv7u", []);
  CSS.make("css-6gv15", []);
  CSS.make("css-4ri6c6", []);
  CSS.make("css-y21ccd", []);
  CSS.make("css-ji0mni", []);
  CSS.make("css-18clsq3", []);
  
  CSS.make("css-uibpem", []);
  CSS.make("css-q6mpzl", []);
  CSS.make("css-34rdol", []);
  CSS.make("css-cdmsyx", []);
  
  CSS.make("css-6enj32", []);
  CSS.make("css-1vqmv2", []);
  CSS.make("css-1klfea4", []);
  CSS.make("css-42tkty", []);
  CSS.make("css-1cn4751", []);
  CSS.make("css-18oog6n", []);
  CSS.make("css-1wwh3xc", []);
  CSS.make("css-cg7k25", []);
  
  CSS.make("css-1e9bokm", []);
  CSS.make("css-15b8kih", []);
  CSS.make("css-oei7uw", []);
  CSS.make("css-jicoyv", []);
  CSS.make("css-1apoofy", []);
  CSS.make("css-1uvj0mf", []);
