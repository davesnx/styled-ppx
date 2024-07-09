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
  CSS.unsafe({js|resize|js}, {js|none|js});
  CSS.unsafe({js|resize|js}, {js|both|js});
  CSS.unsafe({js|resize|js}, {js|horizontal|js});
  CSS.unsafe({js|resize|js}, {js|vertical|js});
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
  CSS.unsafe({js|appearance|js}, {js|auto|js});
  CSS.unsafe({js|appearance|js}, {js|none|js});
  CSS.textOverflow(`clip);
  CSS.textOverflow(`ellipsis);
  CSS.textOverflow(`string({js|foo|js}));
  CSS.unsafe({js|textOverflow|js}, {js|clip clip|js});
  CSS.unsafe({js|textOverflow|js}, {js|ellipsis clip|js});
  CSS.unsafe({js|textOverflow|js}, {js|'foo' clip|js});
  CSS.unsafe({js|textOverflow|js}, {js|clip ellipsis|js});
  CSS.unsafe({js|textOverflow|js}, {js|ellipsis ellipsis|js});
  CSS.unsafe({js|textOverflow|js}, {js|'foo' ellipsis|js});
  CSS.unsafe({js|textOverflow|js}, {js|clip 'foo'|js});
  CSS.unsafe({js|textOverflow|js}, {js|ellipsis 'foo'|js});
  CSS.unsafe({js|textOverflow|js}, {js|'foo' 'foo'|js});
  CSS.userSelect(`auto);
  CSS.userSelect(`text);
  CSS.userSelect(`none);
  CSS.userSelect(`contain);
  CSS.userSelect(`all);

  $ dune build
