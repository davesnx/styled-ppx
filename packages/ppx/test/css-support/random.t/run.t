This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat >dune-project <<EOF
  > (lang dune 3.10)
  > EOF

  $ cat >dune <<EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.css_native styled-ppx.emotion_native)
  >  (preprocess (pps styled-ppx.lib)))
  > EOF

  $ dune build
  File "input.re", line 1, characters 7-27:
  Error: Unbound module Color
  [1]

  $ dune_describe_pp _build/default/input.re.pp.ml
  [@@@ocaml.ppx.context
    {
      tool_name = "ppx_driver";
      include_dirs = [];
      load_path = [];
      open_modules = [];
      for_package = None;
      debug = false;
      use_threads = false;
      use_vmthreads = false;
      recursive_types = false;
      principal = false;
      transparent_modules = false;
      unboxed_types = false;
      unsafe_string = false;
      cookies = []
    }]
  ;;CssJs.unsafe {js|scrollBehavior|js} {js|smooth|js}
  ;;CssJs.unsafe {js|overflowAnchor|js} {js|none|js}
  ;;CssJs.width (`calc (`add ((`percent 50.), (`pxFloat 4.))))
  ;;CssJs.width (`calc (`sub ((`pxFloat 20.), (`pxFloat 10.))))
  ;;CssJs.width
      (`calc (`sub ((`vh 100.), (`calc (`add ((`rem 2.), (`pxFloat 120.)))))))
  ;;CssJs.width
      (`calc
         (`sub
            ((`vh 100.),
              (`calc
                 (`add
                    ((`rem 2.),
                      (`calc
                         (`add
                            ((`rem 2.),
                              (`calc
                                 (`add
                                    ((`rem 2.),
                                      (`calc
                                         (`add ((`rem 2.), (`pxFloat 120.))))))))))))))))
  ;;CssJs.unsafe {js|MozAppearance|js} {js|textfield|js}
  ;;CssJs.unsafe {js|WebkitAppearance|js} {js|none|js}
  ;;CssJs.unsafe {js|WebkitBoxOrient|js} {js|vertical|js}
  ;;CssJs.unsafe {js|WebkitBoxShadow|js}
      {js|inset 0 0 0 1000px $(Color.Background.selectedMuted)|js}
  ;;CssJs.unsafe {js|WebkitLineClamp|js} {js|2|js}
  ;;CssJs.unsafe {js|WebkitOverflowScrolling|js} {js|touch|js}
  ;;CssJs.unsafe {js|WebkitTapHighlightColor|js} {js|transparent|js}
  ;;CssJs.unsafe {js|WebkitTextFillColor|js} {js|$(Color.Text.primary)|js}
  ;;CssJs.animation ~duration:(`ms 0) ~delay:(`ms 0) ~direction:`normal
      ~timingFunction:`ease ~fillMode:`none ~playState:`running
      ~iterationCount:(`count 1.) {js|none|js}
  ;;CssJs.unsafe {js|appearance|js} {js|none|js}
  ;;CssJs.unsafe {js|aspectRatio|js} {js|21 / 8|js}
  let c = CssJs.hex "e15a46"
  ;;(CssJs.backgroundColor c : CssJs.rule)
  ;;CssJs.unsafe {js|border|js} {js|none|js}
  ;;CssJs.unsafe {js|bottom|js} {js|unset|js}
  ;;CssJs.boxShadow `none
  ;;CssJs.unsafe {js|breakInside|js} {js|avoid|js}
  ;;CssJs.unsafe {js|caretColor|js} {js|#e15a46|js}
  ;;CssJs.unsafe {js|color|js} {js|inherit|js}
  ;;CssJs.color (`var {js|--color-link|js})
  ;;CssJs.columnWidth (`pxFloat 125.)
  ;;CssJs.columnWidth `auto
  ;;CssJs.display `webkitBox
  ;;CssJs.display `contents
  ;;CssJs.display `table
  ;;(CssJs.SVG.fill c : CssJs.rule)
  ;;CssJs.SVG.fill `currentColor
  ;;CssJs.gap (`pxFloat 4.)
  ;;CssJs.unsafe {js|grid-column|js} {js|unset|js}
  ;;CssJs.unsafe {js|grid-row|js} {js|unset|js}
  ;;CssJs.gridTemplateColumns [|`maxContent;`maxContent|]
  ;;CssJs.gridTemplateColumns
      [|(`minmax ((`pxFloat 10.), `auto));(`fitContent (`pxFloat 20.));(
        `fitContent (`pxFloat 20.))|]
  ;;CssJs.gridTemplateColumns
      [|(`minmax ((`pxFloat 51.), `auto));(`fitContent (`pxFloat 20.));(
        `fitContent (`pxFloat 20.))|]
  ;;CssJs.gridTemplateColumns [|(`repeat ((`num 2), [|`auto|]))|]
  ;;CssJs.gridTemplateColumns [|(`repeat ((`num 3), [|`auto|]))|]
  ;;CssJs.unsafe {js|height|js} {js|fit-content|js}
  ;;CssJs.justifyItems `start
  ;;CssJs.unsafe {js|justify-self|js} {js|unset|js}
  ;;CssJs.unsafe {js|left|js} {js|unset|js}
  let maskedImageUrl = `url "https://www.example.com/eye-uncrossed.svg"
  ;;(CssJs.maskImage maskedImageUrl : CssJs.rule)
  ;;CssJs.unsafe {js|maskPosition|js} {js|center center|js}
  ;;CssJs.unsafe {js|maskRepeat|js} {js|no-repeat|js}
  ;;CssJs.maxWidth `maxContent
  ;;CssJs.unsafe {js|outline|js} {js|none|js}
  ;;CssJs.unsafe {js|overflowAnchor|js} {js|none|js}
  ;;CssJs.unsafe {js|position|js} {js|unset|js}
  ;;CssJs.unsafe {js|resize|js} {js|none|js}
  ;;CssJs.right (`calc (`sub ((`percent 50.), (`pxFloat 4.))))
  ;;CssJs.unsafe {js|scrollBehavior|js} {js|smooth|js}
  ;;CssJs.SVG.strokeOpacity (`num 0.)
  ;;(CssJs.SVG.stroke Color.Text.white : CssJs.rule)
  ;;CssJs.top (`calc (`sub ((`percent 50.), (`pxFloat 1.))))
  ;;CssJs.unsafe {js|top|js} {js|unset|js}
  ;;CssJs.unsafe {js|touchAction|js} {js|none|js}
  ;;CssJs.unsafe {js|touchAction|js} {js|pan-x pan-y|js}
  ;;CssJs.transformOrigin2 `center `left
  ;;CssJs.transformOrigin2 `center `right
  ;;CssJs.transformOrigin (`pxFloat 2.)
  ;;CssJs.transformOrigin `bottom
  ;;CssJs.transformOrigin2 (`cm 3.) (`pxFloat 2.)
  ;;CssJs.transformOrigin2 (`pxFloat 2.) `left
  ;;CssJs.transform `none
  ;;CssJs.unsafe {js|width|js} {js|fit-content|js}
  ;;CssJs.width `maxContent
  ;;CssJs.transitionDelay (`ms 240)
  ;;CssJs.animationDuration (`ms 150)
  ;;CssJs.borderWidth `thin
  ;;CssJs.outlineWidth `medium
  ;;CssJs.outline `medium `solid CssJs.red
  ;;CssJs.overflow lola
  ;;CssJs.overflow `hidden
  ;;(CssJs.overflowY lola : CssJs.rule)
  ;;CssJs.overflowX `hidden
  ;;CssJs.overflowBlock `hidden
  ;;(CssJs.overflowBlock value : CssJs.rule)
  ;;(CssJs.overflowInline value : CssJs.rule)

  $ dune build
  File "input.re", line 1, characters 7-27:
  Error: Unbound module Color
  [1]

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
  CssJs.unsafe(
    {js|WebkitBoxShadow|js},
    {js|inset 0 0 0 1000px $(Color.Background.selectedMuted)|js},
  );
  CssJs.unsafe({js|WebkitLineClamp|js}, {js|2|js});
  CssJs.unsafe({js|WebkitOverflowScrolling|js}, {js|touch|js});
  CssJs.unsafe({js|WebkitTapHighlightColor|js}, {js|transparent|js});
  CssJs.unsafe({js|WebkitTextFillColor|js}, {js|$(Color.Text.primary)|js});
  CssJs.animation(
    ~duration=`ms(0),
    ~delay=`ms(0),
    ~direction=`normal,
    ~timingFunction=`ease,
    ~fillMode=`none,
    ~playState=`running,
    ~iterationCount=`count(1.),
    {js|none|js},
  );
  CssJs.unsafe({js|appearance|js}, {js|none|js});
  CssJs.unsafe({js|aspectRatio|js}, {js|21 / 8|js});
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
  (CssJs.SVG.stroke(Color.Text.white): CssJs.rule);
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
  CssJs.overflow(lola);
  CssJs.overflow(`hidden);
  (CssJs.overflowY(lola): CssJs.rule);
  CssJs.overflowX(`hidden);
  CssJs.overflowBlock(`hidden);
  (CssJs.overflowBlock(value): CssJs.rule);
  (CssJs.overflowInline(value): CssJs.rule);
