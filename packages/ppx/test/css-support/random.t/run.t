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
  CSS.unsafe({js|scrollBehavior|js}, {js|smooth|js});
  CSS.unsafe({js|overflowAnchor|js}, {js|none|js});
  CSS.width(`calc(`add((`percent(50.), `pxFloat(4.)))));
  CSS.width(`calc(`sub((`pxFloat(20.), `pxFloat(10.)))));
  CSS.width(
    `calc(`sub((`vh(100.), `calc(`add((`rem(2.), `pxFloat(120.))))))),
  );
  CSS.width(
    `calc(
      `sub((
        `vh(100.),
        `calc(
          `add((
            `rem(2.),
            `calc(
              `add((
                `rem(2.),
                `calc(
                  `add((
                    `rem(2.),
                    `calc(`add((`rem(2.), `pxFloat(120.)))),
                  )),
                ),
              )),
            ),
          )),
        ),
      )),
    ),
  );
  CSS.unsafe({js|MozAppearance|js}, {js|textfield|js});
  CSS.unsafe({js|WebkitAppearance|js}, {js|none|js});
  CSS.unsafe({js|WebkitBoxOrient|js}, {js|vertical|js});
  module Color = {
    let text = CSS.hex("444");
  };
  let colorTextString = Color.text |> CSS.Types.Color.toString;
  CSS.unsafe(
    {js|WebkitBoxShadow|js},
    {js|inset 0 0 0 1000px $(Color.background)|js},
  );
  CSS.unsafe({js|WebkitLineClamp|js}, {js|2|js});
  CSS.unsafe({js|WebkitOverflowScrolling|js}, {js|touch|js});
  CSS.unsafe({js|WebkitTapHighlightColor|js}, {js|transparent|js});
  CSS.unsafe({js|WebkitTextFillColor|js}, colorTextString);
  CSS.animation(
    ~duration=?None,
    ~delay=?None,
    ~direction=?None,
    ~timingFunction=?None,
    ~fillMode=?Some(`none),
    ~playState=?None,
    ~iterationCount=?None,
    ~name=Css_types.AnimationName.make({js|none|js}),
    (),
  );
  CSS.unsafe({js|appearance|js}, {js|none|js});
  CSS.aspectRatio(`ratio((21, 8)));
  let c = CSS.hex("e15a46");
  (CSS.backgroundColor(c): CSS.rule);
  CSS.unsafe({js|border|js}, {js|none|js});
  CSS.unsafe({js|bottom|js}, {js|unset|js});
  CSS.boxShadow(`none);
  CSS.unsafe({js|breakInside|js}, {js|avoid|js});
  CSS.unsafe({js|caretColor|js}, {js|#e15a46|js});
  CSS.unsafe({js|color|js}, {js|inherit|js});
  CSS.color(`var({js|--color-link|js}));
  CSS.columnWidth(`pxFloat(125.));
  CSS.columnWidth(`auto);
  CSS.display(`webkitBox);
  CSS.display(`contents);
  CSS.display(`table);
  (CSS.SVG.fill(c): CSS.rule);
  CSS.SVG.fill(`currentColor);
  CSS.gap(`pxFloat(4.));
  CSS.unsafe({js|gridColumn|js}, {js|unset|js});
  CSS.unsafe({js|gridRow|js}, {js|unset|js});
  CSS.gridTemplateColumns([|`maxContent, `maxContent|]);
  CSS.gridTemplateColumns([|
    `minmax((`pxFloat(10.), `auto)),
    `fitContent(`pxFloat(20.)),
    `fitContent(`pxFloat(20.)),
  |]);
  CSS.gridTemplateColumns([|
    `minmax((`pxFloat(51.), `auto)),
    `fitContent(`pxFloat(20.)),
    `fitContent(`pxFloat(20.)),
  |]);
  CSS.gridTemplateColumns([|`repeat((`num(2), [|`auto|]))|]);
  CSS.gridTemplateColumns([|`repeat((`num(3), [|`auto|]))|]);
  CSS.unsafe({js|height|js}, {js|fit-content|js});
  CSS.justifyItems(`start);
  CSS.unsafe({js|justifySelf|js}, {js|unset|js});
  CSS.unsafe({js|left|js}, {js|unset|js});
  let maskedImageUrl = `url("https://www.example.com/eye-uncrossed.svg");
  (CSS.maskImage(maskedImageUrl): CSS.rule);
  CSS.unsafe({js|maskPosition|js}, {js|center center|js});
  CSS.unsafe({js|maskRepeat|js}, {js|no-repeat|js});
  CSS.maxWidth(`maxContent);
  CSS.unsafe({js|outline|js}, {js|none|js});
  CSS.unsafe({js|overflowAnchor|js}, {js|none|js});
  CSS.unsafe({js|position|js}, {js|unset|js});
  CSS.unsafe({js|resize|js}, {js|none|js});
  CSS.right(`calc(`sub((`percent(50.), `pxFloat(4.)))));
  CSS.unsafe({js|scrollBehavior|js}, {js|smooth|js});
  CSS.SVG.strokeOpacity(`num(0.));
  (CSS.SVG.stroke(Color.text): CSS.rule);
  CSS.top(`calc(`sub((`percent(50.), `pxFloat(1.)))));
  CSS.unsafe({js|top|js}, {js|unset|js});
  CSS.unsafe({js|touchAction|js}, {js|none|js});
  CSS.unsafe({js|touchAction|js}, {js|pan-x pan-y|js});
  CSS.transformOrigin2(`center, `left);
  CSS.transformOrigin2(`center, `right);
  CSS.transformOrigin(`pxFloat(2.));
  CSS.transformOrigin(`bottom);
  CSS.transformOrigin2(`cm(3.), `pxFloat(2.));
  CSS.transformOrigin2(`pxFloat(2.), `left);
  CSS.transform(`none);
  CSS.unsafe({js|width|js}, {js|fit-content|js});
  CSS.width(`maxContent);
  CSS.transitionDelay(`ms(240));
  CSS.animationDuration(`ms(150));
  CSS.borderWidth(`thin);
  CSS.outlineWidth(`medium);
  CSS.outline(`medium, `solid, CSS.red);
  let lola = `hidden;
  CSS.overflow(lola);
  CSS.overflow(`hidden);
  (CSS.overflowY(lola): CSS.rule);
  CSS.overflowX(`hidden);
  let value = `clip;
  CSS.overflowBlock(`hidden);
  (CSS.overflowBlock(value): CSS.rule);
  (CSS.overflowInline(value): CSS.rule);
  CSS.style([|
    CSS.backgroundImage(
      `linearGradient((
        Some(`deg(84.)),
        [|
          (Some(`hex({js|F80|js})), Some(`percent(0.))),
          (Some(`rgba((255, 255, 255, `num(0.8)))), Some(`percent(50.))),
          (Some(`hex({js|2A97FF|js})), Some(`percent(100.))),
        |]: CSS.Types.Gradient.color_stop_list,
      )),
    ),
  |]);
  CSS.style([|CSS.aspectRatio(`ratio((16, 9)))|]);
  CSS.color(`var({js|--color-link|js}));

  $ dune build
