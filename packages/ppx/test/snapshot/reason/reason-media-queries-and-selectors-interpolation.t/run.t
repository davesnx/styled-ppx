  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  File "output.ml", lines 6-8, characters 2-3:
  Error: Interpolation in @media preludes is not supported during static extraction. CSS custom properties (var()) are not valid in media query conditions. Inline the value directly.
  [1]
  $ refmt --parse ml --print re output.ml
  let width = "120px";
  let orientation = "landscape";
  module SelectorWithInterpolation = [%styled.div
    {|
    @media only screen and (min-width: $(width)) {
      color: blue;
    }
    @media (min-width: 700px) and (orientation: $(orientation)) {
      display: none;
    }
  |}
  ];
