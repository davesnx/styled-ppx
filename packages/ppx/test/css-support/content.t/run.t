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
  [@css ".css-ivpc6q9{quotes:auto;}"];
  [@css ".css-ivpcc2d{content:\"►\" / \"\";}"];
  [@css ".css-ivpc7hf{content:\"\";}"];
  [@css ".css-ivpcp49{content:counter(ol);}"];
  [@css ".css-ivpc5qw{content:counter(count, decimal);}"];
  [@css ".css-ivpc2k7{content:counter(count, decimal) \") \";}"];
  [@css ".css-ivpcn4r{content:unset;}"];
  [@css ".css-ivpceqw{content:normal;}"];
  [@css ".css-ivpcjc2{content:none;}"];
  [@css ".css-ivpcohc{content:url(\"http://www.example.com/test.png\");}"];
  [@css ".css-ivpcrnj{content:linear-gradient(#e66465, #9198e5);}"];
  [@css
    ".css-ivpc6sc{content:image-set(\"image1x.png\" 1x, \"image2x.png\" 2x);}"
  ];
  [@css
    ".css-ivpc1io{content:url(\"../img/test.png\") / \"This is the alt text\";}"
  ];
  [@css ".css-ivpcitz{content:\"unparsed text\";}"];
  [@css ".css-ivpc2hh{content:counter(chapter_counter);}"];
  [@css ".css-ivpcmhd{content:counter(chapter_counter, upper-roman);}"];
  [@css ".css-ivpc3m5{content:counters(section_counter, \".\");}"];
  [@css
    ".css-ivpcax9{content:counters(section_counter, \".\", decimal-leading-zero);}"
  ];
  [@css ".css-ivpcag6{content:attr(href);}"];
  [@css ".css-ivpcdf8{content:attr(data-width px);}"];
  [@css ".css-ivpchk4{content:open-quote;}"];
  [@css ".css-ivpcsm5{content:close-quote;}"];
  [@css ".css-ivpcabl{content:no-open-quote;}"];
  [@css ".css-ivpccxl{content:no-close-quote;}"];
  [@css
    ".css-ivpcnlr{content:\"prefix\" url(\"http://www.example.com/test.png\");}"
  ];
  [@css
    ".css-ivpclp8{content:\"prefix\" url(\"/img/test.png\") \"suffix\" / \"Alt text\";}"
  ];
  [@css ".css-ivpciqo{content:open-quote counter(chapter_counter);}"];
  [@css ".css-ivpcktx{content:inherit;}"];
  [@css ".css-ivpcx9a{content:initial;}"];
  [@css ".css-ivpcjyp{content:revert;}"];
  [@css ".css-ivpcfc4{content:revert-layer;}"];
  [@css ".css-ivpcm85{content:\"点\";}"];
  [@css ".css-ivpczja{content:\"lola\";}"];
  [@css ".css-ivpcb05{content:\" \";}"];
  [@css ".css-ivpcvj9{content:\"'\";}"];
  [@css ".css-ivpcp6r{content:\"\\\"\";}"];
  [@css ".css-ivpcxz8{content:attr(data-value);}"];
  [@css ".css-ivpc08y{content:attr(data-value raw-string);}"];
  [@css ".css-ivpcluo{content:attr(data-value em);}"];
  [@css ".css-ivpcp9o{content:attr(data-value px);}"];
  [@css ".css-ivpcm3p{content:\"→\";}"];
  [@css ".css-ivpcdba{content:\"←\";}"];
  [@css ".css-ivpc74j{content:\"↑\";}"];
  [@css ".css-ivpc83r{content:\"↓\";}"];
  [@css ".css-ivpc8zd{content:\"“\";}"];
  [@css ".css-ivpc3nz{content:\"‘\";}"];
  [@css ".css-ivpcgvi{content:\"’\";}"];
  [@css ".css-ivpcvn4{content:\"•\";}"];
  [@css ".css-ivpcx5m{content:\"—\";}"];
  [@css ".css-ivpck8l{content:\"…\";}"];
  [@css ".css-ivpcr79{content:\"♥\";}"];
  [@css ".css-ivpcvz3{content:\"✓\";}"];
  [@css ".css-ivpcraj{content:\"✗\";}"];
  [@css ".css-ivpcp6q{content:\"✦\";}"];
  [@css ".css-ivpclno{content:\"\" attr(data-title) \"”\";}"];
  [@css ".css-ivpc53a{content:\"→\" \" Click here\";}"];
  [@css ".css-ivpcqb2{content:\"Step \" counter(step, decimal) \": \";}"];
  [@css ".css-ivpcbzx{content:\"💡\";}"];
  [@css ".css-ivpcd92{content:\"👍\";}"];
  [@css ".css-ivpcbep{content:\"»\";}"];
  [@css ".css-ivpc2m8{content:\"§\";}"];
  [@css ".css-ivpceaz{content:\"→ \" attr(href);}"];
  [@css ".css-ivpc4it{content:\"• \" counter(item, decimal) \" \";}"];
  [@css.classes
    [
      ("css-ivpc6q9", 0, "", "input.re", 2, 8, 2, 20),
      ("css-ivpcc2d", 1, "", "input.re", 4, 8, 4, 29),
      ("css-ivpc7hf", 2, "", "input.re", 6, 8, 6, 20),
      ("css-ivpcp49", 3, "", "input.re", 8, 8, 8, 29),
      ("css-ivpc5qw", 4, "", "input.re", 9, 8, 9, 41),
      ("css-ivpc2k7", 5, "", "input.re", 10, 8, 10, 46),
      ("css-ivpcn4r", 6, "", "input.re", 11, 8, 11, 23),
      ("css-ivpceqw", 7, "", "input.re", 14, 8, 14, 24),
      ("css-ivpcjc2", 8, "", "input.re", 15, 8, 15, 22),
      ("css-ivpcohc", 9, "", "input.re", 18, 8, 18, 56),
      ("css-ivpcrnj", 10, "", "input.re", 19, 8, 19, 51),
      ("css-ivpc6sc", 11, "", "input.re", 20, 8, 20, 63),
      ("css-ivpc1io", 12, "", "input.re", 23, 8, 23, 65),
      ("css-ivpcitz", 13, "", "input.re", 26, 8, 26, 33),
      ("css-ivpc2hh", 14, "", "input.re", 29, 8, 29, 42),
      ("css-ivpcmhd", 15, "", "input.re", 30, 8, 30, 55),
      ("css-ivpc3m5", 16, "", "input.re", 32, 8, 32, 48),
      ("css-ivpcax9", 17, "", "input.re", 33, 8, 33, 70),
      ("css-ivpcag6", 18, "", "input.re", 36, 8, 36, 28),
      ("css-ivpcdf8", 19, "", "input.re", 37, 8, 37, 37),
      ("css-ivpchk4", 20, "", "input.re", 42, 8, 42, 28),
      ("css-ivpcsm5", 21, "", "input.re", 43, 8, 43, 29),
      ("css-ivpcabl", 22, "", "input.re", 44, 8, 44, 31),
      ("css-ivpccxl", 23, "", "input.re", 45, 8, 45, 32),
      ("css-ivpcnlr", 24, "", "input.re", 49, 8, 49, 63),
      ("css-ivpclp8", 25, "", "input.re", 50, 8, 50, 69),
      ("css-ivpciqo", 26, "", "input.re", 52, 8, 52, 53),
      ("css-ivpcktx", 27, "", "input.re", 55, 8, 55, 25),
      ("css-ivpcx9a", 28, "", "input.re", 56, 8, 56, 25),
      ("css-ivpcjyp", 29, "", "input.re", 57, 8, 57, 24),
      ("css-ivpcfc4", 30, "", "input.re", 58, 8, 58, 30),
      ("css-ivpcm85", 31, "", "input.re", 61, 7, 61, 20),
      ("css-ivpczja", 32, "", "input.re", 64, 8, 64, 24),
      ("css-ivpcb05", 33, "", "input.re", 67, 8, 67, 21),
      ("css-ivpcvj9", 34, "", "input.re", 70, 8, 70, 21),
      ("css-ivpcp6r", 35, "", "input.re", 71, 8, 71, 21),
      ("css-ivpcxz8", 36, "", "input.re", 75, 8, 75, 34),
      ("css-ivpc08y", 37, "", "input.re", 85, 8, 85, 45),
      ("css-ivpcluo", 38, "", "input.re", 86, 8, 86, 37),
      ("css-ivpcp9o", 39, "", "input.re", 87, 8, 87, 37),
      ("css-ivpcm3p", 40, "", "input.re", 93, 8, 93, 25),
      ("css-ivpcdba", 41, "", "input.re", 94, 8, 94, 25),
      ("css-ivpc74j", 42, "", "input.re", 95, 8, 95, 25),
      ("css-ivpc83r", 43, "", "input.re", 96, 8, 96, 25),
      ("css-ivpc8zd", 44, "", "input.re", 99, 8, 99, 25),
      ("css-ivpc3nz", 45, "", "input.re", 102, 8, 102, 25),
      ("css-ivpcgvi", 46, "", "input.re", 103, 8, 103, 25),
      ("css-ivpcvn4", 47, "", "input.re", 106, 8, 106, 25),
      ("css-ivpcx5m", 48, "", "input.re", 107, 8, 107, 25),
      ("css-ivpck8l", 49, "", "input.re", 108, 8, 108, 25),
      ("css-ivpcr79", 50, "", "input.re", 109, 8, 109, 25),
      ("css-ivpcvz3", 51, "", "input.re", 110, 8, 110, 25),
      ("css-ivpcraj", 52, "", "input.re", 111, 8, 111, 25),
      ("css-ivpcp6q", 53, "", "input.re", 112, 8, 112, 25),
      ("css-ivpclno", 54, "", "input.re", 115, 8, 115, 45),
      ("css-ivpc53a", 55, "", "input.re", 116, 8, 116, 39),
      ("css-ivpcqb2", 56, "", "input.re", 117, 8, 117, 53),
      ("css-ivpcbzx", 57, "", "input.re", 120, 8, 120, 26),
      ("css-ivpcd92", 58, "", "input.re", 121, 8, 121, 26),
      ("css-ivpcbep", 59, "", "input.re", 124, 8, 124, 25),
      ("css-ivpc2m8", 60, "", "input.re", 125, 8, 125, 25),
      ("css-ivpceaz", 61, "", "input.re", 140, 8, 140, 33),
      ("css-ivpc4it", 62, "", "input.re", 141, 8, 141, 49),
    ]
  ];
  
  CSS.make("css-ivpc6q9", []);
  
  CSS.make("css-ivpcc2d", []);
  
  CSS.make("css-ivpc7hf", []);
  
  CSS.make("css-ivpcp49", []);
  CSS.make("css-ivpc5qw", []);
  CSS.make("css-ivpc2k7", []);
  CSS.make("css-ivpcn4r", []);
  
  CSS.make("css-ivpceqw", []);
  CSS.make("css-ivpcjc2", []);
  
  CSS.make("css-ivpcohc", []);
  CSS.make("css-ivpcrnj", []);
  CSS.make("css-ivpc6sc", []);
  
  CSS.make("css-ivpc1io", []);
  
  CSS.make("css-ivpcitz", []);
  
  CSS.make("css-ivpc2hh", []);
  CSS.make("css-ivpcmhd", []);
  
  CSS.make("css-ivpc3m5", []);
  CSS.make("css-ivpcax9", []);
  
  CSS.make("css-ivpcag6", []);
  CSS.make("css-ivpcdf8", []);
  
  CSS.make("css-ivpchk4", []);
  CSS.make("css-ivpcsm5", []);
  CSS.make("css-ivpcabl", []);
  CSS.make("css-ivpccxl", []);
  
  CSS.make("css-ivpcnlr", []);
  CSS.make("css-ivpclp8", []);
  
  CSS.make("css-ivpciqo", []);
  
  CSS.make("css-ivpcktx", []);
  CSS.make("css-ivpcx9a", []);
  CSS.make("css-ivpcjyp", []);
  CSS.make("css-ivpcfc4", []);
  CSS.make("css-ivpcn4r", []);
  
  CSS.make("css-ivpcm85", []);
  CSS.make("css-ivpcm85", []);
  CSS.make("css-ivpcm85", []);
  CSS.make("css-ivpczja", []);
  CSS.make("css-ivpczja", []);
  CSS.make("css-ivpc7hf", []);
  CSS.make("css-ivpcb05", []);
  CSS.make("css-ivpcb05", []);
  CSS.make("css-ivpc7hf", []);
  CSS.make("css-ivpcvj9", []);
  CSS.make("css-ivpcp6r", []);
  
  CSS.make("css-ivpcag6", []);
  CSS.make("css-ivpcxz8", []);
  
  CSS.make("css-ivpc08y", []);
  CSS.make("css-ivpcluo", []);
  CSS.make("css-ivpcp9o", []);
  
  CSS.make("css-ivpcm3p", []);
  CSS.make("css-ivpcdba", []);
  CSS.make("css-ivpc74j", []);
  CSS.make("css-ivpc83r", []);
  
  CSS.make("css-ivpc8zd", []);
  
  CSS.make("css-ivpc3nz", []);
  CSS.make("css-ivpcgvi", []);
  
  CSS.make("css-ivpcvn4", []);
  CSS.make("css-ivpcx5m", []);
  CSS.make("css-ivpck8l", []);
  CSS.make("css-ivpcr79", []);
  CSS.make("css-ivpcvz3", []);
  CSS.make("css-ivpcraj", []);
  CSS.make("css-ivpcp6q", []);
  
  CSS.make("css-ivpclno", []);
  CSS.make("css-ivpc53a", []);
  CSS.make("css-ivpcqb2", []);
  
  CSS.make("css-ivpcbzx", []);
  CSS.make("css-ivpcd92", []);
  
  CSS.make("css-ivpcbep", []);
  CSS.make("css-ivpc2m8", []);
  
  CSS.make("css-ivpcm3p", []);
  CSS.make("css-ivpcb05", []);
  
  CSS.make("css-ivpcm3p", []);
  CSS.make("css-ivpcvn4", []);
  CSS.make("css-ivpcx5m", []);
  CSS.make("css-ivpck8l", []);
  CSS.make("css-ivpcp6r", []);
  CSS.make("css-ivpcp6r", []);
  CSS.make("css-ivpcvz3", []);
  CSS.make("css-ivpcr79", []);
  CSS.make("css-ivpceaz", []);
  CSS.make("css-ivpc4it", []);
