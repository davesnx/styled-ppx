Top-level bare leading `::after` (pseudo-element) is rejected with
the same diagnostic shape as bare pseudo-classes.

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
  File "input.re", line 3, characters 2-10:
  3 |   ::after { content: "*"; }
        ^^^^^^^^
  Error: Bare leading pseudo selector `::after` is ambiguous in nested CSS. Per CSS Nesting Level 1 §3.1 it descendant-joins with the enclosing selector (producing `<parent> ::after`), which matches descendants rather than the element itself. Write `&::after` for compound (`<parent>::after`, the usual intent), or `& ::after` to opt into the explicit descendant form.
  [1]
