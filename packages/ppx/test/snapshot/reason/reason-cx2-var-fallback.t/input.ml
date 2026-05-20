(* `var(--name, fallback)` is standard CSS and must parse in cx2.

   Each declaration round-trips the fallback expression verbatim through
   the rendered CSS — so `var(--theme, blue)`, `var(--gap, 16px)` and the
   nested `var(--theme, var(--fallback, red))` form all reach the
   stylesheet untouched. *)

let plain = [%cx2 {| color: var(--theme); |}]

let withFallback = [%cx2 {| color: var(--theme-color, blue); |}]

let lengthFallback = [%cx2 {| margin: var(--gap, 16px); |}]

let complexFallback = [%cx2 {|
  background: var(--bg, linear-gradient(0deg, red, blue));
|}]

let nested = [%cx2 {| color: var(--theme, var(--fallback, red)); |}]
