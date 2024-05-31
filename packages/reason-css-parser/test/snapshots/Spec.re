open Standard;
open Combinator;
open Modifier;
open Rule.Match;
open Parser_helper;

let rec _legacy_gradient = [%value.rec
  "<-webkit-gradient()> | <-legacy-linear-gradient> | <-legacy-repeating-linear-gradient> | <-legacy-radial-gradient> | <-legacy-repeating-radial-gradient>"
]
and _legacy_linear_gradient = [%value.rec
  "-moz-linear-gradient( <-legacy-linear-gradient-arguments> ) | -webkit-linear-gradient( <-legacy-linear-gradient-arguments> ) | -o-linear-gradient( <-legacy-linear-gradient-arguments> )"
]
and property_height = [%value.rec
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | 'max-content' | 'fit-content' | fit-content( <extended-length> | <extended-percentage> )"
]

and property_transition = [%value.rec
  "[ <single-transition> | <single-transition-no-interp> ]# | <interpolation>"
]

and single_transition_no_interp = [%value.rec
  "[ <single-transition-property-no-interp> | 'none' ] || <extended-time-no-interp> || <timing-function-no-interp> || <extended-time-no-interp>"
]
and single_transition = [%value.rec
  "[ [<single-transition-property> | 'none'] <extended-time>] | [ [<single-transition-property> | 'none'] <extended-time> <extended-time>] | [ [<single-transition-property> | 'none'] <extended-time> <timing-function> <extended-time>] "
];

let check_map =
  StringMap.of_seq(
    List.to_seq([
      ("linear-gradient", _legacy_gradient),
      ("radial-gradient", _legacy_linear_gradient),
    ]),
  );
