/* Keyword values */
[%cx2 {| flex: auto; |}];
[%cx2 {| flex: initial; |}];
[%cx2 {| flex: none; |}];

/* One value, unitless number: flex-grow
   flex-basis is then equal to 0. */
[%cx2 {| flex: 2; |}];

/* One value, width/height: flex-basis */
[%cx2 {| flex: 10em; |}];
[%cx2 {| flex: 30%; |}];
[%cx2 {| flex: min-content; |}];

/* Two values: flex-grow | flex-basis */
[%cx2 {| flex: 1 30px; |}];

/* Two values: flex-grow | flex-shrink */
[%cx2 {| flex: 2 2; |}];

/* Three values: flex-grow | flex-shrink | flex-basis */
[%cx2 {| flex: 2 2 10%; |}];
[%cx2 {| flex: 2 2 10em; |}];
[%cx2 {| flex: 2 2 min-content; |}];
