This test ensures error locations are reported accurately for CSS property errors

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

Test error location accuracy
  $ dune build 2>&1 | grep -A 3 "Error:"
  Error: Got 'fley', did you mean 'flex'?
  Error: Got 'fley', did you mean 'flex'?
  Error: Got 'reed', expected 'red', 'rgb', 'hsl', 'hwb', 'lch', 'oklch', 'lab', 'oklab', 'color', 'device-cmyk', 'currentColor', or 'transparent'.
  Error: Got 'fley', did you mean 'flex'?
  Error: Got '10pxx', expected a <length>, <percentage>, or 'auto'.
  Error: Got 'fley', did you mean 'flex'?
  Error: Got 'fley', did you mean 'flex'?
  Error: Got 'fley', did you mean 'flex'?
  Error: Got 'fley', did you mean 'flex'?
  Error: Got 'fley', did you mean 'flex'?
  Error: Got 'fley', did you mean 'flex'?
  Error: Property not found
