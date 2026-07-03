Regression: extraction-phase diagnostics (bare leading pseudo and
@media-prelude interpolation) must report absolute file locations, even
when the [%css] block sits several lines below the top of the file.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name pseudo)
  >  (modules pseudo)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > (executable
  >  (name media)
  >  (modules media)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ cat > pseudo.re << EOF
  > let filler_one = 1;
  > let filler_two = 2;
  > let filler_three = 3;
  > let filler_four = 4;
  > let _styles = [%css {|
  >   :hover { color: red; }
  > |}];
  > EOF

  $ cat > media.re << EOF
  > let filler_one = 1;
  > let filler_two = 2;
  > let breakpoint = "(min-width: 600px)";
  > let filler_four = 4;
  > let _styles = [%css {|
  >   color: red;
  >   @media \$(breakpoint) {
  >     display: none;
  >   }
  > |}];
  > EOF

  $ dune build ./pseudo.exe
  File "pseudo.re", line 6, characters 2-9:
  Error: Bare leading pseudo selector `:hover` is ambiguous in nested CSS. Per CSS Nesting Level 1 §3.1 it descendant-joins with the enclosing selector (producing `<parent> :hover`), which matches descendants rather than the element itself. Write `&:hover` for compound (`<parent>:hover`, the usual intent), or `& :hover` to opt into the explicit descendant form.
  [1]

  $ dune build ./media.exe
  File "media.re", line 7, characters 8-23:
  Error: Interpolation in @media preludes is not supported during static extraction. CSS custom properties (var()) are not valid in media query conditions. Inline the value directly.
  [1]
