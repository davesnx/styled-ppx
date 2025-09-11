This test ensures that '$' is not shown in error messages

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

Test that error messages don't contain "expected '$'"
  $ dune build 2>&1 | grep -E "Error:" | head -n 10
  Error: Got 'fley', did you mean 'flex'?
  Error: Got 'fley', did you mean 'flex'?
  Error: Got 'fley', did you mean 'flex'?
  Error: Got 'reed', expected 'red', 'rgb', 'hsl', 'hwb', 'lch', 'oklch', 'lab', 'oklab', 'color', 'device-cmyk', 'currentColor', or 'transparent'.

Verify that none of the error messages contain "expected '$'"
  $ dune build 2>&1 | grep -q "expected '\$'" && echo "FAIL: Found 'expected \$'" || echo "PASS: No 'expected \$' found"
  PASS: No 'expected $' found
