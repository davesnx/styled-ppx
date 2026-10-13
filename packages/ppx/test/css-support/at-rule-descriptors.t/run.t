The @font-palette-values (css-fonts-4), @view-transition
(css-view-transitions-2) and @counter-style (css-counter-styles-3) bodies take
descriptors only. Each descriptor is validated against its spec grammar and
rejected outside the at-rule that owns it. input.re carries a valid block for
each at-rule; every other file carries one mistake, described before the
build that shows its error.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > palette_bad_base.re << 'EOF'
  > module Broken = [%styled.global {|
  >   @font-palette-values --cool {
  >     base-palette: warm;
  >   }
  > |}];
  > EOF

  $ cat > palette_bad_override.re << 'EOF'
  > module Broken = [%styled.global {|
  >   @font-palette-values --cool {
  >     override-colors: 0 #7EB7E4, one red;
  >   }
  > |}];
  > EOF

  $ cat > palette_outside.re << 'EOF'
  > module Broken = [%styled.global {|
  >   @font-face {
  >     font-family: "Bixa";
  >     base-palette: 1;
  >   }
  > |}];
  > EOF

  $ cat > palette_inside.re << 'EOF'
  > module Broken = [%styled.global {|
  >   @font-palette-values --cool {
  >     color: red;
  >   }
  > |}];
  > EOF

  $ cat > vt_bad_navigation.re << 'EOF'
  > module Broken = [%styled.global {|
  >   @view-transition {
  >     navigation: sideways;
  >   }
  > |}];
  > EOF

  $ cat > vt_bad_types.re << 'EOF'
  > module Broken = [%styled.global {|
  >   @view-transition {
  >     types: 12px;
  >   }
  > |}];
  > EOF

  $ cat > vt_inside.re << 'EOF'
  > module Broken = [%styled.global {|
  >   @view-transition {
  >     color: red;
  >   }
  > |}];
  > EOF

  $ cat > vt_foreign.re << 'EOF'
  > module Broken = [%styled.global {|
  >   @view-transition {
  >     navigation: auto;
  >     override-colors: 0 red;
  >   }
  > |}];
  > EOF

  $ cat > counter_bad_system.re << 'EOF'
  > module Broken = [%styled.global {|
  >   @counter-style broken {
  >     system: fixed foo;
  >   }
  > |}];
  > EOF

  $ cat > counter_bad_range.re << 'EOF'
  > module Broken = [%styled.global {|
  >   @counter-style broken {
  >     range: 1 2 3;
  >   }
  > |}];
  > EOF

  $ cat > counter_bad_pad.re << 'EOF'
  > module Broken = [%styled.global {|
  >   @counter-style broken {
  >     pad: 3;
  >   }
  > |}];
  > EOF

  $ cat > counter_inside.re << 'EOF'
  > module Broken = [%styled.global {|
  >   @counter-style broken {
  >     color: red;
  >   }
  > |}];
  > EOF

  $ cat > counter_outside.re << 'EOF'
  > module Broken = [%styled.global {|
  >   .title {
  >     symbols: "a";
  >   }
  > |}];
  > EOF

  $ cat > outside_css.re << 'EOF'
  > let broken = [%css "navigation: auto"];
  > EOF

  $ cat > dune << EOF
  > (executables
  >  (names input outside_css palette_bad_base palette_bad_override palette_outside palette_inside vt_bad_navigation vt_bad_types vt_inside vt_foreign counter_bad_system counter_bad_range counter_bad_pad counter_inside counter_outside)
  >  (libraries styled-ppx.native)
  >  (flags (:standard -w -32))
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build ./input.exe

base-palette takes light, dark or an integer.

  $ dune build ./palette_bad_base.exe
  File "palette_bad_base.re", line 3, characters 18-22:
  3 |     base-palette: warm;
                        ^^^^
  Error: Property 'base-palette' has an invalid value: 'warm',
         Expected 'integer', 'dark', or 'light'. Did you mean 'dark'?
  [1]

override-colors takes integer and color pairs.

  $ dune build ./palette_bad_override.exe
  File "palette_bad_override.re", line 3, characters 21-39:
  3 |     override-colors: 0 #7EB7E4, one red;
                           ^^^^^^^^^^^^^^^^^^
  Error: Property 'override-colors' has an invalid value: '0 #7EB7E4, one
         red',
         Expected a valid value.
  [1]

A @font-palette-values descriptor inside @font-face.

  $ dune build ./palette_outside.exe
  File "palette_outside.re", line 4, characters 4-16:
  4 |     base-palette: 1;
          ^^^^^^^^^^^^
  Error: Descriptor 'base-palette' is only valid inside @font-palette-values
  [1]

An ordinary property inside @font-palette-values.

  $ dune build ./palette_inside.exe
  File "palette_inside.re", line 3, characters 4-9:
  3 |     color: red;
          ^^^^^
  Error: Property 'color' is not a @font-palette-values descriptor
  [1]

navigation takes auto or none.

  $ dune build ./vt_bad_navigation.exe
  File "vt_bad_navigation.re", line 3, characters 16-24:
  3 |     navigation: sideways;
                      ^^^^^^^^
  Error: Property 'navigation' has an invalid value: 'sideways',
         Expected 'auto' or 'none'.
  [1]

types takes none or custom idents.

  $ dune build ./vt_bad_types.exe
  File "vt_bad_types.re", line 3, characters 11-15:
  3 |     types: 12px;
                 ^^^^
  Error: Property 'types' has an invalid value: '12px',
         Expected 'identifier' or 'none'.
  [1]

An ordinary property inside @view-transition.

  $ dune build ./vt_inside.exe
  File "vt_inside.re", line 3, characters 4-9:
  3 |     color: red;
          ^^^^^
  Error: Property 'color' is not a @view-transition descriptor
  [1]

A @font-palette-values descriptor inside @view-transition.

  $ dune build ./vt_foreign.exe
  File "vt_foreign.re", line 4, characters 4-19:
  4 |     override-colors: 0 red;
          ^^^^^^^^^^^^^^^
  Error: Descriptor 'override-colors' is only valid inside @font-palette-values
  [1]

fixed takes an optional integer.

  $ dune build ./counter_bad_system.exe
  File "counter_bad_system.re", line 3, characters 12-21:
  3 |     system: fixed foo;
                  ^^^^^^^^^
  Error: Property 'system' has an invalid value: 'fixed foo', Expected a valid
         value.
  [1]

range takes pairs of integer or infinite.

  $ dune build ./counter_bad_range.exe
  File "counter_bad_range.re", line 3, characters 11-16:
  3 |     range: 1 2 3;
                 ^^^^^
  Error: Property 'range' has an invalid value: '1 2 3', Expected a valid
         value.
  [1]

pad takes an integer and a symbol.

  $ dune build ./counter_bad_pad.exe
  File "counter_bad_pad.re", line 3, characters 9-10:
  3 |     pad: 3;
               ^
  Error: Property 'pad' has an invalid value: '3', Expected a valid value.
  [1]

An ordinary property inside @counter-style.

  $ dune build ./counter_inside.exe
  File "counter_inside.re", line 3, characters 4-9:
  3 |     color: red;
          ^^^^^
  Error: Property 'color' is not a @counter-style descriptor
  [1]

A @counter-style descriptor in a style rule.

  $ dune build ./counter_outside.exe
  File "counter_outside.re", line 3, characters 4-11:
  3 |     symbols: "a";
          ^^^^^^^
  Error: Descriptor 'symbols' is only valid inside @counter-style
  [1]

A descriptor is not a property: [%css] rejects it too.

  $ dune build ./outside_css.exe
  File "outside_css.re", line 1, characters 20-30:
  1 | let broken = [%css "navigation: auto"];
                          ^^^^^^^^^^
  Error: Descriptor 'navigation' is only valid inside @view-transition
  [1]
