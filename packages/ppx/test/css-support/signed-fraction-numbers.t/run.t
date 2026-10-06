This test locks down signed-fraction numbers (a sign directly followed by a
decimal point, with no leading digit, e.g. `-.5px`). CSS Syntax Level 3
allows this spelling; the lexer's `consume_number` used to only match a sign
when followed immediately by a digit, so it consumed nothing for `-.5`, left
an empty number representation, and crashed the whole PPX with
`Failure("float_of_string")` instead of producing a located error or a
token.

The renderer always normalizes the numeric spelling it emits. `-.5px`
renders as `-0.5px`: a leading zero is added, the same as the existing
`.5px` -> `0.5px` normalization. `+.5px` renders as `0.5px`: the leading
zero is added and the redundant "+" is dropped. `-.5e1px` renders as its
evaluated form, `-5px`. This normalization is pre-existing renderer
behavior. This fix only lets the lexer reach the renderer without crashing;
it does not change how numbers render.

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
  [@css "._a_7ppxco{margin:-0.5px;}"];
  [@css "._a_7p1kc6{margin:0.5px;}"];
  [@css "._a_dmr2ev{transition:opacity 0.3s ease -0.1s;}"];
  [@css "._a_71008ktvb{top:-5px;}"];
  CSS.make("_a_7ppxco", []);
  CSS.make("_a_7p1kc6", []);
  CSS.make("_a_dmr2ev", []);
  CSS.make("_a_71008ktvb", []);

  $ dune build
