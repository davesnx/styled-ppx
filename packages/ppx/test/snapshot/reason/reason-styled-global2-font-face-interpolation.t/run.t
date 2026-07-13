styled.global must reject `$(name)` interpolation inside a `url()`
function. CSS does not substitute `var()` inside `url()`, so allowing
the rewrite would silently emit broken CSS that fails to load the
resource at runtime. Users should inline the URL as a literal string
or move the entire declaration value behind a single interpolation.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -n 5
  File "input.re", line 15, characters 13-25:
  15 |     src: url($(inter_url)) format("woff2");
                    ^^^^^^^^^^^^
  Error: Interpolation inside `url(...)` is not supported: browsers don't substitute `var()` there.
  - Inline the URL: `url("/path/to/asset")`.
