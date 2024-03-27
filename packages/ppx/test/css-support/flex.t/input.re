/* Keyword values */
[%css {| flex: auto; |}];
[%css {| flex: initial; |}];
[%css {| flex: none; |}];

/* One value, unitless number: flex-grow
   flex-basis is then equal to 0. */
[%css {| flex: 2; |}];

/* One value, width/height: flex-basis */
[%css {| flex: 10em; |}];
[%css {| flex: 30%; |}];
[%css {| flex: min-content; |}];

/* Two values: flex-grow | flex-basis */
[%css {| flex: 1 30px; |}];

/* Two values: flex-grow | flex-shrink */
[%css {| flex: 2 2; |}];

/* Three values: flex-grow | flex-shrink | flex-basis */
[%css {| flex: 2 2 10%; |}];
[%css {| flex: 2 2 10em; |}];
[%css {| flex: 2 2 min-content; |}];
