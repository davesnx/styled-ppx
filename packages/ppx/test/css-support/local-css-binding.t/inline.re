let inline = () => [%css {| color: blue; |}];
let card = [%css {| & .$(inline) { color: red; } |}];
