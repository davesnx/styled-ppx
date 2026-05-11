Compounds that mix a pseudo with a Class / Id / Attribute / Type
selector are accepted unchanged. The "mixed" form is unambiguous —
spec descendant-join is the only sensible interpretation, and the
compound is anchored by the non-pseudo component so the result is
not a footgun.

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
