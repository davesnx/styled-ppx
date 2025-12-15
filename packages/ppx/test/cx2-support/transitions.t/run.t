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
  File "input.re", line 44, characters 4-13:
  44 | let property2 = CSS.Types.TransitionProperty.all;
           ^^^^^^^^^
  Error (warning 32 [unused-value-declaration]): unused value property2.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-18xp3bj { transition-property: none; }\n.css-1s51fkn { transition-property: all; }\n.css-1tssc30 { transition-property: width; }\n.css-xlhx1v { transition-property: width, height; }\n.css-18ho55h { transition-duration: 0s; }\n.css-1l61tf5 { transition-duration: 1s; }\n.css-ee4pqv { transition-duration: 100ms; }\n.css-1hwar81 { transition-duration: 10s, 30s, 230ms; }\n.css-1b4fulp { transition-timing-function: ease; }\n.css-tu9ezu { transition-timing-function: linear; }\n.css-1gqt5eg { transition-timing-function: ease-in; }\n.css-1ibyizf { transition-timing-function: ease-out; }\n.css-5ctsla { transition-timing-function: ease-in-out; }\n.css-1b9gly0 { transition-timing-function: cubic-bezier(.5, .5, .5, .5); }\n.css-17vkr8f { transition-timing-function: cubic-bezier(.5, 1.5, .5, -2.5); }\n.css-1j9k05 { transition-timing-function: step-start; }\n.css-1thc6of { transition-timing-function: step-end; }\n.css-19fypmz { transition-timing-function: steps(3, start); }\n.css-1xm39fv { transition-timing-function: steps(5, end); }\n.css-tnafj5 { transition-timing-function: ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1); }\n.css-f8spak { transition-delay: 1s; }\n.css-1tjo4ps { transition-delay: -1s; }\n.css-2b5va2 { transition-delay: 2s, 4ms; }\n.css-c9047x { transition-behavior: normal; }\n.css-1jkpp2n { transition-behavior: allow-discrete; }\n.css-4br5th { transition-behavior: allow-discrete, normal; }\n.css-17k4frg { transition: margin-right 2s, opacity 0.5s; }\n.css-1srr1rr { transition: 1s 2s width linear; }\n.css-xmiiar { transition: none; }\n.css-8f2r2e { transition: margin-right; }\n.css-15mf2t2 { transition: margin-right ease-in; }\n.css-t3yaku { transition: .5s; }\n.css-1kx0h1w { transition: 200ms .5s; }\n.css-10x512z { transition: linear; }\n.css-1nmf3m1 { transition: 1s .5s linear margin-right; }\n.css-1pg67ld { transition: display 4s allow-discrete; }\n.css-mb3iwo { transition: all 0.5s ease-out allow-discrete; }\n.css-133lk2h { transition: var(--var-mzypqe); }\n.css-hxt43r { transition: var(--var-tbzsda); }\n.css-12yumlj { transition: var(--var-fefko6) var(--var-7p0nz0) var(--var-ml3rsq) var(--var-h43taz) var(--var-vo645f); }\n.css-1s77stt { transition: var(--var-fefko6) 0.2s ease-out 3s; }\n.css-1r5dgu9 { transition: var(--var-fefko6) 0.2s var(--var-ml3rsq) 3s; }\n.css-2ud1nz { transition: var(--var-fefko6) var(--var-7p0nz0) var(--var-ml3rsq) 3s; }\n.css-1qu06dt { transition: margin-right var(--var-7p0nz0) ease-out var(--var-h43taz); }\n.css-14j7bkl { transition: var(--var-fefko6) var(--var-7p0nz0) ease-out var(--var-h43taz); }\n.css-f4zddx { transition: margin-right 0.2s var(--var-ml3rsq) 3s; }\n.css-ebibhc { transition: margin-right 0.2s ease-out var(--var-h43taz); }\n.css-1xh0m8n { transition: var(--var-fefko6) 0.2s ease-in; }\n.css-qf8wt0 { transition: var(--var-fefko6) 0.2s var(--var-ml3rsq); }\n.css-1cdb5et { transition: margin-right var(--var-7p0nz0) ease-in; }\n.css-oru0ue { transition: var(--var-fefko6) var(--var-7p0nz0) ease-in; }\n.css-1se0g6a { transition: margin-right 0.2s var(--var-ml3rsq); }\n.css-18a1zm2 { transition: var(--var-fefko6) 0.2s; }\n.css-w3j1tl { transition: margin-right var(--var-7p0nz0); }\n"
  ];
  CSS.make("css-18xp3bj", []);
  CSS.make("css-1s51fkn", []);
  CSS.make("css-1tssc30", []);
  CSS.make("css-xlhx1v", []);
  CSS.make("css-18ho55h", []);
  CSS.make("css-1l61tf5", []);
  CSS.make("css-ee4pqv", []);
  CSS.make("css-1hwar81", []);
  CSS.make("css-1b4fulp", []);
  CSS.make("css-tu9ezu", []);
  CSS.make("css-1gqt5eg", []);
  CSS.make("css-1ibyizf", []);
  CSS.make("css-5ctsla", []);
  CSS.make("css-1b9gly0", []);
  CSS.make("css-17vkr8f", []);
  CSS.make("css-1j9k05", []);
  CSS.make("css-1thc6of", []);
  CSS.make("css-19fypmz", []);
  CSS.make("css-1xm39fv", []);
  CSS.make("css-tnafj5", []);
  CSS.make("css-f8spak", []);
  CSS.make("css-1tjo4ps", []);
  CSS.make("css-2b5va2", []);
  CSS.make("css-c9047x", []);
  CSS.make("css-1jkpp2n", []);
  CSS.make("css-4br5th", []);
  CSS.make("css-17k4frg", []);
  CSS.make("css-1srr1rr", []);
  CSS.make("css-xmiiar", []);
  CSS.make("css-8f2r2e", []);
  CSS.make("css-15mf2t2", []);
  CSS.make("css-t3yaku", []);
  CSS.make("css-1kx0h1w", []);
  CSS.make("css-10x512z", []);
  CSS.make("css-1nmf3m1", []);
  CSS.make("css-1pg67ld", []);
  CSS.make("css-mb3iwo", []);
  
  let property = CSS.Types.TransitionProperty.make("margin-right");
  let property2 = CSS.Types.TransitionProperty.all;
  let timingFunction = `easeOut;
  let duration = `ms(200);
  let delay = `s(3);
  let property3 = CSS.Types.TransitionProperty.make("opacity");
  let behavior = `allowDiscrete;
  
  let fullTransition =
    CSS.Types.Transition.Value.make(
      ~property=CSS.Types.TransitionProperty.make("margin-right"),
      ~duration=`ms(200),
      (),
    );
  CSS.make("css-133lk2h", [("--var-mzypqe", CSS.Types.Transition.toString(fullTransition))]);
  
  let fullTransition2 = CSS.Types.Transition.Value.make(~property=CSS.Types.TransitionProperty.all, ());
  CSS.make("css-hxt43r", [("--var-tbzsda", CSS.Types.Transition.toString(fullTransition2))]);
  
  CSS.make(
    "css-12yumlj",
    [
      ("--var-fefko6", CSS.Types.TransitionProperty.toString(property)),
      ("--var-7p0nz0", CSS.Types.Time.toString(duration)),
      ("--var-ml3rsq", CSS.Types.TimingFunction.toString(timingFunction)),
      ("--var-h43taz", CSS.Types.Time.toString(delay)),
      ("--var-vo645f", CSS.Types.TransitionBehaviorValue.toString(behavior)),
    ],
  );
  CSS.transitions([|
    CSS.Types.Transition.Value.make(~duration, ~delay, ~timingFunction, ~property, ()),
    CSS.Types.Transition.Value.make(~duration=`s(0), ~property=property3, ()),
  |]);
  CSS.make("css-1s77stt", [("--var-fefko6", CSS.Types.TransitionProperty.toString(property))]);
  CSS.make(
    "css-1r5dgu9",
    [
      ("--var-fefko6", CSS.Types.TransitionProperty.toString(property)),
      ("--var-ml3rsq", CSS.Types.TimingFunction.toString(timingFunction)),
    ],
  );
  CSS.make(
    "css-2ud1nz",
    [
      ("--var-fefko6", CSS.Types.TransitionProperty.toString(property)),
      ("--var-7p0nz0", CSS.Types.Time.toString(duration)),
      ("--var-ml3rsq", CSS.Types.TimingFunction.toString(timingFunction)),
    ],
  );
  CSS.make(
    "css-1qu06dt",
    [("--var-7p0nz0", CSS.Types.Time.toString(duration)), ("--var-h43taz", CSS.Types.Time.toString(delay))],
  );
  CSS.make(
    "css-14j7bkl",
    [
      ("--var-fefko6", CSS.Types.TransitionProperty.toString(property)),
      ("--var-7p0nz0", CSS.Types.Time.toString(duration)),
      ("--var-h43taz", CSS.Types.Time.toString(delay)),
    ],
  );
  CSS.make("css-f4zddx", [("--var-ml3rsq", CSS.Types.TimingFunction.toString(timingFunction))]);
  CSS.make("css-ebibhc", [("--var-h43taz", CSS.Types.Time.toString(delay))]);
  CSS.make("css-1xh0m8n", [("--var-fefko6", CSS.Types.TransitionProperty.toString(property))]);
  CSS.make(
    "css-qf8wt0",
    [
      ("--var-fefko6", CSS.Types.TransitionProperty.toString(property)),
      ("--var-ml3rsq", CSS.Types.TimingFunction.toString(timingFunction)),
    ],
  );
  CSS.make("css-1cdb5et", [("--var-7p0nz0", CSS.Types.Time.toString(duration))]);
  CSS.make(
    "css-oru0ue",
    [
      ("--var-fefko6", CSS.Types.TransitionProperty.toString(property)),
      ("--var-7p0nz0", CSS.Types.Time.toString(duration)),
    ],
  );
  CSS.make("css-1se0g6a", [("--var-ml3rsq", CSS.Types.TimingFunction.toString(timingFunction))]);
  CSS.make("css-1xh0m8n", [("--var-fefko6", CSS.Types.TransitionProperty.toString(property))]);
  CSS.make("css-1cdb5et", [("--var-7p0nz0", CSS.Types.Time.toString(duration))]);
  CSS.make("css-1se0g6a", [("--var-ml3rsq", CSS.Types.TimingFunction.toString(timingFunction))]);
  CSS.make("css-18a1zm2", [("--var-fefko6", CSS.Types.TransitionProperty.toString(property))]);
  CSS.make("css-w3j1tl", [("--var-7p0nz0", CSS.Types.Time.toString(duration))]);
