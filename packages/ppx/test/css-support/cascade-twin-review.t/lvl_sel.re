let a = [%css {| & > span { color: rgb(1, 0, 0); } |}];
let b = [%css {| @media (min-width: 1px) { & > div { color: rgb(2, 0, 0); } } |}];
let c = [%css {| @media (min-width: 2px) { & > div { color: rgb(3, 0, 0); } } |}];
