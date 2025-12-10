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
  File "input.re", line 7, characters 6-32:
  7 | [%cx2 {|animation-name: $(foo)|}];
            ^^^^^^^^^^^^^^^^^^^^^^^^^^
  Error: This expression has type "[> `KeyframesName of string ]"
         but an expression was expected of type "Css_types.AnimationName.t"
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    "@keyframes keyframe-1gqudlu { 0% { opacity: 0.0 ; } 100% { opacity: 1.0 ; } }\n.css-gyly5q { animation-name: random; }\n.css-1i13szv { animation-name: foo, bar; }\n.css-1rzyjvs { animation-name: var(--var-13g64p); }\n.css-b88oy1 { animation-name: var(--var-13g64p), var(--var-rgjxtb); }\n.css-16l6t2h { animation-duration: 0s; }\n.css-qeukgh { animation-duration: 1s; }\n.css-1p5cz5u { animation-duration: 100ms; }\n.css-lejn06 { animation-duration: 1.64s, 15.22s; }\n.css-1jp5qf0 { animation-duration: 10s, 35s, 230ms; }\n.css-rqexdv { animation-timing-function: ease; }\n.css-z9jcr7 { animation-timing-function: linear; }\n.css-9g60ck { animation-timing-function: ease-in; }\n.css-1i8e4x4 { animation-timing-function: ease-out; }\n.css-wefyhw { animation-timing-function: ease-in-out; }\n.css-1e7ql32 { animation-timing-function: cubic-bezier(.5, .5, .5, .5); }\n.css-19jpktj { animation-timing-function: cubic-bezier(.5, 1.5, .5, -2.5); }\n.css-1wfyjhr { animation-timing-function: step-start; }\n.css-12uv6yb { animation-timing-function: step-end; }\n.css-1i8h2v5 { animation-timing-function: steps(3, start); }\n.css-j9gfaf { animation-timing-function: steps(5, end); }\n.css-2a0skc { animation-iteration-count: infinite; }\n.css-p5xba1 { animation-iteration-count: 8; }\n.css-mdj2nu { animation-iteration-count: 4.35; }\n.css-vv3jvd { animation-iteration-count: 2, 0, infinite; }\n.css-17sbnog { animation-direction: normal; }\n.css-1lbfdif { animation-direction: alternate; }\n.css-czv9lh { animation-direction: reverse; }\n.css-kgx9ec { animation-direction: alternate-reverse; }\n.css-16m6mc9 { animation-direction: normal, reverse; }\n.css-aokxmx { animation-direction: alternate, reverse, normal; }\n.css-o52y9c { animation-play-state: running; }\n.css-1flzxye { animation-play-state: paused; }\n.css-1lfwh20 { animation-play-state: paused, running, running; }\n.css-13lmla1 { animation-delay: 1s; }\n.css-1ciikty { animation-delay: -1s; }\n.css-19dmitg { animation-delay: 2.1s, 480ms; }\n.css-1pdg3wu { animation-fill-mode: none; }\n.css-5xnzmw { animation-fill-mode: forwards; }\n.css-15ig93q { animation-fill-mode: backwards; }\n.css-1kdiqxg { animation-fill-mode: both; }\n.css-1vs3rvu { animation-fill-mode: both, forwards, none; }\n.css-1a99hkj { animation: foo 1s 2s infinite linear alternate both; }\n.css-1cdqcon { animation: 4s ease-in 1s infinite reverse both paused; }\n.css-axoozn { animation: a 300ms linear 400ms infinite reverse forwards running; }\n"
  ];
  let foo = `KeyframesName("keyframe-1gqudlu");
  let bar = `KeyframesName("keyframe-1gqudlu");
  
  CSS.make("css-gyly5q", []);
  CSS.make("css-1i13szv", []);
  CSS.make(
    "css-1rzyjvs",
    [("--var-13g64p", CSS.Types.AnimationName.toString(foo))],
  );
  CSS.make(
    "css-b88oy1",
    [
      ("--var-13g64p", CSS.Types.AnimationName.toString(foo)),
      ("--var-rgjxtb", CSS.Types.AnimationName.toString(bar)),
    ],
  );
  CSS.make("css-16l6t2h", []);
  CSS.make("css-qeukgh", []);
  CSS.make("css-1p5cz5u", []);
  CSS.make("css-lejn06", []);
  CSS.make("css-1jp5qf0", []);
  CSS.make("css-rqexdv", []);
  CSS.make("css-z9jcr7", []);
  CSS.make("css-9g60ck", []);
  CSS.make("css-1i8e4x4", []);
  CSS.make("css-wefyhw", []);
  CSS.make("css-1e7ql32", []);
  CSS.make("css-19jpktj", []);
  CSS.make("css-1wfyjhr", []);
  CSS.make("css-12uv6yb", []);
  CSS.make("css-1i8h2v5", []);
  CSS.make("css-j9gfaf", []);
  CSS.animationTimingFunctions([|
    `ease,
    `stepStart,
    `cubicBezier((0.1, 0.7, 1., 0.1)),
  |]);
  CSS.make("css-2a0skc", []);
  CSS.make("css-p5xba1", []);
  CSS.make("css-mdj2nu", []);
  CSS.make("css-vv3jvd", []);
  CSS.make("css-17sbnog", []);
  CSS.make("css-1lbfdif", []);
  CSS.make("css-czv9lh", []);
  CSS.make("css-kgx9ec", []);
  CSS.make("css-16m6mc9", []);
  CSS.make("css-aokxmx", []);
  CSS.make("css-o52y9c", []);
  CSS.make("css-1flzxye", []);
  CSS.make("css-1lfwh20", []);
  CSS.make("css-13lmla1", []);
  CSS.make("css-1ciikty", []);
  CSS.make("css-19dmitg", []);
  CSS.make("css-1pdg3wu", []);
  CSS.make("css-5xnzmw", []);
  CSS.make("css-15ig93q", []);
  CSS.make("css-1kdiqxg", []);
  CSS.make("css-1vs3rvu", []);
  CSS.make("css-1a99hkj", []);
  CSS.make("css-1cdqcon", []);
  CSS.make("css-axoozn", []);
