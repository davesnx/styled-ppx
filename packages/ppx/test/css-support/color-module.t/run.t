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
  CSS.color(`rgba((0, 0, 0, `num(0.5))));
  CSS.color(`hex({js|F06|js}));
  CSS.color(`hex({js|FF0066|js}));
  CSS.unsafe({js|color|js}, {js|hsl(0,0%,0%)|js});
  CSS.unsafe({js|color|js}, {js|hsl(0,0%,0%,.5)|js});
  CSS.color(`transparent);
  CSS.color(`currentColor);
  CSS.backgroundColor(`rgba((0, 0, 0, `num(0.5))));
  CSS.backgroundColor(`hex({js|F06|js}));
  CSS.backgroundColor(`hex({js|FF0066|js}));
  CSS.unsafe({js|backgroundColor|js}, {js|hsl(0,0%,0%)|js});
  CSS.unsafe({js|backgroundColor|js}, {js|hsl(0,0%,0%,.5)|js});
  CSS.backgroundColor(`transparent);
  CSS.backgroundColor(`currentColor);
  CSS.borderColor(`rgba((0, 0, 0, `num(0.5))));
  CSS.borderColor(`hex({js|F06|js}));
  CSS.borderColor(`hex({js|FF0066|js}));
  CSS.unsafe({js|borderColor|js}, {js|hsl(0,0%,0%)|js});
  CSS.unsafe({js|borderColor|js}, {js|hsl(0,0%,0%,.5)|js});
  CSS.borderColor(`transparent);
  CSS.borderColor(`currentColor);
  CSS.textDecorationColor(`rgba((0, 0, 0, `num(0.5))));
  CSS.textDecorationColor(`hex({js|F06|js}));
  CSS.textDecorationColor(`hex({js|FF0066|js}));
  CSS.unsafe({js|textDecorationColor|js}, {js|hsl(0,0%,0%)|js});
  CSS.unsafe({js|textDecorationColor|js}, {js|hsl(0,0%,0%,.5)|js});
  CSS.textDecorationColor(`transparent);
  CSS.textDecorationColor(`currentColor);
  CSS.unsafe({js|columnRuleColor|js}, {js|rgba(0,0,0,.5)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|#F06|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|#FF0066|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|hsl(0,0%,0%)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|hsl(0,0%,0%,.5)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|transparent|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|currentColor|js});
  CSS.color(`rgb((0, 51, 178)));
  CSS.color(`rgb((0, 64, 185)));
  CSS.color(`hsl((`deg(0.), `percent(0.), `percent(0.))));
  CSS.color(`rgba((0, 51, 178, `percent(0.5))));
  CSS.color(`rgba((0, 51, 178, `num(0.5))));
  CSS.color(`rgba((0, 64, 185, `percent(0.5))));
  CSS.color(`rgba((0, 64, 185, `num(0.5))));
  CSS.color(`hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))));
  CSS.color(`rgba((0, 51, 178, `percent(0.5))));
  CSS.color(`rgba((0, 51, 178, `num(0.5))));
  CSS.color(`rgba((0, 64, 185, `percent(0.5))));
  CSS.color(`rgba((0, 64, 185, `num(0.5))));
  CSS.color(`hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))));
  CSS.color(`hex({js|000F|js}));
  CSS.color(`hex({js|000000FF|js}));
  CSS.color(CSS.rebeccapurple);
  CSS.backgroundColor(`rgb((0, 51, 178)));
  CSS.backgroundColor(`rgb((0, 64, 185)));
  CSS.backgroundColor(`hsl((`deg(0.), `percent(0.), `percent(0.))));
  CSS.backgroundColor(`rgba((0, 51, 178, `percent(0.5))));
  CSS.backgroundColor(`rgba((0, 51, 178, `num(0.5))));
  CSS.backgroundColor(`rgba((0, 64, 185, `percent(0.5))));
  CSS.backgroundColor(`rgba((0, 64, 185, `num(0.5))));
  CSS.backgroundColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  );
  CSS.backgroundColor(`rgba((0, 51, 178, `percent(0.5))));
  CSS.backgroundColor(`rgba((0, 51, 178, `num(0.5))));
  CSS.backgroundColor(`rgba((0, 64, 185, `percent(0.5))));
  CSS.backgroundColor(`rgba((0, 64, 185, `num(0.5))));
  CSS.backgroundColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  );
  CSS.backgroundColor(`hex({js|000F|js}));
  CSS.backgroundColor(`hex({js|000000FF|js}));
  CSS.backgroundColor(CSS.rebeccapurple);
  CSS.borderColor(`rgb((0, 51, 178)));
  CSS.borderColor(`rgb((0, 64, 185)));
  CSS.borderColor(`hsl((`deg(0.), `percent(0.), `percent(0.))));
  CSS.borderColor(`rgba((0, 51, 178, `percent(0.5))));
  CSS.borderColor(`rgba((0, 51, 178, `num(0.5))));
  CSS.borderColor(`rgba((0, 64, 185, `percent(0.5))));
  CSS.borderColor(`rgba((0, 64, 185, `num(0.5))));
  CSS.borderColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  );
  CSS.borderColor(`rgba((0, 51, 178, `percent(0.5))));
  CSS.borderColor(`rgba((0, 51, 178, `num(0.5))));
  CSS.borderColor(`rgba((0, 64, 185, `percent(0.5))));
  CSS.borderColor(`rgba((0, 64, 185, `num(0.5))));
  CSS.borderColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  );
  CSS.borderColor(`hex({js|000F|js}));
  CSS.borderColor(`hex({js|000000FF|js}));
  CSS.borderColor(CSS.rebeccapurple);
  CSS.textDecorationColor(`rgb((0, 51, 178)));
  CSS.textDecorationColor(`rgb((0, 64, 185)));
  CSS.textDecorationColor(`hsl((`deg(0.), `percent(0.), `percent(0.))));
  CSS.textDecorationColor(`rgba((0, 51, 178, `percent(0.5))));
  CSS.textDecorationColor(`rgba((0, 51, 178, `num(0.5))));
  CSS.textDecorationColor(`rgba((0, 64, 185, `percent(0.5))));
  CSS.textDecorationColor(`rgba((0, 64, 185, `num(0.5))));
  CSS.textDecorationColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  );
  CSS.textDecorationColor(`rgba((0, 51, 178, `percent(0.5))));
  CSS.textDecorationColor(`rgba((0, 51, 178, `num(0.5))));
  CSS.textDecorationColor(`rgba((0, 64, 185, `percent(0.5))));
  CSS.textDecorationColor(`rgba((0, 64, 185, `num(0.5))));
  CSS.textDecorationColor(
    `hsla((`deg(0.), `percent(0.), `percent(0.), `num(0.5))),
  );
  CSS.textDecorationColor(`hex({js|000F|js}));
  CSS.textDecorationColor(`hex({js|000000FF|js}));
  CSS.textDecorationColor(CSS.rebeccapurple);
  CSS.unsafe({js|columnRuleColor|js}, {js|rgb(0% 20% 70%)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|rgb(0 64 185)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|hsl(0 0% 0%)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|rgba(0% 20% 70% / 50%)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|rgba(0% 20% 70% / .5)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|rgba(0 64 185 / 50%)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|rgba(0 64 185 / .5)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|hsla(0 0% 0% /.5)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|rgb(0% 20% 70% / 50%)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|rgb(0% 20% 70% / .5)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|rgb(0 64 185 / 50%)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|rgb(0 64 185 / .5)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|hsl(0 0% 0% / .5)|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|#000F|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|#000000FF|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|rebeccapurple|js});
