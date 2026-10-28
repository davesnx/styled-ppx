let x = [%css {| color: red; |}];

let row = x => [%css {| & .$(x) { margin: 0; } |}];
