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
    ".css-kzef2z { quotes: auto; }\n.css-uks4w6 { content: \"►\" / \"\"; }\n.css-osruv2 { content: \"\"; }\n.css-18fgq8t { content: counter(count, decimal); }\n.css-97uct6 { content: counter(count, decimal) \") \"; }\n.css-1spwa6n { content: unset; }\n.css-1cfi6iy { content: normal; }\n.css-1wetqq9 { content: none; }\n.css-1x3aegt { content: url(\"http://www.example.com/test.png\"); }\n.css-1bkdxpi { content: linear-gradient(#e66465, #9198e5); }\n.css-10kwuit { content: image-set(\"image1x.png\" 1x, \"image2x.png\" 2x); }\n.css-1nrqfa0 { content: url(\"../img/test.png\") / \"This is the alt text\"; }\n.css-wpb9rc { content: \"unparsed text\"; }\n.css-19omh37 { content: attr(href); }\n.css-srfnjw { content: attr(data-width px); }\n.css-15eucfc { content: open-quote; }\n.css-1oh0gem { content: close-quote; }\n.css-1vkb2uw { content: no-open-quote; }\n.css-15njwfz { content: no-close-quote; }\n.css-1tlmr9x { content: \"prefix\" url(\"http://www.example.com/test.png\"); }\n.css-1v79iew { content: \"prefix\" url(\"/img/test.png\") \"suffix\" / \"Alt text\"; }\n.css-1pw55v7 { content: inherit; }\n.css-1d53ba8 { content: initial; }\n.css-6ogn5d { content: revert; }\n.css-e3zrum { content: revert-layer; }\n.css-1jo521i { content: \"点\"; }\n.css-3fn60f { content: \"lola\"; }\n.css-1qr4vg { content: \" \"; }\n.css-1vwn4dm { content: \"'\"; }\n.css-15b57nm { content: \"\"\"; }\n.css-13a2b21 { content: attr(data-value); }\n.css-106qa47 { content: attr(data-value raw-string); }\n.css-4a4run { content: attr(data-value em); }\n.css-x4z73r { content: attr(data-value px); }\n.css-1aqlaeu { content: \"→\"; }\n.css-1edmid9 { content: \"←\"; }\n.css-16g23vh { content: \"↑\"; }\n.css-1ljhzzx { content: \"↓\"; }\n.css-s7fmsh { content: \"“\"; }\n.css-t0u322 { content: \"‘\"; }\n.css-18r2j5x { content: \"’\"; }\n.css-18r9qjz { content: \"—\"; }\n.css-tmwxsb { content: \"…\"; }\n.css-ieb5tk { content: \"♥\"; }\n.css-z7f70d { content: \"✓\"; }\n.css-11z9g7d { content: \"✗\"; }\n.css-1my55lt { content: \"\" attr(data-title) \"”\"; }\n.css-1ofhn70 { content: \"→\" \" Click here\"; }\n.css-1p6os6s { content: \"Step \" counter(step, decimal) \": \"; }\n.css-1vfinhy { content: \"💡\"; }\n.css-thy0y7 { content: \"👍\"; }\n.css-1uuu61r { content: \"»\"; }\n.css-1ymva63 { content: \"§\"; }\n.css-1nw78qk { content: \"→ \" attr(href); }\n.css-3aoqj { content: \"• \" counter(item, decimal) \" \"; }\n"
  ];
  CSS.make("css-kzef2z", []);
  
  CSS.make("css-uks4w6", []);
  
  CSS.make("css-osruv2", []);
  
  CSS.make("css-18fgq8t", []);
  CSS.make("css-97uct6", []);
  CSS.make("css-1spwa6n", []);
  
  CSS.make("css-1cfi6iy", []);
  CSS.make("css-1wetqq9", []);
  
  CSS.make("css-1x3aegt", []);
  CSS.make("css-1bkdxpi", []);
  CSS.make("css-10kwuit", []);
  
  CSS.make("css-1nrqfa0", []);
  
  CSS.make("css-wpb9rc", []);
  
  CSS.make("css-19omh37", []);
  CSS.make("css-srfnjw", []);
  
  CSS.make("css-15eucfc", []);
  CSS.make("css-1oh0gem", []);
  CSS.make("css-1vkb2uw", []);
  CSS.make("css-15njwfz", []);
  
  CSS.make("css-1tlmr9x", []);
  CSS.make("css-1v79iew", []);
  
  CSS.make("css-1pw55v7", []);
  CSS.make("css-1d53ba8", []);
  CSS.make("css-6ogn5d", []);
  CSS.make("css-e3zrum", []);
  CSS.make("css-1spwa6n", []);
  
  CSS.make("css-1jo521i", []);
  CSS.make("css-1jo521i", []);
  CSS.make("css-1jo521i", []);
  CSS.make("css-3fn60f", []);
  CSS.make("css-3fn60f", []);
  CSS.make("css-osruv2", []);
  CSS.make("css-1qr4vg", []);
  CSS.make("css-1qr4vg", []);
  CSS.make("css-osruv2", []);
  CSS.make("css-1vwn4dm", []);
  CSS.make("css-15b57nm", []);
  
  CSS.make("css-19omh37", []);
  CSS.make("css-13a2b21", []);
  
  CSS.make("css-106qa47", []);
  CSS.make("css-4a4run", []);
  CSS.make("css-x4z73r", []);
  
  CSS.make("css-1aqlaeu", []);
  CSS.make("css-1edmid9", []);
  CSS.make("css-16g23vh", []);
  CSS.make("css-1ljhzzx", []);
  
  CSS.make("css-s7fmsh", []);
  
  CSS.make("css-t0u322", []);
  CSS.make("css-18r2j5x", []);
  
  CSS.make("css-15b57nm", []);
  CSS.make("css-18r9qjz", []);
  CSS.make("css-tmwxsb", []);
  CSS.make("css-ieb5tk", []);
  CSS.make("css-z7f70d", []);
  CSS.make("css-11z9g7d", []);
  CSS.make("css-tmwxsb", []);
  
  CSS.make("css-1my55lt", []);
  CSS.make("css-1ofhn70", []);
  CSS.make("css-1p6os6s", []);
  
  CSS.make("css-1vfinhy", []);
  CSS.make("css-thy0y7", []);
  
  CSS.make("css-1uuu61r", []);
  CSS.make("css-1ymva63", []);
  
  CSS.make("css-1aqlaeu", []);
  CSS.make("css-1qr4vg", []);
  
  CSS.make("css-1aqlaeu", []);
  CSS.make("css-15b57nm", []);
  CSS.make("css-18r9qjz", []);
  CSS.make("css-tmwxsb", []);
  CSS.make("css-15b57nm", []);
  CSS.make("css-15b57nm", []);
  CSS.make("css-z7f70d", []);
  CSS.make("css-ieb5tk", []);
  CSS.make("css-1nw78qk", []);
  CSS.make("css-3aoqj", []);
