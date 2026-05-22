(* `var(--name, fallback)` is standard CSS and must parse in cx2.

   Each declaration round-trips the fallback expression verbatim through
   the rendered CSS — so `var(--theme, blue)`, `var(--gap, 16px)` and the
   nested `var(--theme, var(--fallback, red))` form all reach the
   stylesheet untouched. *)

let plain = [%css {| color: var(--theme); |}]
let withFallback = [%css {| color: var(--theme-color, blue); |}]
let lengthFallback = [%css {| margin: var(--gap, 16px); |}]

let complexFallback =
  [%css {|
  background: var(--bg, linear-gradient(0deg, red, blue));
|}]

let nested = [%css {| color: var(--theme, var(--fallback, red)); |}]
