This test ensures the ppx generates the correct output against styled-ppx.emotion_native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native)
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
  CssJs.unsafe({js|breakBefore|js}, {js|auto|js});
  CssJs.unsafe({js|breakBefore|js}, {js|avoid|js});
  CssJs.unsafe({js|breakBefore|js}, {js|avoid-page|js});
  CssJs.unsafe({js|breakBefore|js}, {js|page|js});
  CssJs.unsafe({js|breakBefore|js}, {js|left|js});
  CssJs.unsafe({js|breakBefore|js}, {js|right|js});
  CssJs.unsafe({js|breakBefore|js}, {js|recto|js});
  CssJs.unsafe({js|breakBefore|js}, {js|verso|js});
  CssJs.unsafe({js|breakBefore|js}, {js|avoid-column|js});
  CssJs.unsafe({js|breakBefore|js}, {js|column|js});
  CssJs.unsafe({js|breakBefore|js}, {js|avoid-region|js});
  CssJs.unsafe({js|breakBefore|js}, {js|region|js});
  CssJs.unsafe({js|breakAfter|js}, {js|auto|js});
  CssJs.unsafe({js|breakAfter|js}, {js|avoid|js});
  CssJs.unsafe({js|breakAfter|js}, {js|avoid-page|js});
  CssJs.unsafe({js|breakAfter|js}, {js|page|js});
  CssJs.unsafe({js|breakAfter|js}, {js|left|js});
  CssJs.unsafe({js|breakAfter|js}, {js|right|js});
  CssJs.unsafe({js|breakAfter|js}, {js|recto|js});
  CssJs.unsafe({js|breakAfter|js}, {js|verso|js});
  CssJs.unsafe({js|breakAfter|js}, {js|avoid-column|js});
  CssJs.unsafe({js|breakAfter|js}, {js|column|js});
  CssJs.unsafe({js|breakAfter|js}, {js|avoid-region|js});
  CssJs.unsafe({js|breakAfter|js}, {js|region|js});
  CssJs.unsafe({js|breakInside|js}, {js|auto|js});
  CssJs.unsafe({js|breakInside|js}, {js|avoid|js});
  CssJs.unsafe({js|breakInside|js}, {js|avoid-page|js});
  CssJs.unsafe({js|breakInside|js}, {js|avoid-column|js});
  CssJs.unsafe({js|breakInside|js}, {js|avoid-region|js});
  CssJs.unsafe({js|boxDecorationBreak|js}, {js|slice|js});
  CssJs.unsafe({js|boxDecorationBreak|js}, {js|clone|js});
  CssJs.unsafe({js|orphans|js}, {js|1|js});
  CssJs.unsafe({js|orphans|js}, {js|2|js});
