Regression test: an unbound value inside a `$( ... )` interpolation of a
double-quoted [%css] string must be reported at the interpolation's exact
position in the file, not at the beginning of the CSS string.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -5
  File "input.re", line 1, characters 44-49:
  1 | let demo = [%css "font-size: 10px; color: $(color);"];
                                                  ^^^^^
  Error: Unbound value color
  Hint:   Did you mean floor or lor?
