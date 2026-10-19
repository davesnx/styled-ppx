let x = [%css {| & .x { color: rgb(21, 0, 0); } |}];
let y = [%css {| & .y { color: rgb(22, 0, 0); } |}];
let child = [%css {| & > div { color: rgb(23, 0, 0); } |}];
let descendant = [%css {| & div { color: rgb(24, 0, 0); } |}];
let legacy = [%css {| &:before { color: rgb(25, 0, 0); } |}];
let modern = [%css {| &::before { color: rgb(26, 0, 0); } |}];
