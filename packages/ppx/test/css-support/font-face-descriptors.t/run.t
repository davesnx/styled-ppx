The css-fonts-5 @font-face metric-override descriptors (ascent-override,
descent-override, line-gap-override, size-adjust) are validated at compile
time inside [%styled.global] (issue #580). Each accepts
'normal' | <percentage> (size-adjust: <percentage> only).

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

A valid @font-face block using all four descriptors compiles and ships
through the extraction channel verbatim:

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (modules input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -4

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    "@font-face{font-family:\"Inter\";src:url(\"/fonts/inter.woff2\") format(\"woff2\");ascent-override:90%;descent-override:normal;line-gap-override:0%;size-adjust:105.5%}"
  ];
  
  module Fonts = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
  
  let _ = Fonts.make;

An invalid value (a length where only 'normal' or a percentage is allowed)
fails with an error naming the descriptor:

  $ cat > dune << EOF
  > (executable
  >  (name invalid)
  >  (modules invalid)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -6
  File "invalid.re", line 9, characters 20-25:
  9 |     ascent-override: 12px;
                          ^^^^^
  Error: Property 'ascent-override' has an invalid value: '12px',
         Expected 'percentage', 'calc()', 'max()', 'min()', or 'normal'.
