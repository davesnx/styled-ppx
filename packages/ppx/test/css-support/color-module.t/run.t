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
  
  CSS.color(
    `colorMix((`srgb, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.color(
    `colorMix((
      `srgb,
      (`rgba((255, 0, 0, `num(0.2))), Some(`percent(65.))),
      (CSS.olive, None),
    )),
  );
  CSS.color(
    `colorMix((
      `srgb,
      (`currentColor, None),
      (`rgba((0, 0, 0, `num(0.5))), Some(`percent(65.))),
    )),
  );
  CSS.color(
    `colorMix((
      `srgb,
      (`currentColor, Some(`percent(10.))),
      (`rgba((0, 0, 0, `num(0.5))), Some(`percent(65.))),
    )),
  );
  CSS.color(
    `colorMix((`lch, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.color(
    `colorMix((`hsl, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.color(
    `colorMix((`hwb, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.color(
    `colorMix((`xyz, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.color(
    `colorMix((`lab, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.color(
    `colorMix((
      `polar_with_hue((`lch, `longer)),
      (`hsl((`deg(200.), `percent(50.), `percent(80.))), None),
      (CSS.coral, None),
    )),
  );
  
  CSS.backgroundColor(
    `colorMix((`srgb, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.backgroundColor(
    `colorMix((
      `srgb,
      (`rgba((255, 0, 0, `num(0.2))), Some(`percent(65.))),
      (CSS.olive, None),
    )),
  );
  CSS.backgroundColor(
    `colorMix((
      `srgb,
      (`currentColor, None),
      (`rgba((0, 0, 0, `num(0.5))), Some(`percent(65.))),
    )),
  );
  CSS.backgroundColor(
    `colorMix((
      `srgb,
      (`currentColor, Some(`percent(10.))),
      (`rgba((0, 0, 0, `num(0.5))), Some(`percent(65.))),
    )),
  );
  CSS.backgroundColor(
    `colorMix((`lch, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.backgroundColor(
    `colorMix((`hsl, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.backgroundColor(
    `colorMix((`hwb, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.backgroundColor(
    `colorMix((`xyz, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.backgroundColor(
    `colorMix((`lab, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  
  CSS.borderColor(
    `colorMix((`srgb, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.borderColor(
    `colorMix((
      `srgb,
      (`rgba((255, 0, 0, `num(0.2))), Some(`percent(65.))),
      (CSS.olive, None),
    )),
  );
  CSS.borderColor(
    `colorMix((
      `srgb,
      (`currentColor, None),
      (`rgba((0, 0, 0, `num(0.5))), Some(`percent(65.))),
    )),
  );
  CSS.borderColor(
    `colorMix((
      `srgb,
      (`currentColor, Some(`percent(10.))),
      (`rgba((0, 0, 0, `num(0.5))), Some(`percent(65.))),
    )),
  );
  CSS.borderColor(
    `colorMix((`lch, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.borderColor(
    `colorMix((`hsl, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.borderColor(
    `colorMix((`hwb, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.borderColor(
    `colorMix((`xyz, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.borderColor(
    `colorMix((`lab, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  
  CSS.textDecorationColor(
    `colorMix((`srgb, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.textDecorationColor(
    `colorMix((
      `srgb,
      (`rgba((255, 0, 0, `num(0.2))), Some(`percent(65.))),
      (CSS.olive, None),
    )),
  );
  CSS.textDecorationColor(
    `colorMix((
      `srgb,
      (`currentColor, None),
      (`rgba((0, 0, 0, `num(0.5))), Some(`percent(65.))),
    )),
  );
  CSS.textDecorationColor(
    `colorMix((
      `srgb,
      (`currentColor, Some(`percent(10.))),
      (`rgba((0, 0, 0, `num(0.5))), Some(`percent(65.))),
    )),
  );
  CSS.textDecorationColor(
    `colorMix((`lch, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.textDecorationColor(
    `colorMix((`hsl, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.textDecorationColor(
    `colorMix((`hwb, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.textDecorationColor(
    `colorMix((`xyz, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  CSS.textDecorationColor(
    `colorMix((`lab, (CSS.teal, Some(`percent(65.))), (CSS.olive, None))),
  );
  
  CSS.unsafe(
    {js|columnRuleColor|js},
    {js|color-mix(in srgb, teal 65%, olive)|js},
  );
  CSS.unsafe(
    {js|columnRuleColor|js},
    {js|color-mix(in srgb, rgb(255, 0, 0, .2) 65%, olive)|js},
  );
  CSS.unsafe(
    {js|columnRuleColor|js},
    {js|color-mix(in srgb, currentColor, rgba(0, 0, 0, .5) 65%)|js},
  );
  CSS.unsafe(
    {js|columnRuleColor|js},
    {js|color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, .5) 65%)|js},
  );
  CSS.unsafe(
    {js|columnRuleColor|js},
    {js|color-mix(in lch, teal 65%, olive)|js},
  );
  CSS.unsafe(
    {js|columnRuleColor|js},
    {js|color-mix(in hsl, teal 65%, olive)|js},
  );
  CSS.unsafe(
    {js|columnRuleColor|js},
    {js|color-mix(in hwb, teal 65%, olive)|js},
  );
  CSS.unsafe(
    {js|columnRuleColor|js},
    {js|color-mix(in xyz, teal 65%, olive)|js},
  );
  CSS.unsafe(
    {js|columnRuleColor|js},
    {js|color-mix(in lab, teal 65%, olive)|js},
  );
  
  CSS.color(`rgba((0, 0, 0, `calc(`num(1.)))));
  CSS.color(`rgba((0, 0, 0, `calc(`sub((`num(10.), `num(1.)))))));
