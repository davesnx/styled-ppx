CSS Generated Content L3 (bookmark-label, bookmark-level, bookmark-state,
string-set) and CSS Generated Content for Paged Media (running,
footnote-display, footnote-policy). input.re carries valid declarations
(accepted silently); invalid.re carries an out-of-grammar keyword, whose
error names the property.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executables
  >  (names input invalid)
  >  (libraries styled-ppx.native)
  >  (flags (:standard -w -32))
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build
  File "invalid.re", line 1, characters 24-30:
  1 | [%css {|bookmark-state: hidden|}];
                              ^^^^^^
  Error: Property 'bookmark-state' has an invalid value: 'hidden',
         Expected 'closed' or 'open'.
  [1]
