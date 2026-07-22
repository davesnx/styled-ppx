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
  [@css ".css-1vj3b5r{transition-timing-function:steps(2,jump-start)}"];
  [@css ".css-4a3i15{transition-timing-function:steps(2,jump-end)}"];
  [@css ".css-qdfgpt{transition-timing-function:steps(1,jump-both)}"];
  [@css ".css-6hu8yk{transition-timing-function:steps(2,jump-none)}"];
  
  CSS.make("css-1vj3b5r", []);
  CSS.make("css-4a3i15", []);
  CSS.make("css-qdfgpt", []);
  CSS.make("css-6hu8yk", []);
