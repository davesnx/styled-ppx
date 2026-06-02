This test ensures generated [%styled.global] helper bindings do not fail builds
that promote warning 32 to an error.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (flags (:standard -warn-error +32))
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build
