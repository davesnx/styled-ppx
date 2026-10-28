let marginTopZero = [%css {| margin-top: 0; |}];
let marginAll = [%css {| margin: 10px; |}];
let _ = CSS.merge(marginTopZero, marginAll);
let _ = CSS.merge(marginAll, marginTopZero);

let base = [%css {| padding-top: 0; |}];
let wide = [%css {| @media (min-width: 600px) { padding-top: 8px; } |}];
let _ = CSS.merge(base, wide);
let _ = CSS.merge(wide, base);
