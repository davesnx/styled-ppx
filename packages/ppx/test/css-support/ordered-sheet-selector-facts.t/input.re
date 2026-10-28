let b = [%css {| &:hover { color: red; } &[data-state~='open'] { color: green; } |}];
let c = [%css {| &:hover { color: red; } &[title='a b'] { color: pink; } |}];
let _ = (b, c);
