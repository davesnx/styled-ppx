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
      "cx-_borderTop cid-k0smpx css-11h9vd4",
      [("--line-17j5in5", CSS.Types.Color.toString(Color.Border.line))],
    );
  let _borderBottom =
    CSS.make(
      "cx-_borderBottom cid-4yz5wd css-epkb5g",
      [
        (
          "--lineAlpha-1tmd8aq",
          CSS.Types.Color.toString(Color.Border.lineAlpha),
        ),
      ],
    );
  let _borderLeft =
    CSS.make(
      "cx-_borderLeft cid-1w7n6a9 css-ob4w3j",
      [
        (
          "--lineAlpha-k1tpqj",
          CSS.Types.Color.toString(Color.Border.lineAlpha),
        ),
      ],
    );
  
  let _boxShadow1 =
    CSS.make(
      "cx-_boxShadow1 cid-114a8u4 css-1070dz6",
      [
        (
          "--deprecated__elevation1-1jpikyl",
          CSS.Types.BoxShadows.toString(BoxShadow.deprecated__elevation1),
        ),
      ],
    );
  
  let _heightPlus =
    CSS.make(
      "cx-_heightPlus cid-11xytn2 css-1y8ttxg",
      [("--topMenuHeight-10ob2p1", CSS.Types.Length.toString(topMenuHeight))],
    );

  $ dune build
