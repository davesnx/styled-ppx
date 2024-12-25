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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  
  let _chart =
    CSS.style([|
      CSS.label("_chart"),
      CSS.userSelect(`none),
      CSS.selector(
        [|{js|.recharts-cartesian-grid-horizontal|js}|],
        [|
          CSS.selector(
            [|{js|line|js}|],
            [|
              CSS.selector(
                [|{js|:nth-last-child(1)|js}, {js|:nth-last-child(2)|js}|],
                [|CSS.SVG.strokeOpacity(`num(0.))|],
              ),
            |],
          ),
        |],
      ),
      CSS.selector(
        [|
          {js|.recharts-scatter .recharts-scatter-symbol .recharts-symbols|js},
        |],
        [|
          CSS.opacity(0.8),
          CSS.selector([|{js|:hover|js}|], [|CSS.opacity(1.)|]),
        |],
      ),
    |]);

  $ dune build
