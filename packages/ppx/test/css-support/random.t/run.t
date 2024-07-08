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
  CssJs.unsafe({js|scrollBehavior|js}, {js|smooth|js});
  CssJs.unsafe({js|overflowAnchor|js}, {js|none|js});
  CssJs.width(`calc(`add((`percent(50.), `pxFloat(4.)))));
  CssJs.width(`calc(`sub((`pxFloat(20.), `pxFloat(10.)))));
  CssJs.width(
    `calc(`sub((`vh(100.), `calc(`add((`rem(2.), `pxFloat(120.))))))),
  );
  CssJs.width(
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
  CssJs.unsafe({js|MozAppearance|js}, {js|textfield|js});
  CssJs.unsafe({js|WebkitAppearance|js}, {js|none|js});
  CssJs.unsafe({js|WebkitBoxOrient|js}, {js|vertical|js});
  module Color = {
    let text = CssJs.hex("444");
  };
  let colorTextString = Color.text |> CssJs.Types.Color.toString;
  CssJs.unsafe(
    {js|WebkitBoxShadow|js},
    {js|inset 0 0 0 1000px $(Color.background)|js},
  );
  CssJs.unsafe({js|WebkitLineClamp|js}, {js|2|js});
  CssJs.unsafe({js|WebkitOverflowScrolling|js}, {js|touch|js});
  CssJs.unsafe({js|WebkitTapHighlightColor|js}, {js|transparent|js});
  CssJs.unsafe({js|WebkitTextFillColor|js}, colorTextString);
  CssJs.animation(
    ~duration=?None,
    ~delay=?None,
    ~direction=?None,
    ~timingFunction=?None,
    ~fillMode=?Some(`none),
    ~playState=?None,
    ~iterationCount=?None,
    {js|none|js},
  );
  CssJs.unsafe({js|appearance|js}, {js|none|js});
  CssJs.aspectRatio(`ratio((21, 8)));
  let c = CssJs.hex("e15a46");
  (CssJs.backgroundColor(c): CssJs.rule);
  CssJs.unsafe({js|border|js}, {js|none|js});
  CssJs.unsafe({js|bottom|js}, {js|unset|js});
  CssJs.boxShadow(`none);
  CssJs.unsafe({js|breakInside|js}, {js|avoid|js});
  CssJs.unsafe({js|caretColor|js}, {js|#e15a46|js});
  CssJs.unsafe({js|color|js}, {js|inherit|js});
  CssJs.color(`var({js|--color-link|js}));
  CssJs.columnWidth(`pxFloat(125.));
  CssJs.columnWidth(`auto);
  CssJs.display(`webkitBox);
  CssJs.display(`contents);
  CssJs.display(`table);
  (CssJs.SVG.fill(c): CssJs.rule);
  CssJs.SVG.fill(`currentColor);
  CssJs.gap(`pxFloat(4.));
  CssJs.unsafe({js|grid-column|js}, {js|unset|js});
  CssJs.unsafe({js|grid-row|js}, {js|unset|js});
  CssJs.gridTemplateColumns([|`maxContent, `maxContent|]);
  CssJs.gridTemplateColumns([|
    `minmax((`pxFloat(10.), `auto)),
    `fitContent(`pxFloat(20.)),
    `fitContent(`pxFloat(20.)),
  |]);
  CssJs.gridTemplateColumns([|
    `minmax((`pxFloat(51.), `auto)),
    `fitContent(`pxFloat(20.)),
    `fitContent(`pxFloat(20.)),
  |]);
  CssJs.gridTemplateColumns([|`repeat((`num(2), [|`auto|]))|]);
  CssJs.gridTemplateColumns([|`repeat((`num(3), [|`auto|]))|]);
  CssJs.unsafe({js|height|js}, {js|fit-content|js});
  CssJs.justifyItems(`start);
  CssJs.unsafe({js|justify-self|js}, {js|unset|js});
  CssJs.unsafe({js|left|js}, {js|unset|js});
  let maskedImageUrl = `url("https://www.example.com/eye-uncrossed.svg");
  (CssJs.maskImage(maskedImageUrl): CssJs.rule);
  CssJs.unsafe({js|maskPosition|js}, {js|center center|js});
  CssJs.unsafe({js|maskRepeat|js}, {js|no-repeat|js});
  CssJs.maxWidth(`maxContent);
  CssJs.unsafe({js|outline|js}, {js|none|js});
  CssJs.unsafe({js|overflowAnchor|js}, {js|none|js});
  CssJs.unsafe({js|position|js}, {js|unset|js});
  CssJs.unsafe({js|resize|js}, {js|none|js});
  CssJs.right(`calc(`sub((`percent(50.), `pxFloat(4.)))));
  CssJs.unsafe({js|scrollBehavior|js}, {js|smooth|js});
  CssJs.SVG.strokeOpacity(`num(0.));
  (CssJs.SVG.stroke(Color.text): CssJs.rule);
  CssJs.top(`calc(`sub((`percent(50.), `pxFloat(1.)))));
  CssJs.unsafe({js|top|js}, {js|unset|js});
  CssJs.unsafe({js|touchAction|js}, {js|none|js});
  CssJs.unsafe({js|touchAction|js}, {js|pan-x pan-y|js});
  CssJs.transformOrigin2(`center, `left);
  CssJs.transformOrigin2(`center, `right);
  CssJs.transformOrigin(`pxFloat(2.));
  CssJs.transformOrigin(`bottom);
  CssJs.transformOrigin2(`cm(3.), `pxFloat(2.));
  CssJs.transformOrigin2(`pxFloat(2.), `left);
  CssJs.transform(`none);
  CssJs.unsafe({js|width|js}, {js|fit-content|js});
  CssJs.width(`maxContent);
  CssJs.transitionDelay(`ms(240));
  CssJs.animationDuration(`ms(150));
  CssJs.borderWidth(`thin);
  CssJs.outlineWidth(`medium);
  CssJs.outline(`medium, `solid, CssJs.red);
  let lola = `hidden;
  CssJs.overflow(lola);
  CssJs.overflow(`hidden);
  (CssJs.overflowY(lola): CssJs.rule);
  CssJs.overflowX(`hidden);
  let value = `clip;
  CssJs.overflowBlock(`hidden);
  (CssJs.overflowBlock(value): CssJs.rule);
  (CssJs.overflowInline(value): CssJs.rule);
  CssJs.style([|
    CssJs.backgroundImage(
      `linearGradient((
        Some(`deg(84.)),
        [|
          (Some(`hex({js|F80|js})), Some(`percent(0.))),
          (Some(`rgba((255, 255, 255, `num(0.8)))), Some(`percent(50.))),
          (Some(`hex({js|2A97FF|js})), Some(`percent(100.))),
        |]: CssJs.Types.Gradient.color_stop_list,
      )),
    ),
  |]);
  CssJs.style([|CssJs.aspectRatio(`ratio((16, 9)))|]);

  $ dune build
