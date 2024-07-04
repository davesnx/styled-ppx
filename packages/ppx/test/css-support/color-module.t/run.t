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
  CssJs.color(`rgba((0, 0, 0, `num(0.5))));
  CssJs.color(`hex({js|F06|js}));
  CssJs.color(`hex({js|FF0066|js}));
  CssJs.unsafe({js|color|js}, {js|hsl(0,0%,0%)|js});
  CssJs.unsafe({js|color|js}, {js|hsl(0,0%,0%,.5)|js});
  CssJs.color(`transparent);
  CssJs.color(`currentColor);
  CssJs.backgroundColor(`rgba((0, 0, 0, `num(0.5))));
  CssJs.backgroundColor(`hex({js|F06|js}));
  CssJs.backgroundColor(`hex({js|FF0066|js}));
  CssJs.unsafe({js|backgroundColor|js}, {js|hsl(0,0%,0%)|js});
  CssJs.unsafe({js|backgroundColor|js}, {js|hsl(0,0%,0%,.5)|js});
  CssJs.backgroundColor(`transparent);
  CssJs.backgroundColor(`currentColor);
  CssJs.borderColor(`rgba((0, 0, 0, `num(0.5))));
  CssJs.borderColor(`hex({js|F06|js}));
  CssJs.borderColor(`hex({js|FF0066|js}));
  CssJs.unsafe({js|borderColor|js}, {js|hsl(0,0%,0%)|js});
  CssJs.unsafe({js|borderColor|js}, {js|hsl(0,0%,0%,.5)|js});
  CssJs.borderColor(`transparent);
  CssJs.borderColor(`currentColor);
  CssJs.textDecorationColor(`rgba((0, 0, 0, `num(0.5))));
  CssJs.textDecorationColor(`hex({js|F06|js}));
  CssJs.textDecorationColor(`hex({js|FF0066|js}));
  CssJs.unsafe({js|textDecorationColor|js}, {js|hsl(0,0%,0%)|js});
  CssJs.unsafe({js|textDecorationColor|js}, {js|hsl(0,0%,0%,.5)|js});
  CssJs.textDecorationColor(`transparent);
  CssJs.textDecorationColor(`currentColor);
  CssJs.unsafe({js|columnRuleColor|js}, {js|rgba(0,0,0,.5)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|#F06|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|#FF0066|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|hsl(0,0%,0%)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|hsl(0,0%,0%,.5)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|transparent|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|currentColor|js});
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
  CssJs.color(`hex({js|000F|js}));
  CssJs.color(`hex({js|000000FF|js}));
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
  CssJs.backgroundColor(`hex({js|000F|js}));
  CssJs.backgroundColor(`hex({js|000000FF|js}));
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
  CssJs.borderColor(`hex({js|000F|js}));
  CssJs.borderColor(`hex({js|000000FF|js}));
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
  CssJs.textDecorationColor(`hex({js|000F|js}));
  CssJs.textDecorationColor(`hex({js|000000FF|js}));
  CssJs.textDecorationColor(CssJs.rebeccapurple);
  CssJs.unsafe({js|columnRuleColor|js}, {js|rgb(0% 20% 70%)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|rgb(0 64 185)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|hsl(0 0% 0%)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|rgba(0% 20% 70% / 50%)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|rgba(0% 20% 70% / .5)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|rgba(0 64 185 / 50%)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|rgba(0 64 185 / .5)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|hsla(0 0% 0% /.5)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|rgb(0% 20% 70% / 50%)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|rgb(0% 20% 70% / .5)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|rgb(0 64 185 / 50%)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|rgb(0 64 185 / .5)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|hsl(0 0% 0% / .5)|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|#000F|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|#000000FF|js});
  CssJs.unsafe({js|columnRuleColor|js}, {js|rebeccapurple|js});
