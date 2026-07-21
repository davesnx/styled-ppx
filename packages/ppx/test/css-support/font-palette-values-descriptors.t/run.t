The css-fonts-4 @font-palette-values descriptors (base-palette,
override-colors) are validated at compile time inside [%styled.global]
(issue #585). font-family inside the block reuses the property grammar,
and the font-palette property accepts the dashed-ident naming the palette.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

A valid @font-palette-values block plus font-palette references compile and
ship through the extraction channel verbatim:

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
    "@font-palette-values --cool{font-family:\"Bixa\";base-palette:1;override-colors:0 #7EB7E4,1 rgb(20 20 20)}"
  ];

An invalid value (a keyword outside 'light' | 'dark' | <integer>) fails
with an error naming the descriptor:

  $ cat > dune << EOF
  > (executable
  >  (name invalid)
  >  (modules invalid)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "invalid.re", line 8, characters 17-22:
  8 |     base-palette: warm;
                       ^^^^^
  Error: Property 'base-palette' has an invalid value: 'warm',
         Expected 'integer', 'dark', or 'light'. Did you mean 'dark'?
