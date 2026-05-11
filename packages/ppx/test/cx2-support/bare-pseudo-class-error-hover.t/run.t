Top-level bare leading `:hover` is rejected with the standard
diagnostic pointing at the selector and offering both safe forms.

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
  File "input.re", line 2, characters 2-9:
  Error: Bare leading pseudo selector `:hover` is ambiguous in nested CSS. Per CSS Nesting Level 1 §3.1 it descendant-joins with the enclosing selector (producing `<parent> :hover`), which matches descendants rather than the element itself. Write `&:hover` for compound (`<parent>:hover`, the usual intent), or `& :hover` to opt into the explicit descendant form.
  [1]
