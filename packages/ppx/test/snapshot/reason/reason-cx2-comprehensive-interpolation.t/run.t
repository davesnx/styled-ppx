Comprehensive test for cx2 interpolation with various property types
  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    ".css-1kchgva { width: var(--var-yq31wd); }\n.css-gascpj { height: var(--var-yq31wd); }\n.css-cbvxw4 { min-width: var(--var-yq31wd); }\n.css-yl4um3 { max-width: var(--var-yq31wd); }\n.css-c42q25 { margin-top: var(--var-yq31wd); }\n.css-ai6rtm { margin-bottom: var(--var-yq31wd); }\n.css-mjx1j { padding-left: var(--var-yq31wd); }\n.css-g3iwpg { padding-right: var(--var-yq31wd); }\n.css-32u9gy { gap: var(--var-yq31wd); }\n.css-1nv4nym { row-gap: var(--var-yq31wd); }\n.css-1nl0ld0 { column-gap: var(--var-yq31wd); }\n.css-k3s05 { color: var(--var-15252qs); }\n.css-dw114q { background-color: var(--var-15252qs); }\n.css-16ri0tl { border-top-color: var(--var-15252qs); }\n.css-13ho3oh { flex-basis: var(--var-x7fhjg); }\n.css-1lap05 { grid-row-start: var(--var-4ff4w4); }\n.css-gydso { grid-column-end: var(--var-4ff4w4); }\n.css-1457p3r { top: var(--var-1n3wsy); }\n.css-t129nw { bottom: var(--var-1n3wsy); }\n.css-4z3574 { z-index: var(--var-fd7qxc); }\n.css-14zw3md { border-top-width: var(--var-wag9af); }\n.css-1jugcl4 { border-width: var(--var-wag9af); }\n.css-wx7rkh { letter-spacing: var(--var-apx1x0); }\n.css-1s0bla0 { word-spacing: var(--var-apx1x0); }\n.css-y0qb0l { width: var(--var-a9b677); }\n.css-16ve3ed { height: 100px; }\n.css-jk0pkr { color: red; }\n"
  ];
  let lengthVar = CSS.px(10);
  let colorVar = CSS.red;
  let percentVar = CSS.pct(50.0);
  let autoVar = `auto;
  let test1 =
    CSS.make(
      "css-1kchgva css-gascpj css-cbvxw4 css-yl4um3",
      [("--var-yq31wd", CSS.Types.Width.toString(lengthVar))],
    );
  let test2 =
    CSS.make(
      "css-c42q25 css-ai6rtm css-mjx1j css-g3iwpg",
      [("--var-yq31wd", CSS.Types.Length.toString(lengthVar))],
    );
  let test3 =
    CSS.make(
      "css-32u9gy css-1nv4nym css-1nl0ld0",
      [("--var-yq31wd", CSS.Types.Gap.toString(lengthVar))],
    );
  let test4 =
    CSS.make(
      "css-k3s05 css-dw114q css-16ri0tl",
      [("--var-15252qs", CSS.Types.Color.toString(colorVar))],
    );
  let flexBasisVar = CSS.px(100);
  let test5 =
    CSS.make(
      "css-13ho3oh",
      [("--var-x7fhjg", CSS.Types.Width.toString(flexBasisVar))],
    );
  let gridLineVar = `auto;
  let test6 =
    CSS.make(
      "css-1lap05 css-gydso",
      [("--var-4ff4w4", CSS.Types.GridRowStart.toString(gridLineVar))],
    );
  let topVar = CSS.px(20);
  let test7 =
    CSS.make(
      "css-1457p3r css-t129nw",
      [("--var-1n3wsy", CSS.Types.Top.toString(topVar))],
    );
  let zIndexVar = `num(10);
  let test8 =
    CSS.make(
      "css-4z3574",
      [("--var-fd7qxc", CSS.Types.ZIndex.toString(zIndexVar))],
    );
  let borderWidthVar = `medium;
  let test9 =
    CSS.make(
      "css-14zw3md css-1jugcl4",
      [("--var-wag9af", CSS.Types.Length.toString(borderWidthVar))],
    );
  let spacingVar = CSS.px(2);
  let test10 =
    CSS.make(
      "css-wx7rkh css-1s0bla0",
      [("--var-apx1x0", CSS.Types.LetterSpacing.toString(spacingVar))],
    );
  let test11 = width =>
    CSS.make(
      "css-y0qb0l css-16ve3ed css-jk0pkr",
      [("--var-a9b677", CSS.Types.Width.toString(width))],
    );

