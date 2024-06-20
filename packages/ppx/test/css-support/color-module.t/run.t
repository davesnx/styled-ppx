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
  CssJs.color(`rgba((0, 0, 0, `num(0.5))));
  CssJs.color(`hex({|F06|}));
  CssJs.color(`hex({|FF0066|}));
  CssJs.unsafe({|color|}, {|hsl(0,0%,0%)|});
  CssJs.unsafe({|color|}, {|hsl(0,0%,0%,.5)|});
  CssJs.color(`transparent);
  CssJs.color(`currentColor);
  CssJs.backgroundColor(`rgba((0, 0, 0, `num(0.5))));
  CssJs.backgroundColor(`hex({|F06|}));
  CssJs.backgroundColor(`hex({|FF0066|}));
  CssJs.unsafe({|backgroundColor|}, {|hsl(0,0%,0%)|});
  CssJs.unsafe({|backgroundColor|}, {|hsl(0,0%,0%,.5)|});
  CssJs.backgroundColor(`transparent);
  CssJs.backgroundColor(`currentColor);
  CssJs.borderColor(`rgba((0, 0, 0, `num(0.5))));
  CssJs.borderColor(`hex({|F06|}));
  CssJs.borderColor(`hex({|FF0066|}));
  CssJs.unsafe({|borderColor|}, {|hsl(0,0%,0%)|});
  CssJs.unsafe({|borderColor|}, {|hsl(0,0%,0%,.5)|});
  CssJs.borderColor(`transparent);
  CssJs.borderColor(`currentColor);
  CssJs.textDecorationColor(`rgba((0, 0, 0, `num(0.5))));
  CssJs.textDecorationColor(`hex({|F06|}));
  CssJs.textDecorationColor(`hex({|FF0066|}));
  CssJs.unsafe({|textDecorationColor|}, {|hsl(0,0%,0%)|});
  CssJs.unsafe({|textDecorationColor|}, {|hsl(0,0%,0%,.5)|});
  CssJs.textDecorationColor(`transparent);
  CssJs.textDecorationColor(`currentColor);
  CssJs.unsafe({|columnRuleColor|}, {|rgba(0,0,0,.5)|});
  CssJs.unsafe({|columnRuleColor|}, {|#F06|});
  CssJs.unsafe({|columnRuleColor|}, {|#FF0066|});
  CssJs.unsafe({|columnRuleColor|}, {|hsl(0,0%,0%)|});
  CssJs.unsafe({|columnRuleColor|}, {|hsl(0,0%,0%,.5)|});
  CssJs.unsafe({|columnRuleColor|}, {|transparent|});
  CssJs.unsafe({|columnRuleColor|}, {|currentColor|});
  CssJs.color(`rgb((0, 51, 178)));
  CssJs.color(`rgb((0, 64, 185)));
  CssJs.color(`hsl((`deg(0.), `percent(0.), `percent(0.))));
  CssJs.color(`rgba((0, 51, 178, `percent(0.5))));
  CssJs.color(`rgba((0, 51, 178, `num(0.5))));
  CssJs.color(`rgba((0, 64, 185, `percent(0.5))));
  CssJs.color(`rgba((0, 64, 185, `num(0.5))));
  CssJs.color(`hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))));
  CssJs.color(`rgba((0, 51, 178, `percent(0.5))));
  CssJs.color(`rgba((0, 51, 178, `num(0.5))));
  CssJs.color(`rgba((0, 64, 185, `percent(0.5))));
  CssJs.color(`rgba((0, 64, 185, `num(0.5))));
  CssJs.color(`hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))));
  CssJs.color(`hex({|000F|}));
  CssJs.color(`hex({|000000FF|}));
  CssJs.color(CssJs.rebeccapurple);
  CssJs.backgroundColor(`rgb((0, 51, 178)));
  CssJs.backgroundColor(`rgb((0, 64, 185)));
  CssJs.backgroundColor(`hsl((`deg(0.), `percent(0.), `percent(0.))));
  CssJs.backgroundColor(`rgba((0, 51, 178, `percent(0.5))));
  CssJs.backgroundColor(`rgba((0, 51, 178, `num(0.5))));
  CssJs.backgroundColor(`rgba((0, 64, 185, `percent(0.5))));
  CssJs.backgroundColor(`rgba((0, 64, 185, `num(0.5))));
  CssJs.backgroundColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  );
  CssJs.backgroundColor(`rgba((0, 51, 178, `percent(0.5))));
  CssJs.backgroundColor(`rgba((0, 51, 178, `num(0.5))));
  CssJs.backgroundColor(`rgba((0, 64, 185, `percent(0.5))));
  CssJs.backgroundColor(`rgba((0, 64, 185, `num(0.5))));
  CssJs.backgroundColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  );
  CssJs.backgroundColor(`hex({|000F|}));
  CssJs.backgroundColor(`hex({|000000FF|}));
  CssJs.backgroundColor(CssJs.rebeccapurple);
  CssJs.borderColor(`rgb((0, 51, 178)));
  CssJs.borderColor(`rgb((0, 64, 185)));
  CssJs.borderColor(`hsl((`deg(0.), `percent(0.), `percent(0.))));
  CssJs.borderColor(`rgba((0, 51, 178, `percent(0.5))));
  CssJs.borderColor(`rgba((0, 51, 178, `num(0.5))));
  CssJs.borderColor(`rgba((0, 64, 185, `percent(0.5))));
  CssJs.borderColor(`rgba((0, 64, 185, `num(0.5))));
  CssJs.borderColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  );
  CssJs.borderColor(`rgba((0, 51, 178, `percent(0.5))));
  CssJs.borderColor(`rgba((0, 51, 178, `num(0.5))));
  CssJs.borderColor(`rgba((0, 64, 185, `percent(0.5))));
  CssJs.borderColor(`rgba((0, 64, 185, `num(0.5))));
  CssJs.borderColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  );
  CssJs.borderColor(`hex({|000F|}));
  CssJs.borderColor(`hex({|000000FF|}));
  CssJs.borderColor(CssJs.rebeccapurple);
  CssJs.textDecorationColor(`rgb((0, 51, 178)));
  CssJs.textDecorationColor(`rgb((0, 64, 185)));
  CssJs.textDecorationColor(`hsl((`deg(0.), `percent(0.), `percent(0.))));
  CssJs.textDecorationColor(`rgba((0, 51, 178, `percent(0.5))));
  CssJs.textDecorationColor(`rgba((0, 51, 178, `num(0.5))));
  CssJs.textDecorationColor(`rgba((0, 64, 185, `percent(0.5))));
  CssJs.textDecorationColor(`rgba((0, 64, 185, `num(0.5))));
  CssJs.textDecorationColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  );
  CssJs.textDecorationColor(`rgba((0, 51, 178, `percent(0.5))));
  CssJs.textDecorationColor(`rgba((0, 51, 178, `num(0.5))));
  CssJs.textDecorationColor(`rgba((0, 64, 185, `percent(0.5))));
  CssJs.textDecorationColor(`rgba((0, 64, 185, `num(0.5))));
  CssJs.textDecorationColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  );
  CssJs.textDecorationColor(`hex({|000F|}));
  CssJs.textDecorationColor(`hex({|000000FF|}));
  CssJs.textDecorationColor(CssJs.rebeccapurple);
  CssJs.unsafe({|columnRuleColor|}, {|rgb(0% 20% 70%)|});
  CssJs.unsafe({|columnRuleColor|}, {|rgb(0 64 185)|});
  CssJs.unsafe({|columnRuleColor|}, {|hsl(0 0% 0%)|});
  CssJs.unsafe({|columnRuleColor|}, {|rgba(0% 20% 70% / 50%)|});
  CssJs.unsafe({|columnRuleColor|}, {|rgba(0% 20% 70% / .5)|});
  CssJs.unsafe({|columnRuleColor|}, {|rgba(0 64 185 / 50%)|});
  CssJs.unsafe({|columnRuleColor|}, {|rgba(0 64 185 / .5)|});
  CssJs.unsafe({|columnRuleColor|}, {|hsla(0 0% 0% /.5)|});
  CssJs.unsafe({|columnRuleColor|}, {|rgb(0% 20% 70% / 50%)|});
  CssJs.unsafe({|columnRuleColor|}, {|rgb(0% 20% 70% / .5)|});
  CssJs.unsafe({|columnRuleColor|}, {|rgb(0 64 185 / 50%)|});
  CssJs.unsafe({|columnRuleColor|}, {|rgb(0 64 185 / .5)|});
  CssJs.unsafe({|columnRuleColor|}, {|hsl(0 0% 0% / .5)|});
  CssJs.unsafe({|columnRuleColor|}, {|#000F|});
  CssJs.unsafe({|columnRuleColor|}, {|#000000FF|});
  CssJs.unsafe({|columnRuleColor|}, {|rebeccapurple|});
