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
  [@css "._a_9uidje{quotes:auto;}"];
  [@css "._a_4wf2ur{content:\"►\" / \"\";}"];
  [@css "._a_4wsdc1{content:\"\";}"];
  [@css "._a_4wdhko{content:counter(ol);}"];
  [@css "._a_4wzbnh{content:counter(count, decimal);}"];
  [@css "._a_4w56qq{content:counter(count, decimal) \") \";}"];
  [@css "._a_4wd7tk{content:unset;}"];
  [@css "._a_4wordy{content:normal;}"];
  [@css "._a_4wzcbh{content:none;}"];
  [@css "._a_4w1wxf{content:url(\"http://www.example.com/test.png\");}"];
  [@css "._a_4weiwy{content:linear-gradient(#e66465, #9198e5);}"];
  [@css
    "._a_4wnydd{content:image-set(\"image1x.png\" 1x, \"image2x.png\" 2x);}"
  ];
  [@css
    "._a_4wu5b0{content:url(\"../img/test.png\") / \"This is the alt text\";}"
  ];
  [@css "._a_4w6790{content:\"unparsed text\";}"];
  [@css "._a_4wr3ui{content:counter(chapter_counter);}"];
  [@css "._a_4wxuxw{content:counter(chapter_counter, upper-roman);}"];
  [@css "._a_4wwggo{content:counters(section_counter, \".\");}"];
  [@css
    "._a_4w14i9{content:counters(section_counter, \".\", decimal-leading-zero);}"
  ];
  [@css "._a_4wn5wz{content:attr(href);}"];
  [@css "._a_4w2bce{content:attr(data-width px);}"];
  [@css "._a_4wenc9{content:open-quote;}"];
  [@css "._a_4w0d5m{content:close-quote;}"];
  [@css "._a_4woxre{content:no-open-quote;}"];
  [@css "._a_4wyzsz{content:no-close-quote;}"];
  [@css
    "._a_4wq46n{content:\"prefix\" url(\"http://www.example.com/test.png\");}"
  ];
  [@css
    "._a_4wt6w1{content:\"prefix\" url(\"/img/test.png\") \"suffix\" / \"Alt text\";}"
  ];
  [@css "._a_4wwmef{content:open-quote counter(chapter_counter);}"];
  [@css "._a_4w1hfk{content:inherit;}"];
  [@css "._a_4wslsq{content:initial;}"];
  [@css "._a_4wltxf{content:revert;}"];
  [@css "._a_4wtvgg{content:revert-layer;}"];
  [@css "._a_4wks2k{content:\"点\";}"];
  [@css "._a_4wf07t{content:\"lola\";}"];
  [@css "._a_4wvtt9{content:\" \";}"];
  [@css "._a_4w6l48{content:\"'\";}"];
  [@css "._a_4wu917{content:\"\\\"\";}"];
  [@css "._a_4wwufj{content:attr(data-value);}"];
  [@css "._a_4wn7nw{content:attr(data-value raw-string);}"];
  [@css "._a_4wtxzt{content:attr(data-value em);}"];
  [@css "._a_4webvu{content:attr(data-value px);}"];
  [@css "._a_4w3vis{content:\"→\";}"];
  [@css "._a_4w8i71{content:\"←\";}"];
  [@css "._a_4wjm9f{content:\"↑\";}"];
  [@css "._a_4w8ulk{content:\"↓\";}"];
  [@css "._a_4wi5s9{content:\"“\";}"];
  [@css "._a_4wb13f{content:\"‘\";}"];
  [@css "._a_4wn7fj{content:\"’\";}"];
  [@css "._a_4wwxr5{content:\"•\";}"];
  [@css "._a_4w5ir8{content:\"—\";}"];
  [@css "._a_4w17ng{content:\"…\";}"];
  [@css "._a_4w8arn{content:\"♥\";}"];
  [@css "._a_4wgzna{content:\"✓\";}"];
  [@css "._a_4wy3yn{content:\"✗\";}"];
  [@css "._a_4wvyh0{content:\"\" attr(data-title) \"”\";}"];
  [@css "._a_4wnazq{content:\"→\" \" Click here\";}"];
  [@css "._a_4w520c{content:\"Step \" counter(step, decimal) \": \";}"];
  [@css "._a_4we5sp{content:\"💡\";}"];
  [@css "._a_4w561c{content:\"👍\";}"];
  [@css "._a_4wvc81{content:\"»\";}"];
  [@css "._a_4w3v3e{content:\"§\";}"];
  [@css "._a_4wfv9f{content:\"→ \" attr(href);}"];
  [@css "._a_4w4efr{content:\"• \" counter(item, decimal) \" \";}"];
  
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
