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
  [@css ".a-9uidje{quotes:auto;}"];
  [@css ".a-4wf2ur{content:\"►\" / \"\";}"];
  [@css ".a-4wsdc1{content:\"\";}"];
  [@css ".a-4wdhko{content:counter(ol);}"];
  [@css ".a-4wzbnh{content:counter(count, decimal);}"];
  [@css ".a-4w56qq{content:counter(count, decimal) \") \";}"];
  [@css ".a-4wd7tk{content:unset;}"];
  [@css ".a-4wordy{content:normal;}"];
  [@css ".a-4wzcbh{content:none;}"];
  [@css ".a-4w1wxf{content:url(\"http://www.example.com/test.png\");}"];
  [@css ".a-4weiwy{content:linear-gradient(#e66465, #9198e5);}"];
  [@css ".a-4wnydd{content:image-set(\"image1x.png\" 1x, \"image2x.png\" 2x);}"];
  [@css
    ".a-4wu5b0{content:url(\"../img/test.png\") / \"This is the alt text\";}"
  ];
  [@css ".a-4w6790{content:\"unparsed text\";}"];
  [@css ".a-4wr3ui{content:counter(chapter_counter);}"];
  [@css ".a-4wxuxw{content:counter(chapter_counter, upper-roman);}"];
  [@css ".a-4wwggo{content:counters(section_counter, \".\");}"];
  [@css
    ".a-4w14i9{content:counters(section_counter, \".\", decimal-leading-zero);}"
  ];
  [@css ".a-4wn5wz{content:attr(href);}"];
  [@css ".a-4w2bce{content:attr(data-width px);}"];
  [@css ".a-4wenc9{content:open-quote;}"];
  [@css ".a-4w0d5m{content:close-quote;}"];
  [@css ".a-4woxre{content:no-open-quote;}"];
  [@css ".a-4wyzsz{content:no-close-quote;}"];
  [@css
    ".a-4wq46n{content:\"prefix\" url(\"http://www.example.com/test.png\");}"
  ];
  [@css
    ".a-4wt6w1{content:\"prefix\" url(\"/img/test.png\") \"suffix\" / \"Alt text\";}"
  ];
  [@css ".a-4wwmef{content:open-quote counter(chapter_counter);}"];
  [@css ".a-4w1hfk{content:inherit;}"];
  [@css ".a-4wslsq{content:initial;}"];
  [@css ".a-4wltxf{content:revert;}"];
  [@css ".a-4wtvgg{content:revert-layer;}"];
  [@css ".a-4wks2k{content:\"点\";}"];
  [@css ".a-4wf07t{content:\"lola\";}"];
  [@css ".a-4wvtt9{content:\" \";}"];
  [@css ".a-4w6l48{content:\"'\";}"];
  [@css ".a-4wu917{content:\"\\\"\";}"];
  [@css ".a-4wwufj{content:attr(data-value);}"];
  [@css ".a-4wn7nw{content:attr(data-value raw-string);}"];
  [@css ".a-4wtxzt{content:attr(data-value em);}"];
  [@css ".a-4webvu{content:attr(data-value px);}"];
  [@css ".a-4w3vis{content:\"→\";}"];
  [@css ".a-4w8i71{content:\"←\";}"];
  [@css ".a-4wjm9f{content:\"↑\";}"];
  [@css ".a-4w8ulk{content:\"↓\";}"];
  [@css ".a-4wi5s9{content:\"“\";}"];
  [@css ".a-4wb13f{content:\"‘\";}"];
  [@css ".a-4wn7fj{content:\"’\";}"];
  [@css ".a-4wwxr5{content:\"•\";}"];
  [@css ".a-4w5ir8{content:\"—\";}"];
  [@css ".a-4w17ng{content:\"…\";}"];
  [@css ".a-4w8arn{content:\"♥\";}"];
  [@css ".a-4wgzna{content:\"✓\";}"];
  [@css ".a-4wy3yn{content:\"✗\";}"];
  [@css ".a-4wvyh0{content:\"\" attr(data-title) \"”\";}"];
  [@css ".a-4wnazq{content:\"→\" \" Click here\";}"];
  [@css ".a-4w520c{content:\"Step \" counter(step, decimal) \": \";}"];
  [@css ".a-4we5sp{content:\"💡\";}"];
  [@css ".a-4w561c{content:\"👍\";}"];
  [@css ".a-4wvc81{content:\"»\";}"];
  [@css ".a-4w3v3e{content:\"§\";}"];
  [@css ".a-4wfv9f{content:\"→ \" attr(href);}"];
  [@css ".a-4w4efr{content:\"• \" counter(item, decimal) \" \";}"];
  
  CSS.make("a-9uidje", []);
  
  CSS.make("a-4wf2ur", []);
  
  CSS.make("a-4wsdc1", []);
  
  CSS.make("a-4wdhko", []);
  CSS.make("a-4wzbnh", []);
  CSS.make("a-4w56qq", []);
  CSS.make("a-4wd7tk", []);
  
  CSS.make("a-4wordy", []);
  CSS.make("a-4wzcbh", []);
  
  CSS.make("a-4w1wxf", []);
  CSS.make("a-4weiwy", []);
  CSS.make("a-4wnydd", []);
  
  CSS.make("a-4wu5b0", []);
  
  CSS.make("a-4w6790", []);
  
  CSS.make("a-4wr3ui", []);
  CSS.make("a-4wxuxw", []);
  
  CSS.make("a-4wwggo", []);
  CSS.make("a-4w14i9", []);
  
  CSS.make("a-4wn5wz", []);
  CSS.make("a-4w2bce", []);
  
  CSS.make("a-4wenc9", []);
  CSS.make("a-4w0d5m", []);
  CSS.make("a-4woxre", []);
  CSS.make("a-4wyzsz", []);
  
  CSS.make("a-4wq46n", []);
  CSS.make("a-4wt6w1", []);
  
  CSS.make("a-4wwmef", []);
  
  CSS.make("a-4w1hfk", []);
  CSS.make("a-4wslsq", []);
  CSS.make("a-4wltxf", []);
  CSS.make("a-4wtvgg", []);
  CSS.make("a-4wd7tk", []);
  
  CSS.make("a-4wks2k", []);
  CSS.make("a-4wks2k", []);
  CSS.make("a-4wks2k", []);
  CSS.make("a-4wf07t", []);
  CSS.make("a-4wf07t", []);
  CSS.make("a-4wsdc1", []);
  CSS.make("a-4wvtt9", []);
  CSS.make("a-4wvtt9", []);
  CSS.make("a-4wsdc1", []);
  CSS.make("a-4w6l48", []);
  CSS.make("a-4wu917", []);
  
  CSS.make("a-4wn5wz", []);
  CSS.make("a-4wwufj", []);
  
  CSS.make("a-4wn7nw", []);
  CSS.make("a-4wtxzt", []);
  CSS.make("a-4webvu", []);
  
  CSS.make("a-4w3vis", []);
  CSS.make("a-4w8i71", []);
  CSS.make("a-4wjm9f", []);
  CSS.make("a-4w8ulk", []);
  
  CSS.make("a-4wi5s9", []);
  
  CSS.make("a-4wb13f", []);
  CSS.make("a-4wn7fj", []);
  
  CSS.make("a-4wwxr5", []);
  CSS.make("a-4w5ir8", []);
  CSS.make("a-4w17ng", []);
  CSS.make("a-4w8arn", []);
  CSS.make("a-4wgzna", []);
  CSS.make("a-4wy3yn", []);
  CSS.make("a-4w17ng", []);
  
  CSS.make("a-4wvyh0", []);
  CSS.make("a-4wnazq", []);
  CSS.make("a-4w520c", []);
  
  CSS.make("a-4we5sp", []);
  CSS.make("a-4w561c", []);
  
  CSS.make("a-4wvc81", []);
  CSS.make("a-4w3v3e", []);
  
  CSS.make("a-4w3vis", []);
  CSS.make("a-4wvtt9", []);
  
  CSS.make("a-4w3vis", []);
  CSS.make("a-4wwxr5", []);
  CSS.make("a-4w5ir8", []);
  CSS.make("a-4w17ng", []);
  CSS.make("a-4wu917", []);
  CSS.make("a-4wu917", []);
  CSS.make("a-4wgzna", []);
  CSS.make("a-4w8arn", []);
  CSS.make("a-4wfv9f", []);
  CSS.make("a-4w4efr", []);
