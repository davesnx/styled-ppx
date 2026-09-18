The css-counter-styles-3 @counter-style descriptors (system, symbols,
negative, range, pad, fallback, prefix, suffix, additive-symbols,
speak-as) are validated at compile time inside [%styled.global]
(issue #584). list-style-type accepts the custom ident naming the style.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

Valid @counter-style blocks exercising every descriptor compile and ship
through the extraction channel verbatim:

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (modules input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -4

  $ dune describe pp ./input.re | sed '1,/^];$/d' | head -3
  [@css
    "@counter-style thumbs{system:cyclic;symbols:\"+\" url(\"one.svg\") alpha;negative:\"(\" \")\";range:1 10,20 infinite;pad:3 \"0\";fallback:lower-alpha;prefix:\">\";suffix:\". \";speak-as:bubbles}"
  ];

An invalid value (a number where a system keyword is required) fails with
an error naming the descriptor:

  $ cat > dune << EOF
  > (executable
  >  (name invalid)
  >  (modules invalid)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "invalid.re", line 8, characters 11-14:
  8 |     system: 42;
                 ^^^
  Error: Property 'system' has an invalid value: '42',
         Expected 'additive', 'alphabetic', 'cyclic', 'extends', 'fixed',
         'numeric', or 'symbolic'.
