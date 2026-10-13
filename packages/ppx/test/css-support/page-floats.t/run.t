CSS Page Floats (https://drafts.csswg.org/css-page-floats/): float-reference,
float-defer, float-offset. input.re carries valid declarations (accepted
silently); invalid.re carries an out-of-grammar keyword, whose error names
the property.

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
  File "invalid.re", line 1, characters 25-30:
  1 | [%css {|float-reference: block|}];
                               ^^^^^
  Error: Property 'float-reference' has an invalid value: 'block',
         Expected 'column', 'inline', 'page', or 'region'.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "._a_fsgd04{float-reference:inline;}"];
  [@css "._a_fsfd3q{float-reference:column;}"];
  [@css "._a_fsrpyx{float-reference:region;}"];
  [@css "._a_fsssig{float-reference:page;}"];
  [@css "._a_fqk6ea{float-defer:none;}"];
  [@css "._a_fqeb1u{float-defer:last;}"];
  [@css "._a_fqr3fc{float-defer:2;}"];
  [@css "._a_frh37k{float-offset:0;}"];
  [@css "._a_frwu5a{float-offset:10px;}"];
  [@css "._a_fr5tyx{float-offset:10%;}"];
  
  CSS.make("_a_fsgd04", []);
  CSS.make("_a_fsfd3q", []);
  CSS.make("_a_fsrpyx", []);
  CSS.make("_a_fsssig", []);
  CSS.make("_a_fqk6ea", []);
  CSS.make("_a_fqeb1u", []);
  CSS.make("_a_fqr3fc", []);
  CSS.make("_a_frh37k", []);
  CSS.make("_a_frwu5a", []);
  CSS.make("_a_fr5tyx", []);
