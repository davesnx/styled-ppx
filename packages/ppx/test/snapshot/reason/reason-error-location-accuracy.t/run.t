This test ensures error locations are reported accurately for CSS property errors

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native server-reason-react.react)
  >  (preprocess (pps server-reason-react.ppx styled-ppx --output=./styles)))
  > EOF

Test error location accuracy
  $ dune build
