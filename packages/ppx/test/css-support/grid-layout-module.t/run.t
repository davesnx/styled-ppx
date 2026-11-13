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
  [@css "@property --3kn975-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --ik1d9f-0{syntax:\"*\";inherits:false;}"];
  [@css ".css-19upnxc{display:grid;}"];
  [@css ".css-1g07ora{display:inline-grid;}"];
  [@css ".css-roy6lj{grid-template-columns:none;}"];
  [@css ".css-fu7nkl{grid-template-columns:auto;}"];
  [@css ".css-hfocg6{grid-template-columns:100px;}"];
  [@css ".css-1krnjs7{grid-template-columns:1fr;}"];
  [@css ".css-1k8p0cp{grid-template-columns:100px 1fr auto;}"];
  [@css ".css-162zzcj{grid-template-columns:repeat(2, 100px 1fr);}"];
  [@css
    ".css-r1p8hz{grid-template-columns:repeat(4, 10px [col-start] 250px [col-end]) 10px;}"
  ];
  [@css
    ".css-hcncw8{grid-template-columns:100px 1fr max-content minmax(min-content, 1fr);}"
  ];
  [@css
    ".css-1g7g5sr{grid-template-columns:repeat(auto-fill, minmax(25ch, 1fr));}"
  ];
  [@css ".css-3pbj1h{grid-template-columns:10px [col-start] 250px [col-end];}"];
  [@css
    ".css-1aq37yp{grid-template-columns:[first nav-start] 150px [main-start] 1fr [last];}"
  ];
  [@css
    ".css-hh0srw{grid-template-columns:10px [col-start] 250px [col-end] 10px [col-start] 250px [col-end] 10px;}"
  ];
  [@css
    ".css-5vsjq4{grid-template-columns:[a] auto [b] minmax(min-content, 1fr) [b c d] repeat(2, [e] 40px) repeat(5, auto);}"
  ];
  [@css
    ".css-1g9eg2p{grid-template-columns:200px repeat(auto-fill, 100px) 300px;}"
  ];
  [@css
    ".css-hkl3vf{grid-template-columns:minmax(100px, max-content) repeat(auto-fill, 200px) 20%;}"
  ];
  [@css
    ".css-vawv68{grid-template-columns:[linename1] 100px [linename2] repeat(auto-fit, [linename3 linename4] 300px) 100px;}"
  ];
  [@css
    ".css-g4b674{grid-template-columns:[linename1 linename2] 100px repeat(auto-fit, [linename1] 300px) [linename3];}"
  ];
  [@css ".css-3kn975{grid-template-columns:var(--3kn975-0);}"];
  [@css ".css-bljr8q{grid-template-rows:none;}"];
  [@css ".css-le77um{grid-template-rows:auto;}"];
  [@css ".css-1n3lbpv{grid-template-rows:100px;}"];
  [@css ".css-g19zso{grid-template-rows:1fr;}"];
  [@css ".css-1w36hg4{grid-template-rows:100px 1fr auto;}"];
  [@css ".css-p1nmxd{grid-template-rows:repeat(2, 100px 1fr);}"];
  [@css
    ".css-fdizu{grid-template-rows:100px 1fr max-content minmax(min-content, 1fr);}"
  ];
  [@css ".css-wzz13w{grid-template-rows:10px [row-start] 250px [row-end];}"];
  [@css
    ".css-188p6gh{grid-template-rows:[first header-start] 50px [main-start] 1fr [footer-start] 50px [last];}"
  ];
  [@css ".css-1yfy4ey{grid-template-areas:none;}"];
  [@css ".css-1cv5fbk{grid-template-areas:\"articles\";}"];
  [@css ".css-f7494q{grid-template-areas:\"head head\";}"];
  [@css
    ".css-1e0au8c{grid-template-areas:\"head head\" \"nav main\" \"foot ....\";}"
  ];
  [@css ".css-1rj7zgm{grid-template:none;}"];
  [@css ".css-1xk881n{grid-template:auto 1fr auto / auto 1fr;}"];
  [@css
    ".css-ikgsyo{grid-template:[header-top] \"a   a   a\" [header-bottom] [main-top] \"b   b   b\" 1fr [main-bottom] / auto 1fr auto;}"
  ];
  [@css ".css-ao4wx4{grid-auto-columns:auto;}"];
  [@css ".css-82vbr6{grid-auto-columns:1fr;}"];
  [@css ".css-631ddl{grid-auto-columns:100px;}"];
  [@css ".css-1qzkmh5{grid-auto-columns:max-content;}"];
  [@css ".css-17o955p{grid-auto-columns:minmax(min-content, 1fr);}"];
  [@css ".css-1n2rgid{grid-auto-columns:min-content max-content auto;}"];
  [@css ".css-13ry9km{grid-auto-columns:100px 150px 390px;}"];
  [@css
    ".css-1pvj4s7{grid-auto-columns:100px minmax(100px, auto) 10% 0.5fr fit-content(400px);}"
  ];
  [@css ".css-1jxhq2n{grid-auto-rows:auto;}"];
  [@css ".css-u7zu7f{grid-auto-rows:1fr;}"];
  [@css ".css-buhclq{grid-auto-rows:100px;}"];
  [@css ".css-15slil4{grid-auto-rows:100px 30%;}"];
  [@css ".css-1gqemx7{grid-auto-rows:100px 30% 1em;}"];
  [@css ".css-1muufqf{grid-auto-rows:min-content;}"];
  [@css ".css-9p24k6{grid-auto-rows:minmax(min-content, 1fr);}"];
  [@css ".css-1ovyjc{grid-auto-rows:min-content max-content auto;}"];
  [@css
    ".css-1680b2m{grid-auto-rows:100px minmax(100px, auto) 10% 0.5fr fit-content(400px);}"
  ];
  [@css ".css-9k3p4b{grid-auto-flow:row;}"];
  [@css ".css-55zphy{grid-auto-flow:column;}"];
  [@css ".css-y3oq5s{grid-auto-flow:row dense;}"];
  [@css ".css-wbi1br{grid-auto-flow:column dense;}"];
  [@css ".css-eoieo2{grid:auto-flow 1fr / 100px;}"];
  [@css ".css-ul5rt1{grid:none / auto-flow 1fr;}"];
  [@css ".css-fm0j8y{grid:auto-flow / auto 1fr;}"];
  [@css ".css-ilhwvg{grid:repeat(auto-fill, 5em) / auto-flow 1fr;}"];
  [@css ".css-kkz7e{grid:auto-flow 1fr / repeat(auto-fill, 5em);}"];
  [@css
    ".css-1na7dau{grid:\"H    H \" \"A    B \" \"F    F \" 30px / auto 1fr;}"
  ];
  [@css ".css-1rng8nf{grid-row-start:auto;}"];
  [@css ".css-1x84da8{grid-row-start:4;}"];
  [@css ".css-sc4erd{grid-row-start:C;}"];
  [@css ".css-s1jn8r{grid-row-start:C 2;}"];
  [@css ".css-zku515{grid-row-start:span C;}"];
  [@css ".css-1xoq8ef{grid-row-start:span 1;}"];
  [@css ".css-n31ufw{grid-column-start:auto;}"];
  [@css ".css-mx83kg{grid-column-start:4;}"];
  [@css ".css-1g52l11{grid-column-start:C;}"];
  [@css ".css-18sn2s9{grid-column-start:C 2;}"];
  [@css ".css-1kvh455{grid-column-start:span C;}"];
  [@css ".css-osmr9{grid-column-start:span 1;}"];
  [@css ".css-1vrtnpr{grid-row-end:auto;}"];
  [@css ".css-1wtvd6d{grid-row-end:4;}"];
  [@css ".css-1pvha8d{grid-row-end:C;}"];
  [@css ".css-1pqbd4a{grid-row-end:C 2;}"];
  [@css ".css-1amnaih{grid-row-end:span C;}"];
  [@css ".css-1x1v383{grid-row-end:span 1;}"];
  [@css ".css-1li70gw{grid-column-end:auto;}"];
  [@css ".css-14gji32{grid-column-end:4;}"];
  [@css ".css-qj6n9d{grid-column-end:C;}"];
  [@css ".css-mpkfyx{grid-column-end:C 2;}"];
  [@css ".css-1q0svio{grid-column-end:span C;}"];
  [@css ".css-1ampykb{grid-column-end:span 1;}"];
  [@css ".css-h02lh1{-ms-grid-column:auto;grid-column:auto;}"];
  [@css ".css-159j8bw{-ms-grid-column:1;grid-column:1;}"];
  [@css ".css-c0np48{-ms-grid-column:-1;grid-column:-1;}"];
  [@css ".css-19rbjh5{-ms-grid-column:1 / 1;grid-column:1 / 1;}"];
  [@css ".css-ysrmx6{-ms-grid-column:1 / -1;grid-column:1 / -1;}"];
  [@css ".css-7b5dxi{-ms-grid-column:auto / auto;grid-column:auto / auto;}"];
  [@css ".css-msm32l{-ms-grid-column:2 / span 2;grid-column:2 / span 2;}"];
  [@css ".css-1bqpid5{-ms-grid-row:auto;grid-row:auto;}"];
  [@css ".css-1jabi9l{-ms-grid-row:1;grid-row:1;}"];
  [@css ".css-7476l3{-ms-grid-row:-1;grid-row:-1;}"];
  [@css ".css-5hhh0{-ms-grid-row:1 / 1;grid-row:1 / 1;}"];
  [@css ".css-22cj94{-ms-grid-row:1 / -1;grid-row:1 / -1;}"];
  [@css ".css-1422yxl{-ms-grid-row:auto / auto;grid-row:auto / auto;}"];
  [@css ".css-f04ys6{-ms-grid-row:2 / span 2;grid-row:2 / span 2;}"];
  [@css ".css-h2ow33{grid-area:1 / 1;}"];
  [@css ".css-ik1d9f{grid-area:var(--ik1d9f-0);}"];
  [@css ".css-x78zg2{grid-area:1 / span 1;}"];
  [@css ".css-bi9yck{grid-area:span 1 / 10 / -1;}"];
  [@css ".css-1opl1uq{grid-column-gap:0;}"];
  [@css ".css-1t7gezn{grid-column-gap:1em;}"];
  [@css ".css-17kwn8l{grid-row-gap:0;}"];
  [@css ".css-wske8m{grid-row-gap:1em;}"];
  [@css ".css-1rzpshu{grid-gap:0 0;}"];
  [@css ".css-8a1oeo{grid-gap:0 1em;}"];
  [@css ".css-87tg0w{grid-gap:1em;}"];
  [@css ".css-ooa55a{grid-gap:1em 1em;}"];
  [@css ".css-bgdyn{grid-template-columns:subgrid;}"];
  [@css ".css-644h5{grid-template-columns:subgrid [sub-a];}"];
  [@css ".css-z3dir{grid-template-columns:subgrid [sub-a] [sub-b];}"];
  [@css ".css-rlf51l{grid-template-columns:subgrid repeat(1, [sub-a]);}"];
  [@css
    ".css-ri3vv1{grid-template-columns:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}"
  ];
  [@css
    ".css-15w8kvw{grid-template-columns:subgrid repeat(auto-fill, [sub-a] [sub-b]);}"
  ];
  [@css
    ".css-tvo6nd{grid-template-columns:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g]);}"
  ];
  [@css ".css-1ajiy3l{grid-template-rows:subgrid;}"];
  [@css ".css-1ieou4m{grid-template-rows:subgrid [sub-a];}"];
  [@css ".css-fw7kzz{grid-template-rows:subgrid [sub-a] [sub-b];}"];
  [@css ".css-1oq5e7l{grid-template-rows:subgrid repeat(1, [sub-a]);}"];
  [@css
    ".css-11dbnql{grid-template-rows:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}"
  ];
  [@css
    ".css-1iwzvdc{grid-template-rows:subgrid repeat(auto-fill, [sub-a] [sub-b]);}"
  ];
  [@css
    ".css-1ckq7ev{grid-template-rows:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g]);}"
  ];
  [@css ".css-b61mw5{grid-template-columns:masonry;}"];
  [@css ".css-957ox1{grid-template-rows:masonry;}"];
  [@css ".css-2gbaes{masonry-auto-flow:pack;}"];
  [@css ".css-vfw24h{masonry-auto-flow:next;}"];
  [@css ".css-10h7ooi{masonry-auto-flow:definite-first;}"];
  [@css ".css-ebid7e{masonry-auto-flow:ordered;}"];
  [@css ".css-obnjkx{masonry-auto-flow:pack definite-first;}"];
  [@css ".css-1r7k2sl{masonry-auto-flow:pack ordered;}"];
  [@css ".css-ny2g06{masonry-auto-flow:next definite-first;}"];
  [@css ".css-17t0t9c{masonry-auto-flow:next ordered;}"];
  [@css ".css-2cv0q{masonry-auto-flow:ordered pack;}"];
  [@css.classes
    [
      ("css-19upnxc", 2, "", "input.re", 2, 8, 2, 21),
      ("css-1g07ora", 3, "", "input.re", 3, 8, 3, 28),
      ("css-roy6lj", 4, "", "input.re", 4, 8, 4, 35),
      ("css-fu7nkl", 5, "", "input.re", 5, 8, 5, 35),
      ("css-hfocg6", 6, "", "input.re", 6, 8, 6, 36),
      ("css-1krnjs7", 7, "", "input.re", 7, 8, 7, 34),
      ("css-1k8p0cp", 8, "", "input.re", 8, 8, 8, 45),
      ("css-162zzcj", 9, "", "input.re", 9, 8, 9, 51),
      ("css-r1p8hz", 10, "", "input.re", 11, 4, 11, 75),
      ("css-hcncw8", 11, "", "input.re", 14, 4, 14, 73),
      ("css-1g7g5sr", 12, "", "input.re", 16, 8, 16, 67),
      ("css-3pbj1h", 13, "", "input.re", 17, 8, 17, 63),
      ("css-1aq37yp", 14, "", "input.re", 19, 4, 19, 74),
      ("css-hh0srw", 15, "", "input.re", 22, 4, 22, 97),
      ("css-5vsjq4", 16, "", "input.re", 25, 4, 25, 108),
      ("css-1g9eg2p", 17, "", "input.re", 27, 8, 27, 69),
      ("css-hkl3vf", 18, "", "input.re", 29, 4, 29, 84),
      ("css-vawv68", 19, "", "input.re", 32, 4, 32, 110),
      ("css-g4b674", 20, "", "input.re", 36, 4, 36, 104),
      ("css-3kn975", 21, "", "input.re", 51, 8, 51, 39),
      ("css-bljr8q", 22, "", "input.re", 52, 8, 52, 32),
      ("css-le77um", 23, "", "input.re", 53, 8, 53, 32),
      ("css-1n3lbpv", 24, "", "input.re", 54, 8, 54, 33),
      ("css-g19zso", 25, "", "input.re", 55, 8, 55, 31),
      ("css-1w36hg4", 26, "", "input.re", 56, 8, 56, 42),
      ("css-p1nmxd", 27, "", "input.re", 57, 8, 57, 48),
      ("css-fdizu", 28, "", "input.re", 58, 8, 58, 74),
      ("css-wzz13w", 29, "", "input.re", 59, 8, 59, 60),
      ("css-188p6gh", 30, "", "input.re", 61, 4, 61, 93),
      ("css-1yfy4ey", 31, "", "input.re", 63, 8, 63, 33),
      ("css-1cv5fbk", 32, "", "input.re", 64, 8, 64, 39),
      ("css-f7494q", 33, "", "input.re", 65, 8, 65, 40),
      ("css-1e0au8c", 34, "", "input.re", 66, 8, 66, 63),
      ("css-1rj7zgm", 35, "", "input.re", 67, 8, 67, 27),
      ("css-1xk881n", 36, "", "input.re", 68, 8, 68, 47),
      ("css-ikgsyo", 37, "", "input.re", 70, 4, 70, 116),
      ("css-ao4wx4", 38, "", "input.re", 72, 8, 72, 31),
      ("css-82vbr6", 39, "", "input.re", 73, 8, 73, 30),
      ("css-631ddl", 40, "", "input.re", 74, 8, 74, 32),
      ("css-1qzkmh5", 41, "", "input.re", 75, 8, 75, 38),
      ("css-17o955p", 42, "", "input.re", 76, 8, 76, 51),
      ("css-1n2rgid", 43, "", "input.re", 77, 8, 77, 55),
      ("css-13ry9km", 44, "", "input.re", 78, 8, 78, 44),
      ("css-1pvj4s7", 45, "", "input.re", 80, 4, 80, 77),
      ("css-1jxhq2n", 46, "", "input.re", 82, 8, 82, 28),
      ("css-u7zu7f", 47, "", "input.re", 83, 8, 83, 27),
      ("css-buhclq", 48, "", "input.re", 84, 8, 84, 29),
      ("css-15slil4", 49, "", "input.re", 85, 8, 85, 33),
      ("css-1gqemx7", 50, "", "input.re", 86, 8, 86, 37),
      ("css-1muufqf", 51, "", "input.re", 87, 8, 87, 35),
      ("css-9p24k6", 52, "", "input.re", 88, 8, 88, 48),
      ("css-1ovyjc", 53, "", "input.re", 89, 8, 89, 52),
      ("css-1680b2m", 54, "", "input.re", 91, 4, 91, 74),
      ("css-9k3p4b", 55, "", "input.re", 93, 8, 93, 27),
      ("css-55zphy", 56, "", "input.re", 94, 8, 94, 30),
      ("css-y3oq5s", 57, "", "input.re", 95, 8, 95, 33),
      ("css-wbi1br", 58, "", "input.re", 96, 8, 96, 36),
      ("css-eoieo2", 59, "", "input.re", 97, 8, 97, 35),
      ("css-ul5rt1", 60, "", "input.re", 98, 8, 98, 34),
      ("css-fm0j8y", 61, "", "input.re", 99, 8, 99, 34),
      ("css-ilhwvg", 62, "", "input.re", 100, 8, 100, 52),
      ("css-kkz7e", 63, "", "input.re", 101, 8, 101, 53),
      ("css-1na7dau", 64, "", "input.re", 102, 8, 102, 59),
      ("css-1rng8nf", 65, "", "input.re", 103, 8, 103, 28),
      ("css-1x84da8", 66, "", "input.re", 104, 8, 104, 25),
      ("css-sc4erd", 67, "", "input.re", 105, 8, 105, 25),
      ("css-s1jn8r", 68, "", "input.re", 106, 8, 106, 27),
      ("css-zku515", 69, "", "input.re", 107, 8, 107, 30),
      ("css-1xoq8ef", 70, "", "input.re", 108, 8, 108, 30),
      ("css-n31ufw", 71, "", "input.re", 109, 8, 109, 31),
      ("css-mx83kg", 72, "", "input.re", 110, 8, 110, 28),
      ("css-1g52l11", 73, "", "input.re", 111, 8, 111, 28),
      ("css-18sn2s9", 74, "", "input.re", 112, 8, 112, 30),
      ("css-1kvh455", 75, "", "input.re", 113, 8, 113, 33),
      ("css-osmr9", 76, "", "input.re", 114, 8, 114, 33),
      ("css-1vrtnpr", 77, "", "input.re", 115, 8, 115, 26),
      ("css-1wtvd6d", 78, "", "input.re", 116, 8, 116, 23),
      ("css-1pvha8d", 79, "", "input.re", 117, 8, 117, 23),
      ("css-1pqbd4a", 80, "", "input.re", 118, 8, 118, 25),
      ("css-1amnaih", 81, "", "input.re", 119, 8, 119, 28),
      ("css-1x1v383", 82, "", "input.re", 120, 8, 120, 28),
      ("css-1li70gw", 83, "", "input.re", 121, 8, 121, 29),
      ("css-14gji32", 84, "", "input.re", 122, 8, 122, 26),
      ("css-qj6n9d", 85, "", "input.re", 123, 8, 123, 26),
      ("css-mpkfyx", 86, "", "input.re", 124, 8, 124, 28),
      ("css-1q0svio", 87, "", "input.re", 125, 8, 125, 31),
      ("css-1ampykb", 88, "", "input.re", 126, 8, 126, 31),
      ("css-h02lh1", 89, "", "input.re", 127, 8, 127, 25),
      ("css-159j8bw", 90, "", "input.re", 128, 8, 128, 22),
      ("css-c0np48", 91, "", "input.re", 129, 8, 129, 23),
      ("css-19rbjh5", 92, "", "input.re", 130, 8, 130, 26),
      ("css-ysrmx6", 93, "", "input.re", 131, 8, 131, 27),
      ("css-7b5dxi", 94, "", "input.re", 132, 8, 132, 32),
      ("css-msm32l", 95, "", "input.re", 133, 8, 133, 31),
      ("css-1bqpid5", 96, "", "input.re", 134, 8, 134, 22),
      ("css-1jabi9l", 97, "", "input.re", 135, 8, 135, 19),
      ("css-7476l3", 98, "", "input.re", 136, 8, 136, 20),
      ("css-5hhh0", 99, "", "input.re", 137, 8, 137, 23),
      ("css-22cj94", 100, "", "input.re", 138, 8, 138, 24),
      ("css-1422yxl", 101, "", "input.re", 139, 8, 139, 29),
      ("css-f04ys6", 102, "", "input.re", 140, 8, 140, 28),
      ("css-h2ow33", 103, "", "input.re", 141, 8, 141, 24),
      ("css-ik1d9f", 104, "", "input.re", 143, 8, 143, 26),
      ("css-x78zg2", 105, "", "input.re", 144, 8, 144, 29),
      ("css-bi9yck", 106, "", "input.re", 145, 8, 145, 35),
      ("css-1opl1uq", 107, "", "input.re", 146, 8, 146, 26),
      ("css-1t7gezn", 108, "", "input.re", 147, 8, 147, 28),
      ("css-17kwn8l", 109, "", "input.re", 148, 8, 148, 23),
      ("css-wske8m", 110, "", "input.re", 149, 8, 149, 25),
      ("css-1rzpshu", 111, "", "input.re", 150, 8, 150, 21),
      ("css-8a1oeo", 112, "", "input.re", 151, 8, 151, 23),
      ("css-87tg0w", 113, "", "input.re", 152, 8, 152, 21),
      ("css-ooa55a", 114, "", "input.re", 153, 8, 153, 25),
      ("css-bgdyn", 115, "", "input.re", 156, 8, 156, 38),
      ("css-644h5", 116, "", "input.re", 157, 8, 157, 46),
      ("css-z3dir", 117, "", "input.re", 158, 8, 158, 54),
      ("css-rlf51l", 118, "", "input.re", 159, 8, 159, 57),
      ("css-ri3vv1", 119, "", "input.re", 160, 8, 160, 73),
      ("css-15w8kvw", 120, "", "input.re", 161, 8, 161, 73),
      ("css-tvo6nd", 121, "", "input.re", 163, 4, 163, 112),
      ("css-1ajiy3l", 122, "", "input.re", 165, 8, 165, 35),
      ("css-1ieou4m", 123, "", "input.re", 166, 8, 166, 43),
      ("css-fw7kzz", 124, "", "input.re", 167, 8, 167, 51),
      ("css-1oq5e7l", 125, "", "input.re", 168, 8, 168, 54),
      ("css-11dbnql", 126, "", "input.re", 169, 8, 169, 70),
      ("css-1iwzvdc", 127, "", "input.re", 170, 8, 170, 70),
      ("css-1ckq7ev", 128, "", "input.re", 172, 4, 172, 109),
      ("css-b61mw5", 129, "", "input.re", 176, 8, 176, 38),
      ("css-957ox1", 130, "", "input.re", 177, 8, 177, 36),
      ("css-2gbaes", 131, "", "input.re", 178, 8, 178, 31),
      ("css-vfw24h", 132, "", "input.re", 179, 8, 179, 31),
      ("css-10h7ooi", 133, "", "input.re", 180, 8, 180, 41),
      ("css-ebid7e", 134, "", "input.re", 181, 8, 181, 34),
      ("css-obnjkx", 135, "", "input.re", 182, 8, 182, 46),
      ("css-1r7k2sl", 136, "", "input.re", 183, 8, 183, 39),
      ("css-ny2g06", 137, "", "input.re", 184, 8, 184, 46),
      ("css-17t0t9c", 138, "", "input.re", 185, 8, 185, 39),
      ("css-2cv0q", 139, "", "input.re", 186, 8, 186, 39),
    ]
  ];
  
  CSS.make("css-19upnxc", []);
  CSS.make("css-1g07ora", []);
  CSS.make("css-roy6lj", []);
  CSS.make("css-fu7nkl", []);
  CSS.make("css-hfocg6", []);
  CSS.make("css-1krnjs7", []);
  CSS.make("css-1k8p0cp", []);
  CSS.make("css-162zzcj", []);
  CSS.make("css-r1p8hz", []);
  CSS.make("css-hcncw8", []);
  CSS.make("css-1g7g5sr", []);
  CSS.make("css-3pbj1h", []);
  CSS.make("css-1aq37yp", []);
  CSS.make("css-hh0srw", []);
  CSS.make("css-5vsjq4", []);
  CSS.make("css-1g9eg2p", []);
  CSS.make("css-hkl3vf", []);
  CSS.make("css-vawv68", []);
  
  CSS.make("css-g4b674", []);
  let value =
    CSS.tracks([|
      CSS.repeatFn(
        CSS.numInt(4),
        [|
          CSS.pxFloat(10.),
          CSS.lineNames({js|[col-start]|js}),
          CSS.pxFloat(250.),
          CSS.lineNames({js|[col-end]|js}),
        |],
      ),
      CSS.pxFloat(10.),
    |]);
  CSS.make(
    "css-3kn975",
    [("--3kn975-0", CSS.Types.GridTemplateColumns.toString(value))],
  );
  CSS.make("css-bljr8q", []);
  CSS.make("css-le77um", []);
  CSS.make("css-1n3lbpv", []);
  CSS.make("css-g19zso", []);
  CSS.make("css-1w36hg4", []);
  CSS.make("css-p1nmxd", []);
  CSS.make("css-fdizu", []);
  CSS.make("css-wzz13w", []);
  CSS.make("css-188p6gh", []);
  CSS.make("css-1yfy4ey", []);
  CSS.make("css-1cv5fbk", []);
  CSS.make("css-f7494q", []);
  CSS.make("css-1e0au8c", []);
  CSS.make("css-1rj7zgm", []);
  CSS.make("css-1xk881n", []);
  CSS.make("css-ikgsyo", []);
  CSS.make("css-ao4wx4", []);
  CSS.make("css-82vbr6", []);
  CSS.make("css-631ddl", []);
  CSS.make("css-1qzkmh5", []);
  CSS.make("css-17o955p", []);
  CSS.make("css-1n2rgid", []);
  CSS.make("css-13ry9km", []);
  CSS.make("css-1pvj4s7", []);
  CSS.make("css-1jxhq2n", []);
  CSS.make("css-u7zu7f", []);
  CSS.make("css-buhclq", []);
  CSS.make("css-15slil4", []);
  CSS.make("css-1gqemx7", []);
  CSS.make("css-1muufqf", []);
  CSS.make("css-9p24k6", []);
  CSS.make("css-1ovyjc", []);
  CSS.make("css-1680b2m", []);
  CSS.make("css-9k3p4b", []);
  CSS.make("css-55zphy", []);
  CSS.make("css-y3oq5s", []);
  CSS.make("css-wbi1br", []);
  CSS.make("css-eoieo2", []);
  CSS.make("css-ul5rt1", []);
  CSS.make("css-fm0j8y", []);
  CSS.make("css-ilhwvg", []);
  CSS.make("css-kkz7e", []);
  CSS.make("css-1na7dau", []);
  CSS.make("css-1rng8nf", []);
  CSS.make("css-1x84da8", []);
  CSS.make("css-sc4erd", []);
  CSS.make("css-s1jn8r", []);
  CSS.make("css-zku515", []);
  CSS.make("css-1xoq8ef", []);
  CSS.make("css-n31ufw", []);
  CSS.make("css-mx83kg", []);
  CSS.make("css-1g52l11", []);
  CSS.make("css-18sn2s9", []);
  CSS.make("css-1kvh455", []);
  CSS.make("css-osmr9", []);
  CSS.make("css-1vrtnpr", []);
  CSS.make("css-1wtvd6d", []);
  CSS.make("css-1pvha8d", []);
  CSS.make("css-1pqbd4a", []);
  CSS.make("css-1amnaih", []);
  CSS.make("css-1x1v383", []);
  CSS.make("css-1li70gw", []);
  CSS.make("css-14gji32", []);
  CSS.make("css-qj6n9d", []);
  CSS.make("css-mpkfyx", []);
  CSS.make("css-1q0svio", []);
  CSS.make("css-1ampykb", []);
  CSS.make("css-h02lh1", []);
  CSS.make("css-159j8bw", []);
  CSS.make("css-c0np48", []);
  CSS.make("css-19rbjh5", []);
  CSS.make("css-ysrmx6", []);
  CSS.make("css-7b5dxi", []);
  CSS.make("css-msm32l", []);
  CSS.make("css-1bqpid5", []);
  CSS.make("css-1jabi9l", []);
  CSS.make("css-7476l3", []);
  CSS.make("css-5hhh0", []);
  CSS.make("css-22cj94", []);
  CSS.make("css-1422yxl", []);
  CSS.make("css-f04ys6", []);
  CSS.make("css-h2ow33", []);
  let area = `num(33);
  CSS.make(
    "css-ik1d9f",
    [("--ik1d9f-0", CSS.Types.GridArea.toString(area))],
  );
  CSS.make("css-x78zg2", []);
  CSS.make("css-bi9yck", []);
  CSS.make("css-1opl1uq", []);
  CSS.make("css-1t7gezn", []);
  CSS.make("css-17kwn8l", []);
  CSS.make("css-wske8m", []);
  CSS.make("css-1rzpshu", []);
  CSS.make("css-8a1oeo", []);
  CSS.make("css-87tg0w", []);
  CSS.make("css-ooa55a", []);
  
  CSS.make("css-bgdyn", []);
  CSS.make("css-644h5", []);
  CSS.make("css-z3dir", []);
  CSS.make("css-rlf51l", []);
  CSS.make("css-ri3vv1", []);
  CSS.make("css-15w8kvw", []);
  CSS.make("css-tvo6nd", []);
  CSS.make("css-1ajiy3l", []);
  CSS.make("css-1ieou4m", []);
  CSS.make("css-fw7kzz", []);
  CSS.make("css-1oq5e7l", []);
  CSS.make("css-11dbnql", []);
  CSS.make("css-1iwzvdc", []);
  CSS.make("css-1ckq7ev", []);
  
  CSS.make("css-b61mw5", []);
  CSS.make("css-957ox1", []);
  CSS.make("css-2gbaes", []);
  CSS.make("css-vfw24h", []);
  CSS.make("css-10h7ooi", []);
  CSS.make("css-ebid7e", []);
  CSS.make("css-obnjkx", []);
  CSS.make("css-1r7k2sl", []);
  CSS.make("css-ny2g06", []);
  CSS.make("css-17t0t9c", []);
  CSS.make("css-2cv0q", []);
