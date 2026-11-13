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
  [@css ".css-1usn6q9{quotes:auto;}"];
  [@css ".css-13xdc2d{content:\"►\" / \"\";}"];
  [@css ".css-rt27hf{content:\"\";}"];
  [@css ".css-1ctyp49{content:counter(ol);}"];
  [@css ".css-1d95qw{content:counter(count, decimal);}"];
  [@css ".css-184h2k7{content:counter(count, decimal) \") \";}"];
  [@css ".css-jz4n4r{content:unset;}"];
  [@css ".css-u6eeqw{content:normal;}"];
  [@css ".css-172jc2{content:none;}"];
  [@css ".css-ybnohc{content:url(\"http://www.example.com/test.png\");}"];
  [@css ".css-xnyrnj{content:linear-gradient(#e66465, #9198e5);}"];
  [@css
    ".css-8a36sc{content:image-set(\"image1x.png\" 1x, \"image2x.png\" 2x);}"
  ];
  [@css
    ".css-1qxz1io{content:url(\"../img/test.png\") / \"This is the alt text\";}"
  ];
  [@css ".css-1wngitz{content:\"unparsed text\";}"];
  [@css ".css-9h22hh{content:counter(chapter_counter);}"];
  [@css ".css-pupmhd{content:counter(chapter_counter, upper-roman);}"];
  [@css ".css-eem3m5{content:counters(section_counter, \".\");}"];
  [@css
    ".css-nweax9{content:counters(section_counter, \".\", decimal-leading-zero);}"
  ];
  [@css ".css-priag6{content:attr(href);}"];
  [@css ".css-7bhdf8{content:attr(data-width px);}"];
  [@css ".css-1fzmhk4{content:open-quote;}"];
  [@css ".css-5ndsm5{content:close-quote;}"];
  [@css ".css-s1abl{content:no-open-quote;}"];
  [@css ".css-cc3cxl{content:no-close-quote;}"];
  [@css
    ".css-1ffanlr{content:\"prefix\" url(\"http://www.example.com/test.png\");}"
  ];
  [@css
    ".css-1jqdlp8{content:\"prefix\" url(\"/img/test.png\") \"suffix\" / \"Alt text\";}"
  ];
  [@css ".css-1ucniqo{content:open-quote counter(chapter_counter);}"];
  [@css ".css-1uwaktx{content:inherit;}"];
  [@css ".css-lpyx9a{content:initial;}"];
  [@css ".css-1i33jyp{content:revert;}"];
  [@css ".css-45efc4{content:revert-layer;}"];
  [@css ".css-asqm85{content:\"点\";}"];
  [@css ".css-15dyzja{content:\"lola\";}"];
  [@css ".css-2g6b05{content:\" \";}"];
  [@css ".css-1haxvj9{content:\"'\";}"];
  [@css ".css-s4tp6r{content:\"\\\"\";}"];
  [@css ".css-1bi6xz8{content:attr(data-value);}"];
  [@css ".css-1ogk08y{content:attr(data-value raw-string);}"];
  [@css ".css-1et8luo{content:attr(data-value em);}"];
  [@css ".css-1f58p9o{content:attr(data-value px);}"];
  [@css ".css-1jo6m3p{content:\"→\";}"];
  [@css ".css-jcwdba{content:\"←\";}"];
  [@css ".css-iwr74j{content:\"↑\";}"];
  [@css ".css-nm383r{content:\"↓\";}"];
  [@css ".css-dv08zd{content:\"“\";}"];
  [@css ".css-k1w3nz{content:\"‘\";}"];
  [@css ".css-5bsgvi{content:\"’\";}"];
  [@css ".css-1ksgvn4{content:\"•\";}"];
  [@css ".css-oxjx5m{content:\"—\";}"];
  [@css ".css-1auok8l{content:\"…\";}"];
  [@css ".css-fpar79{content:\"♥\";}"];
  [@css ".css-1o0vz3{content:\"✓\";}"];
  [@css ".css-uggraj{content:\"✗\";}"];
  [@css ".css-hurp6q{content:\"✦\";}"];
  [@css ".css-1ubglno{content:\"\" attr(data-title) \"”\";}"];
  [@css ".css-yca53a{content:\"→\" \" Click here\";}"];
  [@css ".css-1hppqb2{content:\"Step \" counter(step, decimal) \": \";}"];
  [@css ".css-arhbzx{content:\"💡\";}"];
  [@css ".css-5mbd92{content:\"👍\";}"];
  [@css ".css-1hyabep{content:\"»\";}"];
  [@css ".css-5eo2m8{content:\"§\";}"];
  [@css ".css-1evdeaz{content:\"→ \" attr(href);}"];
  [@css ".css-1o9e4it{content:\"• \" counter(item, decimal) \" \";}"];
  [@css.classes
    [
      ("css-1usn6q9", 0, "", "input.re", 2, 8, 2, 20),
      ("css-13xdc2d", 1, "", "input.re", 4, 8, 4, 29),
      ("css-rt27hf", 2, "", "input.re", 6, 8, 6, 20),
      ("css-1ctyp49", 3, "", "input.re", 8, 8, 8, 29),
      ("css-1d95qw", 4, "", "input.re", 9, 8, 9, 41),
      ("css-184h2k7", 5, "", "input.re", 10, 8, 10, 46),
      ("css-jz4n4r", 6, "", "input.re", 11, 8, 11, 23),
      ("css-u6eeqw", 7, "", "input.re", 14, 8, 14, 24),
      ("css-172jc2", 8, "", "input.re", 15, 8, 15, 22),
      ("css-ybnohc", 9, "", "input.re", 18, 8, 18, 56),
      ("css-xnyrnj", 10, "", "input.re", 19, 8, 19, 51),
      ("css-8a36sc", 11, "", "input.re", 20, 8, 20, 63),
      ("css-1qxz1io", 12, "", "input.re", 23, 8, 23, 65),
      ("css-1wngitz", 13, "", "input.re", 26, 8, 26, 33),
      ("css-9h22hh", 14, "", "input.re", 29, 8, 29, 42),
      ("css-pupmhd", 15, "", "input.re", 30, 8, 30, 55),
      ("css-eem3m5", 16, "", "input.re", 32, 8, 32, 48),
      ("css-nweax9", 17, "", "input.re", 33, 8, 33, 70),
      ("css-priag6", 18, "", "input.re", 36, 8, 36, 28),
      ("css-7bhdf8", 19, "", "input.re", 37, 8, 37, 37),
      ("css-1fzmhk4", 20, "", "input.re", 42, 8, 42, 28),
      ("css-5ndsm5", 21, "", "input.re", 43, 8, 43, 29),
      ("css-s1abl", 22, "", "input.re", 44, 8, 44, 31),
      ("css-cc3cxl", 23, "", "input.re", 45, 8, 45, 32),
      ("css-1ffanlr", 24, "", "input.re", 49, 8, 49, 63),
      ("css-1jqdlp8", 25, "", "input.re", 50, 8, 50, 69),
      ("css-1ucniqo", 26, "", "input.re", 52, 8, 52, 53),
      ("css-1uwaktx", 27, "", "input.re", 55, 8, 55, 25),
      ("css-lpyx9a", 28, "", "input.re", 56, 8, 56, 25),
      ("css-1i33jyp", 29, "", "input.re", 57, 8, 57, 24),
      ("css-45efc4", 30, "", "input.re", 58, 8, 58, 30),
      ("css-asqm85", 31, "", "input.re", 61, 7, 61, 20),
      ("css-15dyzja", 32, "", "input.re", 64, 8, 64, 24),
      ("css-2g6b05", 33, "", "input.re", 67, 8, 67, 21),
      ("css-1haxvj9", 34, "", "input.re", 70, 8, 70, 21),
      ("css-s4tp6r", 35, "", "input.re", 71, 8, 71, 21),
      ("css-1bi6xz8", 36, "", "input.re", 75, 8, 75, 34),
      ("css-1ogk08y", 37, "", "input.re", 85, 8, 85, 45),
      ("css-1et8luo", 38, "", "input.re", 86, 8, 86, 37),
      ("css-1f58p9o", 39, "", "input.re", 87, 8, 87, 37),
      ("css-1jo6m3p", 40, "", "input.re", 93, 8, 93, 25),
      ("css-jcwdba", 41, "", "input.re", 94, 8, 94, 25),
      ("css-iwr74j", 42, "", "input.re", 95, 8, 95, 25),
      ("css-nm383r", 43, "", "input.re", 96, 8, 96, 25),
      ("css-dv08zd", 44, "", "input.re", 99, 8, 99, 25),
      ("css-k1w3nz", 45, "", "input.re", 102, 8, 102, 25),
      ("css-5bsgvi", 46, "", "input.re", 103, 8, 103, 25),
      ("css-1ksgvn4", 47, "", "input.re", 106, 8, 106, 25),
      ("css-oxjx5m", 48, "", "input.re", 107, 8, 107, 25),
      ("css-1auok8l", 49, "", "input.re", 108, 8, 108, 25),
      ("css-fpar79", 50, "", "input.re", 109, 8, 109, 25),
      ("css-1o0vz3", 51, "", "input.re", 110, 8, 110, 25),
      ("css-uggraj", 52, "", "input.re", 111, 8, 111, 25),
      ("css-hurp6q", 53, "", "input.re", 112, 8, 112, 25),
      ("css-1ubglno", 54, "", "input.re", 115, 8, 115, 45),
      ("css-yca53a", 55, "", "input.re", 116, 8, 116, 39),
      ("css-1hppqb2", 56, "", "input.re", 117, 8, 117, 53),
      ("css-arhbzx", 57, "", "input.re", 120, 8, 120, 26),
      ("css-5mbd92", 58, "", "input.re", 121, 8, 121, 26),
      ("css-1hyabep", 59, "", "input.re", 124, 8, 124, 25),
      ("css-5eo2m8", 60, "", "input.re", 125, 8, 125, 25),
      ("css-1evdeaz", 61, "", "input.re", 140, 8, 140, 33),
      ("css-1o9e4it", 62, "", "input.re", 141, 8, 141, 49),
    ]
  ];
  
  CSS.make("css-1usn6q9", []);
  
  CSS.make("css-13xdc2d", []);
  
  CSS.make("css-rt27hf", []);
  
  CSS.make("css-1ctyp49", []);
  CSS.make("css-1d95qw", []);
  CSS.make("css-184h2k7", []);
  CSS.make("css-jz4n4r", []);
  
  CSS.make("css-u6eeqw", []);
  CSS.make("css-172jc2", []);
  
  CSS.make("css-ybnohc", []);
  CSS.make("css-xnyrnj", []);
  CSS.make("css-8a36sc", []);
  
  CSS.make("css-1qxz1io", []);
  
  CSS.make("css-1wngitz", []);
  
  CSS.make("css-9h22hh", []);
  CSS.make("css-pupmhd", []);
  
  CSS.make("css-eem3m5", []);
  CSS.make("css-nweax9", []);
  
  CSS.make("css-priag6", []);
  CSS.make("css-7bhdf8", []);
  
  CSS.make("css-1fzmhk4", []);
  CSS.make("css-5ndsm5", []);
  CSS.make("css-s1abl", []);
  CSS.make("css-cc3cxl", []);
  
  CSS.make("css-1ffanlr", []);
  CSS.make("css-1jqdlp8", []);
  
  CSS.make("css-1ucniqo", []);
  
  CSS.make("css-1uwaktx", []);
  CSS.make("css-lpyx9a", []);
  CSS.make("css-1i33jyp", []);
  CSS.make("css-45efc4", []);
  CSS.make("css-jz4n4r", []);
  
  CSS.make("css-asqm85", []);
  CSS.make("css-asqm85", []);
  CSS.make("css-asqm85", []);
  CSS.make("css-15dyzja", []);
  CSS.make("css-15dyzja", []);
  CSS.make("css-rt27hf", []);
  CSS.make("css-2g6b05", []);
  CSS.make("css-2g6b05", []);
  CSS.make("css-rt27hf", []);
  CSS.make("css-1haxvj9", []);
  CSS.make("css-s4tp6r", []);
  
  CSS.make("css-priag6", []);
  CSS.make("css-1bi6xz8", []);
  
  CSS.make("css-1ogk08y", []);
  CSS.make("css-1et8luo", []);
  CSS.make("css-1f58p9o", []);
  
  CSS.make("css-1jo6m3p", []);
  CSS.make("css-jcwdba", []);
  CSS.make("css-iwr74j", []);
  CSS.make("css-nm383r", []);
  
  CSS.make("css-dv08zd", []);
  
  CSS.make("css-k1w3nz", []);
  CSS.make("css-5bsgvi", []);
  
  CSS.make("css-1ksgvn4", []);
  CSS.make("css-oxjx5m", []);
  CSS.make("css-1auok8l", []);
  CSS.make("css-fpar79", []);
  CSS.make("css-1o0vz3", []);
  CSS.make("css-uggraj", []);
  CSS.make("css-hurp6q", []);
  
  CSS.make("css-1ubglno", []);
  CSS.make("css-yca53a", []);
  CSS.make("css-1hppqb2", []);
  
  CSS.make("css-arhbzx", []);
  CSS.make("css-5mbd92", []);
  
  CSS.make("css-1hyabep", []);
  CSS.make("css-5eo2m8", []);
  
  CSS.make("css-1jo6m3p", []);
  CSS.make("css-2g6b05", []);
  
  CSS.make("css-1jo6m3p", []);
  CSS.make("css-1ksgvn4", []);
  CSS.make("css-oxjx5m", []);
  CSS.make("css-1auok8l", []);
  CSS.make("css-s4tp6r", []);
  CSS.make("css-s4tp6r", []);
  CSS.make("css-1o0vz3", []);
  CSS.make("css-fpar79", []);
  CSS.make("css-1evdeaz", []);
  CSS.make("css-1o9e4it", []);
