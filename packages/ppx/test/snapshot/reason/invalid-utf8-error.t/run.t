This test ensures a CSS payload containing bytes that are not valid UTF-8
produces a located error instead of crashing the compiler with
`Fatal error: exception Sedlexing.MalFormed`.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

Testing located error for a raw \xe9 byte inside the CSS payload
  $ dune build
  File "input.re", line 3, characters 33-34:
  3 | let broken = [%css "content: \"caf\xe9\""];
                                       ^
  Error: This CSS is not valid UTF-8
  [1]
