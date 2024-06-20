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
  CssJs.unsafe({|breakBefore|}, {|auto|});
  CssJs.unsafe({|breakBefore|}, {|avoid|});
  CssJs.unsafe({|breakBefore|}, {|avoid-page|});
  CssJs.unsafe({|breakBefore|}, {|page|});
  CssJs.unsafe({|breakBefore|}, {|left|});
  CssJs.unsafe({|breakBefore|}, {|right|});
  CssJs.unsafe({|breakBefore|}, {|recto|});
  CssJs.unsafe({|breakBefore|}, {|verso|});
  CssJs.unsafe({|breakBefore|}, {|avoid-column|});
  CssJs.unsafe({|breakBefore|}, {|column|});
  CssJs.unsafe({|breakBefore|}, {|avoid-region|});
  CssJs.unsafe({|breakBefore|}, {|region|});
  CssJs.unsafe({|breakAfter|}, {|auto|});
  CssJs.unsafe({|breakAfter|}, {|avoid|});
  CssJs.unsafe({|breakAfter|}, {|avoid-page|});
  CssJs.unsafe({|breakAfter|}, {|page|});
  CssJs.unsafe({|breakAfter|}, {|left|});
  CssJs.unsafe({|breakAfter|}, {|right|});
  CssJs.unsafe({|breakAfter|}, {|recto|});
  CssJs.unsafe({|breakAfter|}, {|verso|});
  CssJs.unsafe({|breakAfter|}, {|avoid-column|});
  CssJs.unsafe({|breakAfter|}, {|column|});
  CssJs.unsafe({|breakAfter|}, {|avoid-region|});
  CssJs.unsafe({|breakAfter|}, {|region|});
  CssJs.unsafe({|breakInside|}, {|auto|});
  CssJs.unsafe({|breakInside|}, {|avoid|});
  CssJs.unsafe({|breakInside|}, {|avoid-page|});
  CssJs.unsafe({|breakInside|}, {|avoid-column|});
  CssJs.unsafe({|breakInside|}, {|avoid-region|});
  CssJs.unsafe({|boxDecorationBreak|}, {|slice|});
  CssJs.unsafe({|boxDecorationBreak|}, {|clone|});
  CssJs.unsafe({|orphans|}, {|1|});
  CssJs.unsafe({|orphans|}, {|2|});
