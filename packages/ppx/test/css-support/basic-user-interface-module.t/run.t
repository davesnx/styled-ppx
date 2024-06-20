This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build

  $ dune describe pp ./input.re.ml | refmt --parse ml --print re
  [@ocaml.ppx.context
    {
      tool_name: "ppx_driver",
      include_dirs: [],
      load_path: [],
      open_modules: [],
      for_package: None,
      debug: false,
      use_threads: false,
      use_vmthreads: false,
      recursive_types: false,
      principal: false,
      transparent_modules: false,
      unboxed_types: false,
      unsafe_string: false,
      cookies: [],
    }
  ];
  CssJs.boxSizing(`borderBox);
  CssJs.boxSizing(`contentBox);
  CssJs.outlineStyle(`auto);
  CssJs.outlineStyle(`none);
  CssJs.outlineStyle(`dotted);
  CssJs.outlineStyle(`dashed);
  CssJs.outlineStyle(`solid);
  CssJs.outlineStyle(`double);
  CssJs.outlineStyle(`groove);
  CssJs.outlineStyle(`ridge);
  CssJs.outlineStyle(`inset);
  CssJs.outlineStyle(`outset);
  CssJs.outlineOffset(`pxFloat(-5.));
  CssJs.outlineOffset(`zero);
  CssJs.outlineOffset(`pxFloat(5.));
  CssJs.unsafe({|resize|}, {|none|});
  CssJs.unsafe({|resize|}, {|both|});
  CssJs.unsafe({|resize|}, {|horizontal|});
  CssJs.unsafe({|resize|}, {|vertical|});
  CssJs.textOverflow(`clip);
  CssJs.textOverflow(`ellipsis);
  CssJs.cursor(`default);
  CssJs.cursor(`none);
  CssJs.cursor(`contextMenu);
  CssJs.cursor(`cell);
  CssJs.cursor(`verticalText);
  CssJs.cursor(`alias);
  CssJs.cursor(`copy);
  CssJs.cursor(`noDrop);
  CssJs.cursor(`notAllowed);
  CssJs.cursor(`grab);
  CssJs.cursor(`grabbing);
  CssJs.cursor(`ewResize);
  CssJs.cursor(`nsResize);
  CssJs.cursor(`neswResize);
  CssJs.cursor(`nwseResize);
  CssJs.cursor(`colResize);
  CssJs.cursor(`rowResize);
  CssJs.cursor(`allScroll);
  CssJs.cursor(`zoomIn);
  CssJs.cursor(`zoomOut);
  CssJs.unsafe({|caretColor|}, {|auto|});
  CssJs.unsafe({|caretColor|}, {|green|});
  CssJs.unsafe({|appearance|}, {|auto|});
  CssJs.unsafe({|appearance|}, {|none|});
  CssJs.textOverflow(`clip);
  CssJs.textOverflow(`ellipsis);
  CssJs.textOverflow(`string({|foo|}));
  CssJs.unsafe({|textOverflow|}, {|clip clip|});
  CssJs.unsafe({|textOverflow|}, {|ellipsis clip|});
  CssJs.unsafe({|textOverflow|}, {|'foo' clip|});
  CssJs.unsafe({|textOverflow|}, {|clip ellipsis|});
  CssJs.unsafe({|textOverflow|}, {|ellipsis ellipsis|});
  CssJs.unsafe({|textOverflow|}, {|'foo' ellipsis|});
  CssJs.unsafe({|textOverflow|}, {|clip 'foo'|});
  CssJs.unsafe({|textOverflow|}, {|ellipsis 'foo'|});
  CssJs.unsafe({|textOverflow|}, {|'foo' 'foo'|});
  CssJs.unsafe({|userSelect|}, {|auto|});
  CssJs.unsafe({|userSelect|}, {|text|});
  CssJs.unsafe({|userSelect|}, {|none|});
  CssJs.unsafe({|userSelect|}, {|contain|});
  CssJs.unsafe({|userSelect|}, {|all|});

  $ dune build
