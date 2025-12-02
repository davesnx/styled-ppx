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
    ".css-lbk5m { caption-side: inline-start; }\n.css-j0hngk { caption-side: inline-end; }\n.css-xq4l47 { float: inline-start; }\n.css-1rs8054 { float: inline-end; }\n.css-h4m0hw { clear: inline-start; }\n.css-1mv3ckh { clear: inline-end; }\n.css-17w8cy0 { resize: block; }\n.css-1fqej0 { resize: inline; }\n.css-mw62u4 { block-size: 100px; }\n.css-exsijd { inline-size: 100px; }\n.css-1vytuo1 { min-block-size: 100px; }\n.css-1w8unl7 { min-inline-size: 100px; }\n.css-1kvz1ai { max-block-size: 100px; }\n.css-ar0ndq { max-inline-size: 100px; }\n.css-ui8d8n { margin-block: 10px; }\n.css-46uqtu { margin-block: 10px 10px; }\n.css-1v9gji0 { margin-block-start: 10px; }\n.css-1gugygk { margin-block-end: 10px; }\n.css-e3avt6 { margin-inline: 10px; }\n.css-wz2vuw { margin-inline: 10px 10px; }\n.css-7c52p4 { margin-inline-start: 10px; }\n.css-1bhriyp { margin-inline-end: 10px; }\n.css-bki7rv { inset: 10px; }\n.css-1hzt528 { inset: 10px 10px; }\n.css-167j7bo { inset: 10px 10px 10px; }\n.css-jdipfs { inset: 10px 10px 10px 10px; }\n.css-9h7jqn { inset-block: 10px; }\n.css-16nf1z { inset-block: 10px 10px; }\n.css-1bhjftf { inset-block-start: 10px; }\n.css-n544gq { inset-block-end: 10px; }\n.css-fa39mz { inset-inline: 10px; }\n.css-1tjkhmw { inset-inline: 10px 10px; }\n.css-1trlv10 { inset-inline-start: 10px; }\n.css-1o3g4zx { inset-inline-end: 10px; }\n.css-mh0nvf { padding-block: 10px; }\n.css-tn8u9n { padding-block: 10px 10px; }\n.css-1jpj8jd { padding-block-start: 10px; }\n.css-6fy1he { padding-block-end: 10px; }\n.css-aylv9w { padding-inline: 10px; }\n.css-17v036g { padding-inline: 10px 10px; }\n.css-1kpit0t { padding-inline-start: 10px; }\n.css-v9bb9b { padding-inline-end: 10px; }\n.css-5nuvor { border-block: 1px; }\n.css-14vh9bg { border-block: 2px dotted; }\n.css-nzuzvh { border-block: medium dashed green; }\n.css-vabwbi { border-block-start: 1px; }\n.css-d6nhax { border-block-start: 2px dotted; }\n.css-5v19il { border-block-start: medium dashed green; }\n.css-qn5lr6 { border-block-start-width: thin; }\n.css-v2apoq { border-block-start-style: dotted; }\n.css-no5cbw { border-block-start-color: navy; }\n.css-ewd1bg { border-block-end: 1px; }\n.css-5l8w1a { border-block-end: 2px dotted; }\n.css-100hzql { border-block-end: medium dashed green; }\n.css-6zvjaa { border-block-end-width: thin; }\n.css-ibegtz { border-block-end-style: dotted; }\n.css-7u56n0 { border-block-end-color: navy; }\n.css-13yx4i7 { border-block-color: navy blue; }\n.css-1vrm5ze { border-inline: 1px; }\n.css-1fqcqio { border-inline: 2px dotted; }\n.css-84hdx { border-inline: medium dashed green; }\n.css-c28v8t { border-inline-start: 1px; }\n.css-uzjr9t { border-inline-start: 2px dotted; }\n.css-19phc3y { border-inline-start: medium dashed green; }\n.css-hrcbsb { border-inline-start-width: thin; }\n.css-1pp25j8 { border-inline-start-style: dotted; }\n.css-v745kt { border-inline-start-color: navy; }\n.css-h6erl5 { border-inline-end: 1px; }\n.css-xyqx4e { border-inline-end: 2px dotted; }\n.css-zh3jf4 { border-inline-end: medium dashed green; }\n.css-6e04wk { border-inline-end-width: thin; }\n.css-1darnub { border-inline-end-style: dotted; }\n.css-f67n99 { border-inline-end-color: navy; }\n.css-rj8g4x { border-inline-color: navy blue; }\n.css-1x2xzxl { border-start-start-radius: 0; }\n.css-owjxrr { border-start-start-radius: 50%; }\n.css-muytoi { border-start-start-radius: 250px 100px; }\n.css-7fvm9n { border-start-end-radius: 0; }\n.css-rdt01a { border-start-end-radius: 50%; }\n.css-1jvancl { border-start-end-radius: 250px 100px; }\n.css-bgudyf { border-end-start-radius: 0; }\n.css-udwylg { border-end-start-radius: 50%; }\n.css-qhj2z2 { border-end-start-radius: 250px 100px; }\n.css-17ul9tn { border-end-end-radius: 0; }\n.css-tvqybk { border-end-end-radius: 50%; }\n.css-ymja7b { border-end-end-radius: 250px 100px; }\n"
  ];
  CSS.make("css-lbk5m", []);
  CSS.make("css-j0hngk", []);
  CSS.make("css-xq4l47", []);
  CSS.make("css-1rs8054", []);
  CSS.make("css-h4m0hw", []);
  CSS.make("css-1mv3ckh", []);
  CSS.make("css-17w8cy0", []);
  CSS.make("css-1fqej0", []);
  CSS.make("css-mw62u4", []);
  CSS.make("css-exsijd", []);
  CSS.make("css-1vytuo1", []);
  CSS.make("css-1w8unl7", []);
  CSS.make("css-1kvz1ai", []);
  CSS.make("css-ar0ndq", []);
  CSS.make("css-ui8d8n", []);
  CSS.make("css-46uqtu", []);
  CSS.make("css-1v9gji0", []);
  CSS.make("css-1gugygk", []);
  CSS.make("css-e3avt6", []);
  CSS.make("css-wz2vuw", []);
  CSS.make("css-7c52p4", []);
  CSS.make("css-1bhriyp", []);
  CSS.make("css-bki7rv", []);
  CSS.make("css-1hzt528", []);
  CSS.make("css-167j7bo", []);
  CSS.make("css-jdipfs", []);
  CSS.make("css-9h7jqn", []);
  CSS.make("css-16nf1z", []);
  CSS.make("css-1bhjftf", []);
  CSS.make("css-n544gq", []);
  CSS.make("css-fa39mz", []);
  CSS.make("css-1tjkhmw", []);
  CSS.make("css-1trlv10", []);
  CSS.make("css-1o3g4zx", []);
  CSS.make("css-mh0nvf", []);
  CSS.make("css-tn8u9n", []);
  CSS.make("css-1jpj8jd", []);
  CSS.make("css-6fy1he", []);
  CSS.make("css-aylv9w", []);
  CSS.make("css-17v036g", []);
  CSS.make("css-1kpit0t", []);
  CSS.make("css-v9bb9b", []);
  CSS.make("css-5nuvor", []);
  CSS.make("css-14vh9bg", []);
  CSS.make("css-nzuzvh", []);
  CSS.make("css-vabwbi", []);
  CSS.make("css-d6nhax", []);
  CSS.make("css-5v19il", []);
  CSS.make("css-qn5lr6", []);
  CSS.make("css-v2apoq", []);
  CSS.make("css-no5cbw", []);
  CSS.make("css-ewd1bg", []);
  CSS.make("css-5l8w1a", []);
  CSS.make("css-100hzql", []);
  CSS.make("css-6zvjaa", []);
  CSS.make("css-ibegtz", []);
  CSS.make("css-7u56n0", []);
  
  CSS.make("css-13yx4i7", []);
  CSS.make("css-1vrm5ze", []);
  CSS.make("css-1fqcqio", []);
  CSS.make("css-84hdx", []);
  CSS.make("css-c28v8t", []);
  CSS.make("css-uzjr9t", []);
  CSS.make("css-19phc3y", []);
  CSS.make("css-hrcbsb", []);
  CSS.make("css-1pp25j8", []);
  CSS.make("css-v745kt", []);
  CSS.make("css-h6erl5", []);
  CSS.make("css-xyqx4e", []);
  CSS.make("css-zh3jf4", []);
  CSS.make("css-6e04wk", []);
  CSS.make("css-1darnub", []);
  CSS.make("css-f67n99", []);
  
  CSS.make("css-rj8g4x", []);
  CSS.make("css-1x2xzxl", []);
  CSS.make("css-owjxrr", []);
  CSS.make("css-muytoi", []);
  CSS.make("css-7fvm9n", []);
  CSS.make("css-rdt01a", []);
  CSS.make("css-1jvancl", []);
  CSS.make("css-bgudyf", []);
  CSS.make("css-udwylg", []);
  CSS.make("css-qhj2z2", []);
  CSS.make("css-17ul9tn", []);
  CSS.make("css-tvqybk", []);
  CSS.make("css-ymja7b", []);
