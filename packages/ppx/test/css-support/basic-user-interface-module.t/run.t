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
  CssJs.unsafe({js|resize|js}, {js|none|js});
  CssJs.unsafe({js|resize|js}, {js|both|js});
  CssJs.unsafe({js|resize|js}, {js|horizontal|js});
  CssJs.unsafe({js|resize|js}, {js|vertical|js});
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
  CssJs.unsafe({js|caretColor|js}, {js|auto|js});
  CssJs.unsafe({js|caretColor|js}, {js|green|js});
  CssJs.unsafe({js|appearance|js}, {js|auto|js});
  CssJs.unsafe({js|appearance|js}, {js|none|js});
  CssJs.textOverflow(`clip);
  CssJs.textOverflow(`ellipsis);
  CssJs.textOverflow(`string({js|foo|js}));
  CssJs.unsafe({js|textOverflow|js}, {js|clip clip|js});
  CssJs.unsafe({js|textOverflow|js}, {js|ellipsis clip|js});
  CssJs.unsafe({js|textOverflow|js}, {js|'foo' clip|js});
  CssJs.unsafe({js|textOverflow|js}, {js|clip ellipsis|js});
  CssJs.unsafe({js|textOverflow|js}, {js|ellipsis ellipsis|js});
  CssJs.unsafe({js|textOverflow|js}, {js|'foo' ellipsis|js});
  CssJs.unsafe({js|textOverflow|js}, {js|clip 'foo'|js});
  CssJs.unsafe({js|textOverflow|js}, {js|ellipsis 'foo'|js});
  CssJs.unsafe({js|textOverflow|js}, {js|'foo' 'foo'|js});
  CssJs.userSelect(`auto);
  CssJs.userSelect(`text);
  CssJs.userSelect(`none);
  CssJs.userSelect(`contain);
  CssJs.userSelect(`all);

  $ dune build
