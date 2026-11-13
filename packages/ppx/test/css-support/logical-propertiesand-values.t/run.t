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
  [@css ".css-7mz79u{caption-side:inline-start;}"];
  [@css ".css-5u5p43{caption-side:inline-end;}"];
  [@css ".css-kqir4a{float:inline-start;}"];
  [@css ".css-1sxnx20{float:inline-end;}"];
  [@css ".css-19hhk00{clear:inline-start;}"];
  [@css ".css-u1gdzw{clear:inline-end;}"];
  [@css ".css-156qw47{resize:block;}"];
  [@css ".css-1fmy9i6{resize:inline;}"];
  [@css ".css-svysv2{block-size:100px;}"];
  [@css ".css-i8z6hn{inline-size:100px;}"];
  [@css ".css-1lzmmlh{min-block-size:100px;}"];
  [@css ".css-1f1hcln{min-inline-size:100px;}"];
  [@css ".css-vhgdm0{max-block-size:100px;}"];
  [@css ".css-1hguxwp{max-inline-size:100px;}"];
  [@css ".css-5k0441{margin-block:10px;}"];
  [@css ".css-v5bau3{margin-block:10px 10px;}"];
  [@css ".css-1jw84jr{margin-block-start:10px;}"];
  [@css ".css-q32d8m{margin-block-end:10px;}"];
  [@css ".css-mty236{margin-inline:10px;}"];
  [@css ".css-1cn5u5a{margin-inline:10px 10px;}"];
  [@css
    ".css-n2eom{-webkit-margin-inline-start:10px;margin-inline-start:10px;}"
  ];
  [@css ".css-122d16h{-webkit-margin-inline-end:10px;margin-inline-end:10px;}"];
  [@css ".css-mqdnfh{inset:10px;}"];
  [@css ".css-11hvniv{inset:10px 10px;}"];
  [@css ".css-12nt223{inset:10px 10px 10px;}"];
  [@css ".css-vohzxm{inset:10px 10px 10px 10px;}"];
  [@css ".css-147vi6x{inset-block:10px;}"];
  [@css ".css-17mc543{inset-block:10px 10px;}"];
  [@css ".css-9e1f8u{inset-block-start:10px;}"];
  [@css ".css-1githvz{inset-block-end:10px;}"];
  [@css ".css-13gqea3{inset-inline:10px;}"];
  [@css ".css-1m9cfbq{inset-inline:10px 10px;}"];
  [@css ".css-2el462{inset-inline-start:10px;}"];
  [@css ".css-osat9e{inset-inline-end:10px;}"];
  [@css ".css-10nlncu{padding-block:10px;}"];
  [@css ".css-1kqk887{padding-block:10px 10px;}"];
  [@css ".css-19twxy7{padding-block-start:10px;}"];
  [@css ".css-1c7676y{padding-block-end:10px;}"];
  [@css ".css-1i1h6su{padding-inline:10px;}"];
  [@css ".css-1j5h71r{padding-inline:10px 10px;}"];
  [@css
    ".css-nywxcj{-webkit-padding-inline-start:10px;padding-inline-start:10px;}"
  ];
  [@css ".css-sonisa{-webkit-padding-inline-end:10px;padding-inline-end:10px;}"];
  [@css ".css-tuuyuh{border-block:1px;}"];
  [@css ".css-clo02m{border-block:2px dotted;}"];
  [@css ".css-z6em57{border-block:medium dashed green;}"];
  [@css ".css-vvqkyu{border-block-start:1px;}"];
  [@css ".css-1s3ynk8{border-block-start:2px dotted;}"];
  [@css ".css-csz2dr{border-block-start:medium dashed green;}"];
  [@css ".css-1taq9fl{border-block-start-width:thin;}"];
  [@css ".css-t3h7up{border-block-start-style:dotted;}"];
  [@css ".css-h89i83{border-block-start-color:navy;}"];
  [@css ".css-1cnh1he{border-block-end:1px;}"];
  [@css ".css-z7cyo{border-block-end:2px dotted;}"];
  [@css ".css-10gjshu{border-block-end:medium dashed green;}"];
  [@css ".css-1l5bmkl{border-block-end-width:thin;}"];
  [@css ".css-ysgx5j{border-block-end-style:dotted;}"];
  [@css ".css-1uifhab{border-block-end-color:navy;}"];
  [@css ".css-bdrrhu{border-block-color:navy blue;}"];
  [@css ".css-1xhxv6v{border-inline:1px;}"];
  [@css ".css-1s77iqu{border-inline:2px dotted;}"];
  [@css ".css-1h286bq{border-inline:medium dashed green;}"];
  [@css ".css-1rpd03w{border-inline-start:1px;}"];
  [@css ".css-iev7c1{border-inline-start:2px dotted;}"];
  [@css ".css-1mcxfm1{border-inline-start:medium dashed green;}"];
  [@css ".css-nbbm9x{border-inline-start-width:thin;}"];
  [@css ".css-1ftrvxn{border-inline-start-style:dotted;}"];
  [@css ".css-1upicpl{border-inline-start-color:navy;}"];
  [@css ".css-2ohsxv{border-inline-end:1px;}"];
  [@css ".css-uayx1k{border-inline-end:2px dotted;}"];
  [@css ".css-1yzogvx{border-inline-end:medium dashed green;}"];
  [@css ".css-1yrztd{border-inline-end-width:thin;}"];
  [@css ".css-monsr5{border-inline-end-style:dotted;}"];
  [@css ".css-1vnl01k{border-inline-end-color:navy;}"];
  [@css ".css-byewf5{border-inline-color:navy blue;}"];
  [@css ".css-1yd9gj8{border-start-start-radius:0;}"];
  [@css ".css-cr8zws{border-start-start-radius:50%;}"];
  [@css ".css-17b7r8g{border-start-start-radius:250px 100px;}"];
  [@css ".css-1daceji{border-start-end-radius:0;}"];
  [@css ".css-446pxb{border-start-end-radius:50%;}"];
  [@css ".css-1csw90r{border-start-end-radius:250px 100px;}"];
  [@css ".css-1x77fpi{border-end-start-radius:0;}"];
  [@css ".css-effwqa{border-end-start-radius:50%;}"];
  [@css ".css-kyvqvg{border-end-start-radius:250px 100px;}"];
  [@css ".css-l3kxx5{border-end-end-radius:0;}"];
  [@css ".css-vvmxna{border-end-end-radius:50%;}"];
  [@css ".css-a71r0b{border-end-end-radius:250px 100px;}"];
  [@css.classes
    [
      ("css-7mz79u", 0, "", "input.re", 2, 8, 2, 34),
      ("css-5u5p43", 1, "", "input.re", 3, 8, 3, 32),
      ("css-kqir4a", 2, "", "input.re", 4, 8, 4, 27),
      ("css-1sxnx20", 3, "", "input.re", 5, 8, 5, 25),
      ("css-19hhk00", 4, "", "input.re", 6, 8, 6, 27),
      ("css-u1gdzw", 5, "", "input.re", 7, 8, 7, 25),
      ("css-156qw47", 6, "", "input.re", 8, 8, 8, 21),
      ("css-1fmy9i6", 7, "", "input.re", 9, 8, 9, 22),
      ("css-svysv2", 8, "", "input.re", 10, 8, 10, 25),
      ("css-i8z6hn", 9, "", "input.re", 11, 8, 11, 26),
      ("css-1lzmmlh", 10, "", "input.re", 12, 8, 12, 29),
      ("css-1f1hcln", 11, "", "input.re", 13, 8, 13, 30),
      ("css-vhgdm0", 12, "", "input.re", 14, 8, 14, 29),
      ("css-1hguxwp", 13, "", "input.re", 15, 8, 15, 30),
      ("css-5k0441", 14, "", "input.re", 16, 8, 16, 26),
      ("css-v5bau3", 15, "", "input.re", 17, 8, 17, 31),
      ("css-1jw84jr", 16, "", "input.re", 18, 8, 18, 32),
      ("css-q32d8m", 17, "", "input.re", 19, 8, 19, 30),
      ("css-mty236", 18, "", "input.re", 20, 8, 20, 27),
      ("css-1cn5u5a", 19, "", "input.re", 21, 8, 21, 32),
      ("css-n2eom", 20, "", "input.re", 22, 8, 22, 33),
      ("css-122d16h", 21, "", "input.re", 23, 8, 23, 31),
      ("css-mqdnfh", 22, "", "input.re", 24, 8, 24, 19),
      ("css-11hvniv", 23, "", "input.re", 25, 8, 25, 24),
      ("css-12nt223", 24, "", "input.re", 26, 8, 26, 29),
      ("css-vohzxm", 25, "", "input.re", 27, 8, 27, 34),
      ("css-147vi6x", 26, "", "input.re", 28, 8, 28, 25),
      ("css-17mc543", 27, "", "input.re", 29, 8, 29, 30),
      ("css-9e1f8u", 28, "", "input.re", 30, 8, 30, 31),
      ("css-1githvz", 29, "", "input.re", 31, 8, 31, 29),
      ("css-13gqea3", 30, "", "input.re", 32, 8, 32, 26),
      ("css-1m9cfbq", 31, "", "input.re", 33, 8, 33, 31),
      ("css-2el462", 32, "", "input.re", 34, 8, 34, 32),
      ("css-osat9e", 33, "", "input.re", 35, 8, 35, 30),
      ("css-10nlncu", 34, "", "input.re", 36, 8, 36, 27),
      ("css-1kqk887", 35, "", "input.re", 37, 8, 37, 32),
      ("css-19twxy7", 36, "", "input.re", 38, 8, 38, 33),
      ("css-1c7676y", 37, "", "input.re", 39, 8, 39, 31),
      ("css-1i1h6su", 38, "", "input.re", 40, 8, 40, 28),
      ("css-1j5h71r", 39, "", "input.re", 41, 8, 41, 33),
      ("css-nywxcj", 40, "", "input.re", 42, 8, 42, 34),
      ("css-sonisa", 41, "", "input.re", 43, 8, 43, 32),
      ("css-tuuyuh", 42, "", "input.re", 44, 8, 44, 25),
      ("css-clo02m", 43, "", "input.re", 45, 8, 45, 32),
      ("css-z6em57", 44, "", "input.re", 46, 8, 46, 41),
      ("css-vvqkyu", 45, "", "input.re", 47, 8, 47, 31),
      ("css-1s3ynk8", 46, "", "input.re", 48, 8, 48, 38),
      ("css-csz2dr", 47, "", "input.re", 49, 8, 49, 47),
      ("css-1taq9fl", 48, "", "input.re", 50, 8, 50, 38),
      ("css-t3h7up", 49, "", "input.re", 51, 8, 51, 40),
      ("css-h89i83", 50, "", "input.re", 52, 8, 52, 38),
      ("css-1cnh1he", 51, "", "input.re", 53, 8, 53, 29),
      ("css-z7cyo", 52, "", "input.re", 54, 8, 54, 36),
      ("css-10gjshu", 53, "", "input.re", 55, 8, 55, 45),
      ("css-1l5bmkl", 54, "", "input.re", 56, 8, 56, 36),
      ("css-ysgx5j", 55, "", "input.re", 57, 8, 57, 38),
      ("css-1uifhab", 56, "", "input.re", 58, 8, 58, 36),
      ("css-bdrrhu", 57, "", "input.re", 61, 8, 61, 37),
      ("css-1xhxv6v", 58, "", "input.re", 62, 8, 62, 26),
      ("css-1s77iqu", 59, "", "input.re", 63, 8, 63, 33),
      ("css-1h286bq", 60, "", "input.re", 64, 8, 64, 42),
      ("css-1rpd03w", 61, "", "input.re", 65, 8, 65, 32),
      ("css-iev7c1", 62, "", "input.re", 66, 8, 66, 39),
      ("css-1mcxfm1", 63, "", "input.re", 67, 8, 67, 48),
      ("css-nbbm9x", 64, "", "input.re", 68, 8, 68, 39),
      ("css-1ftrvxn", 65, "", "input.re", 69, 8, 69, 41),
      ("css-1upicpl", 66, "", "input.re", 70, 8, 70, 39),
      ("css-2ohsxv", 67, "", "input.re", 71, 8, 71, 30),
      ("css-uayx1k", 68, "", "input.re", 72, 8, 72, 37),
      ("css-1yzogvx", 69, "", "input.re", 73, 8, 73, 46),
      ("css-1yrztd", 70, "", "input.re", 74, 8, 74, 37),
      ("css-monsr5", 71, "", "input.re", 75, 8, 75, 39),
      ("css-1vnl01k", 72, "", "input.re", 76, 8, 76, 37),
      ("css-byewf5", 73, "", "input.re", 79, 8, 79, 38),
      ("css-1yd9gj8", 74, "", "input.re", 80, 8, 80, 36),
      ("css-cr8zws", 75, "", "input.re", 81, 8, 81, 38),
      ("css-17b7r8g", 76, "", "input.re", 82, 8, 82, 46),
      ("css-1daceji", 77, "", "input.re", 83, 8, 83, 34),
      ("css-446pxb", 78, "", "input.re", 84, 8, 84, 36),
      ("css-1csw90r", 79, "", "input.re", 85, 8, 85, 44),
      ("css-1x77fpi", 80, "", "input.re", 86, 8, 86, 34),
      ("css-effwqa", 81, "", "input.re", 87, 8, 87, 36),
      ("css-kyvqvg", 82, "", "input.re", 88, 8, 88, 44),
      ("css-l3kxx5", 83, "", "input.re", 89, 8, 89, 32),
      ("css-vvmxna", 84, "", "input.re", 90, 8, 90, 34),
      ("css-a71r0b", 85, "", "input.re", 91, 8, 91, 42),
    ]
  ];
  
  CSS.make("css-7mz79u", []);
  CSS.make("css-5u5p43", []);
  CSS.make("css-kqir4a", []);
  CSS.make("css-1sxnx20", []);
  CSS.make("css-19hhk00", []);
  CSS.make("css-u1gdzw", []);
  CSS.make("css-156qw47", []);
  CSS.make("css-1fmy9i6", []);
  CSS.make("css-svysv2", []);
  CSS.make("css-i8z6hn", []);
  CSS.make("css-1lzmmlh", []);
  CSS.make("css-1f1hcln", []);
  CSS.make("css-vhgdm0", []);
  CSS.make("css-1hguxwp", []);
  CSS.make("css-5k0441", []);
  CSS.make("css-v5bau3", []);
  CSS.make("css-1jw84jr", []);
  CSS.make("css-q32d8m", []);
  CSS.make("css-mty236", []);
  CSS.make("css-1cn5u5a", []);
  CSS.make("css-n2eom", []);
  CSS.make("css-122d16h", []);
  CSS.make("css-mqdnfh", []);
  CSS.make("css-11hvniv", []);
  CSS.make("css-12nt223", []);
  CSS.make("css-vohzxm", []);
  CSS.make("css-147vi6x", []);
  CSS.make("css-17mc543", []);
  CSS.make("css-9e1f8u", []);
  CSS.make("css-1githvz", []);
  CSS.make("css-13gqea3", []);
  CSS.make("css-1m9cfbq", []);
  CSS.make("css-2el462", []);
  CSS.make("css-osat9e", []);
  CSS.make("css-10nlncu", []);
  CSS.make("css-1kqk887", []);
  CSS.make("css-19twxy7", []);
  CSS.make("css-1c7676y", []);
  CSS.make("css-1i1h6su", []);
  CSS.make("css-1j5h71r", []);
  CSS.make("css-nywxcj", []);
  CSS.make("css-sonisa", []);
  CSS.make("css-tuuyuh", []);
  CSS.make("css-clo02m", []);
  CSS.make("css-z6em57", []);
  CSS.make("css-vvqkyu", []);
  CSS.make("css-1s3ynk8", []);
  CSS.make("css-csz2dr", []);
  CSS.make("css-1taq9fl", []);
  CSS.make("css-t3h7up", []);
  CSS.make("css-h89i83", []);
  CSS.make("css-1cnh1he", []);
  CSS.make("css-z7cyo", []);
  CSS.make("css-10gjshu", []);
  CSS.make("css-1l5bmkl", []);
  CSS.make("css-ysgx5j", []);
  CSS.make("css-1uifhab", []);
  
  CSS.make("css-bdrrhu", []);
  CSS.make("css-1xhxv6v", []);
  CSS.make("css-1s77iqu", []);
  CSS.make("css-1h286bq", []);
  CSS.make("css-1rpd03w", []);
  CSS.make("css-iev7c1", []);
  CSS.make("css-1mcxfm1", []);
  CSS.make("css-nbbm9x", []);
  CSS.make("css-1ftrvxn", []);
  CSS.make("css-1upicpl", []);
  CSS.make("css-2ohsxv", []);
  CSS.make("css-uayx1k", []);
  CSS.make("css-1yzogvx", []);
  CSS.make("css-1yrztd", []);
  CSS.make("css-monsr5", []);
  CSS.make("css-1vnl01k", []);
  
  CSS.make("css-byewf5", []);
  CSS.make("css-1yd9gj8", []);
  CSS.make("css-cr8zws", []);
  CSS.make("css-17b7r8g", []);
  CSS.make("css-1daceji", []);
  CSS.make("css-446pxb", []);
  CSS.make("css-1csw90r", []);
  CSS.make("css-1x77fpi", []);
  CSS.make("css-effwqa", []);
  CSS.make("css-kyvqvg", []);
  CSS.make("css-l3kxx5", []);
  CSS.make("css-vvmxna", []);
  CSS.make("css-a71r0b", []);
