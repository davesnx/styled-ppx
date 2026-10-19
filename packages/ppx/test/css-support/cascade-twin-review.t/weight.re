let is_list = [%css {| &:is(.p, .q) { color: rgb(31, 0, 0); } |}];
let one_class = [%css {| &.x { color: rgb(32, 0, 0); } |}];
let escaped = [%css {| &.md\:flex { color: rgb(33, 0, 0); } |}];
let hover = [%css {| &:hover { color: rgb(34, 0, 0); } |}];
let attr = [%css {| &[data-k="a:b"] { color: rgb(35, 0, 0); } |}];
let focus = [%css {| &:focus { color: rgb(36, 0, 0); } |}];
