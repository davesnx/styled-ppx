This test captures the admin-support cx2 regressions from the monorepo: border-side shorthands with interpolated colors, box-shadow array interpolation, and length interpolation inside calc().
  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune describe pp ./input.re | sed -n '/let _borderTop/,$p'
  let _borderTop =
    CSS.make(
      "css-11h9vd4-_borderTop",
      [("--var-gg7ool", CSS.Types.Color.toString(Color.Border.line))],
    );
  let _borderBottom =
    CSS.make(
      "css-epkb5g-_borderBottom",
      [("--var-1xen95r", CSS.Types.Color.toString(Color.Border.lineAlpha))],
    );
  let _borderLeft =
    CSS.make(
      "css-ob4w3j-_borderLeft",
      [("--var-kur4dm", CSS.Types.Color.toString(Color.Border.lineAlpha))],
    );
  
  let _boxShadow1 =
    CSS.make(
      "css-1070dz6-_boxShadow1",
      [
        (
          "--var-1tqet3m",
          CSS.Types.BoxShadows.toString(BoxShadow.deprecated__elevation1),
        ),
      ],
    );
  
  let _heightPlus =
    CSS.make(
      "css-1y8ttxg-_heightPlus",
      [("--var-y31x4h", CSS.Types.Length.toString(topMenuHeight))],
    );

  $ dune build
