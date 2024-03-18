This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat >dune-project <<EOF
  > (lang dune 3.10)
  > EOF

  $ cat >dune <<EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
  >  (preprocess (pps styled-ppx.lib)))
  > EOF

  $ dune build

  $ dune_describe_pp _build/default/input.re.pp.ml | refmt --parse ml --print re
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
  CssJs.width(`rem(5.));
  CssJs.width(`ch(5.));
  CssJs.width(`vw(5.));
  CssJs.width(`vh(5.));
  CssJs.width(`vmin(5.));
  CssJs.width(`vmax(5.));
  CssJs.width(`calc(`add((`pxFloat(1.), `pxFloat(2.)))));
  CssJs.width(`calc(`mult((`pxFloat(5.), `num(2.)))));
  CssJs.width(`calc(`mult((`pxFloat(5.), `num(2.)))));
  CssJs.width(`calc(`sub((`pxFloat(5.), `pxFloat(10.)))));
  CssJs.width(`calc(`sub((`vw(1.), `pxFloat(1.)))));
  CssJs.width(`percent(100.));
  CssJs.padding(`rem(5.));
  CssJs.padding(`ch(5.));
  CssJs.padding(`vw(5.));
  CssJs.padding(`vh(5.));
  CssJs.padding(`vmin(5.));
  CssJs.padding(`vmax(5.));
