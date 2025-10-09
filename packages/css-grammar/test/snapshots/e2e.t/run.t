  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.css-parser)
  >  (preprocess (pps reason_css_parser_ppx)))
  > EOF

  $ dune build
