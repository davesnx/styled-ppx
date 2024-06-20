This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.css_native styled-ppx.emotion_native)
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
  CssJs.unsafe({|scrollBehavior|}, {|smooth|});
  CssJs.unsafe({|overflowAnchor|}, {|none|});
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
  CssJs.unsafe({|MozAppearance|}, {|textfield|});
  CssJs.unsafe({|WebkitAppearance|}, {|none|});
  CssJs.unsafe({|WebkitBoxOrient|}, {|vertical|});
  module Color = {
    let text = CssJs.hex("444");
  };
  let colorTextString = Color.text |> CssJs.Color.toString;
  CssJs.unsafe({|WebkitBoxShadow|}, {|inset 0 0 0 1000px $(Color.background)|});
  CssJs.unsafe({|WebkitLineClamp|}, {|2|});
  CssJs.unsafe({|WebkitOverflowScrolling|}, {|touch|});
  CssJs.unsafe({|WebkitTapHighlightColor|}, {|transparent|});
  CssJs.unsafe({|WebkitTextFillColor|}, colorTextString);
  CssJs.animation(
    ~duration=?None,
    ~delay=?None,
    ~direction=?None,
    ~timingFunction=?None,
    ~fillMode=?Some(`none),
    ~playState=?None,
    ~iterationCount=?None,
    {|none|},
  );
  CssJs.unsafe({|appearance|}, {|none|});
  CssJs.unsafe({|aspectRatio|}, {|21 / 8|});
  let c = CssJs.hex("e15a46");
  (CssJs.backgroundColor(c): CssJs.rule);
  CssJs.unsafe("border", "none");
  CssJs.unsafe({|bottom|}, {|unset|});
  CssJs.boxShadow(`none);
  CssJs.unsafe({|breakInside|}, {|avoid|});
  CssJs.unsafe({|caretColor|}, {|#e15a46|});
  CssJs.unsafe({|color|}, {|inherit|});
  CssJs.color(`var({|--color-link|}));
  CssJs.columnWidth(`pxFloat(125.));
  CssJs.columnWidth(`auto);
  CssJs.display(`webkitBox);
  CssJs.display(`contents);
  CssJs.display(`table);
  (CssJs.SVG.fill(c): CssJs.rule);
  CssJs.SVG.fill(`currentColor);
  CssJs.gap(`pxFloat(4.));
  CssJs.unsafe({|grid-column|}, {|unset|});
  CssJs.unsafe({|grid-row|}, {|unset|});
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
  CssJs.unsafe({|height|}, {|fit-content|});
  CssJs.justifyItems(`start);
  CssJs.unsafe({|justify-self|}, {|unset|});
  CssJs.unsafe({|left|}, {|unset|});
  let maskedImageUrl = `url("https://www.example.com/eye-uncrossed.svg");
  (CssJs.maskImage(maskedImageUrl): CssJs.rule);
  CssJs.unsafe({|maskPosition|}, {|center center|});
  CssJs.unsafe({|maskRepeat|}, {|no-repeat|});
  CssJs.maxWidth(`maxContent);
  CssJs.unsafe("outline", "none");
  CssJs.unsafe({|overflowAnchor|}, {|none|});
  CssJs.unsafe({|position|}, {|unset|});
  CssJs.unsafe({|resize|}, {|none|});
  CssJs.right(`calc(`sub((`percent(50.), `pxFloat(4.)))));
  CssJs.unsafe({|scrollBehavior|}, {|smooth|});
  CssJs.SVG.strokeOpacity(`num(0.));
  (CssJs.SVG.stroke(Color.text): CssJs.rule);
  CssJs.top(`calc(`sub((`percent(50.), `pxFloat(1.)))));
  CssJs.unsafe({|top|}, {|unset|});
  CssJs.unsafe({|touchAction|}, {|none|});
  CssJs.unsafe({|touchAction|}, {|pan-x pan-y|});
  CssJs.transformOrigin2(`center, `left);
  CssJs.transformOrigin2(`center, `right);
  CssJs.transformOrigin(`pxFloat(2.));
  CssJs.transformOrigin(`bottom);
  CssJs.transformOrigin2(`cm(3.), `pxFloat(2.));
  CssJs.transformOrigin2(`pxFloat(2.), `left);
  CssJs.transform(`none);
  CssJs.unsafe({|width|}, {|fit-content|});
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
          (Some(`hex({|F80|})), Some(`percent(0.))),
          (Some(`rgba((255, 255, 255, `num(0.8)))), Some(`percent(50.))),
          (Some(`hex({|2A97FF|})), Some(`percent(100.))),
        |]: Css_AtomicTypes.Gradient.color_stop_list,
      )),
    ),
  |]);

  $ dune build
