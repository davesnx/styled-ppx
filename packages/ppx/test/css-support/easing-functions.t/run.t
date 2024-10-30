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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  
  CSS.unsafe({js|transitionTimingFunction|js}, {js|steps(2, jump-start)|js});
  CSS.unsafe({js|transitionTimingFunction|js}, {js|steps(2, jump-end)|js});
  CSS.unsafe({js|transitionTimingFunction|js}, {js|steps(1, jump-both)|js});
  CSS.unsafe({js|transitionTimingFunction|js}, {js|steps(2, jump-none)|js});
