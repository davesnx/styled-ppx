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
  [@css ".css-jf1x3e{box-sizing:border-box;}"];
  [@css ".css-1pg8tz0{box-sizing:content-box;}"];
  [@css ".css-1vwj0y4{outline-style:auto;}"];
  [@css ".css-19a2wke{outline-style:none;}"];
  [@css ".css-1yeszy0{outline-style:dotted;}"];
  [@css ".css-qlixb4{outline-style:dashed;}"];
  [@css ".css-t9d6q1{outline-style:solid;}"];
  [@css ".css-6s7u18{outline-style:double;}"];
  [@css ".css-uz4n3j{outline-style:groove;}"];
  [@css ".css-edy3oc{outline-style:ridge;}"];
  [@css ".css-o77wr5{outline-style:inset;}"];
  [@css ".css-i2akwd{outline-style:outset;}"];
  [@css ".css-ywvp9z{outline-offset:-5px;}"];
  [@css ".css-1pth5s1{outline-offset:0;}"];
  [@css ".css-iy4atl{outline-offset:5px;}"];
  [@css ".css-19sgvj{resize:none;}"];
  [@css ".css-ovijqk{resize:both;}"];
  [@css ".css-ixfsj6{resize:horizontal;}"];
  [@css ".css-1kg8tw2{resize:vertical;}"];
  [@css ".css-1usgsdf{text-overflow:clip;}"];
  [@css ".css-4r8ugr{text-overflow:ellipsis;}"];
  [@css ".css-coajd1{cursor:default;}"];
  [@css ".css-1mge6mj{cursor:none;}"];
  [@css ".css-32xbc8{cursor:context-menu;}"];
  [@css ".css-1rv04z{cursor:cell;}"];
  [@css ".css-6hyi1y{cursor:vertical-text;}"];
  [@css ".css-dasf0w{cursor:alias;}"];
  [@css ".css-1ogmf5t{cursor:copy;}"];
  [@css ".css-1mkyb1y{cursor:no-drop;}"];
  [@css ".css-1yz0bof{cursor:not-allowed;}"];
  [@css ".css-15qfupi{cursor:-webkit-grab;cursor:grab;}"];
  [@css ".css-l1rlms{cursor:-webkit-grabbing;cursor:grabbing;}"];
  [@css ".css-hb19oy{cursor:ew-resize;}"];
  [@css ".css-1dj19vs{cursor:ns-resize;}"];
  [@css ".css-sc1vmz{cursor:nesw-resize;}"];
  [@css ".css-f9w5zv{cursor:nwse-resize;}"];
  [@css ".css-1l2nb28{cursor:col-resize;}"];
  [@css ".css-jnmugq{cursor:row-resize;}"];
  [@css ".css-1mdael{cursor:all-scroll;}"];
  [@css ".css-zna53q{cursor:zoom-in;}"];
  [@css ".css-i8gm9h{cursor:zoom-out;}"];
  [@css ".css-os4am0{caret-color:auto;}"];
  [@css ".css-14hsrpc{caret-color:green;}"];
  [@css
    ".css-1ek2mgo{-webkit-appearance:auto;-moz-appearance:auto;-ms-appearance:auto;appearance:auto;}"
  ];
  [@css
    ".css-224653{-webkit-appearance:none;-moz-appearance:none;-ms-appearance:none;appearance:none;}"
  ];
  [@css ".css-1b7ljyy{text-overflow:\"foo\";}"];
  [@css ".css-11u5ka0{text-overflow:clip clip;}"];
  [@css ".css-vhu6mm{text-overflow:ellipsis clip;}"];
  [@css ".css-z1f7iy{text-overflow:\"foo\" clip;}"];
  [@css ".css-violkf{text-overflow:clip ellipsis;}"];
  [@css ".css-1cotsjd{text-overflow:ellipsis ellipsis;}"];
  [@css ".css-1s2hyyq{text-overflow:\"foo\" ellipsis;}"];
  [@css ".css-1lmity6{text-overflow:clip \"foo\";}"];
  [@css ".css-xkxqjv{text-overflow:ellipsis \"foo\";}"];
  [@css ".css-1x723vq{text-overflow:\"foo\" \"foo\";}"];
  [@css
    ".css-zqhz7y{-webkit-user-select:auto;-moz-user-select:auto;-ms-user-select:auto;user-select:auto;}"
  ];
  [@css
    ".css-mre99o{-webkit-user-select:text;-moz-user-select:text;-ms-user-select:text;user-select:text;}"
  ];
  [@css
    ".css-2n7llq{-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}"
  ];
  [@css
    ".css-1a0fyyx{-webkit-user-select:contain;-moz-user-select:contain;-ms-user-select:contain;user-select:contain;}"
  ];
  [@css
    ".css-1issdwh{-webkit-user-select:all;-moz-user-select:all;-ms-user-select:all;user-select:all;}"
  ];
  [@css.classes
    [
      ("css-jf1x3e", 0, "", "input.re", 2, 8, 2, 30),
      ("css-1pg8tz0", 1, "", "input.re", 3, 8, 3, 31),
      ("css-1vwj0y4", 2, "", "input.re", 4, 8, 4, 27),
      ("css-19a2wke", 3, "", "input.re", 5, 8, 5, 27),
      ("css-1yeszy0", 4, "", "input.re", 6, 8, 6, 29),
      ("css-qlixb4", 5, "", "input.re", 7, 8, 7, 29),
      ("css-t9d6q1", 6, "", "input.re", 8, 8, 8, 28),
      ("css-6s7u18", 7, "", "input.re", 9, 8, 9, 29),
      ("css-uz4n3j", 8, "", "input.re", 10, 8, 10, 29),
      ("css-edy3oc", 9, "", "input.re", 11, 8, 11, 28),
      ("css-o77wr5", 10, "", "input.re", 12, 8, 12, 28),
      ("css-i2akwd", 11, "", "input.re", 13, 8, 13, 29),
      ("css-ywvp9z", 12, "", "input.re", 14, 8, 14, 28),
      ("css-1pth5s1", 13, "", "input.re", 15, 8, 15, 25),
      ("css-iy4atl", 14, "", "input.re", 16, 8, 16, 27),
      ("css-19sgvj", 15, "", "input.re", 17, 8, 17, 20),
      ("css-ovijqk", 16, "", "input.re", 18, 8, 18, 20),
      ("css-ixfsj6", 17, "", "input.re", 19, 8, 19, 26),
      ("css-1kg8tw2", 18, "", "input.re", 20, 8, 20, 24),
      ("css-1usgsdf", 19, "", "input.re", 21, 8, 21, 27),
      ("css-4r8ugr", 20, "", "input.re", 22, 8, 22, 31),
      ("css-coajd1", 21, "", "input.re", 24, 8, 24, 23),
      ("css-1mge6mj", 22, "", "input.re", 25, 8, 25, 20),
      ("css-32xbc8", 23, "", "input.re", 26, 8, 26, 28),
      ("css-1rv04z", 24, "", "input.re", 27, 8, 27, 20),
      ("css-6hyi1y", 25, "", "input.re", 28, 8, 28, 29),
      ("css-dasf0w", 26, "", "input.re", 29, 8, 29, 21),
      ("css-1ogmf5t", 27, "", "input.re", 30, 8, 30, 20),
      ("css-1mkyb1y", 28, "", "input.re", 31, 8, 31, 23),
      ("css-1yz0bof", 29, "", "input.re", 32, 8, 32, 27),
      ("css-15qfupi", 30, "", "input.re", 33, 8, 33, 20),
      ("css-l1rlms", 31, "", "input.re", 34, 8, 34, 24),
      ("css-hb19oy", 32, "", "input.re", 35, 8, 35, 25),
      ("css-1dj19vs", 33, "", "input.re", 36, 8, 36, 25),
      ("css-sc1vmz", 34, "", "input.re", 37, 8, 37, 27),
      ("css-f9w5zv", 35, "", "input.re", 38, 8, 38, 27),
      ("css-1l2nb28", 36, "", "input.re", 39, 8, 39, 26),
      ("css-jnmugq", 37, "", "input.re", 40, 8, 40, 26),
      ("css-1mdael", 38, "", "input.re", 41, 8, 41, 26),
      ("css-zna53q", 39, "", "input.re", 42, 8, 42, 23),
      ("css-i8gm9h", 40, "", "input.re", 43, 8, 43, 24),
      ("css-os4am0", 41, "", "input.re", 44, 8, 44, 25),
      ("css-14hsrpc", 42, "", "input.re", 45, 8, 45, 26),
      ("css-1ek2mgo", 43, "", "input.re", 48, 8, 48, 24),
      ("css-224653", 44, "", "input.re", 49, 8, 49, 24),
      ("css-1b7ljyy", 45, "", "input.re", 63, 8, 63, 28),
      ("css-11u5ka0", 46, "", "input.re", 64, 8, 64, 32),
      ("css-vhu6mm", 47, "", "input.re", 65, 8, 65, 36),
      ("css-z1f7iy", 48, "", "input.re", 69, 8, 69, 33),
      ("css-violkf", 49, "", "input.re", 70, 8, 70, 36),
      ("css-1cotsjd", 50, "", "input.re", 71, 8, 71, 40),
      ("css-1s2hyyq", 51, "", "input.re", 75, 8, 75, 37),
      ("css-1lmity6", 52, "", "input.re", 94, 8, 94, 33),
      ("css-xkxqjv", 53, "", "input.re", 95, 8, 95, 37),
      ("css-1x723vq", 54, "", "input.re", 99, 8, 99, 34),
      ("css-zqhz7y", 55, "", "input.re", 100, 8, 100, 25),
      ("css-mre99o", 56, "", "input.re", 101, 8, 101, 25),
      ("css-2n7llq", 57, "", "input.re", 102, 8, 102, 25),
      ("css-1a0fyyx", 58, "", "input.re", 103, 8, 103, 28),
      ("css-1issdwh", 59, "", "input.re", 104, 8, 104, 24),
    ]
  ];
  
  CSS.make("css-jf1x3e", []);
  CSS.make("css-1pg8tz0", []);
  CSS.make("css-1vwj0y4", []);
  CSS.make("css-19a2wke", []);
  CSS.make("css-1yeszy0", []);
  CSS.make("css-qlixb4", []);
  CSS.make("css-t9d6q1", []);
  CSS.make("css-6s7u18", []);
  CSS.make("css-uz4n3j", []);
  CSS.make("css-edy3oc", []);
  CSS.make("css-o77wr5", []);
  CSS.make("css-i2akwd", []);
  CSS.make("css-ywvp9z", []);
  CSS.make("css-1pth5s1", []);
  CSS.make("css-iy4atl", []);
  CSS.make("css-19sgvj", []);
  CSS.make("css-ovijqk", []);
  CSS.make("css-ixfsj6", []);
  CSS.make("css-1kg8tw2", []);
  CSS.make("css-1usgsdf", []);
  CSS.make("css-4r8ugr", []);
  
  CSS.make("css-coajd1", []);
  CSS.make("css-1mge6mj", []);
  CSS.make("css-32xbc8", []);
  CSS.make("css-1rv04z", []);
  CSS.make("css-6hyi1y", []);
  CSS.make("css-dasf0w", []);
  CSS.make("css-1ogmf5t", []);
  CSS.make("css-1mkyb1y", []);
  CSS.make("css-1yz0bof", []);
  CSS.make("css-15qfupi", []);
  CSS.make("css-l1rlms", []);
  CSS.make("css-hb19oy", []);
  CSS.make("css-1dj19vs", []);
  CSS.make("css-sc1vmz", []);
  CSS.make("css-f9w5zv", []);
  CSS.make("css-1l2nb28", []);
  CSS.make("css-jnmugq", []);
  CSS.make("css-1mdael", []);
  CSS.make("css-zna53q", []);
  CSS.make("css-i8gm9h", []);
  CSS.make("css-os4am0", []);
  CSS.make("css-14hsrpc", []);
  
  CSS.make("css-1ek2mgo", []);
  CSS.make("css-224653", []);
  
  CSS.make("css-1usgsdf", []);
  CSS.make("css-4r8ugr", []);
  
  CSS.make("css-1b7ljyy", []);
  CSS.make("css-11u5ka0", []);
  CSS.make("css-vhu6mm", []);
  
  CSS.make("css-z1f7iy", []);
  CSS.make("css-violkf", []);
  CSS.make("css-1cotsjd", []);
  
  CSS.make("css-1s2hyyq", []);
  
  CSS.make("css-1lmity6", []);
  CSS.make("css-xkxqjv", []);
  
  CSS.make("css-1x723vq", []);
  CSS.make("css-zqhz7y", []);
  CSS.make("css-mre99o", []);
  CSS.make("css-2n7llq", []);
  CSS.make("css-1a0fyyx", []);
  CSS.make("css-1issdwh", []);

  $ dune build
