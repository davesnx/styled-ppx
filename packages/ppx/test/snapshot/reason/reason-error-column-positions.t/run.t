This test ensures error column positions are reported accurately

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

Test that error positions point to the exact location of the error.
The column position should point to the value, not the start of the property.

  $ dune build 2>&1 | grep -E "File.*line.*character|Error:" | head -n 40
  File "input.re", line 4, characters 18-32:
  Error: Got 'fley', did you mean 'flex'?
  File "input.re", line 7, characters 18-28:
  Error: Got 'reed', expected 'red', 'rgb', 'hsl', 'hwb', 'lch', 'oklch', 'lab', 'oklab', 'color', 'device-cmyk', 'currentColor', or 'transparent'.
  File "input.re", line 10, characters 4-17:
  Error: Got 'fley', did you mean 'flex'?
  File "input.re", line 15, characters 29-42:
  Error: Got 'fley', did you mean 'flex'?
  File "input.re", line 18, characters 2-18:
  Error: Got 'reed', expected 'red', 'rgb', 'hsl', 'hwb', 'lch', 'oklch', 'lab', 'oklab', 'color', 'device-cmyk', 'currentColor', or 'transparent'.
  File "input.re", line 24, characters 18-77:
  Error: Got 'fley', expected a valid box-shadow value.
  File "input.re", line 27, characters 18-43:
  Error: Got 'fley', expected a <length>, <percentage>, or 'auto'.
  File "input.re", line 30, characters 18-41:
  Error: Got 'fley', did you mean 'flex'?
  File "input.re", line 33, characters 18-39:
  Error: Got 'fley', expected an <angle>.
  File "input.re", line 36, characters 18-40:
  Error: Got 'fley', expected a valid calc expression.
