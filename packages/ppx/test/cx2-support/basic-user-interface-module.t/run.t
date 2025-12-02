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
    ".css-t4wdd6 { box-sizing: border-box; }\n.css-1o7awd8 { box-sizing: content-box; }\n.css-msuo7a { outline-style: auto; }\n.css-1r6150q { outline-style: none; }\n.css-1aotdqt { outline-style: dotted; }\n.css-1ik71lc { outline-style: dashed; }\n.css-zz85nw { outline-style: solid; }\n.css-mosx9y { outline-style: double; }\n.css-g7bo1t { outline-style: groove; }\n.css-1b4gslg { outline-style: ridge; }\n.css-155utrz { outline-style: inset; }\n.css-107bh12 { outline-style: outset; }\n.css-1duftui { outline-offset: -5px; }\n.css-1yf7qq { outline-offset: 0; }\n.css-1faa143 { outline-offset: 5px; }\n.css-16azont { resize: none; }\n.css-13c9pzu { resize: both; }\n.css-1vdm7ox { resize: horizontal; }\n.css-1ezpyu1 { resize: vertical; }\n.css-f16v9c { text-overflow: clip; }\n.css-hj0la8 { text-overflow: ellipsis; }\n.css-apmse4 { cursor: default; }\n.css-sb695v { cursor: none; }\n.css-1iqnhk9 { cursor: context-menu; }\n.css-x0fiuo { cursor: cell; }\n.css-exw398 { cursor: vertical-text; }\n.css-mf96a2 { cursor: alias; }\n.css-1petjew { cursor: copy; }\n.css-1dlmed { cursor: no-drop; }\n.css-1clacm2 { cursor: not-allowed; }\n.css-efj213 { cursor: grab; }\n.css-109y3s4 { cursor: grabbing; }\n.css-1gwv7dd { cursor: ew-resize; }\n.css-g4wuk3 { cursor: ns-resize; }\n.css-oouldl { cursor: nesw-resize; }\n.css-1rz6s52 { cursor: nwse-resize; }\n.css-1ldpa4f { cursor: col-resize; }\n.css-4o6ys1 { cursor: row-resize; }\n.css-16zdop4 { cursor: all-scroll; }\n.css-kkhv6f { cursor: zoom-in; }\n.css-o1phr5 { cursor: zoom-out; }\n.css-d4rrkh { caret-color: auto; }\n.css-1iwe6o9 { caret-color: green; }\n.css-vijte7 { appearance: auto; }\n.css-1mar6mu { appearance: none; }\n.css-1fo2rhg { text-overflow: \"foo\"; }\n.css-ejrs9j { text-overflow: clip clip; }\n.css-3fugm9 { text-overflow: ellipsis clip; }\n.css-4ns6d5 { text-overflow: \"foo\" clip; }\n.css-1lg9isa { text-overflow: clip ellipsis; }\n.css-iucslp { text-overflow: ellipsis ellipsis; }\n.css-bnltrq { text-overflow: \"foo\" ellipsis; }\n.css-1p6t8if { text-overflow: clip \"foo\"; }\n.css-9l3by5 { text-overflow: ellipsis \"foo\"; }\n.css-a01399 { text-overflow: \"foo\" \"foo\"; }\n.css-2ivm7i { user-select: auto; }\n.css-ny7vl5 { user-select: text; }\n.css-v7pysf { user-select: none; }\n.css-bujf45 { user-select: contain; }\n.css-1up6yon { user-select: all; }\n"
  ];
  CSS.make("css-t4wdd6", []);
  CSS.make("css-1o7awd8", []);
  CSS.make("css-msuo7a", []);
  CSS.make("css-1r6150q", []);
  CSS.make("css-1aotdqt", []);
  CSS.make("css-1ik71lc", []);
  CSS.make("css-zz85nw", []);
  CSS.make("css-mosx9y", []);
  CSS.make("css-g7bo1t", []);
  CSS.make("css-1b4gslg", []);
  CSS.make("css-155utrz", []);
  CSS.make("css-107bh12", []);
  CSS.make("css-1duftui", []);
  CSS.make("css-1yf7qq", []);
  CSS.make("css-1faa143", []);
  CSS.make("css-16azont", []);
  CSS.make("css-13c9pzu", []);
  CSS.make("css-1vdm7ox", []);
  CSS.make("css-1ezpyu1", []);
  CSS.make("css-f16v9c", []);
  CSS.make("css-hj0la8", []);
  
  CSS.make("css-apmse4", []);
  CSS.make("css-sb695v", []);
  CSS.make("css-1iqnhk9", []);
  CSS.make("css-x0fiuo", []);
  CSS.make("css-exw398", []);
  CSS.make("css-mf96a2", []);
  CSS.make("css-1petjew", []);
  CSS.make("css-1dlmed", []);
  CSS.make("css-1clacm2", []);
  CSS.make("css-efj213", []);
  CSS.make("css-109y3s4", []);
  CSS.make("css-1gwv7dd", []);
  CSS.make("css-g4wuk3", []);
  CSS.make("css-oouldl", []);
  CSS.make("css-1rz6s52", []);
  CSS.make("css-1ldpa4f", []);
  CSS.make("css-4o6ys1", []);
  CSS.make("css-16zdop4", []);
  CSS.make("css-kkhv6f", []);
  CSS.make("css-o1phr5", []);
  CSS.make("css-d4rrkh", []);
  CSS.make("css-1iwe6o9", []);
  
  CSS.make("css-vijte7", []);
  CSS.make("css-1mar6mu", []);
  
  CSS.make("css-f16v9c", []);
  CSS.make("css-hj0la8", []);
  
  CSS.make("css-1fo2rhg", []);
  CSS.make("css-ejrs9j", []);
  CSS.make("css-3fugm9", []);
  
  CSS.make("css-4ns6d5", []);
  CSS.make("css-1lg9isa", []);
  CSS.make("css-iucslp", []);
  
  CSS.make("css-bnltrq", []);
  
  CSS.make("css-1p6t8if", []);
  CSS.make("css-9l3by5", []);
  
  CSS.make("css-a01399", []);
  CSS.make("css-2ivm7i", []);
  CSS.make("css-ny7vl5", []);
  CSS.make("css-v7pysf", []);
  CSS.make("css-bujf45", []);
  CSS.make("css-1up6yon", []);

  $ dune build
