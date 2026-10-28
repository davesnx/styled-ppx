let sidebar = [%css {| @media (max-width: 600px) { flex-direction: column; } |}];
let controls = [%css {| display: flex; flex-direction: row; |}];
let controlsMobile = [%css {| @media (max-width: 600px) { flex-direction: column; } |}];
let _ = (sidebar, CSS.merge(controls, controlsMobile));

let narrowGap = [%css {| column-gap: 0; |}];
let wideGap = [%css {| gap: 8px; |}];
let _ = CSS.merge(wideGap, narrowGap);

let a = [%css {| padding: 8px; |}];
let b = [%css {| @media (max-width: 600px) { padding: 4px; } |}];
let _ = CSS.merge(a, b);
let unrelated = [%css {| @media (max-width: 600px) { padding: 4px; } padding: 8px; |}];

let (+++) = CSS.merge;
let base = [%css {| margin: 0; |}];
let _ = base +++ [%css {| margin-top: 4px; |}];
