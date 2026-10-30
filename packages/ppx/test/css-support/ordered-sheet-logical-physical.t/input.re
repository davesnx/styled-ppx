let inlineStart = [%css {| margin-inline-start: 8px; |}];
let left = [%css {| margin-left: 4px; |}];
let _ = CSS.merge(left, inlineStart);

let anchor = [%css {| left: 10px; |}];
let panel = [%css {| inset-inline-start: 0; left: 10px; |}];

let size = [%css {| width: 100px; |}];
let _ = (anchor, panel, size);
