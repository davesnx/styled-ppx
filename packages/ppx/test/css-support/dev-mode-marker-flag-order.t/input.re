/* Same input as dev-mode-marker.t: one binding grows a `label:<name>`
   marker under --dev, one stays a plain atom chain without it. */

let layout = [%css {| display: flex; padding: 12px; |}];

let button = [%css {| color: red; |}];

let _ = (layout, button);
