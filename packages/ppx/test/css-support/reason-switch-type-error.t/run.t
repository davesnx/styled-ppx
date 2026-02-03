This test ensures Reason switch type errors are reported with correct locations

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -30
  File "input.re", line 10, characters 44-47:
  Error: The constructor `re has type [> `re ]
         but an expression was expected of type Css_types.Color.t
         The second variant type does not allow tag(s) `re
