open Standard;
open Modifier;
open Rule.Match;
open Driver;

let rec _legacy_gradient = [%value.rec
  "<-webkit-gradient()> | <-legacy-linear-gradient> | <-legacy-repeating-linear-gradient> | <-legacy-radial-gradient> | <-legacy-repeating-radial-gradient>"
]
and _legacy_linear_gradient = [%value.rec
  "-moz-linear-gradient( <-legacy-linear-gradient-arguments> ) | -webkit-linear-gradient( <-legacy-linear-gradient-arguments> ) | -o-linear-gradient( <-legacy-linear-gradient-arguments> )"
]
and property_height = [%value.rec
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | 'max-content' | 'fit-content' | fit-content( <extended-length> | <extended-percentage> )"
];

let check_map =
  StringMap.of_seq(
    List.to_seq([
      ("linear-gradient", _legacy_gradient),
      ("radial-gradient", _legacy_linear_gradient),
    ]),
  );
