  $ refmt --parse re --print ml ./input.re > input.ml
  $ as_standalone --impl input.ml -o output.ml
  $ refmt --parse ml --print re --in-place output.ml
  $ cat output.ml
  let rec _legacy_gradient = [%value.rec
    "<-webkit-gradient()> | <-legacy-linear-gradient> | <-legacy-repeating-linear-gradient> | <-legacy-radial-gradient> | <-legacy-repeating-radial-gradient>"
  ]
  and _legacy_linear_gradient = [%value.rec
    "-moz-linear-gradient( <-legacy-linear-gradient-arguments> ) | -webkit-linear-gradient( <-legacy-linear-gradient-arguments> ) | -o-linear-gradient( <-legacy-linear-gradient-arguments> )"
  ]
  and property_height = [%value.rec
    "'auto' | <extended-length> | <extended-percentage> | 'min-content' | 'max-content' | 'fit-content' | fit-content( <extended-length> | <extended-percentage> )"
  ];
