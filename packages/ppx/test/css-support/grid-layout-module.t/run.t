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
  [@css "@property --ivpc75i{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcp1r{syntax:\"*\";inherits:false;}"];
  [@css ".css-ivpcnxc{display:grid;}"];
  [@css ".css-ivpcora{display:inline-grid;}"];
  [@css ".css-ivpc6lj{grid-template-columns:none;}"];
  [@css ".css-ivpcnkl{grid-template-columns:auto;}"];
  [@css ".css-ivpccg6{grid-template-columns:100px;}"];
  [@css ".css-ivpcjs7{grid-template-columns:1fr;}"];
  [@css ".css-ivpc0cp{grid-template-columns:100px 1fr auto;}"];
  [@css ".css-ivpczcj{grid-template-columns:repeat(2, 100px 1fr);}"];
  [@css
    ".css-ivpc8hz{grid-template-columns:repeat(4, 10px [col-start] 250px [col-end]) 10px;}"
  ];
  [@css
    ".css-ivpccw8{grid-template-columns:100px 1fr max-content minmax(min-content, 1fr);}"
  ];
  [@css
    ".css-ivpc5sr{grid-template-columns:repeat(auto-fill, minmax(25ch, 1fr));}"
  ];
  [@css ".css-ivpcj1h{grid-template-columns:10px [col-start] 250px [col-end];}"];
  [@css
    ".css-ivpc7yp{grid-template-columns:[first nav-start] 150px [main-start] 1fr [last];}"
  ];
  [@css
    ".css-ivpcsrw{grid-template-columns:10px [col-start] 250px [col-end] 10px [col-start] 250px [col-end] 10px;}"
  ];
  [@css
    ".css-ivpcjq4{grid-template-columns:[a] auto [b] minmax(min-content, 1fr) [b c d] repeat(2, [e] 40px) repeat(5, auto);}"
  ];
  [@css
    ".css-ivpcg2p{grid-template-columns:200px repeat(auto-fill, 100px) 300px;}"
  ];
  [@css
    ".css-ivpc3vf{grid-template-columns:minmax(100px, max-content) repeat(auto-fill, 200px) 20%;}"
  ];
  [@css
    ".css-ivpcv68{grid-template-columns:[linename1] 100px [linename2] repeat(auto-fit, [linename3 linename4] 300px) 100px;}"
  ];
  [@css
    ".css-ivpc674{grid-template-columns:[linename1 linename2] 100px repeat(auto-fit, [linename1] 300px) [linename3];}"
  ];
  [@css ".css-ivpc7vz{grid-template-columns:var(--ivpc75i);}"];
  [@css ".css-ivpcr8q{grid-template-rows:none;}"];
  [@css ".css-ivpc7um{grid-template-rows:auto;}"];
  [@css ".css-ivpcbpv{grid-template-rows:100px;}"];
  [@css ".css-ivpczso{grid-template-rows:1fr;}"];
  [@css ".css-ivpchg4{grid-template-rows:100px 1fr auto;}"];
  [@css ".css-ivpcmxd{grid-template-rows:repeat(2, 100px 1fr);}"];
  [@css
    ".css-ivpcizu{grid-template-rows:100px 1fr max-content minmax(min-content, 1fr);}"
  ];
  [@css ".css-ivpc13w{grid-template-rows:10px [row-start] 250px [row-end];}"];
  [@css
    ".css-ivpc6gh{grid-template-rows:[first header-start] 50px [main-start] 1fr [footer-start] 50px [last];}"
  ];
  [@css ".css-ivpc4ey{grid-template-areas:none;}"];
  [@css ".css-ivpcfbk{grid-template-areas:\"articles\";}"];
  [@css ".css-ivpc94q{grid-template-areas:\"head head\";}"];
  [@css
    ".css-ivpcu8c{grid-template-areas:\"head head\" \"nav main\" \"foot ....\";}"
  ];
  [@css ".css-ivpczgm{grid-template:none;}"];
  [@css ".css-ivpc81n{grid-template:auto 1fr auto / auto 1fr;}"];
  [@css
    ".css-ivpcsyo{grid-template:[header-top] \"a   a   a\" [header-bottom] [main-top] \"b   b   b\" 1fr [main-bottom] / auto 1fr auto;}"
  ];
  [@css ".css-ivpcwx4{grid-auto-columns:auto;}"];
  [@css ".css-ivpcbr6{grid-auto-columns:1fr;}"];
  [@css ".css-ivpcddl{grid-auto-columns:100px;}"];
  [@css ".css-ivpcmh5{grid-auto-columns:max-content;}"];
  [@css ".css-ivpc55p{grid-auto-columns:minmax(min-content, 1fr);}"];
  [@css ".css-ivpcgid{grid-auto-columns:min-content max-content auto;}"];
  [@css ".css-ivpc9km{grid-auto-columns:100px 150px 390px;}"];
  [@css
    ".css-ivpc4s7{grid-auto-columns:100px minmax(100px, auto) 10% 0.5fr fit-content(400px);}"
  ];
  [@css ".css-ivpcq2n{grid-auto-rows:auto;}"];
  [@css ".css-ivpcu7f{grid-auto-rows:1fr;}"];
  [@css ".css-ivpcclq{grid-auto-rows:100px;}"];
  [@css ".css-ivpcil4{grid-auto-rows:100px 30%;}"];
  [@css ".css-ivpcmx7{grid-auto-rows:100px 30% 1em;}"];
  [@css ".css-ivpcfqf{grid-auto-rows:min-content;}"];
  [@css ".css-ivpc4k6{grid-auto-rows:minmax(min-content, 1fr);}"];
  [@css ".css-ivpcyjc{grid-auto-rows:min-content max-content auto;}"];
  [@css
    ".css-ivpcb2m{grid-auto-rows:100px minmax(100px, auto) 10% 0.5fr fit-content(400px);}"
  ];
  [@css ".css-ivpcp4b{grid-auto-flow:row;}"];
  [@css ".css-ivpcphy{grid-auto-flow:column;}"];
  [@css ".css-ivpcq5s{grid-auto-flow:row dense;}"];
  [@css ".css-ivpc1br{grid-auto-flow:column dense;}"];
  [@css ".css-ivpceo2{grid:auto-flow 1fr / 100px;}"];
  [@css ".css-ivpcrt1{grid:none / auto-flow 1fr;}"];
  [@css ".css-ivpcj8y{grid:auto-flow / auto 1fr;}"];
  [@css ".css-ivpcwvg{grid:repeat(auto-fill, 5em) / auto-flow 1fr;}"];
  [@css ".css-ivpcz7e{grid:auto-flow 1fr / repeat(auto-fill, 5em);}"];
  [@css
    ".css-ivpcdau{grid:\"H    H \" \"A    B \" \"F    F \" 30px / auto 1fr;}"
  ];
  [@css ".css-ivpc8nf{grid-row-start:auto;}"];
  [@css ".css-ivpcda8{grid-row-start:4;}"];
  [@css ".css-ivpcerd{grid-row-start:C;}"];
  [@css ".css-ivpcn8r{grid-row-start:C 2;}"];
  [@css ".css-ivpc515{grid-row-start:span C;}"];
  [@css ".css-ivpc8ef{grid-row-start:span 1;}"];
  [@css ".css-ivpcufw{grid-column-start:auto;}"];
  [@css ".css-ivpc3kg{grid-column-start:4;}"];
  [@css ".css-ivpcl11{grid-column-start:C;}"];
  [@css ".css-ivpc2s9{grid-column-start:C 2;}"];
  [@css ".css-ivpc455{grid-column-start:span C;}"];
  [@css ".css-ivpcmr9{grid-column-start:span 1;}"];
  [@css ".css-ivpcnpr{grid-row-end:auto;}"];
  [@css ".css-ivpcd6d{grid-row-end:4;}"];
  [@css ".css-ivpca8d{grid-row-end:C;}"];
  [@css ".css-ivpcd4a{grid-row-end:C 2;}"];
  [@css ".css-ivpcaih{grid-row-end:span C;}"];
  [@css ".css-ivpc383{grid-row-end:span 1;}"];
  [@css ".css-ivpc0gw{grid-column-end:auto;}"];
  [@css ".css-ivpci32{grid-column-end:4;}"];
  [@css ".css-ivpcn9d{grid-column-end:C;}"];
  [@css ".css-ivpcfyx{grid-column-end:C 2;}"];
  [@css ".css-ivpcvio{grid-column-end:span C;}"];
  [@css ".css-ivpcykb{grid-column-end:span 1;}"];
  [@css ".css-ivpclh1{-ms-grid-column:auto;grid-column:auto;}"];
  [@css ".css-ivpc8bw{-ms-grid-column:1;grid-column:1;}"];
  [@css ".css-ivpcp48{-ms-grid-column:-1;grid-column:-1;}"];
  [@css ".css-ivpcjh5{-ms-grid-column:1 / 1;grid-column:1 / 1;}"];
  [@css ".css-ivpcmx6{-ms-grid-column:1 / -1;grid-column:1 / -1;}"];
  [@css ".css-ivpcdxi{-ms-grid-column:auto / auto;grid-column:auto / auto;}"];
  [@css ".css-ivpc32l{-ms-grid-column:2 / span 2;grid-column:2 / span 2;}"];
  [@css ".css-ivpcid5{-ms-grid-row:auto;grid-row:auto;}"];
  [@css ".css-ivpci9l{-ms-grid-row:1;grid-row:1;}"];
  [@css ".css-ivpc6l3{-ms-grid-row:-1;grid-row:-1;}"];
  [@css ".css-ivpchh0{-ms-grid-row:1 / 1;grid-row:1 / 1;}"];
  [@css ".css-ivpcj94{-ms-grid-row:1 / -1;grid-row:1 / -1;}"];
  [@css ".css-ivpcyxl{-ms-grid-row:auto / auto;grid-row:auto / auto;}"];
  [@css ".css-ivpcys6{-ms-grid-row:2 / span 2;grid-row:2 / span 2;}"];
  [@css ".css-ivpcw33{grid-area:1 / 1;}"];
  [@css ".css-ivpcavk{grid-area:var(--ivpcp1r);}"];
  [@css ".css-ivpczg2{grid-area:1 / span 1;}"];
  [@css ".css-ivpcyck{grid-area:span 1 / 10 / -1;}"];
  [@css ".css-ivpc1uq{grid-column-gap:0;}"];
  [@css ".css-ivpcezn{grid-column-gap:1em;}"];
  [@css ".css-ivpcn8l{grid-row-gap:0;}"];
  [@css ".css-ivpce8m{grid-row-gap:1em;}"];
  [@css ".css-ivpcshu{grid-gap:0 0;}"];
  [@css ".css-ivpcoeo{grid-gap:0 1em;}"];
  [@css ".css-ivpcg0w{grid-gap:1em;}"];
  [@css ".css-ivpc55a{grid-gap:1em 1em;}"];
  [@css ".css-ivpcdyn{grid-template-columns:subgrid;}"];
  [@css ".css-ivpc4h5{grid-template-columns:subgrid [sub-a];}"];
  [@css ".css-ivpcdir{grid-template-columns:subgrid [sub-a] [sub-b];}"];
  [@css ".css-ivpc51l{grid-template-columns:subgrid repeat(1, [sub-a]);}"];
  [@css
    ".css-ivpcvv1{grid-template-columns:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}"
  ];
  [@css
    ".css-ivpckvw{grid-template-columns:subgrid repeat(auto-fill, [sub-a] [sub-b]);}"
  ];
  [@css
    ".css-ivpc6nd{grid-template-columns:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g]);}"
  ];
  [@css ".css-ivpcy3l{grid-template-rows:subgrid;}"];
  [@css ".css-ivpcu4m{grid-template-rows:subgrid [sub-a];}"];
  [@css ".css-ivpckzz{grid-template-rows:subgrid [sub-a] [sub-b];}"];
  [@css ".css-ivpce7l{grid-template-rows:subgrid repeat(1, [sub-a]);}"];
  [@css
    ".css-ivpcnql{grid-template-rows:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}"
  ];
  [@css
    ".css-ivpcvdc{grid-template-rows:subgrid repeat(auto-fill, [sub-a] [sub-b]);}"
  ];
  [@css
    ".css-ivpc7ev{grid-template-rows:subgrid [sub-a] repeat(auto-fill, [sub-b] [sub-c] [sub-d]) [sub-e] repeat(1, [sub-g]);}"
  ];
  [@css ".css-ivpcmw5{grid-template-columns:masonry;}"];
  [@css ".css-ivpcox1{grid-template-rows:masonry;}"];
  [@css ".css-ivpcaes{masonry-auto-flow:pack;}"];
  [@css ".css-ivpc24h{masonry-auto-flow:next;}"];
  [@css ".css-ivpcooi{masonry-auto-flow:definite-first;}"];
  [@css ".css-ivpcd7e{masonry-auto-flow:ordered;}"];
  [@css ".css-ivpcjkx{masonry-auto-flow:pack definite-first;}"];
  [@css ".css-ivpc2sl{masonry-auto-flow:pack ordered;}"];
  [@css ".css-ivpcg06{masonry-auto-flow:next definite-first;}"];
  [@css ".css-ivpct9c{masonry-auto-flow:next ordered;}"];
  [@css ".css-ivpcv0q{masonry-auto-flow:ordered pack;}"];
  [@css.classes
    [
      ("css-ivpcnxc", 2, "", "input.re", 2, 8, 2, 21),
      ("css-ivpcora", 3, "", "input.re", 3, 8, 3, 28),
      ("css-ivpc6lj", 4, "", "input.re", 4, 8, 4, 35),
      ("css-ivpcnkl", 5, "", "input.re", 5, 8, 5, 35),
      ("css-ivpccg6", 6, "", "input.re", 6, 8, 6, 36),
      ("css-ivpcjs7", 7, "", "input.re", 7, 8, 7, 34),
      ("css-ivpc0cp", 8, "", "input.re", 8, 8, 8, 45),
      ("css-ivpczcj", 9, "", "input.re", 9, 8, 9, 51),
      ("css-ivpc8hz", 10, "", "input.re", 11, 4, 11, 75),
      ("css-ivpccw8", 11, "", "input.re", 14, 4, 14, 73),
      ("css-ivpc5sr", 12, "", "input.re", 16, 8, 16, 67),
      ("css-ivpcj1h", 13, "", "input.re", 17, 8, 17, 63),
      ("css-ivpc7yp", 14, "", "input.re", 19, 4, 19, 74),
      ("css-ivpcsrw", 15, "", "input.re", 22, 4, 22, 97),
      ("css-ivpcjq4", 16, "", "input.re", 25, 4, 25, 108),
      ("css-ivpcg2p", 17, "", "input.re", 27, 8, 27, 69),
      ("css-ivpc3vf", 18, "", "input.re", 29, 4, 29, 84),
      ("css-ivpcv68", 19, "", "input.re", 32, 4, 32, 110),
      ("css-ivpc674", 20, "", "input.re", 36, 4, 36, 104),
      ("css-ivpc7vz", 21, "", "input.re", 51, 8, 51, 39),
      ("css-ivpcr8q", 22, "", "input.re", 52, 8, 52, 32),
      ("css-ivpc7um", 23, "", "input.re", 53, 8, 53, 32),
      ("css-ivpcbpv", 24, "", "input.re", 54, 8, 54, 33),
      ("css-ivpczso", 25, "", "input.re", 55, 8, 55, 31),
      ("css-ivpchg4", 26, "", "input.re", 56, 8, 56, 42),
      ("css-ivpcmxd", 27, "", "input.re", 57, 8, 57, 48),
      ("css-ivpcizu", 28, "", "input.re", 58, 8, 58, 74),
      ("css-ivpc13w", 29, "", "input.re", 59, 8, 59, 60),
      ("css-ivpc6gh", 30, "", "input.re", 61, 4, 61, 93),
      ("css-ivpc4ey", 31, "", "input.re", 63, 8, 63, 33),
      ("css-ivpcfbk", 32, "", "input.re", 64, 8, 64, 39),
      ("css-ivpc94q", 33, "", "input.re", 65, 8, 65, 40),
      ("css-ivpcu8c", 34, "", "input.re", 66, 8, 66, 63),
      ("css-ivpczgm", 35, "", "input.re", 67, 8, 67, 27),
      ("css-ivpc81n", 36, "", "input.re", 68, 8, 68, 47),
      ("css-ivpcsyo", 37, "", "input.re", 70, 4, 70, 116),
      ("css-ivpcwx4", 38, "", "input.re", 72, 8, 72, 31),
      ("css-ivpcbr6", 39, "", "input.re", 73, 8, 73, 30),
      ("css-ivpcddl", 40, "", "input.re", 74, 8, 74, 32),
      ("css-ivpcmh5", 41, "", "input.re", 75, 8, 75, 38),
      ("css-ivpc55p", 42, "", "input.re", 76, 8, 76, 51),
      ("css-ivpcgid", 43, "", "input.re", 77, 8, 77, 55),
      ("css-ivpc9km", 44, "", "input.re", 78, 8, 78, 44),
      ("css-ivpc4s7", 45, "", "input.re", 80, 4, 80, 77),
      ("css-ivpcq2n", 46, "", "input.re", 82, 8, 82, 28),
      ("css-ivpcu7f", 47, "", "input.re", 83, 8, 83, 27),
      ("css-ivpcclq", 48, "", "input.re", 84, 8, 84, 29),
      ("css-ivpcil4", 49, "", "input.re", 85, 8, 85, 33),
      ("css-ivpcmx7", 50, "", "input.re", 86, 8, 86, 37),
      ("css-ivpcfqf", 51, "", "input.re", 87, 8, 87, 35),
      ("css-ivpc4k6", 52, "", "input.re", 88, 8, 88, 48),
      ("css-ivpcyjc", 53, "", "input.re", 89, 8, 89, 52),
      ("css-ivpcb2m", 54, "", "input.re", 91, 4, 91, 74),
      ("css-ivpcp4b", 55, "", "input.re", 93, 8, 93, 27),
      ("css-ivpcphy", 56, "", "input.re", 94, 8, 94, 30),
      ("css-ivpcq5s", 57, "", "input.re", 95, 8, 95, 33),
      ("css-ivpc1br", 58, "", "input.re", 96, 8, 96, 36),
      ("css-ivpceo2", 59, "", "input.re", 97, 8, 97, 35),
      ("css-ivpcrt1", 60, "", "input.re", 98, 8, 98, 34),
      ("css-ivpcj8y", 61, "", "input.re", 99, 8, 99, 34),
      ("css-ivpcwvg", 62, "", "input.re", 100, 8, 100, 52),
      ("css-ivpcz7e", 63, "", "input.re", 101, 8, 101, 53),
      ("css-ivpcdau", 64, "", "input.re", 102, 8, 102, 59),
      ("css-ivpc8nf", 65, "", "input.re", 103, 8, 103, 28),
      ("css-ivpcda8", 66, "", "input.re", 104, 8, 104, 25),
      ("css-ivpcerd", 67, "", "input.re", 105, 8, 105, 25),
      ("css-ivpcn8r", 68, "", "input.re", 106, 8, 106, 27),
      ("css-ivpc515", 69, "", "input.re", 107, 8, 107, 30),
      ("css-ivpc8ef", 70, "", "input.re", 108, 8, 108, 30),
      ("css-ivpcufw", 71, "", "input.re", 109, 8, 109, 31),
      ("css-ivpc3kg", 72, "", "input.re", 110, 8, 110, 28),
      ("css-ivpcl11", 73, "", "input.re", 111, 8, 111, 28),
      ("css-ivpc2s9", 74, "", "input.re", 112, 8, 112, 30),
      ("css-ivpc455", 75, "", "input.re", 113, 8, 113, 33),
      ("css-ivpcmr9", 76, "", "input.re", 114, 8, 114, 33),
      ("css-ivpcnpr", 77, "", "input.re", 115, 8, 115, 26),
      ("css-ivpcd6d", 78, "", "input.re", 116, 8, 116, 23),
      ("css-ivpca8d", 79, "", "input.re", 117, 8, 117, 23),
      ("css-ivpcd4a", 80, "", "input.re", 118, 8, 118, 25),
      ("css-ivpcaih", 81, "", "input.re", 119, 8, 119, 28),
      ("css-ivpc383", 82, "", "input.re", 120, 8, 120, 28),
      ("css-ivpc0gw", 83, "", "input.re", 121, 8, 121, 29),
      ("css-ivpci32", 84, "", "input.re", 122, 8, 122, 26),
      ("css-ivpcn9d", 85, "", "input.re", 123, 8, 123, 26),
      ("css-ivpcfyx", 86, "", "input.re", 124, 8, 124, 28),
      ("css-ivpcvio", 87, "", "input.re", 125, 8, 125, 31),
      ("css-ivpcykb", 88, "", "input.re", 126, 8, 126, 31),
      ("css-ivpclh1", 89, "", "input.re", 127, 8, 127, 25),
      ("css-ivpc8bw", 90, "", "input.re", 128, 8, 128, 22),
      ("css-ivpcp48", 91, "", "input.re", 129, 8, 129, 23),
      ("css-ivpcjh5", 92, "", "input.re", 130, 8, 130, 26),
      ("css-ivpcmx6", 93, "", "input.re", 131, 8, 131, 27),
      ("css-ivpcdxi", 94, "", "input.re", 132, 8, 132, 32),
      ("css-ivpc32l", 95, "", "input.re", 133, 8, 133, 31),
      ("css-ivpcid5", 96, "", "input.re", 134, 8, 134, 22),
      ("css-ivpci9l", 97, "", "input.re", 135, 8, 135, 19),
      ("css-ivpc6l3", 98, "", "input.re", 136, 8, 136, 20),
      ("css-ivpchh0", 99, "", "input.re", 137, 8, 137, 23),
      ("css-ivpcj94", 100, "", "input.re", 138, 8, 138, 24),
      ("css-ivpcyxl", 101, "", "input.re", 139, 8, 139, 29),
      ("css-ivpcys6", 102, "", "input.re", 140, 8, 140, 28),
      ("css-ivpcw33", 103, "", "input.re", 141, 8, 141, 24),
      ("css-ivpcavk", 104, "", "input.re", 143, 8, 143, 26),
      ("css-ivpczg2", 105, "", "input.re", 144, 8, 144, 29),
      ("css-ivpcyck", 106, "", "input.re", 145, 8, 145, 35),
      ("css-ivpc1uq", 107, "", "input.re", 146, 8, 146, 26),
      ("css-ivpcezn", 108, "", "input.re", 147, 8, 147, 28),
      ("css-ivpcn8l", 109, "", "input.re", 148, 8, 148, 23),
      ("css-ivpce8m", 110, "", "input.re", 149, 8, 149, 25),
      ("css-ivpcshu", 111, "", "input.re", 150, 8, 150, 21),
      ("css-ivpcoeo", 112, "", "input.re", 151, 8, 151, 23),
      ("css-ivpcg0w", 113, "", "input.re", 152, 8, 152, 21),
      ("css-ivpc55a", 114, "", "input.re", 153, 8, 153, 25),
      ("css-ivpcdyn", 115, "", "input.re", 156, 8, 156, 38),
      ("css-ivpc4h5", 116, "", "input.re", 157, 8, 157, 46),
      ("css-ivpcdir", 117, "", "input.re", 158, 8, 158, 54),
      ("css-ivpc51l", 118, "", "input.re", 159, 8, 159, 57),
      ("css-ivpcvv1", 119, "", "input.re", 160, 8, 160, 73),
      ("css-ivpckvw", 120, "", "input.re", 161, 8, 161, 73),
      ("css-ivpc6nd", 121, "", "input.re", 163, 4, 163, 112),
      ("css-ivpcy3l", 122, "", "input.re", 165, 8, 165, 35),
      ("css-ivpcu4m", 123, "", "input.re", 166, 8, 166, 43),
      ("css-ivpckzz", 124, "", "input.re", 167, 8, 167, 51),
      ("css-ivpce7l", 125, "", "input.re", 168, 8, 168, 54),
      ("css-ivpcnql", 126, "", "input.re", 169, 8, 169, 70),
      ("css-ivpcvdc", 127, "", "input.re", 170, 8, 170, 70),
      ("css-ivpc7ev", 128, "", "input.re", 172, 4, 172, 109),
      ("css-ivpcmw5", 129, "", "input.re", 176, 8, 176, 38),
      ("css-ivpcox1", 130, "", "input.re", 177, 8, 177, 36),
      ("css-ivpcaes", 131, "", "input.re", 178, 8, 178, 31),
      ("css-ivpc24h", 132, "", "input.re", 179, 8, 179, 31),
      ("css-ivpcooi", 133, "", "input.re", 180, 8, 180, 41),
      ("css-ivpcd7e", 134, "", "input.re", 181, 8, 181, 34),
      ("css-ivpcjkx", 135, "", "input.re", 182, 8, 182, 46),
      ("css-ivpc2sl", 136, "", "input.re", 183, 8, 183, 39),
      ("css-ivpcg06", 137, "", "input.re", 184, 8, 184, 46),
      ("css-ivpct9c", 138, "", "input.re", 185, 8, 185, 39),
      ("css-ivpcv0q", 139, "", "input.re", 186, 8, 186, 39),
    ]
  ];
  
  CSS.make("css-ivpcnxc", []);
  CSS.make("css-ivpcora", []);
  CSS.make("css-ivpc6lj", []);
  CSS.make("css-ivpcnkl", []);
  CSS.make("css-ivpccg6", []);
  CSS.make("css-ivpcjs7", []);
  CSS.make("css-ivpc0cp", []);
  CSS.make("css-ivpczcj", []);
  CSS.make("css-ivpc8hz", []);
  CSS.make("css-ivpccw8", []);
  CSS.make("css-ivpc5sr", []);
  CSS.make("css-ivpcj1h", []);
  CSS.make("css-ivpc7yp", []);
  CSS.make("css-ivpcsrw", []);
  CSS.make("css-ivpcjq4", []);
  CSS.make("css-ivpcg2p", []);
  CSS.make("css-ivpc3vf", []);
  CSS.make("css-ivpcv68", []);
  
  CSS.make("css-ivpc674", []);
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
    "css-ivpc7vz",
    [("--ivpc75i", CSS.Types.GridTemplateColumns.toString(value))],
  );
  CSS.make("css-ivpcr8q", []);
  CSS.make("css-ivpc7um", []);
  CSS.make("css-ivpcbpv", []);
  CSS.make("css-ivpczso", []);
  CSS.make("css-ivpchg4", []);
  CSS.make("css-ivpcmxd", []);
  CSS.make("css-ivpcizu", []);
  CSS.make("css-ivpc13w", []);
  CSS.make("css-ivpc6gh", []);
  CSS.make("css-ivpc4ey", []);
  CSS.make("css-ivpcfbk", []);
  CSS.make("css-ivpc94q", []);
  CSS.make("css-ivpcu8c", []);
  CSS.make("css-ivpczgm", []);
  CSS.make("css-ivpc81n", []);
  CSS.make("css-ivpcsyo", []);
  CSS.make("css-ivpcwx4", []);
  CSS.make("css-ivpcbr6", []);
  CSS.make("css-ivpcddl", []);
  CSS.make("css-ivpcmh5", []);
  CSS.make("css-ivpc55p", []);
  CSS.make("css-ivpcgid", []);
  CSS.make("css-ivpc9km", []);
  CSS.make("css-ivpc4s7", []);
  CSS.make("css-ivpcq2n", []);
  CSS.make("css-ivpcu7f", []);
  CSS.make("css-ivpcclq", []);
  CSS.make("css-ivpcil4", []);
  CSS.make("css-ivpcmx7", []);
  CSS.make("css-ivpcfqf", []);
  CSS.make("css-ivpc4k6", []);
  CSS.make("css-ivpcyjc", []);
  CSS.make("css-ivpcb2m", []);
  CSS.make("css-ivpcp4b", []);
  CSS.make("css-ivpcphy", []);
  CSS.make("css-ivpcq5s", []);
  CSS.make("css-ivpc1br", []);
  CSS.make("css-ivpceo2", []);
  CSS.make("css-ivpcrt1", []);
  CSS.make("css-ivpcj8y", []);
  CSS.make("css-ivpcwvg", []);
  CSS.make("css-ivpcz7e", []);
  CSS.make("css-ivpcdau", []);
  CSS.make("css-ivpc8nf", []);
  CSS.make("css-ivpcda8", []);
  CSS.make("css-ivpcerd", []);
  CSS.make("css-ivpcn8r", []);
  CSS.make("css-ivpc515", []);
  CSS.make("css-ivpc8ef", []);
  CSS.make("css-ivpcufw", []);
  CSS.make("css-ivpc3kg", []);
  CSS.make("css-ivpcl11", []);
  CSS.make("css-ivpc2s9", []);
  CSS.make("css-ivpc455", []);
  CSS.make("css-ivpcmr9", []);
  CSS.make("css-ivpcnpr", []);
  CSS.make("css-ivpcd6d", []);
  CSS.make("css-ivpca8d", []);
  CSS.make("css-ivpcd4a", []);
  CSS.make("css-ivpcaih", []);
  CSS.make("css-ivpc383", []);
  CSS.make("css-ivpc0gw", []);
  CSS.make("css-ivpci32", []);
  CSS.make("css-ivpcn9d", []);
  CSS.make("css-ivpcfyx", []);
  CSS.make("css-ivpcvio", []);
  CSS.make("css-ivpcykb", []);
  CSS.make("css-ivpclh1", []);
  CSS.make("css-ivpc8bw", []);
  CSS.make("css-ivpcp48", []);
  CSS.make("css-ivpcjh5", []);
  CSS.make("css-ivpcmx6", []);
  CSS.make("css-ivpcdxi", []);
  CSS.make("css-ivpc32l", []);
  CSS.make("css-ivpcid5", []);
  CSS.make("css-ivpci9l", []);
  CSS.make("css-ivpc6l3", []);
  CSS.make("css-ivpchh0", []);
  CSS.make("css-ivpcj94", []);
  CSS.make("css-ivpcyxl", []);
  CSS.make("css-ivpcys6", []);
  CSS.make("css-ivpcw33", []);
  let area = `num(33);
  CSS.make(
    "css-ivpcavk",
    [("--ivpcp1r", CSS.Types.GridArea.toString(area))],
  );
  CSS.make("css-ivpczg2", []);
  CSS.make("css-ivpcyck", []);
  CSS.make("css-ivpc1uq", []);
  CSS.make("css-ivpcezn", []);
  CSS.make("css-ivpcn8l", []);
  CSS.make("css-ivpce8m", []);
  CSS.make("css-ivpcshu", []);
  CSS.make("css-ivpcoeo", []);
  CSS.make("css-ivpcg0w", []);
  CSS.make("css-ivpc55a", []);
  
  CSS.make("css-ivpcdyn", []);
  CSS.make("css-ivpc4h5", []);
  CSS.make("css-ivpcdir", []);
  CSS.make("css-ivpc51l", []);
  CSS.make("css-ivpcvv1", []);
  CSS.make("css-ivpckvw", []);
  CSS.make("css-ivpc6nd", []);
  CSS.make("css-ivpcy3l", []);
  CSS.make("css-ivpcu4m", []);
  CSS.make("css-ivpckzz", []);
  CSS.make("css-ivpce7l", []);
  CSS.make("css-ivpcnql", []);
  CSS.make("css-ivpcvdc", []);
  CSS.make("css-ivpc7ev", []);
  
  CSS.make("css-ivpcmw5", []);
  CSS.make("css-ivpcox1", []);
  CSS.make("css-ivpcaes", []);
  CSS.make("css-ivpc24h", []);
  CSS.make("css-ivpcooi", []);
  CSS.make("css-ivpcd7e", []);
  CSS.make("css-ivpcjkx", []);
  CSS.make("css-ivpc2sl", []);
  CSS.make("css-ivpcg06", []);
  CSS.make("css-ivpct9c", []);
  CSS.make("css-ivpcv0q", []);
