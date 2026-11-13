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
  [@css ".css-5lj5x4{offset:none;}"];
  [@css ".css-1j543qe{offset:auto;}"];
  [@css ".css-1lg6ftm{offset:center;}"];
  [@css ".css-96nabw{offset:200px 100px;}"];
  [@css ".css-vbpo3m{offset:margin-box;}"];
  [@css ".css-14rz8oo{offset:border-box;}"];
  [@css ".css-1mwjqt7{offset:padding-box;}"];
  [@css ".css-jnvhvi{offset:content-box;}"];
  [@css ".css-l4s61x{offset:fill-box;}"];
  [@css ".css-7dzhr6{offset:stroke-box;}"];
  [@css ".css-1kv0g2w{offset:view-box;}"];
  [@css ".css-15fcbx6{offset:path(\"M 20 20 H 80 V 30\");}"];
  [@css ".css-13pp3fb{offset:url(\"image.png\");}"];
  [@css ".css-10w947f{offset:ray(45deg closest-side);}"];
  [@css ".css-1386uzn{offset:ray(45deg closest-side) 10%;}"];
  [@css ".css-1fr9nlq{offset:ray(45deg closest-side) 10% reverse;}"];
  [@css ".css-11jp8c0{offset:ray(45deg closest-side) reverse 10%;}"];
  [@css ".css-1uq8xhq{offset:auto / center;}"];
  [@css ".css-qf1a9h{offset:center / 200px 100px;}"];
  [@css ".css-29p769{offset:ray(45deg closest-side) / 200px 100px;}"];
  [@css ".css-1a7dixe{offset-path:none;}"];
  [@css ".css-aecpiv{offset-path:ray(45deg closest-side);}"];
  [@css ".css-1d9cmk6{offset-path:ray(45deg farthest-side);}"];
  [@css ".css-tcte20{offset-path:ray(45deg closest-corner);}"];
  [@css ".css-1icoyru{offset-path:ray(45deg farthest-corner);}"];
  [@css ".css-1lehsys{offset-path:ray(100grad closest-side contain);}"];
  [@css ".css-mjpn0q{offset-path:margin-box;}"];
  [@css ".css-1nwuxsd{offset-path:border-box;}"];
  [@css ".css-1y48o1o{offset-path:padding-box;}"];
  [@css ".css-3ksmvc{offset-path:content-box;}"];
  [@css ".css-12jz30m{offset-path:fill-box;}"];
  [@css ".css-e1xaxm{offset-path:stroke-box;}"];
  [@css ".css-du05gy{offset-path:view-box;}"];
  [@css ".css-c7bjyf{offset-path:circle(60%) margin-box;}"];
  [@css ".css-1vomupb{offset-distance:10%;}"];
  [@css ".css-12c9mow{offset-position:auto;}"];
  [@css ".css-3jgscp{offset-position:200px;}"];
  [@css ".css-1pcece2{offset-position:200px 100px;}"];
  [@css ".css-3wh6a2{offset-position:center;}"];
  [@css ".css-15jhqlb{offset-anchor:auto;}"];
  [@css ".css-1bp077j{offset-anchor:200px;}"];
  [@css ".css-ioppbs{offset-anchor:200px 100px;}"];
  [@css ".css-1mvfrt2{offset-anchor:center;}"];
  [@css ".css-1eowlf5{offset-rotate:auto;}"];
  [@css ".css-1crwj05{offset-rotate:0deg;}"];
  [@css ".css-a1qvve{offset-rotate:reverse;}"];
  [@css ".css-qkxajd{offset-rotate:-45deg;}"];
  [@css ".css-1ff316z{offset-rotate:auto 180deg;}"];
  [@css ".css-1vv8o0x{offset-rotate:reverse 45deg;}"];
  [@css ".css-11yyb51{offset-rotate:2turn reverse;}"];
  [@css.classes
    [
      ("css-5lj5x4", 0, "", "input.re", 2, 8, 2, 20),
      ("css-1j543qe", 1, "", "input.re", 3, 8, 3, 20),
      ("css-1lg6ftm", 2, "", "input.re", 4, 8, 4, 22),
      ("css-96nabw", 3, "", "input.re", 5, 8, 5, 27),
      ("css-vbpo3m", 4, "", "input.re", 9, 8, 9, 26),
      ("css-14rz8oo", 5, "", "input.re", 10, 8, 10, 26),
      ("css-1mwjqt7", 6, "", "input.re", 11, 8, 11, 27),
      ("css-jnvhvi", 7, "", "input.re", 12, 8, 12, 27),
      ("css-l4s61x", 8, "", "input.re", 13, 8, 13, 24),
      ("css-7dzhr6", 9, "", "input.re", 14, 8, 14, 26),
      ("css-1kv0g2w", 10, "", "input.re", 15, 8, 15, 24),
      ("css-15fcbx6", 11, "", "input.re", 17, 8, 17, 41),
      ("css-13pp3fb", 12, "", "input.re", 18, 8, 18, 30),
      ("css-10w947f", 13, "", "input.re", 19, 8, 19, 39),
      ("css-1386uzn", 14, "", "input.re", 20, 8, 20, 43),
      ("css-1fr9nlq", 15, "", "input.re", 21, 8, 21, 51),
      ("css-11jp8c0", 16, "", "input.re", 26, 8, 26, 51),
      ("css-1uq8xhq", 17, "", "input.re", 35, 8, 35, 29),
      ("css-qf1a9h", 18, "", "input.re", 36, 8, 36, 36),
      ("css-29p769", 19, "", "input.re", 37, 8, 37, 53),
      ("css-1a7dixe", 20, "", "input.re", 53, 8, 53, 25),
      ("css-aecpiv", 21, "", "input.re", 54, 8, 54, 44),
      ("css-1d9cmk6", 22, "", "input.re", 55, 8, 55, 45),
      ("css-tcte20", 23, "", "input.re", 56, 8, 56, 46),
      ("css-1icoyru", 24, "", "input.re", 57, 8, 57, 47),
      ("css-1lehsys", 25, "", "input.re", 60, 8, 60, 54),
      ("css-mjpn0q", 26, "", "input.re", 65, 8, 65, 31),
      ("css-1nwuxsd", 27, "", "input.re", 66, 8, 66, 31),
      ("css-1y48o1o", 28, "", "input.re", 67, 8, 67, 32),
      ("css-3ksmvc", 29, "", "input.re", 68, 8, 68, 32),
      ("css-12jz30m", 30, "", "input.re", 69, 8, 69, 29),
      ("css-e1xaxm", 31, "", "input.re", 70, 8, 70, 31),
      ("css-du05gy", 32, "", "input.re", 71, 8, 71, 29),
      ("css-c7bjyf", 33, "", "input.re", 72, 8, 72, 43),
      ("css-1vomupb", 34, "", "input.re", 77, 8, 77, 28),
      ("css-12c9mow", 35, "", "input.re", 78, 8, 78, 29),
      ("css-3jgscp", 36, "", "input.re", 79, 8, 79, 30),
      ("css-1pcece2", 37, "", "input.re", 80, 8, 80, 36),
      ("css-3wh6a2", 38, "", "input.re", 81, 8, 81, 31),
      ("css-15jhqlb", 39, "", "input.re", 82, 8, 82, 27),
      ("css-1bp077j", 40, "", "input.re", 83, 8, 83, 28),
      ("css-ioppbs", 41, "", "input.re", 84, 8, 84, 34),
      ("css-1mvfrt2", 42, "", "input.re", 85, 8, 85, 29),
      ("css-1eowlf5", 43, "", "input.re", 86, 8, 86, 27),
      ("css-1crwj05", 44, "", "input.re", 87, 8, 87, 27),
      ("css-a1qvve", 45, "", "input.re", 88, 8, 88, 30),
      ("css-qkxajd", 46, "", "input.re", 89, 8, 89, 29),
      ("css-1ff316z", 47, "", "input.re", 90, 8, 90, 34),
      ("css-1vv8o0x", 48, "", "input.re", 91, 8, 91, 36),
      ("css-11yyb51", 49, "", "input.re", 92, 8, 92, 36),
    ]
  ];
  
  CSS.make("css-5lj5x4", []);
  CSS.make("css-1j543qe", []);
  CSS.make("css-1lg6ftm", []);
  CSS.make("css-96nabw", []);
  
  CSS.make("css-vbpo3m", []);
  CSS.make("css-14rz8oo", []);
  CSS.make("css-1mwjqt7", []);
  CSS.make("css-jnvhvi", []);
  CSS.make("css-l4s61x", []);
  CSS.make("css-7dzhr6", []);
  CSS.make("css-1kv0g2w", []);
  
  CSS.make("css-15fcbx6", []);
  CSS.make("css-13pp3fb", []);
  CSS.make("css-10w947f", []);
  CSS.make("css-1386uzn", []);
  CSS.make("css-1fr9nlq", []);
  
  CSS.make("css-11jp8c0", []);
  
  CSS.make("css-1uq8xhq", []);
  CSS.make("css-qf1a9h", []);
  CSS.make("css-29p769", []);
  
  CSS.make("css-1a7dixe", []);
  CSS.make("css-aecpiv", []);
  CSS.make("css-1d9cmk6", []);
  CSS.make("css-tcte20", []);
  CSS.make("css-1icoyru", []);
  
  CSS.make("css-1lehsys", []);
  
  CSS.make("css-mjpn0q", []);
  CSS.make("css-1nwuxsd", []);
  CSS.make("css-1y48o1o", []);
  CSS.make("css-3ksmvc", []);
  CSS.make("css-12jz30m", []);
  CSS.make("css-e1xaxm", []);
  CSS.make("css-du05gy", []);
  CSS.make("css-c7bjyf", []);
  
  CSS.make("css-1vomupb", []);
  CSS.make("css-12c9mow", []);
  CSS.make("css-3jgscp", []);
  CSS.make("css-1pcece2", []);
  CSS.make("css-3wh6a2", []);
  CSS.make("css-15jhqlb", []);
  CSS.make("css-1bp077j", []);
  CSS.make("css-ioppbs", []);
  CSS.make("css-1mvfrt2", []);
  CSS.make("css-1eowlf5", []);
  CSS.make("css-1crwj05", []);
  CSS.make("css-a1qvve", []);
  CSS.make("css-qkxajd", []);
  CSS.make("css-1ff316z", []);
  CSS.make("css-1vv8o0x", []);
  CSS.make("css-11yyb51", []);
