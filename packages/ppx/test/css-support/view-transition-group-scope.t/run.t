view-transition-group (css-view-transitions-2) accepts 'normal', 'contain',
'nearest', or a <custom-ident>; view-transition-scope accepts only 'none' or
'all'. input.re carries valid declarations for both (accepted silently);
invalid.re uses view-transition-group's 'contain' keyword on
view-transition-scope, whose error names the property.

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
  File "invalid.re", line 2, characters 31-38:
  2 | [%css {|view-transition-scope: contain|}];
                                     ^^^^^^^
  Error: Property 'view-transition-scope' has an invalid value:
         'contain',
         Expected 'all' or 'none'.
  [1]
