let x = [%css {| color: red; |}];

module Row = [%styled.div (~x) => {| & .$(x) { margin: 0; } |}];
