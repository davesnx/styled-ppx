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
  
  CSS.boxSizing(`borderBox);
  CSS.boxSizing(`contentBox);
  CSS.outlineStyle(`auto);
  CSS.outlineStyle(`none);
  CSS.outlineStyle(`dotted);
  CSS.outlineStyle(`dashed);
  CSS.outlineStyle(`solid);
  CSS.outlineStyle(`double);
  CSS.outlineStyle(`groove);
  CSS.outlineStyle(`ridge);
  CSS.outlineStyle(`inset);
  CSS.outlineStyle(`outset);
  CSS.outlineOffset(`pxFloat(-5.));
  CSS.outlineOffset(`zero);
  CSS.outlineOffset(`pxFloat(5.));
  CSS.resize(`none);
  CSS.resize(`both);
  CSS.resize(`horizontal);
  CSS.resize(`vertical);
  CSS.textOverflow(`clip);
  CSS.textOverflow(`ellipsis);
  
  CSS.cursor(`default);
  CSS.cursor(`none);
  CSS.cursor(`contextMenu);
  CSS.cursor(`cell);
  CSS.cursor(`verticalText);
  CSS.cursor(`alias);
  CSS.cursor(`copy);
  CSS.cursor(`noDrop);
  CSS.cursor(`notAllowed);
  CSS.cursor(`grab);
  CSS.cursor(`grabbing);
  CSS.cursor(`ewResize);
  CSS.cursor(`nsResize);
  CSS.cursor(`neswResize);
  CSS.cursor(`nwseResize);
  CSS.cursor(`colResize);
  CSS.cursor(`rowResize);
  CSS.cursor(`allScroll);
  CSS.cursor(`zoomIn);
  CSS.cursor(`zoomOut);
  CSS.unsafe({js|caretColor|js}, {js|auto|js});
  CSS.unsafe({js|caretColor|js}, {js|green|js});
  
  CSS.appearance(`auto);
  CSS.appearance(`none);
  
  CSS.textOverflow(`clip);
  CSS.textOverflow(`ellipsis);
  
  CSS.textOverflow(`string({js|foo|js}));
  CSS.unsafe({js|textOverflow|js}, {js|clip clip|js});
  CSS.unsafe({js|textOverflow|js}, {js|ellipsis clip|js});
  
  CSS.unsafe({js|textOverflow|js}, {js|"foo" clip|js});
  CSS.unsafe({js|textOverflow|js}, {js|clip ellipsis|js});
  CSS.unsafe({js|textOverflow|js}, {js|ellipsis ellipsis|js});
  
  CSS.unsafe({js|textOverflow|js}, {js|"foo" ellipsis|js});
  
  CSS.unsafe({js|textOverflow|js}, {js|clip "foo"|js});
  CSS.unsafe({js|textOverflow|js}, {js|ellipsis "foo"|js});
  
  CSS.unsafe({js|textOverflow|js}, {js|"foo" "foo"|js});
  CSS.userSelect(`auto);
  CSS.userSelect(`text);
  CSS.userSelect(`none);
  CSS.userSelect(`contain);
  CSS.userSelect(`all);

  $ dune build
